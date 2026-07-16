Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3179C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMQ6-0003ej-28; Thu, 16 Jul 2026 09:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkMQ3-0003dp-J7; Thu, 16 Jul 2026 09:46:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkMQ1-0007fR-Qw; Thu, 16 Jul 2026 09:46:31 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDfdUE3359874; Thu, 16 Jul 2026 13:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=7nog3PPrgO1fh5DWkrGnLAFC1mG9iFbTgG19Ftj1qKk=; b=sTpZf8wstSRn
 P7fJg/CJ43XwCvCxdxj3ymbUkMni3dHXnv5j8TqF0iocwEJJTkf9zIk2FGOUc2Sn
 sk0/3UQ9gVjfcF+PXkfU0J0WvPKbctpxhqnfjDlPlQtn1PX+QwjWnSrhqC0iLE+H
 tEvUCkBIhJpa4n+RXbZIH0FsnVU5G0Qpu1J5EBL3AQmNIMoELuIievuAgJ4ORjs6
 9Sh8nPrbo08f/r6LmXHo4ddG/8EIfqVZ90N2aLVLKZG2m3DvjHIpmvWtg5frCAp0
 qnjbWhLnPlz132UP3kHw06Zn4SjNZ5osZA52dECcDsohk5WzoBbHcKU1pB9U8fGJ
 z8zeXpGxiA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxs47s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 13:46:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GDYZVC022904;
 Thu, 16 Jul 2026 13:46:05 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uycx6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 13:46:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GDk4BT29688370
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 13:46:04 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63C8058059;
 Thu, 16 Jul 2026 13:46:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5BB358055;
 Thu, 16 Jul 2026 13:46:03 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 13:46:03 +0000 (GMT)
Message-ID: <0a84637090653c4e578b2f4458379d195c5f6267.camel@linux.ibm.com>
Subject: Re: [PATCH 07/29] hw/gpio: pca9552: apply input polarity inversion
 on read
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
Date: Thu, 16 Jul 2026 08:46:03 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-7-814575bc076b@free.fr>
References: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
 <20260709-catalina-upgrade-v1-7-814575bc076b@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 6xGBI1y4mdXhVbd_WQbczCyMnWWoo1ZP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0MSBTYWx0ZWRfXyHB2i/yCSUz3
 dwoQxQpVTqlHDxBzNFc860vWhSYI0RwPqky4nK0lpLW+64kX7qy/mC92ck2J1w3Y3Oaxa1QrgED
 jsUbNNwxrsuRUKMLgtysYbWLIBscY68=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0MSBTYWx0ZWRfX773N6rq2jwJm
 dpOU8kCuORy2AaYDcfcJHceSJK+eEVGpBfdhf0njckpx8OnTkgzh53KKROwlQmYrdsx4TXCSYZM
 p3FgbkA9Fuyo+DQKpPzbANwHz7+GogzBNO1l/3DoknxPCSn2sBuQSsm0IQl2pznfzohFKtnw3k4
 bin3AZZOEz9uG69UnqOcY562q+1OdVNQf91FV/LKtx9YGQCxVlVj1pItzyo5Hd186A9Q8OZxAeV
 mUQNJokY9HFLuLZy9eyzo2dEd8A8oo/4WJ5XAZ3gAx+3BBnzbNSYLC0Si09bQ7X8JmLR5G3HTaC
 FkX+x0FoaxFbdCrN5nptOPdfckcRwIVqeXNH6v1D7X83S5QJWNdparipDg4qzc1Zt2XyWWfitdS
 Jg/oOgdTPHIv3/IzsGpSMu0+b61AN98tDI+fz8quQI3NX7gaKccimPWJmT/cOrPp9gt3alJ8Ljb
 jhgW5KpHQcl3WIh6ACQ==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a58e09e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=AShcY7bfDNrBB48VrpIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fDmHf4yDCLPo-whjOKH5O8ZLr8Mseagv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160141
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
> The PCA9535 polarity inversion register inverts the value read back from
> the input port for every pin, regardless of its direction, and does not
> affect the output drive or the physical pin level.
> 
> Store the raw pin level in the input register and apply the polarity
> inversion when the input port is read, instead of XORing it into the
> stored value of output-configured pins only. The interrupt output now
> reflects the raw pin level, matching the datasheet.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  hw/gpio/pca9552.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 66f699bf6a..24f6465415 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -167,9 +167,12 @@ static void pca955x_update_pin_input(PCA955xState *s)
>              /* PCA9535: Simple GPIO behavior */
>              uint8_t config_reg = PCA9535_CONFIG0 + (i / 8);
>              uint8_t output_reg = PCA9535_OUTPUT0 + (i / 8);
> -            uint8_t polarity_reg = PCA9535_POLARITY0 + (i / 8);
>  
> -            /* Check if pin is configured as input */
> +            /*
> +             * The input register holds the raw pin logic level; the
> +             * polarity inversion register is only applied when the input
> +             * port is read (see pca955x_read()).
> +             */
>              if (s->regs[config_reg] & bit_mask) {
>                  /* Input mode - reflect external state */
>                  if (s->ext_state[i] == PCA9552_PIN_LOW) {
> @@ -179,12 +182,8 @@ static void pca955x_update_pin_input(PCA955xState *s)
>                  }
>              } else {
>                  /* Output mode - reflect output register value */
> -                uint8_t output_bit = s->regs[output_reg] & bit_mask;
> -                uint8_t polarity_bit = s->regs[polarity_reg] & bit_mask;
> -
> -                /* Apply polarity inversion if set */
>                  s->regs[input_reg] = (s->regs[input_reg] & ~bit_mask) |
> -                                    ((output_bit ^ polarity_bit) & bit_mask);
> +                                     (s->regs[output_reg] & bit_mask);
>              }
>          }
>  
> @@ -206,6 +205,18 @@ static uint8_t pca955x_read(PCA955xState *s, uint8_t reg)
>          return 0xFF;
>      }
>  
> +    /*
> +     * On the GPIO variants, reading an input port returns the raw pin
> +     * levels XORed with the polarity inversion register, as specified by
> +     * the datasheet.
> +     */
> +    if (!k->has_led_support &&
> +        (reg == PCA9535_INPUT0 || reg == PCA9535_INPUT1)) {
> +        uint8_t polarity_reg = PCA9535_POLARITY0 + (reg - PCA9535_INPUT0);
> +
> +        return s->regs[reg] ^ s->regs[polarity_reg];
> +    }
> +
>      return s->regs[reg];
>  }
>  
> 


