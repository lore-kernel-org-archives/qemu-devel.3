Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AADC369D1
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 12:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ZXf-0002L8-Iv; Wed, 23 Apr 2025 08:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7ZXd-0002Hu-F3
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:49:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7ZXb-0005eQ-C5
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745412566;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=N9HYsIgZ69LvudZidgFbA83Asw5v53wHKfF8qnqhKtk=;
 b=JAViCv8x9gHlOfkrntHj4/jIxQ/KIj/uHC8WT1/euvfayuwo1WA6SNHHs3vTt7cbbld6aa
 lDeC/Wo0iaG0x9JYFEK9MHSk0jmrUVTAJdJGyReDds1cO1YvNAQpeKsRITPo7svr+rBL14
 uk93T64kQb5OQS42YxAdphYqqmnq5n4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-NOqeK1dNMKCe2sMHx9Rcag-1; Wed,
 23 Apr 2025 08:49:24 -0400
X-MC-Unique: NOqeK1dNMKCe2sMHx9Rcag-1
X-Mimecast-MFC-AGG-ID: NOqeK1dNMKCe2sMHx9Rcag_1745412563
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CF2A1801325; Wed, 23 Apr 2025 12:49:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.34])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A99E719560B3; Wed, 23 Apr 2025 12:49:20 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:49:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 6/9] h264: add hardware encoders
Message-ID: <aAjhzHZNkgTmnjsM@redhat.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-7-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250418112953.1744442-7-dietmar@proxmox.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Fri, Apr 18, 2025 at 01:29:50PM +0200, Dietmar Maurer wrote:

....could at lesat explain what the chosen encoders are..

> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
> ---
>  ui/vnc-enc-h264.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
> index 0f89cafbf6..840674dbdb 100644
> --- a/ui/vnc-enc-h264.c
> +++ b/ui/vnc-enc-h264.c
> @@ -29,15 +29,17 @@
>  
>  static char *get_available_encoder(const char *encoder_list)
>  {
> +    char *ret = NULL;
> +    char **encoder_array = NULL;
> +
>      g_assert(encoder_list != NULL);
>  
>      if (!strcmp(encoder_list, "")) {
>          /* use default list */
> -        encoder_list = "x264enc openh264enc";
> +        encoder_list = "nvh264enc vaapih264enc x264enc openh264enc";
>      }
>  
> -    char *ret = NULL;
> -    char **encoder_array = g_strsplit(encoder_list, " ", -1);
> +    encoder_array = g_strsplit(encoder_list, " ", -1);
>  
>      int i = 0;
>      do {
> @@ -69,7 +71,19 @@ static GstElement *create_encoder(const char *encoder_name)
>          return NULL;
>      }
>  
> -    if (!strcmp(encoder_name, "x264enc")) {
> +    if (!strcmp(encoder_name, "nvh264enc")) {
> +        g_object_set(
> +            encoder,
> +            "preset", 8,         /* p1 - fastest */
> +            "multi-pass", 1,     /* multipass disabled */
> +            "tune", 2,           /* low latency */
> +            "zerolatency", true, /* low latency */
> +            /* avoid access unit delimiters (Nal Unit Type 9) - not required */
> +            "aud", false,
> +            NULL);
> +    } else if (!strcmp(encoder_name, "vaapih264enc")) {
> +        g_object_set(encoder, "tune", 1, NULL); /* high compression */
> +    } else if (!strcmp(encoder_name, "x264enc")) {
>          g_object_set(
>              encoder,
>              "tune", 4, /* zerolatency */

Feels like this patch could jsut be folded into patch 4 that first
introduces this method.

> -- 
> 2.39.5
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


