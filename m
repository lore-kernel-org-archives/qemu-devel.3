Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8172BC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 05:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkGPa-0000uw-OX; Tue, 18 Feb 2025 00:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tkGPY-0000um-EF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 00:44:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tkGPW-0000nw-8O
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 00:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739857484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8rHFisp02o8YtBIemUhK3PAVx3lAL9TZ95F0tUvlJNo=;
 b=fuJ1ITY9RZ70mMabkwgi/dQJGZ9l/WmQksPS6jTzL0Yk5QF8HR6yJyQjKalBVkEJh6BsCI
 6YX37PkDaT/d77Jb6Yldd5wt1DWZa0iq4l0vY+zv41dVPG7sMYb92m2ZBb62UfXoiLYv1g
 9IV4Ydo2zdxa/XVyK0oFqyAZ+gi8uN4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-9wAPZTkKO5eFleYoTb6tYA-1; Tue,
 18 Feb 2025 00:44:42 -0500
X-MC-Unique: 9wAPZTkKO5eFleYoTb6tYA-1
X-Mimecast-MFC-AGG-ID: 9wAPZTkKO5eFleYoTb6tYA_1739857481
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C89D0180087B; Tue, 18 Feb 2025 05:44:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 364871955BCB; Tue, 18 Feb 2025 05:44:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9464521E6A28; Tue, 18 Feb 2025 06:44:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Eric Blake <eblake@redhat.com>
Subject: Re: [RFC] migration: Introduce migration throttle event
In-Reply-To: <4df13a8005170ad42cbbc883a0a8fdbb1ab94ac1.1739846274.git.yong.huang@smartx.com>
 (yong huang's message of "Tue, 18 Feb 2025 10:39:55 +0800")
References: <4df13a8005170ad42cbbc883a0a8fdbb1ab94ac1.1739846274.git.yong.huang@smartx.com>
Date: Tue, 18 Feb 2025 06:44:38 +0100
Message-ID: <87cyffiz7d.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

yong.huang@smartx.com writes:

> From: Hyman Huang <yong.huang@smartx.com>
>
> When the developer is examining the time distribution of
> the migration, it is useful to record the migration throttle
> timestamp. Consequently, include the migration throttle event.

Can you explain what you'd like to do with the information in a little
more detail?

> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  migration/ram.c     |  1 +
>  qapi/migration.json | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 589b6505eb..725e029927 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -524,6 +524,7 @@ static void mig_throttle_guest_down(uint64_t bytes_dirty_period,
>  
>      /* We have not started throttling yet. Let's start it. */
>      if (!cpu_throttle_active()) {
> +        qapi_event_send_migration_throttle();
>          cpu_throttle_set(pct_initial);
>      } else {
>          /* Throttling already on, just increase the rate */

I guess the percentage is uninteresting because it changes too quickly.
Correct?

Would it make sense to track cpu_throttle_stop(), too?

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8b9c53595c..0495065b5d 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1393,6 +1393,21 @@
>  { 'event': 'MIGRATION_PASS',
>    'data': { 'pass': 'int' } }
>  
> +##
> +# @MIGRATION_THROTTLE:
> +#
> +# Emitted from the source side of a migration at the start of vCPU throttle
> +#
> +# Since: 10.0
> +#
> +# Example:
> +#
> +# <- { "event": "MIGRATION_THROTTLE",
> +#      "timestamp": { "seconds": 1267041730, "microseconds": 281295 } }
> +#
> +##
> +{ 'event': 'MIGRATION_THROTTLE' }
> +
>  ##
>  # @COLOMessage:
>  #

Standard question for events: if a management application misses an
event, say because it restarts and reconnects, is there a way to obtain
the missed information with a query command?


