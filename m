Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790FACD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ8ce-0007uU-Au; Mon, 15 Jun 2026 10:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZ8cZ-0007rc-8k
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:49:04 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZ8cN-0005fn-D3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:48:54 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2c31212104cso14212955ad.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781534926; x=1782139726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t8+mV9HiTD3Eu7FTUBwiGKuLUXtotABZr0FR4aRLwYE=;
 b=rQP9IwWjrkhV9kIKgCe5MclfQ39L15CR39xnqXntLWsFdVMvPQ0u2oQu9gsYHhZz2v
 mQRkIRW6catsKhU92FQzSfzkRw14aaFV+oHNMcd6mtFzb9dOKQ2yWQMhsWLN04NlTpF8
 U2VEgOrTc+7j7Keug3mgBRXmkF3mHKh25lHi1SDjdQmzVTUu8HnhmH4j2eK2E4Rns1m6
 v3U4/WcgxGAJDfiHCHWy7Q2bl7C9kHtpnKxbCqZ5AoGkqZ0E3Eno7QN4XCqpT/QwuFMl
 ByqdvOGCaTVQl//JEYSqOsCIQT/wsaZcoSXMSjm9LETz5t3myNVhiHdkIK3xaweFTr6Q
 ULdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781534926; x=1782139726;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t8+mV9HiTD3Eu7FTUBwiGKuLUXtotABZr0FR4aRLwYE=;
 b=XMRuNytRSR2Zxpz/pVlVUToTO3AxXPpbftOa9NSzP2LqfH1VFFFLpoDfwwKguiyZit
 ZyXGtVk9CfFwI0o/TAgAHYlguzKUPKlSdsB1ts0jBasJWlMwKNXeRniNvGKpbBc03K/Z
 UdiMd6Vh2253R5EMdvBKFRhl1qbNxx3uwbUEcfNMarqS4fa+DUaLh45PBDN3yvItamEc
 wovoy6e2eu2+C0cZPw8ABE/sr8P7dmStnCKyWelNh6D4lwXOZcxYwufNS0Xr1Jffw2/I
 69v/131BleuTBKD0ChpQ71uhPwI2ALCrg4tg9ZHEfpLz4A6NAdTMS4tqYYdZh1Ig5kNn
 OfeQ==
X-Gm-Message-State: AOJu0YyA2ADe5f6edWpiUTvy9QcJh/vFfRDFEvzRP2rk2fUfTpelObSa
 EPUCcsMllEkAA709AJUMGemz2EgKnlH/2sR6Jq03yYmjsnE9pwnHRGncUmQvFhV0c8iCi+BXbNT
 Mfa9U
X-Gm-Gg: Acq92OESCPTpVvvQFwQDEqUV6Tz0Uze5PMuU67xaAwSYVW3oVIAJIV5Vkg5v6X8WLjR
 bO08utzPlmX0qh5BoGbtV46Ye35SwcPRAoakv9Y3rCK1vnGYChtuZ04F+g0/71WN8d9CqyYM8ct
 xz4rZrLucF0GjcoL4nGwsBu5dlatkV2U0NeW5sLFOamLJ/vuZWPThRVeyETe/cyP3Ujyxg20RQ1
 HQasJfSnpWh51AO/aNvPdcGH67UlG+lu2Y4LspXSTf2u2EBZ3tMnSjF/4RwmxAym0VO2kudetHS
 Zg9gcV/jyXiPguwyDXUzFk0yCbPMyfHGpscvP/WCcVeBl+KD/CUJVanKrE3ZdYVRjpr2HJXPNRk
 Uj70/bDnkLxPCLgL+wcwmMkurTb1OgMRMSdCy04ALhpCzzFF2SkioC59cF12HFotIOvVJ3YaWXa
 OFCj9ejN3Djs3AuWOKp+AlBAQa9ZB/ZDBStf+T
X-Received: by 2002:a17:903:41c4:b0:2c0:aef8:23eb with SMTP id
 d9443c01a7336-2c66429085emr118076725ad.25.1781534926206; 
 Mon, 15 Jun 2026 07:48:46 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432f77479sm106698745ad.63.2026.06.15.07.48.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 07:48:45 -0700 (PDT)
Message-ID: <a133b6c1-46c1-43cb-9e7d-b206f0bddd43@linaro.org>
Date: Mon, 15 Jun 2026 07:48:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] misc: Remove pre-C99/C11 checks
To: qemu-devel@nongnu.org
References: <20260615091308.4458-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260615091308.4458-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 6/15/26 02:13, Philippe Mathieu-Daudé wrote:
> We uses C11 since 5 years now, time to
> remove few obsolete __STDC_VERSION__ checks.
> 
> v2:
> - Correctly use flexible array member (Bastian)
> 
> Philippe Mathieu-Daudé (2):
>    hw/xen/interface: Remove pre-C99 checks
>    qom/object: Remove pre-C11 check
> 
>   include/hw/xen/interface/physdev.h    |  2 +-
>   include/hw/xen/interface/version.h    |  5 ++---
>   include/hw/xen/interface/xen-compat.h |  2 --
>   include/hw/xen/interface/xen.h        | 14 --------------
>   qom/object.c                          | 14 +-------------
>   5 files changed, 4 insertions(+), 33 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

