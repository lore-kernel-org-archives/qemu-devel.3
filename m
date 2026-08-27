Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0A1C61DC7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzWGu-0006RI-Ne; Thu, 27 Aug 2026 05:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzWGt-0006QT-4O
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:19:43 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzWGr-0006na-9a
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:19:42 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-81ed2a06b9eso19529507b3.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 02:19:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787822380; cv=none;
 d=google.com; s=arc-20260327;
 b=qlxuSeyJ5VWqUu12j/HZfd/CqHntbtEUjV4nlEfqiMfJ/UB+lvCeMR+qKVenWOo2Q4
 x0Xb5BESjGQvv5NncNdrwKppvzdViLsds2+P2TBRc3c+oYPq7ojx41ZEBlp6Kc9cVD6B
 b3AaaheC73o7vezvPk+Pyk5ZBG2ahTjNYwggKWV//ScMf9SskjksVG9JXIbbZq/wpt5F
 xom5LYhCGSPtaAYq2DSkSKXYE1rPR4dUdr1wNfuecb2rH8+4poax8kbGLMWXXquNe7pH
 VXBhhQNqSTGTTTNcpzvc3eFiwUobKe6HBxo5FC3wEL6tT4VNQUW9rr6sUkbJLVXTrz6l
 d8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HtBlM6Z6bTfGegu7sb9BhAkdE/aBn0pvhLP8tvsv0vY=;
 fh=ZRYhF6Rp+Cnb3RB0wrwVZZJ9P0OjTlPcRm8z4vqZvQc=;
 b=hQBc5Fz2MliwfIn5ixZeVFtc/LjJHQIqocaeJ923mJIATYVpHur7M0oXenmEkmFTAW
 5+ueVcjlek1zzyiUH4zQwbNIOdisWpYpLbw4bvezPVJCvE2LNHW/wDHfsJWPlNS39v+m
 52s5BYQ8SjAa7TyLehBnHyeOrdTATvvCFrV7BgDYBT/r1CN45b/xUfH9JAVGEB6ebTo9
 F0tZvUXsi3Sn0gOZFCgv1534zeijV0qalpOMGG5ivu+0XBCZw6Y6/KoC2F8N8R0otPxo
 k2K+cFBQdFnPgc2FpCZT2Aaa2z+zyLYJX+CSGZewTPyrtJgI4fr715tYKPzyQK+Cbgik
 75JA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787822380; x=1788427180; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HtBlM6Z6bTfGegu7sb9BhAkdE/aBn0pvhLP8tvsv0vY=;
 b=XUdCcVbI/QwKV6f9tFG+o0UIW6drN2qgD9xyBFNZgOKsYjAjZdE7L0TBGlmQ4KmjNn
 0EGvgzJBpSS8aB15x+h9XRUyUujyg9oiiTdcRmX7FGxlBZLX/zj2E5BqObas+alyNd7p
 isAn9/Wg9RNxztKU8KpwxPCCo3nmXWCOkUS6sChkVs/Cysc3vFWEazluPihTRvTjGhP6
 Q31VtomgHrJyg5R38CapOIos8LxOPoSR9K6/38q0mkevrLwvLX3WjOjAQIyza4ujcS1R
 zB+Z6XjyeKPU9AQ1l11+b2BFS9Dc8bwDwTo/dXsTE28EKoDJyNbEhnPO3E2OcxjK7jlM
 E80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787822380; x=1788427180;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HtBlM6Z6bTfGegu7sb9BhAkdE/aBn0pvhLP8tvsv0vY=;
 b=poF//lowmcpWmFbaZON1qB1827QOClyt8jQNA5/NDWU9g6pUs3phD0GEQ7yl7OkGgR
 Hge/mRX5EaZ3i4U8TLVdTIHukescQpEqQlJFLLU8wK4Cy6EQbhfwj0Gi1DDBumAMFCbk
 LpfIAPH9D8HejP6EeavjJtsw8vyX284q7EkPJ9uowQ03HbO/6Yh6s/JbNqkEIhB0SbEt
 cSS6hLbfpuEeIZLWdgV0yexvBBbx+R8dyVim+HMkVcxygNG8PdtnFeVA/HJRP6Q1aZw5
 Z5oBLHm8rnb6y7UCV4k/NNnZFBIvuF0hExkEl2GCDmToCE2aSoPjAq2yayO9O4BA0AzN
 ejzw==
