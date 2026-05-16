Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51363CD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9xn-0001y4-Co; Sat, 16 May 2026 04:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9xh-0001sC-12
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9xf-0007xM-5c
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4m7pmp7qnl/dyUVLbYMaT8ZipvvTkt7+0WBm0mtE5E=;
 b=EFYU8+LT8bX0JHsUMEbQr0tC3D2o4DQS1c9jm6zPY4gCi1MZvQ840MS9fO97/N8btBZr2v
 fFz+X2/mddzNU2jbAs8LDgIzgpJLgDCK04ERwnQdLObJ0rXcIR9hzVLvZI9RAGu+OWxFVx
 S7C6c1l6W97n9ySHrgl+rbJmQ6yLRJg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-boY4hZj2P1ebmvQ1A3Ffnw-1; Sat,
 16 May 2026 04:01:24 -0400
X-MC-Unique: boY4hZj2P1ebmvQ1A3Ffnw-1
X-Mimecast-MFC-AGG-ID: boY4hZj2P1ebmvQ1A3Ffnw_1778918483
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D216919560AE
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 08:01:23 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3C4218001E8; Sat, 16 May 2026 08:01:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:21 +0400
Subject: [PATCH v3 22/24] target/riscv: use hash table as set for user_options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-22-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4750;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rzQyp5DQ5nvhaO0TBZoOhaU+VtZA1JAU78E8mJirGw4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPQN4u0LHMf1Wf/VLxNx6N+CMJUkPRbupF8h
 SdoiwoFWbqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggj0AAKCRDa6OEJdZac
 5b4rEACnA0l3Gh37hZD5yXoK1+ey7KUCJal5DFpC1nVWjI2OY23VaydfCZb2by0SVpGMkflh8QX
 IZqYoFOMVWScxZhdt5Z4bXsFdxqd4jj2ViBZBFxBT0opgGGGSG7t4WBYD3R9fkS1YfnuI5re3gY
 8zVGEtu1ABL65bepBmckyxBgjdTIzgHO7caTf2A91wpai+WVUldj9iW4GHwWdlZaTjryb52Yb1u
 EVq3pg3cehKU5lG4Y+uqzbMssW1oYNCe5pTH8oOEfDY0WUeYo/jAVEwfd5TAM0vahHzTmKD/gdz
 rqFF2rGnUhdm3XV2JnKpf7xRMo9Y65DcTX5d0jOmaZSxC3UtVgCz5UPTHXwsrSBdN5CyZrRKLBu
 fDYXXGgMO6rgUr+IbAsBVU04VK1d9xADpknXcjgIkqHeFJdI7BupOjMSXj0y0hHDMXKvWJ2lMzT
 W64wZR4Uhtmil+cOow5SHpbG16CRURck3uJs26QDxPLzgtLvCYyWdsnjLxzq6GUGU2KJXU3E/zh
 hQ+AOGJMt8tfOdnl1c9ADRNL0b673O8UG73vmkvXmB0VVaol/nqcG92CLtsLKMwwNjEr7eLpJTG
 5snDH+0H3U8br9FfJAUQVS3TDngLFKvJMRmOeNGKOgH3QODM/QW3rD/Xv6aXsi7ByCsXmMh/Puo
 2kpXlYEpDdTtTxA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index bbdc9d8f5de..6adba597969 100644
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


