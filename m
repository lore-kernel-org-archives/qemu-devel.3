Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F244C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 16:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCLIB-0007f8-R8; Tue, 06 May 2025 12:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCLI9-0007eD-VW
 for qemu-devel@nongnu.org; Tue, 06 May 2025 12:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCLI8-0002g8-3l
 for qemu-devel@nongnu.org; Tue, 06 May 2025 12:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746549429;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/9NgYuk+qn1sAKzNi81FOEXjblYjXex7Vk6T+cuAZm0=;
 b=TaZq2H8SDZ3cGn/atYxxvcY4MXVml5ugB7sQiL5fOjIcZiP51wwXDqkSIUjsWJJSbkYXRM
 atTuzX0hC8mx8HI+zziLEd+0o0YR5Pgh4MId1CpkopO/cen9/atKzcjtBOUKzxTaETP5IN
 8Y3A/elJsaK2DcT46/kiwmKBitHo5P8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-bkzos4MAOWqrkBclYXUaSA-1; Tue,
 06 May 2025 12:37:05 -0400
X-MC-Unique: bkzos4MAOWqrkBclYXUaSA-1
X-Mimecast-MFC-AGG-ID: bkzos4MAOWqrkBclYXUaSA_1746549425
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF6621955E87; Tue,  6 May 2025 16:37:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6675718001EF; Tue,  6 May 2025 16:37:03 +0000 (UTC)
Date: Tue, 6 May 2025 17:37:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Elisha Hollander <just4now666666@gmail.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] util/memfd: allow allocating 0 bytes
Message-ID: <aBo6rDsbZGOfWfLP@redhat.com>
References: <CACkyd_bN=zx1LaLnrg-U35--jzF3Q3BA6ABBokQZjLznaHcjFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACkyd_bN=zx1LaLnrg-U35--jzF3Q3BA6ABBokQZjLznaHcjFg@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Tue, May 06, 2025 at 07:17:25PM +0300, Elisha Hollander wrote:
> Sorry for former patch something is messed up with my email.

The commit message needs to explain what problem is being solved by
making this change as allowing 0 bytes looks dubious on the surface.

> 
> Signed-off-by: donno2048 <just4now666666@gmail.com>
> ---
>  util/memfd.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/util/memfd.c b/util/memfd.c
> index 8a2e906..e96e5af 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -108,7 +108,7 @@ err:
>  void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,
>                         int *fd, Error **errp)
>  {
> - void *ptr;
> + void *ptr = NULL;
>      int mfd = qemu_memfd_create(name, size, false, 0, seals, NULL);
> 
>      /* some systems have memfd without sealing */
> @@ -131,9 +131,11 @@ void *qemu_memfd_alloc(const char *name, size_t size,
> unsigned int seals,
>          }
>      }
> 
> - ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
> - if (ptr == MAP_FAILED) {
> - goto err;
> + if (size != 0) {
> + ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
> + if (ptr == MAP_FAILED) {
> + goto err;
> + }
>      }

This patch is mangled.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


