Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE2BD44C7E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 16:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgQMP-000062-Pu; Thu, 15 Jan 2026 11:38:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vgQMO-00004x-0E
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:38:12 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vgQMM-0000tM-5T
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:38:11 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-50299648ae9so414481cf.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 08:38:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768495089; cv=none;
 d=google.com; s=arc-20240605;
 b=L70GaeX/U8HShlXPLuEYISGSnfMcvDPjIZFyJh0KjerdssM9lDuPu2Z0cZ/Po4XnEJ
 vBqQg2mvjzjEN7AwHxWG/+X4ofKzodpLx0Cv05/QUcKr5SQN7b9FpDqd0ONKrzw9BjO1
 002dRxRrWKvt0eM3w+oHoLwSeb36B8i+teQYPoGO7HdANGcqeLJhNEYuxRhAK+MDR4QF
 SSuP2TG5z4MwEwBJ4FekpwmLa1mZsJnMlphLoRyGhnVPPydd9Mf6iC7RsiNxWVfa8g68
 nSBOurrH6tPZul3lllmVmQOIMfHT6/fHY/rdfD+6bRs6G1hJOB2VZ4CZzZFg/uRV2XQs
 e7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LvyPzMCTX8GI9pmwQoVY5STxB1JRn9F4OKPHINN02ic=;
 fh=Rnmw7nBshWv3WKoPj2/vZqqoLGelht69j3ZmU6yLknU=;
 b=DlxxbtA/C+lb6QVHltQII4UYMv7HoYtdHyM9FTjaDah9G71B85jP2zdYTOs2FZuSgs
 xILT5xsYMkcVudDLskl1NtzBr0yGBHESSgZ/j3c3CB6doxMJCK7pEmEqmhYTWyvesHRc
 ZZxXPP+5Iu250z3aXO6h9ELN7ilCPKHBFhTi+SmRLMWJDDKabCMoC/BwZi5/HnD0ev06
 F0sBNb336fG9TTTzztc/rUBfhCjpbuLi2Nc9yOO7SyjfCa7OqgF40ZxrxlT8hjkSZOh0
 DOR2knAoNjMwzXA/odHurIzocp1uVvpZuCjGPlUEGh+qlbFNbQ3F/ckiOfeY6OIaVaAF
 lBYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1768495089; x=1769099889; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LvyPzMCTX8GI9pmwQoVY5STxB1JRn9F4OKPHINN02ic=;
 b=Cyc/KMfG56tESsxUqAsbubPZ++SMdYDsn6pTsIii8fsZzsVmp+IAKX5aIeN5x9fcGe
 6QkqNK4lwR4UWD6ROaPrAwJMrSid/6hD1bIncI9dsVfp9IKnOszDb4a/IdDoTt59JRQl
 wUb2Ck+Eoqqpj7zVViec26wAAZxWWCVCWpoxDWL1WNwmCbp8J4zoJTdceL1XQpBC3Da3
 zX5rlenVOHaAX3hVKd6sHUif3gpr2c+SXvvj8FRJD6nmXfdxzDhTI6df8yWS0KIKJ8Dz
 8XbGqCdHndtD4Fp1HmLPJesDuh3cy2hEgWp4bPf7WkbAjUgdixzUxx5c9o0YeT8xLwco
 IlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768495089; x=1769099889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LvyPzMCTX8GI9pmwQoVY5STxB1JRn9F4OKPHINN02ic=;
 b=X86yT+p8U682Eyn38Wd4TraGw17wODdNmyIe0ssbfP6OBC+olsWfhsQAOmvqI3GHxy
 AsgCNblO84t4esp3L2wLO/83Vc29XESETufayX8nmH1aiUc33c4Bgaz9nQbowODOUPb3
 EHkvO+6wYDD57/Q3TRnBBi1YAkz+Wua+yVKCN8EBlxOyTjXbUNwgQZmZx+YlnaZPt0Tk
 8Vk0cFeWfBcF4ngLNlRrM4nTsO+FCkDIyzsU6w9mj5Y8Q8FmiDaG2VgiyqMGjLLQjVQ8
 WmcjX26tczVDWd1HkgUmNMheuIG9UCD/+DzkvYThbHjsSmnbDVwUN1KpAe7KifB5LDiY
 8ipA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxRiXcFFjBQF2FyBnyFFObBCblT/68nZAIlt3FbVLBVKS7Ut/HEUK0HK3Zzg8hcC8X3/mlTP7Rba1V@nongnu.org
X-Gm-Message-State: AOJu0Yyyv21lhS9ORysjwHNRrjKNKg02AXfO9A+dreQj9GSjl1gbQniQ
 xBSC2+g9A/OFjQ5VgVl76OvHYeiVzDrO76cqrVoxXOrWoWYFrB7Uw0qxAVZjDc8K7LbimF0zBWU
 uSbfVAKKvpWmFM8M8sVp2wzNX8QROgWa/R3eexNJN
