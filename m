Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0988CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsaf-0000aG-6z; Wed, 03 Jun 2026 16:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZj-000854-1Y
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZY-0004Fx-B4
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:26 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653JZejZ1039943
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=je3MUD6keVA
 fPWR8DdS5aO6YgwljUqYzUOpTW+/1Ems=; b=EW0NDc8K8EYuU6BXWBxf3b+3dgi
 U11cDvmqRMg33h22LtL76rwXE2h9gG0AMT0qiyB5IIXmhY1Y9x1lGsyYcOn4x7Qo
 mfJCEjuWsL4a2ZCt6TM1JrLPNa+7155HIeay+AsdH6jyacXnw1YCuLnteeCFzIj7
 Zjy/h4kWiuMSKe/178/joVYAUENH5GvbYn7K6nFLuDQbVD/fwcnJx4ExM6kWW0GE
 zqhwoXaBjZp8yIMNEQ3mvlTLdQzm/eMOtd9s/hmhgOrS0bVFXLMLKM3upEDY5iZw
 +b9YtFm2zLTf6+7QRPlZoDRZs4jTJjwNVyaXsPtVZlMMvvwb314lzfJtsAA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejtj8g8q8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:17 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304d8613efbso7411093eec.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519937; x=1781124737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=je3MUD6keVAfPWR8DdS5aO6YgwljUqYzUOpTW+/1Ems=;
 b=Bcqj35sfPeEMkNRZ3npsSzrE/EtQW91o+UMdGZ08c2eOLf/RPwzOusf4el3Wb1DNN4
 28DGfiHEtDVdXQtuq8041qtc9YO8Regu2yho+Gj+RnGF6x/ykfdVMu1aSxY5sEozOxDL
 rP3vFYw148prtOSHwPqK9MZTg/TOYUngPu8/M0f0wVRaJoSN0eisR02VXQTJwQoUXgNj
 3fBkv2ml2JuDbtvvw7E+1FRo+axNwFK6VyiHA7Pk3ixERu1dQKh3Fo5MXXCGY1+n4YuZ
 lDMLsv0UlH0G3SJuzhozsQSb46ZfEXVroYZyB6Kd++jIks6Jx3sGnxV72GY9yW4X0l4I
 zHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519937; x=1781124737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=je3MUD6keVAfPWR8DdS5aO6YgwljUqYzUOpTW+/1Ems=;
 b=d4Bkjoo6ZWzOCmDmNs20RjH6wZAyTccK+8XJv7ShxJHPHl9HDHHaih5peP768Ar0hT
 yVG47b2VadpLLnj/eyUgIbB8CuvH8dK1Nlj/PTwbEZsMP+3w8BA7VbLE5/kDK0dByWBJ
 gpRFH6HmYaDI3grSImRX0JddubvI/dnv27prZu313RTCieO9al3IVA5tnGcDeKLmSmO7
 Hr46UldUKGL/9bMUEVAhgYZX7F1yMK0EkEzz1hCHh0gzQ4ST446AxYgEgmGMLAq+Kj/l
 QkDxzCMjzYFi0KBzEz033PFYWak/c1NI3eE7k0fGWWSaf3RLYAUS1hpqGj9LR6IailkQ
 9nNA==
X-Gm-Message-State: AOJu0YyTbHqHLXlt8u9Wk8rOPcPlJfbaWQPKklQFAD6Vh27DoSwPUWQ6
 7dO2XP3htcGmi52ecjsEhIeri8EbTgvpzVNaHMi7ho65sh6WDjeVYL7uRaQ/alT0qni8K1Nuqwv
 XfoVimntiDXEcMySKFt3MSfOXnR2s540LnBEKEEGFktgcI4JmW//qSutpUUl1icRoBFTi
