Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AE1D1CDAC
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 07:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t39js-0007Yh-VC; Tue, 22 Oct 2024 03:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t39jr-0007YC-BF
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 03:55:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t39jp-0005EP-6t
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 03:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729583731;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Og0pMX1cNvVOgVZgaTEkN8qADkOzeIZsk1//g2dw/w=;
 b=a/0INVZ/BZKUyEWm+gTliZIeiJjuHg9wKHZ86bHY2yD1QHW3jS8DAh7at+f/PhjiV8iM4R
 w9eIe+781x1ME2qBZ8ph+XFJX0zaooeTHk1O3yPlXJaJNr5ulYT9lN1NEP7MEeExu9EE0U
 klNpH6/5NNXbsXKjE2Yqn0Doz7O40sM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-hqUsDfDWPTSdTowe2AWdSQ-1; Tue,
 22 Oct 2024 03:55:27 -0400
X-MC-Unique: hqUsDfDWPTSdTowe2AWdSQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA63E19560B8; Tue, 22 Oct 2024 07:55:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.59])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FCDC1956088; Tue, 22 Oct 2024 07:55:22 +0000 (UTC)
Date: Tue, 22 Oct 2024 08:55:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Andrew Keesler <ankeesler@google.com>,
 Roque Arcudia Hernandez <roqueh@google.com>, mst@redhat.com,
 qemu-devel@nongnu.org, venture@google.com
Subject: Re: [PATCH 1/2] ui: Allow injection of vnc display name
Message-ID: <ZxdaZ0_idsFl8Ti-@redhat.com>
References: <20241017215304.3916866-1-roqueh@google.com>
 <20241017215304.3916866-2-roqueh@google.com>
 <CAMxuvax3ZRcGGE7Lyq=j-3pGtJ3jThw+rFyHhdBbhbUCyVs6+g@mail.gmail.com>
 <CAGZECHPnD5XiZbGzHbxCEUOxE_CTR3ZOHBzF8+38xAqwYQAn_A@mail.gmail.com>
 <CAJ+F1CJXBRe4kgVA_bPoB0jZsWefba5JYY=pUbLt32tczSLhTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CJXBRe4kgVA_bPoB0jZsWefba5JYY=pUbLt32tczSLhTA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 22, 2024 at 11:49:46AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Oct 22, 2024 at 12:23 AM Andrew Keesler <ankeesler@google.com>
> wrote:
> 
> > Hi Marc-André -
> >
> > The ability to set the name with QMP qom-set seems like a nice behavior.
> >
> > Note that the ultimate goal of this name is to propagate it downstream to
> > a device (see next patch[0] for a sample propagation to virtio-gpu).
> >
> > In order to accomplish this, would it work to expose this new "head_name"
> > property via a qemu_graphic_console_get_head_name(QemuConsole *c) function
> > that:
> >
> > 1. verifies that c is indeed a QemuGraphicConsole with
> >    QEMU_IS_GRAPHIC_CONSOLE(), and
> > 2. returns c->head_name (similar to qemu_console_get_name() from [0])?
> >
> 
> > We'd probably need a similar function
> > qemu_graphic_console_get_head_name(QemuConsole *c, const char *name) in
> > order to
> > set the head_name from a display (e.g., VNC) - correct me if you were
> > thinking
> >
> 
> Right (qemu_graphic_console_set_head_name), get/set exposed to QOM via
> object_class_property_add_str()
> 
> 
> > of going a different direction with this interface, though. My main goal
> > is to
> > provide some way for a user to inject a display EDID name from the command
> > line.
> >
> > Also, just to verify my understanding - there would never be a QemuConsole
> > that
> > a) is NOT a QemuGraphicConsole AND b) is associated with an EDID in a
> > guest,
> > correct?
> >
> >
> Seems correct.
> 
> (fwiw, I think we should have all UI info(s) as part of QemuUIInfo,
> including the head name, but this would require further refactoring to
> avoid some copy etc)

QemuUIInfo is an internal struct, on the public side we have DisplayOptions
in QAPI which is where this should live. 


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


