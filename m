Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9E9C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfKHs-0007Fa-MK; Thu, 02 Jul 2026 12:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfKHq-0007Dx-Oa
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:29:14 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfKHp-00060r-4r
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:29:14 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2c9b42be8feso21291015ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 09:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783009751; x=1783614551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=clPxnpvMTJJ7zVZ+WGnCfyZQm8S6TZkoiuNX+DPkh5Q=;
 b=fN0J62SorB+WzXXogPNlSkkOGxVliXnGDqU4ZsEpgcNFFcEJeXYD6EvtthzSvcssHG
 BKa5d7u25t2IBmREG/3lyoAWb9PjmH4hobv5UD0cjx/3JflIOOt2fjT8P3QKknQbTKNW
 OxReNHeHmBDEbLjow5mf8S9E/G/+PqYVE1HydEaaSrgs33T55nOeFSA5v8aUmX3d5ShE
 LnzTvyjv0J6PFRK1SQYwYFpLXSRR31DtdD0ji3M0E1XcGVl6bY/BBi+tHmsuaAmzuqhp
 hGePWZJ7UnQqf90zhcTCqms2JvZoPiA2E/z9S+fVfaVpfwcBw2TmpHweb+HaXuON5Yne
 iZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783009751; x=1783614551;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=clPxnpvMTJJ7zVZ+WGnCfyZQm8S6TZkoiuNX+DPkh5Q=;
 b=kGXIfm4hSf0U3FU1Q/yKa1P0r8FMKpjT9kCFjcz7XpWHTPcjSSeTeRdkI2IB7SjJNT
 XidRwQm+Vggl5hAhz92BA9U59JQ+VJ1J3lheVYOlUf4lWZIZaDPKskRBxue0lfWRZFB0
 l/YLRacNRZqpyBrhyVlwWt6552mplv5t8kUZko9/pOmyfWzbNeV0Vz2Eql1LsQNsB4KB
 fHCliQgKP7TER/vFwUtJjnMfVXggLvVqiCcBLL8XMyp2mL98p8CiI9NmLad53+tMXzLM
 iTCq78tZj7+xr1sVC9XSVpoYssox+44uPSkOp4/3f4ovCEkD2hMAZMtbCBR5/SfJd5Ru
 CACA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ror5LxlKLr3xF1g2TSpJSG7TG3eBuxHXAPuzJJY46g11A3YK017TWAWOkHYVASQLcVEYBDZtkN4V3Hj@nongnu.org
X-Gm-Message-State: AOJu0YyADRVR8HL8IVHNJ8XQwvE6vAVQE2sM5w67FTZAyYYg7M/Y0yBc
 EsehpIsnWYEdImeHH9z22vmi2FG/rDSSgMQzHTLEPmsCk0NaRovCwb+8hjaaaW2A6xEVhBdjPCC
 865C0
X-Gm-Gg: AfdE7cnLAqBKrfZNBmdR050PZiSolQ62O2H/xiEf+Wxfr9WbXep+TZY44msTIo+Z3yo
 zlamdG//RJFktZ8G2YSXUDw07m4mhHJVlkduhJW2szMrYwMNUwFXWautPRcQm+Z/dh+qMmeZtPG
 Q26C7npkDGwnQ+SWzbU6NLkNtX5EYwgbrbp/qEcj9A1Don2grtGzaaz+ARfDUKhzyCHFQGFryzu
 eUc9H4w+0F6+UtrqUI/UfnIfY2tfTqzqOO7N7zL7IiS96K/nrABN/goYEOlruCMOT00Kj/fMUX2
 uDe6yCT9evj/Y1/W+nao68fPlrvhA9JyEdfXxm4UbdG9qb22rdDChQPHq/82RZ4tIR3zuzTzSHN
 Lc1K9hAZ6PHwddXQiyxh1iZo/9uZyzukZwgDdoRDpvZ7j0Zf8Yc3QzRWsfQNQ6wcSa6labblxJ/
 S+1fs/zF3kzfTnzYGR3m5/jeBuA13GlBfq4kkSJ4w68cXAHjPrb0TjrH8WVEkJDW1iIjPL
X-Received: by 2002:a17:903:1252:b0:2ca:bb7e:29a7 with SMTP id
 d9443c01a7336-2cabb7e2de6mr17803535ad.41.1783009751390; 
 Thu, 02 Jul 2026 09:29:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9aa02c16sm15789795ad.75.2026.07.02.09.29.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 09:29:11 -0700 (PDT)
Message-ID: <9f463afc-a97b-4a11-8203-f7135f0ad1fd@linaro.org>
Date: Thu, 2 Jul 2026 09:29:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/33] accel/tcg: Restrict tlb_protect/unprotect_code() to
 TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-4-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Both tlb_protect() and tlb_unprotect_code() are only used
> within accel/tcg/. Avoid exposing them to the whole code base,
> declare them in a new "system-page-protection.h" local header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   accel/tcg/system-page-protection.h | 17 +++++++++++++++++
>   include/exec/cputlb.h              |  8 ++------
>   accel/tcg/cputlb.c                 |  3 ++-
>   accel/tcg/tb-maint.c               |  1 +
>   4 files changed, 22 insertions(+), 7 deletions(-)
>   create mode 100644 accel/tcg/system-page-protection.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

