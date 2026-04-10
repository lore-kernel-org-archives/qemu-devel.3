Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E61BF459E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 14:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBD4y-0007Bv-S3; Fri, 10 Apr 2026 10:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBD4w-0007BZ-Sm
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 10:43:26 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBD4t-0004IH-8Q
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 10:43:26 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6501725d888so1724135d50.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 07:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775832201; cv=none;
 d=google.com; s=arc-20240605;
 b=d3oCdyqopL5G/DtNkoXYV73lJnnTr2iIHzNyG9d1k9hDaMEVSx0AAOLuQ05WfAMlaD
 +xWAAij4kBfV6b3MK1iyKTmXjrHlL0l3aL5hCPPFtVfCT7cEGKr9Z1TM246l1Z9yNhah
 Lke3jM3jJvxz7cY1ksziyS3XwRnwpU8g+r99wHDjwCAbXKNUS6XyITiC/yORaayl/GVy
 8S45BWHOXvqGvcfl0Bo/2MYeQsIMIOXZIpRIMweP/RTrnN+uvvO3nDGh4hWDyQnFlGe6
 j2oUo7Aj3UDbjmw7jk2FyrVyblv3mO/lZKa/2sXy8evVEgUTvxPA+IMUpwFP3w9wpAAM
 STCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1lYn9/D8W00oC8+/a14SI6vwo6i/F1q7KTJzua+AgWo=;
 fh=8VtuVIP4k2rVtZrQKgJ7K9nQTLZtP6dfYqF1tIx3uI0=;
 b=MFFzgz4fv6GqEafLI55KxA7dzVl42Kw0qdUzxKdd1Tp1p5OAGdlaZnjdjZY7Op309s
 LsV0p/zIaZ9XXb6k1pzj94dC+jTrg2g8mi3zsvM5b4l95x9gv7E0eSxo/TnOTbWBtqee
 Bv2KbwRVA/ztif/i22i2Nw3ZYqq+S7lSPJv/v5PTx7sSLKlvMozeNn8bm8udRhJkDP1Y
 7L2icV1yKBQByYOt9oJ6KLFw4EYlYRS3FqUkB1qGsUSNWX1XU8kS2FMwm5pW6zrhbDob
 NZxRUVx8xZRfxgt3AjYPx86SjOe4sFVGY7GzjrnkyQWQTSp8DzC83YPhc9Um/6yoxOym
 Breg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775832201; x=1776437001; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1lYn9/D8W00oC8+/a14SI6vwo6i/F1q7KTJzua+AgWo=;
 b=MfWjKPiQnxRtOftWf9mDEnsWdhfHHhwlwszcsS7sztVjAh2vboualqQJXmUW5/DWGP
 UGTWsdh/tovC5LmbGATQlLJyhDqBLOKCac1F46OGJ73N0yqc/9hUCRmUPmvljrFrE0g+
 P1QWDgMUZJ5xAKQN6/cQTC1LqSCg+jE3aPFTwRIZOdDPkLQGEashJEES/q37OwoR+d+0
 3P3LLaWuik3JlJZurWFklnTC4EQNuKQBGGXsjopkSwV8clBMXB3xPQ+6CLBxASh++BsK
 4G8kI4LXSQRIZ3grqFRumcHEhid/XG6QNjt/6yC/70yOm9QJxoqk+C7TQA7GmBTDevcG
 jw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775832201; x=1776437001;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1lYn9/D8W00oC8+/a14SI6vwo6i/F1q7KTJzua+AgWo=;
 b=VM+DV8pJmRBTKPQ4L0l/JoshSD4sVHOvQibTyypg+UPfm6gx6s2uHGOQVwGwWINFIt
 1X+jWI2dZ4vvruxTt14G5+dldlQ/h+4NeykQWrhPhxLH2jKGvVtOaHFz51DZnwIJhw9b
 R9ofmGFgNb5Qurlpdyz5k003UidP0pxRFmhjA8lBar5xgPwLvSlCnV5vTnZyoA6RHJcy
 hU1ngbAT5BvA9rdFdkHnwLaSZwH8pArsb9mmKiQyxwSSk+LT8xSjgF30mMtO6Vwfc6of
 reZOxYMJ6ZMFHgBn2I9embAzjAmkL55InqJHmL+fxzUKYkbfEI7WxM50S88cHy4hMmeF
 rgJQ==
