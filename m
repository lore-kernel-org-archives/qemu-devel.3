Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4E7CD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWl7-0008G5-6J; Fri, 05 Jun 2026 11:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWkb-0007ml-3b
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:46:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWkZ-0006gO-8A
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EW80NPiZA0afDX2EUeVylLahlZEm44Zw2VwztJ63muo=;
 b=WW5j74UNZboTRer1CgcR51v33zVxlbRKPB2j/pdTH9gUEuGxnPfjI5EXmNhXfqXAVj9iRi
 vlwr7R/n2J5kALHm+Uf2ciG4Ezx/922M2Rzg0mlXOz8OjOiRaHbdfQCV31jtYLM3QdQcr9
 lCcEhlvH9B9p7glR/umQBXDCxGSuXVo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-Cgl9Rw_pPUiBKyL9BL2yEw-1; Fri,
 05 Jun 2026 11:46:21 -0400
X-MC-Unique: Cgl9Rw_pPUiBKyL9BL2yEw-1
X-Mimecast-MFC-AGG-ID: Cgl9Rw_pPUiBKyL9BL2yEw_1780674380
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 912B0195608B
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:46:20 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B2661800480; Fri,  5 Jun 2026 15:46:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 05 Jun 2026 19:44:41 +0400
Subject: [GIT PULL 21/23] target/riscv: use hash table as set for user_options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-qom-tests-v1-21-3f184f382c2b@redhat.com>
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=4808;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=upzIszpg9Sqx2Er0dwvmJZ/wdllyA5oABsmXU9+/2ek=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7VC49Xtq7xfGs7Q6v9KVruKr1UbQEjfQAd2
 hU/PIGoRpqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1QAKCRDa6OEJdZac
 5SmpD/48QBtLwmxLgn78F/GfN6jSReRHQ8NfxCA5g7sWTw8smKk/Zrv+Kdjqk8nLz3I/Q35iuX1
 DIWIE0dPAhM6dM+dMoegv4NxO6pO7hWV9q6qel4KrULr1UaaIZlsM3omtc8NBbxiOltIwPobJRm
 2iD6jPwr8gLYdtgZBBxwyq7vUoHVklu92PJga9wB0NoxVwe8WXQbVDsiXmK1rDvoMshF/aQ/xVu
 r/IYR0lyFaz+2m2wm2jU5s24sCcqQk8jfeL8KN+YZfLEvx09Jqi1vutt50U4Je8MZkReXWjC+/n
 DM4tS3gz6Ibj1qzL5VquBWws1yzs5tusfck3eopbIKvPvS34aR2DSoAaRA3iMe6cD1ugU2QeX18
 9vl5+sItPU8vi7iW/O/LCN92oZrVVd9N9HkIZ5wivueQXL1JCSNMlFZdfI7VgjvJ2URf1uq0MNK
 Tf2wtkWwiuVQAp5BLBcArZ8FGMe8LA6pLDmCDzZ83kmXEwC6NjuM6escvPfBZEDiMB0l9+TZ2UE
 cLgOsbx4V0vQIqEjNgze4udP6juZ62YHGCPapdkzpM4kqSzX6oAxIUo5s/z92d33+BvqaKKWNhc
 6uGfDtTrW4LIHxIaW4NfXtVk8tWOKRSZeLwXdcgEryR//q6kQMF2DftXnDBfMYjJdIDw/L7HZRR
 sRAJZBm7bnBFgxA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/riscv/cpu.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 57000983edd..5903df99548 100644
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
@@ -1290,7 +1288,7 @@ static void prop_pmu_num_set(Object *obj, Visitor *v, const char *name,
 
     warn_report("\"pmu-num\" property is deprecated; use \"pmu-mask\"");
     cpu->cfg.pmu_mask = pmu_mask;
-    cpu_option_add_user_setting(cpu, "pmu-mask", pmu_mask);
+    cpu_option_add_user_setting(cpu, "pmu-mask");
 }
 
 static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
@@ -1332,7 +1330,7 @@ static void prop_pmu_mask_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.pmu_mask = value;
 }
 
@@ -1364,7 +1362,7 @@ static void prop_mmu_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.mmu = value;
 }
 
@@ -1396,7 +1394,7 @@ static void prop_pmp_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.pmp = value;
 }
 
@@ -1436,7 +1434,7 @@ static void prop_num_pmp_regions_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.pmp_regions = value;
 }
 
@@ -1474,7 +1472,7 @@ static void prop_pmp_granularity_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.pmp_granularity = value;
 }
 
@@ -1547,7 +1545,7 @@ static void prop_priv_spec_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, priv_version);
+    cpu_option_add_user_setting(cpu, name);
     cpu->env.priv_ver = priv_version;
 }
 
@@ -1581,7 +1579,7 @@ static void prop_vext_spec_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, VEXT_VERSION_1_00_0);
+    cpu_option_add_user_setting(cpu, name);
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
@@ -1624,7 +1622,7 @@ static void prop_vlen_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.vlenb = value >> 3;
 }
 
@@ -1665,7 +1663,7 @@ static void prop_elen_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.elen = value;
 }
 
@@ -1701,7 +1699,7 @@ static void prop_cbom_blksize_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.cbom_blocksize = value;
 }
 
@@ -1737,7 +1735,7 @@ static void prop_cbop_blksize_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.cbop_blocksize = value;
 }
 
@@ -1773,7 +1771,7 @@ static void prop_cboz_blksize_set(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_option_add_user_setting(cpu, name, value);
+    cpu_option_add_user_setting(cpu, name);
     cpu->cfg.cboz_blocksize = value;
 }
 

-- 
2.54.0


