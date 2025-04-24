Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51B2C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tr0-00047b-67; Thu, 24 Apr 2025 06:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7tqo-00045E-Lu
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7tqm-0007Mt-1H
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745490632;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+AI9gb5CODDIeqPqOGYJ+kaqRJcROI9Fnwi4nnqUw2w=;
 b=JAh3pD4y2PLmdIxNbIaObvpLHwx9D+gbZmmfrttvUTaF3Tj2NwbkHbmci3cRzKLdH1dH1m
 HyghF0QuS/R1B+v+zpl3oap5yxR8oDSwgDP0PF3b2RWzrU0vSEwHrPPMxtB+u8yhNzOVsx
 KviDQ4aT1lcPL4aEXQsJcQfP+VhvaoY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-YWPjtw6oNamVf8-7JUfUSw-1; Thu,
 24 Apr 2025 06:30:30 -0400
X-MC-Unique: YWPjtw6oNamVf8-7JUfUSw-1
X-Mimecast-MFC-AGG-ID: YWPjtw6oNamVf8-7JUfUSw_1745490629
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D0441800263; Thu, 24 Apr 2025 10:30:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.118])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65ED3195608D; Thu, 24 Apr 2025 10:30:25 +0000 (UTC)
Date: Thu, 24 Apr 2025 11:30:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 4/9] h264: search for available h264 encoder
Message-ID: <aAoSvoQEGc78WRby@redhat.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-5-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250418112953.1744442-5-dietmar@proxmox.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Apr 18, 2025 at 01:29:48PM +0200, Dietmar Maurer wrote:
> The search list is currently hardcoded to: ["x264enc", "openh264enc"]
> 
> x264enc: is probably the best available software encoder
> openh264enc: lower quality, but available on more systems.
> 
> We restrict encoders to a known list because each encoder requires
> fine tuning to get reasonable/usable results.
> 
> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
> ---
>  ui/vnc-enc-h264.c | 89 +++++++++++++++++++++++++++++++++++++++--------
>  ui/vnc.h          |  1 +
>  2 files changed, 75 insertions(+), 15 deletions(-)
> 
> diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
> index 3abe6a1528..047f4a3128 100644
> --- a/ui/vnc-enc-h264.c
> +++ b/ui/vnc-enc-h264.c

> @@ -172,9 +220,20 @@ static bool create_encoder_context(VncState *vs, int w, int h)
>  
>  bool vnc_h264_encoder_init(VncState *vs)
>  {
> +    const char *encoder_name;
> +
>      g_assert(vs->h264 == NULL);
>  
> +    encoder_name = get_available_encoder();
> +    if (encoder_name == NULL) {
> +        VNC_DEBUG("No H264 encoder available.\n");
> +        return -1;

This method has return type 'bool', not 'int', this needs
to be 'false'.

> +    }
> +
>      vs->h264 = g_new0(VncH264, 1);
> +    vs->h264->encoder_name = encoder_name;
> +
> +    VNC_DEBUG("Allow H264 using encoder '%s`\n", encoder_name);
>  
>      return true;
>  }


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