X-Gm-Gg: AY/fxX7EWd2/UsVooCE2XY9zM5XYbhDD9MOLIDjbAyJwosFmSd7a6aPAnmmh/2TgyEx
 8hVC9m2Lv9s3BlWCRK0x7Aqk3ZiVH2RCM94ukoiqquw60asoota1Y2xAOoCxh8UpxESDrWBeErU
 sgma0LrScQMyPx/5VkkdGRnRWTGluor7njAQ+3Tyo20v9hSKUFRrJ5Ct5DeaFBFIte94AP2g6yJ
 oXju37NENvrKvKNToaRBjTErOov765tDRN/pMyWpnEVfx05DZRdxJrMeYUsBf0Si+Cvy4PzDpgl
 QZuF8jHK8tBxWh+DpS0T94IWQw==
X-Received: by 2002:a05:622a:120d:b0:4f3:54eb:f26e with SMTP id
 d75a77b69052e-5026ecd7aeamr9096671cf.1.1768495088291; Thu, 15 Jan 2026
 08:38:08 -0800 (PST)
MIME-Version: 1.0
References: <20260112083054.4151945-1-kane_chen@aspeedtech.com>
 <20260112083054.4151945-2-kane_chen@aspeedtech.com>
 <CA+QoejXKnT6iNuyAS3rDg3ovYbAyBf5crPrw9kYGm73Uk0S1uw@mail.gmail.com>
 <8b0f766b-6afc-4eba-836e-08edc9e09e48@kaod.org>
In-Reply-To: <8b0f766b-6afc-4eba-836e-08edc9e09e48@kaod.org>
From: Nabih Estefan <nabihestefan@google.com>
Date: Thu, 15 Jan 2026 08:37:56 -0800
X-Gm-Features: AZwV_QisDOnTP6zfeueP4657hmI2bt36Iz1ZXTE0Nmv2Q8JzK7qwbb0Lm9WuMGI
Message-ID: <CA+QoejVy1THSGD=e8ZwyRTeCP-g-c5B2v+VhBAZu1HqB4Htw1A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] hw/i2c/aspeed: Introduce 'bus-label' to customize
 bus naming
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed, Jan 14, 2026 at 11:18=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.or=
g> wrote:
>
> Hello Nabih,
>
> On 1/15/26 00:11, Nabih Estefan wrote:
> > On Mon, Jan 12, 2026 at 12:38=E2=80=AFAM Kane Chen via qemu development
> > <qemu-devel@nongnu.org> wrote:
> >>
> >> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> >>
> >> On some Aspeed-based machines, multiple I2C controllers may exist
> >> across different components, such as the primary SoC and an external
> >> IO expander or co-processor (e.g., AST1700). Using the current static
> >> naming convention results in object name conflicts when multiple
> >> controllers attempt to instantiate buses with the same ID.
> >>
> >> This patch introduces a 'bus-label' property for the Aspeed I2C
> >> controller. This allows higher-level layers, such as the SoC realize
> >> function, to provide a unique identifier for the buses. The I2C bus
> >> object name is then constructed using this label (e.g., "ioexp0.0"
> >> instead of the default "aspeed.i2c.bus.0").
> >>
> >> This enhancement ensures unique bus identifiers across the system and
> >> resolves naming conflicts in multi-controller configurations.
> >>
> >> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> >
>
>
> Did you mean 'Reviewed-by' ?
>
> Thanks,
>
> C.
>

Yes, taht is absolutely what I meant. sorry about that.

Reviewed-by: Nabih Estefan <nabihestefan@google.com>

