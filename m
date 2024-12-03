Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F5DE6C5E5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 01:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIHmt-0004T3-LN; Mon, 02 Dec 2024 20:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <benh@kernel.crashing.org>)
 id 1tIHmp-0004Sa-Bm
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 20:33:11 -0500
Received: from gate.crashing.org ([63.228.1.57])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <benh@kernel.crashing.org>) id 1tIHmf-00018t-Al
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 20:33:05 -0500
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4B31Uo8V031997;
 Mon, 2 Dec 2024 19:30:50 -0600
Message-ID: <2f6a993cd0e12c2bf903440f9f921d7af58bee36.camel@kernel.crashing.org>
Subject: Re: [PATCH-for-9.2? v2 1/2] hw/display/vga: Do not reset
 'big_endian_fb' in vga_common_reset()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau
 <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Date: Tue, 03 Dec 2024 12:30:49 +1100
In-Reply-To: <21c5e930-d7ee-4dd8-a238-862f4db87849@linaro.org>
References: <20241129101721.17836-1-philmd@linaro.org>
 <20241129101721.17836-2-philmd@linaro.org>
 <21c5e930-d7ee-4dd8-a238-862f4db87849@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
Received-SPF: pass client-ip=63.228.1.57;
 envelope-from=benh@kernel.crashing.org; helo=gate.crashing.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It's been a long time, I only have vague memories of this :-) But I
think it should be ok.

It does definitely make sense in the virtio case and similar where
the property is set once for the instance.

For bochs and ati, there's a register to configure it as well, so there
*may* be an expectation that it gets reset there, I'm less certain.

So tentatively...

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


On Mon, 2024-12-02 at 20:48 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> ping?
>=20
> On 29/11/24 11:17, Philippe Mathieu-Daud=C3=A9 wrote:
> > The 'pci-vga' device allow setting a 'big-endian-framebuffer'
> > property since commit 3c2784fc864 ("vga: Expose framebuffer
> > byteorder as a QOM property"). Similarly, the 'virtio-vga'
> > device since commit 8be61ce2ce3 ("virtio-vga: implement
> > big-endian-framebuffer property").
> >=20
> > Both call vga_common_reset() in their reset handler, respectively
> > pci_secondary_vga_reset() and virtio_vga_base_reset_hold(), which
> > reset 'big_endian_fb', overwritting the property. This is not
> > correct: the hardware is expected to keep its configured
> > endianness during resets.
> >=20
> > Move 'big_endian_fb' assignment from vga_common_reset() to
> > vga_common_init() which is called once when the common VGA state
> > is initialized.
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> > =C2=A0 hw/display/vga.c | 2 +-
> > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/display/vga.c b/hw/display/vga.c
> > index 892fedc8dce..b074b58c90d 100644
> > --- a/hw/display/vga.c
> > +++ b/hw/display/vga.c
> > @@ -1873,7 +1873,6 @@ void vga_common_reset(VGACommonState *s)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->cursor_start =3D 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->cursor_end =3D 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->cursor_offset =3D 0;
> > -=C2=A0=C2=A0=C2=A0 s->big_endian_fb =3D s->default_endian_fb;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(s->invalidated_y_table, '\0', siz=
eof(s-
> > >invalidated_y_table));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(s->last_palette, '\0', sizeof(s->=
last_palette));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(s->last_ch_attr, '\0', sizeof(s->=
last_ch_attr));
> > @@ -2266,6 +2265,7 @@ bool vga_common_init(VGACommonState *s,
> > Object *obj, Error **errp)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * all target endian dependencies f=
rom this file.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->default_endian_fb =3D target_words_bi=
gendian();
> > +=C2=A0=C2=A0=C2=A0 s->big_endian_fb =3D s->default_endian_fb;
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vga_dirty_log_start(s);
> > =C2=A0=20


