Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF37ACD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 20:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRFh6-0003M5-DP; Sun, 24 May 2026 16:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRFgy-0003Kc-Py
 for qemu-devel@nongnu.org; Sun, 24 May 2026 16:45:02 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRFgu-0006ok-T1
 for qemu-devel@nongnu.org; Sun, 24 May 2026 16:44:59 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bcda7765d64so1811640966b.1
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 13:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779655494; cv=none;
 d=google.com; s=arc-20240605;
 b=FkvYcUWDkjcTgz7z1HBKg7YMdlj7B9WVgu9Gim9d0siXALs/hkDrGjznf3mpHgsb14
 POT8NvLuIhQ2wbU6NVRXILn/720SRHPbYWl0sEWug2RaA8w0tkuN9pVqezKvaJ0B8Arj
 MATJm6ExM/0V6SUOgzcPcIEiJAMImCMaMeEZOS9LJLqFc0nP9u3dV8AMB/I/CAmEMHAf
 0r91wvFfTpcHB2yCtanX4NdxukAjDy1KvFmuaXn8El9bor38mcG5jplrU5eeAB+FVi/1
 jHlyiUZaUrExggxpRG+Z9QKzyyXMHB0Ijsgnjjn0hvmFT7ODVhRAdwEd4gw1K1zRCQOQ
 lYow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tFTh/zRJLzlsp93HGhklSCwo9s1Dhj5hc+rc87wWVwA=;
 fh=mrAqOAlRIGzl3d4pNRwV1B423btQKQRubQ2Zcl+rj0E=;
 b=BIhPNGxfhf6Beqr0CYYT2dA3I/ywg7CxbachM+c7jAmB9irLw08HN8y+vZG+jUgSZu
 P0FbJziM0n8LI16KFLmQn9ElgVznzmxDTRfaROv3oWTQ6wEAg31DSNgtixqzh8HNccoB
 /WsDEI+rnBtkdDx554seHNuPbHp+ehC7PgE21Ie+v2gkOSPUaVex8plXZJEOghCV4jOL
 dM0TswKkxBoiySoesi5Z6mmkd3PiAvhI9/KJK0YvC+YS+bh0hSteRt05wS1EoHk4B/FE
 HuL6zlPPbnBTz1Vhb7c2qUOxRhoNglUUddgjfSJc4kgrol6PyQvrLBYi75B93shQs21s
 uobw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779655494; x=1780260294; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFTh/zRJLzlsp93HGhklSCwo9s1Dhj5hc+rc87wWVwA=;
 b=UMsg28grnoG7wwawXPViaugAsNnTKJEeXvBZ7zQtT2IUwmkMRfnY5cShy+q1CJQf7x
 td39L3NIVzsSc9sv5BFVlRQF0Mc9orsaFuLW7n/dVndMrjQrOztkpbF+PC6jenEkI4T+
 I1sQQ8nWNckyo/dduUAqMa9xqAabnVTd5rMvS5nFRUDFKHQJclateSKk8L+t4Uj/Hayi
 LsVSHXjF+KKIZyIuh+CVEtqO/3z7i8kEovIQ4Cup0JJlPhEJjsXCVL7pJ7dD5nG4OCF7
 DOkBMRPQO4mOGDsS/Kl74uXRRlqH8oOK5ETllwi1xlodFEHChACWjum56MnPHpcS/yiA
 DyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779655494; x=1780260294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tFTh/zRJLzlsp93HGhklSCwo9s1Dhj5hc+rc87wWVwA=;
 b=HL/PPyivheRuSaunSRd4TaPtUd0PFex8la3KHbx5DajnRia5UP6fSz0DncwVEhRH4e
 gPeb+ccbFdTvoCyNTkC9bKFy4x0o1sS3nPwjPUgCRXdJ+Z9W2w2Rb1sWPJ/qNzYsJV1K
 8FbFGwPEe8eOIlM47bv+n6Sztu3JEJZSE+3FJe6kRfhuy7xvmTcvh9hJSexpqgGeBHfX
 RTtmtrItN5jvVlZo4LFIqN5FN7TmTZ94PlMaylI+pE85pG+RBQeBp7ozCM/j4Bk3toSb
 A5r046nLef81kFoq3uDcsfOCvPUGLjYFYDOSHa30ILDWB6IMnOjUAPUHkV4m/1XaZPOl
 W3RA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8Cy/OtjHucH73xowTIllqxaTsQXi4APActEX8SVGKiPMAdm+NzPT8ShTXFj4RPUbCnppxZir5rmB0@nongnu.org
