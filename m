Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249E4C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 10:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reXqD-0004Cz-Nl; Mon, 26 Feb 2024 05:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1reXqB-0004Bh-7D
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:04:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1reXq8-0004Yd-OS
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708941842;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D3HB8iP+E4RiAxS+OQNmFELAMsX8YUGYPIgQpJXF6Jg=;
 b=WYh3XTFcP4QJR5t/sTpydUZdYzjhrkGWl6zyCNMju7SYMDKOqamKu9z8chKtJreaRtW64y
 WwWAccRf0FgkchXgzVPgfedshLDgEM0z0IOhHWOzNHCoaTSFcLNTlE6JoS77y+TTWKqeGc
 8ZG4m2/bpns5aQRraL1sXFbJfwCX7yE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-yLq1UHw1P8KituBT3CxQLg-1; Mon, 26 Feb 2024 05:03:57 -0500
X-MC-Unique: yLq1UHw1P8KituBT3CxQLg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3CDE83B8E8;
 Mon, 26 Feb 2024 10:03:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8F542026D0A;
 Mon, 26 Feb 2024 10:03:52 +0000 (UTC)
Date: Mon, 26 Feb 2024 10:03:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: dinglimin <dinglimin@cmss.chinamobile.com>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] semihosting/uaccess.c: Replaced a malloc call with
 g_malloc
Message-ID: <ZdxiBvKPrynexuZl@redhat.com>
References: <20240226090628.1986-1-dinglimin@cmss.chinamobile.com>
 <2b3f15a8-93ba-4d4f-bfd6-7af11aade2dc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b3f15a8-93ba-4d4f-bfd6-7af11aade2dc@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Feb 26, 2024 at 10:48:14AM +0100, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 26/2/24 10:06, dinglimin wrote:
> > Signed-off-by: dinglimin <dinglimin@cmss.chinamobile.com>
> > ---
> >   semihosting/uaccess.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
> > index dc587d73bc..7788ead9b2 100644
> > --- a/semihosting/uaccess.c
> > +++ b/semihosting/uaccess.c
> > @@ -14,10 +14,10 @@
> >   void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
> >                           target_ulong len, bool copy)
> >   {
> > -    void *p = malloc(len);
> > +    void *p = g_try_malloc(len);
> >       if (p && copy) {
> >           if (cpu_memory_rw_debug(env_cpu(env), addr, p, len, 0)) {
> > -            free(p);
> > +            g_free(p);
> >               p = NULL;
> >           }
> >       }
> 
> This seems dangerous, now all users of uaccess_lock_user() must
> use g_free(), in particular lock_user_string() which is used more
> than a hundred of times:

This is not true for many years now.

GLib is hardcoded to always use the system allocator, so g_malloc
can be freely mixed with free, and vica-verca.

Using 'g_free' is stylistically preferred, but not functionally
required.

> 
> $ git grep -w lock_user_string | wc -l
>      116
> 
> > @@ -87,5 +87,5 @@ void uaccess_unlock_user(CPUArchState *env, void *p,
> >       if (len) {
> >           cpu_memory_rw_debug(env_cpu(env), addr, p, len, 1);
> >       }
> > -    free(p);
> > +    g_free(p);
> >   }
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


