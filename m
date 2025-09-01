Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAA9CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyNd-00087r-MZ; Mon, 01 Sep 2025 02:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1usyNc-000873-61
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:51:04 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1usyNZ-0003p6-Ja
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:51:03 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3cf991e8bb8so1573353f8f.2
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756709459; x=1757314259; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g77vqNCQJxDfwO4ALWHfnlzQ+Rcp4ya1rTbQ9itgQ4I=;
 b=nmMP80zfmqcjrRWzaJtJQnj84+PuYla9j62xtg/TuGY76NVVF4e+rWdLMWLqb+vCoH
 ainjWsQj2liSN8uulzMHsK7ZLmcMf8j/ClSDQUz6t+JEtv2DOU/FsJM1HsWzzYz4QG3X
 dAjb8t8VZms6Ia40d9boCyJdLhr4/CguDihopVqCmruRmFhgOf7repLnoKKv7+K0Cytw
 V3ekD685u0gFpwUCKfgm+mkNanRVHKxUPzVMN8g44VzdeETBVjpNezilxZRNpgSDUB/M
 bnv10/UEKnLbDE4DWZCzurj/UFoEUZ+VfsK7ZbnwtzLLEWTHfq9zkLSwY13L2ATIw8fE
 vi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756709459; x=1757314259;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g77vqNCQJxDfwO4ALWHfnlzQ+Rcp4ya1rTbQ9itgQ4I=;
 b=oaOOxnwe0/nzED2ZmjGHugUh5Q8RFqzc6UQyHb9v3JlXzymuJbSINdVOsAOUU6Y7S5
 O4bEe2iQL5VJWfduQPNax8ylBIduwDvPmc7EOgW4j4LzXPvu1ynMmCUzlg7z6sfB9caK
 uo0dQ+bA7LlfAhkW/y9HpgymTWO4LjcxBgC2w7PY7TNV6Bqm4mOgO9c33QC29mp/eYjq
 ouA1gj8ssMH7QySJ2H3lDWEHVWfQTr5Q3ehKt39butSyW0lVILuHapPI6w2pimmOkfIP
 XcPFH4Iyat1pkzBXHiX2Xxief3qx75qEoNa7vx41xSB32BhLm9wX/SPn6hcmKPgY+ChT
 cTIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYhPYUPpKakOuIn/yut9q+MEo3BiV5a7fX4df6wcsPZIsNWg+J2YRDRWfWweg+aZSL8up90FTptaiR@nongnu.org
X-Gm-Message-State: AOJu0YyqFLYKMH7jbnp5qd/NEtUsqMOKa3F6Ucb2Uef6sqwQUrEMR7Ab
 wJXvngaq1MnJto+udKBlMCs6CCFPdGD72eBQ4zybULcMHoJ+yAKXktQGegXGSnk+m/U=
X-Gm-Gg: ASbGncvrJUy7/iFiXpBgq7OgfabAQiFkfsH4pgTOxunI+aObSCV2b7b9ZgAvDBtsDmm
 B/nHgaLy7g9ZqqalC50efrk8cyAHjCLbalnavJ6devOkUL2d3ykDWfz+HofJKMu/XpUURS7XW5F
 a9C0f7vZEx5e5ZFSPMlW70EofHdow1Bjaszz15zR9JuzOw6FClvauBaL8L/HjahuCo6oo4+UhIN
 2hVAJW+qot4cvcLUndpOTsGPqhmFrQlosDi/JYkv/Hknj7ZfxEYfdP4Z+sPuxF49cif43XPVYPv
 N35z568zBtA7UlBmiU69UpvDLSBtt17iGyxfHDHGps02jtmb720EL/dJhdQ6AFjW1jrerl55gEL
 8OjRWbH8NXawCIt/PzpHgdISPHMaqOIXxs/AE4BpSXWdXwQBLn3CBesoEnWcaPEa+dk/Uz8JKHr
 7Y
X-Google-Smtp-Source: AGHT+IFc+jPUMsXvD4FGorS3LoO7vOUdrQP7ADyjnfbdawyDmyl6oa+ns0wWdBFArwfKGbleaOFpcw==
X-Received: by 2002:a05:6000:1786:b0:3d1:4c3d:1933 with SMTP id
 ffacd0b85a97d-3d1dea8c5e9mr5462114f8f.43.1756709459304; 
 Sun, 31 Aug 2025 23:50:59 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34493b8csm13614105f8f.59.2025.08.31.23.50.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Aug 2025 23:50:58 -0700 (PDT)
Message-ID: <16e6ee37-c16f-425d-b1e9-82e310578cc3@linaro.org>
Date: Mon, 1 Sep 2025 08:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/19] target/loongarch: Use MMUAccessType in
 loongarch_map_tlb_entry()
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250730030202.3425934-1-maobibo@loongson.cn>
 <20250730030202.3425934-8-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250730030202.3425934-8-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 30/7/25 05:01, Bibo Mao wrote:
> Enum type MMUAccessType is used in function loongarch_map_tlb_entry()
> rather than int type, and keep consistent with its caller function.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


