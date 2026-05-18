Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA66CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 17:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP1j4-0007pW-P8; Mon, 18 May 2026 13:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wP1iz-0007ns-4u; Mon, 18 May 2026 13:25:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wP1is-0005Ez-8t; Mon, 18 May 2026 13:25:50 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IB9VHA1950620; Mon, 18 May 2026 17:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=9o+ZPd+Dq5mzDzpO+
 zbMazocWrqDmu+Ib19Mxw1Xvdk=; b=KPPTCmthLF3UG9amFItvKZSpiUh/1BV5z
 oo9oXZpY2+HvFlS3abbT8gt7md2Y6Lz9HGbutmv1Qw21gHs4cmNU63n2GM1glRzC
 4yHe7o+EXtip1SxcU/dyxAkhUob3qkMf+4SLZ/+F5Z9qF/9cdKLI72zguAE+RnY4
 LpKTP7PYkAIHDpbeZrF+vsusQZcxk/qCaRnQTYnXYxPJJaGZluN1FFLdxtTCZW9f
 7JyYGrKiS+DKGCBBqpfBtrADvQPHiF8DUC603wEyTj1C0Ly1a9TLRf4T/B4qoT7C
 j+KF6JMfQALena2Ct+VrrGqVQAcvwTY63WXbvQ2YQasL6W0rx1HHg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h888rsj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2026 17:25:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IHO9p0000992;
 Mon, 18 May 2026 17:25:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vq3nt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2026 17:25:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64IHPdcI38994218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 May 2026 17:25:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B50D720043;
 Mon, 18 May 2026 17:25:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD65120040;
 Mon, 18 May 2026 17:25:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.29.56])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 18 May 2026 17:25:36 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH v3 1/2] target/ppc/kvm: Fix const violation when trimming CPU
 alias suffix
Date: Mon, 18 May 2026 22:55:15 +0530
Message-ID: <20260518172517.12466-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260518172517.12466-1-amachhiw@linux.ibm.com>
References: <20260518172517.12466-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 9mUzMzoX7csFzem3tPuVm1nrS4J8QxBe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2OCBTYWx0ZWRfX+2uxiwIomGgA
 8Skn3c4GSv0gU+WCS/rAU1E8JlnVk0S2h5xQpUHSedVWZN7J31cfNWKEgQmp59+7HnzYK2emDXS
 4nv9B2oOPsW8vXcvNHL6pjofwzh/LgrBGyWOD0XTLDPssrUmcssHGt1g3gdvD3amMKBPQPubkit
 cuw679wHdz0oya6S5OI80uUWM4pbY/+A5gYtxwEhJyon3P9Fomcjft4cXwOv2X1vAgr8XhRheWX
 k0jGITARRv8T7Ome2ja5ZHmBs/md3Vf+h/h/w/8bGkf24e0qzG/M73ZViQpJ+85ieLiyGXQac37
 3Y6kvilbm4lulokSdhK/iBvPcxJBQ/Zis4xPvNOGAqpmZOQEdirIS9oFy9Jl0KgroeWOvdJ4lPr
 5mL+XxAmYVgrRqCOP7F5+iMJi2kwDsIwJQwC4EH+CqqBKNb/8WsJxVQMm5u2BnI1/4SaOTf740f
 x/CnAI2OozYVWzy0jwA==
X-Proofpoint-GUID: amO-cARgsXVXDVNCRP8vYc6cb1FUsc8t
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0b4b98 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=AeOTFisfVSLvIChBu_YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180168
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Fix this by changing suffix to 'const gchar *' and using g_strstr_len()
to locate the suffix, then allocating a new string with g_strndup() (to
copy only the prefix) or g_strdup() (to copy the entire name if no
suffix exists). This maintains const correctness throughout while
preserving the original functionality.

No functional change intended.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 target/ppc/kvm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 25c28ad089c6..b94c2997a07f 100644
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
2.50.1 (Apple Git-155)


