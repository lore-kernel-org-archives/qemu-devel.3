Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5964EC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMTi-0005Fd-V2; Thu, 16 Jul 2026 09:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkMTh-0005FB-47; Thu, 16 Jul 2026 09:50:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkMTf-00083S-DM; Thu, 16 Jul 2026 09:50:16 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDfidG3284432; Thu, 16 Jul 2026 13:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=OjZ/DlJiMjCCxcUxxmy0oGHjNj4kiQ78E1W+8f8sj8s=; b=XRVrUQKKaZ2J
 Q+5lWLP2bg+4CUiwSvgAzdLg8cyB9VhicrTP7HrgYklsPfyIX6OGyz/OSjYyRb9t
 uKA+Jiy9eOFlsqTgatM86maEldZsqXrqRtQ54k/MOWdGpqpytgV5Ywsp9yb3/I6j
 m/DUBRmFv81mStm5sytstaSogKkVzlSU5cFWBl7hwneqUeraSeSqcIR8l+Lg8WZy
 1+xpHS1+Q7P4MOy6RRYtw6ZKd85c2ZSYQlKtLKDfcOOYGYduz3J+2CgXN9GlFaFO
 NKxpOq40TcnicvcOOj8DgIh4tHtYXRaGmkKMcGLy5o9bitHPgDgr/MOGqL+fDzEV
 Jo5DjwxXCA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2agdge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 13:49:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GDnrEf021402;
 Thu, 16 Jul 2026 13:49:57 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhn5pf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 13:49:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GDnMau27591228
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 13:49:22 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F243A5805B;
 Thu, 16 Jul 2026 13:49:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A13F55805E;
 Thu, 16 Jul 2026 13:49:55 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 13:49:55 +0000 (GMT)
Message-ID: <cf6167754880e48fe8e034f0885a243355695211.camel@linux.ibm.com>
Subject: Re: [PATCH 09/29] hw/gpio: pca9552: expose GPIO pins as pin%d QOM
 properties
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
Date: Thu, 16 Jul 2026 08:49:55 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-9-814575bc076b@free.fr>
References: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
 <20260709-catalina-upgrade-v1-9-814575bc076b@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0MSBTYWx0ZWRfX6lU67jUU9Qrm
 pmwa+d3kJSiztXNoGiKRXtlFnxYgJxEGzWwdT84Hd/XgRX2/7NZAZRWnfxLBb0X26P48KkvZZEx
 3vUWjB/TWBly2+fDcHLDsEpwsqpD1K4=
X-Proofpoint-GUID: sEjAgBnlFcTk_4AfuEXK0AQJlHVkUXOA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0MSBTYWx0ZWRfX2LM/LdxuWlww
 S7vZQmXF0pxqUyeZ7B4veC2Zz/IIILf74Eqt0XDJFTkMwxn2IzecucOxSy0X/z4FqQ+Wy+ZcK7q
 /q2Yo3AF6DXGf/u+b57UGRJX/BL2xzZUbirsv/qLCHiXs7nQDCczztrL7JNMDgxUTTBowbCioz5
 c1cziBKrBzE5RMWjPB1XchlJJbduLvETgIDNWvh3R8dydooJjjI/thDrSvIrDkywmZhl21K1OnB
 g2ZZuJLlBMhPc2EL05HCpcikGZbWc5wEGfKq+Y8nzAVEQDJ/cofEsJZiOIm0mRz11oRoO7OhyTv
 Kqwe/4xtZVHnAhpuNtshmb75/8RbZF6ioKnDTw7FTXv/huExX+KKBDGeDoqQCQlSZA9tGgWDX+P
 /jKHyakgePAYsQaBOqzC9EwD1btGNHHrMuMAFbaLNtlOoa3MsY+hf3QKP+BMBHcAHxfKGCcpXH/
 TXg3Xym3ZyzRO7G/22Q==
