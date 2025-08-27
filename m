Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A87CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 22:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urOyt-0002g3-JA; Wed, 27 Aug 2025 18:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urOyr-0002fH-Uv
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 18:51:01 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urOyq-0006Ud-70
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 18:51:01 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b471737b347so282658a12.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 15:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756335058; x=1756939858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pBAEEHumrbzzOHvLHnRftzyUpfbjYa16c3FmklvRBjI=;
 b=w9BJ74r0yYzWLgdFCYeRmydih3WaSqvLsJFTl9xv6OtG2b4/HwAWqfqp5JzKZOyHQI
 ZDFlrMcH9rOv+h8vhObxq8kjo+WktMkE3cQ1VqdNOKjdUZX49vvjc4kqgVXzxEPOZejq
 cvTokliRDevNoPWAKX3l6CfaKba+iW7g6jxufwPnvC1ZvMZKR4h4pvEWARscb9tnWWOn
 99n3jOfRuJWAqX1DeByXzFyDYCGuFqIcw0JAlLNaDKE+Nl/4LNgZA5enJZ/whA4848XO
 QHFhpCoVFXYe9VdSRNadT0x4zups1a9Iw/JliZPN/b9HFbHeCsnn0gekoJEv5VjcRxLA
 76ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756335058; x=1756939858;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pBAEEHumrbzzOHvLHnRftzyUpfbjYa16c3FmklvRBjI=;
 b=OEeiHQXBPOF8IUdTN96h67H199LHQ9jFw+wXyvRJqCud9ofmihlm1eShvKS5OEV0xI
 x4Siq1wSmEav85PdoltQf4fTbZz4fU6MPtBo+SMw/DQd0J+a2PK2cuPjL5nhpQuqDXXR
 9QszzNjRRXZrX1Fnv1cZjc1veQlsFjSBkHMBOEhDv6zKrpatmWPZYh/P1RN4JhDpALo9
 kW6m1VysMzmSf9QcmWw6vFaGqnlx/14DvZ8Z4uT6WHsKi5xX9oKp9qCdEk8DhnIrKGlj
 TeIf1OA3WzmqvcejFeWgmfWIrvA/9Yo6RTPTCWZsMwTKRrkz4Lh2lMmHHw4VYE8kUiBC
 /H8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrEf5m8rmz+U2b2Uj+QoRVF6TbKQprHLbA2sH18y+A2oHEsWm9M/NONOeKcCfuzZ5kx89ULslPTqBK@nongnu.org
X-Gm-Message-State: AOJu0Yzm1G99gZ1sNcyEOTg29JbXyrYAy21Vir1LuHshybFw7ldPrBMw
 U299CVgjw5KtZxnIggvt1wu1xn634PD0YJiJbWzP5MjENJkox5fZAHpGaAtDiGSQiDWhwCy7obz
 opKoFNfo=
X-Gm-Gg: ASbGncsUv77IzJV8dKBjzsPtsEPlB0cGUnAGXjkZFW8r8evsJx25uXvoeRyNtDD/ZVs
 abwaF1su2cBwWmBLIqbgEd9BpT4n9MFFxz9zIIqt10T8IkyBVMfTPWN5hpjmkkzfcsfjRUAQdC7
 O9v+vXZtzu8+rnwc2llGSHWciKV/cUUG2bf9/qzSIG/jNlQIzXkpZCkbiLHBLcTLHg1y4TKhDwp
 tKTlxHg3DbHo/5Fe4jng5r4Jie640yQjRfzuK7210dP3b2DXHrEFPAtBhSoazTRjUHjjrNk92YC
 +DTDBUbyGLKSfyWcbBh1aMqQdQYMbYdfgmjIKq+mT0qvS4ok7f/YoQ8j/+xgUvZH/zVgrwopPw2
 ODYtQDPfe1XvUymMDCLUYWXTjOgHW/+qNyyDySC88jbDydsQ=
X-Google-Smtp-Source: AGHT+IGaCLHvzXjR28ldPqxgFPpKIU8V/38UfxFp5A2iXLSQSCVK28DUiwudQJNMQ2hHTh9dnY7DJg==
X-Received: by 2002:a17:902:cec2:b0:246:61e:b564 with SMTP id
 d9443c01a7336-2462f1d82c4mr256606295ad.61.1756335058575; 
 Wed, 27 Aug 2025 15:50:58 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24668879162sm130659865ad.113.2025.08.27.15.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 15:50:58 -0700 (PDT)
Message-ID: <8d69480e-71b2-46ee-9419-9114ac9beb99@linaro.org>
Date: Thu, 28 Aug 2025 08:50:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/14] QEMU patches for 2025-08-27
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250827182533.854476-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250827182533.854476-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 8/28/25 04:25, Paolo Bonzini wrote:
> The following changes since commit 88f72048d2f5835a1b9eaba690c7861393aef283:
> 
>    Update version for the v10.1.0-rc4 release (2025-08-19 14:05:56 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 92dedaf169ddcf8c81fa6d21c86c60f3b82458e5:
> 
>    rust: move dependencies to rust/Cargo.toml (2025-08-27 10:57:04 +0200)
> 
> ----------------------------------------------------------------
> * rust: declare self as qemu_api for proc-macros
> * rust/qemu-api-macros: make derive(Object) friendly when missing parent
> * x86/loader: Don't update kernel header for CoCo VMs
> * target/i386: Add support for save/load of exception error code
> * i386/tcg/svm: fix incorrect canonicalization
> * scripts/minikconf.py: small fixes


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

