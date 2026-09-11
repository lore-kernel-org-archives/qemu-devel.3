Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B16CC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4yie-0007xJ-12; Fri, 11 Sep 2026 06:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x4yic-0007wb-GQ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:42:55 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x4yia-0007IL-OE
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:42:54 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66825847b2cso501087d50.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 03:42:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789123371; cv=none;
 d=google.com; s=arc-20260327;
 b=kvqSkAI6hDyP5QUOR6XYVv29KUnMpe70Jdttii7q8g96nadOkcewi+H3J143hNH8Bf
 Xa8m/APQFOiyhryfKTbjvH3oHVwYn79XR0pYEsgguhuk2XESbp2uVkQ3kf+/HTyQzFZ/
 eEgKb6v6gR78iI9xW8EuiGe9rZa8vSFMZKQedh4caU/6C5FAb9ENO0USXWgH3Gu+GsLe
 SCEi5lSE2ITSo92+Ex//kjn+Ay2R0IRkDh7Ysl38+DVH0xcVFq+me+H8yh4VXrXGpiBZ
 6MF+iLzW4pcYQjXi3HVKzD4SNEkBcyX5w5UkdNEfQ6u348BR5brJwhjqkG6VCmQWp1us
 tr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tbSZseq4xKJpH6pVez1WREuikexg6+VO4yFzWUUVwTw=;
 fh=aUY7suFJoK2sc+DDyUK4xVGAkkxh1iZAbQBuhf+ZV34=;
 b=rKvOf+5lCOAtK8JnCIx3DnYRA7Zb/3w3Td6689qD+pdln/6PiZhTjqhVPDbLMTHh7U
 nWAV5/DmHsElxLk8NVXOXlw2a3yTSq1YsNWrHFdS8BfcCF6s8V+2aKZajakaf42/+lP2
 fonT8KnJylz9bnYqyYiyBmKAWmeXQ371K0KAECqXhOwaJYYlevteJK0hDLk1Dg8jI1m3
 1ASFIN2+/cj134fZu3fpe0Jke14kCsrQqX3bMXJJuHaLah39K+HLoxtc2Aokh0ox8AlF
 1IrbkQMvzvf29ctmDWil1sGgN8eenlhZQWXKKkN0yh7h47GktDiD6UXljMHEekoOav1z
 /8jg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789123371; x=1789728171; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tbSZseq4xKJpH6pVez1WREuikexg6+VO4yFzWUUVwTw=;
 b=E4M43YRZT7w6zX68nrmmYrOJ/KZxCQ9hTaA3zT7yX4cKLyjHBkbKOrEi/prz6yRufs
 SZo6qwnZ3Mmtkw8Z63CHTCtNGfRB3KiSBsJaN3OYl8O3jGFdj3W1dZ/Hmw8d6xLw8Nd+
 DKpXzd8vCEX/vf48b+A0kJpmdj5nJ7EmmLksRK8EAnN49L40sbe/Bv6Qyi9ntV7JG2vO
 81zBdW1xpAEE/Bh6FaMV52jrJ++sK5p3lRlJ25uyUK73831MYsRRMIhNfcNNgPkZi3Ao
 ypcJtmWvVtO2MVRAUruVZf4+mYANCqVka4UsfJ0IXxo3Zt/rHntLgbJX44WSERUFZUgX
 mxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789123371; x=1789728171;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tbSZseq4xKJpH6pVez1WREuikexg6+VO4yFzWUUVwTw=;
 b=WgyHD8/cSM8XK6er9Fq7yiEVSfQ7GMQgh/gixcPdmFaDKgjzqEwsNT+b/S6Fpksa41
 tYpBcghsn/lE/0RHfxC0tM3B9CiYP8jK3NLPeRnGWmGhCeRyaMRJ3zFtstXVO2vKk8og
 UFPthT1u0foc8Bmxduu02+w64Dy1qw+T91AU7hwrXdXTMw7IDDi/kpntE1wymNLz3Obe
 HN+gKC5+7myd71CFNWtt3THJGQA0fq9W62br9vIV51UJnrG9YXjtfLEzfGucOE69SA8V
 84DYzeCYCJnDnNYwDZ02rUv7+WkYwr1VkRSuumxB+1EtKWZsdcxK759sdwCn4oi2NqRf
 RZ4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxz+3nB/tIHVIs+L4xSiTvaOgG5X2EF0QMe3qXkH7OJc5+lJZW+KZldp99fShqGq/sRW0R7xduXw0bP@nongnu.org
