Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A57AD30019
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 15:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1p8D-0004yl-So; Fri, 18 Oct 2024 11:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1p8C-0004y7-LJ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:43:12 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1p8A-00013Q-OG
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:43:12 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so4068148a12.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729266189; x=1729870989; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+CgZWY9fB6p2WqZGCXblHXKAsQRULhetRVvwpPUjPeo=;
 b=YxPslvXfF+I3zxp6V7iKkNLA1nCwYw5z9SCob9UhLJoHCqgHOysqPzKJr4kr3jwrnZ
 KfAKVrYRkhuxoOi9G2N542VcAQ/BSwm4rqwHNjcG5kLSSIl6k+Oxv4Anu6mLlWoCXQqs
 qOLIOTG+YFVVFewnzMdP043cf9OUsdjqueSkLGrcq1z7jldFJxYZR/2Cjagt3Bnsw32y
 TCr1fDBC8IjGv8r4hpCgVhXXKlDA1R++zHl0+iACgxUSaVBQg4jybM86Bjv9xCBRJwbP
 9FM0SHtoCRge19z8XH1Lyuj7ZkjfE2Y3Ej0ywQLj+yHQKud/PXFBfSe0ltBFjNxZLaos
 Ih0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729266189; x=1729870989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+CgZWY9fB6p2WqZGCXblHXKAsQRULhetRVvwpPUjPeo=;
 b=Txx50VaJZieQUBXwGy5fy0Y8zMeobPZtWiaiachFexjwZRODOVUFata5si3TfyWZ5z
 qBlC/QWncehPBm1knRHFYfMEzKzYS5qUB112qSakcT1Cq2gPPpfzl4y+Tc+y8e/IXcxN
 hNr+AoOlYFZgKwUInQtiud5DBcx/+JGN8bc1J3OmMZKpBKUDJn5YuqS3eC21kzCVmqNz
 +xMI8wzjNAiLB6N0JMX5+9mKMySYPOJOKpKe6wyBGVEe8KuNx6Lh1bs7CU9HSgJfqEoF
 yivBKZT1KNzN7R4uQ0p+0LXLTTTpR+AevxqclJMIfg09U3zQ0hRH0GW0evBBKQ1mpuoB
 lQ9A==
X-Gm-Message-State: AOJu0YyBODg7X63dC1RKBP57ZhLmt1amQNpymtorHj6fw2QujaJaNX8O
 JfKRfWYhoC5gu2MqM0+n/OzRLfxoESH7WAKMd/+mExHt1RkS3ZszHVTl1CJlUG8Xw+t5YZ5ls7I
 R22sAoLAjm6IIuDw2azZ8s7hwUyUW/mrG/4JxFQ==
X-Google-Smtp-Source: AGHT+IGCAPHfuffTy+wCZfeUaCcLRP+GK02cq1rvOmkO3ilyrb7hBnkO/lVN+19xNWLlrMLkoeHplE4jyJsGZ7wnN04=
X-Received: by 2002:a05:6402:28ca:b0:5c9:46a7:527 with SMTP id
 4fb4d7f45d1cf-5ca0b117cacmr3059569a12.17.1729266189161; Fri, 18 Oct 2024
 08:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241015135649.4189256-1-jlu@pengutronix.de>
In-Reply-To: <20241015135649.4189256-1-jlu@pengutronix.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2024 16:42:58 +0100
Message-ID: <CAFEAcA9sjszCj=Fu-A-=qQV_jawnomJ-Nqnd=Vx2vLKmYZ1-nQ@mail.gmail.com>
Subject: Re: [PATCH] hw/sd/sdcard: Allow user creation of eMMCs
To: Jan Luebbe <jlu@pengutronix.de>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 15 Oct 2024 at 14:57, Jan Luebbe <jlu@pengutronix.de> wrote:
>
> For testing eMMC-specific functionality (such as handling boot
> partitions), it would be very useful to attach them to generic VMs such
> as x86_64 via the sdhci-pci device:
>  ...
>  -drive if=none,id=emmc-drive,file=emmc.img,format=raw \
>  -device sdhci-pci \
>  -device emmc,id=emmc0,drive=emmc-drive,boot-partition-size=1048576 \
>  ...
>
> While most eMMCs are soldered to boards, they can also be connected to
> SD controllers with just a passive adapter, such as:
>  https://docs.radxa.com/en/accessories/emmc-to-usd
>  https://github.com/voltlog/emmc-wfbga153-microsd
>
> The only change necessary to make the options above work is to avoid
> disabling user_creatable, so do that. The SDHCI-PCI driver in the Linux
> kernel already supports this just fine.
>
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>

Applied to target-arm.next, thanks (unless anybody would
prefer it to go via some other route).

-- PMM

