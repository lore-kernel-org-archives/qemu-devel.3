Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64293C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05YQ-0001BL-OR; Fri, 28 Aug 2026 19:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YJ-0000mX-SY
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:00:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YH-0005nj-MF
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:00:03 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTv8c146839
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AFxB+6PHHMh
 iCUfNfln4GAWfFlgvw3YNZc5dgO+oh2k=; b=HUtV7ST87ViGEbbb6vE7vvamOW3
 fKC8cMv8/TU28BzxTJF66vsDud5hi7tSNdywqE0tmVc+1HkDVUwh6mHGxwy59NLs
 1OLyPmrOBh2a2a83HzTcHBfR9qwjyotWYpn/pGImhwNlzkJCwrl8t1qHrL2twcGS
 wGaZnF4ca2OvPxsqvqq+2mkAS5nUkyEKkP7NfkK+xIMYbolbTDpBILar7HllcMxs
 dNYohYTRj6cT4rE+rYNabAlyObdpqZ6UsL+Mt155MMGQ8Pn6CpTXKhx+yQP/tS6C
 pg/eJNPZarpL2Ve6p43omk4SSaZoDIgRT9ACxxLAQWE8uqczKGNontm1bLA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb7eh2s45-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so3591287a91.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957989; x=1788562789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AFxB+6PHHMhiCUfNfln4GAWfFlgvw3YNZc5dgO+oh2k=;
 b=BlCXsqzInPKKhjWgrobKdUvgkzl7APXOcos9nM61xpKB4ircTsx/wiJr7eQYRcWgyX
 TOEwYObyrUQXtlDcP/pHgKmWcZAN7arGWE/9iRuAmzr4cbgUOA3x3vKbYgo9jRlRZzEH
 4F7QM1w1te53Z9PrIyKB0mK3tqFUlpznp+RJiT1sL6sQL1bnlHLgH/ZKfV352BNNFQ+e
 /NHG8ZPqWVifwqDekulehMOs+wGyUnwsEqf8w4VoqENAIoGSsZEt5emRsf1kIl10HW7D
 /e0UfWPm+Fr7QTjx9E7Ne6qeOhqoLpq3mUC1b/KWd4xoCxVcjRwAryr+hjccsF1HI5yo
 qG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957989; x=1788562789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AFxB+6PHHMhiCUfNfln4GAWfFlgvw3YNZc5dgO+oh2k=;
 b=iuWW2+4Vs/IaKD4b3e4PIH63uy92oxZP2LfAKxu4ORQUBc8FnwT8B247n5a2TqDB2Q
 MlML1qUS1kv2fUe3SR/R0WQrGVrC1o73i+EJY36va4bUugKgs3JDlx04eKWcfglj3yIB
 gd147JeRVPP5nO/ewRhQYUt4G5MJmUgUGyEE1sCQb1FcdtTkqLTauusJ9tA63w0m1DQ1
 5nOJLmM9iPUQBIJU1kxhv24w3pdeSG8RJYrhxyJEaww5XDqADWHv1VnRP1rOZDGbyOWX
 VUPsVXJrkJj1QiTwCsm62ioNvMOXnYcwR7cOO5s7gvIetEwTP2pHmrxmHhXFopqoZzxp
 UrxQ==
X-Gm-Message-State: AFuF++n+Y4KGv6YtIFQcPwgXgSUAj+xD7kWdoGcbgsMEv+akyzFSEIp6
 GxJx9b8vMeBIY6l0funs+WmVY5w2cDze0yRPPdMq+0Qa45UoP61u2exUav9FgBcfkvA1vzuthUW
 SRFOhMXUL/pakaGFHN92ze/U42lOlYJV/nIAPbBK8G6SQvVtDsXMvXFsY4yl6KjXppQ==
