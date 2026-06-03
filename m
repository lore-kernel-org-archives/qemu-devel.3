Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEB7CD6E71
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsZf-00083I-He; Wed, 03 Jun 2026 16:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZP-0007x5-F1
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZL-0004C0-OZ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:09 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653HA3mf2651282
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4vJKa5FfzO6
 wDkm27O18xdmld0GrhQ8bYsHnUHwAZVQ=; b=WeUefxmFIjgH4EBsxCsbQUIpUuG
 KMM5z0AYkg5/87DyqXv8Hl9OtUjJEMJ4REdlJ8UPQLxSb4AxOvgPWKnMcr6/jBtn
 UocEghCXefI2Qq1ZpJ3cVRVvpDeOwfn4rY+NfypSfFfejPI13TY0fF0RabGtPG7A
 eV9gUmXoY03wtPep/24mA59pRTEsPYpZGttzY2c9vKRjIWLWyCeqF8AtV6s0ryQC
 YUJVojQJMUoI3IbqWy9x7iDQjCvhK010p+lBzLRka8kUZjlSpWIaBhpsvtsD5XNN
 gWYJdd4DUQUW4kCZZ23yqJtw01m0bSdJTzYfBALPNPKD8RlqAutVGFcSQFw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejre9gvfn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:05 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3074d4102a9so756467eec.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519924; x=1781124724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4vJKa5FfzO6wDkm27O18xdmld0GrhQ8bYsHnUHwAZVQ=;
 b=Qei4fCt1MmR8f1gP74UOVX1Ah+SuNXnlkmNfixU7KjE9BqZBJhwiq+VutCfrPWK2PC
 cBXq/wLkjafvFQZAweZe+Z1vYZ7hD6D7JgVUHcHMAr+U0eua4AP/aWw+xEsML7gNi9ZT
 e34AkQfgP1RpFzy2GDzcCmkfIzS4Y60pC6+6cvrDdYyPpWJs2j9Q4/NQBt0cis86jiNp
 Sl0Zop2/07kDxNnDg0Dwh7tSWKpTTWklFDmb6sINV6UJcO/BuEHKLzB1GeaEB1VzPa9v
 AlAMkLJVe4OpxISq6vqamy2Ksa11TVlUj0b2uwSj0BiKk4ixzX56APcqMtm99/ynhA6i
 XIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519924; x=1781124724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4vJKa5FfzO6wDkm27O18xdmld0GrhQ8bYsHnUHwAZVQ=;
 b=BqN2RantS7LhcutBrfbteKCCme5SGFsiWnY43WgtI2F+UecXpzxLgXzQ2yojFBQ29C
 3wiCkacIB+MBtiT6vwC8ZaJASfLnNSS7F2ajmbG0hNOQx+KkmE7ISxVjVVTVvCk4QEnC
 RKaOTASQ7feNOr6qhtxpxSG7Fp6zX1UsU4Vw20tlDKOjLnpiH6oFgoc4dJHhkQ4SBeAC
 RhTgf1Ha6jL0IEOUhPnTinZxRHLjnPZiL5M11wyTox6WyRBgOTD4Ce84vFdxyZ/O7ruh
 8IJcll3qAGJ8TesONb7eDTOytwPJpE9N5li1MZav/6iqDGmrzpimuDgFG+CVhE78o+fG
 I1Tg==
X-Gm-Message-State: AOJu0Yza39LurVO/wTRU1PBZGa2m1uFMhnU6GQb6kVdcl/OiAvqJuROo
 JLzOuyoVYMyaTB90IBMvQVK15YJmyszZjOd12O2RO4JeHLX7Erqr78+Ny4glbCuWdMg9Mq53rwe
 y66uSJ7NQe9a5HXn7L1kfyDSPSkmmt2Ljk+oHHCpWWpSbhm1evB2Ofl1MoP2C6REwNvHx
