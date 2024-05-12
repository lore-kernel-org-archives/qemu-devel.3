Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBC0C25B5F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 09:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s65fu-0004xC-AI; Sun, 12 May 2024 05:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1s65fs-0004wz-Kv; Sun, 12 May 2024 05:39:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1s65fq-0000LS-Ej; Sun, 12 May 2024 05:39:20 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44C8vo6Y000932; Sun, 12 May 2024 09:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=cVJ7yvPe4l6dKdQJOqlpPAwMabyPMDRDnsoYy4wARYA=;
 b=k7Kb6Woplzgpt83tAfqkA6hWFdv1T5Nh/PY9BLBjxamMkxmmuAWAzOu0+QUE+B9/7AH3
 YLJW/VFrHSRsKwQRbHV/SuNL7qARt58vY4Z83oa1N/cl074fLkgRvecbuzjUiydYyEeG
 +Kg+F6n8qsbeMsfgVhObsrZcfvL/9whV1slrbLCo3TnxiLIhAqDWuW9bFqo8joO5Iz1H
 9EYqDxkQjmmCikNwn3Eh3VtZoQHwV7a2U7HjW8glJEMhWssaUw0YmBDZUA0Blek3r/vL
 LTNzs/PX3N5xhfFFCRPMXAQv4VrhLZVdC2rqr6ExZPNduesW/YN3jQckGYtIZOQr/epe Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y2tq301ew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 12 May 2024 09:39:11 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44C9dBre024690;
 Sun, 12 May 2024 09:39:11 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y2tq301et-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 12 May 2024 09:39:11 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44C5XTCZ002339; Sun, 12 May 2024 09:39:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2m0nsq51-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 12 May 2024 09:39:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44C9d5jM20513276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 12 May 2024 09:39:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A81EF2004F;
 Sun, 12 May 2024 09:39:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60DB32004D;
 Sun, 12 May 2024 09:39:03 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.171.34.11])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 12 May 2024 09:39:03 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com,
 lucas.araujo@eldorado.org.br
Subject: target/ppc: Move VMX int add/sub saturate insns to decodetree. 
Date: Sun, 12 May 2024 15:08:46 +0530
Message-Id: <20240512093847.18099-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H1UKoqi_x04yuZICy7iGchFGkipBnM7h
X-Proofpoint-ORIG-GUID: _inGbfGKv8sypvh5TkwVIAzXafne9AVm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-12_06,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=770 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405120072
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Moving the following instructions to decodetree :
  v{add,sub}{u,s}{b,h,w}s   : VX-form

However, the following instructions were paired using the
GEN_VXFORM_DUAL macros in the vmx-impl and vmx-ops files :

  vaddubs and vmul10uq
  vadduhs and vmul10euq
  vaddshs and bcdcpsgn
  vsububs and bcdadd
  vsubuhs and bcdsub
  vsubsbs and bcdtrunc
  vsubsws and xpnd04_2

Out of those 7 above mentioned pairs, I have moved the first one of
each pair and added respective entry of the 2nd one in the vmx-ops file.
However, I lack some clarity on those flag checks added for those insns
in the ops file. It would be great if someone sheds some light at this.

The issue; let's take the following example :

1. vsubsbs and bcdtrunc :

In this pair, bcdtrunc has the insn flag check PPC2_ISA300 in the
vmx-impl file, within the GEN_VXFORM_DUAL macro, which does this flag
check.
However it also has this flag check in the vmx-ops file.
Hence I have retained the same in the new entry in the vmx-ops file.
This is consistent with the behaviour in done in the following commit :
https://github.com/qemu/qemu/commit/b132be53a4ba6a0a40d5643d791822f958a36e53
So even though the flag check is removed from the vmx-impl file, it is
retained in the vmx-ops file. All good here.

2. vadduhs and vmul10euq :

In this pair, vmul10euq has the insn flag check PPC2_ISA300 in the
vmx-impl file, check done within the GEN_VXFORM_DUAL macro. 
However the same flag was NOT originally present in the
vmx-ops file, so I have NOT included in its new entry in the vmx-ops
file. I have done this, following the behaviour done in the following
commit : 
https://github.com/qemu/qemu/commit/c85929b2ddf6bbad737635c9b85213007ec043af
So this flag check for vmul10euq is excluded now. Is this not a problem ?
I feel that this leads to the flag check being skipped now, however this
behaviour was followed in the above mentioned commit.

Requesting anyone to please let me know why this behaviour was followed and
how the flag checks are retained here, or if they are really skipped,
why is it okay to skip them here ? 

Regards,
Chinmay

Chinmay Rath (1):
  target/ppc: Move VMX integer add/sub saturate insns to decodetree.

 target/ppc/helper.h                 |  24 +--
 target/ppc/insn32.decode            |  16 ++
 target/ppc/int_helper.c             |  22 +--
 target/ppc/translate/vmx-impl.c.inc | 242 ++++++++++++++++++++--------
 target/ppc/translate/vmx-ops.c.inc  |  19 +--
 5 files changed, 224 insertions(+), 99 deletions(-)

-- 
2.39.3


