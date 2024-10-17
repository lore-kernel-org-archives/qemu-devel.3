Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90801D2127C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 11:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Ote-00083w-2D; Thu, 17 Oct 2024 07:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1Ota-0007fe-HR
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:42:22 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1OtY-00074o-Aq
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:42:21 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c94c4ad9d8so1267182a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 04:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729165338; x=1729770138; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEBhnIM4WfP1g25I2z1kaOFk26YuSNIPE2uPxwTCmHY=;
 b=OpWUEYgWaKD32RYe2cIKVDydyJq+AKnKfMwhXgxQbkxv3nh7rrgQv8shR7jpILi8PN
 UV8FNCAXdzTDXCDO93Tg3mPopbfxCAKjahvqJ8VNR+reop27oqWJwZJwuS3Vuno/kS7o
 z5MUm3LocunRmlxV7wEz9mUwKWcnJ3D1O6ec+MMQU6c+WBKDdrAAV2OYs2twIBNia1aE
 xKSLCgzTLrMeJou4JsxEUQL8a+nXPCivAx8169i2WbzdIPuSMAGWBw0HfMSC5yvXm1+s
 gxdBYNjBQxvzO1Ewa93k/zNAdb0XEwssOFQP6LsY1yfCc4ZVcAgP7NeC7u3s7gEPwloX
 hm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729165338; x=1729770138;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BEBhnIM4WfP1g25I2z1kaOFk26YuSNIPE2uPxwTCmHY=;
 b=BRzytUudqe9czKEmdiNSYpkNzI+I7AFdeAObFixfvOnVnmh7Lz6HgyqMHCF3+5MY4h
 s2dntl2hSH41VQItTyWu9MJKNNtZA5buxMatYDZccAhNB3zQNhwhLpQ4bzHBevuRXneb
 IL/ZpDRM0OxEXAZENNe4v1toUzH9sQJIunZyTwcl+TCd1t+CPo1NNwN4sAIg2Se3PZXY
 FHvqZ8VZKBloETtVagZ/0wUtwPvUdxFz6zC5OcFls6zk4GTWNdqH6Iv2ue6Y9cpC4wW5
 BXZVWotQsIn/KCkP1nLQ3h9HrweS/CH2Y+PeP0DKEgnIBJbjQ/57Y+c4dAFtw67go4Pn
 dkow==
X-Gm-Message-State: AOJu0Yyk9tnbG+WZMF4+NPXHDJTs82xogK88+kcME7/kmFIhxHhAuT95
 0DfKrA/pUGaH3TpjMXqfkgGsicX4p4N5Ar4CGNKUWdDdBhBTNjnqsLf5QLX6C8cYiFY0Di8rSFy
 tkTQDiMWFo+1dCaRrY+lM0MUABGpsBRB0jZwARQ==
X-Google-Smtp-Source: AGHT+IEhzKH9KGSfBvI3eSJbB3hlQIPgFPLBQNSC7a7VNHaJRBSx6RWKEKxDcAR5pFiAP6dNawjV9Kdyk9qYLtkKNSQ=
X-Received: by 2002:a05:6402:1e95:b0:5c4:1437:4159 with SMTP id
 4fb4d7f45d1cf-5c948d48359mr18912436a12.28.1729165338557; Thu, 17 Oct 2024
 04:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20241015154443.71763-1-philmd@linaro.org>
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2024 12:42:07 +0100
Message-ID: <CAFEAcA9zQhQr-dUN+S1yFn_sOSJ3zpYJM=mu2h-4hu9XAvMnWw@mail.gmail.com>
Subject: Re: [PULL 00/33] Endianness cleanup patches for 2024-10-15
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 15 Oct 2024 at 16:47, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The following changes since commit c155d13167c6ace099e351e28125f9eb3694ae=
27:
>
>   Merge tag 'chr-pull-request' of https://gitlab.com/marcandre.lureau/qem=
u into staging (2024-10-15 10:30:43 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/single-binary-20241015
>
> for you to fetch changes up to 3e8f019be77d1b648bca0af0121da3bb37766509:
>
>   hw/mips: Have mips_cpu_create_with_clock() take an endianness argument =
(2024-10-15 12:21:06 -0300)
>
> One checkpatch warning due to wide comment:
>
>   WARNING: line over 80 characters
>   #108: FILE: hw/i386/multiboot.c:380:
>   +    stl_le_p(bootinfo + MBI_BOOT_DEVICE, 0x8000ffff); /* XXX: use the =
-boot switch? */
>
> ----------------------------------------------------------------
> Remove some target-specific endianness knowledge from target/.
>
> For MIPS, propagate endianness at the board level, using QOM property.
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

