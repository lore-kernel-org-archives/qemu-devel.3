Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E98C369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 22:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6zqB-0007pR-4J; Mon, 21 Apr 2025 18:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u6zqA-0007pE-2q
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 18:42:14 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u6zq8-0001Gi-1J
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 18:42:13 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ff784dc055so4130516a91.1
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 15:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745275330; x=1745880130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lf61QPzirPuFqwj69Zxqab2/6NFuhx8wWZm260vQwhA=;
 b=j0f7D4EKxLKKHoD1dH7sROYwgYiUs9rqjJzJQdq0wPuqpfVOmuMkptWXV0IybmJecn
 Oi8lKYBFfDFKt15epNbDNbc4M12vsRHHz5E//VXZQPeCh1zkw0nBT227H90kp/LNcXNz
 T4hkkvmdOFD4iKgLlnSuwVXuyYJ8VW6E6hyjQ7ALDbq9+HYXNNEyuH10gvsxZ5fqICCi
 MYPKw4q/ob0ZBRxCYqA7zVBNagmd8ZDURChHlKzEHqIl6V5ObPFSkoaRFPI+104sIrUZ
 R4s6HqzlyYykT4FshlCN+gqYQdfzDGjpHjPj4CasbsameiNYxVsb6QDyl+nmfie0HRAx
 4bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745275330; x=1745880130;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lf61QPzirPuFqwj69Zxqab2/6NFuhx8wWZm260vQwhA=;
 b=lyPtL5r12G+XrGTBlQSBU7nDTjOMn3kayBTO26a2r+gO+QZk+1xiiR5C3AEYVmNRm6
 shIrEyntn9JGHN2dbOk2wIojYA45RsWEeKAE9wWd/KxPRJmaCiVttGk82n0FHQAdKdTN
 3PKNt3HSD9r3dzA2xtkqx8Q1i9q8z4kT9IxleyCdw6+Z3D5YV8ecxV1agBLC654sl0f4
 rNpjTd5LTTatMbf6U9ggDrE2bo5lxjQyW/fFUkGN2FFxPvVzk9zlfe3kmEW7LXTXOnZ+
 E+DiI2XPgSIFV3+sMfuFxVYB5/S6Vv0sN7clJtO2Sul7sq/pmcxiT2kGcNEPgX0WtRkp
 PiRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRIl4a5PKzZ9LW5FRBbGmDBPgE346/YT3NgfG/hRFK1DENex0MCcY7nWj+UwjTB4Xi4VMc6weJDIaO@nongnu.org
X-Gm-Message-State: AOJu0Yz9Jb1+TNu1M8t4EcT4j8ztQOxVmATrb5KDZZc+rnuSQFNqxaJV
 LcqL/xGYShhplFHGtoxQgS+hb0Nlvr6A1gy7dAgrpiIOC3Vbu2Ghj/11Ynd2gsg=
X-Gm-Gg: ASbGnctBz6lhKDpHgBdadR+eLxPDwvfLlBAfEACQMoYOPYtgtca0xK9ve3kpx3HdyHq
 2XPK9IWrFM0eVz8wSvOVXTMbcZy6YO6V171AlkOOqSHZaUI4YAJnX/devWOSRgJdBVxoOHUzRaC
 D/A4N/mNzqmHpjEMYbUJWeye4Ci+L9z1uRd5aJF03o+myLDVzXvBdvLCk6i98QJdv82nJmYr+L3
 0w9F8g3ZgVdr0F+XEAtQPeyQAwxybZJwyPTz3uLqYD05sR9QJIsNzUnuNGTXvrScD7I8T/IE7hb
 0cqnVPgh1H4Tcsv4Tzaf50JmhKskSUtIkS1SX3A0vnYFgDibh+4w59WzNBypnW13vBggSK2TGz9
 uSpe3oNI=
X-Google-Smtp-Source: AGHT+IE8NtBZHqbDvNhzrMyvuRk25JLowtfBQ9R2H11GLPLrx6jzW6B+RqCQeLMr24NHwepu3fiMXg==
X-Received: by 2002:a17:90b:2d10:b0:2ee:c6c8:d89f with SMTP id
 98e67ed59e1d1-3087bb57376mr21422458a91.14.1745275329922; 
 Mon, 21 Apr 2025 15:42:09 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309d3409c3bsm36343a91.1.2025.04.21.15.42.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 15:42:09 -0700 (PDT)
Message-ID: <fab8fc07-bdf4-473b-937d-189087ea8804@linaro.org>
Date: Mon, 21 Apr 2025 15:42:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: riscv: AMO exception is incorrect
To: Eric DeVolder <eric_devolder@yahoo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <89209876.67593.1745258284104.ref@mail.yahoo.com>
 <89209876.67593.1745258284104@mail.yahoo.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <89209876.67593.1745258284104@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 4/21/25 10:58, Eric DeVolder wrote:
> Hi,
> 
> I've noticed what I believe to be an error in the RISC-V
> implementation.  The RISC-V spec[1] states:
> 
>   Note that load and load-reserved instructions generate load
>   exceptions, whereas store, storeconditional, and AMO instructions
>   generate store/AMO exceptions.
> 
> For an AMO operation, a translation page fault should record into
> m/scause the value 15 Store/AMO Page Fault. Instead, I observe it
> record 13 Load Page Fault.
> 
> Here is a look at this using the execlog plugin:
> 
>   0, 0x3fbf6dfee8, 0x8f5b02f, "amoswap.d               zero,a5,(a1)", priv -> 0x0000000000000001, scause -> 0x000000000000000d
>   0, 0xffffffff8031b5ac, 0x14021273, "csrrw                   tp,sscratch,tp", tp -> 0xffffffd600926400
> 
> In this scenario a Linux user-space app issues the AMO to an address
> that is not yet mapped, which causes the exception 0xd 13 Load Page
> Fault.
> 
> I've spent time looking into this. The AMO operation, at run-time
> (after TCG), has a call tree that looks like:
> 
>   code_gen_buffer
>    do_ld8_mmu
>     mmu_lookup
>      mmu_lookup1
>       tlb_fill
>        cpu_riscv_tlb_fill
>         get_physical_address
> 
> As the AMO starts with the read/load part of the operation, the
> translation fails since the pte.V=0 (not yet mapped), and because
> get_physical_address is told access_type=MMU_DATA_LOAD, upon return
> the raise_mmu_exception() turns that MMU_DATA_LOAD into a
> RISCV_EXCP_LOAD_PAGE_FAULT.
> 
> This example is a Linux scenario, and I think that I see the Load Page
> Fault happen, and then upon return from the exception handler, a Store
> Page fault happens, after which the AMO is able to complete. So Linux
> has been "gracefully" covering this situation.
> 
> I've looked into trying to detect this condition and change the
> exception_index/cause accordingly. Fundamentally there would need to
> be state reachable via get_physical_adress() that can indicate an AMO.
> In the short time I've looked at this, I can't find it.
> 
> Advice/tips welcome.
> 
> I'm on stable-9.1 <v9.1.1> sha 0ff5ab6f57a2.

Fixed in 9.2 by 98f21c30f5beffc45232721ae79c019df58ae9f1.


r~