X-Gm-Gg: AYBFou04rrYHF7YgDkUHqpv+Nl3rm5gIFYzYcpwMgtOCUNhRXsrAF2xX1KWJfHNKy/7
 THn7BlML6mcrZ/PpZDXltHdSIViUuxP0I/BxA0vZstwThzGx+xkeKNWBGJNlJQqrthdKysTQnBs
 Ea9ZZUId2Nv4iSdCpUs0JCvS+PI8ZHvxWLAX2QVhqG4tZEgHPwWUOZqMSzxnPci8+YkLkgVzP7r
 tF3sNgEdR+WAKztYVVuqobIZDzjD24KB33OzOI2whuK/yRugqYtIskVI39S1agn7mWYrAjGCx2n
 i29p0wvhNRYkTJeS3iFEzV/QNpA0ZbYwM8mLwVmmvLNT7NsLKeK6cnxKqHO9IE/5uuzVkV9Cw0a
 6o7JJgrS4DF0rTAUz0QEmc9ZDjvqJJKqj21ZCSzGBkoD6XvNub9yaAEbI2t8=
X-Received: by 2002:a17:90b:6c7:b0:396:6344:3b63 with SMTP id
 98e67ed59e1d1-396d0e25905mr19256247a91.2.1787957989573; 
 Fri, 28 Aug 2026 15:59:49 -0700 (PDT)
X-Received: by 2002:a17:90b:6c7:b0:396:6344:3b63 with SMTP id
 98e67ed59e1d1-396d0e25905mr19256201a91.2.1787957989201; 
 Fri, 28 Aug 2026 15:59:49 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 33/47] system/vl: add new option -target
Date: Fri, 28 Aug 2026 22:58:47 +0000
Message-ID: <20260828225901.367438-34-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ad7CmZ1cn6pmUoKTSqkKkFJMqUrI6-W4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX+fx+B/Sf4y12
 lUAVpN4QzxcuWN4hkXf866kROap7FJ5zzj7VLm405bmx5R2+HlqqqvGrh1S0kx5yZJIj1izvgHT
 pVnc+KxHtGxSrCHntwWSShcYGLpnqK4elnQqHNlZXWrmFu/2n3NzUxJafer5wTWBLaRo+pw00YB
 WCzwNKOtbLEFMFdEFlb9KhNWBz7bjUSTIkscK+j/RlS12ZvCuFd3LrL0M+ImwkinmXGIXqPJTVv
 Y2dkIo4+j7PiUddfm+Ny0PUUKmFhrzCbcg0kxBU2GwdGtLWcxrrWL9qfdusTFgqzA3kUWnLiC5J
 6Emv2/vivKAhcUYiLjZaZ4eJati5E7UGhiUk++uTFZTpIXlAzbBVzhpZMuZrVpmtgZD/BuVFly+
 ZIQH0Chu6waekRhMlXpoEXxvI8VUBxfr85gGAXCEL/g0qSnCzWAKfA6xpnWuiEhQFGuf2D8IS2K
 FAcE8fKPs/NSHJ8PBBg==
X-Proofpoint-ORIG-GUID: Ad7CmZ1cn6pmUoKTSqkKkFJMqUrI6-W4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX9RWSulIV/0mH
 P4iALzsKfOkE+gH4qUdLqrD4d7jVfrk9Py84e+/V/iVjsihfLoXfpxP9if4Jb4GKci44FsUpott
 /V+quwNpAntVOM2bdE00QqDl+p5QeIg=
X-Authority-Analysis: v=2.4 cv=RoP16imK c=1 sm=1 tr=0 ts=6a9212e6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=kemcdkk9OJzm-CMI4xoA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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

This commit adds a new option -target, which can be allowed to set
current target, or retrieve list of targets available with 'help'.

This option is the first we need to handle, as all the rest of
initialization depends on it.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-qom.h |  1 +
 qemu-options.hx                |  8 ++++++++
 system/vl.c                    | 34 +++++++++++++++++++++++++++++++++-
 target-info-qom.c              | 33 ++++++++++++++++++++++++++++++++-
 4 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index 91be415ed33..87f3a51ccd4 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -26,5 +26,6 @@ typedef struct TargetInfoQomClass {
 OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
 
 void target_info_qom_set_target(void);
+void target_info_qom_set_target_from_name(const char *name);
 
 #endif /* QEMU_TARGET_INFO_QOM_H */
diff --git a/qemu-options.hx b/qemu-options.hx
index 562c4c2b035..68d0c1d42da 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -24,6 +24,14 @@ SRST
     Display version information and exit
 ERST
 
+DEF("target", HAS_ARG, QEMU_OPTION_target, \
+    "-target target  selects the target architecture ('-target help' for list)\n",
+    QEMU_ARCH_ALL)
+SRST
+``-target target``
+    Selects target architecture ('-target help' for list)
+ERST
+
 DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "-machine [type=]name[,prop=value[,...]]\n"
     "                selects emulated machine ('-machine help' for list)\n"
diff --git a/system/vl.c b/system/vl.c
index f7f8aabd122..60c5ce85580 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -281,6 +281,15 @@ static QemuOptsList qemu_accel_opts = {
     },
 };
 
