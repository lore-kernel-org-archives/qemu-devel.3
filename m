Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F1FC369A2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 16:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Be2-0006sF-AX; Tue, 08 Apr 2025 12:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BJ5-0005cX-OP; Tue, 08 Apr 2025 11:56:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BJ3-0005yE-E4; Tue, 08 Apr 2025 11:56:11 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538CU1qJ028772;
 Tue, 8 Apr 2025 15:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=BMii2g6Cq3KmZHIyc
 lvKVLChZ9pjMlONviN6FnGkQ4A=; b=VIt1guAiK+q8jlIQDYAo5XqB7e9CajlB9
 0X06Mcemmmmpm34EPwtY95tCPeW3ECiaWvTDBi1V5AbBJpGvZRJQ5lrr7dIwMx6x
 Ou70/4jfKbIcsUhc1b5qKmr/BFCOf4Zqco8PIXXb5KaQ/m1daOMM/yq5NRnUMObq
 wSw0S53C5ijouEPfzo1R9zLEyPz76wfCgt5PArw60+WzkSe1ITI9SOF3KDpSMMKF
 IYkFH8rulqR2lCo8f7/gQYBYMQ2knmZ9/DJqz5mlLIz3SpLobDbkH2oE76/mljxY
 wtc2fepnp4QFugV3CkqLwICzukCuMVhh5bS4r+hIvpHqqYjfg9Dww==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vv6a3anr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:56:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538CmdpV025510;
 Tue, 8 Apr 2025 15:56:04 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ugbku9wa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:56:04 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 538Fu21g24707620
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 15:56:03 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 991F55803F;
 Tue,  8 Apr 2025 15:56:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A5535804E;
 Tue,  8 Apr 2025 15:56:01 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.125.94])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Apr 2025 15:56:01 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v1 20/24] Add -secure-boot on|off option in QEMU command line
Date: Tue,  8 Apr 2025 11:55:22 -0400
Message-ID: <20250408155527.123341-21-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408155527.123341-1-zycai@linux.ibm.com>
References: <20250408155527.123341-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uB0I5S0lc6S-jLho_xvrLrCy5tpqPub1
X-Proofpoint-GUID: uB0I5S0lc6S-jLho_xvrLrCy5tpqPub1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=741 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080107
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 08 Apr 2025 12:17:35 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The `-secure-boot on|off` command line option is implemented
to enable secure IPL.

By default, -secure-boot is set to false if not specified in
the command line.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 qemu-options.hx |  8 ++++++++
 system/vl.c     | 21 +++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index b460c63490..02d2f4d513 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1262,6 +1262,14 @@ SRST
     A colon may be used to delineate multiple paths.
 ERST
 
+DEF("secure-boot", HAS_ARG, QEMU_OPTION_secure_boot,
+    "-secure-boot on|off\n"
+    "             enable/disable secure boot\n", QEMU_ARCH_S390X)
+SRST
+``-secure-boot on|off``
+    Enable/disable secure boot. Default is off.
+ERST
+
 DEFHEADING()
 
 DEFHEADING(Block device options:)
diff --git a/system/vl.c b/system/vl.c
index bd6197c887..5bdc35516c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -524,6 +524,19 @@ static QemuOptsList qemu_boot_certificates_opts = {
     },
 };
 
+static QemuOptsList qemu_secure_boot_opts = {
+    .name = "secure-boot",
+    .implied_opt_name = "secure-boot",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_secure_boot_opts.head),
+    .desc = {
+        {
+            .name = "secure-boot",
+            .type = QEMU_OPT_BOOL,
+        },
+        { /* end of list */ }
+    },
+};
+
 const char *qemu_get_vm_name(void)
 {
     return qemu_name;
@@ -2894,6 +2907,7 @@ void qemu_init(int argc, char **argv)
     qemu_add_opts(&qemu_fw_cfg_opts);
     qemu_add_opts(&qemu_action_opts);
     qemu_add_opts(&qemu_boot_certificates_opts);
+    qemu_add_opts(&qemu_secure_boot_opts);
     qemu_add_run_with_opts();
     module_call_init(MODULE_INIT_OPTS);
 
@@ -3046,6 +3060,13 @@ void qemu_init(int argc, char **argv)
                     exit(1);
                 }
                 break;
+            case QEMU_OPTION_secure_boot:
+                opts = qemu_opts_parse_noisily(qemu_find_opts("secure-boot"),
+                                               optarg, true);
+                if (!opts) {
+                    exit(1);
+                }
+                break;
             case QEMU_OPTION_fda:
             case QEMU_OPTION_fdb:
                 drive_add(IF_FLOPPY, popt->index - QEMU_OPTION_fda,
-- 
2.49.0


