Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D1BCCFA0E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 04:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t36F9-0003FA-QZ; Tue, 22 Oct 2024 00:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t36F7-0003Ep-FB
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:11:37 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t36F5-0004Of-QU
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:11:37 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a3b98d8a7eso17984385ab.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 21:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729570294; x=1730175094; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aXIzRKITiu+bTV7skCLUHNsao7Mmm2V92UHYDAAGaHY=;
 b=iIA6bMCrnVkJS1hOyMCqNTVg29+cHGWrRNJKPzxuj6koncPjoqnCKqHWdkBUHmq0YX
 DZpe7uNFRHcWX9cVPRaxZxhHwGydSWjuAg2FKFCpY6JQI04F5ctC5pNdIUNySExo8FpB
 8G02rbd9LedEJP+4GTAX8hvn6PaFU8uhN/t2F8E916AAxFsicbhCus+EpI5knM1VSc2S
 BrgmsN/AANJBrF1gkiktBRJi7XoreT/NoBN9DjQdtQKaoGLtYeHy/KRgKPOg1x8wR6xW
 rhvHJTGmw+Uhe1jnYRQM5Y19If2114or9nHSfu3t0HGDLzFh68LtcucEshQfkIdg/Wl8
 wCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729570294; x=1730175094;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aXIzRKITiu+bTV7skCLUHNsao7Mmm2V92UHYDAAGaHY=;
 b=VFTDGjZAlSy33IYf9ACtQXXOKX10FwUthXS2k2GEoZooaU6tptRiDYcJzMutxud+8D
 y8BK+iaJcOG7GFVvdjORnZi/qrKp3SAnyiMwX6TtTkBgiB17Uvk7HftVEFDkZ6JIouA2
 JTdL7KslCWRsygdw7iSAiXC/mHn+O4aYh9JOJDtT8YSpYlKgu7QnldwyUjNJvHWFOFvw
 uTKeDYmsT0XUiP3VCPVDlrSTKGn55wQzGaIDoGanknVtJtOj8TT+C6zF111O61CUYhWi
 dK0AL68najsKICV5uDFgMkrB1/FcyGPwDamkRW+1vUdVTV8WCFRGDVdFtV6PVyDB9wB3
 DCsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0gL0s/7DV5DH54PBR/3FFFcqOLM7M4QlQNcgCEk5AzTrY3YYU3mvFL07AVfyS5npMNsuNLTRs/YmG@nongnu.org
X-Gm-Message-State: AOJu0YwjThrfQ/9kvHcUTovPza/t/YnqY37f0TS4e9R+vWlPV7ezH9eC
 pDAurRQkHn+pC//nqiASvSs3tElEIMjO5KaCLxa0PBo0sPnF629+u63Qtzyz0TM=
X-Google-Smtp-Source: AGHT+IFvs1DI0gHIW25LBWYu16LCJ8Bx792dOSaBF5c5yajACLzU75pkcnEYMX2EQCyre1KxjtkNHQ==
X-Received: by 2002:a05:6e02:1885:b0:3a1:a163:ba58 with SMTP id
 e9e14a558f8ab-3a4cd80da09mr10934285ab.26.1729570294148; 
 Mon, 21 Oct 2024 21:11:34 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeabc115dsm4009419a12.74.2024.10.21.21.11.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 21:11:33 -0700 (PDT)
Message-ID: <977b5038-fa06-46d4-946d-f60135ecf106@linaro.org>
Date: Tue, 22 Oct 2024 01:11:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/functional: Add a functional test for the
 collie board
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, Thomas Huth <thuth@redhat.com>
References: <20241017163247.711244-1-peter.maydell@linaro.org>
 <20241017163247.711244-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241017163247.711244-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/10/24 13:32, Peter Maydell wrote:
> Add a functional test for the collie board that uses the kernel and
> rootfs provided by Guenter Roeck in the linux-test-downloads repo:
>   https://github.com/groeck/linux-test-downloads/
> 
> This just boots Linux with a userspace that immediately reboots
> the board, so we wait for the reboot log line.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS                         |  1 +
>   tests/functional/meson.build        |  1 +
>   tests/functional/test_arm_collie.py | 31 +++++++++++++++++++++++++++++
>   3 files changed, 33 insertions(+)
>   create mode 100755 tests/functional/test_arm_collie.py


> +class CollieTest(LinuxKernelTest):
> +
> +    ASSET_ZIMAGE = Asset(
> +        'https://github.com/groeck/linux-test-downloads/raw/225223f2ad7d637b34426810bf6c3b727b76a718/collie/zImage',
> +        '10ace8abf9e0875ef8a83b8829cc3b5b50bc6d7bc3ca29f19f49f5673a43c13b')
> +
> +    ASSET_ROOTFS = Asset(
> +        'https://github.com/groeck/linux-test-downloads/raw/225223f2ad7d637b34426810bf6c3b727b76a718/collie/rootfs-sa110.cpio',
> +        '89ccaaa5c6b33331887047e1618ffe81b0f55909173944347d5d2426f3bcc1f2')

Should we wrap these lines to comply with checkpatch.pl?

Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