X-Gm-Gg: Acq92OGnWbFEKfRLFOXFQygtRXf/NWnIxdnM54ssFOfIr+sawZ8x58tk1dwINV2LtG4
 YYsF4cf3pCHgbf2HZ5sSiT3LjOs165eibr5+mw2rZGGgRQszCi3ubGMu6MlDWHWUMG4Q1s8ied8
 mH98sC/JjGah0ziSnf9EY751u04xxt++wJNYvKOvFVC6zgXlCZuFwLXsCl0iAeGOUuGeo5PzHJO
 Nb831kj1lW0vONmmxUO9Js1vlqgbAkB0dlAy+5/j9+6C197kWy1dN2wpd2UztgY/AxJA4ND51TN
 u8rFa4XM7W9FCdECKXjpBevdAdQaZo039rGB94AyHvlzxyCU7MPYZZ0IKaMSguWW1kOKQd3Phs0
 DqJnFUT7R4odeNU2GbPJ+hWgujCkWR3IcbXpR9ilb5ssQQXLyKG/A/W6W8OEmgmuKIzVll98AGZ
 kCtvrPTh3gwkqV6otW
X-Received: by 2002:a05:7300:a498:b0:2f5:5dd3:1fd8 with SMTP id
 5a478bee46e88-3074fa7ddcdmr2878859eec.8.1780519923978; 
 Wed, 03 Jun 2026 13:52:03 -0700 (PDT)
X-Received: by 2002:a05:7300:a498:b0:2f5:5dd3:1fd8 with SMTP id
 5a478bee46e88-3074fa7ddcdmr2878837eec.8.1780519923334; 
 Wed, 03 Jun 2026 13:52:03 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 02/25] plugins: add userdata for qemu_plugin_{uninstall, reset}
Date: Wed,  3 Jun 2026 13:51:29 -0700
Message-ID: <20260603205152.1440291-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3BKg9wWvKB8bAQREkolwaqVbK3-iVaa_
X-Proofpoint-GUID: 3BKg9wWvKB8bAQREkolwaqVbK3-iVaa_
X-Authority-Analysis: v=2.4 cv=KoF9H2WN c=1 sm=1 tr=0 ts=6a2093f5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=_u34yJfUH-Co13bc16MA:9 a=O8hF6Hzn-FEA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfXzAOuHXU8NUPN
 ryOzV51esEPMJhu5YoDOPpKXO3AOW02M1lg1VYr8xQLI8PtcxYDuxC5kKHJOvD2dnhe4POPNYgK
 yLnR/aVHL0kbSTiLZCZYpv8OE3bOD0oL9xwhYB+mPIeX8Ol8AjsmRJtVx2KM6JALpUAtOVW8FIo
 gw8OtR1kcxKYS6KDlBzlJXPg0XLvj8nssK4yRb3tSHtxG+SKZJsamlLEsERF3iFH6zhF89sWjLp
 HIjVWkqPJbMJZNlhVYvzqZgeq+lL/j54+WFfaoQvQzZUfkv2bzxWYPgEXenFMXkzBCT3Q2POET/
 vDRW3B+CNO+EVAffKzEKeEMZyzlwmrhmQwXZcabH0M55VE4PTesFwRFjRwKSMa/dcParf2V7F5l
 +VE9Er8E9Wggf9KGcl5+KUKss7j9fZQq7arRrA1F9yOImP/jpR0EjvD8u3if2nKXKipkj8FzzYQ
 N84qu/5mS3UUIPjOvSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030203
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We do both at the same time because they internally use the same
implementation.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/lockstep.c    | 10 +++++-----
 include/plugins/qemu-plugin.h |  8 ++++++--
 plugins/api.c                 | 10 ++++++----
 plugins/loader.c              | 13 ++++++++-----
 plugins/plugin.h              |  3 ++-
 tests/tcg/plugins/reset.c     |  8 ++++----
 6 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 62981d4e098..36b003ead2d 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -77,7 +77,7 @@ static char *path_to_unlink;
 
 static bool verbose;
 
