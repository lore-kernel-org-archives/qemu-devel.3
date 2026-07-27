Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0E2C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKD4-0005q3-6R; Mon, 27 Jul 2026 08:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1woKCx-0005pC-Q3
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:13:23 -0400
Received: from forward102a.mail.yandex.net ([178.154.239.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1woKCq-0007RG-KR
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:13:20 -0400
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c22:d15:0:640:87c2:0])
 by forward102a.mail.yandex.net (postfix) with ESMTPS id 27EDBC0081;
 Mon, 27 Jul 2026 15:13:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id 7DbxOJxdM8c0-FsufXlFH; 
 Mon, 27 Jul 2026 15:13:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1785154390; bh=xmQMygj0LNR5rsvGV9k08dwSkAmlmDJhfj6s229zhvw=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=Dq8Pi2sOrk661rmKlQCtgJUtAwydetjV8yzsBhj647/7l7dr+Z/SRy99nXhDTBEDR
 xvC/mplTmF9bd4RzgCtClLh6lrPo+5d+aME+FqGugg0+oD8g0zm+N92R63ouEiMuzN
 1wVRoYNtxN9jyOgOWYAzeKCiQUrXpUdskzXLJWh4=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <9e4f3fc272c854f496d7c3ce8355df6d3248063f.camel@maquefel.me>
Subject: Re: [PATCH v2 1/2] semihosting/arm-compat-semi: Fix
 =?UTF-8?Q?auto=E2=80=91strlen?= detection for =?UTF-8?Q?32=E2=80=91bit?=
 targets
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alex =?ISO-8859-1?Q?Benn=E9e?=	
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alistair
 Francis	 <alistair.francis@wdc.com>
Date: Mon, 27 Jul 2026 15:13:18 +0300
In-Reply-To: <CAFEAcA-hKu_C9MULJ=8_jktDgujveQRBkGXvgnczPNrTWZfeQA@mail.gmail.com>
References: <20260727-fix-sign-extended-32-bit-addresses-v2-0-6d6a01efed8a@maquefel.me>
 <20260727-fix-sign-extended-32-bit-addresses-v2-1-6d6a01efed8a@maquefel.me>
 <CAFEAcA-hKu_C9MULJ=8_jktDgujveQRBkGXvgnczPNrTWZfeQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=178.154.239.85;
 envelope-from=nikita.shubin@maquefel.me; helo=forward102a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 2026-07-27 at 11:36 +0100, Peter Maydell wrote:
> On Mon, 27 Jul 2026 at 08:46, Nikita Shubin
> <nikita.shubin@maquefel.me> wrote:
> >=20
> > The switch from target_ulong to uint64_t broke the mechanism of
> > passing -1
> > (0xffffffff) in arg2 to signal validate_strlen() to compute the
> > string
> > length automatically. For 32=E2=80=91bit semihosting, detect when arg2 =
is
> > 0xffffffff and replace it with 0xffffffffffffffff. This causes an
> > overflow
> > to zero, restoring the original behavior of automatic length
> > calculation.
>=20
> Why do you think this is a valid thing for the guest to do? The
> change
> in this patch is to the SYS_OPEN semihosting call. The spec for that
> is here:
> https://github.com/ARM-software/abi-aa/blob/main/semihosting/semihosting.=
rst#612sys_open-0x01
>=20
> arg2 is the 3rd word in the argument block, which is documented as:
>=20
> # An integer that gives the length of the string pointed to by field
> 1.
> # The length does not include the terminating null character that
> must
> be present.
>=20
> There's nothing there about -1 being a valid value.
>=20
> I think this is a bug introduced in commit 5b3f39cb04: it
> added "allow length parameter to be 0" to a helper function
> because presumably we need that in some cases where the semihosting
> ABI passes a pointer to a string without a length. But because it
> doesn't separate out "length is 0 because ABI doesn't provide one"
> from "length is provided by guest", that incorrectly allowed the
> guest to not specify a valid length and QEMU to accept it.

Seems not a bug but intended behavior. Commit 5b3f39cb04 deliberately
added support for a zero length as a signal to invoke strlen(), as
documented in both the code comments and the commit message.

Citation:

```
    Add helpers to validate the length of the filename string.
    Prepare for usage by other semihosting by allowing the
    filename length parameter to be 0, and calling strlen.
```

So it seems like a regression bug introduced by 6dfbf9b6cfe.

Before that, open() simply ignored the length argument, so the current
logic is a conscious improvement, not an error.

Still in 64=E2=80=91bit mode, passing -1 as arg2 still yields the expected
result, so there is a bug somewhere =E2=80=94 either in the 32=E2=80=91bit =
handling or
in the common logic.

>=20
> thanks
> -- PMM

Yours, Shubin.

