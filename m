Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DB2C47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 10:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVUjX-0004kj-MD; Thu, 01 Feb 2024 05:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVUjV-0004kR-Sc
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:55:49 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVUjS-0000hk-JP
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 05:55:49 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-55eedf5a284so947002a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 02:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706784945; x=1707389745; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q26hgKbpnZCdPXhddcHdyfhoYhJbqcpu+ZjneKgy2z8=;
 b=hcIqTmE9xG6UuBkBFlx8GWimAGdW1Tg5W7saMdJ9hgwKLkm62onBwJQxaxQ44LFC/n
 ExA9I74Dr34hXyC6usA6dk0xF9/PVIVxtk0mffnwK14SINwZAi/B0jB8+wKe813XVl2G
 kDRlBrcWP87HgEnMXxXDMUI47YKyUI/9OZqqdAjYliYTeYOsJG0fjhUKBvIRIFY9KsxI
 SrfCDedRM6L3zKawPuz8MDWj74ZY8sokO2XZ4bdsSDqonJ15yBqCqwxXMrq/yoXbVhtr
 tVOO+iALo2USRtvr7V7waIt2mml8TY/3un2YGbdQl6Vkf6NFQf/vczV9Zft21tMHQQ7h
 AgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706784945; x=1707389745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q26hgKbpnZCdPXhddcHdyfhoYhJbqcpu+ZjneKgy2z8=;
 b=p43RLb095H58OEM5sLnl+bg8AyYzc72aw1W3h3Ht1XvldoqGsoN4j8Xp6aOxE1j6Xg
 n5y954hzvG3y8mrtftPptKKiM7vlJbsjnzdRnY3dyIIq40IE13udXHyycpIYAHrsNRQk
 F3MGi8A16vvzxeEXZHMEOSZs3WL4iXAOPpiSpSZJdTdiAFkx3AFX6VTZSV+by9iOBIKl
 hzVhPs2wut9EYtSt5nZ5wE6otfFZSsEIINVQNWo+pn8YQbwayaUUlU3oanu9T/gyabID
 4dFVdPoy6vNOXyFOlMLnujZqt9Ve5CaX88ApribPG3uIFLIz1bla9w+glvJJ4bnWnNy6
 COQw==
X-Gm-Message-State: AOJu0Yy9SFI7XzWC0dER4iU+FYcHfPEXC+lsCUf26/j1eVZHKnvo+qSu
 2Qd40XQ3A56xkIlYAILQqnyg/vxBjO2m0fcRhpAk2AgfEVcF6YC+mCVH10KQaHozo9+ugMF8jR3
 EC9vnnQaEHkviNykVgMtNwVS1EkF9qn3L4t+/fw==
X-Google-Smtp-Source: AGHT+IHF5DI2fSloaIXE2I8knh3cPDMkiqr/ysIgs8YZQz2BNqfYjF/1E8t3t9CWplUxRHz0ceY/wWpeHmKur/xcAUU=
X-Received: by 2002:aa7:dcc6:0:b0:55f:6b8:b2f7 with SMTP id
 w6-20020aa7dcc6000000b0055f06b8b2f7mr1401403edu.8.1706784944861; Thu, 01 Feb
 2024 02:55:44 -0800 (PST)
MIME-Version: 1.0
References: <20240130215134.346557-1-stefanha@redhat.com>
In-Reply-To: <20240130215134.346557-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 10:55:34 +0000
Message-ID: <CAFEAcA-p_Yv=VHhm6DxRkQe0mp4e2cNVVXjkHbCvVHEUF-DSxg@mail.gmail.com>
Subject: Re: [PULL 0/5] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Aarushi Mehta <mehta.aaru20@gmail.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, Julia Suvorova <jusual@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 30 Jan 2024 at 21:51, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 11be70677c70fdccd452a3233653949b79e97908:
>
>   Merge tag 'pull-vfio-20240129' of https://github.com/legoater/qemu into staging (2024-01-29 10:53:56 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 954b33daee83fe79293fd81c2f7371db48e7d6bd:
>
>   hw/block/block.c: improve confusing blk_check_size_and_read_all() error (2024-01-30 16:19:00 -0500)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

