Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41342C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3VLp-0000Zf-QB; Mon, 07 Sep 2026 05:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3VLo-0000ZH-6n
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 05:09:16 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3VLm-0008M0-GB
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 05:09:15 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8726acc5eadso20778077b3.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 02:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788772153; cv=none;
 d=google.com; s=arc-20260327;
 b=FVqrpY+Ybn8yTPuXIEOj0wr5mS8vit0pjytN3i2xjRKx/W2naBYoEM5lK5I+QQ3WeX
 GvyvCAa6WM/rj84S5w/2CfdFVqgLV6TTN2OeiMwvxTymMINPCW3JKitSWrIBuuuuBhyT
 pevlztWnb2MUXlJ2eVD7CC2kEFRESeXI0OjRZdFDDw7mhxlUWIpmuFDvr10PjRbKQWOY
 iyAnYw0yk5V5f4hZXfe3yYRG8zyByptHQgyNBL/WnD/3Ce1Uu+zbbn8lfFsFZDhccoCZ
 b7l7E6kkK5a5UlfR+ICO79kRltR3m78b3ZroMU8BtcYR5oKGn0dr3TQNjhgC4mcRKm3j
 GuzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AgLMzHNdQvTp6QSSmqNNnxU6TShe63VrzqfdxLISUy4=;
 fh=fVPfpHMeJX2gxPKYTBQCzQO60hB2p26ro2vRuUEPsJ4=;
 b=SSPvPo1YzOgMULDOvmR0sPspKVR2cSRbh2QTWn7xnUqh7IJQDXVs7l5BHr2rokXuD4
 Mhioeq/ZYWT7iM6omdZrkeFuvr3rcjkKbkjiXlxSBy47hi9dXW5bAjbBFb27c0oMclEz
 LP0rXiSGxmkZWD1UXcKI/d4JYULiH1zxQBAc0FVi1E74he7wyfdzxalDFIAmTX0HcLnE
 j04qUya7Pr3INi5zkAcF+EWC2AdS3Pp9jJUKUPZ5MHINzvHVARMN6I5m8/giqOZqAwCh
 bBaJ6aERMnOsyPSvwtDh6MTr9Dsz35gllkQQq6l9PB843Fk6JYJ7fg4mag+YJuFYMDvn
 rdiA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788772153; x=1789376953; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AgLMzHNdQvTp6QSSmqNNnxU6TShe63VrzqfdxLISUy4=;
 b=srh+EgzCt+gOBqEFujnVKuRjsfIlcjwjX/DqDhkweOeGHSqGMGxAX3a5RWOHIajFDl
 dQ4giPBjr+tE+KxDlZcGlvOXTe0M8J0gxbpWiBedbqMN09BvEU0cT8pE74ppdCIjI4R7
 9qh5N8yBZbKYIus/baagLnQTPnlMTVJd+KRsf9ebf9aokdyPYBp1Lu8i78WMf+wT2gIN
 HZK9qkFieO06EaYDPBlErmzlEthxTtSX3eXXKICKDTbtdj2HUBxkQDIPqquUa08LgegC
 u6TeSO+NdREhYISJFqssFJ6YzwP+n/r5XloRBQQRyuVpd356eRCA45nNYpu1Jbg8LSIX
 ciQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788772153; x=1789376953;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AgLMzHNdQvTp6QSSmqNNnxU6TShe63VrzqfdxLISUy4=;
 b=eIkuSjgoeMAS247P/bf4OSMozxzGHaWL9/FZw0bMRgswyTpx9VN50yabtgfBGKVaVL
 eKf137NtToCCYRnirTZvlRY+CTRgPhCH0YLMyfepczHvJfi6tENpode7jimucU+y5Rhg
 SJJmgmY161xZJFj7zrD05b70qXTGnww0bAEl+icoReIVgasMU0iy5IDHt4N2+kdqEvOR
 LaMJ6qEpalw7jbs8wLbm/lEvwnvAS/dvMqOzgtQV2je3GR3eeb2Q1FPbNlgY9/T/jEZy
 as93ZmW4oiCZ+BN/KimnDp/8JP3B5K6wDev07UgVGZEkEFf1f1MQMcdJvtfhTO7kWKNb
 toIg==
X-Gm-Message-State: AFuF++mi+o8R8ATQSsESb43gY3PbOMfirp9h/l6KxBFXWkdGsVNmR5qD
 VvWm0t6jB8rmaF4EnXdeOlaWrpw61MPsQMyG1Ht023bgMlh2MMW4RgLMc0tXkFM1rEv1gt43Hag
 OssUi9YVksfP9u5bzpButPC0647tOduUFS61J1nq1Mw==
