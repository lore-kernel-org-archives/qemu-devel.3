Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94371EE6B60
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTVn-0003cw-8L; Fri, 06 Feb 2026 16:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTVj-0003Xg-Ke
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:37:09 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTVh-0008Uy-9u
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:37:06 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so12575515e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770413823; x=1771018623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LyJMYrVY4LYHTkG1e3IvX5Jf230iOX4wEQKcGylp35c=;
 b=qEnNBZlTQvgUX5GnbmZ2MxzO923FgfnRoD2bmtkChkynBsl8W1G+2ybUNKVi/0FZqb
 tJcTVHjEzs0wcvuYV3St+RaxSaITNZUbdeKZMOzYg4suAamGt5zvR8b/JkVsRomO6kuO
 Vb0Ypqx30emtlkZkpRzqjFcFj5lV83DPqYle0JEDgYLDUz+7sJ8Kk06HQi4hB8C5utqY
 isoocPWpyTJ3spS8oFJs1iUKI0LTnSveyosW/xYidblhIJY6LdJxZBnIePik1KvVTq5h
 ZlzAdSfU7gEXhrhV0/17j8FENMkt2bMrDXtEP0GsPhXmecQGWfrKCIl/keOydLrUzKt3
 0vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770413823; x=1771018623;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LyJMYrVY4LYHTkG1e3IvX5Jf230iOX4wEQKcGylp35c=;
 b=LDCg7j562dZv73P9z2FzAa1F/qNRFkbHXVaa4kbQfxyViqdULawV5InmahBYo4nFA7
 dMRNVbthSPcZZBaV875z6wQenpD3cCZQ889tMEw+7UL2ZP79rTBiHRqw6eo/mKbvSZPO
 GoGGZVOgUmvlxDybDP2mZLvmQAwnEMvELM9AGTfRP7bRg61iOSn9Qokw+ZRFK80ZMzib
 1/HknNiWD8f36lbO21Gkhtki2lWt04N/IC55l5Mnpo2Epnav0F3LZZ71kf7mPfswSLV8
 MAha4VNb8iFcXLxTLa4F2FYQ5XheZcEaUUuhgRNMMWVL+957l243Jr9aXG3027s8dQDx
 YeJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwcU4+/NC/QAFWS8goi5wfNl/a581efibngI+ihxF/HLbeay6o9iobiparRNw8msKSKeyyk++kzN72@nongnu.org
X-Gm-Message-State: AOJu0YwK2aJLm/G1zXvI5Ac/sgfjmvrIKtZxtvYG5T7YEGSsopOmMAUA
 4MO5Gv9qrD8ialgOMEU0VpBgwtQeJ7H3IZe1u3zH4gI5v3LWvSAyJsxtWXfxABWvnCw=
X-Gm-Gg: AZuq6aKm9EDrZHosu/MxN3dB3vnKYIaBCrbI2r5HRgw31b4c6il9iQeAlkop2RwZKtU
 ZBlwWSQNrYulRYh6Ky+sTAiwQwzR897wKGSKmYfyzbGjv+W8kVS1aWpLFJp6vFh48xqTL84vZ5T
 tK32Dcfv4Rk/5ivTQiG1SFYLleL52xcR0P3xQpklbp6eXCw4KrbOG+jnOPBF6QQtrpcfDqxSWPI
 scLSNJbp2G4Xfzsk09MQ0ZFJAEpq0YQy1mNqDgL9yeCNwVgLw061W43WPmRfM4KIIXJBNKa95E4
 faSRtj76r38YO4czH7iyevMUH/ScPhTx418Y+In/CXtDEow+GMWup/dZ40cWnP2RZK9d2bo19HG
 NIx0n6poBeYThPLXOwLz4HwvZdL75wGmZn8I41+sfDHzAA6BkThS392bLcNwiT1Dm3KWEXRUKuP
 2w3VZwxWYc1Nxla7NYmnc0kUE/KW+N4mDcgvX5JQMHZU/+RGtx3N3rhg==
X-Received: by 2002:a05:600c:630f:b0:482:dbd7:a1c1 with SMTP id
 5b1f17b1804b1-48320226287mr56962335e9.34.1770413822901; 
 Fri, 06 Feb 2026 13:37:02 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483203d60d0sm30383705e9.1.2026.02.06.13.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 13:37:02 -0800 (PST)
Message-ID: <8a60a078-a87d-4fe5-aa8f-e9edabb03f51@linaro.org>
Date: Fri, 6 Feb 2026 22:37:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] or1k: Rename the architecture from openrisc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, shorne@gmail.com
References: <20260205030244.266447-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260205030244.266447-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 5/2/26 04:02, Richard Henderson wrote:

> Richard Henderson (6):
>    target/or1k: Rename from openrisc
>    include/hw/or1k: Rename from openrisc
>    hw/or1k: Rename from openrisc
>    tests/tcg/or1k: Rename from openrisc
>    docs/system/or1k: Rename from openrisc
>    hw/or1k: Rename or1k-sim.c from openrisc_sim.c

Series queued, thanks.

