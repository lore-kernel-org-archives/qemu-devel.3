Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB508CD6E79
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVVhv-0002Yg-2G; Fri, 05 Jun 2026 10:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wVVht-0002YY-Hw
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:39:33 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wVVhr-0004mM-M6
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:39:33 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C5056B17A;
 Fri,  5 Jun 2026 14:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780670369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yuH4rNmTOKa87YS2UHT2MpHSI8Vx5Vd2V4hPkqlrg5s=;
 b=lvbU99e92b+nuGdM0EIA+TWIU/3MxQvb6QvkxvyOCZn5Bt6JQzifG2lKn3ru1q+Gf9auwA
 vOkV1fsc5QRNei0l8GLF+aSn8Jz9WSzrPbF2T72laa2EmFwKxYCJII8WeWli/gms7grlG2
 acDK65ek+jNMdCP1p3a8SRKnJJLlmBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780670369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yuH4rNmTOKa87YS2UHT2MpHSI8Vx5Vd2V4hPkqlrg5s=;
 b=i2iH7pumWj9+wBogVdaXh7dY/KtidTTaVDaznIjbKGtfKnzbNSlW/DUpfinWUYZS9H9R/Z
 Ulh1+qTUdCmEL+DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780670369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yuH4rNmTOKa87YS2UHT2MpHSI8Vx5Vd2V4hPkqlrg5s=;
 b=lvbU99e92b+nuGdM0EIA+TWIU/3MxQvb6QvkxvyOCZn5Bt6JQzifG2lKn3ru1q+Gf9auwA
 vOkV1fsc5QRNei0l8GLF+aSn8Jz9WSzrPbF2T72laa2EmFwKxYCJII8WeWli/gms7grlG2
 acDK65ek+jNMdCP1p3a8SRKnJJLlmBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780670369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yuH4rNmTOKa87YS2UHT2MpHSI8Vx5Vd2V4hPkqlrg5s=;
 b=i2iH7pumWj9+wBogVdaXh7dY/KtidTTaVDaznIjbKGtfKnzbNSlW/DUpfinWUYZS9H9R/Z
 Ulh1+qTUdCmEL+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23E1F779A8;
 Fri,  5 Jun 2026 14:39:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oZ+dOaDfImq6VwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 05 Jun 2026 14:39:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Sana Sharma <sansshar@redhat.com>, Eric Blake <eblake@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 1/4] qdev: Pave way for exporting Property to be used in
 non-qdev
In-Reply-To: <20260604231118.1584889-2-peterx@redhat.com>
References: <20260604231118.1584889-1-peterx@redhat.com>
 <20260604231118.1584889-2-peterx@redhat.com>
Date: Fri, 05 Jun 2026 11:39:26 -0300
Message-ID: <87fr316ogx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[17];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Xu <peterx@redhat.com> writes:

> Property itself is a well defined interface to either support smooth
> conversions to Object's properties, or supports global properties.  However
> currently it's tied to DeviceClass, aka, qdev. So non-qdev cannot use
> Property list.
>
> My current observation shows Property is almost ready to be used as a
> separated exported interface, except two small things that may need touch
> up internally:
>
>         qdev_prop_allow_set

Just a thought, we could use something like this to block update of
migration parameters during migration runtime.

>         qdev_prop_check_globals
>
> The 1st one currently checks against realize state (which is part of qdev
> attributes only).  The 2nd one checks for all global property being used in
> all non-pluggable qdevs.
>
> We can loose the check in both spots, keep the check if the driver is a
> qdev, otherwise we can safely whitelist non-qdev use cases of Property.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/core/qdev-properties.c           | 24 ++++++++++++++++++++----
>  tests/unit/test-qdev-global-props.c |  6 +++++-
>  2 files changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 34d7b26a73..8f870c85fc 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -31,8 +31,14 @@ void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
>  static bool qdev_prop_allow_set(Object *obj, const char *name,
>                                  const PropertyInfo *info, Error **errp)
>  {
> -    DeviceState *dev = DEVICE(obj);
> +    DeviceState *dev;
> +
> +    if (!object_dynamic_cast(obj, TYPE_DEVICE)) {
> +        /* Currently, non-qdev can always set Property anytime */
> +        return true;
> +    }
>  
> +    dev = DEVICE(obj);
>      if (dev->realized && !info->realized_set_allowed) {
>          qdev_prop_set_after_realize(dev, name, errp);
>          return false;
> @@ -997,6 +1003,7 @@ int qdev_prop_check_globals(void)
>  
>      for (i = 0; i < global_props()->len; i++) {
>          GlobalProperty *prop;
> +        bool hotpluggable;
>          ObjectClass *oc;
>          DeviceClass *dc;
>  
> @@ -1005,15 +1012,24 @@ int qdev_prop_check_globals(void)
>              continue;
>          }
>          oc = object_class_by_name(prop->driver);
> -        oc = object_class_dynamic_cast(oc, TYPE_DEVICE);
>          if (!oc) {
>              warn_report("global %s.%s has invalid class name",
>                          prop->driver, prop->property);
>              ret = 1;
>              continue;
>          }
> -        dc = DEVICE_CLASS(oc);
> -        if (!dc->hotpluggable && !prop->used) {
> +        oc = object_class_dynamic_cast(oc, TYPE_DEVICE);
> +        if (oc) {
> +            dc = DEVICE_CLASS(oc);
> +            hotpluggable = dc->hotpluggable;
> +        } else {
> +            /*
> +             * Currently, to be strict to assume all non-qdev are not
> +             * hotpluggable (whoever will use -global).
> +             */
> +            hotpluggable = false;
> +        }
> +        if (!hotpluggable && !prop->used) {
>              warn_report("global %s.%s=%s not used",
>                          prop->driver, prop->property, prop->value);
>              ret = 1;
> diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
> index 8ea362cbb9..86bb1458d9 100644
> --- a/tests/unit/test-qdev-global-props.c
> +++ b/tests/unit/test-qdev-global-props.c
> @@ -275,8 +275,12 @@ static void test_dynamic_globalprop(void)
>      g_test_trap_assert_stderr_unmatched("*prop4*");
>      g_test_trap_assert_stderr(
>          "*warning: global nohotplug-type.prop5=105 not used*");
> +    /*
> +     * TYPE_OBJECT can opt-in for global properties, so the error is "not
> +     * used" too for nondevice-type.
> +     */
>      g_test_trap_assert_stderr(
> -        "*warning: global nondevice-type.prop6 has invalid class name*");
> +        "*warning: global nondevice-type.prop6=106 not used*");
>      g_test_trap_assert_stdout("");
>  }

