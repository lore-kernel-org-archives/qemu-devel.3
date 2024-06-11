Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C04C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 12:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH0Xe-0001rv-St; Tue, 11 Jun 2024 08:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sH0Xc-0001rd-LT; Tue, 11 Jun 2024 08:23:57 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sH0Xa-0007KZ-LJ; Tue, 11 Jun 2024 08:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=nF9wECwog8DyAQqoag5qzzQgj3d1eValGLXNfp0vJG0=; b=TPV7Axhr3JXXzKfW
 Ia7i9nTdpGE+Ax2Y9tGSTVJPwfNYmvZhFf+rhFxCLVXHqY8GF/t17nFdCDf48DvOzgM/3bT6y4u0W
 SBBLXdDZAV9KHyHOo0GbyEnt9BqAO2zoPx1ic9wGkiSkLuSeOUSlt/t24NsS6N7h/Av1CdlKXFfNq
 I3ZKAdkmuKXz/fapMxaG5ZrSc8KjYhZB0U8kcz1NuNm9eXwFvtlcwJ9RML8U5KIZz2/HoG+9kzV1j
 xELRcge+bY4NxdgFDswLU5ET7TcSrAZvEs2tOmEurF/TU3B5N6PW4exF5b+RVbDHG9+HI1PGdB44/
 5xbqMCbVhwFtVmYvOw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1sH0XV-005Ypr-0v;
 Tue, 11 Jun 2024 12:23:49 +0000
Date: Tue, 11 Jun 2024 12:23:49 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: Examining device state via monitor for debugging (was: [PATCH
 0/2] hw/misc/mos6522: Do not open-code hmp_info_human_readable_text())
Message-ID: <ZmhB1RzXCGOU9nu4@gallifrey>
References: <20240610150758.2827-1-philmd@linaro.org>
 <87h6e0uizr.fsf@pond.sub.org>
 <CAFEAcA8F9fTVuTwNosLi7qcZ7ki-kARKJsnrp3-er41LbkpZiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFEAcA8F9fTVuTwNosLi7qcZ7ki-kARKJsnrp3-er41LbkpZiA@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:16:20 up 33 days, 23:30, 1 user, load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Tue, 11 Jun 2024 at 06:50, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > Philippe Mathieu-Daud=E9 <philmd@linaro.org> writes:
> >
> > > Officialise the QMP command, use the existing
> > > hmp_info_human_readable_text() helper.
> >
> > I'm not sure "officialise" is a word :)
> >
> > Taking a step back...  "info via" and its new QMP counterpart
> > x-query-mos6522-devices dump device state.  I understand why examining
> > device state via monitor can be useful for debugging.  However, we have
> > more than 2000 devices in the tree.  Clearly, we don't want 2000 device
> > state queries.  Not even 100.  Could we have more generic means instead?
> >
> > We could use QOM (read-only) properties to expose device state.
> >
> > If we use one QOM property per "thing", examining device state becomes
> > quite tedious.  Also, you'd have to stop the guest to get a consistent
> > view, and adding lots of QOM properties bloats the code.
> >
> > If we use a single, object-valued property for the entire state, we get
> > to define the objects in QAPI.  Differently tedious, and bloats the
> > generated code.
>=20
> We already have a machine readable mandatory-for-every-device
> representation of its entire state -- it's the vmstate struct.
> Admittedly this is sometimes a bit different from the guest-facing
> view of a device and we don't machine-record the field names...

vmstate might not contain everything needed for debug; devices
do a lot of fiddling to create a consistent vmstate, and there may
be more that someone debugging wants (e.g. fd's or host memory addresses).
It's also hopelessly cryptic.

=46rom an HMP point, a 'info debug <DEVICENAME>' seems good to me,
possibly with some options as to whether to recurse or perhaps
add flags to 'info qtree' to also call it.

Dave




> -- PMM
--=20
 -----Open up your eyes, open up your mind, open up your code -------  =20
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \=20
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

