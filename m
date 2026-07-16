Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260DAC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkOIx-0004Ei-GV; Thu, 16 Jul 2026 11:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkOHw-00045K-P5; Thu, 16 Jul 2026 11:46:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkOHv-0002K8-08; Thu, 16 Jul 2026 11:46:16 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDfiQE3360153; Thu, 16 Jul 2026 15:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=eIanNilFHKJpc8qpPvhZ5WmAVFhurccZbVFuS4n1SI4=; b=siYg3oWSEzFn
 RjLDcb/x2H1wXHcx0hNzK8u0FF80fDz+5veTCalCtQK3wuik3QwuA12HZRku47r9
 csIRTBAxkC6E5aJo+r0N8swKLY+v3D4H2WkKfgux+ET/gNaiyoio5P7IyRTZpbYP
 +44tbr3OCVufGVuKkGCEbe9+ZYj97cruFm2xqNXoRCmAVqk5gLaDJkVkIEOm2NS7
 7TTlSj3+n5ZGKK5pGfk7B84f4WGuRBUaFcEV+so5BanfvH5rDF1np/YasnZWUbyz
 7dhjHQLEebvXm644hjNSLcAD+I7ITBVK+qfqKwRBknaqXV9sVXJ1NjosDLPBOPGT
 mIMvHQ4j7A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxsq8s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 15:45:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GFYajV003141;
 Thu, 16 Jul 2026 15:45:49 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhnku6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 15:45:49 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GFjmO328443242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 15:45:48 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5BA658056;
 Thu, 16 Jul 2026 15:45:48 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF2A65805D;
 Thu, 16 Jul 2026 15:45:47 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 15:45:47 +0000 (GMT)
Message-ID: <53670f820a1e08296224feca8903c2112ec78224.camel@linux.ibm.com>
Subject: Re: [PATCH 17/29] hw/gpio: pca9554: reflect push-pull outputs in
 the input register
From: Miles Glenn <milesg@linux.ibm.com>
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Corey
 Minyard <cminyard@mvista.com>
Date: Thu, 16 Jul 2026 10:45:47 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-17-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
 <20260709-catalina-upgrade-v1-17-82a63fead90c@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 4dyDHkNP2oCipA3w95qsHOXxP24u05gg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2MSBTYWx0ZWRfX8YL7xnc6Euv+
 7aY7r9YoJJkUTlx9sIzlcHVehHVQXSadorD5wjgjJqrVQOC/i44k8FFHHDgtX42CRnvphKqiFhC
 s0emPG1DkhEhCMwVVdiwZQq5JpJ+7Yg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2MSBTYWx0ZWRfX+v3YKPQKGSJp
 GdjT/qMYuEi15vhcvy3i56/u1/CIldYow9D4MERf+cY8X0p9A91t+/ZdfNl4biYsTNXKvXJvsMx
 0Dp+dM0vGcRFIvK507xLuquQ/ngbU+7Dgzxt4RdWf7j0YGl2gwI0W+kvtdX2OawsUGPtcXSjVh9
 rdBSRYG2OeJi+hETtCs2DWrWEV+e9TQ2mGygA4VmvsjD/psjUROQJNeq58equv4ZrvbaByNNZ98
 aaKALHb3bk/5nljNYY4yS4mkosgHCS9ZZgY/8xrgo7AWB7tzX4dBcLxEsdga+jX7/lND4lm/+gc
 ecNnzgGvDoaKqyo0LbAr3yZc9Dja0MmGuUC9RJInMCrwFSJMfDFdT6F11oEw/hTL+81Iq3fQuIP
 LCygDURL8YSc6+RtE9GMywtuGddvp5LlhDRVpHGtk638Q60fB6sP3D4iGQdmb7JWH88ScaUJOlN
 fFDnsTXxB2MoAJjSAcQ==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a58fcaf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ilYJhuv43Pl-P8SzJgoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EhPCYggjAe5ABJZnY8wH7oYXwD-nEXju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160161
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Thu, 2026-07-09 at 17:23 +0200, Emmanuel Blot wrote:
> pca9554_update_pin_input() derived the pin level from CONFIG | OUTPUT,
> which treated an output driven high as Hi-Z and let ext_state pull it
> low. The PCA9554/PCA9536 output stage is push-pull, so a pin configured
> as an output drives the OUTPUT register level regardless of any external
> agent. Reflect the output value directly for output pins and keep the
> pull-up/ext_state behaviour for input pins, matching the PCA9555 GPIO
> variant.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  hw/gpio/pca9554.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index ed38fe102b..d4746719f9 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -43,43 +43,32 @@ static void pca9554_update_pin_input(PCA9554State *s)
>      int i;
>      uint8_t config = s->regs[PCA9554_CONFIG];
>      uint8_t output = s->regs[PCA9554_OUTPUT];
> -    uint8_t internal_state = config | output;
>  
>      for (i = 0; i < pc->pin_count; i++) {
>          uint8_t bit_mask = 1 << i;
> -        uint8_t internal_pin_state = (internal_state >> i) & 0x1;
>          uint8_t old_value = s->regs[PCA9554_INPUT] & bit_mask;
>          uint8_t new_value;
>  
> -        switch (internal_pin_state) {
> -        case PCA9554_PIN_LOW:
> -            s->regs[PCA9554_INPUT] &= ~bit_mask;
> -            break;
> -        case PCA9554_PIN_HIZ:
> +        if (config & bit_mask) {
>              /*
> -             * pullup sets it to a logical 1 unless
> -             * external device drives it low.
> +             * Input: the pin is Hi-Z with a pull-up, so it reads high
> +             * unless an external device drives it low.
>               */
>              if (s->ext_state[i] == PCA9554_PIN_LOW) {
>                  s->regs[PCA9554_INPUT] &= ~bit_mask;
>              } else {
> -                s->regs[PCA9554_INPUT] |=  bit_mask;
> +                s->regs[PCA9554_INPUT] |= bit_mask;
>              }
> -            break;
> -        default:
> -            break;
> +        } else {
> +            /* Output: the push-pull stage drives the output register level. */
> +            s->regs[PCA9554_INPUT] = (s->regs[PCA9554_INPUT] & ~bit_mask) |
> +                                     (output & bit_mask);
>          }
>  
>          /* drive the per-pin GPIO output only if the pin level changed */
>          new_value = s->regs[PCA9554_INPUT] & bit_mask;
>          if (new_value != old_value) {
> -            if (new_value) {
> -                /* changed from 0 to 1 */
> -                qemu_set_irq(s->gpio_out[i], 1);
> -            } else {
> -                /* changed from 1 to 0 */
> -                qemu_set_irq(s->gpio_out[i], 0);
> -            }
> +            qemu_set_irq(s->gpio_out[i], !!new_value);
>          }
>      }
>  }
> 


