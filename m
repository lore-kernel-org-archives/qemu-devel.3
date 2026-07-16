Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB09C44519
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNKx-0001s4-TM; Thu, 16 Jul 2026 10:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkNKZ-0001VZ-0m; Thu, 16 Jul 2026 10:44:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkNKU-0008FU-Pe; Thu, 16 Jul 2026 10:44:54 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDg7QA3274753; Thu, 16 Jul 2026 14:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=J1AXwuAP+lEmu6HH3ZRrMpTCVHdEPFY4p0Bxkror56s=; b=MVKO/8fKM1PP
 1zxi3KjvP0bEuo635LvYPVQSqHdfI5Ibv/ETAo/GIYwrwxFEW/XgMxWUQ9/Yueh9
 8IUvTjz8x2SKfTrQ+5dHC9Zl5LoL7OsGXDNPxMw/H/UQe2PbxUtc3qln/uGDPevK
 SEA3R66ODg+CReyqu/U8JCwwKv13+v0iqeYiUlqvciF83DeKIjTNCvHzq2lJFYcH
 +fNs583KNqIcR2XtJDAHuHIdJ5sWpuSGfvur14t12sXExNKt3/jolIGh5PjPcvHa
 rrM/r1Phu5ycYagDAdTZTqjGY5XlurJIOHH4RklaacPKB5Rb6C3DzoIyGxn8jfHn
 CtFYuizovg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexx0m5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 14:44:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GEYbVu018776;
 Thu, 16 Jul 2026 14:44:31 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k5drb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 14:44:31 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GEhtFr29622806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 14:43:56 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE82F58055;
 Thu, 16 Jul 2026 14:44:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20DBE58043;
 Thu, 16 Jul 2026 14:44:30 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 14:44:30 +0000 (GMT)
