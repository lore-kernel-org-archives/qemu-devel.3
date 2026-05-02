Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85596CD13DA
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 08:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJ62J-0004v3-Jb; Sat, 02 May 2026 04:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wJ62G-0004ue-T6
 for qemu-devel@nongnu.org; Sat, 02 May 2026 04:49:18 -0400
Received: from mail-106116.protonmail.ch ([79.135.106.116])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wJ62E-0001u0-Dw
 for qemu-devel@nongnu.org; Sat, 02 May 2026 04:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1777711748; x=1777970948;
 bh=nv9G5ELielHMlvFF8TWk5NU0WH0dPdg0pdCi7O4FJOs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=flY5lUfs7fk1/oO5dyYTLih/cb4od+UHiZGMFrYZlMQQXp0uKJeywPGaN3O7WlaGU
 I2f8JrGmi/hoJGO3RhKP2YhrkwOSMQyEs/OQCBSGYde/zlPV8E8KjKN+YuDD7LsQgf
 ZgQ48mJVw97cGTfUSLxnXOGf32CnMxN1nQmn/14RTcFmLV5AgWwZ86YnOaOx+Hbhj+
 nqgNZ116E/k/a4jnnPIUCMhDHL3ZoyyE75y4DwAnvYLLEde3YHVDeys6nnCi+05fRD
 KcgEi3ZRIVD6g4djN8ldaDZs5xjPbUBhbvKKe9Gnosbc8ErehQURd4XrXweA6qupvH
 p1ca4A+UjGX/Q==
Date: Sat, 02 May 2026 08:49:04 +0000
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
From: Matthew Penney <matt@matthewpenney.net>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 2/2] io: use g_clear_handle_id() for GSource cleanup
Message-ID: <-R6Qz5NcY4aZQ1rCK_5metT6unz1bguO9s8zaUyMXokWkhKYUO_oOYFyjxbCnNH5f9MHvxFUG2zaQ3CRWpYJNl-Vy8F8Keo_Bws9D5j9hJw=@matthewpenney.net>
In-Reply-To: <5998180b-55c1-40a7-8426-d21539f99100@linaro.org>
References: <20260408100605.66795-1-philmd@linaro.org>
 <20260408100605.66795-3-philmd@linaro.org>
 <_FLwJ4IKFwbr2FlwMah_gLTk8PG-FdvyrrFM2UgmbYPlN7wSwZIslJehtfZV7mb8w1UD69eX6LD5Lt9wGkstMiLrdrkkzU1coVZiuy7CSNE=@matthewpenney.net>
 <98a3dea5-266e-4326-b224-0a3401e49783@linaro.org>
 <5998180b-55c1-40a7-8426-d21539f99100@linaro.org>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: 1c86ba19e5379dc4990ea2bdc5374a6d55dfa3e4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=79.135.106.116;
 envelope-from=matt@matthewpenney.net; helo=mail-106116.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Philippe,

Sorry I missed this!
Yes you can add my "Reviewed-by:" or "Co-developed-by:" tag - whichever is =
more
appropriate.

Best regards,
Matt

On Monday, 20 April 2026 at 08:20, Philippe Mathieu-Daud=C3=A9 <philmd@lina=
ro.org> wrote:

> On 19/4/26 18:46, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 9/4/26 16:20, Matthew Penney wrote:
> >> Hi Philippe,
> >>
> >> Thanks for picking this up and cleaning it up.
> >>
> >> This matches what I was aiming for with my series.
> >
> > Thanks Matt, does that mean I can add your tag to this
> > series?
> >
> >    Reviewed-by: Matthew Penney <matt@matthewpenney.net>
>
> Hmm maybe in this case Co-developed-by: is more appropriate.
>
> But then we need to wait for Marc-Andr=C3=A9 or Daniel for a review.
>
> >
> >>
> >> Best regards,
> >> Matt
> >>
> >>
> >>
> >> Sent with Proton Mail secure email.
> >>
> >> On Wednesday, 8 April 2026 at 11:06, Philippe Mathieu-Daud=C3=A9
> >> <philmd@linaro.org> wrote:
> >>
> >>> Use g_clear_handle_id() instead of g_source_remove() with
> >>> manual ID checking and zeroing.
> >>>
> >>> This simplifies the code and ensures consistent handling of
> >>> GSource IDs, since g_clear_handle_id() checks for a non-zero
> >>> ID before calling the cleanup function and zeros it afterwards.
> >>>
> >>> No functional change intended.
> >>>
> >>> Mechanical change using the following Coccinelle spatch script:
> >>>
> >>>    @@
> >>>    expression TAG;
> >>>    @@
> >>>    -    if (TAG > 0) {
> >>>    +    if (TAG) {
> >>>             g_source_remove(TAG);
> >>>             <... when !=3D TAG
> >>>             TAG =3D 0;
> >>>             ...>
> >>>         }
> >>>
> >>>    @@
> >>>    expression TAG;
> >>>    @@
> >>>    -    g_source_remove(TAG);
> >>>    -    TAG =3D 0;
> >>>    +    g_clear_handle_id(&TAG, g_source_remove);
> >>>
> >>>    @@
> >>>    expression TAG;
> >>>    @@
> >>>    -    if (TAG) {
> >>>             g_clear_handle_id(&TAG, g_source_remove);
> >>>    -    }
> >>>
> >>> Inspired-by: Matthew Penney <matt@matthewpenney.net>
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>> ---
> >>>   hw/char/cmsdk-apb-uart.c  |  5 +----
> >>>   hw/char/nrf51_uart.c      |  5 +----
> >>>   hw/char/serial.c          |  6 +-----
> >>>   hw/char/stm32l4x5_usart.c |  5 +----
> >>>   hw/char/terminal3270.c    |  5 +----
> >>>   hw/char/virtio-console.c  | 10 ++--------
> >>>   hw/usb/redirect.c         |  5 +----
> >>>   io/channel-websock.c      | 13 +++----------
> >>>   net/passt.c               |  8 ++------
> >>>   net/stream.c              | 15 +++------------
> >>>   net/stream_data.c         |  5 +----
> >>>   net/vhost-user.c          |  8 ++------
> >>>   ui/dbus-clipboard.c       |  6 ++----
> >>>   ui/input-barrier.c        |  6 +-----
> >>>   ui/vnc-auth-vencrypt.c    |  6 +-----
> >>>   ui/vnc-ws.c               | 12 ++----------
> >>>   16 files changed, 25 insertions(+), 95 deletions(-)
> >
>
>

