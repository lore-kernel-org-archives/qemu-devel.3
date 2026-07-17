Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A57C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 17:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wklv7-0000r7-CJ; Fri, 17 Jul 2026 13:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wklv4-0000qB-DH; Fri, 17 Jul 2026 13:00:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wklv2-0004H0-QU; Fri, 17 Jul 2026 13:00:14 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HEBugN360458; Fri, 17 Jul 2026 17:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ECmJ/i
 hX8AswGZNtikE7dkB+N/1Ui3/RqcQoElStrMo=; b=eZjcDGNb4GedKHoATaXALn
 3fMzEmUOTpZFag6ij5m0tKFJ1g8lyvTTCczMZrtL3YPmhyv0nXX0L/btcAPWVYz3
 KKITVOXCzPfeN6GmJQhWrRFMB3FidQ58PKZCRyrqiHWrbQNKMChde4peAmZ7ukpG
 gZBXyGOsCt/4BZrkHwUlmk9RB9pT/43ArXmM2xi8aVbrj1UoJJLJExUHDM3ma4PJ
 HVEptBSNpFIZBPOEh7YyaTLfp6SHyiTwplGnO+1nLsRe5jA/HxwoGySPSDnH+cyE
 ymorOjD8QsRKWwZJrUGI0u8Q3qD0M65I0t0mpPCTnJiQOArMo/xb9B3Pj26K6b9g
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33r2qu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 17:00:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HGnwaY009284;
 Fri, 17 Jul 2026 17:00:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qjqst-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 17:00:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66HH05uA46793144
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jul 2026 17:00:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1505A2004E;
 Fri, 17 Jul 2026 17:00:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3F1D2004B;
 Fri, 17 Jul 2026 17:00:04 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.138.123])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jul 2026 17:00:04 +0000 (GMT)
Message-ID: <4cc33b71-d094-495e-be51-18074b1f9f0c@linux.ibm.com>
Date: Fri, 17 Jul 2026 19:00:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/51] accel/tcg: Pass breakpoint hit to
 debug_excp_handler
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-28-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE3MCBTYWx0ZWRfX/CDJ2kV7KzXJ
 nvbIETTUQxvrKj9jMvWWnVNy0ksotVBrC6HhYEMTlYzqwSBTpt4c7+DxYHvcEa5d2E5Fa/Q73Ry
 PXQ0a+Ip1W4M5Tak+/mD8Iug/l72Jfo=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a5a5f98 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=pnFR2_1fNxkqxsX6JFAA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: q69rx2XlL_r1-MYOP98tfAC2sBPCV28y
X-Proofpoint-ORIG-GUID: V-5rc069F9Z9truCHW4-VmthMmUXsndn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE3MCBTYWx0ZWRfX9Vuy+6G27MwN
 zw9snRLKa0LLB2SzV8WndxrWeSsHtWguf8QeGDrngP4B2NNzDCf2sN6tN3e4dWSrEhohOH3MhIy
 Mv1fy+Oj6zhV6zww1E/YMoYNPXEvHDodyS+9jRgJ7b8yeVD6kuCFGZXe1LTXUxfxy0FvsWGVmo3
 TPw9RCCawvRmf7ohFAwD25yxnLic3YM30DNC/1C+r5V3iaVE6b9GnByNn4CMPFhYicABqshLyX6
 nS2AV4Et44qx2SwPUu2Bjj+VBIldWjogaPdHJBX2l6Uh8LVJSabs/lWfwHJyW1sxNCV4ZrkmsYJ
 v4YpKZwgvA9k4xPFgX06PFwygyrnFh6fSYV6Ll5IC1TbzxJB912tYTDo6YGIi5x3px3Wr8hOTxa
 Q1G8DazBAIGODnXTW9JdJj9lKUbJwx7saN/kWnMHSmwUrEyi/5fc5LcA641QGIsuyYp2VgtGpAY
 krYLPzgW9DlZDIAoTVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170170
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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



On 7/10/26 22:53, Richard Henderson wrote:
> Record the CPUBreakpoint in check_for_breakpoints_slow,
> into a new CPUState field, so that the as-yet unconverted
> target debug_excp_handler functions won't see it.
> 
> Only call debug_excp_handler for BP_CPU, and clear the
> CPUState fields after the call.  This will allow these
> actions to be dropped from the target hook.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h |  1 +
>   accel/tcg/cpu-exec.c  | 32 +++++++++++++++++++++++---------
>   2 files changed, 24 insertions(+), 9 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


