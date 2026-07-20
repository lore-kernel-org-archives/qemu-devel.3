Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD7AC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlnzt-0001le-O0; Mon, 20 Jul 2026 09:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wlnzq-0001f8-UR; Mon, 20 Jul 2026 09:25:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wlnzn-00023Y-7y; Mon, 20 Jul 2026 09:25:26 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KBDEIB2041258; Mon, 20 Jul 2026 13:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KcKSwg
 FilSztd2iLbWHe9dK/m0Hcz0PBJMF8IkVkyjw=; b=qtIxz4N2cf16pROq6jh5Se
 ALlteH/JWZ8B9h82PPDb3IBC/9n31L+c6CO0aTF4hahd4JmoLWJ4QFj6cIxqrisU
 Hc3R6AEgmDhttyaXi/0s8+DIJFCinS9HRINbLPfRhydydbbx9Jmp1pSuLV8UtN6p
 92/E1f01OjPZ7rORWewQjoO1bBpOFLqrWddwvPG/5easM1snz/kOZ4MAOGRmydWx
 DE94FJdfL9aPqRShuyDjqWsaJihy9HqKkUaW3HuRP74S47vis5Nace6tdPxwilMV
 VR9zONDwZqGvu7SX2OMdOplNZPhCs7FXMwa3CFzZbfAlmJroztwaYYe3r1vxkdpg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790qp05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 13:25:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KDJgLZ006249;
 Mon, 20 Jul 2026 13:25:19 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagwqbn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 13:25:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66KDPGvT2228894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Jul 2026 13:25:17 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DE5F58065;
 Mon, 20 Jul 2026 13:25:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 371AE58062;
 Mon, 20 Jul 2026 13:25:14 +0000 (GMT)
Received: from [9.39.17.136] (unknown [9.39.17.136])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Jul 2026 13:25:13 +0000 (GMT)
Message-ID: <1862e2b0-35eb-48f2-91e5-cecc963b5fb2@linux.ibm.com>
Date: Mon, 20 Jul 2026 18:55:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3] target/ppc: Move system call and rfi instructions
 to decodetree
To: Vishal Chourasia <vishalc@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, Vishal Chourasia <Vishal.Chourasia2@ibm.com>
References: <0ad6b162-086f-4357-b16c-a2988dde7844@linux.ibm.com>
 <20260713222259.2229211-2-vishalc@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260713222259.2229211-2-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MPXCVgo_9-I-0vx6NeM8KmOT8OuZDYOe
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5e21c0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=JglqEYWncxeCZOf1S7UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE0NyBTYWx0ZWRfXzm5OSYLGe4fh
 s06PH67PtF7veBu5MlI2NSFTcl9hwt1ZjHKNm5KSmBWh9FisMiyIh+Z4uPfLvHS6Dqd14PPGxH9
 7FYnxgTJMmZxR5j6X11x5d6GvipOsbQ=
X-Proofpoint-GUID: MPXCVgo_9-I-0vx6NeM8KmOT8OuZDYOe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE0NyBTYWx0ZWRfX6JbN5TY8/uHE
 mARsgEq2djSSYcJ/YxLfmvKqAUHtQn+Ec3K59TDJQtfdseyRNLzqimxOZNqw+qRodCP6+UYdhp4
 lzueWuW8Oj5uTuSdFg5L/PBJb+S41XdUQ/jEczXXWOOSyrV69hJpJLrupnIbl+a3ydHPk2Uyzr3
 +vzDB5/lO/YegQ/YArg20k36SZ9/ryz0v1OqSazRz7eA6A7P/MokeYFHD0ZuljP0lxm0cmCkVUE
 Z3t8fzVzASlXqVZuKxeOW4YJ/Xlmoax3hY5V0cMttslzHS3CUU1S0bMNV7rFYWVy2lp1GF/+uMU
 ZVd7E1hlFiloU7O34Gf5DDqN8uRbb/1ihLVQpT0us8LmVoiOxo+ZNsYDNS9mI/W4vyXJd9IzfAk
 Krl8zx4CbJD3Cqx0JNr4WcLkyzpQ8+f/kfsPvw3By09JYfag7gnUK8pTLUvvKerhxDIlUOgHndO
 dMcooa4FME/PJ5iNFrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200147
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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


On 7/14/26 03:53, Vishal Chourasia wrote:
> From: Vishal Chourasia <Vishal.Chourasia2@ibm.com>
>
> Moving the following instructions to decodetree specification:
>      sc, scv                         : SC-form
>      rfi, rfid, rfscv, hrfid         : XL-form
>
> This builds upon the previous work that moved mfmsr and mtmsr[d]
> instructions to decodetree.
>
> The changes were verified by validating that the tcg ops generated by
> those instructions remain the same, which were captured with the
> `-d in_asm,op` flag, and also by booting a pseries qemu guest.
>
> This also includes improvements from review feedback:
> - Rename helpers to uppercase (RFI/RFID/RFSCV/HRFID) to match ISA mnemonics
> - Add TRANS_FLAGS_NOT() and TRANS64_FLAGS() macro variants
> - Add REQUIRE_INSNS_FLAGS_NOT() check for flag exclusion
> - Specify lev field as uint8_t in SC instruction format
> - Remove redundant masking in SCV since lev is already 7-bit
> - Replace TARGET_PPC64 ifdefs with REQUIRE_64BIT() macro
> - Gate SC, SCV, RFI, RFID, RFSCV, and HRFID with appropriate flags
> - Replace runtime is_book3s_arch2x() check in RFI with TRANS_FLAGS_NOT(SEGMENT_64B)
> - Consolidate CONFIG_USER_ONLY guards into single block
>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
> v3: Addressed missing flag checks for RFI and HRFID instructions pointed
> out by Chinmay.
Thanks for taking care of this !
> v2: In v1, do_rfi() path effectively only implemented the instruction
> for user-only and 64-bit builds, so on qemu-system-ppc every rfi was
> translated as invalid. This trapped OpenBIOS in exception return paths
> and caused the boot/tests to hang. In v2 restore the 32-bit system
> emulation rfi path while keeping rfid, hrfid, and rfscv 64-bit-only.
>
>   target/ppc/helper.h                  |   8 +-
>   target/ppc/insn32.decode             |  11 +++
>   target/ppc/tcg-excp_helper.c         |   8 +-
>   target/ppc/translate.c               | 126 ++-------------------------
>   target/ppc/translate/misc-impl.c.inc | 100 +++++++++++++++++++++
>   5 files changed, 126 insertions(+), 127 deletions(-)

