Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D54CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 18:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSfPw-0000Cl-DW; Thu, 28 May 2026 14:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSfPv-0000Bp-A6
 for qemu-devel@nongnu.org; Thu, 28 May 2026 14:25:15 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSfPt-0005en-Fd
 for qemu-devel@nongnu.org; Thu, 28 May 2026 14:25:15 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-36a7bbb9698so3815155a91.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 11:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779992711; x=1780597511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ey5AQMsOWoVAP4vkS/vX0B3ibwQsp9EyK53od6qG96k=;
 b=BElcSQZhOiAnK43tgbiX+CKB5OPydUgNuH3J6ssj0mt8s+0elFc9IRqVUDveztCg6v
 titepGdpjsxIRT0vPQZyYHqlctFo4YiBkpjRGTrTndp0eykVsog1gpUloaUdF7m8trb5
 jG4rM/X+5duGySd6h/GFjWPa+i1xDLWanK0OT6N0/CXV48n8qu3x8XXJHOrnev59BUKs
 s8dsNHMPgs001fmBp3QZkpwAfL2XXiTbNNP0j6d8Fgd0KG0m0oq1UBmMg5qOGuraNiRA
 z3aL8IfCn8vSMSJwgkXEZRYqNqzUBJfKKQxc/3tR7iBwW/gM2fkNkKUu1F+g67s545XO
 dOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779992711; x=1780597511;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ey5AQMsOWoVAP4vkS/vX0B3ibwQsp9EyK53od6qG96k=;
 b=KOEtz5DBdMyRO39m8kCJ80rWK0j6HP7fwnbOfEFeZbKztJuP86N+GkXcZCpclLaBer
 aWj9LvzSADuulrdIvJlJHf4ZyRQ9MH7W/4+4yN+kb8pfRqcHOkk3Bqr8UjMQH/UI5NiJ
 b2xSKxf/fH+IDSipETMu6zeoY1O0p7zFqFK5bpK6983uSgo15oPSGs+7cViWFdw/xfK9
 aakQMtvRlUi86LgZSWaJHMe4QaSS9P1O19vxxzVqB5e5FHHbf2EvSCxvjveqUu2qfg++
 v3FSOY4SmWQWs+7BG8yYEJwZ9x8O6V4sNvIN0PoEaVeVpzPOlhZjGgEtARDI+anKqUKR
 zKQA==
X-Gm-Message-State: AOJu0YwKBrAJ9SXkNsA7zXVugw69hJfN3W0YgKDxPmrS5mCbXFL2efnY
 kSoNF/eHdeZHlKMw1goVei5NmMaybCIpaQiegQc6/i1MfsSAYjpEIjTffd9ucj5NumhY9hN5Cwr
 n2Ogh2X4=
X-Gm-Gg: Acq92OGc822ywIZdlmQbiQLSi/kAa/KPfOtLz0zdy0E/t/eiRPUPXZd3npfF8Rz8KAo
 qmEHOSqV8LXB0U0QgD4NyYx5vg7FFX15PTALcyqXCXrsQaW+98crrtxyWDnJPw7Mdmo8hRuKgrR
 LeO1AXr1x1jXb1wsAIjzu+4Eu4cvm+u67MctRv3uWO/jj5Cf23m1UiVMZjkjlWXckzND6YRx0Z2
 OMPKu9LagqSMBZ1b2FBLRIiL7KTDISCkGNjF2vIzHoJsqdHeriWxoeI1wRec4fyOwqSsFQEFkAf
 TSsLOCA+/pZQXkIzDLVVrZ/O10mNdYUwy5S5DUkZWWobUh8SxCpBD65imvpQwldaZjrtLNFW28R
 uloQY+7CO5pU2uGXSPKS1QJqR7hUkDasU4tvrMPRJRZgXkG4/SvAByU/ekh5LVW2XRtQ8VsNrSJ
 2c2a/zWb1IimpAe96yXOMcSTP3dAFB+D2ujpVqR6BKB3SKG4k=
X-Received: by 2002:a17:90b:51d0:b0:36b:b3f4:d574 with SMTP id
 98e67ed59e1d1-36bba8e3505mr161930a91.25.1779992711196; 
 Thu, 28 May 2026 11:25:11 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36b90c03259sm2136819a91.13.2026.05.28.11.25.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 11:25:10 -0700 (PDT)
Message-ID: <98dbea58-e2a9-4719-b680-fb277fd82adb@linaro.org>
Date: Thu, 28 May 2026 11:25:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/arm: Setup new registers for GPC3
To: qemu-devel@nongnu.org
References: <20260528-jmac-gpc3b-v1-0-d34c46c5069f@linaro.org>
 <20260528-jmac-gpc3b-v1-2-d34c46c5069f@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260528-jmac-gpc3b-v1-2-d34c46c5069f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 5/28/26 08:34, Jim MacArthur wrote:
> +static void gpcbw_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                        uint64_t value)
> +{
> +    uint64_t rw_mask = R_GPCBW_BWADDR_MASK | R_GPCBW_BWSTRIDE_MASK |
> +                       R_GPCBW_BWSIZE_MASK;
> +    ARMCPU *cpu = env_archcpu(env);
> +    tlb_flush_by_mmuidx(CPU(cpu), alle1_tlbmask(env));

The GPT affects all EL, so this must flush all tlb, not just EL1.


r~

