Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34B4CF6493
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 13:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suXdX-0001ey-0Z; Sat, 28 Sep 2024 09:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suXdT-0001dB-H9
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 09:37:23 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suXdR-0003oo-PC
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 09:37:23 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c88e45f467so193389a12.1
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 06:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727530637; x=1728135437; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6ZXJr4Z/EXRnC3lGSd24LwuHAyw55BDlaA2Oi+7Q/68=;
 b=U5qMXh+KV2XdWFWip+3Q2tYz1hETB9OrejCr8DJcNzsHgs1wtRy89B39LX30BTqZp0
 SZmS3bCRTATLF28JewQ6gYExGbqzJuEQsV8rnJ744qBBFPo811xUVfoKcwVHBiq7wnrB
 rZ8r9Y27pfmpzU4HKYQW2EH3sMIXGSyH0LLqF98tJRLdnEXxEQ8vyvdeuwXvgB9ZNXWi
 0guocLzpw/VUfaf+wwi3SsvC6l+M+rjHYRhiqk2JC5A0cK9Ll4P/rlugFhonh+YeKuYE
 5kk7jWCXM7I5I7bU+VUX9I8UpbiYf8zmqwDqIRuMAEvkarkfyKzDtGJh9d1jf7tB/V1L
 T8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727530637; x=1728135437;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6ZXJr4Z/EXRnC3lGSd24LwuHAyw55BDlaA2Oi+7Q/68=;
 b=J9Qbx9keTKRIUyB42zuBuGK2t98DV0W37cPb05sJL3AeoHw4MLtLlvk771AJ8dNOzf
 9b5NQjEoUTya+IKk88LYrr8WPoujxN+BaNOPnWwXXRdDBfKaM+Om6CuUZe3pOzNXZ2g9
 GOV5yqfOJn2E0M3aXdGO3r2hBxXxHIDSCASsOSJarHT6VlIZM42MxFq9p1tDQjHGNOZL
 I60jqe87kNMiJxbX2JvnuW3YrNVs4U3dam7wIWcVixuVwPOLacSAkXn4px2SrWc6Uzuy
 Wz4PpptB5y2bgvA7awQ8TlD+jt3fslbgozjpnACSCanBlDJxxjSecdDObnWBchaKkDaS
 UR3Q==
X-Gm-Message-State: AOJu0YwxT5uGIs8Ac2lVicCTGhzA/+wmcVTT6E4LjLJ0vxlhQ/o7M6kX
 /uNpTIQqJAjOgRJ5SkBA14krJO7+0Saom4jBzrkzSuBjGJpYTaKWYh8olkYsxlCUDpkXP+hByvp
 XwQoWIM5wGUA9swtam6DARmd7U6Ai9d06ZGwxyv/m/BqJ3wZp
X-Google-Smtp-Source: AGHT+IEnP3pOUzRdswqDvpl6pUzqymhONNRgxccyCEB72u3l82H0fkcS5e3CXghW0pAyUA8bQNJjUNCz8GoIk/8yeys=
X-Received: by 2002:a05:6402:26ce:b0:5c5:bda8:8635 with SMTP id
 4fb4d7f45d1cf-5c88244aac9mr6635787a12.8.1727530637037; Sat, 28 Sep 2024
 06:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240924211153.1473771-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240924211153.1473771-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 28 Sep 2024 14:37:05 +0100
Message-ID: <CAFEAcA_3p=X0sb==TRAsGTvMK32AzuR0kTbtsZCZapw81+S2Rw@mail.gmail.com>
Subject: Re: [PULL 0/1] qemu-openbios queue 20240924
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Tue, 24 Sept 2024 at 22:12, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The following changes since commit 01dc65a3bc262ab1bec8fe89775e9bbfa627becb:
>
>   Merge tag 'pull-target-arm-20240919' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-09-19 14:15:15 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/mcayland/qemu.git tags/qemu-openbios-20240924
>
> for you to fetch changes up to 972208be775a37dccb3047702ea1582e9936102c:
>
>   roms/openbios: update OpenBIOS images to c3a19c1e built from submodule (2024-09-24 20:58:54 +0100)
>
> ----------------------------------------------------------------
> qemu-openbios queue
> - Update OpenBIOS images to c3a19c1e built from submodule
>
> ----------------------------------------------------------------
> Mark Cave-Ayland (1):
>       roms/openbios: update OpenBIOS images to c3a19c1e built from submodule
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

