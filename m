Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B3EC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 14:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJutI-0004YR-GU; Tue, 27 May 2025 10:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJusd-0003tO-JY
 for qemu-devel@nongnu.org; Tue, 27 May 2025 10:02:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJusU-00062n-WB
 for qemu-devel@nongnu.org; Tue, 27 May 2025 10:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748354520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UMLt0iBLOcZ3s3HGfxUPxWVzJ2FA0e8cqpdjXUzXq9o=;
 b=WTvncHXMFJZSvpxb6kadmK1kIHeDKQAfyupNbfiOlOoHrXO9GBaQGWJiZi40OBkfF3clMh
 9B/11KdGUP2o1ry/XwBQca8K/4FSLQURQT7ZOeg0rDzi4IyISH4CScyQVSJlHEmDXC15mb
 LYoJXZi9QR2q/MmpDzdYF9GGqX6OMJU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-GrAHP19kMaa-ZQ498M-lng-1; Tue,
 27 May 2025 10:01:55 -0400
X-MC-Unique: GrAHP19kMaa-ZQ498M-lng-1
X-Mimecast-MFC-AGG-ID: GrAHP19kMaa-ZQ498M-lng_1748354514
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CE07180087A; Tue, 27 May 2025 14:01:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A1FD19560AB; Tue, 27 May 2025 14:01:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4BAB621E66C3; Tue, 27 May 2025 16:01:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-rust@nongnu.org
Subject: Re: [PATCH 10/12] hpet: return errors from realize if properties
 are incorrect
In-Reply-To: <20250526142455.1061519-10-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 26 May 2025 16:24:53 +0200")
References: <20250526142254.1061009-1-pbonzini@redhat.com>
 <20250526142455.1061519-10-pbonzini@redhat.com>
Date: Tue, 27 May 2025 16:01:51 +0200
Message-ID: <87ldqim9tc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Do not silently adjust num_timers, and fail if intcap is 0.

A bad habit of ours.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/timer/hpet.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index d1b7bc52b7b..d78aba04bcd 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -689,8 +689,14 @@ static void hpet_realize(DeviceState *dev, Error **errp)
>      int i;
>      HPETTimer *timer;
>  
> +    if (s->num_timers < HPET_MIN_TIMERS || s->num_timers > HPET_MAX_TIMERS) {
> +        error_setg(errp, "hpet.num_timers must be between %d and %d",
> +                   HPET_MIN_TIMERS, HPET_MAX_TIMERS);
> +        return;
> +    }
>      if (!s->intcap) {
> -        warn_report("Hpet's intcap not initialized");
> +        error_setg(errp, "hpet.hpet-intcap not initialized");
> +        return;
>      }
>      if (hpet_fw_cfg.count == UINT8_MAX) {
>          /* first instance */
> @@ -698,7 +704,7 @@ static void hpet_realize(DeviceState *dev, Error **errp)
>      }
>  
>      if (hpet_fw_cfg.count == 8) {
> -        error_setg(errp, "Only 8 instances of HPET is allowed");
> +        error_setg(errp, "Only 8 instances of HPET are allowed");
>          return;
>      }
>  
> @@ -708,11 +714,6 @@ static void hpet_realize(DeviceState *dev, Error **errp)
>          sysbus_init_irq(sbd, &s->irqs[i]);
>      }
>  
> -    if (s->num_timers < HPET_MIN_TIMERS) {
> -        s->num_timers = HPET_MIN_TIMERS;
> -    } else if (s->num_timers > HPET_MAX_TIMERS) {
> -        s->num_timers = HPET_MAX_TIMERS;
> -    }
>      for (i = 0; i < HPET_MAX_TIMERS; i++) {
>          timer = &s->timer[i];
>          timer->qemu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, hpet_timer, timer);

This device is not user-creatable.  It is only ever created (and
realized) by board code.  Errors should not happen.  If they happen
anyway, it's a board code bug.

The code creating it is pc_basic_device_init():

    if (pcms->hpet_enabled) {
        qemu_irq rtc_irq;

        hpet = qdev_try_new(TYPE_HPET);
        if (!hpet) {
            error_report("couldn't create HPET device");
            exit(1);
        }

Could just as well use qdev_new().  Differently confusing error message,
though.

        /*
         * For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-*,
         * use IRQ16~23, IRQ8 and IRQ2.  If the user has already set
         * the property, use whatever mask they specified.
         */
        uint8_t compat = object_property_get_uint(OBJECT(hpet),
                HPET_INTCAP, NULL);
        if (!compat) {
            qdev_prop_set_uint32(hpet, HPET_INTCAP, hpet_irqs);
        }
        sysbus_realize_and_unref(SYS_BUS_DEVICE(hpet), &error_fatal);

If this fails, it's a programming error, i.e. &error_abort is more
appropriate.  Hmm, can the user mess with property values via -global?
If yes, it could be a user error.

        [...]
    }

I'm rambling.  The patch is fine.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


