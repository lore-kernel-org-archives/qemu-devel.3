Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4613BC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 18:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHJn-0002rh-DJ; Wed, 14 May 2025 14:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHJZ-0002Ui-QX; Wed, 14 May 2025 14:58:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHJY-0006su-2A; Wed, 14 May 2025 14:58:49 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EI5Fvs012963;
 Wed, 14 May 2025 18:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CSQaGM
 YYsEs2RHEct7TArD7A582vitw57wC2rb28J58=; b=FiPLc1q0Y5zywRzaaXB+M2
 ZxoK3P42x4bSgypVchfR08qvcSuJGBSXjEQU17DZYr+NbXvPLgooFl4RTUS16LR+
 hdQLuLhhGuRgd6/tcoIjafAxCppIj9s8PeF+8SrZFjDg4A9wanW1qnufIwlim+0l
 x83cKJ31fAKm4eu/OOa/W9/Bx2/uY+DOgp+lUWz2vyFXUayuHyjRKG9E42GOUhfH
 bkvQCPCU3F+S2LcT2wXcF2MKZL17raceDt0afpTgsM/rhj+RChpnB69rIe/JeLDj
 zQrg/RcYD0ZGbdRWUwPxpMhQCfkOmQtrVGPMdPhIsay/qUl8AnVi1Lo3PXSQ3bLQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcjb0j5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:58:43 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EIo72u016448;
 Wed, 14 May 2025 18:58:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcjb0j3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:58:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGaBQ2021797;
 Wed, 14 May 2025 18:58:42 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpny1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:58:42 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EIwebZ24183226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 18:58:41 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E159058054;
 Wed, 14 May 2025 18:58:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61BEB5804E;
 Wed, 14 May 2025 18:58:40 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 18:58:40 +0000 (GMT)
Message-ID: <6db13316-fe73-4c72-94ec-4d7f4d22bb3e@linux.ibm.com>
Date: Wed, 14 May 2025 13:58:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/50] ppc/xive: tctx_notify should clear the precluded
 interrupt
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-14-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-14-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYgdNtVA c=1 sm=1 tr=0 ts=6824e7e3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=KyNRirOTzh_n4JZT_p0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0Hr72IyPY7LIaufERwUzK1IJvZY1cz99
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE2OSBTYWx0ZWRfXyeOWI5v7u6r+
 pb8yNles/jdqQqT6f06ovUnNzTUgV7X98gs+Mbx4ztw80Vxn+E6BaRYhG/+bPRnFRxW7p8hdgZ5
 q21iz9hJuwJz513hu3mc9NB7bMRi6flqv36i05NYVYd8FlXCFipylnTOBDKqi58S2cBDQvQLY7v
 dYBqiO3ifJ0XXZPz+P2FVvZonyWyEo2ZEWXAgbnWWjTHiRnWqN1yAg9aaoF81gr91vUtINxcKM6
 TIRYsqS83XF/ob6JUHv0yT6fsaq6I/dcm9SsfLAy5ml4aH+zJfMpaMGR93E/KNs7bUax0FRBWaJ
 KAFiF5tzoLdQfc6N3h+trGu5zgLSJy6z53k/UKm9DB3uinDJoQMHSzDlez+9+EKAwRSmliDpTR/
 k9N20gxR10paYa6kvFo22lbzMSHsRTqi8J+A7wsUQ9gb5nJ6y1eMdVdoCR/mjfXy0dY33JNU
X-Proofpoint-GUID: 26UnuFXL8ffXJ_MyAbGQ-cyk-QRHJa-T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=890 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140169
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
> If CPPR is lowered to preclude the pending interrupt, NSR should be
> cleared and the qemu_irq should be lowered. This avoids some cases
> of supurious interrupts.

Reviewed-by: Michael Kowal <kowal@linux.ibm.com>

Thanks MAK


>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index cebe409a1a..6293ea4361 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -110,6 +110,9 @@ void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level)
>                                  regs[TM_IPB], alt_regs[TM_PIPR],
>                                  alt_regs[TM_CPPR], alt_regs[TM_NSR]);
>           qemu_irq_raise(xive_tctx_output(tctx, ring));
> +    } else {
> +        alt_regs[TM_NSR] = 0;
> +        qemu_irq_lower(xive_tctx_output(tctx, ring));
>       }
>   }
>   

