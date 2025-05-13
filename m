Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A195C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 11:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEnZs-0004DI-Rh; Tue, 13 May 2025 07:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEnZo-0004Cg-Rd
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:13:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEnZl-0006PA-S9
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747134812;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cc0CAME9WGkKbGHyo/DZq9Ciki8c3+JhcginYJ8A8EY=;
 b=BY4fre/fH/IUiEQBqgTHVw2UUkZNzkf34ECfu10H1Xl/Cqqcwf3UmO2X8GOkUwiLtIK6hg
 yqOn9oDqPwwQmxtTebvkh9raFlgYO6MyWCFaX9jO3LqL+yH31/ls3YazQJldqTdqHwerLp
 iORrH2NtmPrVFianknyJV0enTHmQ/nE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-XRo0Mc36OTWMFaNXo3UP8w-1; Tue,
 13 May 2025 07:13:29 -0400
X-MC-Unique: XRo0Mc36OTWMFaNXo3UP8w-1
X-Mimecast-MFC-AGG-ID: XRo0Mc36OTWMFaNXo3UP8w_1747134808
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 236D01800368; Tue, 13 May 2025 11:13:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 973331953B82; Tue, 13 May 2025 11:13:26 +0000 (UTC)
Date: Tue, 13 May 2025 12:13:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 1/3] ui/vnc.c: replace big endian flag with byte order
 value
Message-ID: <aCMpU_n2GK1_a8UJ@redhat.com>
References: <20250513100819.1179249-1-berrange@redhat.com>
 <20250513100819.1179249-2-berrange@redhat.com>
 <6c9f7141-8b2e-4b58-9ade-134a7289cff6@linaro.org>
 <caf9f1e2-fe92-48bb-92d9-17e5a5f61476@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <caf9f1e2-fe92-48bb-92d9-17e5a5f61476@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, May 13, 2025 at 12:11:05PM +0100, Philippe Mathieu-Daudé wrote:
> On 13/5/25 13:08, Philippe Mathieu-Daudé wrote:
> > On 13/5/25 12:08, Daniel P. Berrangé wrote:
> > > From: Daniel P. Berrangé <berrange@redhat.com>
> > > 
> > > It will make it easier to do certain comparisons in future if we
> > > store G_BIG_ENDIAN/G_LITTLE_ENDIAN directly, instead of a boolean
> > > flag.
> > > 
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > ---
> > >   ui/vnc-enc-tight.c | 2 +-
> > >   ui/vnc-enc-zrle.c  | 2 +-
> > >   ui/vnc-jobs.c      | 2 +-
> > >   ui/vnc.c           | 6 +++---
> > >   ui/vnc.h           | 2 +-
> > >   5 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > 
> > > diff --git a/ui/vnc.h b/ui/vnc.h
> > > index acc53a2cc1..f2a627dcdf 100644
> > > --- a/ui/vnc.h
> > > +++ b/ui/vnc.h
> > > @@ -323,7 +323,7 @@ struct VncState
> > >       VncWritePixels *write_pixels;
> > >       PixelFormat client_pf;
> > >       pixman_format_code_t client_format;
> > > -    bool client_be;
> > > +    int client_bo; /* G_LITTLE_ENDIAN or G_BIG_ENDIAN */
> 
> 'bo' = 'big order'?

bo == byte order.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