-static void plugin_cleanup(qemu_plugin_id_t id)
+static void plugin_cleanup(qemu_plugin_id_t id, void *userdata)
 {
     /* Free our block data */
     g_slist_free_full(blocks, &g_free);
@@ -98,7 +98,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     g_string_append_printf(out, "Executed ~%ld instructions\n", insn_count);
     qemu_plugin_outs(out->str);
 
-    plugin_cleanup(id);
+    plugin_cleanup(id, NULL);
 }
 
 /*
@@ -189,7 +189,7 @@ static void report_divergance(ExecState *us, ExecState *them)
         }
         qemu_plugin_outs(out->str);
         qemu_plugin_outs("giving up\n");
-        qemu_plugin_uninstall(our_id, plugin_cleanup);
+        qemu_plugin_uninstall(our_id, plugin_cleanup, NULL);
     }
 }
 
@@ -212,7 +212,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
         qemu_plugin_outs(bytes < 0 ?
                          "problem writing to socket" :
                          "wrote less than expected to socket");
-        qemu_plugin_uninstall(our_id, plugin_cleanup);
+        qemu_plugin_uninstall(our_id, plugin_cleanup, NULL);
         return;
     }
 
@@ -225,7 +225,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
         qemu_plugin_outs(bytes < 0 ?
                          "problem reading from socket" :
                          "read less than expected");
-        qemu_plugin_uninstall(our_id, plugin_cleanup);
+        qemu_plugin_uninstall(our_id, plugin_cleanup, NULL);
         return;
     }
 
diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 435a14f5a00..11213c2ca3f 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -221,6 +221,7 @@ typedef void (*qemu_plugin_vcpu_discon_cb_t)(qemu_plugin_id_t id,
  * qemu_plugin_uninstall() - Uninstall a plugin
  * @id: this plugin's opaque ID
  * @cb: callback to be called once the plugin has been removed
+ * @userdata: any plugin data to pass to the @cb
  *
  * Do NOT assume that the plugin has been uninstalled once this function
  * returns. Plugins are uninstalled asynchronously, and therefore the given
@@ -229,12 +230,14 @@ typedef void (*qemu_plugin_vcpu_discon_cb_t)(qemu_plugin_id_t id,
  * Note: Calling this function from qemu_plugin_install() is a bug.
  */
 QEMU_PLUGIN_API
-void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
+void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
+                           void *userdata);
 
 /**
  * qemu_plugin_reset() - Reset a plugin
  * @id: this plugin's opaque ID
  * @cb: callback to be called once the plugin has been reset
+ * @userdata: any plugin data to pass to the @cb
  *
  * Unregisters all callbacks for the plugin given by @id.
  *
@@ -243,7 +246,8 @@ void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
  * callbacks until @cb is called.
  */
 QEMU_PLUGIN_API
-void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
+void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
+                       void *userdata);
 
 /**
  * qemu_plugin_register_vcpu_init_cb() - register a vCPU initialization callback
diff --git a/plugins/api.c b/plugins/api.c
index 2d5fe9327f7..91c9a24a6b2 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -51,14 +51,16 @@
 
 /* Uninstall and Reset handlers */
 
-void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
+void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
+                           void *userdata)
 {
-    plugin_reset_uninstall(id, cb, false);
+    plugin_reset_uninstall(id, cb, userdata, false);
 }
 
-void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
+void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_udata_cb_t cb,
+                       void *userdata)
 {
-    plugin_reset_uninstall(id, cb, true);
+    plugin_reset_uninstall(id, cb, userdata, true);
 }
 
 /*
diff --git a/plugins/loader.c b/plugins/loader.c
index 0dbe7bea263..0d587c344c4 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -253,7 +253,7 @@ static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info, E
          * call a full uninstall if the plugin did not yet call it.
          */
         if (!ctx->uninstalling) {
-            plugin_reset_uninstall(ctx->id, NULL, false);
+            plugin_reset_uninstall(ctx->id, NULL, NULL, false);
         }
     }
 
@@ -314,7 +314,8 @@ int qemu_plugin_load_list(QemuPluginList *head, Error **errp)
 
 struct qemu_plugin_reset_data {
     struct qemu_plugin_ctx *ctx;
-    qemu_plugin_simple_cb_t cb;
+    qemu_plugin_udata_cb_t cb;
+    void *userdata;
     bool reset;
 };
 
