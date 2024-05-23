Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3053EC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAAA4-0004yQ-Jp; Thu, 23 May 2024 11:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sAAA2-0004tc-E3
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:15:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sAA9y-0007Nz-Pa
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716477313;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W3GlEqbSxZzOsIX3e2lb34Sq+70dc8rMOrd7uB7Ro8o=;
 b=CdRNx+mrK8nVXzjL69vRkPE7zP2OWvEghpJwf69k7RdRUqPGPrvDg0vkH+l2TN+j6xVyFH
 KLzHLg+1HbimnHlfVA2XxCp77X3cuA6ZFIyhmXX5evV5G7tf9tnxGgRE6x+m51TAEBTeSC
 Y6JyNxWaqqrxNgAuk8tyKcfQgGQqODs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-_qptJXmDM9eT7osVh7BtsA-1; Thu,
 23 May 2024 11:15:09 -0400
X-MC-Unique: _qptJXmDM9eT7osVh7BtsA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 992BF3806701;
 Thu, 23 May 2024 15:15:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7814F200A35C;
 Thu, 23 May 2024 15:14:53 +0000 (UTC)
Date: Thu, 23 May 2024 16:14:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, gmaglione@redhat.com,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v5 09/13] osdep: move O_DSYNC and O_DIRECT defines from
 file-posix
Message-ID: <Zk9daPZHwpQktl9G@redhat.com>
References: <20240523145522.313012-1-sgarzare@redhat.com>
 <20240523145522.313012-10-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240523145522.313012-10-sgarzare@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, May 23, 2024 at 04:55:18PM +0200, Stefano Garzarella wrote:
> These defines are also useful for vhost-user-blk when it is compiled
> in some POSIX systems that do not define them, so let's move them to
> “qemu/osdep.h”.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/qemu/osdep.h | 14 ++++++++++++++
>  block/file-posix.c   | 14 --------------
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index f61edcfdc2..e165b5cb1b 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -325,6 +325,20 @@ void QEMU_ERROR("code path is reachable")
>  #define ESHUTDOWN 4099
>  #endif
>  
> +/* OS X does not have O_DSYNC */
> +#ifndef O_DSYNC
> +#ifdef O_SYNC
> +#define O_DSYNC O_SYNC
> +#elif defined(O_FSYNC)
> +#define O_DSYNC O_FSYNC
> +#endif
> +#endif
> +
> +/* Approximate O_DIRECT with O_DSYNC if O_DIRECT isn't available */
> +#ifndef O_DIRECT
> +#define O_DIRECT O_DSYNC
> +#endif

Please don't do this - we can't be confident that all code in
QEMU will be OK with O_DIRECT being simulated in this way.

I'm not convinced that the O_DSYNC simulation is a good idea
to do tree-wide either.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


