Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4118D11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOc2e-0007X1-TQ; Thu, 27 Nov 2025 08:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vOc2I-0007T2-5c
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:27:52 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vOc2G-0003M4-IG
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:27:49 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-78a76afeff6so8721517b3.0
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764250066; x=1764854866; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vrfn7kOWdyDusb9P91Onim7DWDgPU3SLrOocHTNZwCI=;
 b=eObfdWqLgAa+4k/FJGBOkX7uYjSUlBUcP10c6oyl5f9abIfARfUDPcVzHQT6DTlC+P
 Gcrw07KZEr0NExBTGAddB/GYPgspyu7Lka18qkdPr9C8XsUhlaIkobZmmNXnCgzdKyQD
 VNW5IIiiqvJAqwBtqSKw/NRx3E2DBuLvqscJ+gxFkUEVnUY8H0uQQrYJYOGy3PCcLalo
 xOTRo0Bq8mcAY2THJDDvWFCBc+CO8rRXTAewYh/IiaFAiPkSuHkS2TforbTa0DF33Fml
 LWgSCzf2Wx0Iz7L1VjxSCrqi1InLfuKH3qYA1gRpB4nHmiZZkpS/IAGRtp+BX0AJquou
 HfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764250066; x=1764854866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vrfn7kOWdyDusb9P91Onim7DWDgPU3SLrOocHTNZwCI=;
 b=c5yyVhChuNmwpnNGTrnTZVefjBEWgNwnKOknjlTa0SsiUvA6NSF/WgDSzDZanHrIsW
 tgiFET8d5pxiJmf3lVU8zVR84tvv8gQ9rcK0OoJwmdYb5ozpuIdNFciu4Xe83LxqQuKE
 f0gFQxzqYVydPU5IZFxQ8hObhmlP0RqffupLMrB+gEx9CKS6b7tR+XgiqesNzCHrxCy8
 wUgjXj74uxhW7RUR6eFgOGEa5ZVEhC1fGGVDO54pFpv1msDvHp9dmOcbASTiHchKZdkF
 swyJvnvP2Bumq1VHypVchpOnlHSnewJCWjuncCe3gsrGjlSbdcPO+FYmARS7fn16j/5X
 PyYQ==
X-Gm-Message-State: AOJu0YzvRhLT98e5O2Z1LfcJxCPjqJudyAGN869FTVLMluEyHLt3kjea
 9B/InoUFiTcOeJhF7YAAR4Y5HC4xjtnCJ/mMe4uqnf5oHN+oeoSO6O2prlfYZb755eFLIspHYKI
 IT9ujnaJrOo5iSzwEoD9Z9cnLApuBKtHy1p0KaReS9g==
X-Gm-Gg: ASbGncs6DFr2GPu0m3fNTjm3yTJCFVq7IcqAgfvwEdO7Bu2TD3ZLLsiWczEPAXsdtBD
 +CjU9WCnD3TCeHv06ZIz1kik+oTv7LTzLfBSPTy0tC2i3mz+GUbjlu1nvX2WvbbaB9suHQC1sx2
 TehslCnv/BGrwj8UfOiSNcMZszzS9oP+dJ9JPlpVSBCLDhYzzJfX2rXOwrCBNMATCgvjxfD5J3B
 L3R9E9pc2IwP5gHB5jctnmPEzquO0d6b7dfMXm1qwT4w/q9mxQi98LTBN23lzogLkeOC47n
X-Google-Smtp-Source: AGHT+IGqz5KuyDnoktdGCKsh5dHkHLEb8jtBQ/ITk1K0deUHVIchbNpjBKxQ3lHSsoQ/toiWo78ynyF/WpHmVR8Hs4c=
X-Received: by 2002:a05:690c:3510:b0:786:6b92:b200 with SMTP id
 00721157ae682-78a8b4cbc4dmr214741347b3.30.1764250065946; Thu, 27 Nov 2025
 05:27:45 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-hyn0B-yWE1=g4+NN9=NBjWvk-P8qrAk9L4vpAZpUYvQ@mail.gmail.com>
 <20251127001247.1672873-1-navidem@google.com>
 <20251127001247.1672873-4-navidem@google.com>
In-Reply-To: <20251127001247.1672873-4-navidem@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Nov 2025 13:27:34 +0000
X-Gm-Features: AWmQ_bmahUVwJfIGT4BTlyfL8h0V1tziALKGujJJuLDyhVaKwnHmLL-gP1968Tw
Message-ID: <CAFEAcA8=5g2zLQ_ueGv0oV-tRVOrD_GasXVGEHMRjHOC_GLksA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] tests/qtest: ahci-test: Check only implemented
 ports in verify_state
To: Navid Emamdoost <navidem@google.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lvivier@redhat.com, 
 pbonzini@redhat.com, zsm@google.com, alxndr@bu.edu, 
 John Snow <jsnow@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Thu, 27 Nov 2025 at 00:12, Navid Emamdoost <navidem@google.com> wrote:
>
> The verify_state helper function in ahci-test.c incorrectly
> assumed that all 32 potential AHCI ports were implemented. During post-
> migration checks, it would loop through all 32 ports, attempting to
> read registers for non-existent ones.
> This resulted in an out-of-bounds access on the main HBA BAR. This
> latent bug was exposed by the recent introduction of strict bounds
> checking in the libqos PCI accessors, which now correctly triggers a
> fatal assertion.
> Fix this by modifying the loop in verify_state to first read the
> AHCI_PI (Ports Implemented) register and then only check the state
> for ports that the device reports as present.
>
> Signed-off-by: Navid Emamdoost <navidem@google.com>
> ---
>  tests/qtest/ahci-test.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
> index e8aabfc13f..06c5bd08d8 100644
> --- a/tests/qtest/ahci-test.c
> +++ b/tests/qtest/ahci-test.c
> @@ -81,6 +81,7 @@ static void string_bswap16(uint16_t *s, size_t bytes)
>  static void verify_state(AHCIQState *ahci, uint64_t hba_old)
>  {
>      int i, j;
> +    uint32_t ports_impl;
>      uint32_t ahci_fingerprint;
>      uint64_t hba_base;
>      AHCICommandHeader cmd;
> @@ -99,7 +100,14 @@ static void verify_state(AHCIQState *ahci, uint64_t hba_old)
>      g_assert_cmphex(ahci_rreg(ahci, AHCI_CAP), ==, ahci->cap);
>      g_assert_cmphex(ahci_rreg(ahci, AHCI_CAP2), ==, ahci->cap2);
>
> +    ports_impl = ahci_rreg(ahci, AHCI_PI);
> +
>      for (i = 0; i < 32; i++) {
> +
> +        if (!(ports_impl & (1 << i))) {

We should use "1U << i" here, because coverity will probably
complain about shifting into the sign bit of a signed integer
otherwise.

> +            continue; /* Skip unimplemented ports */
> +        }
> +
>          g_assert_cmphex(ahci_px_rreg(ahci, i, AHCI_PX_FB), ==,
>                          ahci->port[i].fb);
>          g_assert_cmphex(ahci_px_rreg(ahci, i, AHCI_PX_CLB), ==,

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

