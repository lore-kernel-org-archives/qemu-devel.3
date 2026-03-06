Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D74EFCB626
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyYW2-0005Ws-4K; Fri, 06 Mar 2026 11:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyYVs-0005NK-Tc
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:58:57 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyYVp-0006tu-Tx
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:58:55 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64ca1ba0089so8693824d50.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 08:58:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772816325; cv=none;
 d=google.com; s=arc-20240605;
 b=NYmereDyC6I653puC1Te+A2Vj4eyJnqmcBX4ndlOXAjmD7h5XcUo9vzjuinhzX1q6+
 pATHaR2chTeH5aLD+hqk0IpyfTg8sP+xIr1b5bXPbeuZyQ3oIE25C8Duzz4PDHI3dhEC
 bIJizpUNCD/vM1gxs9xsoz4gce/akFkdfv4ZhqDXZn4alx7a8/gk5fPQUomnPxrmXelN
 TYai5DNkq2qS/WIhYMW3yHsOng92vXzcrPiBvi2VGJcttuUJJCCnxTJDzOq92Glb1P0F
 8Wkoa3BIbAN3h3HzjBiSXJTvhZGFq02c64O2d3yqJqs9Cla7TW9gy/GoQ8u4X5s4adaL
 Z99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=wMp9iT2oBHVioXDMeR9lJeHUwdoXY49xeXeV9GbpoRY=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=EYA8XrjHXaUn3w4K2xTd9Eo1xBjXe8iWz9MHszZHmZSDai8Z5EQ3BtZlWw7ykpDqCo
 DZwFaBAnvE2ts4zyM7vyXmghR/XqjIntKvdbyckP8V8syJIUjttI/LhRlgJcwU3dsv0l
 P0yyyEP+7t+TCd6j7PriVsN/YMLvIZmXiUjHWY26v7qOPXTuihvFXqJPzdwLBl6ucVSQ
 BKOTILThzPjIQM6AXcenZhMKnAP7PZWKq/ijad1ChLPgsnqYR4RccQSQ5OBXvvPYqoGD
 l/HwNuW7vs7SVz+M9Q146FRi/tMNpdGri3WKWjglSQ2mklZtBOgewjWMadJ1U6m2DYsn
 NLUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772816325; x=1773421125; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wMp9iT2oBHVioXDMeR9lJeHUwdoXY49xeXeV9GbpoRY=;
 b=iyhe6Uja6Wx3YsFKRwhbJwm7Mkub+f1RIq3mjWd/RePCb1Fd8r8Rr8Zntd5YtzTusR
 0MvnrpSUZMfm1ogIObA40xpPX6GK0X10o1NkdBlXfhIZCkEVIKqUQJjhkOX80sal9m2B
 taPUW8Zf5kYgJL2cT34t+dmzDuoWFrtE2MozSf4xhrXpK3G8YXroNLl56F1AsrQIZWGv
 doY3toMkhKJUl8jJp/xtilosON4TD02K4/aOuZVFsp37sc5O6F+bXCAsQ0nCz1OKujYm
 g+1Z3sGPJ1f5cbQrwUen9utvsF0vU6V62mqKanPc+tw1WkO5W/rM3LOF5X9zbO8OTHD8
 M6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772816325; x=1773421125;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wMp9iT2oBHVioXDMeR9lJeHUwdoXY49xeXeV9GbpoRY=;
 b=Zc7Ej8kGF2rC/rv9iHN92qiEDKyPsi8CCi1nPYmbCt+mtIO5SVusM6PhPj9Ty+bxD8
 L0ZIM+oMyIYUE6SiWP0bXsI7xzWBZCahrBVyvNg7TTH5ljBgeuycwsNZSnn+Gs78HoKU
 tkEddHuQ6XELCOUsSZdep7XQF70jh5sXhPhBQ8YBQB4k8+TtvN4gIjV0krIGVkreffYx
 lS0B1liy/CkCn5Y5ZXaJRFwJbgsyU5OXPSzFdWMOFKrJvvSz05IbvTT8PT0FUwKx60YH
 +F1QhnHP93OMtg5+P8t79j8WSACzKE015oDCrHj0JrsRv3BC3fb+Z8IV/k9rGRhwI4BX
 sIqg==
