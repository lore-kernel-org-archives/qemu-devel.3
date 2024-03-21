Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A864C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 10:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnFti-0007ja-Ln; Thu, 21 Mar 2024 06:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rnFth-0007jP-7l
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 06:43:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rnFtf-0005uT-A5
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 06:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711017820;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Prjpfmy1k2jOOV/EkJQ+Pwos+LtxEYWH5eWuds2LtGs=;
 b=R+6Vpb9nUDqbdmGkApZymBtvBQwY3dA/HdztBcMriDNvQeWQOoawkX4ktrRMCu4QP7tARv
 ZGnzySBkVD0tlpiHU4oWRAlz6yTAtrK/xaP6dtaIP1K+So+S2h9Pgag2IhB1uAUjpVQRrf
 sowE2/+Dlq3pIPVBW1bHoDhbjbkWgqI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-P5HRrab9MaiBu3jdY-EUZg-1; Thu, 21 Mar 2024 06:43:38 -0400
X-MC-Unique: P5HRrab9MaiBu3jdY-EUZg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1664800262
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 10:43:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A7921C060CE;
 Thu, 21 Mar 2024 10:43:36 +0000 (UTC)
Date: Thu, 21 Mar 2024 10:43:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] coroutine: reserve 5,000 mappings
Message-ID: <ZfwPUtYHSJpLJz1l@redhat.com>
References: <20240320181232.1464819-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320181232.1464819-1-stefanha@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 20, 2024 at 02:12:32PM -0400, Stefan Hajnoczi wrote:
> Daniel P. Berrangé <berrange@redhat.com> pointed out that the coroutine
> pool size heuristic is very conservative. Instead of halving
> max_map_count, he suggested reserving 5,000 mappings for non-coroutine
> users based on observations of guests he has access to.
> 
> Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")

It wasn't really broken, so "Tweaks" or "Enhances" rather than
"Fixes" if you like :-)

> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/qemu-coroutine.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> index 2790959eaf..eb4eebefdf 100644
> --- a/util/qemu-coroutine.c
> +++ b/util/qemu-coroutine.c
> @@ -377,12 +377,17 @@ static unsigned int get_global_pool_hard_max_size(void)
>                              NULL) &&
>          qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
>          /*
> -         * This is a conservative upper bound that avoids exceeding
> -         * max_map_count. Leave half for non-coroutine users like library
> -         * dependencies, vhost-user, etc. Each coroutine takes up 2 VMAs so
> -         * halve the amount again.
> +         * This is an upper bound that avoids exceeding max_map_count. Leave a
> +         * fixed amount for non-coroutine users like library dependencies,
> +         * vhost-user, etc. Each coroutine takes up 2 VMAs so halve the
> +         * remaining amount.
>           */
> -        return max_map_count / 4;
> +        if (max_map_count > 5000) {
> +            return (max_map_count - 5000) / 2;
> +        } else {
> +            /* Disable the global pool but threads still have local pools */
> +            return 0;
> +        }
>      }
>  #endif

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


