Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B121091903
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 17:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3HZZ-0003gh-3l; Thu, 19 Mar 2026 13:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3HZX-0003gQ-Ij
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 13:54:15 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3HZW-0005bT-01
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 13:54:15 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64ca9ec3ee7so1684862d50.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 10:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773942852; cv=none;
 d=google.com; s=arc-20240605;
 b=lV7WUFMVsD46sjAF8iAJx4L1TjY6dLK220mfVvOvnnwghIHbfxMTRYSs8GN1Dq4/Vo
 buIxla1nK2HLKAG+oqJZgGSM61Hm6YDDGEODQJ21U36VFHxAL/VGRlxnUc0WqXlS9XY5
 FrelTkHvUZU4JGGDeiT0ZKvr7gq7J3sCSPhgURoPGR0EfE6Bf/+tR1t83Q9QiDMGvfYJ
 U5/8Ii+1feOHPaAE5Gg/LhYLyDmtUSuBYQa7ZInWyC9mT4/3/caRFufIHYfu6TiFsN80
 Dm8wqOwe6nBw6PWNAh96F89WeEbg75uGrm73MxntwhXjk+aUTPYD1Fvum224P3VIPELL
 p4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/VTI7yL0rhg79+0xa3eAZgg+iqcvIY+hNxC4NcSovOM=;
 fh=V+cJCrcmHfk1hjMGitR5yugawEi3UN82KrpCYh9oF6o=;
 b=CwECcr0m7JeV4fhtepbDH8m8AJK41Kl67ytLu5e+GfvxR94Yse/8Bq6Lkrd+0EcY8a
 nBzI3cdDPtpW/05RYJfTMgnxV0DFFRugnDrwR9U+gbdlvVhwRcjqP8kHEBSsY9bBKus3
 jBp3y9WNdNCVA1KJ++AalHaU0CUdpteO0SJkLsJKnbIulfx5fAff+m+UEV4YS4G12T1u
 qzhW2vYmp7nHk473jA/mhX1Q7rsM1HGG6MLsGKXMKQXs4mn6xiitifoiQZjdj/K6T6fP
 OMUlozYxAw+pcoCTJNC4WEhoV19AleXsGuQj+0UMdOp1rHjKZs9Rst6Y+cXJCN+C6WIH
 g5HA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773942852; x=1774547652; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/VTI7yL0rhg79+0xa3eAZgg+iqcvIY+hNxC4NcSovOM=;
 b=bR2Xz+y2EcNQzBXKV3FB9zrAtloHix+eKDfSJcgQc5GpusYJBIbs2fgSyfCBMrbWKR
 ICVPeMSzvjm0mWVfOMFZcx9g9TdD6v4HUJ3yp2avaQpuBuLF6vnkNjY3zrQsjx3/KNTK
 lWY66i078uUZO4hDV8vsK80cc1r/1IGZebOasQ0S037IIdvAQ3E5Cc1yPtpl1nBRYITn
 kZiO0g6ge8WpE8aZZie+WqAKZQuGkAeMM9cbnRgqOWbLaZq5C0P/dYb+XDHdca2JaxMn
 oUaJXOwd6+Nz5+KcQP/RaSX4Ded4gigt/5eLLthWI11QsZNk9WibYE6Bst8/OJ8cn+Ug
 RcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773942852; x=1774547652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/VTI7yL0rhg79+0xa3eAZgg+iqcvIY+hNxC4NcSovOM=;
 b=X1HB91OJF/R5/VQf5pb2FNGP/p3Tumn7AykRwDDqVNAgyxptjcFJ//eSExN7NptF/Q
 Xip6K0RVJZ/QrQx395dT/yjW7ZzMdOoaVn2WwE94clrtRblda2W4X8dOH82gPoA+xBie
 OQlz9o0qNqA7yqJQP/JiZhitBz3KUaFodSsjQaQta9HFmNhVe0Nep1mgxefCKoP82muz
 zCSoBQgNbE8p9s+USZw5OEyQBkasUeykrp7FcMtrzTqTfbgtN79WcKtUhfktIn3EEECK
 kO+61LiTLHLFcQYykycGEPsUiVYeTF+n33hstT/Z8MuibfRmvSsYMsCLkRdC1OFMF+zJ
 395Q==
