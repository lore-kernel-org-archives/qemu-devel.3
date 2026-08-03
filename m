Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D94C55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqs6z-0000HY-O5; Mon, 03 Aug 2026 08:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqs6w-0000ES-Va; Mon, 03 Aug 2026 08:49:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqs6v-0005nd-AV; Mon, 03 Aug 2026 08:49:42 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673CHpQm151578; Mon, 3 Aug 2026 12:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cbWkil
 153Ujy4T2OZF5TIhFtf4ufpqe5v3pLD6vB/Y4=; b=SvxkHcrb5aNBzAH8t9FZiV
 lMhuVCddpMH+5rSf1aeTLIBm1Obt59NAQam4835o6irW08Xrh3G1iJsSrIOCID8i
 z0/tl/Tfl0bSBilAaCoSx97sH1g4Eh7pgY9VqqSHJ5jJE3aIlGe5O/5qYljnn+2m
 K/CYULIs1lXa5NQmylYn9MSbUcqzKQScKZFNxjkZiurSK1QB2Opin5zZviuPsUry
 GpeyL096MGjVZlUXg9/b4vNkeDBmpg744Uw6eICMerMK6cJ1PJR2Y2rUFTrkkara
 jyPPAujDDBj+itvVi83S9YrgD46+TvUYtmhBE6PtIgSi6i5xqJBK3bS6je3IcTyg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqgrkr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 12:49:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CfGJM027876;
 Mon, 3 Aug 2026 12:49:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh5aub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 12:49:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 673CnXQw29622620
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Aug 2026 12:49:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B205920043;
 Mon,  3 Aug 2026 12:49:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74E4920040;
 Mon,  3 Aug 2026 12:49:33 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.49.55])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Aug 2026 12:49:33 +0000 (GMT)
Message-ID: <d82183a8-536e-443c-9262-7d398900bb75@linux.ibm.com>
Date: Mon, 3 Aug 2026 14:49:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 44/51] accel/tcg: Remove
 TCGCPUOps.adjust_watchpoint_address
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-45-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-45-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: lO_qF3hsp3ki_UGJVHW1QGqHBc5whpA3
X-Proofpoint-ORIG-GUID: hJ3twrPwkw-VN5XUZFrf1p_ujPPUddes
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExNSBTYWx0ZWRfXyoFlF3yM4HRj
 DUl00ujI2IxlEdwLhLOgSfFRfaFzS45a8txbD19DpWuYaUHL71RFsLR+tB0Be8kV2pXkN0ux+zE
 SFbbCXxQfBNIwHmKqgqm7ccJosCD+68=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a708e61 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=I8KRJiQ6pNQQeT64QUkA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExNSBTYWx0ZWRfX1cM0W9an2+2l
 f+0n34I8cs14OxZhI+Z2wksKWfn90PvF6iImPlrLh5m7P82x3MQjoHhyyYVSyAWkZH6WcdKCOkV
 OT6NAtgSndeJ4MmE8MYWC2sq+VVNQd533iiWnevidnS0ZPlFgg2D0Nd6FfyznQcoZCB7L14TZxh
 IUXrgkXGIOYTWR0CLv9PRXV/f0HJVSxzClHNvFnGiWViGN9USazT79779XUCTsnoBqrDjK2loFg
 Ecfzqj42uDfR45Xi9MiwHytRPe9qMWvZOuWIIBHEHGKC/ZsP49lfKXWsxxW7eEOTCKbJm7bjyGs
 kK95QpxtWIHbWXo3LAswFgFXSOEoJeMkWUc17nmeQT179nBN644SW/PnacGmCQ8wI1ZN0N6sI2v
 R5ddXSt+kgz+I2VBqEr8l+XWWqB/LewrorsqwyN1FdjFfQH/SsdDji6msm4pZYSC8p3FiuSN6+I
 gvat4qT74QO1+Aj4eoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030115
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h | 5 -----
>   include/hw/core/cpu.h       | 2 --
>   accel/tcg/watchpoint.c      | 6 ------
>   3 files changed, 13 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



