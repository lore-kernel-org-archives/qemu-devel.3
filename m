Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8D8CD6E55
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTo5S-00055G-Nb; Sun, 31 May 2026 17:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTo5O-000550-Bn
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:52:46 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTo5M-0002LH-Qr
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:52:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490a7a34493so4420315e9.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 14:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780264363; x=1780869163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6D1V+0X1qVdm3MpL4vmOI+0Xf4qHvs6Dml/aEzUvYoU=;
 b=v9ZY0PlDdyMvM+7dfsP8CHmmJzyskB/QurpeRaN92YMUv6MoFdPUxhhKhngoOL+fkb
 404ILLf7GLwQ0dI7ZvNdmWsLammEI0bi+MqVMbtxqhm8x9ht39p7we0I0Yv4rkxX2dNz
 v35HOSJ4m8X91vFFDSKtafGtPKW961pimR01K/yQAJrkXcrTy8xlnw0hmr8HpeZkx2rd
 H/hWJ3hNbil6045ri834xqWde8tTN09QbxUlHmAZF12hlMGnaJFdPWfKDbYKrnqCa5fh
 RLDeKuPLC2SHixsUeQiZGwbs9DMxcbOFuEiHZ8mYapT1BnzyFXzljWyqozpK4zZXWSFH
 6tBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780264363; x=1780869163;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6D1V+0X1qVdm3MpL4vmOI+0Xf4qHvs6Dml/aEzUvYoU=;
 b=KyOSqbYO5OSMNFOo97ciOQoRREeZWW17n9+PaDKFswGzEXLSavtPRODbrSR9ICcnZ6
 dzPJLvtxDKzLCVyyEFNpZIMK9uWFYjiXI0IaIDHiS/IsvMzKvxDiMiPRssiDST/eU5Zr
 wrCs+gcmhonyd8K1egLkHNLIxqn3H54C606ZdraFe2LZLboiUoHgIgspFIas7BR6n6Pe
 UZI49v5gPrr/oS4f5DATAPC7rJ/k4Z8Ws5U1oCEndNdlg8wKh8XiVBBuyeyQ6073Jk50
 FCn3o2JooukTn8gJ8elSscnVpy8XEW7I5//P6gbifNEjW6tPyZYSFOUxsEbypxjiGjp8
 dpDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gg2Q6uLiOWlQ6wRyrn5LaKdqVY3AmdVXLfyXxH5f9ENigy7ErsBj8AL9OKnp7hTDT1R6qrwtJcx88@nongnu.org
X-Gm-Message-State: AOJu0Yw+AJnj6vp6NDeDgEkmMNm1csu41IEt4Hawnnjnt+Pp026Zxg8z
 OX6yttu/lUepTm3EbdlrWX1aE3Bu3qzTB4PiRWwzQv7NcXB0rEmPomMpd9CbX+mkDb4=
X-Gm-Gg: Acq92OHsJznmGzCH8zXrDPeAIFFf6k3MdHJNkYu/fkdPfP+M+fVYr75IeLNJbeOaW8w
 jjiyV7MUnAuXRzlC17pIm2gMsDiChvd+vf9DDIpHnF6f2J115nhqIHXq8XBVvKNwDF36CygQIpw
 8i3sGDYiz2LGykfd61DdzIcgeENV2qPH2UBORkOJWSJyoPsqwM0KiA+eN15lclWQ6m4Dar5kdFM
 WMQDqxP5APRsUsOKJa3vy/enc+TXYaYyqgkz2XeBmJKjmIaA96SUiLoN/jjAiKjsv+gpfFzeOrY
 +XWEzzc3QWAD0fXHmXJzOvZTlzDJbc7UbMSdlpbLD9lrHWrQcPt1o5rzae8FLX5PAMaif3ww4T0
 xVa9Z4oIcLOkrzXbu9NNHmoN3wy9iMm0wHg5TUgQh2x4qQE7Zd3HaV2dJOZm30MX+uxy9vassPE
 DJxAR+EFKXQ6wL6jREc1KsG7pIqUM1egkb81y1qtyxpe3xmwskRiSYEKVZhINLs8MB2FdtEctRe
 7d7
X-Received: by 2002:a05:600c:4753:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-490a2a79df1mr119611575e9.16.1780264363235; 
 Sun, 31 May 2026 14:52:43 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6a0e42sm199185945e9.8.2026.05.31.14.52.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:52:42 -0700 (PDT)
Message-ID: <fda27c32-af6b-4995-9d18-82b64b7bc895@linaro.org>
Date: Sun, 31 May 2026 23:52:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] common-user: Move selfmap from util
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, deller@gmx.de
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260530211248.375318-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 30/5/26 23:12, Richard Henderson wrote:
> This interface is only used for user-only.  It's more usefully
> placed within common-user than util.  Temporarily add stub
> implementation for bsd-user.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/{qemu => user}/selfmap.h | 0
>   {util => common-user}/selfmap.c  | 6 +++++-
>   linux-user/elfload.c             | 2 +-
>   linux-user/syscall.c             | 2 +-
>   common-user/meson.build          | 1 +
>   util/meson.build                 | 4 ----
>   6 files changed, 8 insertions(+), 7 deletions(-)
>   rename include/{qemu => user}/selfmap.h (100%)
>   rename {util => common-user}/selfmap.c (97%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

