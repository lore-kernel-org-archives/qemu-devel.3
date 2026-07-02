Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54840C43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfJvr-0003Fm-7S; Thu, 02 Jul 2026 12:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfJvS-0002WD-8A
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:06:06 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfJvQ-0007F2-DC
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:06:05 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ca1479dfe0so19324915ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783008361; x=1783613161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1adxvsljjHCSqxX3dc+HSBl1+S/uLoRWp5nPn2BGfFI=;
 b=A9FgJ07CNNXMvo8CaW6M0i4X516D/i3yvzpl2+OxiX3dIGq9rW4sGBRwS7rfQI7yVx
 cyxojRzYTpkAPprdzJu5fLF8TnhseaWAeyDCMkGn1Q2Tot99fCfKV2K+yAyEYXlIlvIc
 zyPeWZwKhv24sSI49uV7EANRsDyq2DOxAcElSvyqjd1YyQ5hJKIn3SF32xl2oAH2M0HI
 iC2g35hZYYoI+UXXpVAQ6RbCoGx291KNwCN3f6y/WqOJiu2BPOcyyn6XOp187DV2oITZ
 UVJjeuy2jajOW27gbP9azW2EYm0gQpPHi3+xTiA+BJEVSjA9SQub7Bz4Y1Id4POh2zmM
 9eAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783008361; x=1783613161;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1adxvsljjHCSqxX3dc+HSBl1+S/uLoRWp5nPn2BGfFI=;
 b=XcFO+9Y2+0DpWY5hzPWCbfB9/YMU8ujPdEysXnOCWQ6azHZpm2K1sF/xblPTobLi0q
 3g030OUPQnccunfGILh959uV83ZBHwN1u9q1tQrs8upFpQx5OeQuJZNZJz/OKsJRPVVP
 xB43i+uGVqns+R47ogv9r6TMsce0Dw13ElVPO04SlC8aBqV5MANjMWH7juRovGU+XN8T
 FwYK3FmN7eg/rB/+9K21uzQIKry4ThE2d5hAlMIcqsnO7BpV8X3ZYCmzGxvv3tkclhN6
 zQNonPXfww6NKqcCCeesSbiyQcSMoTwNEtqlgsgxFuFJgZNG8SOBFArcYy2tJcgKLi+5
 JBQw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqmSkzNJ30WHPF6mx3toe5u0qcwyst6vFIqfAJV905F/ecKRACGouoAf/2WCnC+0cgbgW0+JEzx+GDz@nongnu.org
X-Gm-Message-State: AOJu0YxNPF6zpV020SP9lat2K6hGF6SLxKEQyZJLf170X5p+1L9qTKRy
 GDv2tBA/Z4uEOECwx7QmfZFkbBG+iyK0oa76MdGvksKT1JtWe03V6oHHsVxhquAhkTA=
X-Gm-Gg: AfdE7clGS2F3Vs1LCRU77zxeKrbSxMH8YGdsk+SlFYmbqyOMqHGxQOeCBwNVi7HQ1V8
 4Hvq9RXsManXExOQo37u7jpWEmRLOMyVxuxQYkPopR3N/Xup2h8MMiSqMVMJzDpKxI+b0RU5whv
 SOo4s8X9vurtt62NPe8klBg1j4YN54otu5GlQzfXqoD0KyawnKVI/S7VRCvDGuOAWOLPIwNbw5q
 iywz61DIkcUktdZwd2MKFUBRD3zgH+3Tblhskh+fC7NxLN9SUzp8e9bRmm45t6Y4VNf0rGDP2AT
 gbRTRwPkxf0bhD7gvIz6YlrIQG+990KpDSUJhFkXFHg+XhGG/gvvJGCYML2uO66ykQwtN7QZb6g
 m8B0oDDUA/t7juoA7Zg/cSZL3m3n+St9YFU6mY/ZnLfmeMAcsmMERmMybX78ZanAt0LeQF+4qk2
 jbpgRd11UNNdta1zJMV+wQTfSkTVXpWE9vSecLQwnBshpmXHwEkeNvVGO/tw==
X-Received: by 2002:a17:903:2311:b0:2ca:75b1:e1e5 with SMTP id
 d9443c01a7336-2ca7e7109d4mr70201545ad.4.1783008361122; 
 Thu, 02 Jul 2026 09:06:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9a8de800sm15902215ad.12.2026.07.02.09.06.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 09:06:00 -0700 (PDT)
Message-ID: <529683c4-db23-44c7-a4e9-6149ac2e9ea2@linaro.org>
Date: Thu, 2 Jul 2026 09:05:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 21/34] target/arm: Update contiguous first-fault and
 no-fault loads
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
 <20200511133405.5275-22-peter.maydell@linaro.org>
 <e9cdc625-7ded-4678-965a-a98f18150ade@oss.qualcomm.com>
 <58d000af-4213-4600-83ec-e418ac8682b8@linaro.org>
 <8c5eb29b-57df-46cf-8678-36182e052afe@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <8c5eb29b-57df-46cf-8678-36182e052afe@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 7/1/26 07:08, Philippe Mathieu-Daudé wrote:
> Sorry for not being clear enough, I meant the TLB_MMIO & TLB_WATCHPOINT
> checks just after:
> 
> +            /* The first active element crosses a page boundary. */
> +            flags |= info.page[1].flags;
> +            if (unlikely(flags & TLB_MMIO)) {
> +                /* Some page is MMIO, see below. */
> +                goto do_fault;
> +            }
> +            if (unlikely(flags & TLB_WATCHPOINT) &&
> +                (cpu_watchpoint_address_matches
> +                 (env_cpu(env), addr + mem_off, 1 << msz)
> +                 & BP_MEM_READ)) {
> +                /* Watchpoint hit, see below. */
> +                goto do_fault;
> +            }

We still have TLB_WATCHPOINT == 0 for user-only, so that won't actually fire.

We set TLB_MMIO to non-zero for user-only in 6d03226b422 so that we could force slow paths 
for plugins.  These days we should probably rearrange things so that TLB_FORCE_SLOW is 
used for that instead, and make TLB_MMIO be 0 again.


r~



> +            /* TODO: MTE check. */
> +            /*
> +             * Use the slow path for cross-page handling.
> +             * This is RAM, without a watchpoint, and will not trap.
> +             */
> +            tlb_fn(env, vd, reg_off, addr + mem_off, retaddr);
> +            goto second_page;
>            }
>        }


