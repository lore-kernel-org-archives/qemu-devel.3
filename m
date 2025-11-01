Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D90CCFA04
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 08:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vF76L-0002gu-QW; Sat, 01 Nov 2025 04:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF76J-0002ge-F6
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 04:36:43 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF76H-0004Tp-8d
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 04:36:43 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64074f01a6eso4080825a12.2
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 01:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761986199; x=1762590999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jpsYbj8M23Mw415zBlmaId0EsXI8jl2vQ4GI9R14BQ4=;
 b=oxCIjOdM9Cx+r0K/7IfAFIpopjvMWOT+YPSH/ZIuiPNuxv8bySMCmQ3L8+YnrfFbzY
 I8mXaXihc/ZZe0KAZIbS5L/fGnft3Dg6SE0uOLwX43PdjOHsi9KjxRvLsRDaEROAo4w3
 FL4oeoi8A3r4JXwF0K9OM2hDX1CKboRkVqdZ6m1YcmCLjyubrn35a1PGooIcLejr0fnG
 d/tBPGX57g+WLCduJiJaJP0c2bwMYddzh718rQWDZWf+sz4jc2vka/FLU7en3G5SXwFH
 MKiiWpBDzAQJ1/Um0cioZ1RzDOhMDGFEtMuBFtGLRVQbWAWgowJ1+Yt2/Y2U0wScmS5z
 i63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761986199; x=1762590999;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jpsYbj8M23Mw415zBlmaId0EsXI8jl2vQ4GI9R14BQ4=;
 b=FjAqx6e6iAcbqtA8ytHQSr7ZXwMHJRmbwdO8TlSOgXyn0/XDYmJZ9oK1n+JTOiAzRg
 51XQo7CMYDcafRrJAGQmVxvI2yoSww+naa4X3ecx6BIkcnfL4ObL/gI3QhBv1x80emgL
 LsRHgO3XMHhfAnWNn47bDXDti0/uQH0VpsDL6EPr2Esg1/cianaPxQAZjxL46IMvFfWc
 QO1EWI9OmDIYlJCXHRNOUhJhjRKpFadr/dRcJKotuPSSDVVOckljrw/K4LocSKvqRNt+
 XEayOEMGCw+vfFtu+vaBS0qCImQOoRk/GVQw5wyJV1iRKIIEIWz5BXcasi1q3GfMm21m
 F+Lg==
X-Gm-Message-State: AOJu0YynnMGigJHHtsj5oL3ANynngGPEGeXodklyFjgyLuIODgt7ECSq
 25q/VWkutc6DpB8oixbjA5Yrb1lfXnIZP5W9czOcymrFmxVfsnsrcasyMXJgqsnMYItAEFX/yOr
 CyZBePPQ=
X-Gm-Gg: ASbGnctO5ISeUriYuqTMwOfmYwXckip/G8EiW8Ju0dqqhbFeTXUw400A2hoW39fqaYi
 2z7ZyLcMb+QtFBUdjm67z/IZK9fsvAuLbVT4GvHaRtQ3bhNdU3xUwWRkQIffxXegHriwDo52yjp
 xiqbC1h66hRNquhS5LduAO3BYHx1d4SPZwRjzb4gwHp0hwGIKtKMp2+6b1P84FXBECkXN96QzPZ
 vDvXY0q5hyVy/qehjWxqTuIP1f1vkgP8TnIRhyHlAxkah7Sh3qgTYiAEWRST10iyHhJbmfBHYuO
 ZUrsdmuc363aMnuxdgfOu+oyaKRvMS5Z0DAV/Pcdw9pD8yKHe4o7tUarwEyZbZOjqxnd0V0IcrH
 /rdFME9jpUjo/qpDaeLa33LKa9HOXdqoKZRHSZ6syy1pTUDFheM8b7q4yE5u4NI9QvAIb7khV3S
 Ztd3UMAWqBhXneHJU/aE4YgdqM0nUU2UwoCSk0u1x3DoksvrGopTwCVDTou9165uY282X6sikJ
X-Google-Smtp-Source: AGHT+IEMI+TCIVa4Ye5zHnCm+hUMDfgpCKoJMXhUmWYm3qrBLQT7l0X6hAbz72VqLlMHtGbQytKcUQ==
X-Received: by 2002:a17:906:fd87:b0:b6d:6a35:9996 with SMTP id
 a640c23a62f3a-b707085cb9dmr666838166b.58.1761986198700; 
 Sat, 01 Nov 2025 01:36:38 -0700 (PDT)
Received: from [10.240.88.227] (C3239BBB.static.ziggozakelijk.nl.
 [195.35.155.187]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077d03087sm392612466b.68.2025.11.01.01.36.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Nov 2025 01:36:38 -0700 (PDT)
Message-ID: <bc08ce52-e8b6-4b88-b2f7-87b167f67080@linaro.org>
Date: Sat, 1 Nov 2025 09:36:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] nvme queue
To: qemu-devel@nongnu.org
References: <20251030072956.1194-1-its@irrelevant.dk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251030072956.1194-1-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x533.google.com
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

On 10/30/25 08:29, Klaus Jensen wrote:
> From: Klaus Jensen<k.jensen@samsung.com>
> 
> Hi,
> 
> The following changes since commit e090e0312dc9030d94e38e3d98a88718d3561e4e:
> 
>    Merge tag 'pull-trivial-patches' ofhttps://gitlab.com/mjt0k/qemu into staging (2025-10-29 10:44:15 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20251030
> 
> for you to fetch changes up to bce51b83709b548fbecbe64acd65225587c5b803:
> 
>    hw/nvme: add atomic boundary support (2025-10-30 07:07:14 +0100)
> 
> ----------------------------------------------------------------
> nvme queue

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

