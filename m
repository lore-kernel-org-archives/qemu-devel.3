Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC929606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XuaxBWts
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQMYn-0002ma-7Z; Mon, 09 Nov 2026 05:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xQMYk-0002m4-MP
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 05:25:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xQMYi-0001wC-K4
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 05:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794219903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BZ/FKY7orf9E3UkMV9wuLZh0UZYjBNrO1SeCCD5rRKs=;
 b=XuaxBWtsJ+H9LX6Y4lxGh8HAY7HQKkT2PYfH0oNMp2j9S5mR6+B7bcOvCmnG+2heZ2uxbU
 99zS3/ZZe23RhnEyNeds19yBa+wUxw8xjVUpHgqCabAx8Fc62U2sJH4nXZyJ61UnTk9khO
 VA6j9bg4qoWi7bqKDvS5BH2+jZaRPmA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-eFX_bU0hP3--12oTPPjR7g-1; Mon,
 09 Nov 2026 05:25:02 -0500
X-MC-Unique: eFX_bU0hP3--12oTPPjR7g-1
X-Mimecast-MFC-AGG-ID: eFX_bU0hP3--12oTPPjR7g_1794219901
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B42CC1800350; Mon,  9 Nov 2026 10:25:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DDA4195608B; Mon,  9 Nov 2026 10:25:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF12721E6A04; Mon, 09 Nov 2026 11:24:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com,
 milesg@linux.ibm.com,  qemu-ppc@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH 4/8] hw/gpio/pca9554: New abstract base "pca9554-base"