X-Gm-Message-State: AFuF++mIxdBejMPNauOZH5OAeRFegC6mv/ItbFralAyxDohA/ySsCUvw
 IJAl/4Wi+i+qzvqTReOP9O9YHsE7fATzjxkY7BxQRMoZM4VRF39iCTu9FlCLGd1YMc5rUe3p/gv
 NyupJQPad+E18UXOJYNQUcAiWV5eTZfeIZZjtUL9ubQ==
X-Gm-Gg: AR+sD114hbesjT3ApjUZzQcqEtGgZZzfxdtG48fexZNzF6SXw+1CRiPENWSj91Y6O6a
 EhGXtzov5QPickGbMaJgiFZzuQQQQ7qghQS3uoB1HpwRbfGnp/FD2+SVNmf4niYUWxbUD8rRnER
 N/hvOlRyltAF/9IhyQcuUv4nLxWsEgRddOlcgH72v2hFdGxxtALe5FDS6DfeD5bVhTF0uG1/8H9
 x4D4NTp1SDM5wb3Y7DM9JqVs2m11rjwOGVnm4U3gRaM2sc9WrnQHO3NflyciQN3lwwk51A0YTaw
 Js+uJFzlgjvFbc2Q8RBDiCjS6iPcLhVdYZb7LljA1S7iHPihgEhZcPomS7MVP4SROALPcV0S6Gp
 xNf/2RiWXsNC9SD4TVjQ9w1RiUzYs
X-Received: by 2002:a05:690c:9c0c:b0:80c:ebd4:762 with SMTP id
 00721157ae682-8573be1e4c0mr61989607b3.7.1787822379833; Thu, 27 Aug 2026
 02:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260825040452.1322251-1-stephensportia@gmail.com>
In-Reply-To: <20260825040452.1322251-1-stephensportia@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 10:19:28 +0100
X-Gm-Features: AcwNN1XRZThkv23MUPhrrgokKre1Ig6vtj8xgI-faEZYcmow70zlT5AbwWYVdik
Message-ID: <CAFEAcA9etHvjL1igO4mFy5iQNy1pCbNFGaSg5HFva+YCeMkGEA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Rename ssi_transfer to ssi_transfer8
To: stephensportia@gmail.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-ppc@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Troy Lee <leetroy@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org, 
 Tyrone Ting <kfting@nuvoton.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Aditya Gupta <adityag@linux.ibm.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, Joel Stanley <joel@jms.id.au>,
 Hao Wu <wuhaotsh@google.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-riscv@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Portia Stephens <portias@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Tue, 25 Aug 2026 at 05:05, <stephensportia@gmail.com> wrote:
>
> From: Portia Stephens <portias@oss.tenstorrent.com>
>
> The ssi_transfer function comments say that it takes a word varying
> between 8-bits and 32-bits. ssi_transfer takes a 32-bit arg to transfer
> but there is no means to indicate the number of bits that should
> actually be transferred. All child classes of SSI_PERIPHERAL class have
> transfer functions that, despite accepting a 32-bit tx, only transfer a
> single byte; m25p80_transfer8(), ssi_sd_transfer(), ssd0323_transfer().
>
> The current implementation depends on the SSI model to know
> what peripheral model will be attached and what transfer size it
> expects which is error prone. If a SSI_PERIPHERAL model was written that
> accepted 32-bit transfers, it could not attach to any existing SSI
> models.

What is the motivation for this change?

As far as I know for the hardware SSI protocol, it is indeed
the case that the SSI controller (and/or the guest software) needs
to know what transfer size the attached device expects: the
controller just transmits (or expects to receive) however many
bits it is programmed for.

> This change updates the the naming of ssi_transfer to ssi_transfer8, as
> well as changes the return value and transmit argument to be 8-bit.

This means that the API will no longer work for a controller
and device that aren't 8-bit. We happen not to have any of those
devices today, but why specifically stop them working?

thanks
-- PMM

