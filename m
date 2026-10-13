Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C80CC6B16
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGej4-0005JA-IZ; Tue, 13 Oct 2026 11:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGej1-0005IO-5U
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGeiy-0005UY-JP
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791906450;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DVMP1W0wHDGEJfMP7+llEpLNPwYpWq1zbUH0z/EexQk=;
 b=UL2bFh+bsWCYmSQYYscbtC8KdmNgWHQGMj3fOzk0NHytlpZID+NawsCni/A2gbSidg4hIi
 8jnwnwjrMxUDYXJKw4hG3Wr/pvy829kIw4XeXNL7J+85E5xDSDMtD0YBV5IxvJPrieRR/m
 f0wfBcz/PApucF4vT0Mc+fEOp4QSfaM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-aSA1Vf7HM1KwQ4kBDKnv9w-1; Tue,
 13 Oct 2026 15:47:25 +0000
X-MC-Unique: aSA1Vf7HM1KwQ4kBDKnv9w-1
X-Mimecast-MFC-AGG-ID: aSA1Vf7HM1KwQ4kBDKnv9w_1791906444
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A22BF1977580; Tue, 13 Oct 2026 15:47:23 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A528A1800446; Tue, 13 Oct 2026 15:47:21 +0000 (UTC)
Date: Tue, 13 Oct 2026 16:47:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Wesley Hershberger <wesley.hershberger@canonical.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Hector Cao <hector.cao@canonical.com>, alex.ramirez@canonical.com
Subject: Re: [PATCH v2 2/2] util/coroutine: Reduce default idle pool max size
Message-ID: <as5Shuj9MJy_zlNn@redhat.com>
References: <20261013-set-default-pool-size-v2-0-f4fd6f2a3303@canonical.com>
 <20261013-set-default-pool-size-v2-2-f4fd6f2a3303@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013-set-default-pool-size-v2-2-f4fd6f2a3303@canonical.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 13, 2026 at 10:21:59AM -0500, Wesley Hershberger wrote:
> If g_file_get_contents fails (AppArmor or other LSM), use a more
> conservative default max size for the idle coroutine pool; this avoids
> any possibility of the failure described in 86a637e48104 unless the host
> kernel is configured with a low vm.max_map_count.
> 
> This change is motivated by a discussion of backport risk:
> https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2168803/comments/8
> 
> Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
> Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
> ---
>  util/qemu-coroutine.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> index 5af61995437..cfe10c033e4 100644
> --- a/util/qemu-coroutine.c
> +++ b/util/qemu-coroutine.c
> @@ -366,6 +366,11 @@ static unsigned int get_global_pool_hard_max_size(void)
>  #ifdef __linux__
>      g_autofree char *contents = NULL;
>      int max_map_count;
> +    /*
> +     * Read from /proc might fail due to LSM; use (DEFAULT_MAX_MAP_COUNT - 5000)
> +     * for distributions that don't change the kernel default
> +     */
> +    int default_pool_hard_max_size = 60530 / 2;
>  
>      /*
>       * Linux processes can have up to max_map_count virtual memory areas
> @@ -378,7 +383,7 @@ static unsigned int get_global_pool_hard_max_size(void)
>          /* contents has trailing newline, remove it before conversion */
>          g_strchomp(contents);
>          if (qemu_strtoi(contents, NULL, 10, &max_map_count) != 0) {
> -            return UINT_MAX;
> +            return default_pool_hard_max_size;
>          }
>          /*
>           * This is an upper bound that avoids exceeding max_map_count. Leave a
> @@ -395,7 +400,7 @@ static unsigned int get_global_pool_hard_max_size(void)
>      }
>  #endif
>  
> -    return UINT_MAX;
> +    return default_pool_hard_max_size;

This code is outside the __linux__ condition, but this is now applying
a Linux derived limit to it.

I'd suggest splitting the methods so it is more like this:

#ifdef __linux__
static unsigned int get_max_map_count(void)
{
    g_autofree char *contents = NULL;
    if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents,
                            NULL, NULL)) {
        g_strchomp(contents);
        if (qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
            return max_map_count;
        }
    }
    return 0;
}

static unsigned int get_global_pool_hard_max_size(void)
{
    int max_map_count = get_max_map_count();
    if (!max_map_count) {
        max_map_count = 65530;
    }
    ...snip comments...
    if (max_map_count > 5000) {
        return (max_map_count - 5000) / 2;
    } else {
        /* Disable the global pool but threads still have local pools */
        return 0;
    }
}
#else
static unsigned int get_global_pool_hard_max_size(void)
{
    return UINT_MAX;
}
#endif

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


