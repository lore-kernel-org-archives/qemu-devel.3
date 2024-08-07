Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D611C52D73
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 18:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sblLZ-0004sn-2O; Wed, 07 Aug 2024 14:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sblLW-0004qA-0d
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 14:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sblLT-0005ar-Jb
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 14:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723055108;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ITf1GKTF4wGCwvGzNdubRlSavcY4uKLFksAYjG5tveE=;
 b=E6t7uGoT1SY/Zg9KAbO1MVll/Y4qrjbGFaJO0726/9u2ysT4JUw+w3RU8oyEXZN0FsXWXO
 LTUJhW4MoTyzslVj0MOi/z/9UJMzU7hbpr38VVBMHdqcXKRNTXc7WjC8DEat0vAVKVFemh
 efpbJ9+sey7BkvTMvN5l0m9lFoadrbk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-w9JYzDVpNAqJS3OtzNWlWA-1; Wed,
 07 Aug 2024 14:25:06 -0400
X-MC-Unique: w9JYzDVpNAqJS3OtzNWlWA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87AAD19560A2; Wed,  7 Aug 2024 18:25:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.79])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D78CD19560A3; Wed,  7 Aug 2024 18:24:59 +0000 (UTC)
Date: Wed, 7 Aug 2024 19:24:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 vsementsov@yandex-team.ru, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 3/7] nbd/server: CVE-2024-7409: Change default
 max-connections to 100
Message-ID: <ZrO7-MR4avD9OcFo@redhat.com>
References: <20240807174943.771624-9-eblake@redhat.com>
 <20240807174943.771624-12-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807174943.771624-12-eblake@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 07, 2024 at 12:43:29PM -0500, Eric Blake wrote:
> Allowing an unlimited number of clients to any web service is a recipe
> for a rudimentary denial of service attack: the client merely needs to
> open lots of sockets without closing them, until qemu no longer has
> any more fds available to allocate.
> 
> For qemu-nbd, we default to allowing only 1 connection unless more are
> explicitly asked for (-e or --shared); this was historically picked as
> a nice default (without an explicit -t, a non-persistent qemu-nbd goes
> away after a client disconnects, without needing any additional
> follow-up commands), and we are not going to change that interface now
> (besides, someday we want to point people towards qemu-storage-daemon
> instead of qemu-nbd).
> 
> But for qemu proper, the QMP nbd-server-start command has historically
> had a default of unlimited number of connections, in part because
> unlike qemu-nbd it is inherently persistent.  Allowing multiple client
> sockets is particularly useful for clients that can take advantage of
> MULTI_CONN (creating parallel sockets to increase throughput),
> although known clients that do so (such as libnbd's nbdcopy) typically
> use only 8 or 16 connections (the benefits of scaling diminish once
> more sockets are competing for kernel attention).  Picking a number
> large enough for typical use cases, but not unlimited, makes it
> slightly harder for a malicious client to perform a denial of service
> merely by opening lots of connections withot progressing through the
> handshake.
> 
> This change does not eliminate CVE-2024-7409 on its own, but reduces
> the chance for fd exhaustion or unlimited memory usage as an attack
> surface.  On the other hand, by itself, it makes it more obvious that
> with a finite limit, we have the problem of an unauthenticated client
> holding 100 fds opened as a way to block out a legitimate client from
> being able to connect; thus, later patches will further add timeouts
> to reject clients that are not making progress.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/block-export.json         | 4 ++--
>  include/block/nbd.h            | 7 +++++++
>  block/monitor/block-hmp-cmds.c | 3 ++-
>  blockdev-nbd.c                 | 8 ++++++++
>  4 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index 665d5fd0262..ce33fe378df 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -28,7 +28,7 @@
>  # @max-connections: The maximum number of connections to allow at the
>  #     same time, 0 for unlimited.  Setting this to 1 also stops the
>  #     server from advertising multiple client support (since 5.2;
> -#     default: 0)
> +#     default: 100)
>  #
>  # Since: 4.2
>  ##
> @@ -63,7 +63,7 @@
>  # @max-connections: The maximum number of connections to allow at the
>  #     same time, 0 for unlimited.  Setting this to 1 also stops the
>  #     server from advertising multiple client support (since 5.2;
> -#     default: 0).
> +#     default: 100).
>  #
>  # Errors:
>  #     - if the server is already running

This is considered a backwards compatibility break.
An intentional one.

Our justification is that we believe it is the least worst option
to mitigate the DoS vector. Lets explore the reasoning for that
belief...

An alternative would be to deprecate the absence of 'max-connections',
and after the deprecation period, make it in into a mandatory
parameter, forcing apps to make a decision. This would be strictly
compliant with our QAPI change policy.

How does that differ in impact from changing the defaults...

  * Changed default
     - Small risk of breaking app if needing > 100 concurrent conns
     - Immediately closes the DoS hole for all apps using QEMU

  * Deprecation & eventual change to mandatory
     - Zero risk of breaking apps today
     - Forces all apps to be changed to pass max-connections
       in 3 releases time
     - Does NOT close the DoS hole until the 3rd future release
       from now.

If we took the deprecation route, arguably any app which isn't
already setting max-connections would need to have a CVE filed
against it *today*, and thus effectively apps would be forced
into immediately setting max-connections, despite our deprecaiton
grace period supposedly giving them 3 releases to adjust.

If we took the changed default route and broke an app, it would
again have to be changed to set max-connections to a value that
satisfies its use case.


So....

If we take the deprecation route, we create work for /all/ app
developers using NBD to update their code now to fix the CVE.

If we take the changed defaults route, and our 100 value choice
is sufficient, then no apps need changing.

If we take the changed defaults route, and our 100 value choice
is NOT sufficient, then most apps still don't need changing, but
perhaps 1 or 2 do need changing.

The unpleasant bit is that if 100 is insufficient, an app
maintainer or user might not become aware of this until they
have been in production for 12 months and suddenly hit a
rare load spike.


Overall though, changing the defaults still looks likely to
be the least disruptive option for fixing the DoS, providing
our choice of 100 is a good one.

I think system emulators are likely OK given common use
cases for NBD in context of a running VM (migration and
backup related).

I've got a nagging concern someone could be doing something
adventurous with QSD though. eg using it to serve content
(perhaps readonly) to a huge pool of clients ?

Probably that's just a risk we have to take, as any app
relying on the max-connections default is vulernable.

There are no good answers AFAICT. Only bad answers. This
one feels least bad to me.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


