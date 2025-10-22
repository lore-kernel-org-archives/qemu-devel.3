Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6B2CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 14:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBZqr-00068D-Hj; Wed, 22 Oct 2025 10:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBZqp-000681-Uj
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:30:07 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBZqn-0004wV-S3
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:30:07 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-443ac891210so3019310b6e.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761143403; x=1761748203; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h8p/EHYNKbYrSqawNBiJJMNeZGkVjQ0Ny3k+rRgwEFA=;
 b=L48aM+OcHUu/ZG9f0NoguEon2XjJ3zoLmoFENp3NJnQZLZzMfDb/RpqHpsTkGzNRlc
 pBP+R/r9cdPySY2f53LcTwZadBvSwEIbQT/1ikLr9seCEp5YT3z7cty8co0KG75Wrvmx
 yiE3IO9YtIQqr5okIKO6ELWVYrqcCpB9K30XOMUsZMVkBcdjrf14kq8ivaRf8nAV4col
 an8rikKs41DgTwBM3laOrjBFEPcsALo/GQclB6avKT7JXWTRKBttRwZVzyAgT+oRRIHE
 eksmZzhllp3Rk6NQiiQ5sPUe86y5mf3z2IY8wafHMj8CWK5hj17azCo25Dopc5Qw0Aff
 CxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761143403; x=1761748203;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h8p/EHYNKbYrSqawNBiJJMNeZGkVjQ0Ny3k+rRgwEFA=;
 b=TdVLuiBFiBUO6mufJaBEak/p22DhG/ZuqPXuGeUrTSidm1+/Nw0wRLJBxI26zVuB0c
 /UJozAy8JPSEpFqsNw5mrIEtKcMhH/mCz8RfjXq5B2G8DrCbSb/oSYQK8g0qZAcUl/bN
 PuVXlOI8zjSmwOT3WPWyv1f9RFO3D8CYrxEg2pvbVm1a8Njhi7uUkiXTADQ86f6XJCIS
 Cs3ieoCemQPEKv2YlU24j2eBD27VWGhpM3ZVc1yRSaDq3CDHzu7keKw2lsZGGmKYj3YS
 Xv1Tls6jfMz0rPUruj71bh8Byyl02O55FEiW5mzFgwR4YezBLwRNSngm34AgfK6Y8Ep+
 QmEg==
X-Gm-Message-State: AOJu0YwqYGD+2LFW5oLIW5op8cEOOni+dq0tG6qJU91VajDnx94G18i8
 WFa+Nnvj07tzb5pCJUEDL+r+1djR5JzwRRJyTDqMQiVqIz7QvtxFE39vXXfQ2UR8fRTIW/kNhn+
 FClHW
X-Gm-Gg: ASbGnctW9LYAl34hILq1hKiT4xyFJxfALlB6gUjiiYdJVfdH7rvZwP8fzudwykeDXZR
 +FhBqXJ/Ol8kKc8+5g+7KDWK7PNDdqnQz0HmzHhn1Asrh3Mb76JuKN522Mq1lZGXX+fbKPzOGhm
 JOinglnT4EBkTOsjxidGw4Q7JCsbZa6qwdN/WZk6TDIQLXRivBgESJbcoAnRG6vjoxcQk5m72Xs
 epf9AoQB67MG6tNfPQZg4tktjFCNjQbwnSh2Hp5venYpPBBnXeq4tkRAH4Yf6ak+fXYBDA0gph8
 P6N5Lj6QRh+OF+ggtJtqpi3NCq9EGoXFCkjroZ/QK78Deo4S3NeBRjEvRpQdmzabmO/eQbSCIYH
 b5A37du7ZpTKrf60pJtfKRpYNz5QK1iRE0jT7pyulGFhrjWHbkAFO8CqGMs1tIML1C60A93WvyT
 ohLmkFJgDv09pUGxWb
X-Google-Smtp-Source: AGHT+IEs5wbMm9VyqeW89gRjszRx9/OjaVLfIEWelBfwNyP3aid41mUZThMIV1+vlf6HK3jbZoSO9Q==
X-Received: by 2002:a05:6808:1383:b0:441:8f74:f1f with SMTP id
 5614622812f47-443a31aca9dmr8984584b6e.57.1761143403040; 
 Wed, 22 Oct 2025 07:30:03 -0700 (PDT)
Received: from [10.128.41.227] ([50.194.179.134])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-443dd002e30sm3317788b6e.11.2025.10.22.07.30.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 07:30:02 -0700 (PDT)
Message-ID: <827f7a61-a732-4cc9-beb9-2393d9cd2d94@linaro.org>
Date: Wed, 22 Oct 2025 09:29:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] Uefi 20251022 patches
To: qemu-devel@nongnu.org
References: <20251022110027.441780-1-kraxel@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251022110027.441780-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

On 10/22/25 06:00, Gerd Hoffmann wrote:
> The following changes since commit 3c0b42c68f98fb276fa248012642be8cbf2cab70:
> 
>    Merge tag 'pull-request-2025-10-21' ofhttps://gitlab.com/thuth/qemu into staging (2025-10-21 08:59:35 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/kraxel/qemu.git tags/uefi-20251022-pull-request
> 
> for you to fetch changes up to c6c6d854447a7821288e01857d0f7fb28b82cf44:
> 
>    hw/uefi/ovmf-log: add maxsize parameter (2025-10-22 11:32:07 +0200)
> 
> ----------------------------------------------------------------
> uefi: add firmware log monitor commands

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

