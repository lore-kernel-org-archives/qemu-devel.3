Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895F0106ACCD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0knc-0003SC-54; Thu, 12 Mar 2026 14:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0knR-0003Rp-TT
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:30:10 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0knQ-0001Ky-50
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:30:09 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ae222d978so1676546d50.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 11:30:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773340207; cv=none;
 d=google.com; s=arc-20240605;
 b=lUT7q+rI+mFd59VbsG6BPIO3KHkPbUJqnXeqsfyyo8ZK345od4a3fdYlFk10S5AW9u
 siB9nUiXS2S5ShBqytwMwbeF1XV3aeWxZntGitREuQc7JFBJXX+wfP2PaYICjwMkKuJ5
 py+BW/8zScYoUl7KwAYb8aay7Teg01KTmSy7VAmA3Bkt4HtiynzZWkNmMCddOgNsnfwu
 KCIRmnKfZAr81di2E/uBJ6+4m3RcOwdmFzEnL8B8otNzBwcN//VuyK37Ct7KLXxmsoTE
 8sAPKKI5R6JdqBNLddGrahFBFZXY+Tn/f2nXSCBpV9SvGLXh7Z2KRarONINIBkh7HmWf
 J9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Xa6SxkGJeMds5YnWB2RUBshGbVKzBqZ6yA8IvfnDPKU=;
 fh=EzCqtT5E+bTTLv4rNAwVJ+2ChJBsIX5zYHpMVTT1IcQ=;
 b=fEvUasWam1TYTSJt2s+4vNDeo9lYQia4gy0GLG6+3jBFrVz2OHwZoZkWbwU9BbhMwj
 sjgmSKvcyKuXsoY7M45rVa3wbIEoHUycwyd9ahSNALBMFusrMSFlsBHJW8OInfQRF4xb
 rSCv2WYK4OCmH2DgJzY78uaF1NrsuHF1SL4HfcqSoAdxoGghVP7sqDaypSVWJHZ1N0W7
 OGXgVk7BclN6f52XUH/R4b1jvUGK3FXvrwHus+PrIrK8HjLyaXXmDn7B5Q8DyvzUTXL5
 wQXLFMeHDbfFncd20lay+DYZ2RfKPw3qIgdbO29Hcmn6TRBZTJZ8WmTrQyhMEHuiRpo4
 5peA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773340207; x=1773945007; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xa6SxkGJeMds5YnWB2RUBshGbVKzBqZ6yA8IvfnDPKU=;
 b=zdcaqFThBE/j2dhkYCEayyRrhUijoNles5LtvK9aoBIZOs3C7YmKjXrnRdEV88wrQj
 NxWOXAeFfS+vTo68BuxUFtpY1uX0eBiOA5s6qxiZ6lBg6gnIitb57BwAkl08WU+pRZmp
 HXOPs6DDFMpf6XmiozmtNeECwZ59ppue1ej7Bj8l/vdppCoT8nBgsOeIW5J4AOWB/Ezo
 4JquU7lEMuMQCp+rShvznJvtsommNE7/xqkL2pOoErKycV/UJ8C8S/EUAL1qA8Evry9D
 2llXXHb6SbvqIwzXpMB/LToE0A8Mtp5k/TW8yRRaGbFZX7GNm9gXbFoEq8JafreFKtc5
 0NYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773340207; x=1773945007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xa6SxkGJeMds5YnWB2RUBshGbVKzBqZ6yA8IvfnDPKU=;
 b=MgPKjOy1zgbVHNyyw/a35fJMwAvdFonbq9BgozYeJgkvNqw0NtHa5cAg4deqR+O3SJ
 lAkYFShOIiO0qcs/M4+EnqhrdN+pRq+QYv+3VV6VNLw7Mw9R+kxJTk9AXzPD/A7ajig7
 qScxUqrguIT0xi0J6fje5icWhK2aOHHynDJS+Sb0E3+74YqnZwWu0kyqSh9aKQxtVqJt
 KfkeZ+tV0l1r9a9hbcNRWryn+j0ezZWLJSzNgzS77smqXSX3c+oP13BFPtM/8LBXmzv2
 UJg5xjoTmICtB+B6boRRMoqbaopJPmUlZDk6W8Kivci4JiGJaobolckwWwh1cRjvJ1L7
 +cBQ==
X-Gm-Message-State: AOJu0Yy4UyVOUMqzRWPtUJ54elk1vMLGMJ57HfXfK9TdbgpWCX742qBp
 cAKGiXDujmYTLwDZnOICCn1Ful8zRWjzgSr3x/3sww7WtkjEwHTWadWgoIWi7p2zp9BCYorOFpf
 CLwUGxw7XgXY9NeotvOIm/xTBCpfEVjbcGHbbCN4qvg==
X-Gm-Gg: ATEYQzz5jS9br+VxUzCwsa+WuOY7QqyQxtvGNlWZNfTlghABf1cmrRvHcv1DKi4D6Gp
 ChyjQzJw9P8JU/BoR6M0rCqOSHC0Xw0I5q1xRhlWmJ3fDw3rrsV+v88CKT4jJaKpNxdHn1FVwNs
 +FB9IDt+JNMG27d861vkgyiEf4V/+juC/OQR5QJjxII0tp5vUJ5VADLvOfAOxIQVwtRfK2svXl8
 239VxzgR5yJO4d0goF+nGcZn7hE6WW5DyIWSfrKY5Rj6DnvrcMKfbkMs3L41FlLWpSNnv1oK3U1
 aMoXPaghidUGkKN8DrK4TMaIFE0s09oYDPBWDY0chwNEFtiYML9U4z0wXEY7R64Nduo=
X-Received: by 2002:a05:690e:44a3:b0:64a:cf8e:47f6 with SMTP id
 956f58d0204a3-64e630865acmr535985d50.68.1773340206928; Thu, 12 Mar 2026
 11:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
 <20260311-semihosting-cpu-tswap-v3-2-8e239575ec08@eonerc.rwth-aachen.de>
In-Reply-To: <20260311-semihosting-cpu-tswap-v3-2-8e239575ec08@eonerc.rwth-aachen.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 18:29:55 +0000
X-Gm-Features: AaiRm53wMBfnHfMkT_nFWq7K7AEHUOGQx_AefB5t5Ewv_dQrzE-ehEHhDGc0YD8
Message-ID: <CAFEAcA-n5VJ7QfBhj_hwEErof2OXyig+O8LB_0eKSBwt--ahVw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] include/exec: Provide the cpu_internal_tswap()
 functions
To: =?UTF-8?Q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Wed, 11 Mar 2026 at 16:28, Martin Kr=C3=B6ning
<martin.kroening@eonerc.rwth-aachen.de> wrote:
>
> These functions are needed to support semihosting on CPUs that support
> runtime-configurable endianness. They should not be used in other context=
s.
>
> Signed-off-by: Martin Kr=C3=B6ning <martin.kroening@eonerc.rwth-aachen.de=
>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

