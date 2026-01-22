Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50178D6CFA1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 18:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vizQc-0005Eq-2Q; Thu, 22 Jan 2026 13:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vizQX-0005CM-Dy; Thu, 22 Jan 2026 13:29:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vizQU-0008DD-El; Thu, 22 Jan 2026 13:29:05 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MCnOvp006265;
 Thu, 22 Jan 2026 18:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=e9SnoMHqMkSNPghAWuN8uTJDQx9euIPGr38xmrM1J2c=; b=k5rvFyJvl3Hj
 AzttdcchdjeN0IvXU6qV/MKwPPnv2k1IryIElcqIAq2bsJN8tgvMNmCuTiCJ2Lxf
 fTJoJkxFqAd8rflSSKbeKok7NaRG957KX9GxRHTNDeWz0+OnHZ5tuY+3ULrVr0eT
 /pddh5mXOKUyPXKPXZhCAm+a8mRLqWgiRLY+5ilVg6eb8HJ8V8MBIhQ2Snntmzxo
 MZOH4fxG7KClh7Km4T8jf9I4FkgHDPe3XKIYzawddcNaBWeF5lWxl1zoZE8Ty+fV
 asennoPNLE3b1q3Kj7eoR7ARmmBmZC67/bQcyUmQJExobbRPlHCTC+RiMzUPfB/J
 IrfVGyDPgQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23sbj1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jan 2026 18:28:36 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60MIHErP022140;
 Thu, 22 Jan 2026 18:28:35 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23sbj1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jan 2026 18:28:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60MI6RRi024583;
 Thu, 22 Jan 2026 18:28:34 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxas2bfg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jan 2026 18:28:34 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60MISY5k13959904
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jan 2026 18:28:34 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E19E55805D;
 Thu, 22 Jan 2026 18:28:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F031E5805E;
 Thu, 22 Jan 2026 18:28:32 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 Jan 2026 18:28:32 +0000 (GMT)
Message-ID: <44a1bd18eef582911c6ce72fc033ed63c2aaced0.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] hw/gpio/pca9552: add pca9535 support
From: Miles Glenn <milesg@linux.ibm.com>
To: Patrick Williams <patrick@stwcx.xyz>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>
Date: Thu, 22 Jan 2026 12:28:32 -0600
In-Reply-To: <20260121-pca9535-v1-1-164640e622ff@stwcx.xyz>
References: <20260121-pca9535-v1-0-164640e622ff@stwcx.xyz>
 <20260121-pca9535-v1-1-164640e622ff@stwcx.xyz>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YtMm4RPbJnAhCUd91SOuUZnq3I9yY_4F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEzOSBTYWx0ZWRfX4VBK8sC7FYOL
 u0EJ42R6KzexRCy0LRKips5bZW6S+ZYcTqgHTH+4+z5XC30CvCdb5wAEeyaInXU6+RH7ZMrQH/s
 TUkf9WSjRvXDw1amXopdY80hc1XAgBNOaMJQ0JVtgyNKi4RgrfH+tdVg75idRhOhykpkdp067iM
 DbB8CIV56+oPW9PIKeluhl5mVeqQho1/OlnfKYC+dUtnsMcltDVnfS70mH1wFAnr7LWkVEa4MUZ
 M4enQwVygPBenZ++Uu7QaIbE7NqbaLD59Ut5w9gObwkkHEhXc9ObOuPJvSg/zhpIhMT14UarxP3
 0hNXIfKiLIRVjIEcIB15tH1nUoi5QYLdFwkPbWQNrFT0GTaOL/mb71msvMlZG/B7TSzviH3hR4/
 FRGXdWf9/CsoDxpE6HCKekc/JcbGtC4ddapyuPHsfrxbUWl4Qtf6IaNk0fuqnPsZq/bzG/GXEwd
 Q4ATOcUXGEUnBPtpOzA==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=69726c54 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=sozttTNsAAAA:8 a=VnNF1IyMAAAA:8 a=2VGnaFk_AAAA:8 a=ALDBd9SrEUpZhD13X0kA:9
 a=QEXdDO2ut3YA:10 a=xuWaqJMTYXf3QM4Ho2sr:22
