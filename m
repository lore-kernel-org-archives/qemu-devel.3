Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F9BCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYkH-0004MV-2E; Tue, 16 Jun 2026 14:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkF-0004Ln-88
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:42:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkC-0000OJ-KY
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:42:42 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOYSr331236
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7UgS+/XFU9N
 LfD3wp/+A3Y/XXNy5qjeZNzVPzI7CWk8=; b=fzW/0gfKVUfkrDDA+9J+y8LHXtm
 Af9h5j6dDSC8GWwEQNlieixtsLweZbsdRg/uA7AQJJ6xSFvx+idLX7H3qQ2HRE3Q
 rUPxjR2fElBlXfp4xiI7XCWSIOA/PChn0lHr/y0ogGhWP0sShlGC17syQMpjb1cH
 sBMVvJ5BLmV0htRacGfJWCuwvDyIXI3PA1c56khPtfR9+IIcOiY1tShBbyPS7v8d
 u1M8l7KvJ3nJai8brLvEPsdkRevTcJcbgPQ5/DtKi8vZtrf1UJB83llWJTyYA9RU
 nNOnWGTw0swEDhprafp8NYjsY/XcKT0XLU+FwLXUFgnwERhkGP/nKydFzsw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09gbkrf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:39 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84238e83851so3200218b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635358; x=1782240158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7UgS+/XFU9NLfD3wp/+A3Y/XXNy5qjeZNzVPzI7CWk8=;
 b=RYmi9O1Fb7Kah2gKn5RV8d6iixqRQROb6X4ZikOV1FMD53wzhNk+KSGU+xYL0vjwKI
 dOw5TwvsxKGvYIWjzEtTM2GRs6bL/lF23X9V+b2GnqSNcaxiksH/v89iI9mbWI6gJxhW
 sLAbom8woSTLAN9DUuYaRvtCdPOeODe57wc4cXUWyUAdpnmsdbt603Y07wh9zmB1RQM8
 8im5xjbLOZ+0fxATSRUARwh+ULJvyUykeMSWBSlENRiVyevJmW3dhFHylG4WLG1LO1C1
 tJ4paI0TD/4WEtWcFSixDbqvtF6o5tnV49XZVmpscb/UAKtiaTd9gFARRk+P8rX8Po5f
 yTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635358; x=1782240158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7UgS+/XFU9NLfD3wp/+A3Y/XXNy5qjeZNzVPzI7CWk8=;
 b=dcoKfIoXbx3/QhOUWuxSYp2rUBt5uuECUOoWLuzrfb3KJgwA/G3yC8TC3Ii2eUXMLn
 WvkOGWg42prw9FBPfXMhDnSdGHZa5fNFzL00Vv8sG7jj5aLUmy0Qld8+wVuvcD27ro9w
 pGl+7UVBq4FX+a3xd+nXHwP9pCUcsmJic+Vof/UxaOt07MEpuQ9V/ISbidb6O51Kqfo3
 tUyCsBrKRBwp+R2L7v1pDebRdaK08EpQKowUitoh5xASMOTcJv2Pw+Th3lGcUOqQEfr4
 Td3pIyghvDA1f+tMNtC2WqkubYC+9KUNn3yh+q228lP6uS7m2M+3ZZbXPvD1PfY7b1CS
 +bIg==
X-Gm-Message-State: AOJu0Yz5onqApu/dPF8EZ9jyV/mTe0IJxXlM5xAYtQlNf/Sl/Cu/Xfkm
 bqja4pIr4iNQm/97Xp5GnXm1PvLTrRYdWuVye0ZJ8Q7QyhTKEGgu7c5ODCIyHlQLVxkV2QEUs8X
 cuyPo2GBR248sSo9nSjm4fymmMsNK8zzeGmIZhNZk1xdDRBHuQ/75tHCMs1xCzKDvvY2q
X-Gm-Gg: Acq92OFPD8D5/UclgwNo/7BgfF9UOjsL4ZfAv7XOt7/dpK4vsf2w0EAuoiT8cxZRDzG
 EKvHR1euD5olUxDi+wvIJIZkTZMZ9EbkL7ekSGBAAxbUD8DfbkmYybdMJc2bVDQY2bwk6m2yxwm
 e3ZTIFw9ZPeqBiEJUdDhBS0tJzceQ4uWKaDniY/ackENaoTo/JGWNdd+16lZbcA3l1/gykmV7Z/
 GSx+H/PfyICMY8e695ngNJpKNzGmXYY74OIrZ792L5JGF4MNLpvLPpFsfesrA5UEpuo+zbtyQZm
 CMrcEc+xWbnGNecLPVeZi0V1Lm15nFWXzq81lZ/8AhQOoX4AaDd8O0DL+rN2SU4Na6wf7pLrOdS
 QlAJTqbpTrT4NsT7OykSDWd/Qz5h5U7aWp08Dy/xFAbJ5ElApyAVYLjAhVbEPtayJbr+B/bACDN
 UjZCuW5ro=
X-Received: by 2002:a05:6a00:760a:b0:845:259f:8925 with SMTP id
 d2e1a72fcca58-845259f8c33mr74450b3a.6.1781635358182; 
 Tue, 16 Jun 2026 11:42:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:760a:b0:845:259f:8925 with SMTP id
 d2e1a72fcca58-845259f8c33mr74427b3a.6.1781635357682; 
 Tue, 16 Jun 2026 11:42:37 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 02/26] plugins: add userdata for qemu_plugin_{uninstall, reset}
Date: Tue, 16 Jun 2026 11:42:06 -0700
Message-ID: <20260616184230.303038-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX0GiqFuQKoVpp
 NB3GSAR2adYd4LzJUAkMa7C8TFBwR1sQ2aoQZNQ7zi7qn2v/uTK9PXIgRqj3QiwzW5wbJYNJBD/
 43wrMDqn2vi81uYVbq5mJCC+pYhA7IRAAfqOB09c2bG7BnULBUjdqwYKU5rFHMClgfar0zznrkp
 205YWH+NhfJj2fin0WI4eS29nVGB5cEgeX7QzgsTnKJRxR5gAO5TxdSTVCpmPl5/MKWMT2fgBqX
 MoxjcMP2Zk/fSgNQmN8KBpUgINhCgUmIpOSit/cVwQ7arVbAr8s22YzAukJjNG8Z7PGv6YIBo+B
 k31D9TlFghULMpFuWffWyVLUEpc/NSMuXb9flyxoRAhuByEgM4gw6xNUalw6I+RaGUhUpBk2aW8
 xyHLEUGxTtL7/kdOjBzF9rRnIgSvNrH8uy534Eama5ycoflmRStiSZ4AxG+iYvpqVyTUp88+V2H
 dJmxmo2KKNqKp3uYhGQ==
X-Proofpoint-ORIG-GUID: 5KtqrIt4NPwSz_3RigKxgMBaq_zoMDo9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfXzoZ9y3u5KVB0
 bQkr0UlxUjCWFhg9q8LgnESArlaN0R+LXyYByP68eHeRKZop8l40t4c/N4U+wbUAhVwuuHKzcwD
 jmMpDek0zAnTO4UI5+eCf7UHQL0y/VY=
X-Authority-Analysis: v=2.4 cv=DLa/JSNb c=1 sm=1 tr=0 ts=6a31991f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=_u34yJfUH-Co13bc16MA:9 a=O8hF6Hzn-FEA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 5KtqrIt4NPwSz_3RigKxgMBaq_zoMDo9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160190
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-3-pierrick.bouvier@oss.qualcomm.com
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
2.47.3


