Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AA3F3D5F5
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2026 07:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6kcD-0005I4-VB; Sun, 29 Mar 2026 03:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w6kcB-0005Hh-1q; Sun, 29 Mar 2026 03:31:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w6kc9-0000fB-91; Sun, 29 Mar 2026 03:31:18 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62T6xPhD2985290; Sun, 29 Mar 2026 07:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0/ysY/
 BHfIGPg6D1bMEkI353lRhkJ4FVMlD9TaOlbQg=; b=id4IJd0K+dyypHkumMsdIZ
 UOWF1BWC1PHb0mhHxzQMhwD1CL6ceIPIJr6R+HmVzKeWMMXhLXqPS3KDrIhPtDZs
 ztxxJrLFypnOc+I/fi4QbxpBF/8urffykum4opKV6flu7wWqB1wc0pR5Yi9+9EhX
 902w/jD+3KNaHCGqYGxY6lv7A54JSnQX1XHDy2Zg3JKSTa4aoHbQlb+keie2ryfT
 UzZPktOm6Zbd8495lzscpYggX55Aj7vsjffxWTW6vC3SyljGmy1GfDNHzjNWr+Pw
 cEbEnlkb+AjrJYeFndXvaS/B/soBta/3XDfID6nNjjbwmTfuxKeNonLjriNpYsWw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g1jwdf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 29 Mar 2026 07:31:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62T7LoxU021665;
 Sun, 29 Mar 2026 07:31:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sas8v0k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 29 Mar 2026 07:31:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62T7VAQ452166926
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 29 Mar 2026 07:31:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBAED2004B;
 Sun, 29 Mar 2026 07:31:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7598F20040;
 Sun, 29 Mar 2026 07:31:08 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.221.238])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sun, 29 Mar 2026 07:31:08 +0000 (GMT)
Date: Sun, 29 Mar 2026 13:01:05 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Zexiang Zhang <chan9yan9@gmail.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
Subject: Re: [PATCH] As reported in qemu-project/qemu#3324
Message-ID: <acjT4ENff_tcJQtz@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260326152733.344926-1-chan9yan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326152733.344926-1-chan9yan9@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69c8d543 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8
 a=M7vallN8fe5NbUhNrHoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: goZQlISw8kggOFHUTeeFNP_0w5Agby4C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDA1NCBTYWx0ZWRfX2n0e9mdbyKYC
 UIo3EqOmOV1baI+ynq13e3+r9dQFYneyCfRxMxMNtmWoS0mmbdZ1ebYefYhOp3LstDzU7NkTG+d
 WV3Lkc32HxK4HbUeFu9fGMJQJFl4QNk7gcefUSERrFpH/70sc4gV6bG5Yp56wc72eCEwnJdjXAK
 IlSfAsJJG6xP+u+XZMt85jVVRGkI+N6vE0JPodz6mejIesPCtDMkCTCr8ZVrpBGM//Q0S9+VKuU
 36iLVrxwz3WhfG3jQJqVt9pB+djd/iS852LO6blazKY59lKXIZM7stE+pwZL9ufMwVV6e1VRim7
 fOo5okq6TzHX91oQHufViK7Ua41uZUoGkcUbADzqji5jwww6kcGl5OxxQ9lF48aN1icyNpWy7tP
 clvoQ4iDAORoRiB7ERUhojtxNiqgf5FWaUJLacGu9UobJkcApbsGl6YL3iaS/uOU8A+vDbZDC2m
 cpGed6H4PSJ9YEhNhmw==
X-Proofpoint-GUID: 49JeXaK6lWxsdumWKdr2EzYV7Dz7QPXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603290054
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Zexiang,

On 26/03/26 11:27PM, Zexiang Zhang wrote:
> From: kiki <Chan9Yan9@gmail.com>
> 
> A malformed IVE value can result in an invalid server field being
> passed to icp_irq(). The function assumes the server id is valid and
> may access invalid state otherwise, potentially leading to a crash.
> 
> Fix this by validating the server id before using it and ignoring
> invalid values.
> 
> Reported-by: Zexiang Zhang <chan9yan9@gmail.com>
> Signed-off-by: Zexiang Zhang <chan9yan9@gmail.com>

About subject, can you change the subject to decribe the fix, something
like 'ppc/pnv: Fix Null Pointer Deref in PHB3', what do you say ?

There's a build error:

	../hw/intc/xics.c: In function ‘icp_irq’:
	../hw/intc/xics.c:226:9: error: implicit declaration of function ‘qemu_log_mask’; did you mean ‘qemu_log’? [-Wimplicit-function-declaration]
	  226 |         qemu_log_mask(LOG_GUEST_ERROR, "XICS: invalid server %d for IRQ 0x%x\n",
	      |         ^~~~~~~~~~~~~
	      |         qemu_log
	../hw/intc/xics.c:226:9: error: nested extern declaration of ‘qemu_log_mask’ [-Werror=nested-externs]
	../hw/intc/xics.c:226:23: error: ‘LOG_GUEST_ERROR’ undeclared (first use in this function); did you mean ‘MOD_ESTERROR’?
	  226 |         qemu_log_mask(LOG_GUEST_ERROR, "XICS: invalid server %d for IRQ 0x%x\n",
	      |                       ^~~~~~~~~~~~~~~
	      |                       MOD_ESTERROR
	../hw/intc/xics.c:226:23: note: each undeclared identifier is reported only once for each function it appears in
	cc1: all warnings being treated as errors

Add '#include "qemu/log.h", maybe after osdep.h include, to fix above
error.

Also, I will recommend running 'make check-functional-ppc64 -j4' to test
the patch before post.

> ---
>  hw/intc/xics.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 1d40c4386d..25c7b0c8a5 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -222,6 +222,13 @@ void icp_irq(ICSState *ics, int server, int nr, uint8_t priority)
>  
>      trace_xics_icp_irq(server, nr, priority);
>  
> +    if (!icp) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XICS: invalid server %d for IRQ 0x%x\n",
> +                      server, nr);
> +        ics_reject(ics, nr);
> +        return;
> +    }
> +
>      if ((priority >= CPPR(icp))
>          || (XISR(icp) && (icp->pending_priority <= priority))) {
>          ics_reject(ics, nr);

The change looks good to me. Can you post a v2 with the subject and
build fixed ?

Thanks,
- Aditya G


