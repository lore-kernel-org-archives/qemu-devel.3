Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AB7D6ACF4
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 16:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGL5f-0001mA-VP; Wed, 27 Nov 2024 11:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGL5d-0001lh-KG
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 11:40:33 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGL5b-0000tJ-UF
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 11:40:33 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ffc80318c9so34326781fa.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 08:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732725629; x=1733330429; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mDqTUAl6cPKtiPDn5+bd1yqbXjPJYco56pK5q3dNw5k=;
 b=hQGzJWRv4IMNhI78sozwcRp7zY59L1cwzQnOgbBE9M3lW8TTP9QNxLIgTjnzo8ZBXk
 qS69wvS5mhUoAMfWUqAuI9Ndh661KWjF2gqEAnye4FjvGycGnrmGjfo6DYzF/edl8f30
 XO11WhpqkcVT/HYmrvdXmOI00C1D2LIrdmOi+sf3+PjGY2575pvxA3YNNZ+OC8/8yu91
 7mo1JCoQ2vW1gvq7lQDjOGlZ1nCh+zDy+0ZvbD6X1VtdsLYSHAj+Yec5mNWQ+TCqztYR
 24bssdQZo7aC7z4CEEUvq5qnnGNIj353L8yZL/E5EjAYJGNQioVUKXpDzTh2jtCsuHMs
 0SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732725629; x=1733330429;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mDqTUAl6cPKtiPDn5+bd1yqbXjPJYco56pK5q3dNw5k=;
 b=RBMjPuYRhHnpbBxFgjFDiqD77tPyQG6/FsK7xLK/YIYlhCB22Lj1FGJmwCQVtxHb4E
 yjrSba3HW45+cqiY9vOOaZIzaBJSLy3zxwkIHECpx4mxtcOOMZ/VXcRDL9nq9p7dFB1J
 x6ViS2nXKtaeHtwKy4Cz7gZ5279DBiGiAZN1dPvy4P9t4Vn7wUfmC91NjAUVYvsuE1JB
 st6EAMi3iG6E8FIvbastZ7ULHtKjd8dV2YEIK3xGVzeCkEJFxhIT0JArb+9i22uSvpfC
 ryoxi8ipvkmDhvnaMXQFtaKIbucQaVi23J56W7Ry9+Pd9bh0CQIMznOxq9dIS+6ZRbmb
 z0cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgXKLiocsD2lO3hmEdPueV7MFGnF3U4vc7fA6ncFT0z8oga1Zc1ZkCMM5cvmaiEgo2wQnCvDmB1uH5@nongnu.org
X-Gm-Message-State: AOJu0YzuPXlDB/iZmiq/w0Ja3qu+ssX0B1xAN7feHDTHy2idQ3WhDHwY
 7B80IInNk1/1hZcgT4ji1y4caYFW69E7baTirtwXow8bkd7wMgid7pPVtz8LSdI=
X-Gm-Gg: ASbGncsjmxC4Eeu5M/cNc4Ooy6gKltsKPdrHCk6kzw1QTzp6/hJEAIFDpZLAdAL98it
 7Te547U/NoXmBuFQnqgBqglcwheg4JutsMydahQmNE15b2Y9EOoPhm6dIzYgeqJxd3/xTwubbwK
 lV2STJ5mP3ZAvZjejkHvXFUDihjHgS36WKmVTUPV4i+6lP3eaBkVSNKQ/Jwl51ebH2Rk6SDdsCe
 YY8lJDPiQj+5uIRtlQk1SY05axOKOfqQmOJp4mkVMvbJNFmO2KyuMICzyoQnxsugLhE
X-Google-Smtp-Source: AGHT+IGx4x0r8Hl52uqemq1507xpfu7UfB0aKCQ6LOLM3zduComOMLn0JhdNqkeOGzjfC1wiTptZgQ==
X-Received: by 2002:a2e:be90:0:b0:2ff:8e14:30a6 with SMTP id
 38308e7fff4ca-2ffd604a593mr23733911fa.2.1732725629564; 
 Wed, 27 Nov 2024 08:40:29 -0800 (PST)
Received: from [192.168.170.227] ([91.223.100.71])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ffd777bd3dsm2179351fa.0.2024.11.27.08.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 08:40:28 -0800 (PST)
Message-ID: <d83432c4-b699-4cc6-8a01-a278fa0ee4d0@linaro.org>
Date: Wed, 27 Nov 2024 10:40:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 3/6] accel/tcg: Rename TCGCPUOps::initialize() as
 initialize_once()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20241127121658.88966-1-philmd@linaro.org>
 <20241127121658.88966-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241127121658.88966-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x235.google.com
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

On 11/27/24 06:16, Philippe Mathieu-Daudé wrote:
> While this handler can be called multiple times, it will
> only be run once. Clarify by renaming the handler name.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> We could "optimize" TGC frontends memory use by passing
> a CPUClass argument, and each initialize() call would
> initialize TCG registers required for a particular CPUClass
> which are not yet initialized by previous calls. Not
> a priority / worth it.
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

