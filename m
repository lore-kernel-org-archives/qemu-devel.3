Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F38CC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1Dn-0002jG-Vw; Mon, 03 Feb 2025 13:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf1Di-0002ic-4O
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:30:58 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf1Dg-00036Z-At
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:30:53 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so33955845e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 10:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738607449; x=1739212249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5UHndEliEHvm9ODJvtq/SMoGSdhLUrchkR54ymMq3Xw=;
 b=XCHgY6lcdW6GewgHGvsKn0tnd9wUi6pVzvDopt8G2ivPewgjh90PVrtucXPyihsI/3
 R+pNqkUjrGwMgDyGrGKEup1PaNjm1c6ayCcz3243b8iXyXMLtjtOBY8PXGGt9iNhCj99
 gKWg+ncxT8jbragoRFLD2DrMd5xW1q4u4pCrHvrxfSKJ8ndHaw//+52oeosL7uD8PKWo
 LCj2WKfu4lN4WxGxs+hMX73e4LYNtdzLKqKLdj5AOjFpqMnZl/Viw+M894gzb3/StFvq
 f3AYz44t01omERnaYMKhFHL9FDzTI/2qqp4oDEQwwv264yd2HlSsoh+W7GPZxunmg2qf
 p+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738607449; x=1739212249;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5UHndEliEHvm9ODJvtq/SMoGSdhLUrchkR54ymMq3Xw=;
 b=tb4R/nsmUTdJySRhQ3krhP6Yk0Ruq+pO3TAebldsp0HPzrxH0U9HUm5hrz+fBms18B
 yLS7Mzzyokq6UJTFO3VAZwdhDQL4cIkkNY6H1Y1PKQ7o+a1I24KjjwVqUHKPJXfmai2l
 AH/fvrcaoIwWMKvUXrcbroxxiE7TxAJVb1s+DwjPbGdu5pFX8n+Ejq7kfjbRMRQkoeUb
 6I8VnoGKFt2L+SrN9lt/4EFtKx1kSzGwUkVdBxB5mYHFsqadRUFMPX7TI7RiZLgk6dFg
 TmTk8ulZOavcEPgR7tahbcaBuAPvfSMxwkn95RAE6112HAMBBeUHOtM1OyVktDMkVUEw
 iHzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkEjCMfwJEo0wiNbsyeN+NyDT2p+TSsyADeVfvg/fvKsyD4ZspNUZduhbYkasoFRrl933yE+H9Ar4Y@nongnu.org
X-Gm-Message-State: AOJu0YzfFyWvMdElduZRe+bGDmGecdIk9S4ek0Q7tTRoF/4gA915ZpK3
 xtwe5cucpWuSfmh5qClUPL/zGCdU88ABnga2aYeA/7PbhZN6/jTvrC0wTiT7mJA=
X-Gm-Gg: ASbGncvylR2aCdiG3cAW6vAsZmwqe82ndOAfl01PxVrYVkZih9yIeOBdgWjYzo20FTH
 Vcd9Pur/u0rea8Mrl/kIqyXRXGC3Ln2m2kGR09RDf6EhicKdqDRWqWar5no+qlMWprVwAxv+GIA
 SKG7APPJlQi9YmLHNHbtmWEP25iOw+YYE3znZ/S9Av0OzgVLA8XmO10vAzyle2u0LmZzagawzga
 u9eyJ/53Y5xm/M8YmAKViLsYhf6aqYK2WHE/vA/BqfoMx+AqA2XtyBohpEuDxRKt4PHpFzkWksZ
 nt9EIZ0L5wor/63nSUDEW4uqEgrOlWW64Q08vrME94lkEsAalzZsmr4b/iE=
X-Google-Smtp-Source: AGHT+IE1YhnFsCy/zjyCxrMQG2BiPnUesYDa9eR1MgHDf9bws6cJ2NX3OK13GRtIUGIbeXeyX4TjzA==
X-Received: by 2002:a05:600c:1f10:b0:434:f8e5:1bb with SMTP id
 5b1f17b1804b1-438dc3af90cmr204163085e9.12.1738607449384; 
 Mon, 03 Feb 2025 10:30:49 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0ec7f1sm13259488f8f.9.2025.02.03.10.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 10:30:48 -0800 (PST)
Message-ID: <707af3de-3e66-4f23-961a-6fb9de45b5a1@linaro.org>
Date: Mon, 3 Feb 2025 19:30:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] configure: Define TARGET_LONG_BITS in
 configs/targets/*.mak
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 thuth@redhat.com
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250203031821.741477-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 3/2/25 04:18, Richard Henderson wrote:
> Define TARGET_LONG_BITS in each target's configure fragment.
> Do this without removing the define in target/*/cpu-param.h
> so that errors are caught like so:
> 
> In file included from .../src/include/exec/cpu-defs.h:26,
>                   from ../src/target/hppa/cpu.h:24,
>                   from ../src/linux-user/qemu.h:4,
>                   from ../src/linux-user/hppa/cpu_loop.c:21:
> ../src/target/hppa/cpu-param.h:11: error: "TARGET_LONG_BITS" redefined [-Werror]
>     11 | #define TARGET_LONG_BITS              64
>        |
> In file included from .../src/include/qemu/osdep.h:36,
>                   from ../src/linux-user/hppa/cpu_loop.c:20:
> ./hppa-linux-user-config-target.h:32: note: this is the location of the previous definition
>     32 | #define TARGET_LONG_BITS 32
>        |
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Orthogonal to this series, what about the other definitions,
like TARGET_PHYS_ADDR_SPACE_BITS / TARGET_VIRT_ADDR_SPACE_BITS
and possibly TARGET_PAGE_BITS?

