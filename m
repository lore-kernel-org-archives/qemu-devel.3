Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9ACC531CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3UR-0004kR-Hb; Thu, 23 Jul 2026 20:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UQ-0004je-JD
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UO-00067Y-TH
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:10 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeVVn1237248
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=U3ErWgbMe2J
 9mv/POk8WOuE/s+HGx34mS6kjbZjzoW8=; b=X7K74PUN9yMYYCw9YGVXNglh3wr
 YWlJIUAGOUzLWa90DJvVINVNY3IHLkQfwQtPfjnGLzChxRUGFJD88IXrBVu2M16Y
 Gd206WnXH1tpr95Wbv5Fxsc9iYe4QxLXqUNulEGB+vcB3nw2F9D3goggA3AiVLS/
 ag/AOOKRbc0cbmPRw6XX2j65NRfNYLrUo7XU7WcIU/VWeFJF0IsUGiOcxKbmkpPK
 rQzWBvxtyg5arDPbtBqE1tJYW0FC4j4/HBbZgkcIDbcH6na264YmH6ZbcndGltjv
 gLRgYwOjNNcMlt2pBBkrvBbgXSqIbwbZ4L+NHoJtIqjY/sTOgoEWVc6VEfg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkp5vhqkw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:07 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c96b4f58ddcso1142646a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851807; x=1785456607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U3ErWgbMe2J9mv/POk8WOuE/s+HGx34mS6kjbZjzoW8=;
 b=bLApIdXs0nUJSNKsYKofK4gvis8j1KNPULC0NP9n2PtDmwAMKhR9k1W3GnL8g5azYe
 xIDOZuN8/0Pe4FsOdt15D16FuPObvejaavPLGPzGzSuWHH0xgESmijsd2cWfKhTGIUfX
 coplLZRFpo/wn84hcU+KER5es+U0NdAJ5TFI7G7P6zfFAnxexAEyrrursMJ0ClkxL8Gs
 ms7l9Ui5X+QqGLomLxJGEdGe2SVz0BmFL6Dbmt43qH8Zvg4QJ84kzNVvbdUKs20QJrfB
 bENqMkYQ5LnPARi+7rFKq+z7A1Et8FPQgLgOQs00/Jk5zjPmkrMnsiBdjr8+dYUH0C1V
 cZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851807; x=1785456607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U3ErWgbMe2J9mv/POk8WOuE/s+HGx34mS6kjbZjzoW8=;
 b=Qd0M5BpVW+AY+LKo9NilyvtdDsZEMMaKdcM+pfea2tbM0jeOaPi8AIuMAQCe+2SH77
 nmFxvUp4lDQW/ipcMUZSgKneH8F09IJx7X9e3z/EnmLO4RrK3ACGy3UzIjGDl+FtK2Cq
 zXCtoUUUCceB8ELCZ0PrNZmQXg4s4nqtsJylCjAet/dWJM0ONyJGGKU7muDV8LukyO/1
 HTHyX+N79YrJ1yCP+IpTRRw3+vi2kgRnBDnwzg6WlEhcig5/7Cf5tDYLUgh4YM8ju01Y
 fONkJ7b+LIQ9uAk/7K7fuhlW+uMFS7c/Q17wyS/DW/+aHa2ssZUaFodvpw6+QfeSBN7h
 w4IA==
X-Gm-Message-State: AOJu0YxeJgfeqLqm42vJlFX8SwrwHwdcPELbBl7mDFbMZHj5rh/YMfH7
 RJ3ah/Jv+owwZskgPZBM07Loaenei7jSebGRIIh9D/82kRbyrUAkW63fTqOBHp2btilIBUPVr0B
 bAIXDd6CEM47PwG+rC3YibgtnFTDk0+05wcn3PRsftjQSAwHSYY0Ig03RzjEV0ZYiAQ==
