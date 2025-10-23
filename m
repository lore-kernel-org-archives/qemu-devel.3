Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4043CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 10:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBseS-0006YI-Ne; Thu, 23 Oct 2025 06:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBseO-0006XJ-TH
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:34:33 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBseL-00075C-Ew
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:34:32 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4270a0127e1so415507f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761215665; x=1761820465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Herf6G9OYYXgEMxMbMK6HRs11hJAEUesZ+KdZzANJ38=;
 b=DOD7xWGhRTt/PvTACFc70l+1FIV+erFcqxmhdTg6ne1uilMa7azWH1pOnUslKcUzEK
 2/ae+52Hp/GujAJ8n16QzDs9uco5PRW933rasjnFL3aPV6ne+ImTFhZf7EvUmAG935W5
 gYDwasEIHNerUn64ORJOYck7paDrW8pXKKZTSNQ59kK2YuQMmvJZRG5UcCxK3v3+335S
 E6UZ0zvfOJnlUP75GzJ5Zi7YOqHfUBTNv0UN1+LdAfM2He0eZihIwxcFMa6SRoec2463
 DLCN6z3aeZaf3byX6RdtZhj/ezgUAytLUGRKNWX5uf2dwrvFR0yfCtaYbtX7gJkvdFcv
 OHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761215665; x=1761820465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Herf6G9OYYXgEMxMbMK6HRs11hJAEUesZ+KdZzANJ38=;
 b=DzQau5rqlVBOBwO47YKKvNRAF7FzRCnswPaYc45t7/Q1jkaRsFORvYuKh15/PNObh1
 URq2ioPmlpyGmCo2BWVC1RREOYp8Ir0yCYdqBYSd+3nRzgVS3eq7FeCw5IiYbtZpAPgO
 cey6Xu73kzvNeuTj5obRf2Aj4HjVLIFZqfJuRuGFiFpiuJw9oyBtsWP1eS00Qz+2VUGS
 vPsem1sbsR6pSD5BqgyqMdf6M5k3ULMDbTm9kVuVdFy4QLJ3Ua4hZW+M/RVtufsY+13R
 ir5K+640etOLgGihj45+WH11cBF4WcRBvQCWeheXAKrxtCSYQlhgABFMFIRYWYcakI3P
 lhmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMN73tg8F0XWb30CyXcFFDx2tPaUSEEctkKwlnF60XErHiVX2cnwD2xHCG/OPf16z6Cx/rsrLyssy/@nongnu.org
X-Gm-Message-State: AOJu0Yx7yzAejcUZt+NRYB5VUBV4EiGiCdDcDCXGOtR57e240SamW2JW
 G1hvbI0c8PFEjXcVSNcX6BJGU7V1r/RkRURPXP5T3Y/7WPqlzVjH4bipK32cy3MWPEI=
X-Gm-Gg: ASbGncvf37YJ+SnGyy/nKLfg7bPXWBzQSU6QTxQSabCOIpp+d40CTvYlysZiV8cD0YO
 5aXEwjWW9+PehKHHSvBMd7ee1oh97d3bDNo36of5M3X9bG48AC5td3c+PhIDeLWClu+95eXq0Fr
 JKbFgo+1CKigix5D++/WdDxkhCJzqarJd/rYpXsT38jLIuE1kExgzlhzvNF3friIrSdGthObt2f
 hSIcRboWFy/qzyX7M4K0Nk5vfDpXGWJA92gnGLCUPKP4ZBg+2K7FTxN5I5iiUM+Fm40khcByMqt
 4PrjRkDJILFvDE5HnqkmPZ5nz87D3vw9AFvgePsb32d4ZLcgzy/8DXp3DvEuqVTtFcfc8H2ynNn
 Yi6peMKQiNV9HAOUAFQdczaF/Z7aA4DBiSrCgjrvprx3HzbbdbiGaEc08fe9O4QQvizjm4EMUXO
 XqQK19gSrtRJ2b4AnW/DBdcVKo3pDxZV6l7+Xc2mlXFFo=
X-Google-Smtp-Source: AGHT+IHQ4GIMmKMJHlPADhCkgXORbpzWpN8glVx/2ABfKnoswXCNNrcTs5sGwdLb9mRPbosH43zguQ==
X-Received: by 2002:a05:6000:22c5:b0:426:ff7c:86d3 with SMTP id
 ffacd0b85a97d-42704d4423amr17482338f8f.13.1761215664707; 
 Thu, 23 Oct 2025 03:34:24 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acd69sm3276609f8f.24.2025.10.23.03.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 03:34:24 -0700 (PDT)
Message-ID: <c1037a81-ffb9-40d9-a76a-45cbb33bb09b@linaro.org>
Date: Thu, 23 Oct 2025 12:34:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Add assert to arm_to_core_mmu_idx()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20251023101339.1983809-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251023101339.1983809-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 23/10/25 12:13, Peter Maydell wrote:
> Before commit f76cee647c ("target/arm: Introduce mmu indexes for
> GCS") it was impossible for arm_to_core_mmu_idx() to return an
> invalid core MMU index, because NB_MMU_MODES was 16 and
> ARM_MMU_IDX_COREIDX_MASK was 0xf.
> 
> That commit raises ARM_MMU_IDX_COREIDX_MASK to 0x1f and NB_MMU_MODES
> to 22, so it's now possible for a bogus Arm mmu index to result in an
> out of range core mmu index (which can then get used as an array
> index in the CPUTLB struct arrays). Coverity complains that this
> might result in an out-of-bounds access.
> 
> The out-of-bounds access can't happen because we construct all the
> ARMMMUIdx values we will use for TLBs to have valid core MMU indexes
> in the COREIDX field.  But we can add an assert() so that if we ever
> do end up operating on a corrupted or wrong ARMMMUIdx value we get an
> assert rather than silently indexing off the end of an array. This
> should also make Coverity happier.
> 
> Coverity: CID 1641404
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/internals.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


