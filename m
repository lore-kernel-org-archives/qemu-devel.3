Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88250CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGtlC-0005cH-Mi; Wed, 14 Oct 2026 03:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGtlA-0005bm-Fw
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 03:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGtl8-00070m-LZ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 03:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791964245;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lE8Rd/c04006GqQtZVHh7dDl52rVATSHQwAtJf/ReNQ=;
 b=Yz87bINiWnMAY/1nWa7sFCKK66H25fhDFybVmVNTTGTNLuSRHuplW6V3vu+tYDWoqx2MwN
 bDURaxrFOHGPRKS/xpvhFbD0dD4UGnelSnoRUjyFRedfFEobcK9fUTdgEnsoLXiVt0pTJb
 9xCOxX8707+SOyqFRknrz9ybDlk15OY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-g0ghRFhTP1CI--tM5w_5UA-1; Wed,
 14 Oct 2026 07:50:41 +0000
X-MC-Unique: g0ghRFhTP1CI--tM5w_5UA-1
X-Mimecast-MFC-AGG-ID: g0ghRFhTP1CI--tM5w_5UA_1791964241
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 623BA180048E; Wed, 14 Oct 2026 07:50:40 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3890A1800444; Wed, 14 Oct 2026 07:50:36 +0000 (UTC)
Date: Wed, 14 Oct 2026 08:50:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Wesley Hershberger <wesley.hershberger@canonical.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Hector Cao <hector.cao@canonical.com>, alex.ramirez@canonical.com
Subject: Re: [PATCH v3 2/2] util/coroutine: Reduce default idle pool max size
Message-ID: <as80SlXCcNDoLHLj@redhat.com>
References: <20261013-set-default-pool-size-v3-0-d36e8c31f9a6@canonical.com>
 <20261013-set-default-pool-size-v3-2-d36e8c31f9a6@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261013-set-default-pool-size-v3-2-d36e8c31f9a6@canonical.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 13, 2026 at 05:01:01PM -0500, Wesley Hershberger wrote:
> If g_file_get_contents fails (AppArmor, etc), use a more conservative
> default max size for the idle coroutine pool.
> 
> This avoids any possibility of the failure described in 86a637e48104
> unless the host kernel is configured with a lower-than-default
> vm.max_map_count.
> 
> This change is motivated by a discussion of backport risk:
> https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2168803/comments/8
> 
> Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
> ---
>  util/qemu-coroutine.c | 75 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 48 insertions(+), 27 deletions(-)
> 
> diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> index 5af61995437..8ced93144fa 100644
> --- a/util/qemu-coroutine.c
> +++ b/util/qemu-coroutine.c
> @@ -361,42 +361,63 @@ void qemu_coroutine_dec_pool_size(unsigned int removing_pool_size)
>      global_pool_max_size -= removing_pool_size;
>  }
>  
> -static unsigned int get_global_pool_hard_max_size(void)
> -{
>  #ifdef __linux__
> -    g_autofree char *contents = NULL;
> -    int max_map_count;
> +/*
> + * include/linux/mm.h
> + */
> +#define DEFAULT_MAX_MAP_COUNT 65530
>  
> -    /*
> -     * Linux processes can have up to max_map_count virtual memory areas
> -     * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond this limit. We
> -     * must limit the coroutine pool to a safe size to avoid running out of
> -     * VMAs.
> -     */
> -    if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, NULL,
> -                            NULL)) {
> +static unsigned int get_max_map_count(void)
> +{
> +    g_autofree char *contents = NULL;
> +    int max_map_count = 0;
> +    if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents,
> +                            NULL, NULL)) {
>          /* contents has trailing newline, remove it before conversion */
>          g_strchomp(contents);
> -        if (qemu_strtoi(contents, NULL, 10, &max_map_count) != 0) {
> -            return UINT_MAX;
> -        }
> -        /*
> -         * This is an upper bound that avoids exceeding max_map_count. Leave a
> -         * fixed amount for non-coroutine users like library dependencies,
> -         * vhost-user, etc. Each coroutine takes up 2 VMAs so halve the
> -         * remaining amount.
> -         */
> -        if (max_map_count > 5000) {
> -            return (max_map_count - 5000) / 2;
> -        } else {
> -            /* Disable the global pool but threads still have local pools */
> -            return 0;
> +        if (qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
> +            return max_map_count;
>          }
>      }
> -#endif
> +    return 0;
> +}

I'm now realizing we could just return DEFAULT_MAX_MAP_COUNT
here and removed the conditional in the caller.

>  
> +/*
> + * Linux processes can have up to max_map_count virtual memory areas
> + * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond this limit. We
> + * must limit the coroutine pool to a safe size to avoid running out of
> + * VMAs.
> + */
> +static unsigned int get_global_pool_hard_max_size(void)
> +{
> +    /*
> +     * Read from /proc might fail due to mandatory access control (AppArmor,
> +     * SELinux, etc). Use the kernel's default in that case.
> +     */
> +    int max_map_count = get_max_map_count();
> +    if (!max_map_count) {
> +        max_map_count = DEFAULT_MAX_MAP_COUNT;
> +    }
> +
> +    /*
> +     * This is an upper bound that avoids exceeding max_map_count. Leave a
> +     * fixed amount for non-coroutine users like library dependencies,
> +     * vhost-user, etc. Each coroutine takes up 2 VMAs so halve the
> +     * remaining amount.
> +     */
> +    if (max_map_count > 5000) {
> +        return (max_map_count - 5000) / 2;
> +    } else {
> +        /* Disable the global pool but threads still have local pools */
> +        return 0;
> +    }
> +}
> +#else
> +static unsigned int get_global_pool_hard_max_size(void)
> +{
>      return UINT_MAX;
>  }
> +#endif
>  
>  static void __attribute__((constructor)) qemu_coroutine_init(void)
>  {
> 
> -- 
> 2.53.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


