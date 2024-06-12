Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2333C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 11:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHMcr-0001dL-NY; Wed, 12 Jun 2024 07:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHMcp-0001dB-Bx
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:58:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHMcn-0004pi-Dp
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718193523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4h8sokfU1DoC+U2kM5zFQX4cG+bCbl4exI62FC8B+Xw=;
 b=XADQltlUZu0McCmmxJOj/oXND/S2rOX7BaOyZf7/8HpFUC7zoz38mNEIOczV/yq/9uH7rL
 mEHaxrTcNomOiuRRg07RbiqgKmYjq4SdlmyNyp0j88yFCVtVaXALT4L7SCl0SQaCCvMqE7
 00pefghUZDNJvgWKYwPBMlUY9WLEA8c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-18JbWjyjOs2E9CWNiOZpVQ-1; Wed, 12 Jun 2024 07:58:42 -0400
X-MC-Unique: 18JbWjyjOs2E9CWNiOZpVQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35f142464b9so2303207f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 04:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718193521; x=1718798321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4h8sokfU1DoC+U2kM5zFQX4cG+bCbl4exI62FC8B+Xw=;
 b=chmKD/K19670s0Cv9S47GEsN54KOH5cGrSxlO8fPOVRyxpPYr5e/XZ3gEtGmuTNUXH
 f8k2sOvtgaIR9JbT/Fku+Bh1IN7sI5Tisve6FvnmcBe7SSW3VY/aYKCwp1j5HyiqbHuw
 LA6akah5FN5vX21G6+Z0zNkT67rnFadRqvtyRYAKJ5882oVdKyvV5WhTUiRA41e7rFAW
 6KjFZoGEo3AY0q8s8c7iAMoDt9xM3zUeQ55/qiDzCbxISNlBt5IAs6eINvaBG0pDisGu
 yRHb/fVLV/ocZr4XDbu4SGFlSvGCDvU014QB/oN+LN8Nh6uBKYQ56qkcP+EILI7DtE/m
 xyLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeGClEf7TiARTsZStRMvgCISt55mRDO11B6hhBIchu7zNSI8plUv+fRDe+firQxwJt2At7XG2VLYNgf2hzesgiPfB3KlA=
X-Gm-Message-State: AOJu0YwhMMML8169F6Y+jPFEAuMx5jsZQNkXb1s9v0yoB0aiYaVUokVQ
 O1JOf9ScxbL5goKW+5QjWqFbXGtXXSFibh1Es0kPu+yKyQLnlfM05cqTJXPBn6eERI608f0B9wp
 IIS13E4XVIGO1eJu5b48TVB2VAJPSfmieWKovjQFVyfaP8l09Lb/0Np9gcvoAqaYXEJgOckpV62
 Qduevy1I2x+9i3gPv7bfBjcr39tkQ=
X-Received: by 2002:a05:6000:e05:b0:360:6df8:3794 with SMTP id
 ffacd0b85a97d-3606df838b4mr822628f8f.13.1718193521154; 
 Wed, 12 Jun 2024 04:58:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUPKc4pmD4ldXE8gnNh3ZzRZyZbFlFMto8ePueRqHkId+5Clra9ArVKYhz7hTw0PtzaHlh28P9l5zHIpi6MU0=
X-Received: by 2002:a05:6000:e05:b0:360:6df8:3794 with SMTP id
 ffacd0b85a97d-3606df838b4mr822598f8f.13.1718193520005; Wed, 12 Jun 2024
 04:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240612105525.8795-1-amonakov@ispras.ru>
 <ZmmAq8fbJLuaX4Qg@redhat.com>
 <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
 <e26ac8a0-5cb0-22a8-fbf9-54f198cdc7ed@ispras.ru>
 <CABgObfYf8=3yXu1p6q6jzyZ7uHy92BHaBXtJY8AMYXBdd9+HGA@mail.gmail.com>
 <caa7d068-a2c6-28a4-51d5-93c61f004bc0@ispras.ru>
In-Reply-To: <caa7d068-a2c6-28a4-51d5-93c61f004bc0@ispras.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Jun 2024 13:58:28 +0200
Message-ID: <CABgObfaswAJRffjdu9h8crD6jvFAP78CaDDbutvoa7EGxwuy1w@mail.gmail.com>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
To: Alexander Monakov <amonakov@ispras.ru>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jun 12, 2024 at 1:46=E2=80=AFPM Alexander Monakov <amonakov@ispras.=
ru> wrote:
>
>
> On Wed, 12 Jun 2024, Paolo Bonzini wrote:
>
> > On Wed, Jun 12, 2024 at 1:19=E2=80=AFPM Alexander Monakov <amonakov@isp=
ras.ru> wrote:
> > > On Wed, 12 Jun 2024, Paolo Bonzini wrote:
> > > > I didn't do this because of RHEL9, I did it because it's silly that
> > > > QEMU cannot use POPCNT and has to waste 2% of the L1 d-cache to
> > > > compute the x86 parity flag (and POPCNT was introduced at the same
> > > > time as SSE4.2).
> > >
> > > From looking at that POPCNT patch I understood that Qemu detects
> > > presence of POPCNT at runtime and will only use the fallback when
> > > POPCNT is unavailable. Did I misunderstand?
> >
> > -mpopcnt allows GCC to generate the POPCNT instruction for helper
> > code. Right now we have code like this in
> > target/i386/tcg/cc_helper_template.h:
> >
> >     pf =3D parity_table[(uint8_t)dst];
> >
> > and it could be instead something like
> >
> > #if defined __i386__ || defined __x86_64__ || defined __s390x__||
> > defined __riscv_zbb
>
> GCC also predefines __POPCNT__ when -mpopcnt is active, so that would be
> available for ifdef testing like above, but...
>
> > static inline unsigned int compute_pf(uint8_t x)
> > {
> >     return __builtin_parity(x) * CC_P;
> > }
> > #else
> > extern const uint8_t parity_table[256];
> > static inline unsigned int compute_pf(uint8_t x)
> > {
> >     return parity_table[x];
> > }
> > #endif
> >
> > The code generated for __builtin_parity, if you don't have it
> > available in hardware, is pretty bad.
>
> On x86 parity _is_ available in baseline ISA, no? Here's what gcc-14 gene=
rates:
>
>         xor     eax, eax
>         test    dil, dil
>         setnp   al
>         sal     eax, 2

Ahah, nice. :) I'm pretty sure that, when I tested "pf =3D
(__builtin_popcount(x) & 1) * 4;", it was generating a call to
__builtin_popcountsi2.

Still - for something that has a code generator, there _is_ a cost in
supporting old CPUs, so I'd rather avoid reverting this. The glibc bug
that you linked is very different not just because it affected 32-bit
installation media, but also because it was a bug rather than
intentional.

Since you are reporting this issue, how did you find out / what broke for y=
ou?

Paolo


