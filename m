Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2216CEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1rq-0000gy-1N; Tue, 10 Sep 2024 10:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1so1rn-0000Yj-W7
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:29:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1so1rl-0000xa-Tt
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725978552;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZM+aJYRJxNCR224qImcQx368lWgT3HdpQeenS950bIc=;
 b=EWxbK2LFu6MBYv2itnyZMKvn4v3GP91ubrh9zgq+2npMd8uyjRIO2UcwhsPb5roNkmeE1E
 yRl+5n+VV7Y3rFZ4IbpjfMa83N+knoJ77338o8JvNHaOGiE0Y9lkBhjd2GovFxV6nKf5eJ
 L7F8n4lY+KWE80sTCT89Hffnnl87wZQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-q1UAIv6hNt6BI9c8LeWlOQ-1; Tue,
 10 Sep 2024 10:29:08 -0400
X-MC-Unique: q1UAIv6hNt6BI9c8LeWlOQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5C471955F3C; Tue, 10 Sep 2024 14:29:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 175561956086; Tue, 10 Sep 2024 14:28:59 +0000 (UTC)
Date: Tue, 10 Sep 2024 15:28:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Alexandre Ratchov <alex@caoua.org>, Thomas Huth <thuth@redhat.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Bandan Das <bsd@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [PULL 20/24] audio: Add sndio backend
Message-ID: <ZuBXqSoohgbS-rF6@redhat.com>
References: <20220927081912.180983-1-kraxel@redhat.com>
 <20220927081912.180983-21-kraxel@redhat.com>
 <fc493743-5ab0-49eb-98ed-dd260f0f60d6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc493743-5ab0-49eb-98ed-dd260f0f60d6@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 10, 2024 at 04:16:23PM +0200, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> (This is commit 663df1cc68).
> 
> On 27/9/22 10:19, Gerd Hoffmann wrote:
> > From: Alexandre Ratchov <alex@caoua.org>
> > 
> > sndio is the native API used by OpenBSD, although it has been ported to
> > other *BSD's and Linux (packages for Ubuntu, Debian, Void, Arch, etc.).
> > 
> > Signed-off-by: Brad Smith <brad@comstyle.com>
> > Signed-off-by: Alexandre Ratchov <alex@caoua.org>
> > Reviewed-by: Volker Rümelin <vr_qemu@t-online.de>
> > Tested-by: Volker Rümelin <vr_qemu@t-online.de>
> > Message-Id: <YxibXrWsrS3XYQM3@vm1.arverb.com>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >   meson_options.txt             |   4 +-
> >   audio/audio_template.h        |   2 +
> >   audio/audio.c                 |   1 +
> >   audio/sndioaudio.c            | 565 ++++++++++++++++++++++++++++++++++
> >   MAINTAINERS                   |   7 +
> >   audio/meson.build             |   1 +
> >   meson.build                   |   9 +-
> >   qapi/audio.json               |  25 +-
> >   qemu-options.hx               |  16 +
> >   scripts/meson-buildoptions.sh |   7 +-
> >   10 files changed, 632 insertions(+), 5 deletions(-)
> >   create mode 100644 audio/sndioaudio.c
> 
> 
> > diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
> > new file mode 100644
> > index 000000000000..7c45276d36ce
> > --- /dev/null
> > +++ b/audio/sndioaudio.c
> > @@ -0,0 +1,565 @@
> > +/*
> > + * SPDX-License-Identifier: ISC
> 
> This is the single use of the ISC license in the more than 10k
> files in the repository. Just checking IIUC this document:
> https://www.gnu.org/licenses/quick-guide-gplv3.en.html
> 
> ISC -> LGPLv2.1 -> GPLv2 -> GPLv3
> 
> So ISC is compatible with GPLv2-or-later. Is that correct?

ISC is a permissive license that's semantically pretty much equivalent
to either MIT or BSD 2 clause licenses and thus is broadly compatible
with most other licenses, including the various GPL variants/versions.

None the less, since sndioaudio.c was a new file, it should have been
submitted using the GPLv2+, unless there was a reason it needed to
diverge and use ISC.

An example justification for divering is if the new code is derived
from some non-QEMU source that was already ISC.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


