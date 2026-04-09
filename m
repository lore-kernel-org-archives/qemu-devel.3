Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE70E98FA8
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 04:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAgaO-0006fC-LF; Thu, 09 Apr 2026 00:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAga9-0006dZ-6z
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 00:01:29 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAga7-0005Rh-KJ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 00:01:28 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-66dd0531d01so607780a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 21:01:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775707286; cv=none;
 d=google.com; s=arc-20240605;
 b=BXSdB9KwmNHVb9AfWoQgOi+cpfvVgpS9CN/kUA7PD+uAQI3E2p5c8TdinKj05fXmto
 5WFm6zTKYecf1QawlPU84Vr9ooGrvW/8atzJfInuKExxjJuualpPbtosRUET8AdE+ui2
 NfP3RopyNkE749PmtS0p9rd8N1NNqroTXJwl4LWp7NHP2dJBNQv31ygxJ29P57PvIZjW
 CMgVE3vdiRwYNUqXbrvqAgL37SM1Fs213Axty4CkrwKhXdBdTYCs0hechH0YWpBhrmiH
 E4SJA7qM1AvHNpRkDAomuDK6KevltrPJUlIst7vezNUaNq9WwdMefL90Fv1dSJCyvCMc
 XNyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=C7HKM2wQm2NmdTmZZRuChoXL0dYTtav1FY8h5Lcfgvs=;
 fh=QgsN7xBQtyqE3Cp72FyoYANEJ10sBTgA2oW4l/Z+AT0=;
 b=lbVPdSI6h2Zzp7v6DYip0Ug9cXHfWPKRBOHy0AZ2L7Vnj+5/L7DsGixuQAXBCU8FSn
 E1KucNMw4U8CCKgfg4pG3GomD5hwO/I1kD3Gc+4++nKn+1bXu3Q/nTxQ4B7ZP7JY+Qob
 opO4Nns2PPI46o5RZ0Oh4qSlpMvWyDiHshYvkFrFm3ULeeX28jzLPXsOO0z6gWVhZLHL
 Ke7vX1LMn9ppiSz5eWFYT1nZaADBzr1TnZ28nfHM8LiZuE0UMPou3G4sHrTY5H2pBsqy
 h3ToL9Jt9CXZUd/jjGJe6UzC5jH3ctslSrKJL36O8ON5lc1tYHz+d2s0hhv2PtzObXNd
 tj4Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775707286; x=1776312086; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C7HKM2wQm2NmdTmZZRuChoXL0dYTtav1FY8h5Lcfgvs=;
 b=TqYPfSlmrG23IpJgyDg7Nb86YbRG6/b+LRyuyrm6QdBaik5wXr+sF9N+DzamXR6qto
 xywcPMHViO/PV0WQM/EuEsNNhIqdIGqBM/LpsxLDpvF9JTdyPae0PHXTemoMkHm9URSP
 LdWHIuSg0Vpg92GRupqMlD0KUhkL9wmQcq0N5Zrc+Z36Ey30MJ9SE9kCgcco+D/nJ4EB
 Qdg7HNhR42JNPkYbPtrPwth7i6w7TDdLwMc9JmYP8+kz2I+w6DBo0CBPOZk5wOFoqAlr
 ZfH8PtI3crs3yPGsjHyN69t86S4PqZukFU/DgonWXlgfcapEOAo4M6FsXJCv5YliY6n2
 JUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775707286; x=1776312086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C7HKM2wQm2NmdTmZZRuChoXL0dYTtav1FY8h5Lcfgvs=;
 b=I0qFm0cf1KjZ/rsw4OPWfR4NFu9Btae7HUlgNtoj9/5rKEtIra8ba+Z5/wneUCajq5
 5800dbfehlpXRbbqlRvv9xlibM9ml4pXGXRei983KYLfWblRjpqa2zMe9ruUCu8BWDiZ
 TZndGVRQHMGuXcdKxtzdQLIBba4rXw3UgICKsMcJP64Cr+pXzNc8VaIllS+TevG/2nEo
 wfCXVHI9Nr9l17M77nqwqhqhqQfHNv/7e0KULaxXvHQQ0nKtlmA2emI8sXv6JydtroSc
 LCxBUo6lAJPPqGsqVg+4B1Lkl5hUHQ4RjbSPbQQBNw73zuKcjziwI46EgM2CaVSCynNG
 my3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9vO5CkcnXJOob4wiH21LMpdCJHKm25Zf3bEQB+oWM0SIu+PEErS4tKaWF/jKdMQz5K/OnlRF8AF7t@nongnu.org