X-Gm-Gg: AR+sD11eITxG2TnLkJYo2dsHYynOzwSaUFuHECNABOkv5fa8c2SjSc5CoD0bGCwlbb3
 9RjVgZiESruboW3F/NXZJoVVTQj15DUTKtQVuKxHHi/DNmpKRdqlAudZzLYDuBllozA0ue8ysL6
 F44C0igIF+7TTS71HwXrmy2C+eCAy/S+8OJytcajr4nUvdhtwk6eWfqjK1ITLvJlhjQlMVX100S
 /Q05vXUDiCfNuMDWtRcVxYk6H9UoldJ56FIq9v6J6XosQ2LaBeHV8zKTKuHdJ0zs9Dr3DbMC1Nl
 kSm0DrUFDq0DQjQLzW6p4wPl/vd72cPHM8v2tsPGdNKtQAyENk7XPZyrGCD0SWLVPEtOxJ3U4nz
 uqL8/Spq47P9czwRbPeLjjpfMeBBYVn3PhCDpDTI9n8tc5YZaBMFWS3iETlgCIIWybF+a/A8=
X-Received: by 2002:a05:6a21:1f8d:b0:3c3:8d4c:667a with SMTP id
 adf61e73a8af0-3c44afc3a1amr6038452637.18.1784851806760; 
 Thu, 23 Jul 2026 17:10:06 -0700 (PDT)
X-Received: by 2002:a05:6a21:1f8d:b0:3c3:8d4c:667a with SMTP id
 adf61e73a8af0-3c44afc3a1amr6038423637.18.1784851806340; 
 Thu, 23 Jul 2026 17:10:06 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 08/27] target-info: add target_config_xen
Date: Fri, 24 Jul 2026 00:09:28 +0000
Message-ID: <20260724000948.234657-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX/FnJT9pqLf2S
 sTWunFdYr1E9l+6qDr+7K2g5BYKAkDRPlJCHkShJuS7eT/g1sDIHb2kK0KEI3lTmSLQ+fH3eJpT
 wgAM5AodJ1KmwljwK4C6l7sjOOTB2hA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX5WMoqfl06gim
 9wAu01W0zcEzZ24R2Bhg8rnQ6syQ33kJuzOC1BcOiIH4/UPsYLIPL54kIhXs98mKG/MCmDfP1Dx
 R/brtEP4Nnur653HrLRjrYI+/SFUCiOW0PKXfp7LGyYIrm02FKaDJqjkStAJftllAXbCXnNSZZx
 JzZOBqRT9RI8keP1Oze/zA8Bh1RQD6+rxisJpiLGltTUYMsN6w5p4OKE4+xjsWK0XT7Xr/CuG+E
 PiBBGQ4o80749PB1lowzWFQ/fj/CCtOZ7RWRbDw1j9LCUHWYkysIXIF6Wa+ucaz+QxGSZXTXm1H
 1MtdwJk3+nUiuxoR7mB/8E4S7nxEwtathJ6Jd3F9rzLl4GjkcTx5Unl0/Oyg82/j9OsJTSCDLfj
 TT4yCKENt6s7ZKoLb/jYJhRpRl/j5aZ5I9DkeL24X0YZQ9QEfZyNs0FvCgZwf1ghuGvACn53e2N
 TSbioRG8o5OutU1VHxw==
X-Authority-Analysis: v=2.4 cv=Z9Dc2nRA c=1 sm=1 tr=0 ts=6a62ad5f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=txnFS4ndXU-pptBIfMcA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: zBt_7WQ_xzk7zrCvX1XnqgyNomd4vtTx
X-Proofpoint-ORIG-GUID: zBt_7WQ_xzk7zrCvX1XnqgyNomd4vtTx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
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

