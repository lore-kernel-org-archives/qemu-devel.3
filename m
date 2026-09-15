Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B637C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6W4X-0006IQ-VS; Tue, 15 Sep 2026 12:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x6W4N-00063B-4E
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x6W4K-0003u9-Fq
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789489898;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+GwKKNx6m5OM6MqSOp1FOXCkghAqwRgLLCpLbhxKas=;
 b=B7wowTkHJSRLTO3C+zumxzWIgrhUXr5SIbe3zQ8udDX9u1FwL/+8crjhBxSrvV14SuYIsJ
 tF6IkyghC5bzgeHrrc22hEe/F2Z/5w0LTmVCXsNeYelmWUAzGmbHqxck3KfpZ5kegYsxmO
 fG5MxN4sjUwZw6LIQy7ekriQDkZhxOE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-Z3PC60uaM3q1UhdhD5ImXQ-1; Tue,
 15 Sep 2026 12:31:36 -0400
X-MC-Unique: Z3PC60uaM3q1UhdhD5ImXQ-1
X-Mimecast-MFC-AGG-ID: Z3PC60uaM3q1UhdhD5ImXQ_1789489895
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FA461955BC9; Tue, 15 Sep 2026 16:31:34 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BF1F426; Tue, 15 Sep 2026 16:31:31 +0000 (UTC)
Date: Tue, 15 Sep 2026 17:31:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?0J3QuNC60L7Qu9Cw0Lkg0JfQvtGA0LjQvQ==?= <zorin@swemel.ru>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, mst@redhat.com,
 stefanha@redhat.com, kwolf@redhat.com, marcandre.lureau@redhat.com,
 mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/display/tcx: use memmove instead of memcpy for
 overlapping blit memory regions
Message-ID: <aqly4GgJs7XSn3-D@redhat.com>
References: <da75d0f0-d98e-4e27-ac6c-c575a2d382ff@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da75d0f0-d98e-4e27-ac6c-c575a2d382ff@swemel.ru>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Sep 15, 2026 at 07:20:46PM +0300, Николай Зорин wrote:
> SWSA#34e3af79-c6c2-4ad2-986f-313c1ce28e5a

  ^^^^^^^^^  what is this ?

I'm guessing it is a tag you're using for tracking issues, but
if so, it should be removed before sending commits upstream.

> 
> In `tcx_blit_writel()`, memory copying occurs within the same video RAM
> buffers (`vram` and `vram24`) using source and destination offsets that
> can potentially overlap during blit operations.
> 
> Using `memcpy()` on overlapping memory regions triggers undefined behavior
> according to the C standard. Depending on compiler optimizations, this
> can lead to graphical artifacts, memory corruption, or unexpected
> behavior in the guest system.
> 
> Fix this by replacing `memcpy()` with `memmove()`, which explicitly
> guarantees safe and correct behavior when memory regions overlap.
> 
> Signed-off-by: Nikolay N Zorin <zorin@swemel.ru>
> ---
>  hw/display/tcx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> index 2cfc1e8f..fb48a199 100644
> --- a/hw/display/tcx.c
> +++ b/hw/display/tcx.c
> @@ -587,9 +587,9 @@ static void tcx_blit_writel(void *opaque, hwaddr addr,
>                  }
>              }
>          } else {
> -            memcpy(&s->vram[addr], &s->vram[adsr], len);
> +            memmove(&s->vram[addr], &s->vram[adsr], len);
>              if (s->depth == 24) {
> -                memcpy(&s->vram24[addr], &s->vram24[adsr], len * 4);
> +                memmove(&s->vram24[addr], &s->vram24[adsr], len * 4);
>              }
>          }
>          tcx_set_dirty(s, addr, len);
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


