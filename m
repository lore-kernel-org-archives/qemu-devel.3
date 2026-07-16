Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BBFC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNB4-0002cu-0n; Thu, 16 Jul 2026 10:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkNAf-0002XS-0b; Thu, 16 Jul 2026 10:34:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkNAR-0005Y5-IY; Thu, 16 Jul 2026 10:34:29 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDfZOs3370532; Thu, 16 Jul 2026 14:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=NsTbMSTA5acI7Yaw1BjAGaJ7tHKm+7praU7q1Ow1RaU=; b=kKOmjBiKyapz
 VnAn8sDen43XW4d0BI4M5I9nOW+DlaTmWPGZMqRUXk2Wl8wanauL9oVfxwRDKQ4l
 SuG0YOJHJR5DVwTJqdbzmpyFrQ6/0c3WRdCx+mkVUQrT/ehVZu7QRis3myfw7F02
 u7KyjXfCDlWE3H+aJIAadwF2YF11/plJY76ScbIZP7bhOCyiXOdRhB3zjY+Cj7Zw
 ciNzWKq9BukyHTVYYao1yDaG/egp6akurEhBjX38dlJogcF+fWCNAmJql27PWzXY
 r2daUmnXjTERtSC1q5Sqc4LBislelLnk+mseyYQfXcWxkS+B8aWzZ/pr9odhB23a
 b/bUywY2lQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegthe11-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 14:34:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GEJcPt023123;
 Thu, 16 Jul 2026 14:34:04 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgn7aj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 14:34:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GEY3gj28246576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 14:34:04 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B558658051;
 Thu, 16 Jul 2026 14:34:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08D225805F;
 Thu, 16 Jul 2026 14:34:03 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 14:34:02 +0000 (GMT)
