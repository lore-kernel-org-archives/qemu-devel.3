Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F62C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taV9k-00012E-AI; Wed, 22 Jan 2025 02:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taV9c-00011W-0K
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:28:01 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taV9Z-0004S3-LK
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:27:59 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso3243215e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 23:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737530874; x=1738135674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5AhG9uSyvMfzUjTcPeK9n3g0Dthxanb94tswyvrefJQ=;
 b=uJwddqHNOQfJCy7p+2Le38IrQTKEEAUMqiZUdD/TrKp/zOqziUfbVap/L/1WHojF6C
 a/pU1PfZV8jqtfkw3bKybdCdNmbYhEmT6cqGhPIad4k6W4GmwpolFY0hdrxbSoeTBA1n
 spSoHAtoI5ZGBcJJIWS0UFUhMReh7NTxChLwbu5wBVHSGhf1ofVyJ94CWPNg6EEhuGn9
 ezY0KLSweosRdkM5GqLmcCnXt3sNfFr1f8cDtESdqKorZcwQAoNfC/YWnSKE5lvEMECR
 +n0hmX8U6iUDxkU7GuB6E/IqfhsUrDYPphjLsx99bgulJHWo/rxjj7VXHXYzeBX30zJR
 xsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737530874; x=1738135674;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5AhG9uSyvMfzUjTcPeK9n3g0Dthxanb94tswyvrefJQ=;
 b=Bjq+YrohwL58hFvxFrB+mouf4NaQvvphqE8UWQNKOCQa4Gse0btPKfsVHySluXPJZV
 VewesJe1J96usFIyunnPDLncNdDsIjQSKp6G5rIkoDSet6yH3zC+nNURcjv8kRFfPsX0
 D8GlH1V8etFVfH1OBKiM/DuwWOLxN0fyIWbycGFFXUFTlBszDMtemA1ZUGujWxk+5cw/
 IYqt7TZW0uRdviyOqjFSNRbz4xK/JrDIRh7sZaMIl6bhxtPI8dpwWk7iarFOnh46A/wZ
 mqtftVrgkpoUdu63+qHTnmKb3iZRCZ1puQWHOvbjqsApnp/tEV3YdizMm2ofD7RamUyT
 7iSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEk+Bh4nW1uiE/Dm/pDTEUaT6QR4kD04natx5hMw/bf/8uBYeJ96kU9VK+bsIT99VmS90TG+auA3U7@nongnu.org
X-Gm-Message-State: AOJu0YwhdzJ+19XLqs0ITvpDepcfgfpszcWJvBeD7wsUcPrrfyKmQohS
 txtRI6KKbMaTPgbhJ9SdaVkr6MzGkVOyoP4xwXymWetJtDb0x9ioe2L6yFHOnsA=
X-Gm-Gg: ASbGncs8NIJneBRc5D6qlzCIJLtEBGIIubd1uNsLoSbY2rAK7akMNCjsmsSJ38Bh875
 CrjKO3BCCk4P+HfZOOJgm+8B3MHnXlv3fsrN67+uAgVKqFxTHluxMou0FOekb7Qg9N/egQhHDw4
 HYpvA1EM6N9Kr8QPsiaRAbAsfih0lYJt4Lob2kQy/p45wOvyqEmC4J/vCJ2ojQCy0KgYsJRCf/2
 BUfySbuWF0LTBBxgHYO5ixlmIYwwCykWzdTMk/fqyAPIdHqeQpCM00WfgApkJ8MnnvrZ37xcTWd
 qbAlZPrMRQJB+iyuoEAfNJzaWP732Tm0hnK7EA==
X-Google-Smtp-Source: AGHT+IF6IGKeYAV7IIiv+X/cR4BIbi+KxdF5xB34CFE9NWpVkN+0Mgy5rEO+gtyWTWHeh5RkXsfRWA==
X-Received: by 2002:a05:600c:698c:b0:434:f9ad:7222 with SMTP id
 5b1f17b1804b1-438918d3bdcmr177949525e9.7.1737530873812; 
 Tue, 21 Jan 2025 23:27:53 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b3189ba8sm13575925e9.5.2025.01.21.23.27.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 23:27:52 -0800 (PST)
Message-ID: <d136993d-48bc-4283-9de0-c956b5cac302@linaro.org>
Date: Wed, 22 Jan 2025 08:27:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] Add support for emulation of CRC32 instructions
To: Aleksandar Rakic <rakicaleksandar1999@gmail.com>, qemu-devel@nongnu.org
Cc: aleksandar.rakic@htecgroup.com, djordje.todorovic@htecgroup.com,
 cfu@mips.com, arikalo@gmail.com, peter.maydell@linaro.org,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com, kwolf@redhat.com,
 hreitz@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org,
 pierrick.bouvier@linaro.org, berrange@redhat.com,
 Yongbok Kim <yongbok.kim@mips.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
References: <20241112164130.2396737-1-aleksandar.rakic@htecgroup.com>
 <20241112164130.2396737-3-aleksandar.rakic@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241112164130.2396737-3-aleksandar.rakic@htecgroup.com>
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

On 12/11/24 17:41, Aleksandar Rakic wrote:
> Add emulation of MIPS' CRC32 (Cyclic Redundancy Check) instructions.
> Reuse zlib crc32() and Linux crc32c().
> 
> Cherry-picked 4cc974938aee1588f852590509004e340c072940
> from https://github.com/MIPS/gnutools-qemu
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>
> ---
>   target/mips/helper.h             |  2 ++
>   target/mips/meson.build          |  1 +
>   target/mips/tcg/op_helper.c      | 26 ++++++++++++++++++++++++++
>   target/mips/tcg/rel6.decode      |  5 +++++
>   target/mips/tcg/rel6_translate.c | 14 ++++++++++++++
>   target/mips/tcg/translate.c      | 25 +++++++++++++++++++++++++
>   target/mips/tcg/translate.h      |  3 +++
>   7 files changed, 76 insertions(+)


> diff --git a/target/mips/tcg/rel6.decode b/target/mips/tcg/rel6.decode
> index d6989cf56e..5074338aa5 100644
> --- a/target/mips/tcg/rel6.decode
> +++ b/target/mips/tcg/rel6.decode
> @@ -16,11 +16,16 @@
>   
>   &r                  rs rt rd sa
>   
> +&special3_crc       rs rt c sz
> +
>   @lsa                ...... rs:5 rt:5 rd:5 ... sa:2 ......   &r
> +@crc32              ...... rs:5 rt:5 ..... c:3 sz:2 ......   &special3_crc
>   
>   LSA                 000000 ..... ..... ..... 000 .. 000101  @lsa
>   DLSA                000000 ..... ..... ..... 000 .. 010101  @lsa
>   
> +CRC32               011111 ..... ..... 00000 ... .. 001111  @crc32

Interestingly the disassembly for that is in tree, hidden in commit
99029be1c28 ("target/mips: Add implementation of GINVT instruction")...

