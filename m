Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF8AD262B7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 04:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viQ5W-0005ja-5q; Tue, 20 Jan 2026 23:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1viQ5T-0005gq-Um
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 23:44:59 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1viQ5S-0006px-6M
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 23:44:59 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-81e9d0cd082so4760589b3a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 20:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768970697; x=1769575497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+Bf1Pd8Z9/BnT45YObIxltuEdos+6OIjVxfCqB2A3U4=;
 b=WjkhDHdP6u9ECKWGPy9QgsnVAeDvakke4Gq75BIKWAECe+lN9uXOP67Dhr35yINrMw
 FH+x4aQf0yaTBiHECWi/+dM4qBLeBbBX1Ahp2ePCXjULuirEKfkWy6b6mKBnnplNcz/0
 4nD8u+fWhI1n+Wd+zgiyQqoD6NZaHQ4qkjIYz5KJW1ekdZif+UbrJBpE/MXTvLHFYUmc
 tEmBQAXKiHTzO6qi88VwxQkqgqurLxVu6GJkB5UJ816Oc8YNuIuuBhWApRWPLQA6r4af
 V97FuOOLjKdj13dz/pTx6f6iN2Gze7WEHha/8xv0yZDFINTekOoM2CZRyzRg6md6mBK6
 UmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768970697; x=1769575497;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Bf1Pd8Z9/BnT45YObIxltuEdos+6OIjVxfCqB2A3U4=;
 b=s4dhroMhTOb2jyJhhfNpeehXBHYjOY1moP58ccnhWJTkUyJEY+cHMoFeOmZif/tvyd
 nnbb60DKeWW8WrtPHnC579LsCHOn/iQrBrvnn4K1UZRTaHz2AB9B25zatPw1lCLDwicP
 b91ORuJ8NW53nzTxVuOjA2ODf8JBQoj71XwrrUh26a97mhOuwCbSxaTXJAvMCS9lKGQx
 WqsH6ijYTpxbFCE7lj53MuMHljUYFBovrs5eCqK73tFZ0kdXHqtWAFIirVY7pA9WUy9v
 DoDSIcg9qjWhzk0m9t8GiTMD9m7Ph/IeRyreyAg8JDqxmHWqdvFLlNjlnL2w4ed5zCis
 wEGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsLl6/xiUFjFzi37csrVkukE+3UHY7+w741+gUQbz4nBu+O6kpwuDPIEoQ0ZedUvuUkD1gzrnq9K/o@nongnu.org
X-Gm-Message-State: AOJu0Yzd4w5U4Rn5zW3HLh9E/8cYCt/6UmA4UWO9rkBnlfpUr9Wr6stg
 b6eUvnJwFznIK1c6Hhc4Us76m8cD6GX82W7Nss2rFtCsxOA+eCuq+UYlHt/lwpYcljg=
X-Gm-Gg: AZuq6aIDrx9VwvZtYipIv1tGN5OZHjbAA2KUY24bUiW2j/Z3SKlYYitGcuo7Hwy94tn
 9peedbE2daJclvWp7cff9jAKlyPvN7BfwaYJRv2T6qHYAnkdXDLj6wkEqr75svtgTxnBkpf7+x2
 RqEJ56e1UCDckLujtc25Z7FWlsgZipAh2FFDBeu+Mq+SXZPcaYQiGrVzarc+RW362YeF2qjc4TK
 XLBM1wFLGh+CZhxJAGAvlmJ07ZzHqql+1PlqkQTfNhXgYaEfNqNarlsiPuAzySOq+fyT5IqSfta
 KlOG5YL6KlAVzGQn20qqDebup4iByysQGl82s/MYxfaDJ/f+kUm14aJmc4IJgT6W49WveUCLBIu
 H/5z+VCDR2w1+vc6CGQfSyZOjMCslWLAFC4+svbgF7UEFhXKcbntmbHfU97iZME5DxyXcPnb1b4
 24uWiGvAoIqGn/CxUNNSLnuZv8W7YvpF0Ep87rfzej
X-Received: by 2002:a05:6a00:1ca2:b0:81f:3d13:e069 with SMTP id
 d2e1a72fcca58-81fa1780ecdmr12585804b3a.8.1768970696573; 
 Tue, 20 Jan 2026 20:44:56 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa1291ca2sm13596151b3a.54.2026.01.20.20.44.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 20:44:56 -0800 (PST)
Message-ID: <a5e70989-9733-4eee-aaf9-f72d507f11fc@linaro.org>
Date: Wed, 21 Jan 2026 15:44:51 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/29] Misc HW patches for 2026-01-20
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260120183902.73845-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/21/26 05:38, Philippe Mathieu-Daudé wrote:
> The following changes since commit 38879a667fbb4ef54c70de71494882615f600a64:
> 
>    Merge tag 'pull-tcg-20260119' ofhttps://gitlab.com/rth7680/qemu into staging (2026-01-19 09:04:31 +1100)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20260120
> 
> for you to fetch changes up to 84f82697f8294377224aad9f7cc499116ae0ec49:
> 
>    meson: Do not try to build module for empty per-target hw/ directory (2026-01-20 19:34:44 +0100)
> 
> ----------------------------------------------------------------
> Misc HW patches
> 
> - Generalized IOMMU test framework
> - Fix Freescale SDHCI endianness issues
> - Support for zboot images compressed with Zstd
> - Pcap support to analyze UEFI firmware traffic

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

