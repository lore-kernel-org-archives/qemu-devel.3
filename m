Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1428C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxKgJ-0000nu-OG; Fri, 21 Aug 2026 04:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxKgI-0000lq-0C
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:32:54 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxKgG-0006Sl-Et
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:32:53 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6688acd1a51so1243362d50.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 01:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787301170; cv=none;
 d=google.com; s=arc-20260327;
 b=s9OYMwxG+o82lfo1Mva+XB7x+kFe2h0ZZILjHqnmGroZXDHZyrcL/WaVrDB1IycaEA
 xNoIHh3E13xYPCK1GpTqy3fM/qo6+KmNz3D6xSNZu1X5E4bXyV64irIz5lali38gZjJw
 jTrg7YFePvo1ZHiVpFvK5IZwhfiP+17gME/TWsIfj/XWOuMOhGPRAXp0y5JcCPI0bK0w
 0qK9zHO/OpMcjiIcWwXVhkJtgSRZGSE6IFyHHTasohpcNPy4TFFh+akqNa0BqeZQCnzS
 J3gbhhLv/DMKaq/qRovdPPFZkjSu7PKDLImwhAa7CKQJy9lfySVIomUCa2yX4e4p+NOE
 3Xtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=X7V8EptM7f7oCanY7XL4s7R6X3Lifn2fSE2td+MsNQY=;
 fh=RwZq3okHjZyxLOJY9IBrfx55JF5TapXGxHRFuPSRRI4=;
 b=RVWfPoW059haelu61y5Gg+v0i3hpqQveuQvLtlg9v+sGiYOpEP7F4T0gEAFZWpa+9R
 dxUvUHqgjRdslxxCaLQ4IYjDc5r9dCdTkEfBTaMqSa7O+ZoT4vlPz/8D6qrifpLQJY7R
 wN5eKvo4P4DWcZAI1f4aX5uzNIoigWopEj1/9R5u+P6GxttTJkZ9rTRKjaSBGXYI9lWm
 eDQebh3cHwSsGdQT0wz2OvtmYMRKdLXRHOYR8K8MHpxTVZmp/LD1F2JfH72d+XNYLfCu
 iCGv/IQJGJP5+AY3a6xbIaUb1vbIZ2b0zEQh63+4MAE5fjkIlILi1JCj2OKcaRYC2z/C
 J0DA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787301170; x=1787905970; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X7V8EptM7f7oCanY7XL4s7R6X3Lifn2fSE2td+MsNQY=;
 b=ERzFwEd5yHRfWaNQbga3KWWhpv5Nktdwc1Rv5kmBOoKEOTu4L+pwwtyqRgwxJaIlHq
 SNcuMAMDYgw5zcoSXeO8WeSVf8jLrXybkpTAWOrvacRh7nXF0NcmtzK5Bjmjl0E/qZBX
 vwyuRT2KGNDR/hp2K+sheRITREJZEYa6PclXI/J1bk7Ql/LXfEMQLWajyrFpykHJGAia
 +Ruje1VipRi0Wb9f1EkyRuX+hRe0NLD2HWN0nMgca7H8P18sUvkCibW3uhtGMiB2O1F1
 MSeDvxCX2uSPeKN2t5Kh2rcfYj9zmWphiZrmwWEwJ/bCxjtjjiM2+RMT/vBT78VbV6sw
 Y5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787301170; x=1787905970;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X7V8EptM7f7oCanY7XL4s7R6X3Lifn2fSE2td+MsNQY=;
 b=cnft04VLHOrPYKDjDybrGMDI1wEfRVwq6B1aBt/p635eUxOIlqAdDpdfSy4SXeFSOk
 wTHAD6eAhDHOk77nyqugWRcWcrD+UsPOpqj3U6W87X0ALgIrucOavtjy6leJu0xII6fi
 cqdlULFTpyEyH4X81jvmgJ9dH50fuZZ5k6n3NKOZRBXI6rhpY8qHRREdUJ6RhHn6f9Bo
 q5WYbbBIKkD+hfWwxUshtzI2cNBA6fF7aMQ4SEXtvmwXEs/L0D7HnFsClLqrA5Pg2XwB
 8rZfyZoUYzlc2yzXoRcRKHd0/sxl1xoJNy5r0wV4MZX6E/RT4VPdHPFsstnK4UUais7u
 kFlw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrILMY59Hf/cBg0iZKNQI+giH99bjQbQQjVbPu1qvOMQkGMdrulm1K5yWIPN5liCgdv/8Ed8YIVpQjE@nongnu.org
X-Gm-Message-State: AFuF++nrPHoovFMmBRbSB3jI0jacTy71isGoRJSLmORz1ONJUkUrlOqE
 MoL17lWJF2Zdp9eI99g+O5EIcT11NvCDC8q29PudvmtxOJA8cuofoSjdkprRw2spBNbIuMRbWsv
 Dk1PZVCGw41CgYy/EvW90ZuA1qcB7LfBf6HR/BPzr2Q==
X-Gm-Gg: AR+sD10nww+K6Jd8w+rcnqR8E/TJcVO2ETfcYWObzx4fv3gTq8c8oMKMUDceX87hTnS
 P/yfxw1ItAJOP9ovC54DM1VHumSKqUg2aLdB838F9xQD5dMyn+/Dd/l5fTwImlt04vsMd1mBtaN
 sZNpz5yJ39QO1BRcwHcNyVC6V9qP7hmRkm4NUS0kh8yk2fvqHweNp+JcNl4n3rveQ1j0cYfSosg
 Xc5ArB4M3RUmE5VKrMl+6U/FUzacGPjihLHTe94IASran7b9OgIj8KVsZNOzOmg9u/s0b1CAmNK
 m5rJfQ8L6Aw4FQPv39dXvYX3QPZCdRlwUdNivrwNAVTKafHPFM/zy9W4NCU5IO3fMylWvXjf3rF
 +F1qdmvcIoOwGAE/5B8pG9yXgDWMw2D1vSCLlO10=
X-Received: by 2002:a53:c203:0:b0:66c:b8ff:fa9d with SMTP id
 956f58d0204a3-66ce4b343fdmr1550464d50.43.1787301170232; Fri, 21 Aug 2026
 01:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260819185430.3467629-1-peter.maydell@linaro.org>
 <20260819185430.3467629-3-peter.maydell@linaro.org>
 <be278ba9-1e87-4def-8bb9-eeb14b17a03a@oss.qualcomm.com>
In-Reply-To: <be278ba9-1e87-4def-8bb9-eeb14b17a03a@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Aug 2026 09:32:38 +0100
X-Gm-Features: AcwNN1WQ9Gkaemd4bv8KUaD5itzpcG2M1Nw1KHhx8Nj6LmceEfSfTfhvcyOGlQM
Message-ID: <CAFEAcA9ui8LDnYK4uWFEMMATvxSkx2QZZ6aNFMs2Ag5PcuFvzw@mail.gmail.com>
Subject: Re: [PATCH 2/5] hw/arm: Remove spurious WM8750 dependency from
 Realview Kconfig
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Jan Kiszka <jan.kiszka@web.de>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 20 Aug 2026 at 11:55, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 19/8/26 20:54, Peter Maydell wrote:
> > The REALVIEW Kconfig stanza has a "select WM8750"; however the board
> > itself doesn't actually use this i2c audio device: its audio is
> > provided by the pl041 (which connects to an LM4549). Remove the
> > spurious dependency.
> >
>
> Is it worth Cc'ing stable?

I don't think so -- the dependency is harmless and has been there
for years. We only need to drop it so we can delete the WM8750 code.

thanks
-- PMM

