Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC57E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 10:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsf8i-0002YB-3E; Wed, 18 Feb 2026 05:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vsf8c-0002Xw-VK
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 05:50:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vsf8a-0003RY-PJ
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 05:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771411831;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmR7qiFPDXUuZXzD/6TN2Da5Irbk3UcpwMvWzFuNMZk=;
 b=JRXVyzTpunfnj+c7S0AJevXC65HZZ2gV3C/E+up6gYbkuPsSaOtwqubD26hbLvnvkkNP1G
 NzXAz/uk1A14/t4BXWamg0HeRA6eLpZL+km/H8jLP2fwZ+3BjPlXs5JvMSWlstewM3F1bV
 /n01+ifpABT1FAuY1riQLzYM41pE6+c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-MYV6qeijMCWYsjJMkpQHSw-1; Wed,
 18 Feb 2026 05:50:29 -0500
X-MC-Unique: MYV6qeijMCWYsjJMkpQHSw-1
X-Mimecast-MFC-AGG-ID: MYV6qeijMCWYsjJMkpQHSw_1771411828
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E75831955D80; Wed, 18 Feb 2026 10:50:27 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.150])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3804930001A5; Wed, 18 Feb 2026 10:50:22 +0000 (UTC)
Date: Wed, 18 Feb 2026 10:50:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Sergei Heifetz <heifetz@yandex-team.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 1/8] audio: add `audio` build option for meson and Kconfig
Message-ID: <aZWZa8j8dPQG6BGM@redhat.com>
References: <20260217052740.114117-1-heifetz@yandex-team.com>
 <20260217052740.114117-2-heifetz@yandex-team.com>
 <CAFEAcA9y-QEaiRZMrYadQWJ1KgnHxT8Fkqt1uS0PkbY0Sb-_3Q@mail.gmail.com>
 <d09950dc-dd3e-45ca-b54a-cbdff9f71e0d@redhat.com>
 <CAFEAcA_Q78GwXS0Uia1fFdPoDwkofD4Wr080EkG01gGD-d8Pgg@mail.gmail.com>
 <aZQ_bo7SvivJb7Sd@redhat.com>
 <8b4373d7-f065-4f66-ab81-bc83f970d5f7@yandex-team.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b4373d7-f065-4f66-ab81-bc83f970d5f7@yandex-team.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Wed, Feb 18, 2026 at 01:52:06PM +0500, Sergei Heifetz wrote:
> On 2/17/26 15:14, Daniel P. Berrangé wrote:
> > On Tue, Feb 17, 2026 at 10:06:19AM +0000, Peter Maydell wrote:
> > > On Tue, 17 Feb 2026 at 09:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > > On 2/17/26 10:31, Peter Maydell wrote:
> > > > > On Tue, 17 Feb 2026 at 05:29, Sergei Heifetz <heifetz@yandex-team.com> wrote:
> > > > > > This patch adds the `audio` option to meson_options.txt. It is
> > > > > > propagated into Kconfig as AUDIO. It is enabled by default.
> > > > > > The corresponding `--disable-audio` and `--enable-audio` options
> > > > > > for `configure` are also added.
> > > > > > 
> > > > > > For now, this option does nothing. In subsequent patches, it will
> > > > > > gradually disable audio in different places. The final goal is to stop
> > > > > > building sources from `audio/` and `hw/audio/` and other audio-related
> > > > > > files (except for some stubs). Note that this intent is different from
> > > > > > `-audio none`, which mutes audio but still compiles the audio subsystem.
> > > > > Not building audio/ code makes sense, but do we really want to
> > > > > stop building hw/audio code ? That's the guest facing audio
> > > > > devices, and if for instance a machine type has an embedded
> > > > > sound device that would require us to stop compiling that
> > > > > machine. I think it would be very confusing for users if
> > > > > --disable-audio meant "we will silently not build half the
> > > > > Arm boards that have a pl041 in them".
> > > > > 
> > > > > Maybe it would be better if "--disable-audio" meant "don't build
> > > > > the audio backends, and everything behaves as if the user
> > > > > passed -audio none" ?
> > > > The problem is that "-audio none" uses a silent backend but still keeps
> > > > all the audio/ code around.  If you prefer to keep the Arm boards
> > > > around, the solution would be to disable the audio code in the
> > > > individual pl041 devices with "#ifdef CONFIG_AUDIO", so that the
> > > > "depends on AUDIO" for pl041 can be removed too.
> > > This seems weird, though -- why would we put in a lot of ifdefs
> > > in every single audio device, when we could instead say "if you
> > > disable audio at build time what you get is something that presents
> > > the same API as the existing audio backends but does nothing" ?
> > > 
> > > Also, I think we should be consistent here, not put ifdefs in
> > > some devices we think are "important" but skip it in others.
> > If we consider our security boundary guidance, none of these boards
> > with on-board audio frontends would be considered in scope for
> > security.
> > 
> > On arm, only the "virt" board is providing a secure deployment, and
> > that does not require this --disable-audio functionality.
> > 
> > The same applies broadly to other arch targets too, with perhaps the
> > only exception being the "PC speaker" on x86, and a "none" audio
> > backend should be sufficient there IMHO.
> > 
> > With regards,
> > Daniel
> In some production environments, static analysers are used as part of
> broader security measures. If such an analyser reports a problem in an
> unused part of the code, you can’t simply ignore it because it’s unused: you
> either fix the issue (which is a strange thing to do for unused code) or
> remove the unused part. This is a general point about why such functionality
> may be useful for some users.

IMHO "static analysers complain" is way too weak a justification
for taking on this work. Code analysers are always incredibly noisy
and reporting complaints about things that are not worth the cost
of addressing.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


