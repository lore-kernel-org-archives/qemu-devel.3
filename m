Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94868D132B7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 11:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7vVu-0007Hw-LI; Mon, 04 Nov 2024 06:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t7vVq-0007G9-Ko
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:44:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t7vVj-0001lQ-US
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730720682;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcRVOtozGFcTEGYBEay5p0KmPK2G/4ORfnrh/3w3AyM=;
 b=YmSC66XDafiBrj5KM2a6Rx0DJUUocD1XK/t/tjqC8ZsxajHv8hwmQP8M4/Bf0nnQ47gEzh
 2js7m6nO05wH9FIxVUK1/k3xrpkqOLwt7BCHjc3bZLFpMzFMe1H74VfnWgO+sqtGg17KtO
 AbHlE4zjatOSV47mgd9NgH8cXgXjVJE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-yfTaK1HgP_OoYi7NqDG15g-1; Mon,
 04 Nov 2024 06:44:39 -0500
X-MC-Unique: yfTaK1HgP_OoYi7NqDG15g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6F9719560B4; Mon,  4 Nov 2024 11:44:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.152])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DF5D19560AD; Mon,  4 Nov 2024 11:44:33 +0000 (UTC)
Date: Mon, 4 Nov 2024 11:44:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 peter.maydell@linaro.org, huth@tuxfamily.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/2] next-kbd: convert to use
 qemu_input_handler_register()
Message-ID: <ZyizniWmccEjAQBq@redhat.com>
References: <20241101201106.1432336-1-mark.cave-ayland@ilande.co.uk>
 <20241101201106.1432336-2-mark.cave-ayland@ilande.co.uk>
 <ZyicQT4eKlN07AHz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyicQT4eKlN07AHz@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On Mon, Nov 04, 2024 at 10:04:49AM +0000, Daniel P. Berrangé wrote:
> On Fri, Nov 01, 2024 at 08:11:05PM +0000, Mark Cave-Ayland wrote:
> > Convert the next-kbd device from the legacy UI qemu_add_kbd_event_handler()
> > function to use qemu_input_handler_register().
> > 
> > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > ---
> >  hw/m68k/next-kbd.c | 166 ++++++++++++++++++++++++++++++---------------
> >  1 file changed, 111 insertions(+), 55 deletions(-)
> > 
> > diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
> > index bc67810f31..283e98e9eb 100644
> > --- a/hw/m68k/next-kbd.c
> > +++ b/hw/m68k/next-kbd.c
 
> Finding a reliable reference for the NeXT scancodes is very hard
> in my googling so far. The best I've come across so far is
> 
> https://github.com/spenczar/usb-next/blob/main/keymap.h
> 
> who has defined a mapping to USB HID codes, which seems to
> broadly match what's above here, plus has many of the gaps
> fixed.
> 
> Do you know of any other decent references for scancodes ?
> 
> I'm going to see about adding NeXT scancodes to the giant
> database of keycodes at:
> 
>   https://gitlab.com/keycodemap/keycodemapdb
> 
> then we can auto-generate this table as we do for most of
> the other QEMU keyboard drivers.

FYI, I've opened this:

https://gitlab.com/keycodemap/keycodemapdb/-/merge_requests/21

if someone wants to sanity-check it, please comment there. Otherwise I'll
merge it after a short while if no one points out mistakes.

To use this from QEMU we would need:

 * update ui/keycodemapdb submodule hash to point to the above (once
   merged)
 * update ui/meson.build  'keymaps' list to add ['qcode', 'next'] to
   the generated map list
 * import the new generated "ui/input-keymap-qcode-to-next.c.inc" from
   next-kbd.c

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