@@ -338,7 +339,7 @@ static void plugin_reset_destroy__locked(struct qemu_plugin_reset_data *data)
     if (data->reset) {
         g_assert(ctx->resetting);
         if (data->cb) {
-            data->cb(ctx->id);
+            data->cb(ctx->id, data->userdata);
         }
         ctx->resetting = false;
         g_free(data);
@@ -357,7 +358,7 @@ static void plugin_reset_destroy__locked(struct qemu_plugin_reset_data *data)
     g_assert(success);
     QTAILQ_REMOVE(&plugin.ctxs, ctx, entry);
     if (data->cb) {
-        data->cb(ctx->id);
+        data->cb(ctx->id, data->userdata);
     }
     if (!g_module_close(ctx->handle)) {
         warn_report("%s: %s", __func__, g_module_error());
@@ -383,7 +384,8 @@ static void plugin_flush_destroy(CPUState *cpu, run_on_cpu_data arg)
 }
 
 void plugin_reset_uninstall(qemu_plugin_id_t id,
-                            qemu_plugin_simple_cb_t cb,
+                            qemu_plugin_udata_cb_t cb,
+                            void *userdata,
                             bool reset)
 {
     struct qemu_plugin_reset_data *data;
@@ -401,6 +403,7 @@ void plugin_reset_uninstall(qemu_plugin_id_t id,
     data = g_new(struct qemu_plugin_reset_data, 1);
     data->ctx = ctx;
     data->cb = cb;
+    data->userdata = userdata;
     data->reset = reset;
     /*
      * Only flush the code cache if the vCPUs have been created. If so,
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 9179da43851..c901016b8c1 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -76,7 +76,8 @@ void plugin_register_inline_op_on_entry(GArray **arr,
                                         uint64_t imm);
 
 void plugin_reset_uninstall(qemu_plugin_id_t id,
-                            qemu_plugin_simple_cb_t cb,
+                            qemu_plugin_udata_cb_t cb,
+                            void *userdata,
                             bool reset);
 
 void plugin_register_cb(qemu_plugin_id_t id, enum qemu_plugin_event ev,
diff --git a/tests/tcg/plugins/reset.c b/tests/tcg/plugins/reset.c
index 1be8be2a4b2..6ea675b8095 100644
--- a/tests/tcg/plugins/reset.c
+++ b/tests/tcg/plugins/reset.c
@@ -14,7 +14,7 @@ static qemu_plugin_id_t plugin_id;
 static bool was_reset;
 static bool was_uninstalled;
 
-static void after_uninstall(qemu_plugin_id_t id)
+static void after_uninstall(qemu_plugin_id_t id, void *userdata)
 {
     g_assert(was_reset && !was_uninstalled);
     qemu_plugin_outs("uninstall done\n");
@@ -24,7 +24,7 @@ static void after_uninstall(qemu_plugin_id_t id)
 static void tb_exec_after_reset(unsigned int vcpu_index, void *userdata)
 {
     g_assert(was_reset && !was_uninstalled);
-    qemu_plugin_uninstall(plugin_id, after_uninstall);
+    qemu_plugin_uninstall(plugin_id, after_uninstall, NULL);
 }
 
 static void tb_trans_after_reset(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -34,7 +34,7 @@ static void tb_trans_after_reset(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
                                          QEMU_PLUGIN_CB_NO_REGS, NULL);
 }
 
-static void after_reset(qemu_plugin_id_t id)
+static void after_reset(qemu_plugin_id_t id, void *userdata)
 {
     g_assert(!was_reset && !was_uninstalled);
     qemu_plugin_outs("reset done\n");
@@ -45,7 +45,7 @@ static void after_reset(qemu_plugin_id_t id)
 static void tb_exec_before_reset(unsigned int vcpu_index, void *userdata)
 {
     g_assert(!was_reset && !was_uninstalled);
-    qemu_plugin_reset(plugin_id, after_reset);
+    qemu_plugin_reset(plugin_id, after_reset, NULL);
 }
 
 static void tb_trans_before_reset(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
-- 
2.43.0


