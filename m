Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35239C5CFC1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wthat-0006ta-0G; Tue, 11 Aug 2026 04:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wthar-0006t8-Kj; Tue, 11 Aug 2026 04:12:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wthap-0005PE-UU; Tue, 11 Aug 2026 04:12:17 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AN1rgb2965210; Tue, 11 Aug 2026 08:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=VMrc/EnF2Ur46i6EFsA3fUrsNPK+nG
 MwvMoaIJg5//E=; b=Q4ZtqrfKETaVoPfG8xR6z65bN4FIJ5NhSORn2d8AeNetr5
 yJbAZVbHJHfYCh0DJ7vp+mkdrPCMBT35F+Iekv7WFK7oThxyHdVZ+XEBRVQIc30J
 cuZZJWAFt3RHA7F4UXDMBwV+9+0LVH0xWxRjUflg78x5kc1Vz/nix6rWBktLgX0O
 1bd6lg8TOzqhDfXHSLG64NOc6Us0/K83MayPMvAhvsQYqItjg/z/8c/sl64kLhQV
 7fuhLF2GjcBSqWjWFQ1+a2dnbQpuMRiWKMP6TNOVzYkwp5waPzkipLmvMlJCfNc+
 VRgUpiWCu6E6eBcpBFubtd4s0ROVWE2k3W6lNivA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9m0sd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 08:12:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67B7uOK0017728;
 Tue, 11 Aug 2026 08:11:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjr5ar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 08:11:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67B8BtZo34603416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 08:11:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 572E12004B;
 Tue, 11 Aug 2026 08:11:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D250520040;
 Tue, 11 Aug 2026 08:11:51 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.25.110]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 11 Aug 2026 08:11:51 +0000 (GMT)
Date: Tue, 11 Aug 2026 13:41:48 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: "Kirill A. Korinsky" <kirill@korins.ky>
Cc: shivangu@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 npiggin@gmail.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 rathc@linux.ibm.com, brad@comstyle.com
Subject: Re: [PATCH v4] powernv: boot OpenBSD on POWER9
Message-ID: <anrZFLsu2ywOUH5U@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260719145559.94342-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719145559.94342-1-kirill@korins.ky>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA2NiBTYWx0ZWRfX2EmFYKt1IYiH
 7wc3YbMQUg0BLPi6ZLW+XJoVJLTWhtmfSRP9jTWsDdHFfA3DC6LFbVg+9B/hfDlqCcvJe1DspqH
 1FiPg9nI0ecoH1BA1jcdXPCmuXBHKDqYogec1VS9YBdFmnorhCQnE2Wkv9LAYFKDRpXws940xMZ
 UcVm2rwX0Qz8YWV69JGc5u6tjpIIouszTfVoLMz3A5l+iTMEmzLumbJhO2YVUp6Bgj3cA4ooQOO
 H/ZwxvQCbRZRXa+VNBOk8JqfEtrcESK+tSlQ0fcpu0nzGkNr9TSIw/tzrlF8Q9z+yyb7KP5+Szn
 cv4XS/aLLXWqVMid7AaUa7ErEiGCiKrRI77Oto7IEhZ7yecCKykg93kj8TVIiclJpbtJv94pw38
 X7aF85J9c1n4c43LTf0NPK4d9s0vR5ZE+t8zQCTBJ2tjrQDdPMgSFsjeR1rh/1AboCKg9I9K/F3
 CJOG6N8jSj22b6A4goQ==
X-Proofpoint-ORIG-GUID: W5skl-MBDzexja19KZAMkFPbMYpw8xhr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA2NiBTYWx0ZWRfX5eLV44uavXov
 lG4ySPmsm0haDLXDC8Df+RXuZk4SR/g/neFX1MCad+vo9uKCoNukqos1NEgX0ibXPHfezEHufPU
 kPWjCAEb6Kz3d8zJtkhHSZnzQZZoeGc=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7ad950 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=tJga6xRQVZmOmLnUc40A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: qkV2oQm7aZFdxtT8WsPMo9JMB5QM8ZTt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110066
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

On 26/07/19 04:55PM, Kirill A. Korinsky wrote:
> The POWER9 Processor User's Manual, section 4.9.4, specifies that POWER9
> ignores PTCR[PATS] and only supports a 64 KiB partition table. Use an
> effective PATS value of 4 on POWER9; other processors keep the existing
> ISA v3.0 interpretation.
> 
> The PSI model now exposes POWER9 IRQ level and pending status registers,
> and keeps both updated while delivering through the existing XIVE LSI
> source. This lets guests that select the POWER9 PSI LSI IRQ method
> continue to receive LPC interrupts.
> 
> The blast radius is probably minimal: the PTCR change is limited to
> POWER9, while the PSI change only touches POWER9 PSI state and reuses
> the existing delivery path.
> ---
>  hw/ppc/pnv_psi.c                       | 11 ++++--
>  target/ppc/mmu-book3s-v3.c             | 21 +++++++++--
>  tests/functional/ppc64/meson.build     |  2 +
>  tests/functional/ppc64/test_openbsd.py | 52 ++++++++++++++++++++++++++
>  4 files changed, 79 insertions(+), 7 deletions(-)
>  create mode 100755 tests/functional/ppc64/test_openbsd.py

Looks good to me. Thank you for adding openbsd support :)

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G


