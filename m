Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C861C606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vtzcodb8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVSE1-0002n6-4U; Mon, 23 Nov 2026 06:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVSDt-0002mi-Ff
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 06:28:38 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVSDr-0001f3-BB
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 06:28:37 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-67921b515a7so3205195d50.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 03:28:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795433314; cv=none;
 d=google.com; s=arc-20260327;
 b=eXOvVNkZAj8fyhhqEYQQ9rgC+ppXMMAVrWviRy92ANq1hwAMF0q3S8QB2xSTC37j4i
 mb23qf+sEycwqqzrtgiOvIlTK91n4OuYznPtw+d7HyzHxmxs91X9EPWtcRcygODyohxx
 GlEWgTFPkJNEq/lvTNSyeoOQaNA3oab8us8O508b8bwJ6MyDfalvxmr3N3xWhc5OScpg
 V9CM2Q+xIFvi7FulXdlWRTBJX2+r2sCL/S7xPuGxfRobs7cPo0q7uIXiBKl4dj8bQxwy
 dKJBuHGT/zm79S5RE0PRrs5ZdkgrvLrjpz8NNvAElT9Y/CxhPwlKiDu+mt2yBPgL2zpZ
 rlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=D6JYfbVzOmCG6tYTaehEtn3ibekVe4GjRe8lJDd16ZU=;
 fh=6XnXMJYFRoy/vZiWCJijwFGoJ1wfuCrZrR2Dq+7S3/s=;
 b=eWqEUMT0kJnFI7FJJUOt4W9CNMEhcsEUCdKxWGZ5YGqJmGCqs6jRoiadXmLCqfHpcf
 TwbO7XglS5lCc2ZlbdaSpGUr0M4LG/LUbNFNA33i3pl7pr5DleIhpIDHBRh4v2TlDKVM
 4wvaYLHlpo9gB3T9dYKv9rvtzXDl/ZpH4nI1ZvfYfIKIVU4Zj9UT4SjrTxNMzBXboNRy
 xK7u/+93iC2Sqb0il0R+tyfQWqfs1BNqvpaIb5+XxBcMa7Nt7YullSLQra6iF5CXddsX
 hzX75dNp51GQ1qB2UU8nXFdIsPBbp08kxu5VB+o4AN7C/5kYSI4nT6GZsPBn5N3GUrfc
 KAIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795433314; x=1796038114; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D6JYfbVzOmCG6tYTaehEtn3ibekVe4GjRe8lJDd16ZU=;
 b=vtzcodb8NyRZqEqY8e1GQWI/ecz5HNKQR3a35rIrivK9TQ1Ka6Lp+hfE2NCMK+1wWo
 z5HZy9pj9rU/vews4QQkmh5aPvHX73TjY523ezVuDvdu7CtUnQ2tVUxIuKI+oaPz7DjM
 MOIuZIYso2Crvg7yLrqfdP5wwLjae7MvSqOKsbpdhMSSVJ54BSS3i+AMoZJOpnMzW30I
 gjJJF6ZIuA+sSJsIFTCQ+sZwTB/WhVDAzB/pHUiwcfZRnGouJYWi3Lkuxpipih8TVaPO
 AeygfK3Nngzl6Unwluduvd+4KNWWVJfDrwRzZ5PmB3IFNCuyRnEQSyLbymwcWaQ2b2Cg
 jbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795433314; x=1796038114;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=D6JYfbVzOmCG6tYTaehEtn3ibekVe4GjRe8lJDd16ZU=;
 b=xTGz6e5Ph6aNdP7G8gG1ySMEKYgx5r/UcxVYa0b7UMy1iz7lzNqRmfZgVc5t3SeZ7i
 vJcNhGhZk9XJVCDz5rNzIm1Dgq92SIjRcnwYmYqK/OLBkUOBK54mF9Ne4yMeCEzrY8rS
 GeiYoxWeeU6M4/x5LTbTZ7v5JgdE7yi8Nd4IZMQFk5DKnE/pvr5XxdwFfiriVX4vEFwr
 U7SY6uz2Rnoc0HZUzpmcMT+KjvBAKlrh2Son56uaGNLEneB8Ifeg6Rst8hNvajymBHdg
 jcdIH33Jb36K6/AV5MnqaKszksEL/lTfGzitMSqYskOyhLFZQVKHzDB1VVt7u6fIOuMf
 wpmA==
