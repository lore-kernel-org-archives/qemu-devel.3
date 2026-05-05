Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBEAFF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 14:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKH7E-0008KH-GG; Tue, 05 May 2026 10:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKH7D-0008K1-1C
 for qemu-devel@nongnu.org; Tue, 05 May 2026 10:51:15 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKH7B-0001g2-ID
 for qemu-devel@nongnu.org; Tue, 05 May 2026 10:51:14 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-65890a6ca20so4832126d50.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 07:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777992672; cv=none;
 d=google.com; s=arc-20240605;
 b=TpCtvt5TnBJvMoAXM58dNWTDNpIpKKiaHbRNSgwIyYptWbq2/WOVYiJWapC7Ndqz8Q
 OvTh4o08x8ZEOE2Wa1OQ23EluZ26NLHu46p/dxGvjYi/x4JnHW6N10LkEK5/GgxgfbJM
 WCWzYFr9WYOXghfeAiPfMeCChwNDdUDyL20ldfmv1h9vBatQamfGSVlxo4EFLXBAbWgV
 UXxrGjUoACEUrxA00TxXKRLOxEuE4DS/AFJUEIheeCO646/zXXtD9WMAL1/JKGPwQLSu
 moYhfIQslwCIZr9OSnnOTUqx/BOrahLggP5H/oeV3QDyiHMpZ8jt4FpYkVwzn7qu9+Ro
 Mrcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rVoDHb9pCK8ndmf3WABbxQ0WhWHxckb5sBv3pxN+5Gs=;
 fh=GOP80JPN2l2ZporM1TCZUZhADnVpgyZ7R005tMMGOXk=;
 b=EbNzkW+m+Qwkv036TgBiaVWnVY+CAvS6+Xc1ZXu07tyhS+gUQHTzManjPIUbGIISV9
 FCDqTv0iiv6l4b6Wg6gfGKdmO+y7S+/Apn+Er09m67TKfg7MG9lgKQmwhbkI6Fvxwt5y
 H122jvXai5UtlyZ0YAMYTpznc6xC5Mt99SUN7uMiJTu7VEzqrJj2mE7iwZ5SUYsh9uyG
 SLHhpBW/d46UCXocDFX/k1pg7PPWhZ+9lFKh17DaHKRFRUw6XZU3XFt7L9uVq9ACcefr
 KaDXBU8qropoAc68Z7/CCDEUnLzcF9/ebfOZq0dh88jVt0GStY//d3f186a+EtHmAQby
 nl7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777992672; x=1778597472; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rVoDHb9pCK8ndmf3WABbxQ0WhWHxckb5sBv3pxN+5Gs=;
 b=dzsQMcop+Td3XZhcf+CyOBvHVnekxJrMm/xsK69xH+navaL2MC1/0MbPiaZvKQq45c
 7OyycZLzsjv7uQYubEeffE1u/omhVo4gXfKyM+FtK1nvrWOp6kdTqwbtwY35KiUj+rNK
 ZcllISq6AS4ursbQ6BaDl7uoTfU5WdQ68Lb+HVeQD3wdMmbgE9PwCs8SJcA0vQthElRY
 6n8rF2YQGcLZXfx3EA3/fgwsn4NIlXagoHrHdbHFxF35dv9sfBQsAjTxbYoTLgfO9bla
 x1PLj3OTt3wvfIzd8J0Znspe/MIs6hzSOQJ1Jef9XuTSEaE6NU64bAVnA4u4AvXLUcld
 wsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777992672; x=1778597472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVoDHb9pCK8ndmf3WABbxQ0WhWHxckb5sBv3pxN+5Gs=;
 b=HC9IzE+QswSBe5hMDR5Bw0xZKWJi0BNxBk2bVvFZ97AYCM0ByLmMUQLPB5x0zLh3af
 5+FmL5YiWl+mlQnI/y1KEwItrST94PBiwsFEYLOATYSPPqp+96f3Rg69pmp9cgKhY3ez
 FfEGe1cr6N9OSsp78hLoxjpNl/wrHPDl0nNX/QLojKuHXBiEmpgBiacakYojOaxUMDtK
 8OYUUC8ZxiEuKYUUShChGDbZsNd30IWTqMY+XiwjT8D46IL581+A/9NKfiuNggn872m+
 5BPnsgrmYB0sZF3vAvwdtz4P3ZmXr0cXdN+dANblSXJDUlUJNiD7YfGY0qIS76hWTk1Y
 Gnhw==
X-Gm-Message-State: AOJu0YwqQNyULchUyRG9m1l6NKpdXGX4yqgPJBsIK66SK7MBx1xWUGgl
 uwfPa/A+n2iRl/BJ+/JcDycI/sp/zfj5LaKTXNuH48vnSShqVNpOPOpOWbCdV7+PVV9HQwEKQOl
 RhXYM91KFHXhbAKWFN3DfVw6mfjUF8qvnwU31QzmgHg==
X-Gm-Gg: AeBDiev7cJL6EZKGexFLvzF9Y0tusM6/CGvjlFsFyIEgGK9eh4sqFepMrNEbOLTqxWS
 3jnIMoWvjzTxWEWE76D5foBdOrIcTbKqiE9Kag5xmd8OE7BTmlGzRGatk7vJ2beDNKUYmHDaQSe
 9VPZ29o6yCSSXa3oYJHwJmqFT0yI23do/Tjc9GVIdNWrkUEKFU0DHWNWKHuje/CYW31LazVjT1M
 +EUeoeOvlKDP7KXhbnJvKqkj+JJaQ683inKhKli9Y94WXscv9e4d0O1nkw1y/avmUzjMM9fr4vM
 dH6aU0d5NhVMrZzwsFsEf4QLKPX27TXZOXHSynWjjNbDhNadxvBCSOy9l+G0pv6vuluuJqowYp5
 3rg==
X-Received: by 2002:a05:690e:11c7:b0:657:4633:b67e with SMTP id
 956f58d0204a3-65c3db7a8bemr14099133d50.46.1777992671738; Tue, 05 May 2026
 07:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAM5Ud7OgnsygAHxjGEO-qo5+3zYiAQFN85D2bx1Wb62vK2hzRw@mail.gmail.com>
In-Reply-To: <CAM5Ud7OgnsygAHxjGEO-qo5+3zYiAQFN85D2bx1Wb62vK2hzRw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2026 15:50:59 +0100
X-Gm-Features: AVHnY4IUoNqDNi9brW4GfPIVpXpGcnLMb6knq5CLpv2vAfNob6H_EJZ9f9vDbt0
Message-ID: <CAFEAcA-SAvi7uXOqS06Ai2cKXJ8pUeZYzWxi3WbhUsKMbhKi0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] raspi4b: Disable L2 cache
To: Alec Ari <neotheuser@gmail.com>
Cc: qemu-devel@nongnu.org
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 24 Apr 2026 at 01:44, Alec Ari <neotheuser@gmail.com> wrote:
>
> From c5eabff997cf2231326c532c2cbc51fa1334fb9b Mon Sep 17 00:00:00 2001
> From: Alec Ari <neotheuser@ymail.com>
> Date: Thu, 23 Apr 2026 16:42:06 -0500
> Subject: raspi4b: Disable L2 cache
>
> L2 cache is not implemented yet, this patch requires
> `clk_ignore_unused` to be set in the kernel cli.
>
> Now able to boot a 7.0 mainline kernel.

To check I understand correctly, to boot a 7.0 kernel you
need both of:
 (1) this patch applied
 (2) the "clk_ignore_unused" argument to be added to
     the kernel command line

and it won't boot with just this patch alone?

thanks
-- PMM