X-Gm-Gg: Acq92OG1PDZozZ70efkWDYNuzORXGMajqy/CmYEg2yrt06EclbTzijURIsCJJe1Q+Ri
 cbVU5BONCIw2rUw/SRRmIvPWvukYWSBMzvyPUW3+BToGePOUonvHNslRBQnPRViPBsDodESsvA9
 y2j1ryoIDIiUhZLg+bcUcB4dB6hZ5WmUG6dzYJ0bore/3vdlr6xg8z8dwZEfcRjw5prCZ0gaOVy
 0839WQI2qy4bkz97ljDbKYhXxBq/U8VMgv3kPoABFGWJujIH3OJNNyZL3RJeu+bJtOwneVCduml
 93OORO6g85kvtn9zl/T7t7VjyE8FUtj/EI3Lk1NjGviaCELkzKP8ALavfHT0uaVct1MfktP61fJ
 eRi3XiDzxu4F/LTQGayNVdm6GmnLh4cHjWabZ4UvwlGk/rlVHLLSj06zxgc1mmfILv2SxPsde1r
 YvrY9D/6vmTEKy9l2T
X-Received: by 2002:a05:7300:c88:b0:2f2:c336:7736 with SMTP id
 5a478bee46e88-3074fbd9d26mr2493112eec.29.1780519936666; 
 Wed, 03 Jun 2026 13:52:16 -0700 (PDT)
X-Received: by 2002:a05:7300:c88:b0:2f2:c336:7736 with SMTP id
 5a478bee46e88-3074fbd9d26mr2493090eec.29.1780519936175; 
 Wed, 03 Jun 2026 13:52:16 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 13/25] plugins: add userdata to
 qemu_plugin_register_vcpu_discon_cb
Date: Wed,  3 Jun 2026 13:51:40 -0700
Message-ID: <20260603205152.1440291-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XoylCkEsUmyKM1tCPhF6GiS56fhE6diY
X-Proofpoint-GUID: XoylCkEsUmyKM1tCPhF6GiS56fhE6diY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfXxpWnRPql45Vb
 cvpeq7CdSVy1K1NMA4O5IjsBIn6wsjAj/D2R8BiEaQsKCduLMw80aMSTaYFFGeBqrkrLVDpeh3j
 jm+rFgbVzIvYxU7LRNh1UItha2OxX2X+kmfU3vEdgYr6Xq9Jx2/fCTx7R5NvOkobt8hNA/3YIRr
 +D9w8hpr0xvLiFp+VZPqQQp+ussNUv4/cF/3ovm1prN8erEJ5OnyFgVCQXFWMcUUqiKB/kvd9nX
 FNUPLR04CARYCCZqWW5yR4PS/ppft0UbUaBhZaXy7QcSAlKnQnfsIjYGaHIMMiETv2yf0X0RJyb
 mI8EStpCcarZrbH8Su2woiy94VsRg+ToBx4N6KyLr7YGgZOPawqc71vmWwlwStbIryd03EXI4nC
 1ltWjoteDGn1HiiuFTHmtDFZG6O4OWldDgZkT6y8ra4XEuSnkol1PXEud5pQnFim431GXSY5nRO
 AIrUX0nq1vZ4WjP436Q==
X-Authority-Analysis: v=2.4 cv=f4p4wuyM c=1 sm=1 tr=0 ts=6a209401 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=UCrIKau3vUVB3JaL4XcA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030203
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/traps.c       |  5 +++--
 include/plugins/qemu-plugin.h |  8 ++++++--
 plugins/core.c                | 12 ++++++------
 tests/tcg/plugins/discons.c   |  4 ++--
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/contrib/plugins/traps.c b/contrib/plugins/traps.c
index 4b879a8212a..4d59aa3c09d 100644
--- a/contrib/plugins/traps.c
+++ b/contrib/plugins/traps.c
@@ -25,7 +25,7 @@ static struct qemu_plugin_scoreboard *traps;
 
 static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
                         enum qemu_plugin_discon_type type, uint64_t from_pc,
