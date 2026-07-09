Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FD6C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqnJ-0007Ni-Va; Thu, 09 Jul 2026 11:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whqnI-0007NS-S5
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:36:08 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whqnH-0004uX-Ie
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:36:08 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-664c6304683so1978300d50.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 08:36:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783611366; cv=none;
 d=google.com; s=arc-20260327;
 b=XxEQr0sSjJol1Tgz65SzjlqHBesdh5eV6w73APF028gdF3sajlmIA4OMWA8pRcnapJ
 Gn5gDnjCL44fUp7bLo2Ps+Xu08Xdq7Bd4NsvtMLkG2hJU6Mu8AsoRKtmyPUWLpbCxDSM
 6H2pkRO+8NUKBwbwU91TxSHzQMO87Spo4X3ydkgB+GppX0/GZK1GrJaa4O7Q73TjMED9
 LoBVtLkktqjczhLaMQJTLj/OLz+LoQipePRPQnxdUgX55pV1k1jNAJE9gEsAXE7dyvfE
 F9oERGT3F6chBvlO7NOASBa5Ldl4iqas8CUxqK/ad0EtiikCKLppLNYkgGWodL/0BI0Y
 0WJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KwEI7FceSirCv519qRyIn/kuOFSAWrpFnuPieG2C4N8=;
 fh=waovLH6vWO53HDNC8VeHE8f11msCwa+FEZv2zJ1AgFs=;
 b=oxICgiGbENQH7o5Q19kfjioxT4CB3/KjPyYkl4eoB6KPVf0hWqWLIhv/huRMbKxvd3
 MVx6596jpVcLMIyL6F6IdUUS6ZSlQXwHcd9pdITvmDixVon+ITEXg79IxoAkEOhuPkTl
 67TD0YbimEoHjvBHiRpdKMlWQXzz1zqo6yg/lMuxwtEYKZACFGtq1pXIdDgCefZOF+5U
 DOEtAY7VISc2mBlU7+S8SaIyo66TSYW5brg0MxBaASYuFIgB/mCnc20pmFHN1rK2+O83
 0UcbfYC8SW4qqEXMaMAzLgKayXoHkZPtZVhrD9NPBtEBK9I4Hn585ByPLY2lEZQ5onQC
 OnDw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783611366; x=1784216166; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KwEI7FceSirCv519qRyIn/kuOFSAWrpFnuPieG2C4N8=;
 b=QM+uNxThQItqFHZXFAqv7ZlQ/cSgNeiK5N8c8Id5jJP0USpyl6qSRLi3nHvcIgWwDc
 rng3AjEcXkx6VZfy8OdPCpu3/nNk88e8phvtJPD0CD8I0+CZPzvFO/Pbz548BgKCLdSS
 0caYTt/RyibxI4EEP7dtN7zQEzfFA1kGH/VHuobrlEwDbFmOuCa4XTC8QPR6ffE6RodH
 KZ/nYi0ZxhZXqhAIZ0DlIh+7K6UwWJNYS6vGWLdgPybNSEpT2GfhihK458zX+ejmeMM1
 mf53TKObTHHn2HCDu623Z8UM9Uvif/hJnIqcZ0dQpSDIXOST3hEYkBPrfMVg2dWWlRsm
 CqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783611366; x=1784216166;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KwEI7FceSirCv519qRyIn/kuOFSAWrpFnuPieG2C4N8=;
 b=dQjEz+md3gpmUtSmiN31O1PMfn1qmlnhfUB+bZRkTJWoMHf8IiX/Z2DddwjvA+zoTB
 vVYem3PrtrrD6lvwXogv0iX7mm+5hSuAe4B85cRhI+NB4LqbTqxStJZq3sPItZWXn1Ce
 V7AWPpAKZ8lP4CfCHvNK5FEzN7NxdmbZLAPCu4OkOOgHCBHWyl7mgb7OrMDnzq+on6XE
 2oLzhTsNS6XJA3RnLCqRjElgzFdOsZvYkbYPwy7R16/Jo2Js3OmKdD41um9YXKZ1Waqu
 fbzcinwDQpN0oN8hn23GrrLN13/yrmqo1flNdQAmeZSWVqTFa3dvkIs1Q1gQ/NtaBIqp
 E55g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpWkIU6pSgjED4TGIRgGkcYbhwEdaeXFKGnM8IeimWAX0cSQAUtm+Ug+CIqa03G3ISDmxAx8u+L97IY@nongnu.org
X-Gm-Message-State: AOJu0YxJHf7S65dzOCBklwa3ztDTr0QvNIK0VKmk8TATpWuvAuRyJ1SS
 b0WoRE4NfJL8qLHtZj3TLnLbgdtfIioJnCkYRxxizNUVZG/0bTZXc5NSAzYBlg27fnkpYfPKpAk
 60REpTnaIAc+jRp1tVYjyaWLNUCmtwI2kiG4DRMyPzA==
X-Gm-Gg: AfdE7cksNjZksahr7/w4u+S+IkmbD94+bOlfaow9XAn4TR7KOc3rVHSts4SOdRdohto
 pVQioHAlffAOMdol9I86rg6O40bsSweO/EvdvNp5wzgQINK+4P6TGTUkHhGxSOPErX7dAayqZvE
 Fh7PZS+YYNZYhqOjLIu/QOW1bmRrOgGbHG2wHEZLwb/NhZtK9HIpOWvNe8QDp/mGKqHZvaK6NGo
 DCegI95N0SelBjdEeZJPbmc8cbTR+byf0SyepJn2troDIy0DqCqZqjyvYUaUbGo4D3/TvwWUgGe
 j3BA25Qe08paJ1AP+IT6WHQssc9gGJDaf/tRQvy4Wt/e53RY6bFKKZIX
X-Received: by 2002:a05:690e:d02:b0:667:bca8:a685 with SMTP id
 956f58d0204a3-667bca8a866mr1278764d50.57.1783611366173; Thu, 09 Jul 2026
 08:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260706230056.1888992-1-titusr@google.com>
 <20260706230056.1888992-4-titusr@google.com>
In-Reply-To: <20260706230056.1888992-4-titusr@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2026 16:35:54 +0100
X-Gm-Features: AVVi8Ceo9j-IbnSkrgLdqiHmoFCZuCmjfRlevj6CwfdZLuPmseXzgkJa8shXbVk
Message-ID: <CAFEAcA_6RgRbunqGvd2uPGehATNay6=Vh1uPH-yT=T+4NjXPQA@mail.gmail.com>
Subject: Re: [PATCH 3/5] hw/i2c: pmbus: clear output buffer on write
To: Titus Rwantare <titusr@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Tue, 7 Jul 2026 at 00:01, Titus Rwantare <titusr@google.com> wrote:
>
> From: titusr <titusr@google.com>
>
> Generally we expect a PMBus sensor to issue writes after all pending
> reads have completed. If a data read needs to be resumed, this state can
> be tracked in the device model and the pending data placed in the output
> buffer.
>
> Signed-off-by: Titus Rwantare <titusr@google.com>

I'm going to apply this patch to target-arm.next for 11.1,
as it fixes a bug.

thanks
-- PMM

