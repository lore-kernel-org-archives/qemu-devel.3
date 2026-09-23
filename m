Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3818DC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Slu-0002lF-2f; Wed, 23 Sep 2026 15:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Slk-0002iD-PQ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:36:40 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Slj-0007an-AJ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:36:40 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2db1ca069c8so7172905ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 12:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790192198; x=1790796998; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JYnMhGcxLeFLBbIpqmWyiSIzp8Ux9QDLAE46+vmDAL4=;
 b=y2rvDy5Yun3djWzwMJtgrQpCh5oAvKpRmEtiEyLHBesxpekb+RCRmJetcpnoLVGWvK
 tdB1tgiQ9AN9gW43rwCV2pRnGmiOJov4sRwCfP/w5Nd+zAzxCEfnkj2dVvw9M+16FwSx
 y3WP3m12Eymv8TF/Z4GM7RRCH7wlFzZ0vGKnpt7GL/7OQ0pgxjgmFm5v25sBImfrbBUu
 r0s2YrQvyLCPzWDZhb34370VhmZc9/nmt02u5sXUOZs/3rocxEFCDO5QbmGQ8L+5xdtp
 qX2OCpNI6ecRA1f/CO6Jic+YLhcwwK7R4ksrtwHcAsgOWyMP/nynaX8xfPHJj0BWAK2C
 6pmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790192198; x=1790796998;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JYnMhGcxLeFLBbIpqmWyiSIzp8Ux9QDLAE46+vmDAL4=;
 b=VnOqW+bzGk5ECZbCubyDgIrCeqe3E1cfCLGoNywzQWkcJf9xCQsDFtz8spThQOIySN
 QAiM4qvYKv0scJ8+TvdJVhh2Ad6V5JvBA/FsiKmv+EAWu9eUcPd73JSe+2Jw8C/p//AE
 /i4kJxvqvW5nSpzczSQ5zoX0SQ018vZCsN5c4iqgoxSD2y4hfosMMU//p2ZNTZNJZYTq
 xxygcUVNO0/pEhplN37tr7IeA0MV3jgqH0PzczIBpGtWSYAtBR1ZBTnMtJTaGjESWF9c
 w0ZmYH6ibifKka+fp8cZ9BNJz6lDfaFayAGFLXR5WTxLKHkgqT8S310bF/cMlbZd9Ads
 bmww==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxV8u9O1EwM3E5JX45bzoNLIcynTLknIIO/vwrKwgH3KhAFZojuRC8noq6Eht5uKbYoafBA3j1ky1u@nongnu.org
X-Gm-Message-State: AFuF++nO14vcsoJ75cBUSymbP1PpX4BxWaLaAcZRmfQ+p9G0j/Z0BoLW
 X+oahXauNvR/vKvhaVyjJnEf9oW292km+O8VzsZ05D8rdQ9dbkYV/ikn+UN1GYo7MH4hgwWmFKU
 OkFcx
X-Gm-Gg: AYBFou1LzhKFG7O8LfhduDdeoUXwgB+2V2HM6kR7dDl17ZD3VocyJ6Ek8AuDj5VdQkL
 ZH4lJM7xuu3YwKp7glrOo55Q6zK+boIyOyJpIjECPUJ3faMPinIqgoy0Nyzj5Fpp+MWJPoDcWy6
 f+q6aHCxiE/d4nG4Rx+dPrXXJYwObM5CWUAP8kcCcVwC0T6ukj9jDMzUYbBkG8DtNpuXBH0je1l
 /EggXogZz/pQiEFzkoPa0Qil6wvqXDe8ncCS+3Fy0IF92cEKalSZLetTHwcw57KQFY6YVpCVVjX
 EDkCK3qjl3SKOlAtYRY0JUNbAcKI3s9Nvmm/daR+ksNhXtPBV2Qh2KNfU8TV1WDA9mTowiS616/
 2vtMx7G6ETCvjUbJlbEgrPJuRjlFKnlu4Xllx3M2eegVqurv26VB6HVuuu3kqDxGlCz7PdGm+SY
 acxNebazOp3AyC9u8/dr9qUXj0Qj192wptj+snLEXAvsXFBPG8JsNc8Vl6kFVjIGLexYdPZ/0Ik
 MikHe+5QfMvX9K55ESejwJKM7pcMOuqUYC+SSuQ
X-Received: by 2002:a17:903:903:b0:2dd:c100:b2cd with SMTP id
 d9443c01a7336-2df7dd6114emr1467715ad.56.1790192197725; 
 Wed, 23 Sep 2026 12:36:37 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a60c485sm15587525ad.82.2026.09.23.12.36.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 12:36:37 -0700 (PDT)
Message-ID: <1434224f-4e1b-4ac9-a2f4-aa9429304256@linaro.org>
Date: Wed, 23 Sep 2026 12:36:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] target/i386/tcg: use zextT1 for CMPXCHG
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com, zhao1.liu@intel.com
References: <20260923173021.317809-1-pbonzini@redhat.com>
 <20260923173021.317809-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260923173021.317809-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/23/26 10:30, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 4 ++--
>   target/i386/tcg/emit.c.inc       | 5 ++---
>   2 files changed, 4 insertions(+), 5 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