+static QemuOptsList qemu_target_opts = {
+    .name = "target",
+    .implied_opt_name = "target",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_target_opts.head),
+    .desc = {
+        { /* end of list */ },
+    },
+};
+
 static QemuOptsList qemu_boot_opts = {
     .name = "boot-opts",
     .implied_opt_name = "order",
@@ -2891,6 +2900,7 @@ void qemu_init(int argc, char **argv)
     qemu_add_opts(&qemu_semihosting_config_opts);
     qemu_add_opts(&qemu_fw_cfg_opts);
     qemu_add_opts(&qemu_action_opts);
+    qemu_add_opts(&qemu_target_opts);
     qemu_add_run_with_opts();
     module_call_init(MODULE_INIT_OPTS);
 
@@ -2900,7 +2910,26 @@ void qemu_init(int argc, char **argv)
     os_setup_limits();
 
     module_call_init(MODULE_INIT_TARGET_INFO);
-    target_info_qom_set_target();
+
+    /*
+     * Identify target: first from option, then from argv[0].
+     * This happens even before handling --help option, because it may contain
+     * entries that are target specific.
+     */
+    for (int idx = 1; idx < argc;) {
+        if (argv[idx][0] != '-') {
+            idx++;
+        } else {
+            const QEMUOption *popt = lookup_opt(argc, argv, &optarg, &idx);
+            if (popt->index == QEMU_OPTION_target) {
+                target_info_qom_set_target_from_name(optarg);
+                break;
+            }
+        }
+    }
+    if (!target_info()) {
+        target_info_qom_set_target();
+    }
 
     module_init_info(qemu_modinfo);
     module_allow_arch(target_name());
@@ -2948,6 +2977,9 @@ void qemu_init(int argc, char **argv)
                 exit(1);
             }
             switch(popt->index) {
+            case QEMU_OPTION_target:
+                /* handled previously, ignore it here */
+                break;
             case QEMU_OPTION_cpu:
                 /* hw initialization will check this */
                 cpu_option = optarg;
diff --git a/target-info-qom.c b/target-info-qom.c
index 6965e4d1169..a2f506c15ef 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qom/object.h"
+#include "qemu/error-report.h"
 #include "qemu/target-info-impl.h"
 #include "qemu/target-info-init.h"
 #include "qemu/target-info-qom.h"
@@ -50,6 +51,36 @@ void target_info_qom_set_target(void)
                                  "no target-info is available" :
                                  "more than one target-info is available");
     }
-
     target_info_ptr = TARGET_INFO_CLASS(targets->data)->target_info;
 }
+
+static void list_targets_available(void)
+{
+    printf("List of targets available:\n");
+    g_autoptr(GSList) targets = object_class_get_list_sorted(TYPE_TARGET_INFO, false);
+    for (GSList *elem = targets; elem; elem = elem->next) {
+        const TargetInfo *ti = TARGET_INFO_CLASS(elem->data)->target_info;
+        printf("- %s\n", ti->target_name);
+    }
+}
+
+void target_info_qom_set_target_from_name(const char *name)
+{
+    if (!strcmp(name, "help")) {
+        list_targets_available();
+        exit(0);
+    }
+
+    g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
+    for (GSList *elem = targets; elem; elem = elem->next) {
+        const TargetInfo *ti = TARGET_INFO_CLASS(elem->data)->target_info;
+        if (!strcmp(name, ti->target_name)) {
+            target_info_ptr = ti;
+            return;
+        }
+    }
+
+    error_report("target '%s' is not available", name);
+    list_targets_available();
+    exit(1);
+}
-- 
2.43.0


