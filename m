Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20D7EE57D1
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 07:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaqiW-0007M1-RK; Wed, 31 Dec 2025 02:34:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vaqiV-0007Lh-CT
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:33:59 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vaqiT-00013O-RD
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:33:59 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-29f102b013fso132388205ad.2
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 23:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767166436; x=1767771236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BkHk1QVzb3tbKIZlMjEoJAE/AEu1rbaQ6m2/1UcHmns=;
 b=j/CjgYJ7D5GcfaTylDhYEwM4a070Esi5eQybjjEbWFDa45e7sFDfmOS6Qd1Vx3rWrG
 IbiPxYJP2d2gCHqOl8ko2ZzqapDNxXLZLYajIfQCxUdTsF+X0muUqTYyVwAG2McBvUuo
 MWeEFUmotJEk1Slq2koVoPmtopWdhHeEhOrrvTe3nk6kMSDhgHVM5Nuvj34YwpHemXB1
 /xjZQhvmCp5+QuqvGUhBnnD3fKCUdQrFTsDkFLpe5kzM3X4PLqo9x7cKaNmOZMH5PQ+u
 DT9plDIEYGsnPXy+mawFOz2zkFPJ7jQKCu5KkVE3NrdBMu6Wu2v4sN32uyg/Ox10l8dJ
 9kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767166436; x=1767771236;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BkHk1QVzb3tbKIZlMjEoJAE/AEu1rbaQ6m2/1UcHmns=;
 b=tLoPS4X8BfohW6pyYvqoW01Tk/891JwCIO5BQqFPY5FuB5dxnFnNV1MTPQxvac5vpt
 24IJJ97ir8J/5QxOGksTG2emEaqtxOy5Yz0R5O65bAO1cQJyRuqB2SLJ0xym3QcqD9Yx
 R1Bk1lNq46kNslw1bmIuttwD8yMnT44wr/iyRV9DXEhM5zcUUOtJsTUcxlgtwzQs9Vxd
 H0HVRwSevCi6TEGoLTSQKHJdPW7ZEnZEOWrcYI6Zb4ppy5qt7da057lv07OPfBA3oh3J
 X7vFqILmXKLowLk0KZdMujWmC4ZR0ZYtpCNiQ3skF1sXQJ+jPdRO2M/sJGJ/mLKztOQ9
 Qbng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUsDD8SmEs95/Jfdw7BwKN7Zm65gDWQ3fH6xQgj5xCXaHQpoxk543bjePNFXYZGYYiqinehvMQwWBH@nongnu.org
X-Gm-Message-State: AOJu0Yx0JeKI2QFPu3FZm6qpK0led8ChaugolWvgukLnjKh5nJaxIXrr
 WIT2m2hxrtDApUF9H2jPtBdGzUUyr/WQLGTBVZse55sM+2gIqBMZAlOZ3QOeiqTA1FE=
X-Gm-Gg: AY/fxX7gzLUNm+P5TAqA9c2jXb90mjYk1zTKEmiwMudK4uF9KyW1Fz9BP6yPbo/lOwP
 h0yRORYH2tmoTljO3Ne13aj4kmhif3rtTiM16JD5OHjO5NWCTuNcEDfWFklPLne7+NNPFXqdF/U
 qyXHQqjFz6khwTSeGsC6lZhjHNWfY5f/hUXfXEm7ifsO+ZLkdrpODaFuVbvSiu1hQAKNSNS/Wf6
 SC/PhnElYBQ6gslW4d4ma0pzO4eXCHElrekOsD6jNycBGrbBGJ3CJJmhvwNl0WOYkCiG3hSNubU
 YbDK4QNgPtCbNRdDKKLJwHtLVJT8ftreLLoOr3O3f7YRk9tugJkoz6mDz8rdxB2o1+9LyZII/nw
 hvHS4t46TdNxxAwi8tl1H3whk4ke417OS/KaygbyiTtpsk9u+RjIDid70f8+r3FPSCqnHZBJsNf
 Nk27yBtJH9Xp14WbMA37fT3rbPzLFOrA==
X-Google-Smtp-Source: AGHT+IHcUgSGbpkBzH2iK73JmvL/JOtkeM6ZWDrkdl8rfltJ/XALlMDuLs5E5zPhsWRYj1IZTqbEDQ==
X-Received: by 2002:a17:902:cccf:b0:2a1:2ebc:e631 with SMTP id
 d9443c01a7336-2a2f2425783mr353189765ad.24.1767166435665; 
 Tue, 30 Dec 2025 23:33:55 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c66634sm321255915ad.12.2025.12.30.23.33.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Dec 2025 23:33:55 -0800 (PST)
Message-ID: <1590d29c-d959-4978-b0b4-608e468c3f55@linaro.org>
Date: Wed, 31 Dec 2025 18:33:51 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/34] Misc HW patches for 2025-12-30
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251230210757.13803-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/31/25 08:07, Philippe Mathieu-Daudé wrote:
> The following changes since commit 942b0d378a1de9649085ad6db5306d5b8cef3591:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2025-12-29 09:10:40 +1100)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20251230
> 
> for you to fetch changes up to 4bd2b65e524836fef274fd169db804a2efce8836:
> 
>    MAINTAINERS: Change email and status of TriCore (2025-12-30 20:38:41 +0100)
> 
> ----------------------------------------------------------------
> Misc HW patches
> 
> - Remove few target_ulong uses
> - Make human monitor non-target specific
> - Better name for TrustZone Peripheral Protection Controller memory regions
> - Do not expose DEVICE_NATIVE_ENDIAN on Rust
> - Remove address_space_stl_notdirty() and stl_phys_notdirty()
> - Allow to restrict targets to legacy ldst_phys() API
> - Fix MinGW-w64 link failure due to ConvertStringToBSTR()
> - Header cleanups
> - MAINTAINERS updates
> ----------------------------------------------------------------


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

