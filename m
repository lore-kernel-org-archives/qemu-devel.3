Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05DCFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJreN-0001kt-P9; Mon, 04 May 2026 07:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJre6-0001Ri-Pj
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJre2-0001Uh-Iq
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42hjY28IGCdulA5mo/QwK+Hh01CMs8vQW8q3n61V0m4=;
 b=FZYihoy/4Yp6deNS4UGUfkGaJOUJWtjMeVocutNPjAe7vgUid3OJ1/sKJYXs7Kv76KTujL
 MDQB+ao3UqfEFxy6uScIOCXiL2bnKanRmaey5sYHgbkTxCWyinvZa9ycJHuxvGYwYayoal
 f3aIxPGhjYlTjAEZ+HBrvPrqXZnWHiY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-xqMvUuXYN42jy80Wv5BOOw-1; Mon,
 04 May 2026 07:39:24 -0400
X-MC-Unique: xqMvUuXYN42jy80Wv5BOOw-1
X-Mimecast-MFC-AGG-ID: xqMvUuXYN42jy80Wv5BOOw_1777894763
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC6FF1956089
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:39:23 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4FD4319560B1; Mon,  4 May 2026 11:39:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:31 +0400
Subject: [PATCH v2 43/46] target/riscv: use hash table as set for user_options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-43-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4750;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=54UipZhX3LhBC9douJgP5Ilofu4C5/F+Xe5+6aIzMYI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRuxC2J2JbOk0qhObiNeQTTAwuC0UuX9oUFc
 etWTpDay7OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbgAKCRDa6OEJdZac
 5W8XD/9DTzLInq4OCKY5xexqCOK4vp6zvv0yfpoUyimFh18JfQF4B9B2xjMOkggs3jWxuGYsHyl
 iQNL5liQ5qQV93AWmKrYLiWMCNBSNozaUQuLFKAYuhxrIljNPVf9G98/UwqX8jWOxxTChFpVhel
 vU7OL8izw5F75bM/SOEElDM3SmyztH7YVkG2NQFlOOef+8VU6w3fcO0zfB7XE4Q9rHP5cz1tm4j
 8onYn+h45mJ6k+Y00OBeeh4fgPDZiuDnoCON/dr2+5RlvREkckwm9mSKjcI6WPz143nxA8udo/t
 b9azjL/WfUTK7keQMdaEs+1NwUzwXMhGXWW6pBOixWcmu5inaYWtfPcSNygRyl8PWtlWmD7Cj3e
 6zsw8OK48vXP2JgN/9srO11oB963oS1TVZNWXxf3hjxyApEgl+2KQRO4kir1V7/Ts+ABHCZBGQ7
 EfZ91c9RYf+fhk4NbPUIt8J5nzIhvKF7j2lpD8N9odyOUNGwX0y25tAdHbCbgEEA3nl1nzzj+sE
 St/mVI6rwbrywZJBdidAsIva/LkOeQIWPsq22J/WjSYjb56AMvrJzLvwRzFYobw6/5LbhKH46nB
 8smdd+Uyb4A+FU5C7eKVLQQwNt2COG8SngoKZy0UVrcH7IL+BVJUlCBkI27ddsUZXkbBXz88kfz
 sW+ZbIkOnzbC0Wg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The values stored in user_options are never retrieved, only key
presence is checked. Use g_hash_table_add() instead of
g_hash_table_insert() and drop the unused value parameter.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/riscv/cpu.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index be9a3ac13e7..52b89e274f4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -60,11 +60,9 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu)
     return riscv_cpu_mxl(&cpu->env) == MXL_RV32;
 }
 
-static void cpu_option_add_user_setting(RISCVCPU *cpu, const char *optname,
-                                        uint32_t value)
+static void cpu_option_add_user_setting(RISCVCPU *cpu, const char *optname)
 {
-    g_hash_table_insert(cpu->user_options, (gpointer)optname,
-                        GUINT_TO_POINTER(value));
+    g_hash_table_add(cpu->user_options, (gpointer)optname);
 }
 
 bool riscv_cpu_option_set(RISCVCPU *cpu, const char *optname)
@@ -1452,7 +1450,7 @@ static void prop_pmu_num_set(Object *obj, Visitor *v, const char *name,
 
     warn_report("\"pmu-num\" property is deprecated; use \"pmu-mask\"");
     cpu->cfg.pmu_mask = pmu_mask;
-    cpu_option_add_user_setting(cpu, "pmu-mask", pmu_mask);
+    cpu_option_add_user_setting(cpu, "pmu-mask");
 }
 
 static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
@@ -1494,7 +1492,7 @@ static void prop_pmu_mask_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.pmu_mask = value;
 }
 
@@ -1526,7 +1524,7 @@ static void prop_mmu_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.mmu = value;
 }
 
@@ -1558,7 +1556,7 @@ static void prop_pmp_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.pmp = value;
 }
 
@@ -1598,7 +1596,7 @@ static void prop_num_pmp_regions_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.pmp_regions = value;
 }
 
@@ -1636,7 +1634,7 @@ static void prop_pmp_granularity_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.pmp_granularity = value;
 }
 
@@ -1709,7 +1707,7 @@ static void prop_priv_spec_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, priv_version);
+    cpu_option_add_user_setting(cpu, name);
     cpu->env.priv_ver = priv_version;
 }
 
@@ -1743,7 +1741,7 @@ static void prop_vext_spec_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, VEXT_VERSION_1_00_0);
+    cpu_option_add_user_setting(cpu, name);
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
@@ -1786,7 +1784,7 @@ static void prop_vlen_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.vlenb = value >> 3;
 }
 
@@ -1827,7 +1825,7 @@ static void prop_elen_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.elen = value;
 }
 
@@ -1863,7 +1861,7 @@ static void prop_cbom_blksize_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.cbom_blocksize = value;
 }
 
@@ -1899,7 +1897,7 @@ static void prop_cbop_blksize_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.cbop_blocksize = value;
 }
 
@@ -1935,7 +1933,7 @@ static void prop_cboz_blksize_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.cboz_blocksize = value;
 }
 

-- 
2.54.0


