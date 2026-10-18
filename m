Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9E6CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 10:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIODY-0004kx-Oa; Sun, 18 Oct 2026 06:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIODL-0004Wg-2u
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:34:03 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIODJ-0000t1-MT
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:34:02 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8726acc5eadso8528777b3.0
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 03:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792319640; cv=none;
 d=google.com; s=arc-20260327;
 b=eK2u0L4mkSqtTttMcSwVBCOjLlVBX8swugbYfBDSH4lH+LdNzH8cN+iACLXZHUbpMJ
 nB1o9ODmz6a+eulgOHJZsqbAJBGRae4clveaNWomRyp/ZvsvkcQZtW1qZZPgdGj48ndN
 BtNVhV8JusZJn0SYIC5l/11/Xt36IsjpDTScBuO58nq6FrTbcX5wgLPUvwJnaanT0NXM
 pNKnrECpC7scc6cTFDkGUiTjOuFT/SSn106H2hpIyno/Qx/Thz10W8e6TjA48bwOBFah
 VErwpXuROxpUONWK7HQXENHuhtwQVIY3kCJAvwP9SNPY/rFq63J9gJSOqm3eAD59HPye
 HOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5FKN4+VuBNEcl17qj6PlVEN3fAx5SUv8PqL1xJXKu+0=;
 fh=dHN1FZJpb1BHRtRBDcpEyrvNB3hUuCjyQs5YK6bCL1Q=;
 b=k9U/Bz/aNAFQCK0jRf4QYHIn8c/F1ARL3QNJQkHf02ZBpTTl6jRI+SE5p9BWlZN+eF
 YmVW1zi2Z8vJFPTjmDu2NHdebqayi+CrTeELq+N+dQ83pH0VhQZ3zIL+3NHNE6wNLoNs
 aKf9NfJ6oFmiiJEJEnYwzBJDHmcQDc4Cvuxil9uO9ibzmuotwx9sP+M02GV0jstIG++B
 dCnxkXWp6Ipuzx6E9fmnUINi1LG/e2yvG3WNpugcoKHdkR/qb2LSzG4Z1QglpqeWJVuV
 h/rax5KoAA2D8RCc73J6ihrlliMSdnDgjcBoV8Ax1CFtuO25A3C0GQuEWOfNRDDMBeo1
 GTpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792319640; x=1792924440; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5FKN4+VuBNEcl17qj6PlVEN3fAx5SUv8PqL1xJXKu+0=;
 b=qVQTm3KE4mb+NwcLnmfohyMfIalSkZFaumn2HzW7WBKdVQMLXXshRKD6jWa3P/VSUY
 I56zsm+9zsUQXE+YxhWRM6HoWLiLrwt319XasYqPpJIO4HYH223sGErrxghkuudJZFfr
 1D1xVqVJgsYUmfwVoCc34noo3HlQNCDSvyrZst83WzTFApyYs2VphfzOqUtjY9s8nz4b
 lypeWCFR4lzqUumZV3M3TqntsJ/RFm+A6hSWWZVLSpGsXoQN2TKhoKcLunIcxxM04ThX
 ZgA9ZHd+9YWr2f2LDd3ocnmhc6T6epL5JWeMySsXd4bPeZKdH+yxYkG5iAfK9Zf3E9K5
 TVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792319640; x=1792924440;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5FKN4+VuBNEcl17qj6PlVEN3fAx5SUv8PqL1xJXKu+0=;
 b=ZF7UTPt4ak86FF9zVellU0/UyBwfVVbNH9eCa1OPBPpV+2XdU6qOxdkg0WaijtJ5oY
 Ab7NVto+61Q6Dlfxal6M0UoinUeeeuO4+aMCOPQqsgtea2jCuh73DTL1t/fq6taodgAA
 QwofKSDtweZX4ZPWEjQuPbBVbs6C9kFEtN5vujARKaWBVH7yb3ypB1TJhcPUYz57qSoz
 RndhYaCO4CpscigRK6PZqLohtfQZhIaOEBeEKM9x8mbXTVmEXYVfgP27e3nAnwPBZNF6
 FV9nN5FiJACNbpjD7nqK/WSboldFT57kOdUSwEyPdwmAlWPgsytnH0z8JUA6IufrzUMb
 97aA==
X-Gm-Message-State: AFq9FYJFLI8WM81vtOg/xkIwEh1w0ZLgKrrJoxhSkz3osPZJ1z3AU2bl
 raXMKf2S1DJONf4weWGjXGCBxrFn7AGQvJdb5JZJ0WgVGvTqeHJCQc5zBpJR1mtHd2LHOPrPIjT
 vI6T9AriXySas5TQEX2RK9Pd8B5BhOJ2mle3Je5u5FimEi1I6KQzliZI=
X-Gm-Gg: AYBFou0r7XsGadc9Sb6gjkq2GPwpcNPzjpgkgbsHLSVgfd6m/UPgdNjReXXve7wtOzE
 5uWkO+QV1AlCpuQDLulzQW3xrf0zrQ3m6Qw/TJcqa+gxlq8AdOtKj4U0z7ce8G3ud+knWAb3ozf
 0Je9lmakutdI4SfoUM09KkEznblrneKGFuTXH4+c3bu036bBYmo2VgksT3bzCiE4SQGEupbEWdo
 Y/AhvAvGI1mxN40l0zGUZBz66NlamYG6Q+eXkCF1A5vUzt9/LL+AmbvjR0UTS4PdUsArPSnRb64
 aGnQZuBOfkZr4iCTz6a1m3ldHs07jyxtMmAmmAriOMsmOeeo4F6e7gGupkqswbU/jgEsUSwEDco
 XJDDF5/R03iecadNCe4rULGXYqWF+/0stufW9DVYwKJ5/wlsADNg=
X-Received: by 2002:a05:690c:e3ce:b0:8ae:b617:7138 with SMTP id
 00721157ae682-8b0f21f88ecmr19203117b3.49.1792319640068; Sun, 18 Oct 2026
 03:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260918101158.42101-1-corvin.koehne@gmail.com>
 <20260918101158.42101-3-corvin.koehne@gmail.com>
In-Reply-To: <20260918101158.42101-3-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 18 Oct 2026 11:33:48 +0100
X-Gm-Features: AclHuK9hJ_ao3VOyGrHDj2MMBcqi02oRYLLhXxD_5XZH5SzuAjWDBz6W0ccvnqA
Message-ID: <CAFEAcA-V0YHsjOfc5sq7AgPVB7ve5+gqY=imZ815yOqKQcOT_g@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] hw/arm/xilinx_zynq: Add flash type as machine
 class property
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, Corvin Koehne <C.Koehne@beckhoff.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Fri, 18 Sept 2026 at 11:12, Corvin K=C3=B6hne <corvin.koehne@gmail.com> =
wrote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> Introduce ZynqMachineClass with qspi_flash_type field to allow
> different Zynq-based machines to specify their flash device
> type. The base Zynq machine defaults to n25q128.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>

The commit message subject needs updating, because this isn't
a machine class property. Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