X-Gm-Message-State: AFuF++l2clD7Fvs1QflCQUfNfdIM77B0kI2XEeuZw3x6ciUpdcrr1xnM
 6Jds1jnQJN7Cfw7KyMZ+WtfL+3Ge98KdoROqtix8gg9P4/V0+na17JoyTjlmr/IM8CJ5eBOH6sq
 CfpiLgxyeEmoC9FGyeOvpA6dMGmiy3XE=
X-Gm-Gg: AYBFou08kc6gdWZfI5hZdphn4yNRmqBbOVb7WStYo0tgheneefJsenLEWQjCZuXzPTY
 P1V7xZfnOfXgAagWBGZBl0qJgeisz3EKFQYPhLzEJ7rnrmGrbTH5ULXO/IxPCxqvEFt8ti3KufE
 wbl8KGJ0+pRTumxE2GnSn6IIWA75osq1D60BsxhbKZQeXe5ysgYL1yLxhSvJeuhWKS/wHK9r0+G
 5KNSn+6U4heL0D2Y+UWfj/wgWhPgNDuRMMpk3o2UsH3tPNUibq/mWKYpV9KM91t/2Hyo+5txjz+
 JDaSw5BxoefyHAO7pJQp2Qye7LbOKhNXivFsNVCkau15i2FGIN+vC2t4DgEzpOBUU1dNGjQSbN7
 pUjHLJP4+52UIAx5ZuHGWO7YEVItddIjBUY8aT11BD+x8mil2zPoFolV18K92g8aod0G35daRQu
 g=
X-Received: by 2002:a53:a383:0:b0:671:16e9:691 with SMTP id
 956f58d0204a3-671247e7494mr876244d50.99.1789123370885; Fri, 11 Sep 2026
 03:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260909155624.1082893-1-pbonzini@redhat.com>
 <ab12c39c-5d5d-4c4a-8486-3072f85c25f6@tls.msk.ru>
In-Reply-To: <ab12c39c-5d5d-4c4a-8486-3072f85c25f6@tls.msk.ru>
From: Simon Scherer <scherer.simon89@gmail.com>
Date: Fri, 11 Sep 2026 12:42:39 +0200
X-Gm-Features: AcwNN1WU0pKbN59Pex974zPLKb95DE_dwG_5ALUtISUinADcJGnxnwIxl4mZ4hY
Message-ID: <CAEQwQtLVJa9du6KHb4Aoo5TbDOiO++AkVnpYfR8hrnirHxrOcw@mail.gmail.com>
Subject: Re: [PULL 00/12] Misc patches for 2026-09-09
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Andrey Polivoda <apolivodaa433@gmail.com>, QEMU Stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=scherer.simon89@gmail.com; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Mostly yes, but one caveat on "target/i386: clear C1 for all x87 compare
instructions": part of that commit is wrong.

The FCOM/FCOMP/FCOMPP/FUCOM/FUCOMP/FUCOMPP/FICOM/FICOMP part is correct and
hardware-verified. The FCOMI/FCOMIP/FUCOMI/FUCOMIP part is not: the SDM lis=
ts
"C1 Set to 0" for those, but real x86-64 hardware leaves C1 unchanged. I
caught this after v2 was posted and sent a v3 dropping these changes
[https://patchew.org/QEMU/20260902135705.261863-1-scherer.simon89@gmail.com=
/],
but
v2 was the version applied.

I'm sending a follow-up fix on top of master now that reverts just the
fcomi/fucomi changes.

Simon

On Thu, Sep 10, 2026 at 8:02=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 9/9/26 18:56, Paolo Bonzini wrote:
> ...> Andrey Polivoda (1):
> >        target/i386: Mark MOVNTI as not valid with prefixes 0x66, 0xF2, =
0xF3
>
> > Simon Scherer (5):
> >        target/i386: Fix FXCH to unconditionally clear C1
> >        target/i386: clear C1 for all x87 compare instructions
> >        target/i386: Update FPU tag word for FXTRACT's old ST(0)
> >        target/i386: Update FPU tag word for FSTP
> >        target/i386: Update FPU tag word for FXCH
>
> Actually, it looks like this whole lot should be picked up for qemu stabl=
e,
> is it not?
>
> Thanks,
>
> /mjt

