Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9655ECD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWshJ-0000OQ-Fq; Tue, 09 Jun 2026 05:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWshG-0000No-08
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:24:34 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWshD-0001Qw-20
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:24:33 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6604176b575so4879881d50.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 02:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780997069; cv=none;
 d=google.com; s=arc-20240605;
 b=atm7OJxCOpOfDIVq098uuu6QoLviOTnKLwnsArB+HW76JSqfxzpo2bGXQP6dAn6JpC
 dPPBhAomPaOSFuCcd+3CZOwdNgQS1s/xa3VLWxdh4w5UkK1C4mav15UGcvbB5ysV8HD0
 WCb6c6tCHmtgjlie3GfANIUtjqH4sFSRVeUmm5lHx+VdxxOzmfIjRU8na/iQp9bzoHy3
 yjnRMMh3sQE3zs/jvnbSx94e1F0mm03jrRbCDDt6FlI2EipQ9OaHfqlkNpBPFXN8HeTw
 VFV3bv1WDTaJJRdnE0T5EOifutMkjTYJuS2Sh4Uh3Qy1cqRhC0TLkMfl8BxMWK0nZBly
 IzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s+0BfXHM21QnV4863C6uImYyGFFQDfVOWFUWijIqoLk=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=GLu/6nBoKgdrcjjSmZfR5JzonhiDBQWf1EaCEOlPJhDLAAXIR5lEw1lwnh7QRkB/4R
 TFUvCJjw6b1UIs5ai9FE2cDrsk496TVWYSX4/eRMOVZQwggEVl3PHk9M4pi44loti6KI
 0N73/V9LKUONAFA76iLce/6iGDUeUP/YbV8pAZmj+Tn9Nt5QtbwwfmF2zBZjyEHKRxtX
 oaKm9EYSMaBsSENjHnZpZ7vCmomUOvmN3CgCAm8YY9jLiF7J1I5wUwdCCWX49PYb3zPK
 NyBcq5GW8ywGI645CmRM0aarg1kryNHrIqewNL/Y8SuObc0jOHPTwsO0ptYk8AsddNN3
 s03w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780997069; x=1781601869; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s+0BfXHM21QnV4863C6uImYyGFFQDfVOWFUWijIqoLk=;
 b=ucHEjO5RpBsHo5ckYkOF9rCwamqNFB/kusGD9/pAbPJnzvuVXOLuScakq+mDxHUsfi
 BrUYjJBErhZR7PrLwHy7wN8ZqYMzTVWSUUT0RdF3cDsnWrZb+2qkEjYnSusRGLVveCwZ
 8GUrRRSTOmLo9LVZdYYzEKEGAC60GrbRVRhuZcMnQU8BEyR2seOwWyz/J38jqVY/HfLN
 1c5leXz+atiOwIILI7D1pf/JganKHZwVHY5FhT+76PrwAQVBJdhKXHRwt/qLimWlE94R
 0ZDsqwKCTQudPVIa4zBbjtfs5YE+hY148IDk7Alfe42MwrK+hEIfF8PrZEuEY5q7ZJIW
 WOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780997069; x=1781601869;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+0BfXHM21QnV4863C6uImYyGFFQDfVOWFUWijIqoLk=;
 b=X6Z5tr1ozzlEzI4CWaH+CNNkBRF2qniiP/NNJ2few9mYDJa2dIMIKLTvNLIOcDWyzo
 55jT7HFJKmE+A55NaZNlhXosy5hit4MR6U8anHc7EIfK0028I7Pt0QbxAD7doPyrSlfe
 zib9wtg8DjHv2wiVl8us61kEdBRDiRtd7AM3NACOUXSKURY9DPFHcHGCnhdWXBDobd21
 huWGUDVLve0yx+7b7jIEvEQgZ9AXZjb/p1Z1WDWtCDCMTMKHzx8BQg1YOi+FbdmdhtYB
 vxsK17NlPjOzx0SsuZ0L30SrchI6zH3EUrNLSr1nJdqcwB5xrMcrE4pZtp40a8rQ54TU
 Oiwg==
X-Gm-Message-State: AOJu0YyuXEVmrqJyVXybzU9oXXix0dfRfp8qJcYMlcrfIy0010T/ZVB6
 illNVbfoRJjhbf/Dy5WJwRUvnr0tnInH/plw4iyE/zD4eSNUF79CC1WLVpWkSRrGxouK6cEKnB7
 jHlIiAk92EOKbEkUmKhETM17gOj3qUIPn6f/HHb9XVQ==
X-Gm-Gg: Acq92OHyTqsj6wUWF3oXpNVxxjxT4EmVApfTKVt6QfkX/uh1Vi03WySKNjfNVAl0oTN
 LO4V8aQSlbPZAMejpqN82SRAI2wc8b0ESGMcynqhaDeDgXkb/VGoM5RW7U613IBLf2CqNmYreZA
 LkGTb0LqmJIdQx6A9wR9upn1yafx72GE96VsmY9ahT8jBaHSuQgSC/m1sll+Abo33iUM03W6gFN
 P/umtd2WLjUNcI0U2sV8OEL1+TWeLpMk3FiyprJKWbFXHdNzcXXZjnqGFr7S+dR1yhc3PAd5t9l
 WM4H20SmfkViGvNOKL5NRoC8WuOzZ86X/jnTc/isPCQZWk/jwka0rNFBtTIaO3LJ0jYJx7HX8QT
 olQ==
X-Received: by 2002:a53:df87:0:b0:660:446b:7aad with SMTP id
 956f58d0204a3-66106fe57f8mr13338895d50.57.1780997068676; Tue, 09 Jun 2026
 02:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-23-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 10:24:17 +0100
X-Gm-Features: AVVi8Cd6sGxpi5dkdrZEQo85TMgWAk4dtx6bwD74Du4bvx96AFXH5vXU5Kl3WDk
Message-ID: <CAFEAcA_SLtJuVgeD5eD=XLS5pJn_iQYGRoegNc6w6vkpS5-BBQ@mail.gmail.com>
Subject: Re: [PATCH v9 22/45] target/arm: Implement LUTI2, LUTI4 for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Wed, 3 Jun 2026 at 04:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

