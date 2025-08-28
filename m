Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF1AC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFh-0001iX-2W; Thu, 28 Aug 2025 13:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdZX-0003Fz-05
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:25:53 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdZU-0007E1-DS
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:25:50 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-31597d3b410so481348fac.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391145; x=1756995945; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V/LMAw9zqhgwCBkKtocn+JbHSbe3n0q/pOrLQxKbAJ8=;
 b=dOOAVJWsXRfx6XLWhzE2kjDdhBrBZtaR5P5ttXkhEsEFWEY4qaZcNwTRJoXo6jTckM
 CgF4Llof9K5BZ0g0+rgwxrMvYs8QM+USpOczyfHMgUNnGKF4PVSwWGAsC6oI9rG8dCbZ
 +DKbnXpTI2PIR/pPwYixQWIZ75cQjD8yBBGpRYYAvUVAbm3DkeuXGpFtGuI1iKmUh3gb
 8b5aL/9bNTgbZ58//kXGJqgJInWesaaXTtgWzeDRYmC/mEv2gfwT6XRSICPvWVqy9Yvf
 wGjvVyqt8zFQVIMMq/kd+hcSAYhxFmwEHoASYWSugdowglwRg6pUeiK9ZDB30Tfsbpzh
 N76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391145; x=1756995945;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V/LMAw9zqhgwCBkKtocn+JbHSbe3n0q/pOrLQxKbAJ8=;
 b=O9DzDCfN64gYHZi+2aiDmLz8smvQVHrx6bMlk6YgMfLx8d3YL/HRZkLdQeWBswc2x9
 +SPckR9Azp/l/cgZm/JGVEjLVxmbB25+oHwkAChSDjZjoQiMml9BReDo+f0lM+nuI2wk
 kGsYZXN25YnKV3IrPxV73eXIFUraZQuZQlNkx15dQKV75DrOymWawXCVYbqjM+B6I+OM
 1RjBjNmQQpO9gp10C9GwX4pKAcG/ODFmSsPf3rSVA2vYTUOMhn43M8x5qTWu4kd90dD+
 eE2eQVtp4hpEfjxcil5wJ6IlChHjICZHcOT1jKK0oBSovge77OEjXVLJD0Z2aKy4YKoC
 dBQg==
X-Gm-Message-State: AOJu0YxME+2Nzboenk+U/tpiVj4h4zSVTDuq6vaMLnmdXEpzv2sQUKUg
 vPKXP+aezt8H9Lk9Z1qHa5sLrDvYDfOaKxBveLnFRePbqKwaKgT119rZPe9kIBTIK82obYnEP6X
 Ci2kjVdQM7vKLYJHrrXycgraqqcIXrR/60m/bVPSRPFhkiDRnEdok
X-Gm-Gg: ASbGncujP+9hjCClnal4MZMeI93rplTzg97Es8yYaQ8W286oZidSoAYTaRr55Bbat1q
 dHqXEeN7twn9JHknCt8JDdt8iIUBqF4jsak/ljCQzYZEJ2JzxSPnH+QjdDWeNfGzZkyO9IJAGb7
 oS1TUiYNcMzJsBTbcLZaHvEaPskqKtA+I+HNJhaOAS+PM9GBdX50SISWfCABGfcaVTkzTpU5Ff4
 zswQD8HoSgR0hgo4HY=
X-Google-Smtp-Source: AGHT+IF2cWhWU9JtdcIvtQITXtKKMtUAyDLi4+IvD48fUp6GdI7PtKoOu0ordRLlcMo8Sb08OfGQ+d1cHAN45WeB0cE=
X-Received: by 2002:a05:690c:6f8e:b0:721:5b31:54cc with SMTP id
 00721157ae682-7215b316b46mr41331637b3.31.1756390839294; Thu, 28 Aug 2025
 07:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-8-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:20:27 +0100
X-Gm-Features: Ac12FXwltZbc0MqciaNpuifldSpdg_UfQkKZcmEhBIVxH8IvuUWwsJujKOtj3aA
Message-ID: <CAFEAcA89uVuH2KMecV1ri-6km5imBFZeVtNqo4fc31ew0+6H+g@mail.gmail.com>
Subject: Re: [PATCH v3 07/87] linux-user/mips: Convert target_elf_gregset_t to
 a struct
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=peter.maydell@linaro.org; helo=mail-oa1-x32.google.com
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> While we're at it, merge the store of TARGET_EF_R0 into the
> loop over all R0 registers.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