X-Gm-Message-State: APuU4Z9brOap54Hppt/V+UKzZTjvOEZgy06EKLQE5hwkD1GF+WbzKjbJ
 463Q7tj0udVdEcIBQXxkAG9yMI5G109IJw3ILcWip+XuqmixBMp5ugFrRnt6zJ6VCWCBJxCj/g6
 haaULvK7rUI+VpY0SdIUH24ANe0P/AKeWFQyTtbnoPfvvgQxyLTfw
X-Gm-Gg: AZFdTZeN38jCu2OAbCzGVvBilXhPxEPyq8IqI/XZZnluyBNDa3ZYNzEpyLvIjaCDTXs
 AWhuoi8K1RQXohP3Z1UZ4mIJTdfz7tLtWMl0nggbHT42sXUD1P9pxdKMK0Ib5yqL9lnPrp8Edax
 R488P1iP3YyRiq4/b4atGocoXx2f+zksAiShzHY1ZrL6RxH4+OsjyTAuQfg5MjaFsbXRwiLoFWs
 KcuhMF0pAObHOqXjMRzTO3VZ0b/Tb7GWCXW+h9vDJlqiKNw0XSroGZ0oRX6xmTgozjBSHNye6Ue
 67qz5ri1JWLtTQ0MMYahf5HQNPDAdFxW7UuKObw4lMlH95dOCS867g9A22kDd3z8dK6MROiBvTz
 sd/+fMjtgszWrjOuyyyn/2y7W3Gg8nRq5WVzbogs7w4QdnhtWIoe9kNRqX6E07E+p/bRQjsZ/VM
 0+s2WQxtfWmSHaIchRN4wM3CmnpHtH9oiXgrSu4+A1PLQ=
X-Received: by 2002:a05:690e:1919:b0:67c:1b89:b117 with SMTP id
 956f58d0204a3-67df444fa54mr4956355d50.77.1795433313600; Mon, 23 Nov 2026
 03:28:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113165015.1150646-1-peter.maydell@linaro.org>
In-Reply-To: <20261113165015.1150646-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Nov 2026 11:28:21 +0000
X-Gm-Features: Aa3M54pF30KXZOF89rftrHcDQk5mLTlHewNrDPDkXB0Uoxd2Su_hU3Fh8kjktGk
Message-ID: <CAFEAcA--1GLGf=7tmkzQZ=QRPApLTdsdFskgbSibYPDF0o626w@mail.gmail.com>
Subject: Re: [PATCH] hw/net/rtl8139: Limit DMA transfers to plain memory
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ping -- could I get a reviewed-by for this CVE fix, please?
I can fix up the unnecessary "inline" keyword.

thanks
-- PMM

On Fri, 13 Nov 2026 at 16:50, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> There's no reason for the RTL8139 to be doing a DMA transfer to
> something that isn't memory, and allowing it can cause weird
> re-entrancy problems, such as a DMA to the PCI hot-unplug register
> causing the device to be deleted while it's halfway through doing
> something.
>
> Replace the calls to pci_dma_read() and pci_dma_write() with
> local functions that are identical except that they pass
> a MemTxAttrs that forbids non-memory accesses.
>
> This is the same approach we took to a similar problem with
> the hcd-xhci USB controller in commit 89e653b7736 (but differs
> from what we did for lsi53c895a in commit 4862d2c95104d).
>
> The known trigger for this bug requires that you turned off
> ACPI hotplug on the QEMU commandline with
>   -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off
> so most configurations won't run into it.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 3ada003aee2004d24f2 ("rtl8139: Use PCI DMA stub functions")
> Fixes: CVE-2026-128868
> Reported-by: VictorCHEN <ahchen-yz@outlook.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I'm also wondering whether there's an approach to this class of
> bugs that would avoid us having to modify specific devices to
> insist on DMA-to-memory. It seems a bit dubious that writing to
> the PCI hot-unplug register can cause us to unrealize the plugged
> device even if lots of other things are still holding a reference
> to it. Or else we need to be more specific that you can still
> validly (in the sense of "doesn't break things") do things on or
> as part of an unrealized-but-not-yet-freed device, and move
> things like pci_config_free() from unrealize to deinit.
>
>  hw/net/rtl8139.c | 98 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 60 insertions(+), 38 deletions(-)