X-Proofpoint-ORIG-GUID: kvQfBgWuX6C-p1jem8sF8ZSi4xQA4ucc
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a58e186 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=-OEWlCpV48v73FPsAqAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160141
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
> The PCA9552 exposes its LED channels as led%d QOM string properties, but
> the GPIO variants (PCA9535/PCA9555) inherited the same led%d interface,
> which drives the LED selector registers and is meaningless for a plain
> I/O expander.
> 
> Add pin%d string properties ("low"/"high") for the GPIO variants,
> mirroring the standalone pca9555 model:
> 
>   - reading returns the raw pin logic level from the INPUT register;
>   - writing drives the external input level, but only for pins the guest
>     has configured as inputs (writes to output pins are ignored with a
>     LOG_UNIMP message).
> 
> The LED variant keeps its led%d properties.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  hw/gpio/pca9552.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 86 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 54a5945d92..719149b717 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -68,6 +68,7 @@ struct PCA955xClass {
>  #define PCA9552_PIN_HIZ  0x1
>  
>  static const char *led_state[] = {"on", "off", "pwm0", "pwm1"};
> +static const char *pin_state[] = {"low", "high"};
>  
>  static uint8_t pca955x_pin_get_config(PCA955xState *s, int pin)
>  {
> @@ -428,6 +429,79 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
>      pca955x_write(s, reg, val);
>  }
>  
> +static void pca955x_set_ext_state(PCA955xState *s, int pin, int level);
> +
> +static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
> +                            void *opaque, Error **errp)
> +{
> +    PCA955xClass *k = PCA955X_GET_CLASS(obj);
> +    PCA955xState *s = PCA955X(obj);
> +    int pin, rc;
> +    uint8_t input_reg, state;
> +
> +    rc = sscanf(name, "pin%2d", &pin);
> +    if (rc != 1) {
> +        error_setg(errp, "%s: error reading %s", __func__, name);
> +        return;
> +    }
> +    if (pin < 0 || pin >= k->pin_count) {
> +        error_setg(errp, "%s invalid pin %s", __func__, name);
> +        return;
> +    }
> +
> +    /*
> +     * Report the raw pin logic level; polarity inversion is a read-time
> +     * transform applied to the INPUT register, not to the pin state itself.
> +     */
> +    input_reg = PCA9535_INPUT0 + (pin / 8);
> +    state = (s->regs[input_reg] >> (pin % 8)) & 0x1;
> +    visit_type_str(v, name, (char **)&pin_state[state], errp);
> +}
> +
> +static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
> +                            void *opaque, Error **errp)
> +{
> +    PCA955xClass *k = PCA955X_GET_CLASS(obj);
> +    PCA955xState *s = PCA955X(obj);
> +    int pin, rc;
> +    uint8_t state, config_reg;
> +    g_autofree char *state_str = NULL;
> +
> +    if (!visit_type_str(v, name, &state_str, errp)) {
> +        return;
> +    }
> +    rc = sscanf(name, "pin%2d", &pin);
> +    if (rc != 1) {
> +        error_setg(errp, "%s: error reading %s", __func__, name);
> +        return;
> +    }
> +    if (pin < 0 || pin >= k->pin_count) {
> +        error_setg(errp, "%s invalid pin %s", __func__, name);
> +        return;
> +    }
> +
> +    for (state = 0; state < ARRAY_SIZE(pin_state); state++) {
> +        if (!strcmp(state_str, pin_state[state])) {
> +            break;
> +        }
> +    }
> +    if (state >= ARRAY_SIZE(pin_state)) {
> +        error_setg(errp, "%s invalid pin state %s", __func__, state_str);
> +        return;
> +    }
> +
> +    /* Only input-configured pins can be driven by an external device. */
> +    config_reg = PCA9535_CONFIG0 + (pin / 8);
> +    if (!((s->regs[config_reg] >> (pin % 8)) & 0x1)) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: pin %d is configured as output, ignoring set\n",
> +                      s->description, pin);
> +        return;
> +    }
> +
> +    pca955x_set_ext_state(s, pin, state != PCA9552_PIN_LOW);
> +}
> +
>  static const VMStateDescription pca9552_vmstate = {
>      .name = "PCA9552",
>      .version_id = 0,
> @@ -485,15 +559,22 @@ static void pca9535_reset_hold(Object *obj, ResetType type)
>  static void pca955x_initfn(Object *obj)
>  {
>      PCA955xClass *k = PCA955X_GET_CLASS(obj);
> -    int led;
>  
>      assert(k->pin_count <= PCA955X_PIN_COUNT_MAX);
> -    for (led = 0; led < k->pin_count; led++) {
> +    for (int ix = 0; ix < k->pin_count; ix++) {
>          char *name;
>  
> -        name = g_strdup_printf("led%d", led);
> -        object_property_add(obj, name, "bool", pca955x_get_led, pca955x_set_led,
> -                            NULL, NULL);
> +        if (k->has_led_support) {
> +            /* LED variant: expose the LED selector state as led%d. */
> +            name = g_strdup_printf("led%d", ix);
> +            object_property_add(obj, name, "bool",
> +                                pca955x_get_led, pca955x_set_led, NULL, NULL);
> +        } else {
> +            /* GPIO variant: expose the pin logic level as pin%d. */
> +            name = g_strdup_printf("pin%d", ix);
> +            object_property_add(obj, name, "str",
> +                                pca955x_get_pin, pca955x_set_pin, NULL, NULL);
> +        }
>          g_free(name);
>      }
>  }
> 


