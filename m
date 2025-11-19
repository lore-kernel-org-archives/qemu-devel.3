Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F92CF34D3
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 15:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLkF4-0004Qo-FK; Wed, 19 Nov 2025 10:37:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLkF2-0004Qb-IM
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 10:37:08 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLkF0-0000CC-Vu
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 10:37:08 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-477a219db05so25746195e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 07:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763566625; x=1764171425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EhCXmAvrI6zItIMik5WXJbc/5iyh9/pVwds9c0e5SAc=;
 b=ucHzK1Oc+j1Zg0wEW7djshBqfbR8UfRofaowmlNRyO9JbC8ipgmRH37bFRIbdPCh28
 IYDf73Gce2KejXHp9bwldOac4tEfHynwD9A6b0UQu9xkDHDJI5VrgiIaPysDn8Wc0+Ef
 P2g8duFQABZLHmUYmp0RFRP9vL0S71tI8z1Rb4OusnZPU/PQSwlATAnmKIXbt73CN/AG
 4XYq75zFGBZnVhRXMY+Q7BvSTEQz29zFYAtlrL7T8SVU5lbIj1ox/S+lywYwv0lTLCkc
 DJGUHyDUGIXxdOChBtOtsgqQzibCTw4Zq/wc4eqJsOr9KaCd+DOCbrbqptX8Q46z9UwS
 HMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763566625; x=1764171425;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EhCXmAvrI6zItIMik5WXJbc/5iyh9/pVwds9c0e5SAc=;
 b=tBVzx1eGxZ1tyHSnLvuf/0Ce5YKIuptPq1nyBkExe7kOAUwhgoTahGT9/6qimE2+/o
 h2wPeOBKMFEaljRJcL/RqKpJ5EsS2Qv+oX5iP1BngCGaJ52N59OONaOyJQc1X6YrHti+
 V0IllzSbGcv+LHSc5pB4D+Ep8Y+OMHGTnJnSAjYzztKS3zPK+Gtbh1+UpwrSA5dPC6l1
 eVaTiGHBBz+Sn3HKO/g1jIUQe4ZtiP46wsTYqRzI3DRJftqM7XRBaaa2Iooh1dBTMQfL
 l86B5G5OWNCmDBzweWOkxAWswcL1kYK/0BTmWn5fInPJB9licUdG3963lS/NATOl/v2h
 Nf4g==
X-Gm-Message-State: AOJu0Yz6fIWz38YhAVp16hM0UP8ccQmfOnb8ylEum1BdhTq02A6AvC0I
 utH7jdv5yiv2+YFZqFv5JySKSfdux7IgPdFX/Q0/E2DezAt3LbgNXUx5uO9YCzOTkREZCvxyD7g
 /tK4PPiQ=
X-Gm-Gg: ASbGncsKUNTDofRyPvBiTRblWwhazzTcaIcENcSejelpDTgbkLHt2rHeYJLhgNGVUQW
 Ue7m4DEUosJmqXAPh85xuXIR4JDZdyG9uw2QDMlPR+UgfybiO96ujhWaUHu3BXaEcFBQnD9QTVt
 ikCp9W2rXTT7BYYF0RKj5ud6qQ7hu16LPfUdj+RsDqSpZJyDLjlJJ4HQIVJwwortaKGgy1Fvyfo
 CzE2qLI+vACQOZDcJN3P/PJVo3qYp/ixS2KmK3kIFOW6iiM/OMWppXDnApj3M2vP6te5RZ+cMAv
 iq8lvhJvCfsqcUyWYL5+lbwAMD9LQgNCdoZPqeQaaRGITmGdRuVI8FTvh4WK4jGu1oEy56+wABy
 wQj/8wCU83qAbKqx2xRqPknO6/uSjJm2By38UVZlWvFWxVQR8Dl865NqHqeJpnFCtiyBkikrm6d
 V9ooORoZlVtHKlhUzFLE7px83PRwiL15asM2owKgOZIyTD4gyT88lXUnag9OBt7sf+6Z4=
X-Google-Smtp-Source: AGHT+IFcbb+bgb6Rs/Q3orn1wimBP/hnxCahwUvDbdKLCBd9SPuijKy9FbRc1bNRf6X3vBfoqX/O0w==
X-Received: by 2002:a05:6000:4284:b0:42b:3cc6:a4d7 with SMTP id
 ffacd0b85a97d-42b593742f2mr18347562f8f.37.1763566624809; 
 Wed, 19 Nov 2025 07:37:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ed5:b1f0:6d32:aed8:c0be:1d44?
 ([2a01:e0a:ed5:b1f0:6d32:aed8:c0be:1d44])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7b12asm38265793f8f.10.2025.11.19.07.37.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 07:37:04 -0800 (PST)
Message-ID: <4eeaaf87-187d-4ad5-87de-68f88f65925b@linaro.org>
Date: Wed, 19 Nov 2025 16:37:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/core/loader: Make load_elf_hdr() return bool,
 simplify caller
To: qemu-devel@nongnu.org
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-2-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251119130855.105479-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

On 11/19/25 14:08, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster<armbru@redhat.com>
> ---
>   include/hw/loader.h |  4 +++-
>   hw/arm/boot.c       |  6 +-----
>   hw/core/loader.c    |  8 ++++++--
>   hw/riscv/spike.c    | 10 +---------
>   4 files changed, 11 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