X-Gm-Message-State: AOJu0YzRfxFuktuBmGQmVRX+/mjfbqb+2mACA3bRLdT7mVlKdtmvn9Tb
 jdo4uMCrQhkFGLofeBLtvepyB4NZ7d7JKvbKjV7QxfPb2/6fLXNmm9aPjMKQyquGbpY5WSlT+z1
 mWUQ8P0Q1YUeZ5UjUDpl51ZMY31I1GREcurvzD6sM9w==
X-Gm-Gg: AeBDiev9qzaV4MkjVIuX7KyKa/axWTxMmxTT/XMPPM8jy+EvdKmoYKZvH3FMtb7S67p
 V6qu/BZ9/2N1iABpXKTeUr9aYmTdMEFEGvuWmRnO1jpWAleVfcJ/dGxhptuwM6P/2NaFUXjB6ik
 DcIFdO8PlUXDFKyKm33YuMDJ2qBz2hYEWqn7jQt7fGFtVi2BNDsv6WH3CcIbzblWtmNBz+lVDRj
 at3xtp9Wu4O1KZbhr6mQ0eHuUeaNJo4H1GE7kgQv+jY0HAiY4c0if2AGd4+IT7dB9YUWTGRMWiE
 o4QGjQWhpRoSSErBk4lYunwy5lmPmABsC61Q1XqHO3tsJqqOqMX7tJAVr65PJ5PxOUw=
X-Received: by 2002:a53:c5c5:0:b0:64e:e084:fa84 with SMTP id
 956f58d0204a3-65198c02445mr2615577d50.68.1775832201078; Fri, 10 Apr 2026
 07:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260410142932.33089-1-philmd@linaro.org>
In-Reply-To: <20260410142932.33089-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Apr 2026 15:43:09 +0100
X-Gm-Features: AQROBzAiPlsnAS_uYhvsT6iLTPgXy9obanNPGOWoWt4jCoytRqKoX7q7ZmkiVXY
Message-ID: <CAFEAcA_=DjrPvYXyPJ-mBRtsSaKhdC6NYABcvz9R271V2cvznw@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 v4] target/arm: Use vaddr type in
 handle_psci_call()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Fri, 10 Apr 2026 at 15:29, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Use 'vaddr' type for @entry, which is the start %pc for the
> on-lining vCPU. This allows to remove an unnecessary target_ulong
> in hvf_handle_psci_call().
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/hvf/hvf.c  | 2 +-
>  target/arm/tcg/psci.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 5fc8f6bbbd9..124644918ef 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1418,7 +1418,7 @@ static bool hvf_handle_psci_call(CPUState *cpu, int=
 *excp_ret)
>      bool target_aarch64 =3D true;
>      CPUState *target_cpu_state;
>      ARMCPU *target_cpu;
> -    target_ulong entry;
> +    vaddr entry;
>      int target_el =3D 1;
>      int32_t ret =3D 0;
>
> diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
> index 56754bde951..5df17bd059d 100644
> --- a/target/arm/tcg/psci.c
> +++ b/target/arm/tcg/psci.c
> @@ -68,7 +68,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
>      CPUARMState *env =3D &cpu->env;
>      uint64_t param[4];
>      uint64_t context_id, mpidr;
> -    uint64_t entry;
> +    vaddr entry;
>      int32_t ret =3D 0;
>      int i;

So we take our argument which is a uint64_t in param[], and we
put it into a vaddr entry, and then the only thing we do with that
is pass it to arm_set_cpu_on() which takes a uint64_t... I'm not
sure what the vaddr type is getting us here.

Should we just do in hvf.c the same thing we did already for
tcg/psci.c in 3580aa03547f92, and make 'entry' a uint64_t ?

-- PMM

