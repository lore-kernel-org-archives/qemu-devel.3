Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48397C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 17:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wngS5-0005bd-4o; Sat, 25 Jul 2026 13:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wngS1-0005b0-O0; Sat, 25 Jul 2026 13:46:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wngRz-00050w-Tk; Sat, 25 Jul 2026 13:46:17 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66PHHTkP1204107; Sat, 25 Jul 2026 17:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=8RmqUsUuRO8MM4gzk
 tlbgDkhwAKrXz1lTjRFPcImv1E=; b=IKMg+/kCblgETcrwcygo4MmQ7sxZLLX3q
 tH33LyMQrw4sZnErauif+drUbVTpXt5V9en1M5YcOa/NtCxX/fEf7Btb1iVhuNzm
 t3KZZ0emDQfO3bO8hJX80xJgkgsIfhUuaFQb49IFDE23Bj1M5DmJIKb75Ts07Utc
 ZB/xfVwopuFGnKjugpbhh2hzOnj8QnCiq1IgzIf1jdKnzk2UtlNOQCOkduBGX1Ay
 P9drzcsHxYMPdkaof4oeuKe3DskkuluqmETJqTgjNNdwJsyezte5mw1xwKqloYiu
 nBpN1UlxnNICnX9KhNjI3/VoZFrBKhLjCMkxgGmLvOqreoCdQGPFw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw70xvd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Jul 2026 17:46:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PHfGc0032556;
 Sat, 25 Jul 2026 17:46:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn59t0v8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Jul 2026 17:46:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66PHk6Kd38601102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 25 Jul 2026 17:46:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 425CA200EB;
 Sat, 25 Jul 2026 17:46:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F084200EA;
 Sat, 25 Jul 2026 17:46:03 +0000 (GMT)
Received: from shivang.com (unknown [9.124.222.170])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 25 Jul 2026 17:46:03 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: shivangu@linux.ibm.com, thuth@redhat.com, adityag@linux.ibm.com,
 amachhiw@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com
Subject: [PATCH v2] tests/functional/ppc: skip remote interrupts test if -net
 user not built
Date: Sat, 25 Jul 2026 23:16:00 +0530
Message-ID: <20260725174600.17683-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724085440.520125-1-shivangu@linux.ibm.com>
References: <20260724085440.520125-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: xMelhbwi7u0Qv9SZ64-Z-os9PeSGrSq0
X-Proofpoint-ORIG-GUID: IPc7x92us0FC9OtoaUHSX_cYacNlIFWc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE2NCBTYWx0ZWRfX9brArngusFyj
 oyqYdcXiplw47LAD1aFuC7ukoj3EifbzX7qzwUZLhmmVxwu/XVxTswZ2Jzh0//Az4hrwQbeaHN8
 SbB7YjXrhJWNjqb4SMgzdjpKWEDPQFI0EOBObtiVz24Ly1j7PptGQ378+xbQQIDw05BC/og80dZ
 sQpSZKVAXXuw/CmrdB0aBeXib24gKVksQ94lp3SVe+SYEL23U2tbZhqGWrOtsEGE2PVfz2zH2h9
 WfhujZUs4o21jkmq9O65w1cnxo3acFCCZlsUluxQ7r5e/3vR4OXuByQ8xpqGUSCP/Jr4RsfFIOS
 yNsWZJTTaG/ka//fA7KNFSGE0Pr1I9sQ2XtshNvJFDiFH/eN1xNPKJJvLmOM1//Z4aA7zXKAMUV
 UiXGkOkLF9x+9JCUTmYp/hKZ7KT3R6tADjinia6bpmj1x5Wi4hy8wDup5TTGfU/Cf56cbPGu6F5
 5w5F/+OH0XLSWv98CuA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a64f663 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=_mrNEnGEA0-oycTHUFkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE2NCBTYWx0ZWRfXxfAOoKS+vB9V
 bbWA5K9q3eI5CL4OZYIyIjy72KL91Fe3WR0IRVMeF+DcGz9vt734StESc0YiBB/rf1ddrfCCtqq
 TpHAhfCvEHgqo1RF7mB3r9b+YU4sgKY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607250164
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

While running remote interrupts test, without libslirp-devel installed,
facing the following panic logs.

  File
    ...
    raise VMLaunchFailure(
    ...<3 lines>...
    ) from exc
    ...
        Output: qemu-system-ppc64: -netdev user,id=net0: network backend
'user' is not compiled into this binary

Adding netdev user requirement for this test.

Suggested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 tests/functional/ppc64/test_powernv.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
index bac2017e18..9a95b6011d 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
@@ -91,6 +91,7 @@ def test_linux_smt_boot(self):
     def test_linux_remote_interrupts(self):
         self.require_accelerator("tcg")
         self.set_machine('powernv')
+        self.require_netdev('user')
 
         # Have below setup in this test:
         # 1. e1000e attached to pcie.6, which is from 7th PHB, belonging to 2nd
-- 
2.54.0


