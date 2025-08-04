Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400B1C87FDB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqf5-0005me-M2; Mon, 04 Aug 2025 04:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqeM-0005R2-VG
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:34:35 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqeL-0000MS-24
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:34:30 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so28350055e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754296467; x=1754901267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WJanI8IF45DLskc3iyTvlpISdDhRWqhYdV4Aqal0nTE=;
 b=m4NQtx9WFKTWwGoTnK6bFd6d96i336Cx4l4RfQilQfnf9wwuTWvMlKKVgjLFWB6ehN
 lAEiggKCf0e0hXLMgfVmKRF1C3P9voyXNSA0ZVl4SDq0P2RI7ylwXHk/xla7iXhmNEev
 zHNViF3lkIRUqNgPotp1ZojgCpo02ubVeo9sJu8oANYa46oKhY1+R2XPPDvtqKYmvMz4
 sAZBu5cgbBaJDHk9ecAKysTP7+6Zx+MiGpMDUAW/LQ7uS44vlA/OJP38mOnQQKDn4Sgx
 3U2xc4UirGVDdkf6anZLlKpzR778HjEgwv2mSb+MUhZ1CVIUvfwkIAiPtxxHqJAR8Ut7
 Qecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754296467; x=1754901267;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WJanI8IF45DLskc3iyTvlpISdDhRWqhYdV4Aqal0nTE=;
 b=b4YFukXfkeSXncspRdeN0bGmSESmozwdN9yQvsgdyLiIo2MVmh3Jx8/kgMCZQt/Deu
 3xZqfFpcXr+gYVcMeGv60e5L+suGUZR2T61snjfx5qHlGrJ8vDKfd0ZwvR9mcQqQp0nm
 xepTqZGSoHDC2aKJuPJzcFqp+W/ua3pWuqVqerYHzzfmioD5v/l0MiPAnDrTVXFRQJw2
 7XqtX9p+bXv7Os5/bgdsDk8BU1Z4cAU8etlwJdXYV7tHa7r0NZ7yOfRspup++amx3S/m
 rE9DSLdpRyqLYNWi7nuagfSyVZN7e5TJwK072ZzRbFrK4HAakjoeYMcpf4zLVLGmBJk2
 R5Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdV38AnVat7Hs4FcjdlAnuF6/NhoPyn/wfRyrhUfMGkb3UBA5EQ8w8a0qPzX8VOoLwrwVy5sTHAB5f@nongnu.org
X-Gm-Message-State: AOJu0YyJoT/iwgQ00BsdWn2SS3ZUG7lJ3qbUtzRistzZ96yYiB9vVITk
 i1rQ4heGNxR5uSruHlA2FoPjwxqKyJNIj+R5L0Lpz2Fp7vE68WzCNL2qvD4Enpr+owhvKeg9lhC
 P8BWj
X-Gm-Gg: ASbGncs2yuifOniSdK05pFJoVEqsoBtRY5yOUKHw5bGENshszcWmzdm0Fh2y2C1GaV0
 g9H4ZpArYmjk3uvogfdqZxkKHC+DTbLLNzgfgrIq3vze3+KnrVl2VuHTJL3qiU049G3cIWtEJJs
 xWf6SnGg73hB1dDFIp4v7HOcfTmkMpQeEYdjkZNDF2RKrhl7N3biV1etsh3l6ei+mZ3hpNpHT6g
 TH+vou1iCDTh2ErdP04AKPcSRfnH9WmAl83om6EbPLMRzMSo+vDKcb25pnC4cLr5ThaoiNqysLr
 ZvtmlMmUreeNu/jTfwd5fpnTV1t7/6pnA+da5lOcVf2XMV42lKnIeuvVig95M2IV0jOuyA+3ufS
 aWsmDYpQ0rPqNoUQjLaxe0RLRlxCKCuXNJLsf3md6WplUP9eqygpHVl40OsxdZeAqh3Al0Sn/hw
 esD0ZbDg==
X-Google-Smtp-Source: AGHT+IE+IPa26qqxfgG++CjC0cKyOz4aZvbRl5DpPrmRl6GERe3H8MKCWEiuf9f6jj53hRW+ZM4FaQ==
X-Received: by 2002:a5d:5f51:0:b0:3b8:d672:3cec with SMTP id
 ffacd0b85a97d-3b8d94ca599mr5804163f8f.45.1754296466968; 
 Mon, 04 Aug 2025 01:34:26 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459dd85f423sm12704185e9.18.2025.08.04.01.34.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 01:34:26 -0700 (PDT)
Message-ID: <ff6924ee-c6c5-45b1-b685-0f4abf855ece@linaro.org>
Date: Mon, 4 Aug 2025 10:34:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/24] tests/functional: Move m68k tests into architecture
 specific folder
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
 <20250801151251.751368-13-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801151251.751368-13-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 1/8/25 17:12, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The tests/functional folder has become quite crowded, thus move the
> m68k tests into a target-specific subfolder.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                              | 8 ++++----
>   tests/functional/m68k/meson.build                        | 9 +++++++++
>   .../{test_m68k_mcf5208evb.py => m68k/test_mcf5208evb.py} | 0
>   .../{test_m68k_nextcube.py => m68k/test_nextcube.py}     | 0
>   .../functional/{test_m68k_q800.py => m68k/test_q800.py}  | 0
>   .../{test_m68k_replay.py => m68k/test_replay.py}         | 0
>   .../{test_m68k_tuxrun.py => m68k/test_tuxrun.py}         | 0
>   tests/functional/meson.build                             | 9 +--------
>   8 files changed, 14 insertions(+), 12 deletions(-)
>   create mode 100644 tests/functional/m68k/meson.build
>   rename tests/functional/{test_m68k_mcf5208evb.py => m68k/test_mcf5208evb.py} (100%)
>   rename tests/functional/{test_m68k_nextcube.py => m68k/test_nextcube.py} (100%)
>   rename tests/functional/{test_m68k_q800.py => m68k/test_q800.py} (100%)
>   rename tests/functional/{test_m68k_replay.py => m68k/test_replay.py} (100%)
>   rename tests/functional/{test_m68k_tuxrun.py => m68k/test_tuxrun.py} (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


