Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1B1C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 12:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYPz2-0005Xz-Sd; Fri, 09 Feb 2024 07:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYPys-0005Vz-Rs
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:27:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYPyp-0000qh-2X
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707481660;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GmpUBdzzmw+IIjee5eDNdheYjASDc+p95ArjYYv/Wtw=;
 b=X+dfAhG+Ce16/CkZw3P2Ppib8f+cSTxhJ/Gb3qIhyjnkWEilHqzMrY8yEyoCLdzkyMDaM7
 qiDwzcU6QQF+k4HkCsDXQGEPv1Nxpq7gvuCPmbQyjrO1DQLMceILky204AjP4JDW/xDkkv
 Db7kY+6ECK+W1zELfIon7lVDFjvAQRU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-CeVEExZEP1ShedMpu1kKJg-1; Fri,
 09 Feb 2024 07:27:38 -0500
X-MC-Unique: CeVEExZEP1ShedMpu1kKJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63E8D3C0ED55;
 Fri,  9 Feb 2024 12:27:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7735CC08EF7;
 Fri,  9 Feb 2024 12:27:37 +0000 (UTC)
Date: Fri, 9 Feb 2024 12:27:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 5/7] block: Support detached LUKS header creation
 using qemu-img
Message-ID: <ZcYaNpZx5ungAzrt@redhat.com>
References: <cover.1706586786.git.yong.huang@smartx.com>
 <c573cf4d985b0386e2e419fcccd92245800cdeca.1706586786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c573cf4d985b0386e2e419fcccd92245800cdeca.1706586786.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 30, 2024 at 01:37:23PM +0800, yong.huang@smartx.com wrote:
> From: Hyman Huang <yong.huang@smartx.com>
> 
> Even though a LUKS header might be created with cryptsetup,
> qemu-img should be enhanced to accommodate it as well.
> 
> Add the 'detached-header' option to specify the creation of
> a detached LUKS header. This is how it is used:
> $ qemu-img create --object secret,id=sec0,data=abc123 -f luks
> > -o cipher-alg=aes-256,cipher-mode=xts -o key-secret=sec0
> > -o detached-header=true header.luks
> 
> Using qemu-img or cryptsetup tools to query information of
> an LUKS header image as follows:
> 
> Assume a detached LUKS header image has been created by:
> $ dd if=/dev/zero of=test-header.img bs=1M count=32
> $ dd if=/dev/zero of=test-payload.img bs=1M count=1000
> $ cryptsetup luksFormat --header test-header.img test-payload.img
> > --force-password --type luks1
> 
> Header image information could be queried using cryptsetup:
> $ cryptsetup luksDump test-header.img
> 
> or qemu-img:
> $ qemu-img info 'json:{"driver":"luks","file":{"filename":
> > "test-payload.img"},"header":{"filename":"test-header.img"}}'
> 
> When using qemu-img, keep in mind that the entire disk
> information specified by the JSON-format string above must be
> supplied on the commandline; if not, an overlay check will reveal
> a problem with the LUKS volume check logic.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  block.c          |  5 ++++-
>  block/crypto.c   | 10 +++++++++-
>  block/crypto.h   |  8 ++++++++
>  qapi/crypto.json |  5 ++++-
>  4 files changed, 25 insertions(+), 3 deletions(-)


> diff --git a/block/crypto.c b/block/crypto.c
> index 8e7ee5e9ac..65426d3a16 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -791,6 +792,9 @@ block_crypto_co_create_opts_luks(BlockDriver *drv, const char *filename,
>      PreallocMode prealloc;
>      char *buf = NULL;
>      int64_t size;
> +    bool detached_hdr =
> +        qemu_opt_get_bool(opts, "detached-header", false);
> +    unsigned int cflags = 0;
>      int ret;
>      Error *local_err = NULL;
>  
> @@ -830,6 +834,10 @@ block_crypto_co_create_opts_luks(BlockDriver *drv, const char *filename,
>          goto fail;
>      }
>  
> +    if (detached_hdr) {
> +        cflags |= QCRYPTO_BLOCK_CREATE_DETACHED;
> +    }
> +

We're setting cflags but not using it ever.

>      /* Create format layer */
>      ret = block_crypto_co_create_generic(bs, size, create_opts,
>                                           prealloc, 0, errp);

This '0' here should be replaced by 'cflags', since you're
checking for QCRYPTO_BLOCK_CREATE_DETACHED inside the
block_crypto_co_create_generic method.

I'll make this change when I merge this, so no need to resend.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


