Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40872D44157
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 13:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDOKS-0006hP-Ab; Tue, 19 Nov 2024 08:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDOKM-0006gz-My
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 08:31:36 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDOKI-0006r8-7E
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 08:31:34 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5cece886771so9328356a12.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 05:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732023085; x=1732627885; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMG5bJ1hHzKhPyhi4GRumXR5tZcI2xvQdWCpZz+t1l8=;
 b=mjXAsOJ9lOC528zH2wFL94LEQvPtF2ECHECkyEpb7ZMhP6Sb+jG49r+dRBQ4yP11rL
 zRCE/IiTmPyRhSUi/MhenXE9b/FdqIpl1SbsZisqV4tzynqZeNNb49yEBZOABmt/prvw
 7eIAcc8RKeIQ96Xy4zqYrdesftsXLrNGMreQdasst360b7dBE434wi6G07VvaebYir44
 +P2jTUwgQTc9Qw/4tTuMPH03xP4uXhOQCHDxFKCPVAqZXIfxV+rK0io5ChBuYuDNSOoC
 hfdQleXts3AsP/mnxOHtxzrpmG4EywInosiZXBg80CCjzLGgBXReWXQQml4BfqaaCMXz
 NWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732023085; x=1732627885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMG5bJ1hHzKhPyhi4GRumXR5tZcI2xvQdWCpZz+t1l8=;
 b=SZhEgUdpX0BqyEJCnpu+dVSvfiHVGUkwAo34lg9HGv6nB8H3l1FONwZwk9zqEyiBq1
 XqNDTBNyxuQW0iCSeXp0c1RcWUrHA5L5ML8Zz+dRiQlQO242RD0FFtHHaZQwTqVMLnnr
 cvfx23YO04uDN0ue45x16usIqqhzMCjLvqHspfO3CkhySUEmaZR5o4PcgEegN0AiOFix
 nNiqTp88S4nnSvR/WD2d4h3JCrNXPuYJCc26tCKfVI2KCZCj9QJ9EEzr4Yg5eCzLtNH+
 wK+kYBgYe/B1ombFX34B9AlDHqZC7IBh6NlQ/k2dagHJcWUbkMHKKKyaAqWAyD+hmje7
 nkXQ==
X-Gm-Message-State: AOJu0Yx5sVM9LH0Go7+CVzwBrlywc/fkgRG62rJOTiVV7USf0RHZjOqt
 jIQ/npOHqVcN50cZvZIqnyyevglLkj4itIkJWJ//tCvsqntyVoVkXuIxJf8RWvIxMbnGKwsQ1YA
 CGHm0aWGz5ZHm01E3QHDj7luYdueqpezI/AQu3g==
X-Google-Smtp-Source: AGHT+IF8+WFmla9CKxeiSCNcgZWOzBRDcHbN0f0Dk2dRXjTPhcRFQrvQ66C9dGS4YsW2fAl702J6e8P8q+TZCrdpnhI=
X-Received: by 2002:a05:6402:518b:b0:5cf:af26:3da9 with SMTP id
 4fb4d7f45d1cf-5cfde6199ddmr2748841a12.12.1732023084961; Tue, 19 Nov 2024
 05:31:24 -0800 (PST)
MIME-Version: 1.0
References: <20241118204123.3083310-1-alex.bennee@linaro.org>
In-Reply-To: <20241118204123.3083310-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2024 13:31:14 +0000
Message-ID: <CAFEAcA-w+Q-tgqGqcS8NwBNnXebZc1EPLkgY=UWPs7t++gQbbw@mail.gmail.com>
Subject: Re: [PULL for 9.2 0/4] updates (virtio-gpu, gdbstub testing,
 MAINTAINERS)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 18 Nov 2024 at 20:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 0fbc798e4f51d6d2bc05f4965b0eae74ba2044=
71:
>
>   Merge tag 'pull-vfio-20241118' of https://github.com/legoater/qemu into=
 staging (2024-11-18 10:04:04 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-9.2-rc-updates-181124-1
>
> for you to fetch changes up to d6902d7022ba1405a991c94a99b37259d0a6d3a7:
>
>   hw/display: check frame buffer can hold blob (2024-11-18 15:54:48 +0000=
)
>
> ----------------------------------------------------------------
> Misc fixes for 9.2
>
>   - fix remaining gdbstub test cases to exit cleanly
>   - update MAINTAINERS with qemu-rust mailing list details
>   - re-factor virtio-gpu and fix coverity warnings
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

