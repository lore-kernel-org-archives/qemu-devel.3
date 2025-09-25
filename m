Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC19CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 21:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1tIV-0001tD-3R; Thu, 25 Sep 2025 17:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v1tI9-0001qx-I1
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 17:14:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v1tHt-00057W-OO
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 17:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758834831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=clnpiNGMgjzy34SVTV79KfS2QfeMmkFOWjVyr2sQDFA=;
 b=Fs2aMi+2xVXqeNFhnuX8N2LuKDfcIzyS2OE+pnBEBQbepNv/QGcxGKfaFkk8bevNvUw6rL
 nI6BJH0JhRy8mROv3iBnwZ04SiHHsgDNrlSAPGRDjyhYY1sDCtH35SRmw0TTGiXoldN6Q6
 7E8W9GDOQDJP7uKYjHJiEr0CFRw8hi8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-vtPK0CaGNZSL5zfgnQJ1QA-1; Thu,
 25 Sep 2025 17:13:48 -0400
X-MC-Unique: vtPK0CaGNZSL5zfgnQJ1QA-1
X-Mimecast-MFC-AGG-ID: vtPK0CaGNZSL5zfgnQJ1QA_1758834826
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 989A2197740B; Thu, 25 Sep 2025 21:13:45 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.89])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 808A21956095; Thu, 25 Sep 2025 21:13:40 +0000 (UTC)
Date: Thu, 25 Sep 2025 16:13:37 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 07/23] util: add API to fetch the current thread name
Message-ID: <p5yai6s3gtaopp4tnymql2lqqe42dimkhdevmvm4jm427eadpe@7sfg45r6aoz6>
References: <20250925094441.1651372-1-berrange@redhat.com>
 <20250925094441.1651372-8-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250925094441.1651372-8-berrange@redhat.com>
User-Agent: NeoMutt/20250510
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 25, 2025 at 10:44:25AM +0100, Daniel P. Berrangé wrote:
> This will be used to include the thread name in error reports
> in a later patch. It returns a const string stored in a thread
> local to avoid memory allocation when it is called repeatedly
> in a single thread. The thread name should be set at the very
> start of the thread execution, which is the case when using
> qemu_thread_create.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  include/qemu/thread.h    |  1 +
>  meson.build              | 21 +++++++++++++++++
>  util/qemu-thread-posix.c | 33 ++++++++++++++++++++++++++-
>  util/qemu-thread-win32.c | 49 ++++++++++++++++++++++++++++++++++++----
>  4 files changed, 99 insertions(+), 5 deletions(-)
> 

> +++ b/util/qemu-thread-posix.c

> +const char *qemu_thread_get_name(void)

> +# endif
> +    if (rv != 0) {
> +        strlcpy(namebuf, "unnamed", G_N_ELEMENTS(namebuf));

Should this be g_strlcpy() instead of strlcpy(), for consistency with
the Windows half of the patch, and since g_strlcpy() is much more
frequent in the QEMU codebase?

> +++ b/util/qemu-thread-win32.c

> @@ -38,14 +41,17 @@ static bool load_set_thread_description(void)
>              SetThreadDescriptionFunc =
>                  (pSetThreadDescription)GetProcAddress(kernel32_module,
>                                                        "SetThreadDescription");
> -            if (!SetThreadDescriptionFunc) {
> +            GetThreadDescriptionFunc =
> +                (pGetThreadDescription)GetProcAddress(kernel32_module,
> +                                                      "GetThreadDescription");
> +            if (!SetThreadDescriptionFunc || !GetThreadDescriptionFunc) {
>                  FreeLibrary(kernel32_module);
>              }
>          }
>          g_once_init_leave(&_init_once, 1);
>      }
>  
> -    return !!SetThreadDescriptionFunc;
> +    return !!(SetThreadDescriptionFunc && GetThreadDescriptionFunc);

Pre-patch, the !! was necessary for converting a pointer to a bool.
But && also converts to a bool, and "!!(bool)" is redundant compared
to just "bool".

But overall, the patch makes sense.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


