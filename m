Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB0ED42BA2
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 16:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAtJr-0004V3-16; Tue, 12 Nov 2024 11:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tAtE6-0001s1-OH; Tue, 12 Nov 2024 10:54:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tAtE3-00015g-KC; Tue, 12 Nov 2024 10:54:46 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACEe1vK007640;
 Tue, 12 Nov 2024 15:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6ohjYspUe8UuHf7GN
 Umr1rFuogI6/HQ/73VQum0Dfwo=; b=FuKvm9XfryRsJICtCYEC96etYQLBE3PED
 BewoSrOrumrSrdqF+35/vwHDc+6bXxzm2hnQ180j9+GrBq89g1cap7HkzVTM8trM
 Kfs1cTHSO6so1wVdPga6QuRASPU7LhVK4/mD6gqKww4NQPKXvJBoKd2aYA2O916/
 O7L873aq72CRfGtUV9VaWqtjHOLFjIZo6S4JrpInppx5AIVa8MmSKsAQc+SJnFoX
 kIoiTwykbNKOj0gmpJNFxzNWYw7eDu67v5x3ZHFUpfSHvoGCcI45aN+nDuQE+WjH
 rWuoZn8NooCLGLcUktjN9jxv15lfoKzM3ktZ4NSYZor41dUK+oNVg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v8yv8csq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:54:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC7iDlI004065;
 Tue, 12 Nov 2024 15:54:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tms14cdq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:54:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4ACFsbop34013858
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Nov 2024 15:54:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93B0C20049;
 Tue, 12 Nov 2024 15:54:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6565120040;
 Tue, 12 Nov 2024 15:54:37 +0000 (GMT)
Received: from vela.boeblingen.de.ibm.com (unknown [9.155.210.79])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Nov 2024 15:54:37 +0000 (GMT)
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH 10/14] s390x/cpumodel: add
 Ineffective-nonconstrained-transaction facility
Date: Tue, 12 Nov 2024 16:54:15 +0100
Message-ID: <20241112155420.42042-11-brueckner@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112155420.42042-1-brueckner@linux.ibm.com>
References: <20241112155420.42042-1-brueckner@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _c7lbKy2WAEbPjX7LY5UcKPy13RhEB91
X-Proofpoint-ORIG-GUID: _c7lbKy2WAEbPjX7LY5UcKPy13RhEB91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=938 spamscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120125
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=brueckner@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Nov 2024 11:00:23 -0500
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

This facility indicates reduced support for noncontrained
transactional-execution.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 target/s390x/cpu_features_def.h.inc | 1 +
 target/s390x/cpu_models.c           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index df154d145f..2c1d1cd98a 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -112,6 +112,7 @@ DEF_FEAT(MSA_EXT_9, "msa9-base", STFL, 155, "Message-security-assist-extension-9
 DEF_FEAT(ETOKEN, "etoken", STFL, 156, "Etoken facility")
 DEF_FEAT(UNPACK, "unpack", STFL, 161, "Unpack facility")
 DEF_FEAT(NNPA, "nnpa", STFL, 165, "NNPA facility")
+DEF_FEAT(INEFF_NC_TX, "ineff_nc_tx", STFL, 170, "Ineffective-nonconstrained-transaction facility")
 DEF_FEAT(VECTOR_PACKED_DECIMAL_ENH2, "vxpdeh2", STFL, 192, "Vector-Packed-Decimal-Enhancement facility 2")
 DEF_FEAT(BEAR_ENH, "beareh", STFL, 193, "BEAR-enhancement facility")
 DEF_FEAT(RDP, "rdp", STFL, 194, "Reset-DAT-protection facility")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 6a7ce77d9a..7fa1712d78 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -512,6 +512,7 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_PFCR_CSDSTG, S390_FEAT_CCF_BASE },
         { S390_FEAT_PFCR_CSTST, S390_FEAT_CCF_BASE },
         { S390_FEAT_PFCR_CSTSTG, S390_FEAT_CCF_BASE },
+        { S390_FEAT_INEFF_NC_TX, S390_FEAT_TRANSACTIONAL_EXE },
     };
     int i;
 
-- 
2.43.5


