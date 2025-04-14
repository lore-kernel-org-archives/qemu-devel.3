Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80040C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 16:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Mhs-0001WE-GW; Mon, 14 Apr 2025 12:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4Mhr-0001Tg-AU
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4Mhj-0004Va-Ob
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744648236;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=tiHtCa9GxLDRG7VSq6Hu1/21E0v851o0FNxUScCKJjw=;
 b=iEVAdxWx1mpTn5u2MYsEu99lLcFZnByCTjXoMFrNubaL907g8VVQTWQkmg6sfZsKAnWcbd
 rxr8V5TuQbrWS99yeie0KJLa/IVoStApFywFmdpVLSxPRbI2yaJn9i6NgQEc2P1tKhDIGh
 NUyg9zUgv/gVIk73Qu1k+1XDDKgSH3Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-65U8Bj8gPNyPVCTcRW4-sw-1; Mon,
 14 Apr 2025 12:30:32 -0400
X-MC-Unique: 65U8Bj8gPNyPVCTcRW4-sw-1
X-Mimecast-MFC-AGG-ID: 65U8Bj8gPNyPVCTcRW4-sw_1744648231
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33CD71809CA5; Mon, 14 Apr 2025 16:30:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51DDD3001D0F; Mon, 14 Apr 2025 16:30:28 +0000 (UTC)
Date: Mon, 14 Apr 2025 17:30:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH 02/13] migration: Normalize tls arguments
Message-ID: <Z_04IURkXQhVsP47@redhat.com>
References: <20250411191443.22565-1-farosas@suse.de>
 <20250411191443.22565-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250411191443.22565-3-farosas@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Fri, Apr 11, 2025 at 04:14:32PM -0300, Fabiano Rosas wrote:
> The tls_creds, tls_authz and tls_hostname arguments are strings that
> can be set by the user. They are allowed to be either a valid string,
> an empty string or NULL. The values "" and NULL are effectively
> treated the same by the code, but this is not entirely clear because
> the handling is not uniform.
> 
> Make the 3 variables be handled the same and at the same place in
> options.c. Note that this affects only the internal usage of the
> variables.
> 
> (migrate_tls() had to be moved to be able to use migrate_tls_creds())
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 81 ++++++++++++++++++++++++---------------------
>  migration/tls.c     |  2 +-
>  2 files changed, 44 insertions(+), 39 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index cb8eec218f..7cd465ca94 100644
> --- a/migration/options.c
> +++ b/migration/options.c


> @@ -1184,18 +1200,27 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      }
>  
>      if (params->tls_creds) {
> -        assert(params->tls_creds->type == QTYPE_QSTRING);
> -        dest->tls_creds = params->tls_creds->u.s;
> +        if (params->tls_creds->type == QTYPE_QNULL) {
> +            dest->tls_creds = NULL;
> +        } else {
> +            dest->tls_creds = params->tls_creds->u.s;
> +        }

Feels like it is still worth having the assert(QTYPE_QSTRING)
in the else branch before we blindly reference the string pointer

>      }
>  
>      if (params->tls_hostname) {
> -        assert(params->tls_hostname->type == QTYPE_QSTRING);
> -        dest->tls_hostname = params->tls_hostname->u.s;
> +        if (params->tls_hostname->type == QTYPE_QNULL) {
> +            dest->tls_hostname = NULL;
> +        } else {
> +            dest->tls_hostname = params->tls_hostname->u.s;
> +        }
>      }
>  
>      if (params->tls_authz) {
> -        assert(params->tls_authz->type == QTYPE_QSTRING);
> -        dest->tls_authz = params->tls_authz->u.s;
> +        if (params->tls_authz->type == QTYPE_QNULL) {
> +            dest->tls_authz = NULL;
> +        } else {
> +            dest->tls_authz = params->tls_authz->u.s;
> +        }
>      }
>  
>      if (params->has_max_bandwidth) {

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


