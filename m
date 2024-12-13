Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79204E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 11:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM41r-00020S-7N; Fri, 13 Dec 2024 06:40:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tM41p-00020J-Aa
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 06:40:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tM41m-00040v-NC
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 06:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734090012;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+rzsWdZQYuLOuUgwxruGbiKwQ9OrPEvHlwfCg5QNIgQ=;
 b=U5p8hzkWmWtoerYMh/9vFgIxyup1mCOZURdMRruTQ4AQ4dAvvFqjcqnrwFv/dL2q/TTtMH
 LscHO8QDh+2S/02finEoodAOQBxTt1u/mzE28hwnnmc+SqFcf84JQ1M4Mj/mkiDnN8a+tl
 QhcwguvMNimM5C7oxPgcBhHk0+INbEc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-PEeEZjSfPF6WCG-5hA4GUQ-1; Fri,
 13 Dec 2024 06:40:08 -0500
X-MC-Unique: PEeEZjSfPF6WCG-5hA4GUQ-1
X-Mimecast-MFC-AGG-ID: PEeEZjSfPF6WCG-5hA4GUQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C74721956095; Fri, 13 Dec 2024 11:40:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.42])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C509C195394B; Fri, 13 Dec 2024 11:40:03 +0000 (UTC)
Date: Fri, 13 Dec 2024 11:40:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/4] hw/timer/hpet: Hold fw_cfg state within HPET class
Message-ID: <Z1wdEDwzHbP1Bgvg@redhat.com>
References: <20241206191124.9195-1-philmd@linaro.org>
 <20241206191124.9195-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206191124.9195-5-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Dec 06, 2024 at 08:11:24PM +0100, Philippe Mathieu-Daudé wrote:
> We maintain one hpet_cfg[] state for all HPET instances.
> Move it to a new HPET class.

It is a conceptually rather wierd having state stored in a
class rather than an instance.

I don't know what hpet_cfg is used for though ? How / when
does its contents change ? If it were something initialized
once, *before* any instances are created, I might be
convinced that it could live in a class. If it is at all
dynamic though, it could feel more like a separate class
providing a singleton instance.

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/timer/hpet.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 849cb3e669b..c5aeac860b4 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -57,7 +57,7 @@ struct hpet_fw_config
>  
>  #define HPET_MSI_SUPPORT        0
>  
> -OBJECT_DECLARE_SIMPLE_TYPE(HPETState, HPET)
> +OBJECT_DECLARE_TYPE(HPETState, HPETClass, HPET)
>  
>  struct HPETState;
>  typedef struct HPETTimer {  /* timers */
> @@ -101,7 +101,11 @@ struct HPETState {
>      uint8_t  hpet_id;           /* instance id */
>  };
>  
> -static struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
> +struct HPETClass {
> +    SysBusDeviceClass parent_class;
> +
> +    struct hpet_fw_config fw_cfg;
> +};
>  
>  static uint32_t hpet_in_legacy_mode(HPETState *s)
>  {
> @@ -279,6 +283,7 @@ static bool hpet_validate_num_timers(void *opaque, int version_id)
>  static int hpet_post_load(void *opaque, int version_id)
>  {
>      HPETState *s = opaque;
> +    HPETClass *hc = HPET_GET_CLASS(s);
>      int i;
>  
>      for (i = 0; i < s->num_timers; i++) {
> @@ -295,7 +300,7 @@ static int hpet_post_load(void *opaque, int version_id)
>      /* Push number of timers into capability returned via HPET_ID */
>      s->capability &= ~HPET_ID_NUM_TIM_MASK;
>      s->capability |= (s->num_timers - 1) << HPET_ID_NUM_TIM_SHIFT;
> -    hpet_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
> +    hc->fw_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
>  
>      /* Derive HPET_MSI_SUPPORT from the capability of the first timer. */
>      s->flags &= ~(1 << HPET_MSI_SUPPORT);
> @@ -660,6 +665,7 @@ static const MemoryRegionOps hpet_ram_ops = {
>  static void hpet_reset(DeviceState *d)
>  {
>      HPETState *s = HPET(d);
> +    HPETClass *hc = HPET_GET_CLASS(d);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(d);
>      int i;
>  
> @@ -682,8 +688,8 @@ static void hpet_reset(DeviceState *d)
>      s->hpet_counter = 0ULL;
>      s->hpet_offset = 0ULL;
>      s->config = 0ULL;
> -    hpet_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
> -    hpet_cfg.hpet[s->hpet_id].address = sbd->mmio[0].addr;
> +    hc->fw_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
> +    hc->fw_cfg.hpet[s->hpet_id].address = sbd->mmio[0].addr;
>  
>      /* to document that the RTC lowers its output on reset as well */
>      s->rtc_irq_level = 0;
> @@ -719,23 +725,24 @@ static void hpet_realize(DeviceState *dev, Error **errp)
>  {
>      SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>      HPETState *s = HPET(dev);
> +    HPETClass *hc = HPET_GET_CLASS(dev);
>      int i;
>      HPETTimer *timer;
>  
>      if (!s->intcap) {
>          warn_report("Hpet's intcap not initialized");
>      }
> -    if (hpet_cfg.count == UINT8_MAX) {
> +    if (hc->fw_cfg.count == UINT8_MAX) {
>          /* first instance */
> -        hpet_cfg.count = 0;
> +        hc->fw_cfg.count = 0;
>      }
>  
> -    if (hpet_cfg.count == 8) {
> +    if (hc->fw_cfg.count == 8) {
>          error_setg(errp, "Only 8 instances of HPET is allowed");
>          return;
>      }
>  
> -    s->hpet_id = hpet_cfg.count++;
> +    s->hpet_id = hc->fw_cfg.count++;
>  
>      for (i = 0; i < HPET_NUM_IRQ_ROUTES; i++) {
>          sysbus_init_irq(sbd, &s->irqs[i]);
> @@ -773,11 +780,14 @@ static Property hpet_device_properties[] = {
>  static void hpet_device_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    HPETClass *hc = HPET_CLASS(klass);
>  
>      dc->realize = hpet_realize;
>      device_class_set_legacy_reset(dc, hpet_reset);
>      dc->vmsd = &vmstate_hpet;
>      device_class_set_props(dc, hpet_device_properties);
> +
> +    hc->fw_cfg.count = UINT8_MAX;
>  }
>  
>  static const TypeInfo hpet_device_info = {
> @@ -797,7 +807,9 @@ type_init(hpet_register_types)
>  
>  bool hpet_add_fw_cfg_bytes(FWCfgState *fw_cfg, Error **errp)
>  {
> -    fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_cfg, sizeof(hpet_cfg));
> +    HPETClass *hc = HPET_GET_CLASS(hpet_find());
> +
> +    fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hc->fw_cfg, sizeof(hc->fw_cfg));
>  
>      return true;
>  }
> -- 
> 2.45.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


