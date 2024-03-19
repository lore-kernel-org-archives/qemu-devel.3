Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384DEC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZkp-0000LC-Uo; Tue, 19 Mar 2024 09:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmZko-0000Kp-FE
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmZkm-0003Xd-Dd
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710855822;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=txDTDRa29mOwqVwt1WygCy1tWyRzi+Udm6UuwF7lexU=;
 b=HBJU7G1+7kefHIywemUNSWeKUvcBHZeU/YO5hiHbltH5iI40YteCEgUEY7dEsrry3/WSXE
 rBGhyKdFd4fT4m0bOofkE7WTNkGNgdm3iIltjHVabFWJBSjMpqVIQFhE+djFUC9NV5c0sg
 iVhx+4PB8SqlPwH4IHw/sdLTrhPv1E0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-w7JwCYhtMluEvvO6cwN2eA-1; Tue, 19 Mar 2024 09:43:40 -0400
X-MC-Unique: w7JwCYhtMluEvvO6cwN2eA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3683800268
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 13:43:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB6C41C060A4;
 Tue, 19 Mar 2024 13:43:38 +0000 (UTC)
Date: Tue, 19 Mar 2024 13:43:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Sanjay Rao <srao@redhat.com>, Boaz Ben Shabat <bbenshab@redhat.com>,
 Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH] coroutine: cap per-thread local pool size
Message-ID: <ZfmWhDaG5mN-GCeO@redhat.com>
References: <20240318183429.1039340-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240318183429.1039340-1-stefanha@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 18, 2024 at 02:34:29PM -0400, Stefan Hajnoczi wrote:
> The coroutine pool implementation can hit the Linux vm.max_map_count
> limit, causing QEMU to abort with "failed to allocate memory for stack"
> or "failed to set up stack guard page" during coroutine creation.
> 
> This happens because per-thread pools can grow to tens of thousands of
> coroutines. Each coroutine causes 2 virtual memory areas to be created.

This sounds quite alarming. What usage scenario is justified in
creating so many coroutines ?

IIUC, coroutine stack size is 1 MB, and so tens of thousands of
coroutines implies 10's of GB of memory just on stacks alone.

> Eventually vm.max_map_count is reached and memory-related syscalls fail.

On my system max_map_count is 1048576, quite alot higher than
10's of 1000's. Hitting that would imply ~500,000 coroutines and
~500 GB of stacks !

> diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> index 5fd2dbaf8b..2790959eaf 100644
> --- a/util/qemu-coroutine.c
> +++ b/util/qemu-coroutine.c

> +static unsigned int get_global_pool_hard_max_size(void)
> +{
> +#ifdef __linux__
> +    g_autofree char *contents = NULL;
> +    int max_map_count;
> +
> +    /*
> +     * Linux processes can have up to max_map_count virtual memory areas
> +     * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond this limit. We
> +     * must limit the coroutine pool to a safe size to avoid running out of
> +     * VMAs.
> +     */
> +    if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, NULL,
> +                            NULL) &&
> +        qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
> +        /*
> +         * This is a conservative upper bound that avoids exceeding
> +         * max_map_count. Leave half for non-coroutine users like library
> +         * dependencies, vhost-user, etc. Each coroutine takes up 2 VMAs so
> +         * halve the amount again.
> +         */
> +        return max_map_count / 4;

That's 256,000 coroutines, which still sounds incredibly large
to me.

> +    }
> +#endif
> +
> +    return UINT_MAX;

Why UINT_MAX as a default ?  If we can't read procfs, we should
assume some much smaller sane default IMHO, that corresponds to
what current linux default max_map_count would be.

> +}
> +
> +static void __attribute__((constructor)) qemu_coroutine_init(void)
> +{
> +    qemu_mutex_init(&global_pool_lock);
> +    global_pool_hard_max_size = get_global_pool_hard_max_size();
>  }
> -- 
> 2.44.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


