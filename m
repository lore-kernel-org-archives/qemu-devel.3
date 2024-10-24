Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCB8D0E3F7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 19:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t43Nh-0003HB-Nf; Thu, 24 Oct 2024 15:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t43Nh-0003H2-1h
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 15:20:25 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t43Nf-0004kR-Dc
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 15:20:24 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0DBEA21DA7;
 Thu, 24 Oct 2024 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729797618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJoq6RfU36y5XSqopLcYMfLzOj9ASAJIjo6bo1CLbU8=;
 b=X6jOA4f0DMveq12+8jrCXd04/26h+UkKS/qLVviEtODTnzmtPGOX0dMPTph3bOC4yJSF2i
 25FWZ/7BRohhLRvWe/YQu94t6AW35PH+IhCqNy53uqNoy+yVgHT8V9Pyc5Nas1Bg2L+bYL
 PtVc+8iw94Atq6qz0x99xY1LW0wlq94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729797618;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJoq6RfU36y5XSqopLcYMfLzOj9ASAJIjo6bo1CLbU8=;
 b=Dawsbw97knpXcMqXQn3OVHcX8WUMHeka1v3Dc38g74uWhEpW/nXPhUQelSE0fIta0wA2gE
 6rT1FPiGC+ILNdDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=X6jOA4f0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Dawsbw97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729797618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJoq6RfU36y5XSqopLcYMfLzOj9ASAJIjo6bo1CLbU8=;
 b=X6jOA4f0DMveq12+8jrCXd04/26h+UkKS/qLVviEtODTnzmtPGOX0dMPTph3bOC4yJSF2i
 25FWZ/7BRohhLRvWe/YQu94t6AW35PH+IhCqNy53uqNoy+yVgHT8V9Pyc5Nas1Bg2L+bYL
 PtVc+8iw94Atq6qz0x99xY1LW0wlq94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729797618;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJoq6RfU36y5XSqopLcYMfLzOj9ASAJIjo6bo1CLbU8=;
 b=Dawsbw97knpXcMqXQn3OVHcX8WUMHeka1v3Dc38g74uWhEpW/nXPhUQelSE0fIta0wA2gE
 6rT1FPiGC+ILNdDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E03F1368E;
 Thu, 24 Oct 2024 19:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VknsAPGdGmevCAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 24 Oct 2024 19:20:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Igor Mammedov <imammedo@redhat.com>, Juraj Marcin
 <jmarcin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Dr . David
 Alan Gilbert" <dave@treblig.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/4] migration: Make migration object a singleton object
In-Reply-To: <20241024165627.1372621-4-peterx@redhat.com>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-4-peterx@redhat.com>
Date: Thu, 24 Oct 2024 16:20:14 -0300
Message-ID: <878qudfgup.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 0DBEA21DA7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[14]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Peter Xu <peterx@redhat.com> writes:

> This makes the migration object a singleton unit.  After this, we can do
> something slightly tricky later on with the guarantee that nobody will be
> able to create the object twice.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index bcb735869b..1b5285af95 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -45,6 +45,7 @@
>  #include "qapi/qmp/qerror.h"
>  #include "qapi/qmp/qnull.h"
>  #include "qemu/rcu.h"
> +#include "qom/object_interfaces.h"
>  #include "postcopy-ram.h"
>  #include "qemu/thread.h"
>  #include "trace.h"
> @@ -3855,11 +3856,19 @@ fail:
>      migrate_fd_cleanup(s);
>  }
>  
> +static Object* migration_get_instance(Error **errp)

static Object *migration_get_instance(Error **errp)
              ^

> +{
> +    return OBJECT(current_migration);
> +}
> +
>  static void migration_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    SingletonClass *singleton = SINGLETON_CLASS(klass);
>  
>      dc->user_creatable = false;
> +    singleton->get_instance = migration_get_instance;
> +
>      device_class_set_props(dc, migration_properties);
>  }
>  
> @@ -3932,6 +3941,10 @@ static const TypeInfo migration_type = {
>      .instance_size = sizeof(MigrationState),
>      .instance_init = migration_instance_init,
>      .instance_finalize = migration_instance_finalize,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_SINGLETON },
> +        { }
> +    }
>  };
>  
>  static void register_migration_types(void)