X-Gm-Gg: AYBFou1ac7254ichzTKqlK5e21Vt2q471ik5whFZOVS5C45joeLyEYBD0uub8HLo6gi
 KGNw9SJgA+F42ViVgmYXlHeRw1+rZR4GVa+q+9chB10Ivm6gNfSdLcpGLc1Dj6kk/BTAc/9tMjg
 6rinCseE5xVA7nLQtqSvRnq5OnVpqOmjFYVdH/uHqvnqDgoO7aeyIemvi/vyqHLB3gOjzciT9UM
 0jPG02Yam6nuz+Mj7IybNti7+sX2DLheCd3KJHUvzjR7uWMNuY5ywsBRdOxnrb0K0C7HtLENr1v
 FNA9yAXKxKDTvep+Up1WS8wzdFr9fsTiqZfdEnNbHqsqxlJjPYdOea/kp9PjnYAUmLgshUGj+9k
 fEbkIkXH1I9C1ax8M8ah84iSsTDGQ7w==
X-Received: by 2002:a05:690c:4a13:b0:857:f33:6f03 with SMTP id
 00721157ae682-8712a41d647mr90790327b3.29.1788772152848; Mon, 07 Sep 2026
 02:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
 <20260906194438.93046-3-gilles.grimaud@univ-lille.fr>
In-Reply-To: <20260906194438.93046-3-gilles.grimaud@univ-lille.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Sep 2026 10:09:01 +0100
X-Gm-Features: AcwNN1Xfw07d8kdokwYZk6rn3gAjzlKwyPz8_RB2JK4F_amOP1Rz_RChlWDwHGg
Message-ID: <CAFEAcA8OYNNDn7tV8gzoVcKnpNc5MZZ1u0AmbbNpRfuzdoqfKg@mail.gmail.com>
Subject: Re: [PATCH v3 02/36] target/arm: allow Armv6-M to set CONTROL.nPRIV
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Sun, 6 Sept 2026 at 20:44, Gilles Grimaud
<gilles.grimaud@univ-lille.fr> wrote:
>
> Armv6-M implements CONTROL.nPRIV even though it does not implement the Main
> Extension. The M-profile MSR helper currently gates writes to nPRIV on
> ARM_FEATURE_M_MAIN, preventing Cortex-M0 CPUs from entering unprivileged
> Thread mode.
>
> Allow privileged code to write nPRIV on every M-profile CPU. The translator
> already ends the translation block and rebuilds the execution flags after
> an M-profile MSR, so this does not require explicit TLB maintenance.
>
> Add a check-tcg test using the generic microbit machine. It verifies entry
> into unprivileged Thread mode, that unprivileged code cannot clear nPRIV,
> and that an exception handler can restore privileged Thread mode.
>
> Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
> ---
>  target/arm/tcg/m_helper.c                  |  2 +-
>  tests/tcg/arm/system/meson.build           |  6 ++
>  tests/tcg/arm/system/test-armv6m-control.S | 85 ++++++++++++++++++++++
>  3 files changed, 92 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/arm/system/test-armv6m-control.S
>
> diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
> index 33c9e7c55b..0cd51c52ba 100644
> --- a/target/arm/tcg/m_helper.c
> +++ b/target/arm/tcg/m_helper.c
> @@ -2775,7 +2775,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
>                             !arm_v7m_is_handler_mode(env))) {
>              write_v7m_control_spsel(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
>          }
> -        if (cur_el > 0 && arm_feature(env, ARM_FEATURE_M_MAIN)) {
> +        if (cur_el > 0) {
>              env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
>              env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
>          }

For v6M, whether you can write to CONTROL.nPRIV depends on whether the
CPU implements the "Unprivileged/Privileged Extension". In v8M, if
the Main Extension is not present then this is IMPDEF.

In particular, the Cortex-M0 TRM says it doesn't have that
extension, and that's the one v6M CPU we currently model.
On Cortex-M0+ it is a configurable option.

We don't model any v8M CPUs without the Main extension, so we
don't need to adjust anything there. (As it happens, I think
the Cortex-M23 is the only v8M Baseline CPU, and it chooses to
implement allowing nPRIV to be written.)

I think we probably need to model this with a new ARM_FEATURE_ bit,
so we can make Cortex-M0 and Cortex-M0+ behave differently.

thanks
-- PMM

