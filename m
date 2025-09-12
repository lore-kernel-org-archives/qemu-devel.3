Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1DFCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 15:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux5RI-0003Xe-N5; Fri, 12 Sep 2025 11:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux5Qx-0003Ux-42
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 11:11:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux5Qs-0002l7-Uk
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 11:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757689876;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QCuls3ActUOdscIFQliUqDOlTaeTdzP3gvn/XMXkgX0=;
 b=DpPZ2aj4IKRC2dJprP290E7jiIPbFGnYVpqmtk5t/InBF71s/mPJ4M/8+6yoORPt7w7L7g
 R7Xb+TwgV5eHGN9IyWzsFVys32yYT9jaleDqtbvw6P4hWsBzuxJ8Yc1Y5ulFa5gF1OQz23
 1WYgpSltfA7FNcr22JZ7wnuLqmJIf/A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-IVhn3uQvOGiS0p-0x-5cjw-1; Fri,
 12 Sep 2025 11:11:14 -0400
X-MC-Unique: IVhn3uQvOGiS0p-0x-5cjw-1
X-Mimecast-MFC-AGG-ID: IVhn3uQvOGiS0p-0x-5cjw_1757689872
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C47311800577; Fri, 12 Sep 2025 15:11:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2F021800451; Fri, 12 Sep 2025 15:11:07 +0000 (UTC)
Date: Fri, 12 Sep 2025 16:11:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 09/20] ui/vnc: remove use of error_printf_unless_qmp()
Message-ID: <aMQ4CHyGN5D_HyiC@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-10-berrange@redhat.com>
 <74df1365-b9d7-448d-9edd-4a25b8dbf6a2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74df1365-b9d7-448d-9edd-4a25b8dbf6a2@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 11, 2025 at 05:54:48PM +0000, Richard Henderson wrote:
> On 9/10/25 18:03, Daniel P. Berrangé wrote:
> > The error_printf_unless_qmp() will print to the monitor if the current
> > one is HMP, if it is QMP nothing will be printed, otherwise stderr
> > will be used.
> > 
> > This scenario is easily handled by checking !monitor_cur_is_qmp() and
> > then calling the error_printf() function.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   ui/vnc.c | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/ui/vnc.c b/ui/vnc.c
> > index 68ca4a68e7..439d586358 100644
> > --- a/ui/vnc.c
> > +++ b/ui/vnc.c
> > @@ -3530,8 +3530,10 @@ int vnc_display_password(const char *id, const char *password)
> >           return -EINVAL;
> >       }
> >       if (vd->auth == VNC_AUTH_NONE) {
> > -        error_printf_unless_qmp("If you want use passwords please enable "
> > -                                "password auth using '-vnc ${dpy},password'.\n");
> > +        if (!monitor_cur_is_qmp()) {
> > +            error_printf("If you want use passwords please enable "
> > +                         "password auth using '-vnc ${dpy},password'.\n");
> > +        }
> >           return -EINVAL;
> >       }
> > @@ -3570,9 +3572,11 @@ static void vnc_display_print_local_addr(VncDisplay *vd)
> >           qapi_free_SocketAddress(addr);
> >           return;
> >       }
> > -    error_printf_unless_qmp("VNC server running on %s:%s\n",
> > -                            addr->u.inet.host,
> > -                            addr->u.inet.port);
> > +    if (!monitor_cur_is_qmp()) {
> > +        error_printf("VNC server running on %s:%s\n",
> > +                     addr->u.inet.host,
> > +                     addr->u.inet.port);
> > +    }
> >       qapi_free_SocketAddress(addr);
> >   }
> 
> With monitor_cur_hmp, you can use monitor_printf directly.

We still need to be able to print to stderr when there is neither HMP
nor QMP, which error_printf gets us, but monitor_printf would not.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


