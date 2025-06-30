Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD007C8302B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 14:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWFay-00037h-JV; Mon, 30 Jun 2025 10:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexandre.chartre@oracle.com>)
 id 1uWEam-0004aa-8a; Mon, 30 Jun 2025 09:30:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexandre.chartre@oracle.com>)
 id 1uWEai-0008Dx-TQ; Mon, 30 Jun 2025 09:30:39 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UDBfNE000806;
 Mon, 30 Jun 2025 13:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=B7IKr9oZj7qYdfJs4YEnvRbaGnAA3
 CJxLzUSvOJ03p8=; b=H+qR59CNQnLQ8Tu+bWWfqwolKnh7ZTpVn4cZFE4IfpUCB
 vRVSEaWBjW7yKY9mWh0djxXHIPdJk+r28btrkRqxqcQ7b7OPVhsF48/tS+I03358
 AAbwaIy32c9waK7S9/nd8JVzf4JNjGbc4SlHyzkpY6747FokyRbbPtCcswWnMF4z
 v7En7KwOajcmYcivwHEEm+uekLJpmjrwa4JcV0/87wPcX7V9IZr+Z2xdOqr9pNyN
 +YMToBgRvb2vomDOaVis5lVdHb8iBGTCi0rWOclIP4Q9u0o8CI8hZ2z42BMQ37MM
 OBMeJakGb2tRXo89O1DBysj1jvUjGMT/u2enVpeEA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j80w2ghe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Jun 2025 13:30:29 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55UCEDZJ011807; Mon, 30 Jun 2025 13:30:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6u83kwn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Jun 2025 13:30:28 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55UDUSPi038390;
 Mon, 30 Jun 2025 13:30:28 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com
 (dhcp-10-154-171-177.vpn.oracle.com [10.154.171.177])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 47j6u83ksy-1; Mon, 30 Jun 2025 13:30:28 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com
Cc: qemu-stable@nongnu.org, zhao1.liu@intel.com, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com, maciej.szmigiero@oracle.com,
 alexandre.chartre@oracle.com
Subject: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on AMD
Date: Mon, 30 Jun 2025 15:30:25 +0200
Message-ID: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506300110
X-Proofpoint-GUID: 33l6VizfbN-F3TTganpPn07u3t0H-ToV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDExMCBTYWx0ZWRfXwPyU0bN7sUZI
 yN+utnedimTWQfKlUEPLr9PpUmui/HGyjsSOoIPvcG2vc9//TQ2nLpd8OWSpKr5pzSZAF8GxUXr
 R72BRJTfaDkgvgoe9SQNPSoPqtZL3/qNYKF5+7PYvN0UohDSsWYkAA3wisyddsuK1x2U+AWAqrG
 U/h/yns4BomLrbvclOrXDeOQzrXE4E+3A6GpQpwY7pRqW4fjS/Vl+et8QD3TGlaZNulvwwOG3uU
 IcyqoTzHgHZboj3gaDLQxYqfRgTrOyL9WrjP4GUt74pmvS35i7CrYPPgOxoLOfHtlGQHSC7DpNt
 H1qA/wdHTiQVOr4cDczAyHIR6bh8cFFnhE5R4+HPDiN3lMKvCPbzAMWkud6fpUAUrgtDjDuCozp
 IL+NeZTnhnl8FzotgB/3Ea+uk0mZKcv3Rcd8QKlPr9GcWrU4sV6dBI90AmM7mOa/CT3crkhY
X-Authority-Analysis: v=2.4 cv=D6hHKuRj c=1 sm=1 tr=0 ts=68629175 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=12CMx0NIz8uwtlTLpWMA:9
X-Proofpoint-ORIG-GUID: 33l6VizfbN-F3TTganpPn07u3t0H-ToV
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alexandre.chartre@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 30 Jun 2025 10:34:53 -0400
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

KVM emulates the ARCH_CAPABILITIES on x86 for both Intel and AMD
cpus, although the IA32_ARCH_CAPABILITIES MSR is an Intel-specific
MSR and it makes no sense to emulate it on AMD.

As a consequence, VMs created on AMD with qemu -cpu host and using
KVM will advertise the ARCH_CAPABILITIES feature and provide the
IA32_ARCH_CAPABILITIES MSR. This can cause issues (like Windows BSOD)
as the guest OS might not expect this MSR to exist on such cpus (the
AMD documentation specifies that ARCH_CAPABILITIES feature and MSR
are not defined on the AMD architecture).

A fix was proposed in KVM code, however KVM maintainers don't want to
change this behavior that exists for 6+ years and suggest changes to be
done in qemu instead.

So this commit changes the behavior in qemu so that ARCH_CAPABILITIES
is not provided by default on AMD cpus when the hypervisor emulates it,
but it can still be provided by explicitly setting arch-capabilities=on.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 target/i386/cpu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0d35e95430..7e136c48df 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8324,6 +8324,20 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
+    /*
+     * For years, KVM has inadvertently emulated the ARCH_CAPABILITIES
+     * MSR on AMD although this is an Intel-specific MSR; and KVM will
+     * continue doing so to not change its ABI for existing setups.
+     *
+     * So ensure that the ARCH_CAPABILITIES MSR is disabled on AMD cpus
+     * to prevent providing a cpu with an MSR which is not supposed to
+     * be there, unless it was explicitly requested by the user.
+     */
+    if (IS_AMD_CPU(env) &&
+        !(env->user_features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
+        env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
+    }
+
     if (x86_threads_per_pkg(&env->topo_info) > 1) {
         env->features[FEAT_1_EDX] |= CPUID_HT;
 
-- 
2.43.5


