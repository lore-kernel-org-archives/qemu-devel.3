Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DE6D0EE18
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0vH-0003l8-E6; Tue, 25 Nov 2025 16:50:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0v7-0003K3-Ly
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:49:57 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0v6-0005Mb-9j
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:49:57 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42b2a0c18caso3737633f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 13:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764107395; x=1764712195; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NhmjSeNyk4wboyLg5d23KJZ5yGkTp1AX2XCgrnSkmF8=;
 b=Mzp3juzJpmRjRCsHr/0WIW5nIPVpoyH/8/Et9lhJhhkzMilZGVPK22oSdwLcjVZdlf
 imlx5ZRbvl4NUeqPLoUQ1Pu2FvE4Dlw3wckLTEbV0czgATEp3+ArvysQhr62yE54ETfd
 FfV6AE/An55Fi3ULVWBqyh4jvgBQn70uGvKHC1ryz6FZyvT9mzMouR2mw12evXqhkSCu
 H5RuQ3dyY6T3ollR5GUXrA4pWG6MK0aLHc/QgTeOyDT6Clq2TaJTCYeHtS2lKZyMBeLq
 ZWVO4QWG3LrQKmUQxg2NHwcBDrIPpaJwyMrg2oTHnM0DUnfnx7vxqzASv2Mgx5Lnae5D
 q5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764107395; x=1764712195;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NhmjSeNyk4wboyLg5d23KJZ5yGkTp1AX2XCgrnSkmF8=;
 b=A1aI/WdiChDZf0soiyTaM+o3M/lFDiYk/cjlPZr+iM02/l7XzXOGh04y95aaszPEET
 Cvr5HDrPcVXi6ynG3mZWdT7OsxqQBb6J0hUUnnMDAd2kEw7HUn82ei+PLHkgpdvvactc
 FT87HfbIPr9qekc3eFMlCyzYFUkAozp4JrnpWL/9Shiu6gl2sBwlsHJMJZiggFozGbR/
 Xi7WQUguOYXmSBpnujz2hVNmakIvuNvZsNPuAi+LMEg5xNO5AIRAdnwirzM5ZxwZHC7W
 wzikMJ7DArOwJ32wV9HhHnjz8wEXG0U2sg5BWGs2GpNol9SL6N+Tf00bKzZ6wMIzjWzl
 wnEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzJ24QVWnf3/D+OMvzHZ/0zm0Tran1momMbgypJ4+/tneR4OK1kPiP1E4wCgbUcjKx99wFeMLHoPCF@nongnu.org
X-Gm-Message-State: AOJu0YzVJqDKvBef3EVM1grtMsmUm+Vk4m8SVl88C2wJ1WZd6csS1PYC
 VHYfwOvcjK/6OyqqNmrKmsbR8KLjgIdcqQFtRpuNs6Gu8wJveDXIz2btADSkhl+nPok=
X-Gm-Gg: ASbGncsobzpKln11CZepF99B/6z9BOGlSzGNBptD0FQO9bIeJ1oWb02Pqh76T3HYFJ/
 NQOsTLOOYPIBlUtEMHjLrRbwkwzfqtib5GV/bWymgePbGdaBCNkY6qUj8cSbVEDF/GzegHu1Vfr
 ypTEDPdLrEvgK8kASGm8gUofQ2io88umsWyIbwGUKdeB3u+mgxqXgAmxGSUaUPq0z3ukrJKm+FP
 DvPlD+Vc5aoYY+GlG1+YJNUXk2/YljTTwJGG4MLL/8bA/YdcPbrMSho/lV/7km4WRVNmKS7dRMY
 db2WUiBzfTYVTcghgsyRSedmSrj7W13EDAmt+cgcEzGpf2YZcRDd6UnVndq8r0xsBy9upIvID69
 YThIhujWXcsUABBs6wTWpyKTKbzqlMTXVVIdnw5ALK2YxMv9UyzV7cXTMQwkNUX2YMhIsvxxMpK
 hxdb1pNAdE+O9MPMzopg8KPAYnlmBOYmDY/1ANeLMJSmj80PPits4fFg==
X-Google-Smtp-Source: AGHT+IEuQt8h5wc42vNwpic8oq4dRT9cyjEX4BG2PFOc5qu4yhmFvIfw+2DI9ZV84z+PylSGLVzKGA==
X-Received: by 2002:a05:6000:2892:b0:42b:3155:21db with SMTP id
 ffacd0b85a97d-42cc1ac9d0cmr17946463f8f.2.1764107394658; 
 Tue, 25 Nov 2025 13:49:54 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8e54sm37477274f8f.40.2025.11.25.13.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 13:49:53 -0800 (PST)
Message-ID: <aadded8e-c8e0-4ed6-af57-708477eea09b@linaro.org>
Date: Tue, 25 Nov 2025 22:49:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] replay: Improve assert in replay_char_read_all_load()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20251124173407.50124-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251124173407.50124-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 24/11/25 18:34, Peter Maydell wrote:
> In replay_char_read_all_load() we get a buffer and size from the
> replay log.  We know the size has to fit an int because of how we
> write the log.  However the way we assert this is wrong: we cast the
> size_t from replay_get_array() to an int and then check that it is
> non-negative.  This misses cases where an over-large size is
> truncated into a positive value by the cast.
> 
> Replace the assertion with checking that the size is in-range
> before doing the cast.
> 
> Coverity complained about the possible overflow: CID 1643440.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   replay/replay-char.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Queued, thanks.

