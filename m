Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF53CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tnh-0001VW-Ku; Thu, 09 Oct 2025 12:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tnc-0001V7-7E
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:47:29 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tnW-0004iC-90
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:47:26 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-793021f348fso1118081b3a.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760028439; x=1760633239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SKQG7ejLqpGGpxpXCgpef2DjMI2GPjfUDuLg/RQNH2k=;
 b=LgzefDeVD2OW7097kqHQw0CF8tj2RxizQGQgSiPU2KiHUtr3hcYFV1CDJ+rdAI876O
 2r96Z9czFX8LuAPxvDQObftgB/CuX9JPjg5z3BSxQhrpl8b1Gjx1w0OMHV4fb+t77syN
 zFLvHvRXcepJB/EuJguyvnG+0q8R/2Rng+ohyqthYYC0g2UR0NmWctU2/i+fSEkfF9Hv
 V6+LIoZySRbRYCj4eTdORTrqSNLO08SBcpUD4qfxMR8+cSgg+q3uXfikiWZnrZvGr1Im
 SuDtz4DSo+qIFBXq/Y0QRyLi5aXAB7cq6hLS8qSUURLFY7fBxbiWdhQAQ7Zbhx4Nnod2
 Z9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760028439; x=1760633239;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SKQG7ejLqpGGpxpXCgpef2DjMI2GPjfUDuLg/RQNH2k=;
 b=BZFYcUd/iYWGA5XjqHC8yslsDZ9l308RKb12L60TfMNgJ8UhQc9xxxsiib7/CM65dj
 00s9WFm3WYSxaczbLU7doJFccO3GmpgZwATgPTgDpNcoi5PMkfIYhPMAVWPfAwXt8Lb1
 mMYoZJLwe286IkqoeYU7qeIpbaPeGvr6nTFKwwhrdlaj1IhMyZx6hpmAQMzD/Y7Y4wSu
 kfEPMWCzXqDnH/T64406fTuSYP1NEEQ98y+5kFG/mEAVgbkMzCl6txxfq8ievC39c6Pw
 fDubO8Lwzj5EbGZhjzcm6UPweBYlPMUJvjHM7YtR837csd0GcHNipQ/zVsx2Natvn+u3
 /0+A==
X-Gm-Message-State: AOJu0YxAAO87GW/aeiJg5JFeT0KvIgOE2upg6hH7iJRVfKbK39toX/Ta
 F6sH4koFpBpJTBsG09I7Cwlu1yu2PbI/QoNIaStYDFnHJwRdU/SOWAferQ+rleGA2V7/y5hTBe5
 JAB8i3ig=
X-Gm-Gg: ASbGncuGTFR9qSCUoaWhVn/Bp8dkDDzcqrAUaDcCuw9wd5TUMyXifmGUYIo+xTr+RMl
 Fw8J3bgRFeZ/tEHwREt5vW15yBmIE85Dnh1devBwtd5N3oq1d7Px/3u1PMGHEiWdUKtSpMF+vRx
 DZ7iTzSIZVC1iu8o6aCi++FAyfAkfNoSQuiFh0Xei4YF/ta5UenkFQopePf35LwDVCINDPMkYh+
 znYWNUgAa54VweCJ/dOAYqP9bG5z959Y8hEKQOUwNCt3k2ABNi1jBgKEUV/JE2rQCM7mNurvhpb
 xokdafBdvkdZXMOSxfIWRCYPGiS+tCPZTAiesNdgR3dwAhbW7nGdkqFFkSPmImEQZj2uHlpnaik
 fZXbCggNWhmyxQi1CKGeVnUoQnymtCK3vFzjrnszH7UQMh3T09Rz+BXC9ab6PRmrb
X-Google-Smtp-Source: AGHT+IEwkzVb22EAdlqrrzoSPmJSrDE4oyOEnuW8IVu3GtYjHPtaIgHi2h2NrBSWsiTWdcgd5P9Y8w==
X-Received: by 2002:a17:902:e851:b0:26d:58d6:3fb2 with SMTP id
 d9443c01a7336-2902729031cmr128556415ad.12.1760028439087; 
 Thu, 09 Oct 2025 09:47:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f08eb7sm33356645ad.82.2025.10.09.09.47.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:47:18 -0700 (PDT)
Message-ID: <51f0489e-a6ad-46d4-8a0d-49baa8f2a302@linaro.org>
Date: Thu, 9 Oct 2025 09:47:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] target/openrisc: Remove unused
 cpu_openrisc_map_address_*() handlers
To: qemu-devel@nongnu.org
References: <20251009081903.13426-1-philmd@linaro.org>
 <20251009081903.13426-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009081903.13426-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 10/9/25 01:18, Philippe Mathieu-Daudé wrote:
> Commit 23d45ebdb19 ("target/openrisc: Remove indirect
> function calls for mmu") removed the last uses of both
> cpu_openrisc_map_address_code() and
> cpu_openrisc_map_address_data() helpers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/openrisc/cpu.h | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index f4bcf00b073..87201365a91 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -220,15 +220,6 @@ typedef struct OpenRISCTLBEntry {
>   typedef struct CPUOpenRISCTLBContext {
>       OpenRISCTLBEntry itlb[TLB_SIZE];
>       OpenRISCTLBEntry dtlb[TLB_SIZE];
> -
> -    int (*cpu_openrisc_map_address_code)(OpenRISCCPU *cpu,
> -                                         hwaddr *physical,
> -                                         int *prot,
> -                                         target_ulong address, int rw);
> -    int (*cpu_openrisc_map_address_data)(OpenRISCCPU *cpu,
> -                                         hwaddr *physical,
> -                                         int *prot,
> -                                         target_ulong address, int rw);
>   } CPUOpenRISCTLBContext;
>   #endif
>   

Oops, my bad.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