Message-ID: <be1038c303b7853d4ded6dccbb2966579e302dad.camel@linux.ibm.com>
Subject: Re: [PATCH 15/29] hw/gpio: pca9554: add PCA9536 support
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
Date: Thu, 16 Jul 2026 09:34:02 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-15-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
 <20260709-catalina-upgrade-v1-15-82a63fead90c@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: kixry7tr-YgJVQIUtlgRa45C1AjoCKnh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0NiBTYWx0ZWRfX86X7q0P43lGf
 5cZseznkQz0lBLioQ27y8nN4vykDyw1JCHjCLklQIh6xYj+Beie5xeCoBbw1Voa+aBrVYIVCjgG
 /KKCCeA+J5ciTjshTHHbXRs6VJmP6dQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0NiBTYWx0ZWRfX6hroRf8twY5L
 /9Z2g/TG8AuWh3rQOC4FOlV41+BVTngSgr99hphv6Ya6Ywtl/lHNuTjvbl3pTSohyOR6ko8MF8+
 fJ4flGG0WUIzQLN3P0u4RqseO5wtiDRlf/Mz0lW0TbZEOWudk6fTK5myjMMhTeSBMtr0eXeiU9W
 4pDHZoo5bYouYlgMJneGDTUdXln/ugQ14z59fl+EiUzg/egSipkN/FV9ViYBXxXbz/xFWMUGrcd
 0VDVL0d7uZwgNMbaH75182Vf2igMhu9hGFc/hX05g8cRbzxc78jO+6nJyO/2lau2EBsECXbt0v/
 nSCF1FUeDnxjsnfHcxjiOwP+5Mbw1Uo+r2847Nbjv3EN2YJiUBk+L/5YUvWbspcqLTST5VzVmkH
 ZWbaleGRXAXEuhtqUdpUtEoBMbHp4H1kjCRJaalLFs9MZ3DsdmuU1oulur93QzWtC7DITC4BYfR
 DHMKULehkuL/PqORr4Q==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a58ebde cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=_vR5Y93OuTFTYSZ3G2sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: I08aZl10gi1YjBzSWNSLVhZusljANlJ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160146
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
> The PCA9536 is a 4-bit I/O expander that's register-compatible with the
> PCA9554 but only has 4 pins.  Rather than duplicating the whole driver,
> make the existing PCA9554 model parameterizable and register PCA9536 as
> a subtype.
> 
> Introduce a PCA9554Class with a pin_count property, and replace every
> hard-coded PCA9554_PIN_COUNT reference in the driver with the class
> value.  The reset function now computes the correct pin mask from
> pin_count instead of assuming 0xFF.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  hw/gpio/pca9554.c         | 79 +++++++++++++++++++++++++++++++----------------
>  include/hw/gpio/pca9554.h |  2 ++
>  2 files changed, 54 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index 8427e01e9b2..b44ec0d9991 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -24,6 +24,8 @@ struct PCA9554Class {
>      /*< private >*/
>      I2CSlaveClass parent_class;
>      /*< public >*/
> +
> +    uint8_t pin_count;
>  };
>  typedef struct PCA9554Class PCA9554Class;
>  
> @@ -37,12 +39,13 @@ static const char *pin_state[] = {"low", "high"};
>  
>  static void pca9554_update_pin_input(PCA9554State *s)
>  {
> +    PCA9554Class *pc = PCA9554_GET_CLASS(s);
>      int i;
>      uint8_t config = s->regs[PCA9554_CONFIG];
>      uint8_t output = s->regs[PCA9554_OUTPUT];
>      uint8_t internal_state = config | output;
>  
> -    for (i = 0; i < PCA9554_PIN_COUNT; i++) {
> +    for (i = 0; i < pc->pin_count; i++) {
>          uint8_t bit_mask = 1 << i;
>          uint8_t internal_pin_state = (internal_state >> i) & 0x1;
>          uint8_t old_value = s->regs[PCA9554_INPUT] & bit_mask;
> @@ -67,7 +70,7 @@ static void pca9554_update_pin_input(PCA9554State *s)
>              break;
>          }
>  
> -        /* update irq state only if pin state changed */
> +        /* drive the per-pin GPIO output only if the pin level changed */
>          new_value = s->regs[PCA9554_INPUT] & bit_mask;
>          if (new_value != old_value) {
>              if (new_value) {
> @@ -99,6 +102,12 @@ static uint8_t pca9554_read(PCA9554State *s, uint8_t reg)
>  
>  static void pca9554_write(PCA9554State *s, uint8_t reg, uint8_t data)
>  {
> +    PCA9554Class *pc = PCA9554_GET_CLASS(s);
> +    uint8_t pin_mask = (1 << pc->pin_count) - 1;
> +
> +    /* Variants narrower than 8 bits ignore the unimplemented upper pins. */
> +    data &= pin_mask;
> +
>      switch (reg) {
>      case PCA9554_OUTPUT:
>      case PCA9554_CONFIG:
> @@ -157,7 +166,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>          error_setg(errp, "%s: error reading %s", __func__, name);
>          return;
>      }
> -    if (pin < 0 || pin >= PCA9554_PIN_COUNT) {
> +    if (pin < 0 || pin >= PCA9554_GET_CLASS(s)->pin_count) {
>          error_setg(errp, "%s invalid pin %s", __func__, name);
>          return;
>      }
> @@ -184,7 +193,7 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>          error_setg(errp, "%s: error reading %s", __func__, name);
>          return;
>      }
> -    if (pin < 0 || pin >= PCA9554_PIN_COUNT) {
> +    if (pin < 0 || pin >= PCA9554_GET_CLASS(s)->pin_count) {
>          error_setg(errp, "%s invalid pin %s", __func__, name);
>          return;
>      }
> @@ -232,13 +241,15 @@ static const VMStateDescription pca9554_vmstate = {
>  static void pca9554_reset(DeviceState *dev)
>  {
>      PCA9554State *s = PCA9554(dev);
> +    PCA9554Class *pc = PCA9554_GET_CLASS(s);
> +    uint8_t pin_mask = (1 << pc->pin_count) - 1;
>  
> -    s->regs[PCA9554_INPUT] = 0xFF;
> -    s->regs[PCA9554_OUTPUT] = 0xFF;
> +    s->regs[PCA9554_INPUT] = pin_mask;
> +    s->regs[PCA9554_OUTPUT] = pin_mask;
>      s->regs[PCA9554_POLARITY] = 0x0; /* No pins are inverted */
> -    s->regs[PCA9554_CONFIG] = 0xFF; /* All pins are inputs */
> +    s->regs[PCA9554_CONFIG] = pin_mask; /* All pins are inputs */
>  
> -    memset(s->ext_state, PCA9554_PIN_HIZ, PCA9554_PIN_COUNT);
> +    memset(s->ext_state, PCA9554_PIN_HIZ, pc->pin_count);
>      pca9554_update_pin_input(s);
>  
>      s->pointer = 0x0;
> @@ -247,9 +258,10 @@ static void pca9554_reset(DeviceState *dev)
>  
>  static void pca9554_initfn(Object *obj)
>  {
> +    PCA9554Class *pc = PCA9554_GET_CLASS(obj);
>      int pin;
>  
> -    for (pin = 0; pin < PCA9554_PIN_COUNT; pin++) {
> +    for (pin = 0; pin < pc->pin_count; pin++) {
>          char *name;
>  
>          name = g_strdup_printf("pin%d", pin);
> @@ -269,23 +281,24 @@ static void pca9554_set_ext_state(PCA9554State *s, int pin, int level)
>  
>  static void pca9554_gpio_in_handler(void *opaque, int pin, int level)
>  {
> -
>      PCA9554State *s = PCA9554(opaque);
> +    PCA9554Class *pc = PCA9554_GET_CLASS(s);
>  
> -    assert((pin >= 0) && (pin < PCA9554_PIN_COUNT));
> +    assert((pin >= 0) && (pin < pc->pin_count));
>      pca9554_set_ext_state(s, pin, level);
>  }
>  
>  static void pca9554_realize(DeviceState *dev, Error **errp)
>  {
>      PCA9554State *s = PCA9554(dev);
> +    PCA9554Class *pc = PCA9554_GET_CLASS(s);
>  
>      if (!s->description) {
> -        s->description = g_strdup("pca9554");
> +        s->description = g_strdup(object_get_typename(OBJECT(dev)));
>      }
>  
> -    qdev_init_gpio_out(dev, s->gpio_out, PCA9554_PIN_COUNT);
> -    qdev_init_gpio_in(dev, pca9554_gpio_in_handler, PCA9554_PIN_COUNT);
> +    qdev_init_gpio_out(dev, s->gpio_out, pc->pin_count);
> +    qdev_init_gpio_in(dev, pca9554_gpio_in_handler, pc->pin_count);
>  }
>  
>  static const Property pca9554_properties[] = {
> @@ -296,6 +309,7 @@ static void pca9554_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    PCA9554Class *pc = PCA9554_CLASS(klass);
>  
>      k->event = pca9554_event;
>      k->recv = pca9554_recv;
> @@ -304,21 +318,32 @@ static void pca9554_class_init(ObjectClass *klass, const void *data)
>      device_class_set_legacy_reset(dc, pca9554_reset);
>      dc->vmsd = &pca9554_vmstate;
>      device_class_set_props(dc, pca9554_properties);
> +
> +    pc->pin_count = PCA9554_PIN_COUNT;
>  }
>  
> -static const TypeInfo pca9554_info = {
> -    .name          = TYPE_PCA9554,
> -    .parent        = TYPE_I2C_SLAVE,
> -    .instance_init = pca9554_initfn,
> -    .instance_size = sizeof(PCA9554State),
> -    .class_init    = pca9554_class_init,
> -    .class_size    = sizeof(PCA9554Class),
> -    .abstract      = false,
> -};
> -
> -static void pca9554_register_types(void)
> +static void pca9536_class_init(ObjectClass *klass, const void *data)
>  {
> -    type_register_static(&pca9554_info);
> +    PCA9554Class *pc = PCA9554_CLASS(klass);
> +
> +    pc->pin_count = PCA9536_PIN_COUNT;
>  }
>  
> -type_init(pca9554_register_types)
> +static const TypeInfo pca9554_types[] = {
> +    {
> +        .name          = TYPE_PCA9554,
> +        .parent        = TYPE_I2C_SLAVE,
> +        .instance_init = pca9554_initfn,
> +        .instance_size = sizeof(PCA9554State),
> +        .class_init    = pca9554_class_init,
> +        .class_size    = sizeof(PCA9554Class),
> +        .abstract      = false,
> +    },
> +    {
> +        .name          = TYPE_PCA9536,
> +        .parent        = TYPE_PCA9554,
> +        .class_init    = pca9536_class_init,
> +    }
> +};
> +
> +DEFINE_TYPES(pca9554_types);
> diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h
> index 54bfc4c4c7a..c09108e8b65 100644
> --- a/include/hw/gpio/pca9554.h
> +++ b/include/hw/gpio/pca9554.h
> @@ -12,12 +12,14 @@
>  #include "qom/object.h"
>  
>  #define TYPE_PCA9554 "pca9554"
> +#define TYPE_PCA9536 "pca9536"
>  typedef struct PCA9554State PCA9554State;
>  DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,
>                           TYPE_PCA9554)
>  
>  #define PCA9554_NR_REGS 4
>  #define PCA9554_PIN_COUNT 8
> +#define PCA9536_PIN_COUNT 4
>  
>  struct PCA9554State {
>      /*< private >*/
> 