X-Gm-Message-State: AOJu0Ywoaxgo+7XYV19UZqap9TKDmoHL0vTBVTwNB/leCejnHlBSyYwf
 WWO/c50jt/Eyywo8Umyc7eaCvilUT/JkzjfcTenf1bKy2HXif+i6jle7SUGT9opN9usbbGRfk4T
 1Y/tYb3UX3/sPe8NQJTCrbW8c3QWgS6FhmpcP0RRPGg==
X-Gm-Gg: ATEYQzwkqCMx8kNtOYcAlMFWizbbMoR2BaWsGB5PJOX/dqEGIZ6EgXmF4TXzSxgIQyB
 C+xoaXRfHgAMwCI/0CTWDJ3AaCU6O2k0w/5GkAMFTVKOsIelPGQtlRYeHpXNuYGccfVQjXNlzA2
 qL1Ab6WJ9fNWwTfeoVqJqVTvvlaWEuSGpsSays8TjRgw2ACwdOUIRJdmghjQ8qrq66XdZ/BXQBk
 noPWr/6hlMpZnRmzSjCItgWlOhb/ws81iGYAYMZ9fCa3I3P73Kj7kn771V06LGDzV4N5c3KiuXD
 LSyFPlMGbmpytAzoc1bvYRqHWsZZhqdLZuTUSIrZa7oa06uTKWG6n6l+8AKdnOjA0sE=
X-Received: by 2002:a05:690e:708:b0:64d:6098:3bdd with SMTP id
 956f58d0204a3-64eaa77f36emr316681d50.39.1773942852463; Thu, 19 Mar 2026
 10:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260318141415.8538-1-vikingtc4@gmail.com>
 <20260318141415.8538-2-vikingtc4@gmail.com>
In-Reply-To: <20260318141415.8538-2-vikingtc4@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2026 17:54:01 +0000
X-Gm-Features: AaiRm52ixL8GBMnT75g8WC8Q6fyMqtgD3xzp_AGrgTb0Ga-X7LERf-cPokcr3_c
Message-ID: <CAFEAcA_HDDqJ0i7pyztER+i4Jiis4C5VrSWopR6mPYwG3G_VKA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] hw/core/loader: fix error handling for
 load_image_targphys callers
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Wed, 18 Mar 2026 at 14:15, Trieu Huynh <vikingtc4@gmail.com> wrote:
>
> Use QEMU's Error API to handle load_image_targphys() failures
> consistently across callers.
>
> - Use &error_fatal for callers that previously passed NULL, ensuring
> the process exits early on failure instead of continuing in an invalid
> state.
> - No functional changes.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>  hw/alpha/dp264.c     |  2 +-
>  hw/hppa/machine.c    |  2 +-
>  hw/m68k/next-cube.c  | 11 +++++++++--
>  hw/m68k/q800.c       |  2 +-
>  hw/m68k/virt.c       |  2 +-
>  hw/microblaze/boot.c |  3 ++-
>  6 files changed, 15 insertions(+), 7 deletions(-)



> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index 26177c7b86..4bfe5bcf56 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -1326,9 +1326,16 @@ static void next_cube_init(MachineState *machine)
>      memory_region_init_alias(&m->rom2, NULL, "next.rom2", &m->rom, 0x0,
>                               0x20000);
>      memory_region_add_subregion(sysmem, 0x0, &m->rom2);
> -    if (load_image_targphys(bios_name, 0x01000000, 0x20000, NULL) < 8) {
> +    Error *local_err = NULL;
> +    if (load_image_targphys(bios_name, 0x01000000, 0x20000, &local_err) < 8) {
>          if (!qtest_enabled()) {
> -            error_report("Failed to load firmware '%s'.", bios_name);
> +            if (local_err) {
> +                error_report_err(local_err);
> +            } else {
> +                error_report("Firmware image '%s' is too short.", bios_name);
> +            }
> +        } else {
> +            error_free(local_err);
>          }
>      } else {
>          uint8_t *ptr;

This changes the error message with no firmware from:
qemu-system-m68k: Failed to load firmware 'Rev_2.5_v66.bin'.

to:
qemu-system-m68k: Could not open 'Rev_2.5_v66.bin': No such file or directory

We lose the mention that this is the firmware blob,
but gain the more specific error message. That's OK,
I guess.

Both before and afterwards, once we've printed the message
we go ahead and run the machine, which immediately takes a
double mmu fault and aborts. No change with this patch,
so no problem.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