>
> > Tested-by: Nabih Estefan <nabihestefan@google.com>
> >
> > This is basically a rework of the bus-label patches I already tested
> > and we're carrying for AST1700, re-tested just in case, and everything
> > still looks good!
> >
> > Thank you Kane!
> >
> > -Nabih
> >
> >> ---
> >>   include/hw/i2c/aspeed_i2c.h |  2 ++
> >>   hw/i2c/aspeed_i2c.c         | 27 +++++++++++++++++++++------
> >>   2 files changed, 23 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> >> index ffcff2580f..68bd138026 100644
> >> --- a/include/hw/i2c/aspeed_i2c.h
> >> +++ b/include/hw/i2c/aspeed_i2c.h
> >> @@ -252,6 +252,7 @@ struct AspeedI2CBus {
> >>       MemoryRegion mr_pool;
> >>
> >>       I2CBus *bus;
> >> +    char *name;
> >>       uint8_t id;
> >>       qemu_irq irq;
> >>
> >> @@ -269,6 +270,7 @@ struct AspeedI2CState {
> >>       uint32_t intr_status;
> >>       uint32_t ctrl_global;
> >>       uint32_t new_clk_divider;
> >> +    char *bus_label;
> >>       MemoryRegion pool_iomem;
> >>       uint8_t share_pool[ASPEED_I2C_SHARE_POOL_SIZE];
> >>
> >> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> >> index 1b8ac561c3..7cf92423c7 100644
> >> --- a/hw/i2c/aspeed_i2c.c
> >> +++ b/hw/i2c/aspeed_i2c.c
> >> @@ -1215,9 +1215,16 @@ static void aspeed_i2c_realize(DeviceState *dev=
, Error **errp)
> >>                             "aspeed.i2c", aic->mem_size);
> >>       sysbus_init_mmio(sbd, &s->iomem);
> >>
> >> +    /* default value */
> >> +    if (!s->bus_label) {
> >> +        s->bus_label =3D g_strdup(TYPE_ASPEED_I2C_BUS);
> >> +    }
> >> +
> >>       for (i =3D 0; i < aic->num_busses; i++) {
> >>           Object *bus =3D OBJECT(&s->busses[i]);
> >>           int offset =3D i < aic->gap ? 1 : 5;
> >> +        g_autofree char *name =3D g_strdup_printf("%s.%d",
> >> +                                                s->bus_label, i);
> >>
> >>           if (!object_property_set_link(bus, "controller", OBJECT(s), =
errp)) {
> >>               return;
> >> @@ -1227,6 +1234,10 @@ static void aspeed_i2c_realize(DeviceState *dev=
, Error **errp)
> >>               return;
> >>           }
> >>
> >> +        if (!object_property_set_str(bus, "bus-name", name, errp)) {
> >> +            return;
> >> +        }
> >> +
> >>           if (!sysbus_realize(SYS_BUS_DEVICE(bus), errp)) {
> >>               return;
> >>           }
> >> @@ -1263,6 +1274,7 @@ static void aspeed_i2c_realize(DeviceState *dev,=
 Error **errp)
> >>   static const Property aspeed_i2c_properties[] =3D {
> >>       DEFINE_PROP_LINK("dram", AspeedI2CState, dram_mr,
> >>                        TYPE_MEMORY_REGION, MemoryRegion *),
> >> +    DEFINE_PROP_STRING("bus-label", AspeedI2CState, bus_label),
> >>   };
> >>
> >>   static void aspeed_i2c_class_init(ObjectClass *klass, const void *da=
ta)
> >> @@ -1423,24 +1435,26 @@ static void aspeed_i2c_bus_realize(DeviceState=
 *dev, Error **errp)
> >>   {
> >>       AspeedI2CBus *s =3D ASPEED_I2C_BUS(dev);
> >>       AspeedI2CClass *aic;
> >> -    g_autofree char *name =3D g_strdup_printf(TYPE_ASPEED_I2C_BUS ".%=
d", s->id);
> >> -    g_autofree char *pool_name =3D g_strdup_printf("%s.pool", name);
> >> +    g_autofree char *pool_name =3D NULL;
> >>
> >> -    if (!s->controller) {
> >> -        error_setg(errp, TYPE_ASPEED_I2C_BUS ": 'controller' link not=
 set");
> >> +    if (!s->controller || !s->name) {
> >> +        error_setg(errp, TYPE_ASPEED_I2C_BUS
> >> +                   ": 'controller' or 'bus-name' not set");
> >>           return;
> >>       }
> >>
> >> +    pool_name =3D g_strdup_printf("%s.pool", s->name);
> >> +
> >>       aic =3D ASPEED_I2C_GET_CLASS(s->controller);
> >>
> >>       sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
> >>
> >> -    s->bus =3D i2c_init_bus(dev, name);
> >> +    s->bus =3D i2c_init_bus(dev, s->name);
> >>       s->slave =3D i2c_slave_create_simple(s->bus, TYPE_ASPEED_I2C_BUS=
_SLAVE,
> >>                                          0xff);
> >>
> >>       memory_region_init_io(&s->mr, OBJECT(s), &aspeed_i2c_bus_ops,
> >> -                          s, name, aic->reg_size);
> >> +                          s, s->name, aic->reg_size);
> >>       sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
> >>
> >>       memory_region_init_io(&s->mr_pool, OBJECT(s), &aspeed_i2c_bus_po=
ol_ops,
> >> @@ -1452,6 +1466,7 @@ static const Property aspeed_i2c_bus_properties[=
] =3D {
> >>       DEFINE_PROP_UINT8("bus-id", AspeedI2CBus, id, 0),
> >>       DEFINE_PROP_LINK("controller", AspeedI2CBus, controller, TYPE_AS=
PEED_I2C,
> >>                        AspeedI2CState *),
> >> +    DEFINE_PROP_STRING("bus-name", AspeedI2CBus, name),
> >>   };
> >>
> >>   static void aspeed_i2c_bus_class_init(ObjectClass *klass, const void=
 *data)
> >> --
> >> 2.43.0
> >>
> >>
>

