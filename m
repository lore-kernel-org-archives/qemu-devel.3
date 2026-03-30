Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE64FF493A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 04:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w74R4-0004nM-JV; Mon, 30 Mar 2026 00:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w74R2-0004mk-BR
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 00:41:08 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w74R0-00078r-TB
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 00:41:08 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so726928766b.1
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2026 21:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774845665; cv=none;
 d=google.com; s=arc-20240605;
 b=Bul4UCaLYSbUC3rBx33bg81/egcC+sLutrvKLtWDXOmFC27nMO6opwgX9wYLRB6T6v
 Tr4vo4mtRwVptKymL/cyqtWAFRzu9qNnyOBwsTA/awBj4F6eVlUkfof0z2KzmO/zmSgc
 ne0jbXR7DxK0p+fm3983Or240ihff6zDkOPKZC6TefgfEonsznnnKSxbR7yTL87mA2v8
 zmEYeyCLNdeoEVaAg1/gxo15MzyxWpr/uckh9hurxKrL0juQbBaLJ7wQa7JmTxEv5+w6
 FG/2nLHViPjIdrP26npbzJKRvTxin5R3nfDn1QSP41qU/5HjiAbuipdEmB+3C7A7611s
 FJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1W70ohp22ExhfoPnRFf2rMAjXTIG2HfvYYcJJ8iqOio=;
 fh=c5t5J5DuZ07TpANKDNQXBQqHNrBr5lv/14VrOPTGi+M=;
 b=EgGjSqzZiIJvilsaRrmLp5MeQGopOgAYtf5B56xLrVkwnJOeyceSsrfr9wOMrnAkjW
 OFtBEphx4MaOsdYkK9N1RI/zlEJbbTi/k4jtfEB0FOeypHmqav9kvqz7sMCA3qVg6K7u
 l+eLZ3Z89v9n7zurkDMR5Am//aL6D5dpzeyzFdYkrXHVpfS7FaqgyWzloST/hStqLtTR
 AEV7TL8sR7JKkLkl8ZVcVH9iT/TqQdLju3fmwYrudxIvLVSufWaPjf/rX26wV0EYUCPy
 xTJl7rmeDl5yPrvbJZHqJyXHhzoA5RA8wBhxJuJlGiPYNUQ2VuwZ9G/o1OtikDZu5IL4
 ub+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774845665; x=1775450465; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1W70ohp22ExhfoPnRFf2rMAjXTIG2HfvYYcJJ8iqOio=;
 b=dje1j4OYE3dDvDtME8oZ9YLFEb8Hm87LSvCiqqQlJGlZL9rnYcIadjPPf1Rp6V2A5d
 cmCW0g9z2IrWyGtcKdUXiC/UJUQ+FExVTqubrXx1YTfh6g0yQQtbxmAXgeiX9HDnsr00
 f6mHTGqFOkKO5fA5bKVanPpZI08mfBlgcHnR4HnCQLb+vhdTGHUW6DakGUhcs38A/fvw
 gynwVydpG4LxPgv5qnywmQClL1JBrpwiGGdL/2fkq1EPw/sOhqiz5HSyoreYTYpEdPNZ
 +X4qNIIhe68DVXujI4PoHraGAxR6LxpyypJclIDWkgWFuqDbSB9Neh+j2tyWsZ0TLa4o
 G+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774845665; x=1775450465;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1W70ohp22ExhfoPnRFf2rMAjXTIG2HfvYYcJJ8iqOio=;
 b=mIEcTpI/b+1cuLho0tdyXAjjKfaDsx7Cs+3aveQ/A3KVvQ8eAnWlrNLydOV0HChZQK
 L94G93Qq2D6U9Tp0aSmP7a/6qT/ZwGpfEko+erwAmD85kJIytZ09ah+YXMypO8k7erGw
 SIGIQXfNU7RbMSpJlTe9Mx7t+CcOGFx84sn46U7yC728fBCirg0ZQOjnS4cy4dr9eYCf
 RqWk3PC2HRO+KWithBlvzJmGlXM9c602CYVY4J/mvNjWt5AjUaMfNtbXLay04/4xqAfG
 QTFeNFxOpDnB1IGa6O7HfLoEpBBC8qa9kM78kLYjQ2NAce7ucXNA1J6226D0/udU0iwX
 C+Tg==
X-Gm-Message-State: AOJu0YzUk2xd8kNtciPLH2Erq9v9iKFPhNg9VSBwezDWVwyJwQVzXD8b
 Uqfbz0reCk9f4vHTXA/T8lrKofoFpC6Zpgme691YhGJ8pQ80wBbDVcuqx7OukCy2NuRoVgxjw3N
 fnpi2ftuKmLdt30dBNpvgkGQHeUA+gMQ=
X-Gm-Gg: ATEYQzzrVcIDv3ta10nt9uapYQ1Ued4EC5sph5ULpe+vY156g1/CgNsL6aKSNLZJ+UE
 U1rVKpUFoUbVHEsu1E5vt9ovNuOto9rtX98fIfU5hn98QSXrsQ7CICLEguQW37MraCa65fP+OAl
 uN9Md0Ba5FDNEljMwO1/jqyEUHWALiwFQ4zj/lrZ4QRWYUXzqNUQ1pq4fGfefP3jrVanczfO54w
 YnvuPDInRxmYcRB/2vt0IRiMzwL/mhGTuPgTv+nGRl9JRP4ti4eJc+It8P3nEq3bMXiGvAdinQ9
 nO8XLVemDleniaEpw5WavVxKRi4nfFZqbwl9zg==
X-Received: by 2002:a17:907:9605:b0:b98:4d8f:d968 with SMTP id
 a640c23a62f3a-b9b502bccdfmr667406766b.12.1774845664801; Sun, 29 Mar 2026
 21:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260325050011.66722-1-jay.chang@sifive.com>
In-Reply-To: <20260325050011.66722-1-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 30 Mar 2026 14:40:38 +1000
X-Gm-Features: AQROBzCXaxpn2Qj2nW6jpbBGlCJ-x-p56Y0XOCXvMzprxZPk05wLlJdn49uJZrA
Message-ID: <CAKmqyKP4mnW8MjH3a-SChUmP7EHBRu2T5gdEn4xydCV4DUhcjA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Bug fixes and IPSR.PMIP support
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
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

On Wed, Mar 25, 2026 at 3:01=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wr=
ote:
>
> This series contains two fixes for the RISC-V IOMMU implementation:
>
> 1. Fix a bug in the HPM (Hardware Performance Monitor) timer setup where
>    irq_overflow_left was not properly reset, causing stale values from
>    previous timer setups to affect new timer behavior.
>
> 2. Add proper RW1C (Read/Write 1 to Clear) support for the IPSR.PMIP
>    (Performance Monitor Interrupt Pending) bit, which was missing from
>    the IPSR register implementation.

Thanks!

Applied to riscv-to-apply.next

Alistair

>
> ---
> Change in V2
>   Add commit message
>
> Jay Chang (2):
>   hw/riscv/riscv-iommu-hpm: Fix irq_overflow_left residual value bug
>   hw/riscv/riscv-iommu: Add IPSR.PMIP RW1C support
>
>  hw/riscv/riscv-iommu-bits.h | 1 +
>  hw/riscv/riscv-iommu-hpm.c  | 1 +
>  hw/riscv/riscv-iommu.c      | 4 ++++
>  3 files changed, 6 insertions(+)
>
> --
> 2.48.1
>
>

