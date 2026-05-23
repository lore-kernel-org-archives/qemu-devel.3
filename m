Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D66CD5BC6
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 16:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQpCY-0007e4-Vb; Sat, 23 May 2026 12:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wQpCW-0007Zt-OW
 for qemu-devel@nongnu.org; Sat, 23 May 2026 12:27:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wQpCU-0001Ti-V6
 for qemu-devel@nongnu.org; Sat, 23 May 2026 12:27:48 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64NFtDYB2359358
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3F8cfa3sMpBJgTJrU
 Pv7ZhtD6oTivvbM+7sROaKA76Q=; b=p5Fh/EzahZfSjdNmKSMkGT9nNwuO4UvsD
 k7TYCO88yZAJSNgXNCJn+svTiCTitsyo0pAWqTBPEmMUFu61RtSe6qJ5ibqL3Dmo
 34ebu+cPsjRQRyx/KZ/YfdJIlMcRGQg4hMQKksKcCFkYXdyXePOP6+c5UHVVbTxa
 etkk0Q32a8xs15sEleWL7zqwVrPuFmy8v82fQSEnXOSGOZ91y0tsSjAPSwphSyXw
 gcPJ4jwfjd26Ap60DjYbYPfR5d8eqmLzmJ+oe/frdKCmBA9vGfRVAgAv3FFxLPUt
 n5H3CKEIbm1rAmR7uTP43AFOaddNtnS5NrLToeTA2OjJq5U266Swg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s21guc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64NGO3Hj030228
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eb4901r54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64NGReo348169258
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 23 May 2026 16:27:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6270520043;
 Sat, 23 May 2026 16:27:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE70020040;
 Sat, 23 May 2026 16:27:38 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.135])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 23 May 2026 16:27:38 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>
Subject: [PULL 3/5] target/ppc/kvm: Fix const violation when trimming CPU
 alias suffix
Date: Sat, 23 May 2026 21:57:22 +0530
Message-ID: <20260523162724.95229-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260523162724.95229-1-harshpb@linux.ibm.com>
References: <20260523162724.95229-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3uCoojdek9L1GS5wkZgTV7k3RwSzw64m
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a11d581 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=AeOTFisfVSLvIChBu_YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDE2NSBTYWx0ZWRfX5qZxBndxnFP6
 Em1Q38x+uoQOKSHYNzj2AhjNWYBCJ96kX9VOrToTeITwbmt6d0ksVkf57en5D3j79hsZR2CykdG
 9RxVlMvxwiQ3fD8MUyTShn3Pu9sRY6AAc8O/i+1l1GbbuGV0DLIRfidM4Gc2PezsOWfK31Ijcg2
 7jsB5KlpBKwLUyLT6ZbK8zAIqgOiOOv1Ui6EtfkmeRofV5138X8LgZi2gze3y9Xg12y9TT01pGk
 tPI1S+3yDDVUrPPrFEyO2nWymca0ye0h9lBXHNaTOFV36wSx0uSvjcisfaU5lwtBunjZcChF5LZ
 TvijLDJ7y/J3g/AJ0ulD0bzHf6oXo+8qYjddbvliLGT+EKI5cGGka4IbsAW43cfzDxdWl1KKgWb
 x3LviDMffP7A7JkMbr4tJipOksqAqWHQ8SCcI+LKYXukSTCgJjfmUhOwEKXmNv/rqgDnLEq6kKQ
 GvcuO39+vHBwWX00klA==
X-Proofpoint-ORIG-GUID: 3uCoojdek9L1GS5wkZgTV7k3RwSzw64m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605230165
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

From: Amit Machhiwal <amachhiw@linux.ibm.com>

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

Fix this by changing suffix to 'const gchar *' and using g_strstr_len()
to locate the suffix, then allocating a new string with g_strndup() (to
copy only the prefix) or g_strdup() (to copy the entire name if no
suffix exists). This maintains const correctness throughout while
preserving the original functionality.

No functional change intended.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260518172517.12466-2-amachhiw@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/kvm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 25c28ad089..b94c2997a0 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2654,13 +2654,12 @@ static int kvm_ppc_register_host_cpu_type(void)
     dc = DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
     for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
         if (g_ascii_strcasecmp(ppc_cpu_aliases[i].alias, dc->desc) == 0) {
-            char *suffix;
+            const gchar *suffix, *cname = object_class_get_name(oc);
+
+            suffix = g_strstr_len(cname, -1, POWERPC_CPU_TYPE_SUFFIX);
+            ppc_cpu_aliases[i].model = suffix ?
+                g_strndup(cname, (gsize)(suffix - cname)) : g_strdup(cname);
 
-            ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));
-            suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
-            if (suffix) {
-                *suffix = 0;
-            }
             break;
         }
     }
-- 
2.52.0


