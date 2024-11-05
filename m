Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AD5D1266B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 09:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8FUT-0001Og-GZ; Tue, 05 Nov 2024 04:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8FUR-0001Nq-GV
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:04:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8FUP-00028h-Dq
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730797480;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zzkuEV2EzpsZiQe1KHN1EkiOhyjRFpkNxPEepNM5X1U=;
 b=O+UL2XCZSvEfIDB3XlQTYJV5G5XlqwzV8XVVEHXM1ZyVQEnAEetJWM7+tiGb6fMfI/4ZFf
 I1Xh0d/qe62DnCbFxaoI3nSr8dH40TOCxsQOhlU3CIg3Z62Smy4IDZMLG5ZLlOVw2W0iEW
 4ODjj1SkkN4XaT87BcmCYGBVeiV9Shg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-8lgJWovaMiuD5etc8z4-Ng-1; Tue,
 05 Nov 2024 04:04:37 -0500
X-MC-Unique: 8lgJWovaMiuD5etc8z4-Ng-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6E741955E7F; Tue,  5 Nov 2024 09:04:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83D9719560A3; Tue,  5 Nov 2024 09:04:33 +0000 (UTC)
Date: Tue, 5 Nov 2024 09:04:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: peter.maydell@linaro.org, huth@tuxfamily.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/2] next-kbd: convert to use
 qemu_input_handler_register()
Message-ID: <ZynfnYsTVc_nuTkx@redhat.com>
References: <20241101201106.1432336-1-mark.cave-ayland@ilande.co.uk>
 <20241101201106.1432336-2-mark.cave-ayland@ilande.co.uk>
 <ZyicQT4eKlN07AHz@redhat.com>
 <7708dea9-32b3-4ced-9fdd-de0c1a5aca85@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7708dea9-32b3-4ced-9fdd-de0c1a5aca85@ilande.co.uk>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Mon, Nov 04, 2024 at 10:46:45PM +0000, Mark Cave-Ayland wrote:
