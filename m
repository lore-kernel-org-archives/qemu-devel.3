Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8A7C282D3
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6XL-0000ya-5G; Mon, 03 Mar 2025 09:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tp6Wf-0000pT-Hw
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:12:12 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tp6Wc-0006Ez-IZ
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:12:07 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6fbaf4cf2b5so29786097b3.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 06:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741011124; x=1741615924; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c4se0JcUUSt1l0DsIdUpVzlZalM69sHmE0kyAvEGe5k=;
 b=aQNDrgHyqLjD2q0MGMGwpRSbV1wCftuZb1zswvDYKGIYf4rKw0eu6lPDr7ZD3tax0i
 rCBC2QGEgLAPHuWKRMaeSVrXpABZ/kLXD8lLiT8/Q7qK370jz9aCxBUxVpkSLFLogsdb
 YqdHANvJbwWoznxWVlKWlylz4A0A9LEFZjzEEV7isI6IXLtFe3F0ou4Xz7oiSTESJa9h
 Cc9w7mOfAl4wRek+KMiwXCBw0uZX1aliYjWYm3DFAabqWOrGfWcO8OGNjAYlKEDLROcs
 dCGRatJ0SvDUZ12PsZWvVhrft1eA87eDlNJkpopkOAkymTz0W8kbnYOC6IIRSCMf0zp6
 IIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741011124; x=1741615924;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c4se0JcUUSt1l0DsIdUpVzlZalM69sHmE0kyAvEGe5k=;
 b=KLsNcz1dl24LNzyOSaT5UtC+LBpHxDzG+Ye8BR9ePvN52g2JtyKLjEeBweF9ENCuSn
 HJgv0QNLqb+Tt0RUwVr5N6a3Avo1CcMFMVFak5IB8E+cdNjXEn/vCmlvkwTXv06a0GMT
 TsaYoYxFSw8VBYZNoV+u8DDaiFGVGH3RhuHX/tCoWjG4P6GyqV2LClvxSjt2boznUEXB
 TjyLFDO3yLAeijh84ifRYtV0QPLU0xJbPBUOfIZhs6Ne8f2VqGpBCWqIzJIDw95MaAYV
 UzxUBncimOlI8AFYdLD7WI0U/LsvOlqT60q+tecd5gqaHgxRqH5IhMLL/0D1aolSCZko
 c/3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcADZrpc1LNGICjgIYE9A6KwwU469OXVgBoJuYV/BLNqfOUUZKXpay0xzoPEC2vOBwntCzHlo/b6Sj@nongnu.org
X-Gm-Message-State: AOJu0Yw4msEl6/h0mcYYkE72C9cgRMkDxhYLLxIjxTi8y0t+QpATx1+e
 s+cqMjxcGT9CbjeByyvCieSeKhV9lZ1HrarnEypYnEzfmBLiXCzSLSow93Gn2uDQMPmjyiCzL07
 5VE6g+g1mX8r7lAM8aQdiy5ozjSSOelEtwI9klQ==
X-Gm-Gg: ASbGncvsXehUiWfHEernxml2WMZSoZ1UYAwWYgjI9XO2r899GB4CloNaJ6amxE7topc
 7wu6FXuoNuIMd0+MFm+txRWafG16lnul/+LRSBcTd73ZtmJEIJ+dbKMa/y+xdfh/A8pjvD8ZxYX
 mRqwHEVOJHx+VdeUU7bGvvyf+tlEs=
X-Google-Smtp-Source: AGHT+IHMfxk3TICpE4yNWklnb/xRBKhb4tvCYFEG/nxo7gIdOIHyfnQK0R15/uSePe8LHKLuD1UiVUfQd0mWFWaU56k=
X-Received: by 2002:a05:690c:4493:b0:6fb:b8a1:d3bb with SMTP id
 00721157ae682-6fd4a02387cmr164796637b3.17.1741011124254; Mon, 03 Mar 2025
 06:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20250226024603.493148-1-venture@google.com>
In-Reply-To: <20250226024603.493148-1-venture@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Mar 2025 14:11:52 +0000
X-Gm-Features: AQ5f1JpzfHXwMG4-5NoLwQ7JEqGektmvxs4fJTBxL0SxP2ogXNLlo6dNN7jJM9s
Message-ID: <CAFEAcA-jOcycjqDiqKPJi+WMK6OBBp_8vwx1ASpd2jr3HnqE0w@mail.gmail.com>
Subject: Re: [PATCH] hw/gpio: npcm7xx: fixup out-of-bounds access
To: Patrick Venture <venture@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Wed, 26 Feb 2025 at 02:46, Patrick Venture <venture@google.com> wrote:
>
> The reg isn't validated to be a possible register before
> it's dereferenced for one case.  The mmio space registered
> for the gpio device is 4KiB but there aren't that many
> registers in the struct.
>
> Google-Bug-Id: 397469048
> Change-Id: I2fb8d0d3d41422baab22e8fc7e9fadd0f2ee7068
> Signed-off-by: Patrick Venture <venture@google.com>

Applied to target-arm.next (with commit message tweaks
as per Philippe's email), thanks.

-- PMM

