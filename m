Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBA8CC6B0E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfk8-0001Nq-9w; Tue, 13 Oct 2026 12:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1xGfk5-0001Ni-Jr
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:52:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1xGfk4-0000in-13
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:52:45 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DDgrCB149139; Tue, 13 Oct 2026 16:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JynduI
 vWV/Lxeo1IKu+uM4rwlr5RVFQ5+bMezhi7r2M=; b=nFGsnP7qMWgq0QXE6Z1Uep
 lm4gjoBUfywQjmTmU13PlyW7hubZYb7xEWP5P10uQH8bkp/7qOjryAxcOZ6BwUVH
 02e7JQfsRQ/dy4E4u7kVo927vKN5F7b6tZMAeKLJtjB+XrFgN+9e3V6Csnc2exdL
 LQUbPfcszFvsrpuRd/9WNfdENiHPHUBRcB1yla4QuXQrusrmGmptGsa9V9F9Hap+
 shlFOdq5lnnGw0UsPaRJjrYSphzebOGG/E36O/tvViu5yA8f4KFN5xDgtQBjkFkN
 PAW/2V0+Z+UOtbseUplM8Rq3uXIRSbU/n0juAri/W7F/xvYYR4TjREAs6+ex26WA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhfjh6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 16:52:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DFZ1Pv2709317; Tue, 13 Oct 2026 16:52:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h304n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 16:52:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69DGqZPN50921774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Oct 2026 16:52:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C7442004D;
 Tue, 13 Oct 2026 16:52:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 051C320043;
 Tue, 13 Oct 2026 16:52:35 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.35.59])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 Oct 2026 16:52:34 +0000 (GMT)
Message-ID: <9a21eb8c-47ca-47e7-8685-d9fb9c20e971@linux.ibm.com>
Date: Tue, 13 Oct 2026 18:52:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix PVH entrypoint parsing
To: Ard Biesheuvel <ardb@kernel.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, pbonzini@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240929180659.3598-1-ardb@kernel.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20240929180659.3598-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2NiBTYWx0ZWRfX1TO5ktWh4tz6
 kweHurDvyoMXMrSjRZt38eJruzEFfp8YCIZonv8q4X10PatWxwcX3cB65v1vIBSrTIfW2uchESe
 WmficVRMfZP95CoSkwWsX7NoiPvOd98=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2NiBTYWx0ZWRfX1fWdeM8eDLtZ
 WZjAMZulcX5LJ+rtcy1MHmkDtc1VYYuqjnjUfRthgV/nBulLT/D9W1HvYn9id5z0DT/vwB+D8ta
 cqmEAfZz18jddkskSgvA8cynFOFDosbGSjnYSgc/iOb4CCz8v/yK06D8hGxJMLVecBsKhEdRess
 8gVdrYr0iOB5VshsV7s/h3czqfxKPxOomNltOiDLKD5uUWlrjhtmF3bA3TydcgNxFo8ruAIay4L
 TSuPbtzMX5jxwbZ1p9zhb0Cfm8zikwZkIlxH8JXnX/nW37vim4zoWl5oSYp5qAb6wl/QV0QxuOH
 TvTxuo2VUH2CvsMAniyYwtktCUjzpGJ0kjvIaLLJB0jZ8I+8l8YXeyD9HahJSf5Fz8E1OspKJkp
 6lDc39unKOxrVI7Q6JRSiSNF4EzfqV4n/vRfEd8SkpZF03fSzyvLCwgJTlJQWpv6S/G+NBRkSqA
 Bu4Uz+c4OvHGqqXv5wA==
X-Proofpoint-GUID: fKiC4icHIA1qU8YNrduNqrSKfu5dABp0
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ace61d6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=czFtBru75hg9k7Pz9dEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fKiC4icHIA1qU8YNrduNqrSKfu5dABp0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130066
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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



On 9/29/24 20:06, Ard Biesheuvel wrote:
> Fix the handling of the ELF note that describes the PVH entrypoint
> 
> v2: fix broken ELF note handling on big endian hosts
> 
> Ard Biesheuvel (2):
>    hw/elf_ops: Implement missing endian swabbing for ELF notes
>    hw/x86: Always treat the PVH entrypoint as a 32-bit LE field
> 
>   hw/i386/x86-common.c     |  7 ++-----
>   include/hw/elf_ops.h.inc | 19 +++++++++++++++++--
>   2 files changed, 19 insertions(+), 7 deletions(-)

+Cc: Michael and Richard.

Gentle ping.

