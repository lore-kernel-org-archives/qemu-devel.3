Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB89CCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOUx-0006bV-Ex; Tue, 02 Sep 2025 06:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOUo-0006Yc-E6
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:44:14 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOUm-0002MS-76
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:44:14 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45b869d3571so5995965e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756809850; x=1757414650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lKa+uzR2fZe5SDEjtJv45LjqghmibtaANiwzOL7+vIQ=;
 b=bMiwGOs8st5BosiHwblkF0jHoTI8P0Nzv0iy260TinvcUTZngjevwxajq/Copur0kh
 Ktgiukr6nuq5a2/ITKz3OLlrdRLh+xyb8PnA1OYHFQ++bTpvgBgKERqBwRm75y2Bb8ED
 yPsduVSM4FUqgBQ+boiYO9GzfJ2U4zmb9SOfv+Sj2pT/fmC37Non004KHdp8Lmh7WaHe
 XOLPnaAQjhIMfTx2QBRSxRuXK3Kwa3JcyTBIO+sFyCmRjnbEbcd3KnM35jliwyBtB8sM
 ueC3+ammcCVyqczKsczg49zdv13qGSeMLaPVYeR2W3ZLyW4OPvXVvsrxKAN7ojX3ZXV0
 Z6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756809850; x=1757414650;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lKa+uzR2fZe5SDEjtJv45LjqghmibtaANiwzOL7+vIQ=;
 b=pWVNbiU5N3BQ3Ejc7IH+eFa4q4pRw+fKPph/CNoFxmnQbMWz/tXWZLkxSIqQ37wCDm
 UIGxKOoH6iMKqc0MG27EGS3J3bGjaWxtS548fU/VV2IkPNtaJiGJg3pJ1QlRClpeQIuA
 8FmJ82fTYaV/3zAFCPIEZ7ySkuVlZLpbmd+kGEAmHUzoQkLDuOv6IxA/ZLcQoal/22cW
 NKwGgS2ElKQM+vGdb0ufq08h0EG4hqgysy7mgQLkkVT3OytqdaSXOXX2ZtQCyFF+KLo5
 xw2cMT1lUf79tyBfGqArNepAhWkrDS6CCNdvBxHab8d/dkrtq3X2enDkr0yUTm9kcl3X
 AdyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvLt9E+ljy7OGhmyuNy21G9E0IumF6JSd4R7ZUIA1Axxw8woy6urvMSNKZGtcYtEm8eTLBvTS/tVe2@nongnu.org
X-Gm-Message-State: AOJu0YyOLLVYwRsZKk84gX1+415Aa2oWlGTC+MhmB50WcWrctSQbIvRG
 O2+dMunflwJjf4pytdLKCG0ldV8rS5h0ziZhP4Sus4oSN+kP9XplJxfoOENRSWBQXsQ=
X-Gm-Gg: ASbGnct1EB6k+hjIbFqKEdeigtG5x/rihfbC60hg4AkOKS8fNcVY8eTL44IwzGJmVTE
 YIPT+0d+Bm3jdF2gmpnh0JDmFss5IKC8id4aIRaL0VUm6z8qN4dtUjc9GlTRwcCluZZugoey31v
 QTk350KoZK2woG8ifcg83P52TbwngEGppNB7EjrWynnpoWk8dUiA7dhh8y/jGfqEfyms1hoKJ0h
 WCbLMoqqG88zQfd3dgiypkkWCMYpqyygeqNspqGrI5PDecBnaC4jXv0r4xSLTei23my+TXD6S3Z
 KkAO5I8TrNRx6/38b9Gp+XbLaEgIIcTqCI8vDIV0FZByW0SOqcytEK0TxILgsuQL6/XujoicSOD
 g721MxzjsDYUxjpUg3xgUgUz/K1kw/uwqW3QVf6Jmeo4yKCMba21WUA+TmTX2YMLKww==
X-Google-Smtp-Source: AGHT+IEWjg5RdM8rnHb/ivln5tDp2BNTuktCbmrYWsCAO5uKIgDOrFb73uHL7tkrALe40JpNHKYc0w==
X-Received: by 2002:a05:600c:3baa:b0:45b:8b3e:9f7b with SMTP id
 5b1f17b1804b1-45b8b3ea15cmr58758845e9.3.1756809849813; 
 Tue, 02 Sep 2025 03:44:09 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b93fae643sm38561895e9.3.2025.09.02.03.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:44:09 -0700 (PDT)
Message-ID: <aa71d2dc-ebd8-46bf-8693-4e17da3434ef@linaro.org>
Date: Tue, 2 Sep 2025 12:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix: Fix build error with CONFIG_POWERNV disabled
To: Aditya Gupta <adityag@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <20250820122516.949766-2-adityag@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250820122516.949766-2-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 20/8/25 14:25, Aditya Gupta wrote:
> Currently when CONFIG_POWERNV is not enabled, the build fails, such as
> with --without-default-devices:
> 
>      $ ./configure --without-default-devices
>      $ make
> 
>      [281/283] Linking target qemu-system-ppc64
>      FAILED: qemu-system-ppc64
>      cc -m64 @qemu-system-ppc64.rsp
>      /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in function `helper_load_sprd':
>      .../target/ppc/misc_helper.c:335:(.text+0xcdc): undefined reference to `pnv_chip_find_core'
>      /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in function `helper_store_sprd':
>      .../target/ppc/misc_helper.c:375:(.text+0xdf4): undefined reference to `pnv_chip_find_core'
>      collect2: error: ld returned 1 exit status
>      ...
> 
> This is since target/ppc/misc_helper.c references PowerNV specific
> 'pnv_chip_find_core' call.
> 
> Split the PowerNV specific SPRD code out of the generic PowerPC code, by
> moving the SPRD code to pnv.c
> 
> Fixes: 9808ce6d5cb ("target/ppc: Big-core scratch register fix")
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
> Note that while moving the code, the 'target_ulong' type for sprc has been
> modified to 'uint64_t'.
> 
> Based on the discussion happened on [1].
> Requires patch 1 and patch 2 of [1] to be applied, to fix the build.
> 
> [1]: https://lore.kernel.org/qemu-devel/20250526112346.48744-1-philmd@linaro.org/
> ---
> ---
>   hw/ppc/pnv.c             | 86 ++++++++++++++++++++++++++++++++++++++++
>   target/ppc/cpu.h         |  4 ++
>   target/ppc/misc_helper.c | 59 +++------------------------
>   3 files changed, 96 insertions(+), 53 deletions(-)

Patch queued via hw-misc, thanks.


