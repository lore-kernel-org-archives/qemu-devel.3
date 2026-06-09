Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABF3CD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 22:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX5Mc-0008Kj-9l; Tue, 09 Jun 2026 18:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wX5MY-0008Io-Qv
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 18:56:02 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wX5MW-0007Vj-NM
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 18:56:02 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1BF626AC66;
 Tue,  9 Jun 2026 22:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781045759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zHfCb5Zn+148lb/uwbgcwd/WawhXpSYY4wEOhokvacE=;
 b=KKOfBBMNs0fbXYcdO0IJJcJT8UTcVWJ+6vIaSOJyP9Qzf03oK8pjj4IYdHnPm0AbHi5nO9
 T+/IlwcstNeE6tTEOV0H29V0bZR6EBSz4HsM1zBAeLOzrEkLO+sn/KIOocFQsk1byZklwV
 9oQJl+y4gcGOEiXo+GboOIvogSrx9Hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781045759;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zHfCb5Zn+148lb/uwbgcwd/WawhXpSYY4wEOhokvacE=;
 b=w0Q6f7Eyg2mjenj08cWlI0PMU5vJtl6uUmebWPaNXVBiRx1rHUEnGLv1E4WHzL8iondBWo
 B9mLGStUXzcrjWCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781045759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zHfCb5Zn+148lb/uwbgcwd/WawhXpSYY4wEOhokvacE=;
 b=KKOfBBMNs0fbXYcdO0IJJcJT8UTcVWJ+6vIaSOJyP9Qzf03oK8pjj4IYdHnPm0AbHi5nO9
 T+/IlwcstNeE6tTEOV0H29V0bZR6EBSz4HsM1zBAeLOzrEkLO+sn/KIOocFQsk1byZklwV
 9oQJl+y4gcGOEiXo+GboOIvogSrx9Hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781045759;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zHfCb5Zn+148lb/uwbgcwd/WawhXpSYY4wEOhokvacE=;
 b=w0Q6f7Eyg2mjenj08cWlI0PMU5vJtl6uUmebWPaNXVBiRx1rHUEnGLv1E4WHzL8iondBWo
 B9mLGStUXzcrjWCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE94B779A7;
 Tue,  9 Jun 2026 22:55:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id T698H/6ZKGoyOQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Jun 2026 22:55:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>, =?utf-8?Q?Daniel_P_=2E?=
 =?utf-8?Q?_Berrang=C3=A9?=
 <berrange@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Peter Maydell <peter.maydell@linaro.org>, "Dr
 . David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu
 <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Sana Sharma <sansshar@redhat.com>, =?utf-8?Q?Marc-And?=
 =?utf-8?Q?r=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 qemu-rust@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark
 Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v2 02/10] qdev: Export global_props()
In-Reply-To: <20260609172514.2037645-3-peterx@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-3-peterx@redhat.com>
Date: Tue, 09 Jun 2026 19:55:56 -0300
Message-ID: <87ecif5nnn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[20];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> Make it accessible from outside (to apply -global properties).
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/hw/core/qdev-properties.h | 2 ++
>  hw/core/qdev-properties.c         | 2 +-
>  rust/bindings/hwcore-sys/lib.rs   | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
> index eba5436e53..248bbcbba7 100644
> --- a/include/hw/core/qdev-properties.h
> +++ b/include/hw/core/qdev-properties.h
> @@ -321,4 +321,6 @@ void qdev_prop_allow_set_link_before_realize(const Object *obj,
>                                               const char *name,
>                                               Object *val, Error **errp);
>  
> +GPtrArray *global_props(void);
> +
>  #endif
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 34d7b26a73..1d531189ec 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -958,7 +958,7 @@ void qlist_append_link(QList *qlist, Object *obj)
>      qlist_append_str(qlist, path);
>  }
>  
> -static GPtrArray *global_props(void)
> +GPtrArray *global_props(void)
>  {
>      static GPtrArray *gp;
>  
> diff --git a/rust/bindings/hwcore-sys/lib.rs b/rust/bindings/hwcore-sys/lib.rs
> index 8cef4a7961..85e71f5145 100644
> --- a/rust/bindings/hwcore-sys/lib.rs
> +++ b/rust/bindings/hwcore-sys/lib.rs
> @@ -20,7 +20,7 @@
>  
>  use chardev_sys::Chardev;
>  use common::Zeroable;
> -use glib_sys::GSList;
> +use glib_sys::{GPtrArray, GSList};
>  use migration_sys::VMStateDescription;
>  use qom_sys::{
>      InterfaceClass, Object, ObjectClass, ObjectProperty, ObjectPropertyAccessor,

Reviewed-by: Fabiano Rosas <farosas@suse.de>