-                        uint64_t to_pc)
+                        uint64_t to_pc, void *userdata)
 {
     TrapCounters *rec = qemu_plugin_scoreboard_find(traps, vcpu_index);
     switch (type) {
@@ -75,7 +75,8 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
     traps = qemu_plugin_scoreboard_new(sizeof(TrapCounters));
 
     qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL,
-                                        vcpu_discon);
+                                        vcpu_discon,
+                                        NULL);
 
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index cf937c60ee7..03e7b2b1fb8 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -186,6 +186,7 @@ enum qemu_plugin_discon_type {
  * @from_pc: the source of the discontinuity, e.g. the PC before the
  *           transition
  * @to_pc: the PC pointing to the next instruction to be executed
+ * @userdata: any plugin data to pass to the @cb
  *
  * The exact semantics of @from_pc depends on the @type of discontinuity. For
  * interrupts, @from_pc will point to the next instruction which would have
@@ -198,7 +199,8 @@ enum qemu_plugin_discon_type {
 typedef void (*qemu_plugin_vcpu_discon_cb_t)(qemu_plugin_id_t id,
                                              unsigned int vcpu_index,
                                              enum qemu_plugin_discon_type type,
-                                             uint64_t from_pc, uint64_t to_pc);
+                                             uint64_t from_pc, uint64_t to_pc,
+                                             void *userdata);
 
 /**
  * qemu_plugin_uninstall() - Uninstall a plugin
@@ -293,6 +295,7 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
  * @id: plugin ID
  * @type: types of discontinuities for which to call the callback
  * @cb: callback function
+ * @userdata: any plugin data to pass to the @cb
  *
  * The @cb function is called every time a vCPU receives a discontinuity event
  * of the specified type(s), after the vCPU was prepared to handle the event.
@@ -302,7 +305,8 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
 QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
                                          enum qemu_plugin_discon_type type,
-                                         qemu_plugin_vcpu_discon_cb_t cb);
+                                         qemu_plugin_vcpu_discon_cb_t cb,
+                                         void *userdata);
 
 /** struct qemu_plugin_tb - Opaque handle for a translation block */
 struct qemu_plugin_tb;
diff --git a/plugins/core.c b/plugins/core.c
index a5aac1062aa..54ab3bdbedc 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -122,8 +122,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
         /* iterate safely; plugins might uninstall themselves at any time */
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_vcpu_discon_cb_t func = cb->f.vcpu_discon;
-
-            func(cb->ctx->id, cpu->cpu_index, type, from, to);
+            func(cb->ctx->id, cpu->cpu_index, type, from, to, cb->udata);
         }
     }
     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
@@ -655,16 +654,17 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
 
 void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
                                          enum qemu_plugin_discon_type type,
-                                         qemu_plugin_vcpu_discon_cb_t cb)
+                                         qemu_plugin_vcpu_discon_cb_t cb,
+                                         void *userdata)
 {
     if (type & QEMU_PLUGIN_DISCON_INTERRUPT) {
-        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INTERRUPT, cb);
+        plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_INTERRUPT, cb, userdata);
     }
     if (type & QEMU_PLUGIN_DISCON_EXCEPTION) {
-        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_EXCEPTION, cb);
+        plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_EXCEPTION, cb, userdata);
     }
     if (type & QEMU_PLUGIN_DISCON_HOSTCALL) {
-        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_HOSTCALL, cb);
+        plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_HOSTCALL, cb, userdata);
     }
 }
 
diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
index 2e0e664e823..22114830fdc 100644
--- a/tests/tcg/plugins/discons.c
+++ b/tests/tcg/plugins/discons.c
@@ -98,7 +98,7 @@ static void report_mismatch(const char *pc_name, unsigned int vcpu_index,
 
 static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
                         enum qemu_plugin_discon_type type, uint64_t from_pc,
-                        uint64_t to_pc)
+                        uint64_t to_pc, void *userdata)
 {
     struct cpu_state *state = qemu_plugin_scoreboard_find(states, vcpu_index);
 
@@ -214,7 +214,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                                     has_from);
 
     qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL,
-                                        vcpu_discon);
+                                        vcpu_discon, NULL);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
 
     return 0;
-- 
2.43.0


