Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55522E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 18:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsmHQ-0002no-8y; Wed, 18 Feb 2026 13:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsmHN-0002nK-OI
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 13:28:05 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsmHL-000690-Mt
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 13:28:05 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4834826e5a0so1403205e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 10:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771439280; x=1772044080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EgBUyAahJdhGBPD+SqoG+CYE/AC5LXFhk5YCiF96cAU=;
 b=aYuo0DOfNMMtR01qEzyrBdMdbpOk8mWzLFYf515UBtPf0yl4cyLvvPjy1JF8IIAdix
 vxRA8KnVsq5CpyCHAWgu+M0D4db1W6abbHYOkqQ9UgcoW3Gt7jlAIEbdSbs2cNn7Gwv7
 VZ+55S1gfuiifCukemgry+GdSBBaMcW38KLW295u7xH7E3xGKT26GW+qwnL3CUDh8sHM
 q72hgOitSUBr1vkbsaHh3BHwYC/LNjNNm1PgN4acDNLKVBCiptr2IWkCDQBY5Sqkp9s6
 SPmqtG/6LyTxzi+WtJhr6VWWswUdZsCxd4Aq0XdHdm+aIlOpsn5OWpMDZqMxizUg0n2F
 Bkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771439280; x=1772044080;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EgBUyAahJdhGBPD+SqoG+CYE/AC5LXFhk5YCiF96cAU=;
 b=AsXRsQWXKIWCv1S+OPfgqcC8iOyqK+eM2m2r9AM2vdoCYpYfPV69RdauCHpaHnNjo+
 HmJzJUeqBpQDJwSFgYW55QwfQjFqaFbU1e5xgo9baGiZqVmqshbnYhJN+gRGus9eRRNE
 CLZg6MrqCYZ8psCzyPmhlwMilH+ZjWSxLl2JqWmxmF+x6o4nkBIKfXrZL8wt4Sy3Ai11
 +wC546NGLFz3A/sMfBr+6uFqXMhAnLkr4jYbx556vpZeYsPbeeirgU0MSaIlQjEtluxV
 255whLFxowW+qV5MWwApFmB25J7ohyhSk2jTYFf3P49CaCdILBvRcxCaJCVMUPtpIBHK
 E17g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0hidvLBbK9+uvaSSsB7gRGjhQmZ/CMygvkmM9mB7fb8/uWRZcoLQY/4uZco/MElXlZwc+06zdE6i6@nongnu.org
X-Gm-Message-State: AOJu0Yx0sWAFI/o4BFh7tnzLYmpZVOJCfDrtgdArzh0bi7GmGDdXIz0E
 nAoRJligqKP8/Uu0DaELMBSywzuMQB2i/mNlXVJXzlQtJvIrNkQE/3PO3Y//4T/xMMg=
X-Gm-Gg: AZuq6aJYrbgX1nXgg33oWY5l4mzyKpQk11TVc6Th83YLL2SksQzAMWyAneeUfqLR3Nw
 4vlpLOpZI6zjiIgu1dA3wDcuKTPSgM66RDcP/9HaRJiOy/8HIjd6F0DKGyaFSWgNRXPbsDmQ0dO
 YM41zigI/ibIXEWyxoW3DviLxEay5UibkJVD4yuJGls/5TgXhMYEz3r7PsxN4iUgO+a+jt3ftKT
 UKGBCWEBrmRKHTZ2MKPSGAPqNBp/i0NLhWJhhHcsXdiK3Wnpfn6alEYSGc4pGq2Y1+RR5onB4Yx
 fmK21pihSKNlUiKYHX1qh+t1BG/oGdVLz4Yt8FS/K/YjeGEpMswqFjKQ560DrudRM7TeWKZrcPe
 wT+oYtx/TjUs0JjMmNpluhSlOCdQ5BAwBRKAnKVzLlaai8qw5KL4J7vt9YXkCC8l8bYp+CLrXy7
 1R2hBp2Sci5ukIANECNGxCguYH6vACYk4nsS7bG3/CmKWWbwKZxlmIubk/v4FEPMRQL2NaorAWv
 ccx
X-Received: by 2002:a05:600c:35c8:b0:480:3a72:524a with SMTP id
 5b1f17b1804b1-48398b5e28cmr47935565e9.19.1771439279844; 
 Wed, 18 Feb 2026 10:27:59 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm665231525e9.6.2026.02.18.10.27.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 10:27:59 -0800 (PST)
Message-ID: <64a26229-3f29-4ea4-8290-645713d2bb5d@linaro.org>
Date: Wed, 18 Feb 2026 19:27:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] single-binary: Drop TARGET_PHYS_ADDR_SPACE_BITS
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260218-phys_addr-v6-0-a603bf363218@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260218-phys_addr-v6-0-a603bf363218@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 18/2/26 18:21, Anton Johansson wrote:
> The target macro TARGET_PHYS_ADDR_SPACE_BITS is unused since commit
> 
>    2e8fe327eb6 ("accel/tcg: Simplify L1_MAP_ADDR_SPACE_BITS"),
> 
> replace the handful of remaining uses with runtime functions or
> constants.
> 
> For discussion see:
> 
>    https://lore.kernel.org/qemu-devel/8f0db5c1-f20b-4b7a-8d6c-76ce7ec7b4e0@linaro.org/
> 
> Series fully reviewed.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
> Changes in v6:
> - Added reviewed-bys

Not needed, but thanks!

Series queued :)