In-Reply-To: <463635be-2321-49e6-852d-080aa00ce40d@nutanix.com> (Mark
 Cave-Ayland's message of "Mon, 9 Nov 2026 09:02:38 +0000")
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-5-armbru@redhat.com>
 <463635be-2321-49e6-852d-080aa00ce40d@nutanix.com>
Date: Mon, 09 Nov 2026 11:24:57 +0100
Message-ID: <87ld725mkm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:

> On 06/11/2026 11:04, Markus Armbruster wrote:
>
>> Commit 5eceb48bbe86 (hw/gpio: pca9554: add PCA9536 support) made type
>> "pca9535" a child of concrete type "pca9555".  This is inconvenient
>> for the next commit.  Make them both children of new abstract type
>> "pca9554-base".
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/hw/gpio/pca9554.h |  1 +
>>  hw/gpio/pca9554.c         | 55 +++++++++++++++++++++++----------------
>>  2 files changed, 33 insertions(+), 23 deletions(-)
>> 
>> diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h
>> index 1b33a8a752..0d841ff017 100644
>> --- a/include/hw/gpio/pca9554.h
>> +++ b/include/hw/gpio/pca9554.h
>> @@ -8,6 +8,7 @@
>>  #ifndef PCA9554_H
>>  #define PCA9554_H
>>  
>> +#define TYPE_PCA9554_BASE "pca9554-base"
>>  #define TYPE_PCA9554 "pca9554"
>>  #define TYPE_PCA9536 "pca9536"
>>  
>> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
>> index caa73f63c9..1362b605c2 100644
>> --- a/hw/gpio/pca9554.c
>> +++ b/hw/gpio/pca9554.c
>> @@ -26,7 +26,7 @@
>>  #define PCA9554_PIN_COUNT 8
>>  #define PCA9536_PIN_COUNT 4
>>  
>> -OBJECT_DECLARE_TYPE(PCA9554State, PCA9554Class, PCA9554)
>> +OBJECT_DECLARE_TYPE(PCA9554State, PCA9554Class, PCA9554_BASE)
>>  
>>  struct PCA9554State {
>>      /*< private >*/
>> @@ -58,7 +58,7 @@ static const char *pin_state[] = {"low", "high"};
>>  
>>  static void pca9554_update_pin_input(PCA9554State *s)
>>  {
>> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
>> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>>      int i;
>>      uint8_t config = s->regs[PCA9554_CONFIG];
>>      uint8_t output = s->regs[PCA9554_OUTPUT];
>> @@ -110,7 +110,7 @@ static uint8_t pca9554_read(PCA9554State *s, uint8_t reg)
>>  
>>  static void pca9554_write(PCA9554State *s, uint8_t reg, uint8_t data)
>>  {
>> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
>> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>>      uint8_t pin_mask = (1 << pc->pin_count) - 1;
>>  
>>      /* Variants narrower than 8 bits ignore the unimplemented upper pins. */
>> @@ -134,14 +134,14 @@ static void pca9554_write(PCA9554State *s, uint8_t reg, uint8_t data)
>>  
>>  static uint8_t pca9554_recv(I2CSlave *i2c)
>>  {
>> -    PCA9554State *s = PCA9554(i2c);
>> +    PCA9554State *s = PCA9554_BASE(i2c);
>>  
>>      return pca9554_read(s, s->pointer & 0x3);
>>  }
>>  
>>  static int pca9554_send(I2CSlave *i2c, uint8_t data)
>>  {
>> -    PCA9554State *s = PCA9554(i2c);
>> +    PCA9554State *s = PCA9554_BASE(i2c);
>>  
>>      /* First byte sent by is the register address */
>>      if (s->len == 0) {
>> @@ -156,7 +156,7 @@ static int pca9554_send(I2CSlave *i2c, uint8_t data)
>>  
>>  static int pca9554_event(I2CSlave *i2c, enum i2c_event event)
>>  {
>> -    PCA9554State *s = PCA9554(i2c);
>> +    PCA9554State *s = PCA9554_BASE(i2c);
>>  
>>      s->len = 0;
>>      return 0;
>> @@ -173,7 +173,7 @@ static void pca9554_set_ext_state(PCA9554State *s, int pin, int level)
>>  static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>>                              void *opaque, Error **errp)
>>  {
>> -    PCA9554State *s = PCA9554(obj);
>> +    PCA9554State *s = PCA9554_BASE(obj);
>>      int pin, rc;
>>      uint8_t state;
>>  
>> @@ -182,7 +182,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>>          error_setg(errp, "%s: error reading %s", __func__, name);
>>          return;
>>      }
>> -    if (pin < 0 || pin >= PCA9554_GET_CLASS(s)->pin_count) {
>> +    if (pin < 0 || pin >= PCA9554_BASE_GET_CLASS(s)->pin_count) {
>>          error_setg(errp, "%s invalid pin %s", __func__, name);
>>          return;
>>      }
>> @@ -200,7 +200,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>>  static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>>                              void *opaque, Error **errp)
>>  {
>> -    PCA9554State *s = PCA9554(obj);
>> +    PCA9554State *s = PCA9554_BASE(obj);
>>      int pin, rc, val;
>>      uint8_t state, mask;
>>      g_autofree char *state_str = NULL;
>> @@ -213,7 +213,7 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>>          error_setg(errp, "%s: error reading %s", __func__, name);
>>          return;
>>      }
>> -    if (pin < 0 || pin >= PCA9554_GET_CLASS(s)->pin_count) {
>> +    if (pin < 0 || pin >= PCA9554_BASE_GET_CLASS(s)->pin_count) {
>>          error_setg(errp, "%s invalid pin %s", __func__, name);
>>          return;
>>      }
>> @@ -274,8 +274,8 @@ static const VMStateDescription pca9554_vmstate = {
>>  
>>  static void pca9554_reset(DeviceState *dev)
>>  {
>> -    PCA9554State *s = PCA9554(dev);
>> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
>> +    PCA9554State *s = PCA9554_BASE(dev);
>> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>>      uint8_t pin_mask = (1 << pc->pin_count) - 1;
>>  
>>      s->regs[PCA9554_INPUT] = pin_mask;
>> @@ -292,7 +292,7 @@ static void pca9554_reset(DeviceState *dev)
>>  
>>  static void pca9554_initfn(Object *obj)
>>  {
>> -    PCA9554Class *pc = PCA9554_GET_CLASS(obj);
>> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(obj);
>>      int pin;
>>  
>>      for (pin = 0; pin < pc->pin_count; pin++) {
>> @@ -308,8 +308,8 @@ static void pca9554_initfn(Object *obj)
>>  
>>  static void pca9554_gpio_in_handler(void *opaque, int pin, int level)
>>  {
>> -    PCA9554State *s = PCA9554(opaque);
>> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
>> +    PCA9554State *s = PCA9554_BASE(opaque);
>> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>>  
>>      assert((pin >= 0) && (pin < pc->pin_count));
>>      pca9554_set_ext_state(s, pin, level);
>> @@ -317,8 +317,8 @@ static void pca9554_gpio_in_handler(void *opaque, int pin, int level)
>>  
>>  static void pca9554_realize(DeviceState *dev, Error **errp)
>>  {
>> -    PCA9554State *s = PCA9554(dev);
>> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
>> +    PCA9554State *s = PCA9554_BASE(dev);
>> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>>  
>>      if (!s->description) {
>>          s->description = g_strdup(object_get_typename(OBJECT(dev)));
>> @@ -333,11 +333,10 @@ static const Property pca9554_properties[] = {
>>      DEFINE_PROP_BOOL("hw-dir", PCA9554State, hw_dir, false),
>>  };
>>  
>> -static void pca9554_class_init(ObjectClass *klass, const void *data)
>> +static void pca9554_base_class_init(ObjectClass *klass, const void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>>      I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
>> -    PCA9554Class *pc = PCA9554_CLASS(klass);
>>  
>>      k->event = pca9554_event;
>>      k->recv = pca9554_recv;
>> @@ -346,26 +345,36 @@ static void pca9554_class_init(ObjectClass *klass, const void *data)
>>      device_class_set_legacy_reset(dc, pca9554_reset);
>>      dc->vmsd = &pca9554_vmstate;
>>      device_class_set_props(dc, pca9554_properties);
>> +}
>> +
>> +static void pca9554_class_init(ObjectClass *klass, const void *data)
>> +{
>> +    PCA9554Class *pc = PCA9554_BASE_CLASS(klass);
>>  
>>      pc->pin_count = PCA9554_PIN_COUNT;
>>  }
>>  
>>  static void pca9536_class_init(ObjectClass *klass, const void *data)
>>  {
>> -    PCA9554Class *pc = PCA9554_CLASS(klass);
>> +    PCA9554Class *pc = PCA9554_BASE_CLASS(klass);
>>  
>>      pc->pin_count = PCA9536_PIN_COUNT;
>>  }
>>  
>>  static const TypeInfo pca9554_types[] = {
>>      {
>> -        .name          = TYPE_PCA9554,
>> +        .name          = TYPE_PCA9554_BASE,
>>          .parent        = TYPE_I2C_SLAVE,
>>          .instance_init = pca9554_initfn,
>>          .instance_size = sizeof(PCA9554State),
>> -        .class_init    = pca9554_class_init,
>> +        .class_init    = pca9554_base_class_init,
>>          .class_size    = sizeof(PCA9554Class),
>> -        .abstract      = false,
>> +        .abstract      = true,
>> +    },
>> +    {
>> +        .name          = TYPE_PCA9554,
>> +        .parent        = TYPE_PCA9554_BASE,
>> +        .class_init    = pca9554_class_init,
>>      },
>>      {
>>          .name          = TYPE_PCA9536,
>
> The basic change looks good to me, however I found it tricky to follow 
> given that PCA9554Class is now related to PCA9554_BASE_CLASS() and 
> PCA9554State is now related to PCA9554_BASE().
>
> Would it make sense to rename PCA9554Class to PCA9554BaseClass and 
> PCA9554State to PCA9554BaseState here? I think it would help make the 
> hierarchy easier to follow.

I considered it when I wrote this patch, then decided not to, to
minimize churn and keep the identifiers short.  I'm fine either way.