At this moment, we duplicate code between all configs/targets/*.c and
target-info-stub.c but we will clean up this before the end of this
series.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configs/targets/aarch64-softmmu.c | 5 +++++
 configs/targets/arm-softmmu.c     | 5 +++++
 configs/targets/riscv32-softmmu.c | 5 +++++
 configs/targets/riscv64-softmmu.c | 5 +++++
 include/qemu/target-info-impl.h   | 2 ++
 include/qemu/target-info.h        | 7 +++++++
 target-info-stub.c                | 5 +++++
 target-info.c                     | 5 +++++
 8 files changed, 39 insertions(+)

diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
index af65da80d04..4cf13a187d9 100644
--- a/configs/targets/aarch64-softmmu.c
+++ b/configs/targets/aarch64-softmmu.c
@@ -32,6 +32,11 @@ static const TargetInfo target_info_aarch64_system = {
 # else
     .config_multiprocess = false,
 # endif
+# ifdef CONFIG_XEN
+    .config_xen = true,
+# else
+    .config_xen = false,
+# endif
 #endif
 };
 
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
index 501956403cc..f9b8212fc3c 100644
--- a/configs/targets/arm-softmmu.c
+++ b/configs/targets/arm-softmmu.c
@@ -32,6 +32,11 @@ static const TargetInfo target_info_arm_system = {
 # else
     .config_multiprocess = false,
 # endif
+# ifdef CONFIG_XEN
+    .config_xen = true,
+# else
+    .config_xen = false,
+# endif
 #endif
 };
 
diff --git a/configs/targets/riscv32-softmmu.c b/configs/targets/riscv32-softmmu.c
index 69053f3945e..4fe8b096ce0 100644
--- a/configs/targets/riscv32-softmmu.c
+++ b/configs/targets/riscv32-softmmu.c
@@ -31,6 +31,11 @@ static const TargetInfo target_info_riscv32_system = {
 # else
     .config_multiprocess = false,
 # endif
+# ifdef CONFIG_XEN
+    .config_xen = true,
+# else
+    .config_xen = false,
+# endif
 #endif
 };
 
diff --git a/configs/targets/riscv64-softmmu.c b/configs/targets/riscv64-softmmu.c
index cd0fb555986..cfcdac89697 100644
--- a/configs/targets/riscv64-softmmu.c
+++ b/configs/targets/riscv64-softmmu.c
@@ -31,6 +31,11 @@ static const TargetInfo target_info_riscv64_system = {
 # else
     .config_multiprocess = false,
 # endif
+# ifdef CONFIG_XEN
+    .config_xen = true,
+# else
+    .config_xen = false,
+# endif
 #endif
 };
 
diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index 0496eeac046..98542bdaeeb 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -35,6 +35,8 @@ typedef struct TargetInfo {
 
     /* CONFIG_MULTIPROCESS */
     bool config_multiprocess;
+    /* CONFIG_XEN */
+    bool config_xen;
 } TargetInfo;
 
 /**
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 996780150a0..0ecae9411c3 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -127,4 +127,11 @@ bool target_riscv64(void);
  */
 bool target_config_multiprocess(void);
 
+/**
+ * target_config_xen:
+ *
+ * Returns true if target defines CONFIG_XEN.
+ */
+bool target_config_xen(void);
+
 #endif
diff --git a/target-info-stub.c b/target-info-stub.c
index 99c1b1cd7ef..bafbeaa039f 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -51,6 +51,11 @@ static const TargetInfo target_info_stub = {
 # else
     .config_multiprocess = false,
 # endif
+# ifdef CONFIG_XEN
+    .config_xen = true,
+# else
+    .config_xen = false,
+# endif
 #endif
 };
 
diff --git a/target-info.c b/target-info.c
index 07fde91b1ec..a264c51ce83 100644
--- a/target-info.c
+++ b/target-info.c
@@ -119,3 +119,8 @@ bool target_config_multiprocess(void)
 {
     return target_info()->config_multiprocess;
 }
+
+bool target_config_xen(void)
+{
+    return target_info()->config_xen;
+}
-- 
2.43.0


