Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DFAFE51EF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCXs-0000xa-Vl; Fri, 24 Apr 2026 05:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGCXo-0000u8-Ax
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:09:52 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGCXm-0000i4-Iu
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:09:52 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-65492d097acso1321416d50.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 02:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777021789; cv=none;
 d=google.com; s=arc-20240605;
 b=lIEgIAcmS1nPZ0wabRKnEhl3zIbpSORh3Mou4XZO7yKqmvolp6FsiKXLionU3GZEY+
 B4937llLYV/I8NyOPZKiA1b8s0zlwW+/ch67D+EMHpzUeyvQOMV4NdkOA9E2FoX78+JB
 GRXHx3kXtFuBgB5MONF9HGyi/IrCzSqevdY5q/DVL1ydKWepoI4KFze9awkMNsYtIzlA
 3on2Pf1Hu3ftuQRV2MpQUJIOa3WxFZq2UPtUboQc3x41igkijAQ1bdcAMdp5+7O3RcmH
 zpEsBvJXmXzTTK0rzg7wkjeeiur2cFKX/H23yz6JQiNdjB+Y2j4OHXrSPW3XXc9pim0r
 UGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XCgfnlC1WnGQzLp2YVyX5mN90uiWteZaU/EC4uUkfeE=;
 fh=VANerWD8jJ6SYI5omwl+za+tXawbA9VxdY0KZS8GujI=;
 b=g9QK4qADDjnAX3qiwvTuq8PK36M/Zip+02nyqHCddGeDuE4l0JhzPLtRvI9iOW8/KG
 6necO6KEEq/bHVl0x/H8v+mz2SgLTWrAu1pOYcAbw7ET3s7uDDXAB/wDJA6nYZFiq15i
 V/gjh6EJ8CXnzphp6dYbP/94u+JCEIwM7E1RvkHAuriFAMNqjjehX3U1vYDCPIrhP0GJ
 PkAtXAYn6cRREXD09p3QI6yCgHCCf8vu06SjFcCjaHVVrI/JMU4fKBQJHvcYimi6Exhx
 eN5Lu5LAKA70eNjw0JApGKHgw4csmLaE26/JPfbfdaa00TyQLz5vVMcqDFk3Kwo5hsnc
 LiOg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777021789; x=1777626589; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCgfnlC1WnGQzLp2YVyX5mN90uiWteZaU/EC4uUkfeE=;
 b=d9KUT5BTSr+QfseDnBhYoTi4wN1V6ZQNDaBx+lKZvEnxskxcaTQ7VX10g3ac+vxrVe
 R7ysXYekMEaJl3Gfcj7a/EUvum4Rn4ak7b4IHOMSVKk4rFlLsypWY6szo1ybi8OSVb5R
 TKLUB5/a+tDThAnHzTwrm60XaLqy6lDVogYcnBw0yuIr5jI+IqnBo98CxwD9HKiwASZO
 1tvosYjqlEVctbzV6XpFLDhrvdBhN5SJWmX1euGsugZaEdV0CeXfGBoDe8RXhQcbj4sX
 gEoWmwlhdnb8ZJ3tCenUioBBeAv/8nuCJ3supNJCzMU3E74aMURHO9WKTOC1NL+Tj+/y
 clWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777021789; x=1777626589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XCgfnlC1WnGQzLp2YVyX5mN90uiWteZaU/EC4uUkfeE=;
 b=EeSFtOPaCqr9+h58b2TG0unMx6bgMqvcUDvygPP3Y8Mtfws3m605g6Dc5N6vHV3Of5
 h4JAsYR1lAskf0BvAyxxLId9DHcJKcSZRvAIX8+NT859KTWJ7/jsyAKON8SRpzTgYh/s
 IAXLjEPvlpztGD52BcIn6iUazrc7F9DrbGsfHKV8pb0GQ0a3mZkw2VE59DPO/clUk1eY
 e/1Z8F1NRbKE5nsDIFOfN1HSJ+928lP6ZYGn53IQAeOrQkK8dYGp/Yb5fqHQ2IIJF5q+
 tYNo2Gj7iclWBz6yXeb4HaRpDhbc8e/EfdEAexeE2XF8uFCnqrbQtws9oT80iLuBJD2S
 0wYA==
X-Gm-Message-State: AOJu0Yz0pInsHuFd8L13ExO2mXVKFcaYBW0af/JxSeSvVWP/6lEy4+s+
 rYhylD7CihwJuaPZ8F2L9eVVZCc35rw3pzyaaFgR/9ODlsRtZQnnU0TQnyb8fK9WVmLlocGq/fB
 RKPTls9jJj7ltb4RMPZiNIMWReyIMeFsFx/c8Ov+8rg==
X-Gm-Gg: AeBDieuz1EfufPdXqwFLFp0bziYNVFttkjYaUp/szfbFQ15Ur9RPY9MzjUBVrs3ini6
 2x5kNQ+3qIy5vwijwzNy/BMODrijWJX9yuU7exl2rsXQyCOpZfrUNm4Uo8BDqzcWvFWAQVhUvNx
 tAn8acb13TXazEyuKFNzPCvTZMEWI6vlqzBA87SLXLflEv6iXRbzSYpA4v947/vBHrE5Oeu8Dac
 OeSPTHKMcf3UsNLb/zy6F4CIrEt80/L3NP+BkcTDcjI9OodDjH1VMOei/eVVYc0U1c5oeUsJrMV
 zzSS6Z62fy88REU+WXO1c52pnB4pZDAwtf0X8cuJzfxlUE8ZHKLx0kDX1XNmAoMKPj/oui/n88f
 YfQ==