X-Gm-Message-State: AOJu0YyjQTBYJwc6lI7lANzCscszwkLL1pS6fJV1NKZYKmFlfU4ajRu7
 ok1hHHcAt5P3lSv3rcEmNSFJj78ln3vdf/VY1ESg0q3y1tEED4FNkmKlVfIIPdvU5KviofWbjEB
 UcSAcZ2UlmSCZnWS+nFttKNcOAWyEGxM=
X-Gm-Gg: Acq92OH/pHUlIcg4OWdpcwH0Zafv249wwipB+eT2iK/a5Q3XKcxIiY600DQ0YkIVHU1
 XVU+idx7ytiRRhcxevWVSNuCrNzAg9JZ9KGMx+ZtSobtROwSIGLcDGfF9qsY7DnQWI2lj6ecHye
 rBNJ05P/4ZScf1A8x6Xe/Eg20SxiLYZE8fxCOX/KiFnRMwpiS0ew12iqYEhjZZ+AkV04b/shmPo
 4HoDUMzLuoshTheXulAL3R51HmHkxyOY5qb4jhPHluxEygOHd28fhPTFtj2fmXkwyLQY7C3VtXv
 xcN7Qb60U2zYdaA90vQADGkBvM5MVsvJ0Gyjkt9vxg==
X-Received: by 2002:a17:907:94d0:b0:bc1:d3d2:9348 with SMTP id
 a640c23a62f3a-bdc0132e924mr710569366b.20.1779655494121; Sun, 24 May 2026
 13:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <87v7ccd9eh.fsf@draig.linaro.org>
 <20260524161048-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260524161048-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 24 May 2026 16:44:41 -0400
X-Gm-Features: AVHnY4L8z5RFFlhYgvAV7DrYiztGw8-WJAUBlRBrgWUzwlGZaJA2cmE3sDdOYdE
Message-ID: <CAJSP0QVuRHg+gkP=aQzbCAeZfMVFF7qWj58QcJwSPTfinApa_w@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun, May 24, 2026 at 4:12=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sun, May 24, 2026 at 06:06:46PM +0100, Alex Benn=C3=A9e wrote:
> > "Michael S. Tsirkin" <mst@redhat.com> writes:
> >
> > > So, I had to reject a perfectly reasonable patch:
> > > https://lore.kernel.org/qemu-devel/20260320193746.242704-1-jinpu.wang=
@ionos.com/
> > > just because of a tool used to make it.
> > >
> > >
> > >     How contributors could comply with DCO terms (b) or (c) for the o=
utput of AI
> > >     content generators commonly available today is unclear.  The QEMU=
 project is
> > >     not willing or able to accept the legal risks of non-compliance.
> >
> > In the linked case the LLM is basically doing a glorified search and
> > replace. There seems to be no danger of accidentally regurgitating any
> > training data which is where the worry about inadvertent copyright
> > infringement comes from.
>
> Does this mean I can merge it, in your view?

It would be a good time to revisit the AI policy. From the QEMU Summit
2026 minutes:

"- We plan to solicit feedback in spring next year on how the policy has
  worked out in practice."
(https://lore.kernel.org/qemu-devel/CAFEAcA-OmqRTqwYZ2WCeqFu=3DzxG65t6WSfKR=
=3DNthfpazrjzpzA@mail.gmail.com/)

That hasn't happened yet and it's almost summer, so now is a good time
to have that discussion.

The policy was written with the option of adding exceptions (see the
Exceptions section at the bottom of docs/devel/code-provenance.rst).
That is one place where it could be extended.

Another option is to say that the situation has changed since the
policy was written and to replace it with something that allows a
broader range of AI-generated content instead of just specific
exceptions.

Here is Software Freedom Conservancy's most recent blog post about
AI-generated content:
https://sfconservancy.org/blog/2026/apr/15/eternal-november-generative-ai-l=
lm/

Stefan

