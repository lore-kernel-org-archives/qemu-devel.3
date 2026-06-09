Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6C1CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrob-0003iP-2W; Tue, 09 Jun 2026 04:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWroZ-0003hu-S7
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:28:03 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWroY-0004Vp-CB
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:28:03 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-66062a414fcso5784078d50.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 01:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780993681; cv=none;
 d=google.com; s=arc-20240605;
 b=iRM0bhgoRgq+c2lquwGoYRgPg1PBmAYKx0kePdIHGl0OeHrm9z2zxXAwMD2lDh9ou7
 /Gj69Dpy5uqlaUnJqN0oIsTcU3fPSlZoHcHc8acm7h0RAC51Sbjsiew421tBaKvwSZHl
 oLnAaQOtZu2o/U8Bjn6BPLW7tXuNVZa2brIZyDLzHhmQ2eRGmJD3/+WAk4hTjK+pIlPC
 P7+ZkZEaZ7KrbIu6iMSqX8yf6zP0PZYVnPDrsR0qgecnIJYE9OTe03q7LwBgyXRjBxwX
 2QidTAG2kZbMm10YW05Q5Axv7abQ4UM5nODqGC2e43Xbe/+8Fw511DjIcuVmdSYtOPN5
 EVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T9XfZC7YNRxw5/2CWn6V3RlvpPF5RK9B32Q0ybfyge0=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=cLUfqbFCfzn2xgxav9RHAayA0w3ixV4ST2VPR6NPqqh6fuIiPBIZvEtY9m1PrDg5y+
 ORv/5MN9qJYmn7fEHiPGaOahTdBKdK7k5ccbiGZ9zAUDAjPoBfVL2wwkdJR03+jsxHfN
 3CtJGqFQzaQvCEuoeAY6yqkFAX9n4l3xLOJySlejgMH29pUEGiR63h9KF6JRvtk0HI06
 USKlC1ioPE/WVe1NUG3EvROKJL7hicIk9gEoOlhQefIkCTj2vez1POwZuMNAOVAyMc2y
 jeE9LllRrhek3Fx0mVJb86AlK2U28+WqDnl0E9I5dOI+H8+gvfhEGKKErAR38jB9yDZq
 klFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780993681; x=1781598481; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T9XfZC7YNRxw5/2CWn6V3RlvpPF5RK9B32Q0ybfyge0=;
 b=b3PKfmL0b8gF0lv1SDs7o2PgSHYKMHyBPha/oyqOsEVsby85QvmgADPsF+UF2Y+wtQ
 GJOt8J7wunaIEImTnIOagNKpH9NCVK0gax+S1i2mmGnOO5qA/DaDcdCISgWw3UFTqsnF
 MUR1vrjyVsEKAI04LJnK1WVWHbyo6Kv6dDJifzwuKDD8r60FA1Gk811UYaDnRn0VJRi8
 X2/7N9A5/KwmeSmwtrl4ZLimiZpPxlo0yaB0haYTyuzbBd7MURsT2+/YDaUhfd1wDfPE
 zb1XqKp7Z2xZA7XLdt/LrcYxZ7EU0gCDHJWZlRBlsEuTZauHbBus2+qXnw5e0t3qklLc
 KUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780993681; x=1781598481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9XfZC7YNRxw5/2CWn6V3RlvpPF5RK9B32Q0ybfyge0=;
 b=Wp7ceenQgZWjScxhHwt4Bs6/rjRu8iMm1dSE1p07d79IQVwvtvWhGVBNFjqt78fjkp
 tpAMa/mHUX2zG4lZIfmuWG50nIl301p+rzObJeyR3Ucnf2Oicxy0u+JoA6URU+IPKL4N
 rsEd8KFqIIbcAGwMXJtbArxEBqmhR/qn8sQWYpO9ubgt4iVARL89x9i2SZFdyJnhtmhw
 QKDB2dxv19uYM7ArDBxGro+Iev3I70YWEIs09+zbgSCbLkGXNMWXWFEpisNHHEq0m0ri
 ZJxgSP9uTlQfn+ZQEqtXW5jBX/WZsc3OhfN8Jkfqxk9XxwQxFbhX4pdUKZdvQTr2OmIQ
 znXQ==
X-Gm-Message-State: AOJu0YxTJ4pa/BqT4oGPkN/YnLgj/Flup7ZojiWsNtMRuoDFzzHFweF0
 YI+vTu5Zp7pcla/uc+Rbwo2SiH/8i2qGnk7LH0jh7MYT6P0Ir2o/gK0zeWDEP3VkdJxftNq5Kq6
 Bz1weKXm/1j4t3kzbgNDMiZZvKbposhmuQqqX42rydA==
X-Gm-Gg: Acq92OHDTH5bgZgh8fwOwZ5ji4/Wf7I1mqYCwIa4wdPzdgdaH0e7BFuASBUnGY7Cdjq
 4se2aZpILfSmIg1RPiMwiTZMGbTNtrfx5W8LufNE1HtNvhpl4oUmk0uGQ5w+dNCAPXmUliPXKeg
 O+WTZv8UX4aYkzfBDbIiXzs3zSFu693CUgb7trGQib42qCruidqAip4Rm5nsHX9SHHl2NP1AxBM
 VFHxLg30Z5YA/b+PlKGbTcF3tF1gaLFLiQIuDjsUVZAxZquMtsyfbrIfZ/rvEFZxwJJHPFq7Eja
 pUa5zb2O1g83KTERmYRR31QJFwzMx+ehS3m1NuAevJfhHvLghj2IUGvj+6Ev//gKtspgBMzipH6
 ikA==
X-Received: by 2002:a53:c942:0:b0:660:e9fe:48a9 with SMTP id
 956f58d0204a3-66106e63761mr14024161d50.23.1780993681131; Tue, 09 Jun 2026
 01:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260608190155.637067-1-richard.henderson@linaro.org>
 <20260608190155.637067-3-richard.henderson@linaro.org>
In-Reply-To: <20260608190155.637067-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 09:27:49 +0100
X-Gm-Features: AVVi8CfxizJKUA-FGTQG7uKRSX1HgbDZiYyApGGikMVL-k8dSXBXgW4meRN82N8
Message-ID: <CAFEAcA8wiqNxhhdZSmOPMT1UGDs9kgPBggss6S5nMXW2FCnRrQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fpu: Handle all rounding modes in
 partsN_round_to_int_normal
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Mon, 8 Jun 2026 at 20:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Missed float_round_nearest_even_max and float_round_to_odd_inf
> in both switch statements.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