X-Gm-Message-State: AOJu0Yy40Z23IqpSlB2SJ/ctW1K2R/51yfAKXkpvIktzNbm+crStNyWA
 5PAukc6ZuJxzxIG5SUVu8o7H65EJCJ+7C3ztK+iWU4oHdFhyNAnG9wEVPa6Q4lk76IUTimuK3WY
 PnTkt1Grt4/9HRiannEdfke8vCdh27ZQ=
X-Gm-Gg: AeBDiesFevvd4dDdsKg6QiO+UkwtfJTFnlT3uWiBMb3w7rhGgT7/Z8LI9rw6xBQFBIO
 O3suViXXExPd7Kl5rWu3aCG2IT6FjrFxTqF85j2K+jFxlemuvqxurpUPaAz5Zhx/C5l+1WA2cVW
 AyEox/1rQohVlYgubZAmJxyQGhpgYKD9SoLhEAJlzxu6JFSVUrw+BM04p9N2Roc0EDt3y8NWuMz
 ejvNsC89Nhf7Wt6SJiNnMe0GA9hmVPVI/pfyO2RBCxPYSJOjjTpPQg+rS6V2KWSx6BMNRHSX9fB
 OCWqNpgXlQ/GCnnmX1stCPsEPIXu8aXlRMRHhg==
X-Received: by 2002:a17:907:6ea1:b0:b97:c968:d9ba with SMTP id
 a640c23a62f3a-b9c6768a539mr1117825166b.5.1775707285487; Wed, 08 Apr 2026
 21:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
 <20260406154935.144674-3-djordje.todorovic@htecgroup.com>
 <884193da-0078-44f0-804d-e5ccaf5f3398@linaro.org>
In-Reply-To: <884193da-0078-44f0-804d-e5ccaf5f3398@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Apr 2026 14:00:59 +1000
X-Gm-Features: AQROBzCecAV2I5_udRQv0RNj77dcZHfplpurvfFfoFaBH5Z_hcQbWLGsR3aDHbE
Message-ID: <CAKmqyKPZRQ6djtJU2w5y=5i6Bt3Nkr7yOe+K0vnj-m_XKvG=Kg@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] target/riscv: Add big-endian CPU property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "thuth@redhat.com" <thuth@redhat.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
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

On Wed, Apr 8, 2026 at 12:17=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 6/4/26 17:49, Djordje Todorovic wrote:
> > Add a "big-endian" boolean property to the RISC-V CPU configuration,
> > defaulting to false (little-endian). This property allows machine
> > models to configure individual HARTs for big-endian data operation.
> >
> > The RISC-V ISA supports big-endian data accesses via the mstatus
> > SBE/MBE/UBE bits, while instructions remain always little-endian.
> > This property provides the configuration interface; subsequent
> > patches will connect it to the CPU state and translation logic.
> >
> > Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> > Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> > ---
> >   target/riscv/cpu.c                | 1 +
> >   target/riscv/cpu_cfg_fields.h.inc | 1 +
> >   2 files changed, 2 insertions(+)
>
>
> > diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_f=
ields.h.inc
> > index 70ec650abf..51436daabf 100644
> > --- a/target/riscv/cpu_cfg_fields.h.inc
> > +++ b/target/riscv/cpu_cfg_fields.h.inc
> > @@ -154,6 +154,7 @@ BOOL_FIELD(ext_xmipscbop)
> >   BOOL_FIELD(ext_xmipscmov)
> >   BOOL_FIELD(ext_xmipslsp)
> >
> > +BOOL_FIELD(big_endian)
>
> Since it is runtime it doesn't belong to RISCVCPUConfig.

I think the idea is that a user can set the `big-endian` property
(from the command line or machine) and then MBE, SBE and UBE are
always 1 and big endian is always enabled. Basically to model
big-endian only hardware

So in that context it isn't runtime, but it's not clear from the
commit description. Also if we are adding a property the property
should be exposed last, as in once all of the functionality is
supported. That way we don't have a property that doesn't do anything.
We would also need documentation added.

This patch should be merged with patch 3 as well

Alistair

