Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D50C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzJc-00014h-92; Tue, 28 May 2024 12:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzJO-0000Tr-5z
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:04:34 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzJL-0007wL-Nz
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:04:29 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5295eb47b48so1312536e87.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716912266; x=1717517066; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jtembfibf7TJ16NK/HQ1lgfYPTMxTnwU5WdErop0Xd8=;
 b=OVKDydt7ckWZWnpY3k2oeQ/Fe35GnQVU0JedcZRus7yfqoTE+nb8CjfBtKtXo1or1m
 5TuiOTCS+08Pp7uAgVvfyXjNa1MH6r7uq9ISkLSPLrrBpOPDjECOFb5RMX3UP0IC5CyD
 RU1qIiM2+OMxjWiQVVPyzoJ9B5trjhuLHXK9oBV4e3jSSBLTtpDZLS/QjsDEMHIZW5wz
 nigFmOV5AYKzZacNQ8BNlT2E33VQz2oAtpzq6KHffeS6o3JqpZNfKeUgK02++GKRgKsN
 TCsFbTJ62fVl7MqLFr1BLfFIaMQoET3wNWThfCOkiziDdT//Hj1+0lhRFEjbiPu4DnQ8
 K8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912266; x=1717517066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jtembfibf7TJ16NK/HQ1lgfYPTMxTnwU5WdErop0Xd8=;
 b=KWoaNdSJ9JpneO5pZWn3oYu1S3j66ky/5zFDObh9XKtcbv42A0f8gZ1Jz/xxfO3LFl
 CM81Ezmd1iScsHGxByMxPckcSNi8ss6+GsCMM6z81WkNdCVLpW1vtGf3OlqHFufTUgFT
 rSkWJMznywODE+tqa/WP3SEAFen0oXz+z14LabXk+o/edEabQeC4W+5AZaTX6iEgepGG
 VKDsR7+5WFpyutZXcMM58xXY+UYvseTDhthmh+L/IH8Bi/Phpjg2fQaOHdi6mqja6zJv
 v1f3NNf+S1OWUMEKQFwDh0e5HF3ZpD15VkEpuxXjrlUt3jbtumYrkfy8PZMDq9t5mos7
 QNiw==
X-Gm-Message-State: AOJu0YzAr7pSSTL5YKDan7b2nsoPI8VG1LHgk9rCnf2rGyxqVIqFrV5A
 O1iV6hFtL13B8rAE3S7imEuKkEknF380YjBs7wnWx56mAtGVd7OguI56DYZaRGMFleT93GntVLt
 CZOBUgHghqrX2QVTeHUnSg/zMUdqRSJu03jeDvQ==
X-Google-Smtp-Source: AGHT+IGMmuvUptur1lgtEDXMdwWBNb11nVY+eWpwaCE3Ne+yQ2A3XNATTTyPfSXkJLSUXInOvD2xrNgMCFKzk5xyF2Y=
X-Received: by 2002:a19:2d56:0:b0:51f:452f:927b with SMTP id
 2adb3069b0e04-52966ca6423mr7426489e87.45.1716912266021; Tue, 28 May 2024
 09:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-60-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-60-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 17:04:15 +0100
Message-ID: <CAFEAcA-vXfp4+O5dV5onXHZMDZW0bfLeKJgWt9icZt7TQhmXyQ@mail.gmail.com>
Subject: Re: [PATCH v2 59/67] target/arm: Convert SRHADD, URHADD to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 25 May 2024 at 00:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

