Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C1710FCADE
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 21:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w82kQ-0000Ji-Sd; Wed, 01 Apr 2026 17:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w82kP-0000Hm-DU
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 17:05:09 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w82kN-0000BX-Q3
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 17:05:09 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so539195ad.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775077506; x=1775682306; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bum3Ru1xomX6ZKVjj0jSt0FwStXR/PCU/0Vqb6j0mko=;
 b=UNcPvQ8uJ030yItmJbRhQLasXN2XJJ7kRwFa7VyzodIWYi+dFF39/HZtbB2cRZ+PvD
 CAi+OLL4h6jf1zMPW+TVV4A6hiXhfHwC73eVyzPbhFtavIE+Dm1m8uXpOVg+DIuDEiCV
 Pa09tCPnNGDBN1JX9lK9wKtr5PTo+D4dpFulf5pQq8SOnK7whjVqfm3q93WIgDkOhAOQ
 Wv0R+oNEm5eSVmKpe1QbV3lhi6b/jsJ6gypCHJz9Cr/x9OtLTZI9Kd49Gaa4TKIorE0Y
 GFuEpseXESRdHw2oTIaSuD1j56V8/i47/EZRO3B1BlcqDiGm/6cCXLHj7g0kTotSlFll
 cPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775077506; x=1775682306;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bum3Ru1xomX6ZKVjj0jSt0FwStXR/PCU/0Vqb6j0mko=;
 b=H3lEpjmTr4qZfCXrVjaeYJAp/iOO4cR3kNcY17aTUlykHKNh/xs3+DzvWzZ3Bp7osP
 +m9EDPNX7LXkdZoD8XoHwsIgLOvRE3l+rcKJk9IORhOxYqJvh0O81YXXEvBQJKjBCnYn
 UIDcP5x2KO5uw4hA/YBuJjTPbGp0dxGJXceGeElIOYr4W8fATPER9t/8nP7TiwxphORP
 eM0hFSINpYS8zsYDEGkhPkqOaOaADAB7CTZ3hF1/DRdLhKCaBnOz/OtJ6MRjCVXl55Xv
 LpK9v45XfHm97+5wAlxwLItBhu5aRcnvGItBRTSsVXZiRRj7Ika/lljcSGtQ0h86zeFs
 396A==
X-Gm-Message-State: AOJu0YySoAclP/IszD+BPUtOnxP14gBzMIKOsKkwL9L3GOxVYKaBLMKN
 H6KT3lvt7e9bbRZJSJMf6iwjiLVopQbrlI9IRV4oZwQ0BHUTKtXnLOYjZzJJT/bjhN6ofeKSIDT
 FgguNSJg=
X-Gm-Gg: ATEYQzyZDyIQbk0fDg4D7PTHLF0vW1pRFB3lP22UQzdfStR4U/r6Vg+Xkh6Y8xRFASZ
 QEWHjAYP8Vw4bS5dF8J0ZgtmPeF5vHhqWylTme9V+wVXvwj/YAG00eUTFTjtmBcgb8J1GO9K6RZ
 QzVVmeIr2U09IrMBa7+2Pb3OOzWBmnF5WNiH6TC4XTG0Nw37ROA980TSL1yVtB6EfGzpzhdqQVI
 vOBv1itG+2kfJAfTVdB/ln9ETRPxj5Egb23PWrudfXsTOB2o2n5QZOpI7WaCXXzch+j0f3DvpMd
 QHdaN/Gf/RUm6Q4SgFl5wt7h9KzbPLy+jd/dX5eIN2IJsGVi3pTqvknMNNduquVqV0LqfG74MCJ
 ok+9RaxaT4NIFeJUgFvSN3s7eWkL43vAO77etEeiHBN0npF4L+xy1XvnC4f/F6irhJE5w7dMY13
 9d7TsWhzUK+y207jUC5xRabZMvUdvV6FWwGv/cxE9N8tV1G4SDa3x80K4+aQmmJ+iwBm4STAejm
 CJ84flDHMkUlQ==
X-Received: by 2002:a17:902:ce0a:b0:2ab:230d:2d96 with SMTP id
 d9443c01a7336-2b2758a1137mr6591905ad.11.1775077505650; 
 Wed, 01 Apr 2026 14:05:05 -0700 (PDT)
Received: from [192.168.68.76] (122-150-206-150.dyn.ip.vocus.au.
 [122.150.206.150]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27497af19sm6170985ad.50.2026.04.01.14.05.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 14:05:05 -0700 (PDT)
Message-ID: <908d7278-e928-4704-bf8f-b5c53ec40c5a@linaro.org>
Date: Thu, 2 Apr 2026 07:05:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1] target/arm: Replace target_ulong -> vaddr in
 guarded_page_br()
To: qemu-devel@nongnu.org
References: <20260401143456.79843-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260401143456.79843-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 4/2/26 00:34, Philippe Mathieu-Daudé wrote:
> Following commit 15500df3b3b ("target/arm/tcg/translate.h: replace
> target_ulong with vaddr") change, adapt guarded_page_br().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> I know this expands to uint64_t on Aarch64, but vaddr for $pc
> seems clearer, since this is the type used by callees, i.e.
> probe_access_full().
> ---
>   target/arm/tcg/helper-a64-defs.h | 2 +-
>   target/arm/tcg/helper-a64.c      | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

