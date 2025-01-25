Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2922C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkLt-0006pO-Vn; Sat, 25 Jan 2025 12:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbkLs-0006p9-I9
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:53:48 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbkLr-00014M-4R
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:53:48 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2166f1e589cso80437845ad.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737827626; x=1738432426; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vyvJDzClY8xuQEruomzfsjN2X2J0zHz6xOds7I0idrM=;
 b=anV6PiWfFnL5McuTlYe8w8G6Mh4tx4jyopo/xmt+q50WWQq9FREOxLzq6geppPCMmV
 7zWpfgqdGFqwkeI4y+0VFtHzjv5w1vT8MkfjUNiNuIVcBk+o0kIK12fAxXrO3/Pi1chD
 Rakng/YIs4KC8HoLLQGMV72xTfxQJETOvKanDbK5BqbkhclpHPCWnnAxHPdVdRGsZ1Ob
 R7nBMssx45HQFlxBmVdGhtCYcBioCySXVHSOjh6Tm+2SzmvCV+Y/FUpVW8hxdhdO345f
 CXfSXCFTG/lSNWhkINfHJwPCVuqlEYNhpl1OeFQwqWHzFQDO437jzpxRuSc1WAZQ6HYg
 3CdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737827626; x=1738432426;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vyvJDzClY8xuQEruomzfsjN2X2J0zHz6xOds7I0idrM=;
 b=DqMDU5ZuD6DcI1WT1aQCevOS8IVWJV6YhIBJP0tJO86oRDSoOtOvN3FXQLWoOiX461
 p1m8ji8XvMwfNiKv/x6rkS4s96RHlDZansXgKUux93lnW6Mnh0vHtf6wsfqBecAC6hs3
 +0a+M2b9sytc8SWZr3VAzrubYi8U7JgXPMcrVa3EcfkM9CtsCDomal51SVrE2EtyobIz
 +Ae89PFIQrv4xa8f50hKmqk6rustQQW2qJeDnvxkkHri4qwYuebSjPzK+feCmrbAIZhL
 5cgcKz1OpNYPBO3PpKY7nbbPvCksRu5SOhr9tc2LV25ZbQKrLL559xtgv2I/rENVM0qd
 lUiw==
X-Gm-Message-State: AOJu0Yz/Lx/HCvPLRMz02X2nJYEAS6+vkZIHjdiU9Y+Wau0yHF4yIjOr
 QdEvp/Y24ccS03kCFD2aPJxMDQRvUzg45784gDLdTLAIOXhjsKavFU2TrI8cZoGydI9jC+8WFzQ
 r
X-Gm-Gg: ASbGncvTOCNprmdWqJsBczWzhw7TygAHOaraESVmInXszY0sInvjqaxTYXn/0sD6nbX
 3SVVvHwlFhKgD5kjJElpDwRkcs2fuiwm4op56ioQ8l/DZ78PEGValwr3Bzix2c6xfjA2ubNg1d+
 RAHj/Kjs0CLSc4Op51TVoLqZ2dpFuky+6z+mO2mRBg90r0kLhz5+QPPLLEKJgeDhQxWzAxR2KMZ
 BPPr7sD4fA+P7bT2CVWPx14OYTjhGIjqyR7NGiNoDEFz5gHCohjmPEM7A1qMac1yZvhnSZr7XGP
 W3f78HEDUmrXx/XsglCsvuc2tdIl3tBu
X-Google-Smtp-Source: AGHT+IHMt+Sc+CFthoj/er4FIQL7cOuFl6j5f2DR6GqMxER67HPAsO1HrT8SfS02V4l1GyyR8ZHLkw==
X-Received: by 2002:a17:902:f543:b0:216:5002:7341 with SMTP id
 d9443c01a7336-21c3564e6e5mr557462825ad.44.1737827625829; 
 Sat, 25 Jan 2025 09:53:45 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da424e779sm35045155ad.213.2025.01.25.09.53.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 09:53:45 -0800 (PST)
Message-ID: <06ec4933-560f-4d6c-bcce-e4649c0ee0a2@linaro.org>
Date: Sat, 25 Jan 2025 09:53:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 38/76] target/arm: Handle FPCR.NEP for 3-input scalar
 operations
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-39-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-39-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:27, Peter Maydell wrote:
> Handle FPCR.NEP for the 3-input scalar operations which use
> do_fmla_scalar_idx() and do_fmadd(), by making them call the
> appropriate write_fp_*reg_merging() functions.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