Message-ID: <08c93a850880683c823a6538c05a148c691153ea.camel@linux.ibm.com>
Subject: Re: [PATCH 16/29] hw/gpio: pca9554: add hw-dir property honoring
 the configured pin direction
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
Date: Thu, 16 Jul 2026 09:44:29 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-16-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
 <20260709-catalina-upgrade-v1-16-82a63fead90c@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Jt4KFzAu8pFjsZMPi5e8mwV70qRlBEpm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE1MSBTYWx0ZWRfX+/IwSexquVTx
 G12PPYoszvx8Staqb4Fx96wCmliQ/uLoUNrl+/Um+sh4rXaI6m3C6iun45Ulq53Pf6MrklZm3/m
 XGsbS5yc/44nEmfrOcqBjSswieRDNRBYUYmgAF0z3GXu0gJLHZ1NhyU844xYPM8N6qXwPw+SG4D
 hdgwyKisq3z34OxXmyeFUCRz11DcJ+6EVatIkF5y9lXJ+yb0RZn6vVSYHf4SQh7FRdGXnZnP0s4
 KdVckbHiwItTivDo9I6kkyEGTgaQgp3iGNhuCDSHot/TPTCAmSRlWZ7JlqFgwAjvM/YCsI3T3am
 LTbe9r/l7YL8qAjLZ+MQpFJflk6gzvIQWzCIzvjeT1y8GbRcBhMkLC5pBLYIQgepi7yZZxMD8xv
 MLkKVPvV/Au8wLxSjPQN1q4pjPtDXEpUnSw3xS4MszLFt8Hh1uxyiKuRDnzDDQUQDK4HVsPZ1+X
 ucueuv4yrw8r/lQ/FUQ==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a58ee50 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=PFcBf_fgC1tEFRN3GowA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uxx_PXWtr-40O8pEbHfbP1Dx4kCmMD6H
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE1MSBTYWx0ZWRfX5BHMQD8mc6dA
 C4XUBMGUrF3xeQ4v05EfTNW1/Kx6WPWlptN7/UbiVqdo+ppsNCX+VoWGXA0FZqge/sWbRVBPHry
 Wm6LhhcEzWtd+Xri6cl339xLEQHUOJM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160151
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
> The pinN QOM accessors are meant to let external agents observe and
> stimulate the expander's pins, but their default behaviour does not
> match real hardware:
> 
>  - to "drive" a pin, set_pin writes the OUTPUT register and then clears
>    the pin's Configuration bit to force it into output mode. On a real
>    device the pin direction is owned solely by the host (programmed
>    through the Configuration register over I2C); an external agent can
>    neither flip a pin's direction nor impose a level on a pin the host
>    drives as an output -- the latter is a voltage conflict, not a legal
>    operation.
>  - get_pin returns a CONFIG|OUTPUT composite, i.e. the guest's intent,
>    rather than the level actually sampled on the pin.
> 
> The PCA9555 GPIO variant (hw/gpio/pca9552.c) already models this
> correctly and unconditionally: only input-configured pins can be driven
> from outside, and reads return the sampled INPUT register.
> 
> Add a "hw-dir" property to bring the pca9554 pin accessors in line with
> the hardware (and with the PCA9555 model), without changing the
> behaviour seen by existing users:
> 
>  - hw-dir=true: set_pin only drives pins the guest has configured as
>    inputs; a set on an output pin is refused with a LOG_UNIMP warning.
>    get_pin returns the sampled INPUT register.
>  - hw-dir=false (default): keeps the legacy, non-conformant behaviour
>    for backward compatibility.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  hw/gpio/pca9554.c         | 65 ++++++++++++++++++++++++++++++-----------------
>  include/hw/gpio/pca9554.h |  1 +
>  2 files changed, 43 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index b44ec0d999..ed38fe102b 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -154,6 +154,14 @@ static int pca9554_event(I2CSlave *i2c, enum i2c_event event)
>      return 0;
>  }
>  
> +static void pca9554_set_ext_state(PCA9554State *s, int pin, int level)
> +{
> +    if (s->ext_state[pin] != level) {
> +        s->ext_state[pin] = level;
> +        pca9554_update_pin_input(s);
> +    }
> +}
> +
>  static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>                              void *opaque, Error **errp)
>  {
> @@ -171,9 +179,13 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> -    state = pca9554_read(s, PCA9554_CONFIG);
> -    state |= pca9554_read(s, PCA9554_OUTPUT);
> -    state = (state >> pin) & 0x1;
> +    /*
> +     * Report the physical pin level. The input register is kept in sync by
> +     * pca9554_update_pin_input(): output pins mirror the OUTPUT register and
> +     * input pins reflect the externally driven (or pulled-up) level, so it
> +     * holds the wire level regardless of the configured direction.
> +     */
> +    state = (s->regs[PCA9554_INPUT] >> pin) & 0x1;
>      visit_type_str(v, name, (char **)&pin_state[state], errp);
>  }
>  
> @@ -208,20 +220,34 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> -    /* First, modify the output register bit */
> -    val = pca9554_read(s, PCA9554_OUTPUT);
> -    mask = 0x1 << pin;
> -    if (state == PCA9554_PIN_LOW) {
> -        val &= ~(mask);
> +    if (s->hw_dir) {
> +        /* Warn and ignore if the guest has configured this pin as output */
> +        if (!((s->regs[PCA9554_CONFIG] >> pin) & 0x1)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "%s: pin %d is configured as output, "
> +                          "ignoring external set\n",
> +                          s->description, pin);
> +            return;
> +        }
> +        /* Drive the external input level */
> +        pca9554_set_ext_state(s, pin, state != PCA9554_PIN_LOW);
>      } else {
> -        val |= mask;
> -    }
> -    pca9554_write(s, PCA9554_OUTPUT, val);
> +        /* Legacy behavior: force output mode and drive */
> +        /* First, modify the output register bit */
> +        val = pca9554_read(s, PCA9554_OUTPUT);
> +        mask = 0x1 << pin;
> +        if (state == PCA9554_PIN_LOW) {
> +            val &= ~(mask);
> +        } else {
> +            val |= mask;
> +        }
> +        pca9554_write(s, PCA9554_OUTPUT, val);
>  
> -    /* Then, clear the config register bit for output mode */
> -    val = pca9554_read(s, PCA9554_CONFIG);
> -    val &= ~mask;
> -    pca9554_write(s, PCA9554_CONFIG, val);
> +        /* Then, clear the config register bit for output mode */
> +        val = pca9554_read(s, PCA9554_CONFIG);
> +        val &= ~mask;
> +        pca9554_write(s, PCA9554_CONFIG, val);
> +    }
>  }
>  
>  static const VMStateDescription pca9554_vmstate = {
> @@ -271,14 +297,6 @@ static void pca9554_initfn(Object *obj)
>      }
>  }
>  
> -static void pca9554_set_ext_state(PCA9554State *s, int pin, int level)
> -{
> -    if (s->ext_state[pin] != level) {
> -        s->ext_state[pin] = level;
> -        pca9554_update_pin_input(s);
> -    }
> -}
> -
>  static void pca9554_gpio_in_handler(void *opaque, int pin, int level)
>  {
>      PCA9554State *s = PCA9554(opaque);
> @@ -303,6 +321,7 @@ static void pca9554_realize(DeviceState *dev, Error **errp)
>  
>  static const Property pca9554_properties[] = {
>      DEFINE_PROP_STRING("description", PCA9554State, description),
> +    DEFINE_PROP_BOOL("hw-dir", PCA9554State, hw_dir, false),
>  };
>  
>  static void pca9554_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h
> index c09108e8b6..ac835371aa 100644
> --- a/include/hw/gpio/pca9554.h
> +++ b/include/hw/gpio/pca9554.h
> @@ -33,6 +33,7 @@ struct PCA9554State {
>      qemu_irq gpio_out[PCA9554_PIN_COUNT];
>      uint8_t ext_state[PCA9554_PIN_COUNT];
>      char *description; /* For debugging purpose only */
> +    bool hw_dir; /* Honor pin direction */
>  };
>  
>  #endif
> 


