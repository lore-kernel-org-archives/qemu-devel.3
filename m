Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C584FC369A2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 16:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Bdq-0006ow-0u; Tue, 08 Apr 2025 12:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BIZ-0005T3-C4; Tue, 08 Apr 2025 11:55:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BIX-0005qw-EE; Tue, 08 Apr 2025 11:55:39 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5388p8Ig025971;
 Tue, 8 Apr 2025 15:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0a36/rsg5pTVH+f2g
 SG7LvlEPILNLWKTAThg3/tw4+Q=; b=bWtMvt0ubbV+CD/HQttpk8aesg3a7Mqu5
 jK3eCbf8TqJG7OQbv5IFHOtLDeAPJfQ1mME7tT2gxw86jyJSWJ65bc4zgyDrdGvT
 UYhMWZPzFPzvoKZ9MttbFvgJ8yhmDI/Y4cBUXFQwdQBQ+eu9NEu4LB9kQHz2Y4yD
 BmUtT8h4vdXdpVo7Y8wxKvj/XffxYcQMqoqJKgcGVsqflgfis9gj2ydnLQDDzkke
 aZVD98pmtdky2tYZQXoyY//bF4F/PT0f9GbIBhVik9grBFK1L3Ty08Sfpl4gCDry
 FGiqKMSoXGbyOGnnsp2ZLa+5G0o6BcYUg+7MOeg+0oET4+yb0lYSw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vnvq4hw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:55:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538DBG2a018567;
 Tue, 8 Apr 2025 15:55:33 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2kk5b3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:55:33 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 538FtTCr18350630
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 15:55:29 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D8CD5804E;
 Tue,  8 Apr 2025 15:55:31 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28E2F5803F;
 Tue,  8 Apr 2025 15:55:30 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.125.94])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Apr 2025 15:55:30 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v1 01/24] Add -boot-certificates /path/dir:/path/file option
 in QEMU command line
Date: Tue,  8 Apr 2025 11:55:03 -0400
Message-ID: <20250408155527.123341-2-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408155527.123341-1-zycai@linux.ibm.com>
References: <20250408155527.123341-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1KHO5AMehCMwO6nHBUwKFhKUvN11n2XI
X-Proofpoint-ORIG-GUID: 1KHO5AMehCMwO6nHBUwKFhKUvN11n2XI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=493
 malwarescore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080107
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 08 Apr 2025 12:17:33 -0400
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

The `-boot-certificates /path/dir:/path/file` option is implemented
to provide path to either a directory or a single certificate.

Multiple paths can be delineated using a colon.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 qemu-options.hx | 11 +++++++++++
 system/vl.c     | 22 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index dc694a99a3..b460c63490 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1251,6 +1251,17 @@ SRST
     Set system UUID.
 ERST
 
+DEF("boot-certificates", HAS_ARG, QEMU_OPTION_boot_certificates,
+    "-boot-certificates /path/directory:/path/file\n"
+    "                  Provide a path to a directory or a boot certificate.\n"
+    "                  A colon may be used to delineate multiple paths.\n",
+    QEMU_ARCH_S390X)
+SRST
+``-boot-certificates /path/directory:/path/file``
+    Provide a path to a directory or a boot certificate.
+    A colon may be used to delineate multiple paths.
+ERST
+
 DEFHEADING()
 
 DEFHEADING(Block device options:)
diff --git a/system/vl.c b/system/vl.c
index ec93988a03..bd6197c887 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -510,6 +510,20 @@ static QemuOptsList qemu_action_opts = {
     },
 };
 
+static QemuOptsList qemu_boot_certificates_opts = {
+    .name = "boot-certificates",
+    .implied_opt_name = "boot-certificates",
+    .merge_lists = true,
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_boot_certificates_opts.head),
+    .desc = {
+       {
+           .name = "boot-certificates",
+           .type = QEMU_OPT_STRING,
+       },
+        { /* end of list */}
+    },
+};
+
 const char *qemu_get_vm_name(void)
 {
     return qemu_name;
@@ -2879,6 +2893,7 @@ void qemu_init(int argc, char **argv)
     qemu_add_opts(&qemu_semihosting_config_opts);
     qemu_add_opts(&qemu_fw_cfg_opts);
     qemu_add_opts(&qemu_action_opts);
+    qemu_add_opts(&qemu_boot_certificates_opts);
     qemu_add_run_with_opts();
     module_call_init(MODULE_INIT_OPTS);
 
@@ -3024,6 +3039,13 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_boot:
                 machine_parse_property_opt(qemu_find_opts("boot-opts"), "boot", optarg);
                 break;
+            case QEMU_OPTION_boot_certificates:
+                opts = qemu_opts_parse_noisily(qemu_find_opts("boot-certificates"),
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


