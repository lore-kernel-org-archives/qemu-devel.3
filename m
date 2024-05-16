Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D04C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 09:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7XPq-000303-SU; Thu, 16 May 2024 05:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s7XPi-0002vh-UN
 for qemu-devel@nongnu.org; Thu, 16 May 2024 05:28:39 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s7XPh-0002xS-3E
 for qemu-devel@nongnu.org; Thu, 16 May 2024 05:28:38 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-572d83e3c7eso3256961a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 02:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715851713; x=1716456513; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xse0HV+IBwKpm7CLpAWSoVjV12ya/IxrzHtwGn09Ovg=;
 b=AsuVSV4TiMONiLLyg/auPwZeTvQ0DwKVxZn3mmogZzuJQrr978fWPaerOCcf2Owpv4
 Ws/5BebsnDzYsjKXg/WFIuSQw59kUUVEwFR/Ewd8G6JI+acpD/XEtTHn0DHgWQUne2px
 Xa3H2CJ61wct0sXuxXgKl0hFRZ/HusPZ8/fbzHnbkbmEW5p/JUWAsRTXBiM8Niqq1qwh
 fJMbR19sPO0t971+vSFFZPAr+Lx1GCGhi+Bw4l0PmTlrnJvt6ZUiq3EGzwrMbUlxVzhn
 begOxaPTTLGiHjqVXHuAYfyIGngX0dN1JayVz/Q8w9FwMDCIxGscQ8QUpCqm6tNuC4Ue
 Q5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715851713; x=1716456513;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xse0HV+IBwKpm7CLpAWSoVjV12ya/IxrzHtwGn09Ovg=;
 b=Rw8IPigY4yRZmMO1TbhuPfwLMXIJjnQYYOFpFI3ZZVPOn6MMWUNuRQ5f9JO0UiIrD0
 uukQ4krurBNWMfEHLXhQasEUn2UXhMjdICnygReRx8omc8AFZZvoO7OT3yRpR9k/DAYa
 MsjBeJNu87HD94yYTYb8ubmccPsxnrd0IX3zxXhqBwv5+xQ+JPvuoDzFvo9jjzvvFyxv
 h4YpCe45avtWv6JepwDlxBou7cG+imSmSQ9CIJL+Wdg4QiIJw+818qToyjq50zlyNRsf
 TDGJuXzuaylmq5wDDOLzB5FJE5FWbbLOqp7TcH8BI+09hxG7y9gV73D62aRdDZZiwFM2
 37Cg==
X-Gm-Message-State: AOJu0YzHBGC1UPg1H0W2YS4k2r9A7M4iKhelek+2vVzkDjuehLyk7sF6
 nCXGR+hxXBz/Nv7NnJocCAV1GE5CmQXPzZciu8VOxSwrVlc1HwLnY25Q0YnV/4iD3+kbKy0ZTdV
 qJrB5W01y5y7fUVQLL/WzHkgiHXxGAACR2Xw60uXhK5ahVlyh0Ao=
X-Google-Smtp-Source: AGHT+IHBfu3Yg+1Cz+V1AItSx0CwYtQo+ClL3J9KmJLazdDtDd3UiaxubhIuRBE7j3G7ykkWGoIyyfXHFTwiq487kbs=
X-Received: by 2002:a50:8e12:0:b0:572:67d9:3400 with SMTP id
 4fb4d7f45d1cf-5734d6b286fmr10622903a12.39.1715851713132; Thu, 16 May 2024
 02:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240516091120.1021435-1-gaosong@loongson.cn>
In-Reply-To: <20240516091120.1021435-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 May 2024 10:28:20 +0100
Message-ID: <CAFEAcA_UHCYEbpk+V4qS7NpPP_-2kL2XEHM9M_SywfkPZrpsjA@mail.gmail.com>
Subject: Re: [PULL 0/5] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 16 May 2024 at 10:12, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit 922582ace2df59572a671f5c0c5c6c5c706995e5:
>
>   Merge tag 'pull-hppa-20240515' of https://gitlab.com/rth7680/qemu into staging (2024-05-15 11:46:58 +0200)
>
> are available in the Git repository at:
>
>   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240516
>
> for you to fetch changes up to d55d16700a2e2b36c7e34724d4d77f4a75c5243a:
>
>   target/loongarch/kvm: fpu save the vreg registers high 192bit (2024-05-16 16:32:35 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20240516
>
> ----------------------------------------------------------------
> Bibo Mao (3):
>       hw/loongarch: Add compat machine for 9.1
>       hw/loongarch: Remove minimum and default memory size
>       tests: Add migration test for loongarch64

RTH: I had a comment about adding the versioned machine type, so we
should hold off on applying this until that is resolved, I think.

thanks
-- PMM

