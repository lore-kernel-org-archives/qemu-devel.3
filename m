Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB58C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAClz-00041W-Qi; Wed, 30 Apr 2025 15:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uACln-0003td-2v
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 15:07:07 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAClb-0002Lt-Km
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 15:06:49 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso2600495ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746040006; x=1746644806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9n3Gc+fzJYrA8p18MsMkLFMsPX3ZwWCDB/5xmmls/q4=;
 b=pwDHMmGG8tav9CAqGQqP5i8WLBSW9vqYKsWT52WOzDH5/NlL/nTEsvv/kMW8hy0oGM
 GuleY1HcunEUlVmJC0QZXEk7a3SS9z9AwCLEpVbf7D5fCGisCCPuKnH1Gdsfmb1PJsW6
 MnxfX+hqNhULsc6Co0tglWRmVZvrxzpkV7IwF+46WJHIZGJeeaimUWTzAbnFzpmU8b4S
 Y5e0IZr8HWXr0BDQtDkjEpkuxw6zL7HKcTE51nyl94me3YK/mpLGhJdxbq79H/NMH+1I
 krfoz1PQN1RFC6V6pfj594+lr8o8abcbPPvSuErCjbXWIcBrN01rU3MkeKwUK9DJQotS
 yYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746040006; x=1746644806;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9n3Gc+fzJYrA8p18MsMkLFMsPX3ZwWCDB/5xmmls/q4=;
 b=RKRbD+FRfxkeczDu4A3IgJVV2ALK7nFDxpWBEM+dKVtfQtKOm89T62cJpRoVbqc2eH
 BH78TVrm0CQEUm3HL72NOwves8zf9j1IKv/G6uoYXQPAi0pXeLISK37ta/9+F+QC7HCN
 Lvh/Ibi6/89gPtBrdQHQwm5rfFgJoiOizjwLbQiCiK6QawTHwVMKW4oNoWIEhKp0F2c8
 4J5jqeJ+sOUUB5HU3oYIhc8mXmuzdTwhiXSgaNyqR93LrscgRK/7zTssjJk9BRs16RLu
 qO+GI+R+WbG+3gJg2ehIvNX3YD8TN1tZL29ZmmDJxObh9btQ4Tl10W++ieWNO3Dm9hwN
 b+3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8LjP5JK0INAjnajUPCAO7fkhZmHRMaQUf5cZlrCe3laWpUIQvnoogqHyA/GDKC9z9Bm3Vox9a7Kin@nongnu.org
X-Gm-Message-State: AOJu0Yw9r+keU2fqDw5u3DhEuyG0EjbcGR6pXX2g0nu1u2ozft/R2jtx
 EgDaQD1v9Bbqmx1dD2s12ARFj1grxtQ9mf0FctbmS3pNb7l+xB0/GfA9BH2aklI=
X-Gm-Gg: ASbGncswklhlQIKw2o9DwmVtNxds/LvDFTauSYskjhzVh2zwhGVGZzKH7dHnIdOOiT3
 vpWPco+mcheF3S8VOiBlo9Q+iCp+x0c/7LWpyUboLfRCyTUvCiWxFob6nqZFP+CMQgj334gsySF
 6Om3/eHu/3qLfgUklYI0Sxm/onrXpvta5sXrUEmQCt9uUpI3Wsav8t7LqeM2OVdLLmu3RDpQ8hg
 s9WWoYdMd8sqiCdG0m1doMWsWwvh4FR7tmA88NunZlKk1FnRjZOw3Ln3Lh4JWcGhBYAOD1k21Op
 FyPKtc4nAeY52C96r903e6P0T2EmVpKiH93+uUTkMzvJ8SFj2RytSg==
X-Google-Smtp-Source: AGHT+IEwJ9DmS6F4g37/Yr0JrWeK1e551wHd0iG5IlA+XAM9kxsLyaRa9Hjrx30O81QJwrT30x9ysQ==
X-Received: by 2002:a17:903:2acc:b0:224:10a2:cae1 with SMTP id
 d9443c01a7336-22df356f9d7mr61399055ad.37.1746040006067; 
 Wed, 30 Apr 2025 12:06:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f4680sm11028282a12.14.2025.04.30.12.06.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 12:06:45 -0700 (PDT)
Message-ID: <037f7d2b-91cf-4798-a6ae-ba3cbeebf2b6@linaro.org>
Date: Wed, 30 Apr 2025 12:06:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] target/arm/cpu: remove TARGET_AARCH64 in
 arm_cpu_finalize_features
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, anjo@rev.ng
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
 <20250430145838.1790471-11-pierrick.bouvier@linaro.org>
 <8520456e-3e44-4028-976a-45d683610a8e@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <8520456e-3e44-4028-976a-45d683610a8e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/30/25 11:47 AM, Richard Henderson wrote:
> On 4/30/25 07:58, Pierrick Bouvier wrote:
>> new file mode 100644
>> index 00000000000..fda7ccee4b5
>> --- /dev/null
>> +++ b/target/arm/cpu32-stubs.c
>> @@ -0,0 +1,24 @@
>> +#include "qemu/osdep.h"
>> +#include "target/arm/cpu.h"
> 
> Need license comment.  Otherwise,
>

I'll add it, thanks.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> r~


