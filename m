Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9663CD3430
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 13:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJtbU-0000Tp-3s; Mon, 04 May 2026 09:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wJtbR-0000Sg-QQ; Mon, 04 May 2026 09:44:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wJtbP-0005oA-Ni; Mon, 04 May 2026 09:44:53 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 643It5Ve2236368; Mon, 4 May 2026 13:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=nPNN0/CUzh9DpQpCKMPm3SvBtjUik3sXZ2Fy36xrj
 z0=; b=MFIDAfKYiQh7B0KoM/yWOmB0wdpqFfdkV28aAaewNK1R6PoJcIeQi6UZC
 Dt5GYovZMHy7Kq7G0oUH76lTmJKsNsaq1LvGiTF6nBmFiX1E2yLrAAOBuw5j8ghK
 RKJSIyl1t9avFr5JKYctDJ9OeeK21zrVFQVMwm/TWUj5lF/6evO52IcYGRYC0iCX
 gV5bGyq6OGwtijGrKI0EcxejiZcVPpFHDZBK4Th48EWB1s1Eau6XNurMK04acij5
 6k8Mr7XzcAhO5wv4N0d3lhUeiJPr4gVueb9Z4HBWA27TB9TKmXaHHrERgaN41ikg
 GeqzCp7yskv1kdGk11uSYSBXqMZYQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y177qv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 13:44:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644DdSLw001724;
 Mon, 4 May 2026 13:44:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkjnaee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 13:44:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 644DigaV56689148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 May 2026 13:44:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E4A02004B;
 Mon,  4 May 2026 13:44:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3EB62004E;
 Mon,  4 May 2026 13:44:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.223.155])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 May 2026 13:44:38 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: [PATCH] target/ppc/kvm: Fix const violation when trimming CPU alias
 suffix
Date: Mon,  4 May 2026 19:13:44 +0530
Message-ID: <20260504134344.38958-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 0mZSR3U6aLtNcOkhZchVBMHvWArOphLE
X-Proofpoint-GUID: ew3qkdVBhO4JlUueCOwW3kQsISmayDL-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE0MiBTYWx0ZWRfX2bARpZI1djNT
 CAdTKysV01wDY1rXqKxDvM5nF+W2RIDaKZZ/8Xw9KDeQKwKbBMX1rA3/3mLuqzvvZ5sH4fBXZa9
 +PLw5hQLJeIvinKS0NWyKcZvNke0WbQLzXaCpXBJdbCgAO6nix10T25zpfP2quJBuz4wT2mCgyY
 D+XJgYBwy7e+B+xc5UNdoDJnuzPgymVR5X6R9wjDgKp+y1Dc9EK+dNaubY9hFUpKlDflmCDpYMU
 7miMuFZ+/VVEWAFw1YCrm2FbVRL8jI4HWUVvssa3YxYVc95rG8r+Zsyj44frPJuTugCebSTeVC9
 vc1L7BA73d9hlW2h7q0pxeYII9PwHp1RnYOyFj3oNyJOZEhYUPsDV+bjAlPmN8nkNex2kEt3whM
 ZXiD0gPjILY7M+op345NTCq+EaCFBaVyJOJFGaIrGB13eKwMxwVka4s0/tWg228FTQ91ZfFcW5J
 +GV8pP4TueSUYlULhyw==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69f8a2cf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=AeOTFisfVSLvIChBu_YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040142
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

GCC 16 tightens diagnostics around const correctness and now correctly
rejects attempts to modify strings referenced through const-qualified
pointers. In kvm_ppc_register_host_cpu_type(), ppc_cpu_aliases[i].model
is defined as const char *, but the code was using strstr() on it and
then modifying the returned pointer in-place to strip
POWERPC_CPU_TYPE_SUFFIX.

This results in a write through a pointer derived from const data,
triggering a build failure with GCC 16:

  error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
        suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
               ^

Fix this by duplicating the model string into a mutable buffer using
g_strdup(), storing it in the alias table, and then performing the
suffix truncation on the mutable copy.

This preserves the existing behavior while avoiding modification of
const data and ensures compatibility with newer compilers.

No functional change intended.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 target/ppc/kvm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 25c28ad089c6..e71e5c0117da 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2654,10 +2654,12 @@ static int kvm_ppc_register_host_cpu_type(void)
     dc = DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
     for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
         if (g_ascii_strcasecmp(ppc_cpu_aliases[i].alias, dc->desc) == 0) {
+            char *model;
             char *suffix;
 
-            ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));
-            suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
+            model = g_strdup(object_class_get_name(oc));
+            ppc_cpu_aliases[i].model = model;
+            suffix = strstr(model, POWERPC_CPU_TYPE_SUFFIX);
             if (suffix) {
                 *suffix = 0;
             }

base-commit: ac0cc20ad2fe0b8df2e5d9458e90a095ac711ab1
-- 
2.50.1 (Apple Git-155)