> On 04/11/2024 10:04, Daniel P. Berrangé wrote:
> 
> > On Fri, Nov 01, 2024 at 08:11:05PM +0000, Mark Cave-Ayland wrote:
> > > Convert the next-kbd device from the legacy UI qemu_add_kbd_event_handler()
> > > function to use qemu_input_handler_register().
> > > 
> > > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > ---
> > >   hw/m68k/next-kbd.c | 166 ++++++++++++++++++++++++++++++---------------
> > >   1 file changed, 111 insertions(+), 55 deletions(-)
> > > 
> > > diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
> > > index bc67810f31..283e98e9eb 100644
> > > --- a/hw/m68k/next-kbd.c
> > > +++ b/hw/m68k/next-kbd.c
> > 
> > 
> > > -static const unsigned char next_keycodes[128] = {
> > > -    0x00, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x50, 0x4F,
> > > -    0x4E, 0x1E, 0x1F, 0x20, 0x1D, 0x1C, 0x1B, 0x00,
> > > -    0x42, 0x43, 0x44, 0x45, 0x48, 0x47, 0x46, 0x06,
> > > -    0x07, 0x08, 0x00, 0x00, 0x2A, 0x00, 0x39, 0x3A,
> > > -    0x3B, 0x3C, 0x3D, 0x40, 0x3F, 0x3E, 0x2D, 0x2C,
> > > -    0x2B, 0x26, 0x00, 0x00, 0x31, 0x32, 0x33, 0x34,
> > > -    0x35, 0x37, 0x36, 0x2e, 0x2f, 0x30, 0x00, 0x00,
> > > -    0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> > > -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> > > -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> > > -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
> > 
> > The original code used '0' (or equivalently 0x00) to
> > indicate an unmapped scancode.
> > 
> > > +#define NEXTKBD_NO_KEY 0xff
> > 
> > Now you're using 0xff for missing mappings, but....
> > 
> > > +
> > > +static const int qcode_to_nextkbd_keycode[] = {
> > > +    /* Make sure future additions are automatically set to NEXTKBD_NO_KEY */
> > > +    [0 ... Q_KEY_CODE__MAX]    = NEXTKBD_NO_KEY,
> > > +
> > > +    [Q_KEY_CODE_ESC]           = 0x49,
> > > +    [Q_KEY_CODE_1]             = 0x4a,
> > > +    [Q_KEY_CODE_2]             = 0x4b,
> > > +    [Q_KEY_CODE_3]             = 0x4c,
> > > +    [Q_KEY_CODE_4]             = 0x4d,
> > > +    [Q_KEY_CODE_5]             = 0x50,
> > > +    [Q_KEY_CODE_6]             = 0x4f,
> > > +    [Q_KEY_CODE_7]             = 0x4e,
> > > +    [Q_KEY_CODE_8]             = 0x1e,
> > > +    [Q_KEY_CODE_9]             = 0x1f,
> > > +    [Q_KEY_CODE_0]             = 0x20,
> > > +    [Q_KEY_CODE_MINUS]         = 0x1d,
> > > +    [Q_KEY_CODE_EQUAL]         = 0x1c,
> > > +    [Q_KEY_CODE_BACKSPACE]     = 0x1b,
> > > +    [Q_KEY_CODE_TAB]           = 0x00,
> > 
> > ...you've left 0x00 here and....
> 
> Ooops yes that line can be removed.
> 
> > > +    [Q_KEY_CODE_Q]             = 0x42,
> > > +    [Q_KEY_CODE_W]             = 0x43,
> > > +    [Q_KEY_CODE_E]             = 0x44,
> > > +    [Q_KEY_CODE_R]             = 0x45,
> > > +    [Q_KEY_CODE_T]             = 0x48,
> > > +    [Q_KEY_CODE_Y]             = 0x47,
> > > +    [Q_KEY_CODE_U]             = 0x46,
> > > +    [Q_KEY_CODE_I]             = 0x06,
> > > +    [Q_KEY_CODE_O]             = 0x07,
> > > +    [Q_KEY_CODE_P]             = 0x08,
> > > +    [Q_KEY_CODE_RET]           = 0x2a,
> > > +    [Q_KEY_CODE_A]             = 0x39,
> > > +    [Q_KEY_CODE_S]             = 0x3a,
> > > +
> > > +    [Q_KEY_CODE_D]             = 0x3b,
> > > +    [Q_KEY_CODE_F]             = 0x3c,
> > > +    [Q_KEY_CODE_G]             = 0x3d,
> > > +    [Q_KEY_CODE_H]             = 0x40,
> > > +    [Q_KEY_CODE_J]             = 0x3f,
> > > +    [Q_KEY_CODE_K]             = 0x3e,
> > > +    [Q_KEY_CODE_L]             = 0x2d,
> > > +    [Q_KEY_CODE_SEMICOLON]     = 0x2c,
> > > +    [Q_KEY_CODE_APOSTROPHE]    = 0x2b,
> > > +    [Q_KEY_CODE_GRAVE_ACCENT]  = 0x26,
> > > +    [Q_KEY_CODE_SHIFT]         = 0x00,
> 
> This should be kept.
> 
> > > +    [Q_KEY_CODE_BACKSLASH]     = 0x00,
> > 
> > ...here, and ...
> 
> Indeed, that line can also be removed.
> 
> > > +    [Q_KEY_CODE_Z]             = 0x31,
> > > +    [Q_KEY_CODE_X]             = 0x32,
> > > +    [Q_KEY_CODE_C]             = 0x33,
> > > +    [Q_KEY_CODE_V]             = 0x34,
> > > +
> > > +    [Q_KEY_CODE_B]             = 0x35,
> > > +    [Q_KEY_CODE_N]             = 0x37,
> > > +    [Q_KEY_CODE_M]             = 0x36,
> > > +    [Q_KEY_CODE_COMMA]         = 0x2e,
> > > +    [Q_KEY_CODE_DOT]           = 0x2f,
> > > +    [Q_KEY_CODE_SLASH]         = 0x30,
> > > +    [Q_KEY_CODE_SHIFT_R]       = 0x00,
> > 
> > ...here, which is surely not a correct conversion
> 
> And this one should also be kept.
> 
> The reason the two shift keys need to be kept as zero is so that they pass
> the "if (keycode == NEXTKBD_NO_KEY) { return; }" check in nextkbd_event().

IMHO that code sould just be flipped in ordering. Do the
special case

 if (qcode == Q_KEY_CODE_SHIFT_R)

handling before even running the table lookup, since the
lookup is redundant, at which point you don't need to
have 2 distinct special values in the lookup table.


> > I'm going to see about adding NeXT scancodes to the giant
> > database of keycodes at:
> > 
> >    https://gitlab.com/keycodemap/keycodemapdb
> > 
> > then we can auto-generate this table as we do for most of
> > the other QEMU keyboard drivers.
> 
> That would be great! Is this also possible for the ADB keyboard device,
> since that is where I looked for inspiration when looking at next-kbd?

Yes, that's likely possible - we've already got data in keycodemapdb for
Apple ADB


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


