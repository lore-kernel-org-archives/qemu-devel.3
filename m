Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710BAC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKz3-0004do-Cs; Mon, 27 Jul 2026 09:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1woKye-0004WA-Pu
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:02:46 -0400
Received: from forward100d.mail.yandex.net ([2a02:6b8:c41:1300:1:45:d181:d100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1woKyX-0006GU-ER
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:02:40 -0400
Received: from mail-nwsmtp-smtp-production-main-74.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-74.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1ba6:0:640:9434:0])
 by forward100d.mail.yandex.net (postfix) with ESMTPS id 261F9C00EC;
 Mon, 27 Jul 2026 16:02:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.iva.yp-c.yandex.net (smtp)
 with ESMTPSA id K2cAXGlgSW20-KLvBLIaO; 
 Mon, 27 Jul 2026 16:02:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1785157344; bh=hg2jRw0/8J0N+ZT3cBUZfgogftO7rl31HNU/YIzQU4M=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=dP18Yc1uhrasb5a8x6iUw2rE7TUevp685tNzQgZq367m1V6M+yVzUztef381R5dfD
 liBF3aHwQ2mRtKLGyOm3ufjYXVbc/EslB/BCxggGfEmlx17wVSaYNLTtQsDs3fUUw8
 9N1sMaPhEzVavN4Sq2Ps0PP1dWt5eCzPYtHNhQS8=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.iva.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <140847fc9349a45194a7aaad8ab31c1a3e1463ec.camel@maquefel.me>
Subject: Re: [PATCH v2 1/2] semihosting/arm-compat-semi: Fix
 =?UTF-8?Q?auto=E2=80=91strlen?= detection for =?UTF-8?Q?32=E2=80=91bit?=
 targets
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alex =?ISO-8859-1?Q?Benn=E9e?=	
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alistair
 Francis	 <alistair.francis@wdc.com>
Date: Mon, 27 Jul 2026 16:02:30 +0300
In-Reply-To: <CAFEAcA-3ugXDNUncKuv6=GC9b4dkWmDpY6xRRFM5uHGRFPzk6Q@mail.gmail.com>
References: <20260727-fix-sign-extended-32-bit-addresses-v2-0-6d6a01efed8a@maquefel.me>
 <20260727-fix-sign-extended-32-bit-addresses-v2-1-6d6a01efed8a@maquefel.me>
 <CAFEAcA-hKu_C9MULJ=8_jktDgujveQRBkGXvgnczPNrTWZfeQA@mail.gmail.com>
 <9e4f3fc272c854f496d7c3ce8355df6d3248063f.camel@maquefel.me>
 <CAFEAcA-3ugXDNUncKuv6=GC9b4dkWmDpY6xRRFM5uHGRFPzk6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:d100;
 envelope-from=nikita.shubin@maquefel.me; helo=forward100d.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Mon, 2026-07-27 at 13:54 +0100, Peter Maydell wrote:
> On Mon, 27 Jul 2026 at 13:13, Nikita Shubin
> <nikita.shubin@maquefel.me> wrote:
> >=20
> > On Mon, 2026-07-27 at 11:36 +0100, Peter Maydell wrote:
> > > On Mon, 27 Jul 2026 at 08:46, Nikita Shubin
> > > <nikita.shubin@maquefel.me> wrote:
> > > >=20
> > > > The switch from target_ulong to uint64_t broke the mechanism of
> > > > passing -1
> > > > (0xffffffff) in arg2 to signal validate_strlen() to compute the
> > > > string
> > > > length automatically. For 32=E2=80=91bit semihosting, detect when a=
rg2
> > > > is
> > > > 0xffffffff and replace it with 0xffffffffffffffff. This causes
> > > > an
> > > > overflow
> > > > to zero, restoring the original behavior of automatic length
> > > > calculation.
> > >=20
> > > Why do you think this is a valid thing for the guest to do? The
> > > change
> > > in this patch is to the SYS_OPEN semihosting call. The spec for
> > > that
> > > is here:
> > > https://github.com/ARM-software/abi-aa/blob/main/semihosting/semihost=
ing.rst#612sys_open-0x01
> > >=20
> > > arg2 is the 3rd word in the argument block, which is documented
> > > as:
> > >=20
> > > # An integer that gives the length of the string pointed to by
> > > field
> > > 1.
> > > # The length does not include the terminating null character that
> > > must
> > > be present.
> > >=20
> > > There's nothing there about -1 being a valid value.
> > >=20
> > > I think this is a bug introduced in commit 5b3f39cb04: it
> > > added "allow length parameter to be 0" to a helper function
> > > because presumably we need that in some cases where the
> > > semihosting
> > > ABI passes a pointer to a string without a length. But because it
> > > doesn't separate out "length is 0 because ABI doesn't provide
> > > one"
> > > from "length is provided by guest", that incorrectly allowed the
> > > guest to not specify a valid length and QEMU to accept it.
> >=20
> > Seems not a bug but intended behavior. Commit 5b3f39cb04
> > deliberately
> > added support for a zero length as a signal to invoke strlen(), as
> > documented in both the code comments and the commit message.
> >=20
> > Citation:
> >=20
> > ```
> > =C2=A0=C2=A0=C2=A0 Add helpers to validate the length of the filename s=
tring.
> > =C2=A0=C2=A0=C2=A0 Prepare for usage by other semihosting by allowing t=
he
> > =C2=A0=C2=A0=C2=A0 filename length parameter to be 0, and calling strle=
n.
> > ```
>=20
> I take that "by other semihosting" bit to mean that we have other
> semihosting functions where the guest passes a string pointer
> with no associated length, and we're going to implement those
> by calling this function with length =3D=3D 0. I don't think it was
> intended to make that behaviour visible to the guest.
>=20
> > So it seems like a regression bug introduced by 6dfbf9b6cfe.
> >=20
> > Before that, open() simply ignored the length argument, so the
> > current
> > logic is a conscious improvement, not an error.
>=20
> Semihosting has to implement the specification; we don't
> get to "improve" on it.
>=20
> > Still in 64=E2=80=91bit mode, passing -1 as arg2 still yields the expec=
ted
> > result, so there is a bug somewhere =E2=80=94 either in the 32=E2=80=91=
bit handling
> > or
> > in the common logic.
>=20
> The bug is that for both 64-bit and 32-bit passing -1 is an error,
> and we shouldn't be making it work on 64-bit.

That's sound reasonable, but still that's breaks behaviour introduced
earlier and existed for quite a long period of time.

Ok, i'll do the opposite.

>=20
> thanks
> -- PMM

Yours, Shubin.

