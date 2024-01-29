Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB922C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXKg-0007KA-Sm; Mon, 29 Jan 2024 14:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUXKb-0007AI-Lt
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:30:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUXKZ-0003dH-IP
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706556606;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TkomzELiwYtsCz2Zbt/z/tr8CwpLA4S47VhpmTi+tV8=;
 b=eSFgpNnU0u4n/5lL+xiDlwEW9iNghOezHA2OL3x7fMwlDdDdfVg5XOVVU0gs8n4zDVt5P8
 pzNtx6jy4qDGZZc62UtbNp4q06ZpT4ulwyNFBQ/tm4OcQC3nkqYxTKWD+sJGoH7XV/79TU
 /576qmTZUZ6uZSL72cK9tmxY0zmVJCg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-bQDg-opCNFW3PhYsgZO-Uw-1; Mon, 29 Jan 2024 14:30:04 -0500
X-MC-Unique: bQDg-opCNFW3PhYsgZO-Uw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54D0A881B6F
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 19:30:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 918F61121313;
 Mon, 29 Jan 2024 19:30:03 +0000 (UTC)
Date: Mon, 29 Jan 2024 19:30:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony Harivel <aharivel@redhat.com>, mtosatti@redhat.com,
 qemu-devel@nongnu.org, vchundur@redhat.com
Subject: Re: [PATCH v3 1/3] qio: add support for SO_PEERCRED for socket channel
Message-ID: <Zbf8udhDne9wk1Ao@redhat.com>
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-2-aharivel@redhat.com>
 <ZbKOZpi0v3sdKV8q@redhat.com>
 <CABgObfYbGHS_2drz31kGd_KbQKNwaFVSL4TxoE=AJj-W6jqAAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfYbGHS_2drz31kGd_KbQKNwaFVSL4TxoE=AJj-W6jqAAg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jan 29, 2024 at 08:25:29PM +0100, Paolo Bonzini wrote:
> On Thu, Jan 25, 2024 at 5:38 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > +static void
> > > +qio_channel_socket_get_peerpid(QIOChannel *ioc,
> > > +                               unsigned int *pid,
> > > +                               Error **errp)
> > > +{
> > > +#ifdef CONFIG_LINUX
> > > +    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
> > > +    Error *err = NULL;
> > > +    socklen_t len = sizeof(struct ucred);
> > > +
> > > +    struct ucred cred;
> > > +    if (getsockopt(sioc->fd,
> > > +               SOL_SOCKET, SO_PEERCRED,
> > > +               &cred, &len) == -1) {
> > > +        error_setg_errno(&err, errno, "Unable to get peer credentials");
> > > +        error_propagate(errp, err);
> > > +    }
> > > +    *pid = (unsigned int)cred.pid;
> > > +#else
> > > +    *pid = 0;
> >
> > Defaulting 'pid' to 0 is potentially unsafe, because to a caller it
> > now appears that the remote party is 'root' and thus implied to be
> > a privileged account.
> 
> This is a pid, so 0 cannot be confused; however, I agree that
> returning an error is better.

Opps, face-palm  !



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


