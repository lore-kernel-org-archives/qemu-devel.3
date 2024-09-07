Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC692E6FE4C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 13:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smvMG-0007Gk-Qw; Sat, 07 Sep 2024 09:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.mehnert@kernkonzept.com>)
 id 1smpwz-0006nk-5B; Sat, 07 Sep 2024 03:33:41 -0400
Received: from serv1.kernkonzept.com ([2a01:4f8:1c1c:b490::2]
 helo=mx.kernkonzept.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.mehnert@kernkonzept.com>)
 id 1smpwt-00077V-5U; Sat, 07 Sep 2024 03:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kernkonzept.com; s=mx1; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=6/FwPM5bHlbD6wQC2ifk50MOQ3o56tBV3d6y22g/1yg=; b=A4X9ZLggt1uPJVMTjEJYhO951z
 km1+6zvZ8nyPlxBUu7WXOCPL8mvLKLrejMC7SVGn2gOtBXEp/JBvwnsbuh2l5mscNpTTmz+UVAQwg
 zN9MpGmuHauUjRfZZaPopu9b86nS6qeWV2KTatfipSBpzV46NxewsIfQ1Op+FqTOV8hY8fb1ecZLb
 rdr4karKGyWS94sFvLbcWHsXsHVbBvull8LKlxi5phtUqn+YlqDTdFDsULDIlKGgf/8pB4HT3HByS
 EzoCFwhL2Klv2eGbI7YkKWL38GYltAmqYq1UXNrInU7PDL1DhM9+grBepcM7Dvhrk7nj5CKhVY2PY
 KXNu6ecQ==;
Received: from p5089ba45.dip0.t-ipconnect.de ([80.137.186.69]
 helo=noys4.localnet) by mx.kernkonzept.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
 id 1smpwm-00Ag4L-1S; Sat, 07 Sep 2024 09:33:28 +0200
From: Frank Mehnert <frank.mehnert@kernkonzept.com>
To: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: [PATCH] fix SSE2/SSSE3 feature detection in tcg/decode-new.c.inc
Date: Sat, 07 Sep 2024 09:33:22 +0200
Message-ID: <12670861.O9o76ZdvQC@noys4>
Organization: Kernkonzept
In-Reply-To: <b65adf00-28db-42bf-b5ed-708f36b52730@tls.msk.ru>
References: <2975380.e9J7NaK4W3@noys4>
 <b6696d8e-19c7-4d14-80d0-85b92e398a34@tls.msk.ru>
 <b65adf00-28db-42bf-b5ed-708f36b52730@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=2a01:4f8:1c1c:b490::2;
 envelope-from=frank.mehnert@kernkonzept.com; helo=mx.kernkonzept.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 07 Sep 2024 09:20:05 -0400
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

Hi Michael,

the patch is no longer required. The fix was applied with

  da7c95920d027dbb00c6879c1da0216b19509191

I don't know if this was done independent of my proposal or not, but
anyway, I'm satisfied :-)

Thanks!

=46rank

[1] https://github.com/qemu/qemu/commit/da7c95920d027dbb00c6879c1da0216b195=
09191


On Samstag, 7. September 2024 09:09:45 CEST Michael Tokarev wrote:
> 17.06.2024 15:51, Michael Tokarev wrote:
> > Adding Cc's.
>=20
> A friendly ping?  This patch does not apply directly currently, but
> the change is still relevant (I can fix context at apply time).
>=20
> Before it can be applied to trivial-patches tree I'd love to have
> some Reviewed-by tag(s).  Or drop it :)
>=20
> This change is sitting here since May-24.
>=20
> Thanks,
>=20
> /mjt
>=20
> > 29.05.2024 16:53, Frank Mehnert wrote:
> >> The correct bitmask is cpuid_features rather than cpuid_ext_features.
> >> ---
> >>   target/i386/tcg/decode-new.c.inc | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode=
=2Dnew.c.inc
> >> index 27dc1bb146..0ec849b003 100644
> >> --- a/target/i386/tcg/decode-new.c.inc
> >> +++ b/target/i386/tcg/decode-new.c.inc
> >> @@ -2041,9 +2041,9 @@ static bool has_cpuid_feature(DisasContext *s, X=
86CPUIDFeature cpuid)
> >>       case X86_FEAT_PCLMULQDQ:
> >>           return (s->cpuid_ext_features & CPUID_EXT_PCLMULQDQ);
> >>       case X86_FEAT_SSE:
> >> -        return (s->cpuid_ext_features & CPUID_SSE);
> >> +        return (s->cpuid_features & CPUID_SSE);
> >>       case X86_FEAT_SSE2:
> >> -        return (s->cpuid_ext_features & CPUID_SSE2);
> >> +        return (s->cpuid_features & CPUID_SSE2);
> >>       case X86_FEAT_SSE3:
> >>           return (s->cpuid_ext_features & CPUID_EXT_SSE3);
> >>       case X86_FEAT_SSSE3:
>=20
>=20


=2D-=20
Dr.-Ing. Frank Mehnert, frank.mehnert@kernkonzept.com, +49-351-41 883 224

Kernkonzept GmbH.  Sitz: Dresden.  Amtsgericht Dresden, HRB 31129.
Gesch=E4ftsf=FChrer: Dr.-Ing. Michael Hohmuth