X-Received: by 2002:a05:690e:124a:b0:64e:f106:60e5 with SMTP id
 956f58d0204a3-65310ac1e0amr29405509d50.52.1777021789106; Fri, 24 Apr 2026
 02:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250822092410.25833-1-cjchen@igel.co.jp>
 <20250822092410.25833-4-cjchen@igel.co.jp>
 <3a80c5e5-9889-4830-9a00-5d4d92141a3a@linaro.org> <aLdA4uH5CGbfz9Gd@x1.local>
In-Reply-To: <aLdA4uH5CGbfz9Gd@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Apr 2026 10:09:36 +0100
X-Gm-Features: AQROBzD6el2Q_jeFnutszZEuATN6In9ozQrDj5bnCKv9XhmLCzKYGpzTAE_4SZ4
Message-ID: <CAFEAcA_TjVAzntgxdLF7rn4fwMk+YH6eiPdTVEQopRWceHGfrQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/9] hw: npcm7xx_fiu and mx_pic change
 .impl.unaligned = true
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>, 
 Tomoyuki Hirose <hrstmyk811m@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 2 Sept 2025 at 20:09, Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Aug 25, 2025 at 01:00:21PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi,
> >
> > On 22/8/25 11:24, CJ Chen wrote:
> > > By setting .impl.unaligned =3D true, we allow QEMU to pass along
> > > unaligned requests directly as-is, rather than splitting them into
> > > multiple aligned sub-requests that might cause repeated device
> > > callbacks or unintended side effects.
> > >
> > > Signed-off-by: CJ Chen <cjchen@igel.co.jp>
> > > Tested-by: CJ Chen <cjchen@igel.co.jp>
> > > Acked-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
> > > Reported-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
> > > ---
> > >   hw/ssi/npcm7xx_fiu.c | 3 +++
> > >   hw/xtensa/mx_pic.c   | 3 +++
> > >   2 files changed, 6 insertions(+)
> >
> >
> > > diff --git a/hw/xtensa/mx_pic.c b/hw/xtensa/mx_pic.c
> > > index 8211c993eb..6bf524a918 100644
> > > --- a/hw/xtensa/mx_pic.c
> > > +++ b/hw/xtensa/mx_pic.c
> > > @@ -270,6 +270,9 @@ static const MemoryRegionOps xtensa_mx_pic_ops =
=3D {
> > >       .valid =3D {
> > >           .unaligned =3D true,
> > >       },
> > > +    .impl =3D {
> > > +        .unaligned =3D true,
> > > +    },
> > >   };
> >
> > Surely a distinct patch.
>
> Besides that, I also don't understand how it used to work even before thi=
s
> change..
>
> E.g., both of the xtensa mx_pic read/write ignores size, that doesn't loo=
k
> right already when there's totally no limitation of impl.*_access_size.
>
> Meanwhile, taking xtensa_mx_pic_ext_reg_read() as example, it'll return a
> u32 by offset smaller than MX_MAX_IRQ (where MIROUT=3D=3D0):
>
>     if (offset < MIROUT + MX_MAX_IRQ) {
>         return mx->mirout[offset - MIROUT];
>     }
>
> But it returns different u32 for different offsets.. so reading 0x0 retur=
ns
> the 1st u32, then 0x1 returns the 2nd (rather than reading 0x4 returns
> that).
>
> Even if there might be a driver that works with it, it still doesn't look
> like the traditional way of doing MMIOs.. irrelevant of setting unaligned
> or not in its .impl.

I had a look at this. Unfortunately there doesn't seem to be any
publicly available hardware documentation for this, but it looks
from the kernel driver like the hardware really does work in this
weird way. arch/xtensa/include/asm/mxregs.h has:

/*
 * RER/WER at, as       Read/write external register
 *      at: value
 *      as: address
 *
 * Address      Value
 * 00nn         0...0p..p       Interrupt Routing, route IRQ n to processor=
 p
 * 01pp         0...0d..d       16 bits (d) 'ored' as single IPI to process=
or p
 * 0180         0...0m..m       Clear enable specified by mask (m)
 * 0184         0...0m..m       Set enable specified by mask (m)
 * 0190         0...0x..x       8-bit IPI partition register
 *                              VVVVVVVVPPPPUUUUUUUUUUUUUUUUU
 *                              V (10-bit) Release/Version
 *                              P ( 4-bit) Number of cores - 1
 *                              U (18-bit) ID
 * 01a0         i.......i       32-bit ConfigID
 * 0200         0...0m..m       RunStall core 'n'
 * 0220         c               Cache coherency enabled
 */

#define MIROUT(irq)     (0x000 + (irq))
#define MIPICAUSE(cpu)  (0x100 + (cpu))
#define MIPISET(cause)  (0x140 + (cause))
#define MIENG           0x180
#define MIENGSET        0x184
(etc)

so the MIROUT and MIPICAUSE parts are more than byte wide but
the address decode puts them a byte apart. (This is kind of similar
to x86 PC in/out IO ports -- you can have a 32-bit IO port that
is immediately followed by another IO port, you don't have to
space the port numbers 4 apart.)

So I think this device definitely does need to have both
.valid and .impl set unaligned =3D true.

-- PMM


thanks
-- PMM

