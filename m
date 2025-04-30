Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6C6C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAhU-0007d3-CT; Wed, 30 Apr 2025 12:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAAhP-0007cf-QW
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:54:20 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAAhO-0002XD-7i
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:54:19 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso178581b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746032057; x=1746636857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3b8TyiKQCRymyZncAt2BntkBV0+HTBVL7pJZEmXMlBs=;
 b=I6Thx5TmBTlWiV/0DVCjaFrtdgVNna4jhkqcgAbfo/9hN/OKC7o2njWfZambhxhYQ2
 ULfkgEVCGhBOwST1GDjqnJ6R4bUneWflVB/0WsLDJQukgoVlufdR+a6qGpgKVsdvh2/P
 OW6WAgJm+rDZZVZeSmGSvMU+nsZFXI8UU8CQZCXnNxpL+S3UZNSpMrLRJ7JrFn/uwFBT
 uyKjRxhdW1sJBHc6v7pxDQ2vFiF17zzAErr4pAe8zsUTLE0mDCRj2maSI9yOA+m+8PK7
 mTIJ5nwiE6/xZD4tAhOFqKj/nrcuJyGI7mOKCQIvGNPxWwkAj1iu7BLh0RTDWdnn8bwy
 wq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746032057; x=1746636857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3b8TyiKQCRymyZncAt2BntkBV0+HTBVL7pJZEmXMlBs=;
 b=PDVkc54GYb+iCapJBQogzsglfkDgivUigVk25S+v0PToAiFqu84tFyPr7BawyqI4Qw
 ccsZGJ9oV1lYNOEl+Ybic2JNS2uDYyXAR8VnoNnAqZKKDgAFuEp3mT2FGvnH5gXaXgA7
 csCeGZZKUGxlHlts76+lprs4de19+qZ6AE86J8jWEuy+Fn8Z2Te8nL1u2jGPR+029BXr
 FIBrX9BleKuD8oDP7lj2oqFBkKc8s3+jNhIkHfvWU1ga69sXJB816p1xnnTq2jJOmiW8
 82YKCp6I6HG7rwrtcl1TKRGOxh+qHqvaEyD92fsGqey/7F0QxZkpSzjM2ExHYI8us7eQ
 cLEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe8N76vER9EnTyWALZefdDtt4tatyVdGOc6yjBw0aCA01f60bP/N80SBlq2LMHQBSwegY7lVGReEEf@nongnu.org
X-Gm-Message-State: AOJu0YyCG/xB6zB6pJW+KpXeWcd7fyzwj4vqWNBSrEUNg4TNt4lPDTMe
 /BY9xiF14j15RjGQp6VBlfDPGU6719TIL8WdO3aBmqtQtDQ6DeIjOuJCsppn/ms=
X-Gm-Gg: ASbGnctRaR08mD2zPDQIXMuF2qZ8/IkscnEsdXq1+HF2XM3JecMFKU69zEWGTfxgmZ+
 GAko76oDOMmnse0evbNJVHDV60JdVOE59xog/6wQnPW22DS/lKf1J7qmHLYQ/wjb0nIbzULCMzO
 1iUnw61Z/0yOcu34iVMfmNYbaaNNF767LsvG1c/hs5/Fg+h0FtmWzHRGZ9ngB5oivWrt3m/ryAx
 i9QC3b91PAyW732lYUjbg9GY/RCj2grnkwVNa33C+FTRAZ3CXuVDbAuYM2BdV4I9HV7UKsTGorb
 gkOuHWIHZ47ETB4Zx2qpo8SmahRmzmgqy342pER17fnvsSWvJvamWw==
X-Google-Smtp-Source: AGHT+IETkjD4AZT/wvdogJqVjZZnOjQF83E9/mS+z4t7qDeaHKzopdSDQl9lY2k2JWVl27t3fBqAeg==
X-Received: by 2002:a05:6a00:4289:b0:73c:3f2e:5df5 with SMTP id
 d2e1a72fcca58-74046199548mr298184b3a.9.1746032057014; 
 Wed, 30 Apr 2025 09:54:17 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740399415bcsm1901612b3a.73.2025.04.30.09.54.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 09:54:16 -0700 (PDT)
Message-ID: <398fca3c-30d8-4052-b599-c68aa7e33090@linaro.org>
Date: Wed, 30 Apr 2025 09:54:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/16] target/arm: Move cpu_get_tb_cpu_state to hflags.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
 <20250430164854.2233995-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250430164854.2233995-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/30/25 9:48 AM, Richard Henderson wrote:
> This is a tcg-specific function, so move it to a tcg file.
> Also move mve_no_pred, a static function only used within
> cpu_get_tb_cpu_state.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c     | 110 ----------------------------------------
>   target/arm/tcg/hflags.c | 110 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 110 insertions(+), 110 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


