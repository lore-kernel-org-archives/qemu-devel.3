Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A37ECAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4PWq-0002Hp-BC; Thu, 02 Oct 2025 16:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PWj-0002Gd-GS
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:03:47 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PWd-0000qE-Cw
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:03:45 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7811a02316bso1114705b3a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759435413; x=1760040213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uq9hkyMfp20gYvg1flGYuBeuv0ESaUJB0SW826VtP/g=;
 b=mgz+6aHsDdtAObqpdSWCSk1eW6fe1OOts8CyeEH7asLMYFYxc10mxvxkK1++dWY5Um
 EoiMVoneC8ir8IlPUijSHmW3KVC59/ySZpELe9jonTQejb2ODu46uI9JksIhE2VkPbXI
 NJqiVDtfdJtzGnFcXXJ0t0T+ZGz6y9F6l3m/I6yPKlmB99k0YJi8Ohjy9P/tSnEU72l/
 DIkuOd42QYR6HK8LUc1YzVur5LNSGNYyVuvaduiz7nperftrq1s1hRTsQ5XD5zWxa+SQ
 4D5zG/WdoWXGbWgqIhR8nWahdmjozmfJgz2N9Rhtw/0Ludyqxy9w6+YdigPMQ8gjlyVL
 dWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759435413; x=1760040213;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uq9hkyMfp20gYvg1flGYuBeuv0ESaUJB0SW826VtP/g=;
 b=Afg7ik2jXDM4ylrK7/BCgfFxt3PmkxHLzh3ZfZR8+WrDrDDDjw+hx/O/mPOWPB7em1
 Y82R7q5gMXgpkWSeNBBxT2HFfY45OvIsuQNPEXNWW4QPxQz54V0A5s0pKxoUEHWXi29A
 sfOoNmiRoILCbLtbW5w7KsB7M9z46QMWN0IqxNBzA543f3tg8hZzXNWtvqmSS0vlOOw6
 Awvy5SjwkYYlYWvqg5XLUdxbMkjpJW3037WXqeYiwUQvVbZBccC12pLqlqXCQGKh++jN
 2gIrXRRnqUMXJlKCdMLau2CYRsy1S3p9acJbds3BsOcKAiQ5PN9zjh3XzHcnemgOnl8N
 tyrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJTZmvUY5ik+cViXrlv+D64htknVsZKi6jB9vySpLfPlWbgzrbz5n6otVzY9xzGV5Wc9ZPXE3bdrwZ@nongnu.org
X-Gm-Message-State: AOJu0YwP2dDpNsv5pWOTOhYvcP38Bb1GzvAHiB8PIeMhUh/nOnFaMqW+
 w4qNaO5G5b2F1ocgzT2JZwe8Icc/5OxHIPjRZSAebAx87Bq5oVdgwYRoz+VqhwgFlUI=
X-Gm-Gg: ASbGncvkASWVFIADJ8Qc0tVAjod+AuAvPZzrz4W9FArx0XYYCDL1GtXU3wljyxaAXS0
 LrB6JuitYqj2Y9TC5ropQuczxcBOaB+V0/Yk5z42lvpyBOdaopxdPxMH/YA/rHyeMJbHZwYihFG
 LMC2OmBTL8W7+H7PuATWFT+RFZImnTS8cZ6mvfVpPzujqVwAsarpN/CWED3AidOnw90q6v9YWGd
 tIwhKJtT1x69/clcVzyej7rJ1ZPjmVQW93DxFvUysMyM1EQsS7QwRtLi/UTgucUroO/S9Qqe+al
 sloO5I7XGkTbqUhnyrL+7/BljQCE6L9Qmp67og+U0n1Oghe0ndRv6x8wzl7NcM1AzfMtb9s2DG2
 EvTaILLROa+HYVOAnbyDFUiayOZpq6zFHPcHczo5GhFqh7Vt2x/A0lSGzmneAchw=
X-Google-Smtp-Source: AGHT+IGs1Gk7bAwL0PrxDGxGHqKG9uHlv0lze7Db47cR0AntLMeHI9SqD4wEDK9fxz6KKC56sdpdNw==
X-Received: by 2002:a05:6a00:b55:b0:781:1f28:eadd with SMTP id
 d2e1a72fcca58-78c98dc4e18mr713773b3a.20.1759435412666; 
 Thu, 02 Oct 2025 13:03:32 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b01f9a364sm2875083b3a.6.2025.10.02.13.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:03:32 -0700 (PDT)
Message-ID: <3d136b2c-a84f-4c0a-8a85-479f3877e783@linaro.org>
Date: Thu, 2 Oct 2025 13:03:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/33] target/riscv: Fix size of priv_ver and vext_ver
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-16-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-16-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> Fix these fields to 32 bits, also update corresponding priv_ver field
> in DisasContext as well as function arguments. 32 bits was chosen
> since it's large enough to fit all stored values and int/int32_t is
> used in RISCVCPUDef and a few functions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h       | 6 +++---
>   target/riscv/machine.c   | 4 ++--
>   target/riscv/translate.c | 2 +-
>   3 files changed, 6 insertions(+), 6 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