X-Proofpoint-ORIG-GUID: ttdI8D3U0FQD3hRh7hHUhj5QKRfrcHmm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220139
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Looks good.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Wed, 2026-01-21 at 13:17 -0500, Patrick Williams wrote:
> Extend the 16-bit PCA9552 model to support non-LED devices such as
> the PCA9535[1].
> 
> [1]: https://www.ti.com/lit/ds/symlink/pca9535.pdf
> 
> Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
> ---
>  hw/gpio/pca9552.c              | 176 ++++++++++++++++++++++++++++-------------
>  include/hw/gpio/pca9552.h      |   1 +
>  include/hw/gpio/pca9552_regs.h |  10 +++
>  3 files changed, 133 insertions(+), 54 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index dd3c795e49..dd3f1536b6 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -31,6 +31,7 @@ struct PCA955xClass {
>  
>      uint8_t pin_count;
>      uint8_t max_reg;
> +    bool has_led_support;
>  };
>  typedef struct PCA955xClass PCA955xClass;
>  
> @@ -113,32 +114,59 @@ static void pca955x_update_pin_input(PCA955xState *s)
>      for (i = 0; i < k->pin_count; i++) {
>          uint8_t input_reg = PCA9552_INPUT0 + (i / 8);
>          uint8_t bit_mask = 1 << (i % 8);
> -        uint8_t config = pca955x_pin_get_config(s, i);
>          uint8_t old_value = s->regs[input_reg] & bit_mask;
>          uint8_t new_value;
>  
> -        switch (config) {
> -        case PCA9552_LED_ON:
> -            /* Pin is set to 0V to turn on LED */
> -            s->regs[input_reg] &= ~bit_mask;
> -            break;
> -        case PCA9552_LED_OFF:
> -            /*
> -             * Pin is set to Hi-Z to turn off LED and
> -             * pullup sets it to a logical 1 unless
> -             * external device drives it low.
> -             */
> -            if (s->ext_state[i] == PCA9552_PIN_LOW) {
> +        if (k->has_led_support) {
> +            /* PCA9552: LED control behavior */
> +            uint8_t config = pca955x_pin_get_config(s, i);
> +
> +            switch (config) {
> +            case PCA9552_LED_ON:
> +                /* Pin is set to 0V to turn on LED */
>                  s->regs[input_reg] &= ~bit_mask;
> +                break;
> +            case PCA9552_LED_OFF:
> +                /*
> +                 * Pin is set to Hi-Z to turn off LED and
> +                 * pullup sets it to a logical 1 unless
> +                 * external device drives it low.
> +                 */
> +                if (s->ext_state[i] == PCA9552_PIN_LOW) {
> +                    s->regs[input_reg] &= ~bit_mask;
> +                } else {
> +                    s->regs[input_reg] |=  bit_mask;
> +                }
> +                break;
> +            case PCA9552_LED_PWM0:
> +            case PCA9552_LED_PWM1:
> +                /* TODO */
> +            default:
> +                break;
> +            }
> +        } else {
> +            /* PCA9535: Simple GPIO behavior */
> +            uint8_t config_reg = PCA9535_CONFIG0 + (i / 8);
> +            uint8_t output_reg = PCA9535_OUTPUT0 + (i / 8);
> +            uint8_t polarity_reg = PCA9535_POLARITY0 + (i / 8);
> +
> +            /* Check if pin is configured as input */
> +            if (s->regs[config_reg] & bit_mask) {
> +                /* Input mode - reflect external state */
> +                if (s->ext_state[i] == PCA9552_PIN_LOW) {
> +                    s->regs[input_reg] &= ~bit_mask;
> +                } else {
> +                    s->regs[input_reg] |= bit_mask;
> +                }
>              } else {
> -                s->regs[input_reg] |=  bit_mask;
> +                /* Output mode - reflect output register value */
> +                uint8_t output_bit = s->regs[output_reg] & bit_mask;
> +                uint8_t polarity_bit = s->regs[polarity_reg] & bit_mask;
> +
> +                /* Apply polarity inversion if set */
> +                s->regs[input_reg] = (s->regs[input_reg] & ~bit_mask) |
> +                                    ((output_bit ^ polarity_bit) & bit_mask);
>              }
> -            break;
> -        case PCA9552_LED_PWM0:
> -        case PCA9552_LED_PWM1:
> -            /* TODO */
> -        default:
> -            break;
>          }
>  
>          /* update irq state only if pin state changed */
> @@ -151,52 +179,52 @@ static void pca955x_update_pin_input(PCA955xState *s)
>  
>  static uint8_t pca955x_read(PCA955xState *s, uint8_t reg)
>  {
> -    switch (reg) {
> -    case PCA9552_INPUT0:
> -    case PCA9552_INPUT1:
> -    case PCA9552_PSC0:
> -    case PCA9552_PWM0:
> -    case PCA9552_PSC1:
> -    case PCA9552_PWM1:
> -    case PCA9552_LS0:
> -    case PCA9552_LS1:
> -    case PCA9552_LS2:
> -    case PCA9552_LS3:
> -        return s->regs[reg];
> -    default:
> +    PCA955xClass *k = PCA955X_GET_CLASS(s);
> +
> +    if (reg > k->max_reg) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: unexpected read to register %d\n",
>                        __func__, reg);
>          return 0xFF;
>      }
> +
> +    return s->regs[reg];
>  }
>  
>  static void pca955x_write(PCA955xState *s, uint8_t reg, uint8_t data)
>  {
> +    PCA955xClass *k = PCA955X_GET_CLASS(s);
>      uint16_t pins_status;
>  
> -    switch (reg) {
> -    case PCA9552_PSC0:
> -    case PCA9552_PWM0:
> -    case PCA9552_PSC1:
> -    case PCA9552_PWM1:
> -        s->regs[reg] = data;
> -        break;
> -
> -    case PCA9552_LS0:
> -    case PCA9552_LS1:
> -    case PCA9552_LS2:
> -    case PCA9552_LS3:
> -        pins_status = pca955x_pins_get_status(s);
> -        s->regs[reg] = data;
> -        pca955x_update_pin_input(s);
> -        pca955x_display_pins_status(s, pins_status);
> -        break;
> -
> -    case PCA9552_INPUT0:
> -    case PCA9552_INPUT1:
> -    default:
> +    if (reg > k->max_reg) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: unexpected write to register %d\n",
>                        __func__, reg);
> +        return;
> +    }
> +
> +    /* Handle read-only registers */
> +    if (reg == PCA9552_INPUT0 || reg == PCA9552_INPUT1) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: unexpected write to read-only register %d\n",
> +                      __func__, reg);
> +        return;
> +    }
> +
> +    pins_status = pca955x_pins_get_status(s);
> +    s->regs[reg] = data;
> +
> +    /* Update GPIO state if this register affects outputs */
> +    if (k->has_led_support) {
> +        /* PCA9552: Update on LED selector register writes */
> +        if (reg >= PCA9552_LS0 && reg <= PCA9552_LS3) {
> +            pca955x_update_pin_input(s);
> +            pca955x_display_pins_status(s, pins_status);
> +        }
> +    } else {
> +        /* PCA9535: Update on OUTPUT, POLARITY, or CONFIG register writes */
> +        if (reg >= PCA9535_OUTPUT0 && reg <= PCA9535_CONFIG1) {
> +            pca955x_update_pin_input(s);
> +            pca955x_display_pins_status(s, pins_status);
> +        }
>      }
>  }
>  
> @@ -379,6 +407,26 @@ static void pca9552_reset(DeviceState *dev)
>      s->len = 0;
>  }
>  
> +static void pca9535_reset(DeviceState *dev)
> +{
> +    PCA955xState *s = PCA955X(dev);
> +
> +    s->regs[PCA9535_INPUT0] = 0xFF;   /* All inputs high (pull-ups) */
> +    s->regs[PCA9535_INPUT1] = 0xFF;   /* All inputs high (pull-ups) */
> +    s->regs[PCA9535_OUTPUT0] = 0xFF;  /* All outputs high */
> +    s->regs[PCA9535_OUTPUT1] = 0xFF;  /* All outputs high */
> +    s->regs[PCA9535_POLARITY0] = 0x00; /* No polarity inversion */
> +    s->regs[PCA9535_POLARITY1] = 0x00; /* No polarity inversion */
> +    s->regs[PCA9535_CONFIG0] = 0xFF;  /* All pins as inputs */
> +    s->regs[PCA9535_CONFIG1] = 0xFF;  /* All pins as inputs */
> +
> +    memset(s->ext_state, PCA9552_PIN_HIZ, PCA955X_PIN_COUNT_MAX);
> +    pca955x_update_pin_input(s);
> +
> +    s->pointer = 0xFF;
> +    s->len = 0;
> +}
> +
>  static void pca955x_initfn(Object *obj)
>  {
>      PCA955xClass *k = PCA955X_GET_CLASS(obj);
> @@ -463,6 +511,19 @@ static void pca9552_class_init(ObjectClass *oc, const void *data)
>      dc->vmsd = &pca9552_vmstate;
>      pc->max_reg = PCA9552_LS3;
>      pc->pin_count = 16;
> +    pc->has_led_support = true;
> +}
> +
> +static void pca9535_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    PCA955xClass *pc = PCA955X_CLASS(oc);
> +
> +    device_class_set_legacy_reset(dc, pca9535_reset);
> +    dc->vmsd = &pca9552_vmstate;
> +    pc->max_reg = PCA9535_CONFIG1;
> +    pc->pin_count = 16;
> +    pc->has_led_support = false;
>  }
>  
>  static const TypeInfo pca9552_info = {
> @@ -471,10 +532,17 @@ static const TypeInfo pca9552_info = {
>      .class_init    = pca9552_class_init,
>  };
>  
> +static const TypeInfo pca9535_info = {
> +    .name          = TYPE_PCA9535,
> +    .parent        = TYPE_PCA955X,
> +    .class_init    = pca9535_class_init,
> +};
> +
>  static void pca955x_register_types(void)
>  {
>      type_register_static(&pca955x_info);
>      type_register_static(&pca9552_info);
> +    type_register_static(&pca9535_info);
>  }
>  
>  type_init(pca955x_register_types)
> diff --git a/include/hw/gpio/pca9552.h b/include/hw/gpio/pca9552.h
> index c36525f0c3..43b175235d 100644
> --- a/include/hw/gpio/pca9552.h
> +++ b/include/hw/gpio/pca9552.h
> @@ -14,6 +14,7 @@
>  
>  #define TYPE_PCA9552 "pca9552"
>  #define TYPE_PCA955X "pca955x"
> +#define TYPE_PCA9535 "pca9535"
>  typedef struct PCA955xState PCA955xState;
>  DECLARE_INSTANCE_CHECKER(PCA955xState, PCA955X,
>                           TYPE_PCA955X)
> diff --git a/include/hw/gpio/pca9552_regs.h b/include/hw/gpio/pca9552_regs.h
> index d8051cfbd6..5a6bb03396 100644
> --- a/include/hw/gpio/pca9552_regs.h
> +++ b/include/hw/gpio/pca9552_regs.h
> @@ -29,4 +29,14 @@
>   */
>  #define PCA9552_AUTOINC  (1 << 4)
>  
> +/* PCA9535 Registers (same addresses, different semantics) */
> +#define PCA9535_INPUT0      0 /* read only input register 0 */
> +#define PCA9535_INPUT1      1 /* read only input register 1  */
> +#define PCA9535_OUTPUT0     2 /* read/write output register 0 */
> +#define PCA9535_OUTPUT1     3 /* read/write output register 1 */
> +#define PCA9535_POLARITY0   4 /* read/write polarity inversion register 0 */
> +#define PCA9535_POLARITY1   5 /* read/write polarity inversion register 1 */
> +#define PCA9535_CONFIG0     6 /* read/write configuration register 0 */
> +#define PCA9535_CONFIG1     7 /* read/write configuration register 1 */
> +
>  #endif
> 


