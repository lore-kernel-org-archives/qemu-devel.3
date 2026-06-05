Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF41CD6E6B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVPdi-0002bF-Cn; Fri, 05 Jun 2026 04:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVPdh-0002b5-55
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVPdf-0000NI-Fx
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780647045;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YYhL4k6H0XA5raAWVSntoT/50RB3YG1rpxzsT/RplBU=;
 b=PaR7YyMw26rH+ywQXzCs8S8c1UF91GcrhTpBh+rgQFl0JUd33Xn0fZcP6FjtUmKIih2Dz7
 /9zoUsdcaeyD9aiuSxGNXv5VWZ8f0ISyS0ytH5UPP8Poa1yRw9NiaTcJxxe0DNv3T965tC
 pSTH/y3swy86bitEXODZV/CqzJhwhbc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-ZBVqBm7SP1KBlRgOkG8KWA-1; Fri,
 05 Jun 2026 04:10:41 -0400
X-MC-Unique: ZBVqBm7SP1KBlRgOkG8KWA-1
X-Mimecast-MFC-AGG-ID: ZBVqBm7SP1KBlRgOkG8KWA_1780647040
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6C4A1944D1B; Fri,  5 Jun 2026 08:10:39 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C41231624; Fri,  5 Jun 2026 08:10:35 +0000 (UTC)
Date: Fri, 5 Jun 2026 09:10:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alexander Kanavin <alex.kanavin@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 openembedded-core@lists.openembedded.org, Quan.Sun@windriver.com,
 QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: ui: Regression calling eglInitialize() since v11.0.0
Message-ID: <aiKEeH2UZgdePzjX@redhat.com>
References: <20260528202639.4097815-1-Quan.Sun@windriver.com>
 <DIV636CRY5LQ.2KV03HIYY2WKI@bootlin.com>
 <be287797-1941-4afa-8aef-b015ca194476@windriver.com>
 <CANNYZj8gMc8PdWMse=g1J7goZC5Ga=nwN5hA+uX02-G+LNHEwQ@mail.gmail.com>
 <7da33301e8a0bae93a33695b4fd41f67a08e1b9f.camel@linuxfoundation.org>
 <3bde2ef8-5565-4495-9904-dd3db839de1d@windriver.com>
 <CANNYZj8St8Foj7C1RZnGPFmzsAFyCEjvXVZa9DD5Wv6YQ8u1TQ@mail.gmail.com>
 <237df978-b1f2-4c66-ab4c-5894f7a44a02@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <237df978-b1f2-4c66-ab4c-5894f7a44a02@mailo.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Fri, Jun 05, 2026 at 08:35:13AM +0200, Philippe Mathieu-Daudé wrote:
> On 29/5/26 18:29, Alexander Kanavin wrote:
> > On Fri, 29 May 2026 at 18:10, Quan Sun via lists.openembedded.org
> > <Quan.Sun=windriver.com@lists.openembedded.org> wrote:
> > > This is likely a real QEMU 11.0 regression, but may not be in QEMU's
> > > code itself.  The QEMU 11.0 likely changed its display initialization to
> > > be multi-threaded or reordered it, triggering a race condition in the
> > > host's Wayland/EGL/Mesa stack. Maybe setting SDL_VIDEODRIVER=x11 could
> > > solve the issue.
> > > 
> > > This issue is different from the "glx: failed to create dri3 screen /
> > > failed to load driver: vgem error" seen earlier, which was a missing GPU
> > > driver issue on the host.
> > > 
> > > If you have any detailed logs, please share with me and so I have more
> > > contexts.
> > 
> > It's the same issue, I assure you. Qemu 10.x prints nothing and simply
> > starts, while qemu 11.x first tries glx/dri3 , then wayland/egl/vgem
> > (even though there's no wayland running on the build hosts), and then
> > finally crashes, with the traceback that RP provided.
> > 
> > I don't think it's a race condition, as the failure is deterministic,
> > but I agree that something has changed in qemu's GL initialization
> > sequence.
> 
> Cc'ing Marc-André & Akihiko
> 
> Context:
> 
> https://lore.kernel.org/openembedded-core/7da33301e8a0bae93a33695b4fd41f67a08e1b9f.camel@linuxfoundation.org/

If it is an suspected regression between 10.2 and 11.0, then
I'd suggest someone who is able to reproduce the issue reliably
should do a 'git bisect' to narrow it down precisely.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


