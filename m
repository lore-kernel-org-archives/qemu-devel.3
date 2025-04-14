Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0406FC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 16:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Mp6-0004Hc-20; Mon, 14 Apr 2025 12:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4Mp4-0004HN-10
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4Mp1-0005lW-Du
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744648690;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=A+/KZ97ZKnQO0UlX0CuHs/9Od+uTj5JfWM88YaAbq74=;
 b=XG9jonKK4Gx9h20mciDMFDdSwBW1/OA0Xs8gYKXAtZsjYFggdZbiGeiWbJC3IfGwlUj0Be
 pACpwN1y6Lgw2F2zNlAzhRmdfSdVyLJQiOPy5keIM36gQxnMVHKi8gMQpGxekJ7vaOrZiF
 bUvgkkNxb6pLLatCuccoRKGQyLBP+YY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-K5hkoLtSNTS4P4ifcTAQJQ-1; Mon,
 14 Apr 2025 12:38:08 -0400
X-MC-Unique: K5hkoLtSNTS4P4ifcTAQJQ-1
X-Mimecast-MFC-AGG-ID: K5hkoLtSNTS4P4ifcTAQJQ_1744648687
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8205195608B; Mon, 14 Apr 2025 16:38:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEC521828AB9; Mon, 14 Apr 2025 16:38:04 +0000 (UTC)
Date: Mon, 14 Apr 2025 17:38:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH 05/13] migration: Reduce a bit of duplication in
 migration.json
Message-ID: <Z_056amMGN6Ey_1i@redhat.com>
References: <20250411191443.22565-1-farosas@suse.de>
 <20250411191443.22565-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250411191443.22565-6-farosas@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 11, 2025 at 04:14:35PM -0300, Fabiano Rosas wrote:
> Introduce a new MigrationConfigBase, to allow most of the duplication
> in migration.json to be eliminated.
> 
> The reason we need MigrationParameters and MigrationSetParameters is
> that the internal parameter representation in the migration code, as
> well as the user-facing return of query-migrate-parameters use one
> type for the TLS options (tls-creds, tls-hostname, tls-authz), while
> the user-facing input from migrate-set-parameters uses another.
> 
> The difference is in whether the NULL values is accepted. The former
> considers NULL as invalid, while the latter doesn't.
> 
> Move all other (non-TLS) options into the new type and make it a base
> type for the two diverging types so that each child type can declare
> the TLS options in its own way.
> 
> Nothing changes in the user API, nothing changes in the internal
> representation, but we save several lines of duplication in
> migration.json.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  qapi/migration.json | 358 +++++++++++++-------------------------------
>  1 file changed, 108 insertions(+), 250 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8b9c53595c..5a4d5a2d3e 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -914,202 +914,6 @@

> @@ -1277,45 +1059,121 @@
>  #     only has effect if the @mapped-ram capability is enabled.
>  #     (Since 9.1)
>  #
> +# @tls: Whether to use TLS. If this is set the options @tls-authz,
> +#     @tls-creds, @tls-hostname are mandatory and a valid string is
> +#     expected. (Since 10.1)
> +#

I'm not really finding it compelling to add a bool @tls as it
is just a denormalization of  !!@tls-creds.

Incidentally the docs here are wrong - TLS can be used by
only setting @tls-creds. The @tls-authz & @tls-hostname
params are always optional.

>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and
>  #     @x-vcpu-dirty-limit-period are experimental.
>  #
> +# Since: 10.1
> +##
> +{ 'struct': 'MigrationConfigBase',
> +  'data': { '*announce-initial': 'size',
> +            '*announce-max': 'size',
> +            '*announce-rounds': 'size',
> +            '*announce-step': 'size',
> +            '*throttle-trigger-threshold': 'uint8',
> +            '*cpu-throttle-initial': 'uint8',
> +            '*cpu-throttle-increment': 'uint8',
> +            '*cpu-throttle-tailslow': 'bool',
> +            '*max-bandwidth': 'size',
> +            '*avail-switchover-bandwidth': 'size',
> +            '*downtime-limit': 'uint64',
> +            '*x-checkpoint-delay': { 'type': 'uint32',
> +                                     'features': [ 'unstable' ] },
> +            '*multifd-channels': 'uint8',
> +            '*xbzrle-cache-size': 'size',
> +            '*max-postcopy-bandwidth': 'size',
> +            '*max-cpu-throttle': 'uint8',
> +            '*multifd-compression': 'MultiFDCompression',
> +            '*multifd-zlib-level': 'uint8',
> +            '*multifd-qatzip-level': 'uint8',
> +            '*multifd-zstd-level': 'uint8',
> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
> +            '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
> +                                            'features': [ 'unstable' ] },
> +            '*vcpu-dirty-limit': 'uint64',
> +            '*mode': 'MigMode',
> +            '*zero-page-detection': 'ZeroPageDetection',
> +            '*direct-io': 'bool',
> +            '*tls': 'bool' } }


>  { 'struct': 'MigrationParameters',
> +  'base': 'MigrationConfigBase',
> +  'data': { 'tls-creds': 'str',
> +            'tls-hostname': 'str',
> +            'tls-authz': 'str' } }

snip

> +{ 'struct': 'MigrateSetParameters',
> +  'base': 'MigrationConfigBase',
> +  'data': { '*tls-creds': 'StrOrNull',
> +            '*tls-hostname': 'StrOrNull',
> +            '*tls-authz': 'StrOrNull' } }

I recall we discussed this difference a year or two ago, but can't
recall what the outcome was.

Making the TLS params optional is a back compatible change for
MigrationParameters. I would think replacing 'str' with 'StrOrNull'
is also back compatible. So I'm wondering if we can't just unify
the sttructs fully for TLS, even if one usage scenario never actually
needs the "OrNull" bit nor needs the optionality 


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