X-Gm-Message-State: AOJu0Yzs0r7AVsext57JW8hyPGsGLHnihMhu9KDqpkeIabdd8Zw03+Ce
 +DMtwC+GnfXiA9rUWiOeBcpwNuTOJMcfXsNC9KzmKWy1apdvKCJw2kP7SgemhCGgTN29Pnba1/t
 za4t9zpojrBqOKOi1LLI9btV25+l+8rw2OThkWKVajQVndsfsQl1Y
X-Gm-Gg: ATEYQzzMVcDxOMqJBDeRVgZRE92zZYlgHeDHe3ePRy4n6/Xf7sbae6PilcKfx90a5O+
 CJTTTn/ZbiTUvaf1GLy8qxRW3m0GqSq6a5zN00jghm+1uNMHKbnu6YuRc1E5BhGUGs4DDUxXIt+
 G4uO8D0N35pWaZq6lEj5Ah5R24PYL8MAs2YJx0LWQQ2YcAKOQJwP1VxLhFyahU8Gdiwg5l6vy7d
 o8vQR1JSP+of5KLbn3SNWquDBLRdFKIJ0KOarUPs4IcVjcDY5hrfsNOaqvQjKBEJP+VjBeIBHJh
 6KUVuFabFDVHNcwGuxF3kY+iHlxh7Kr5v2LNUSzYOHUi9YanCEjfaawOYVNJWthbSVM=
X-Received: by 2002:a05:690e:11c8:b0:64c:9fe1:38d7 with SMTP id
 956f58d0204a3-64d143a1751mr2511543d50.85.1772816324698; Fri, 06 Mar 2026
 08:58:44 -0800 (PST)
MIME-Version: 1.0
References: <20260306155801.2198582-1-peter.maydell@linaro.org>
In-Reply-To: <20260306155801.2198582-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 16:58:33 +0000
X-Gm-Features: AaiRm52o92kkDTAv2njZL6BVIdMui3xfzHkS_rnoVXMivW8KcgqkujPVzHXKXqk
Message-ID: <CAFEAcA9DHJpMbpWP0_1igx7Qxo8N_7jJ8iaCepeUkVNiCKFKVA@mail.gmail.com>
Subject: Re: [PULL v3 00/36] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Fri, 6 Mar 2026 at 15:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Dropped almost all of the hvf gicv3 and nested virt series.
>
> -- PMM
>
> The following changes since commit 314ff2e07ddc6163554077d68aed5d76a50b8e3d:
>
>   Merge tag 'pull-request-2026-03-05' of https://gitlab.com/thuth/qemu into staging (2026-03-05 16:58:20 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260306-2
>
> for you to fetch changes up to 7b6a3c3349e8ccc11c1857abee7fa218bfdf53e1:
>
>   hvf: hvf-all: stop including hvf_arm.h (2026-03-06 13:27:24 +0000)
>
> ----------------------------------------------------------------
>  * Remove deprecated 'highbank' and 'midway' machines
>  * hw/arm: Add missing dependencies for STM32F405 SoC
>  * hw/arm/smmuv3-accel: Read and propagate host vIOMMU events
>  * Minor MAINTAINERS updates
>  * target/arm: Improve logging of migration errors due to system
>    register mismatches between source and destination
>  * hw/arm/aspeed_gpio: Don't leak string in aspeed_gpio_init()
>  * tests/qtest/iommu-smmuv3-test: Free QPCIDevice
>  * chardev: Fix various sanitizer detected leaks
>  * tests/qtest/test-x86-cpuid-compat: Free allocated memory
>  * tests/qtest/qos-test: Plug a couple of leaks
>  * hw/arm/smmuv3: Fix various minor bugs
>  * hvf/arm: expose FEAT_SME2 to guest if available
>  * hvf/arm: drop unneeded includes
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

