Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5504AC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJ2K-00083u-EG; Tue, 06 May 2025 10:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCJ2I-00081S-Ge
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:12:42 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCJ2G-0005WA-Id
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:12:42 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22e45088d6eso11089235ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746540758; x=1747145558; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+5OVNuoTm2g1d4aOLHeBCK5UvMrKtRLeEB01zGs2fb4=;
 b=ky8eiMNDCwNuwL7m9R5Bcr0xtgiVfV8Zvvq9K4hIb5TzBrtb/Er8zBQuTsUbAnpUOs
 czhHDjZGatgVAxV5CRMtQKPF5ts0S3VqSsIZ2SXLdW20l/Q0QvqL7L3tge91of68XIM2
 8EUifzZ6nCka4ehmtrACQRwMHwKCAMVDSRQHwVMbXU9LHQs3/10uWVvkU9igd8glOn8G
 1j2ekL8MU4CfkEWUM0yd6woL7Lin68vfy1wSJy8zo9f5tqOg86kSV18+ywdlJ4p36+x8
 3tkJQsc3TzsjaM9sDNFH5PY+ksGg8Nc6cCudcVbGOl587Cp6pl1lbKe38M59Lz3XtVMf
 3vWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746540758; x=1747145558;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+5OVNuoTm2g1d4aOLHeBCK5UvMrKtRLeEB01zGs2fb4=;
 b=n59iKySAy3jxSDtTE7hu/RauLwRpQ7LgWDl65aGBWk6ofGw1rlUf9nSH5a4iH2qEBo
 hu7EsRztEUSPXgtVDYjyina/u2u1UzZrK13AoN/ToTQ4zDipIi/4DgJZY+sd0Irc0KMz
 TVlYYkULjnpZYJDZIbf456pX8px+21Sm8lFjd+jlA8zI5F6ZBI22DnMIOlVMZLRF/xSk
 MvAu2u33rr+ocdlAdxgSfA9aT6SV9QO+pJzZekQV9fZhFTMqnt9fTc/PFoTs1xut6EvQ
 EWuIYszATbskuIVIFMxSnSGxeF4ByUKJbyj/ukke3nygaVexNdNtmAeGdiw2yB9UQrZk
 LgBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXABKU4Atu1WAGk1tEUtQMqCq8es1IOF5y/PiA3PzdtoE1tcSqoH4Zj4nmRVUKOB+Acmuv0aGVfRUbw@nongnu.org
X-Gm-Message-State: AOJu0YwyFrHnnirnsRfn7PWvbNaMdJoOl8zXvgFMr8NKXo7n3aT+KZ0Z
 /QnSnGfJBadwCu4Al+jtVXAn7oTW0oSO0BUeCbn3dJqUVygpgYy/H8YOzjmbbLW5/0HbQmZfBUv
 q
X-Gm-Gg: ASbGncuGhb3nomq0ECRFaFnL71v9reOXqUpLoqMqxI+oWvlTO6Kd0/DniX8oUWYf1mz
 xw7ek9+Nv1m4NyeBkPHvRJlWBeqhwKeDrEYtouqLKAdrTmptj0SXsIGA2kBANiCKuGJfAk0szud
 v14SkRmY6+l+b0F/s7aK0UkGWrHJMK5eGeo2P9XJAXdttr88pbT5D9GeDuRwxKl7XEfvSkTd4yd
 68LTOwkUVyV+PHHk6agHcA26tY49PXViAP34YtJ0kOmWQOhFXAwv7dLys8ScrkfvDvhr/+kjdyT
 mABlmVQ7wgF3Ar8IqlD+kIPs90haNL0v4L45yO/PNoqo045Vrt8sznpRyNJrnSHpwkH0sA78zex
 KWhv6A/8=
X-Google-Smtp-Source: AGHT+IGPRoxWwccktkSYRO5fQ9/b7fICzvJO06aTgXcA6TEC6oTu2F289LbIBpzXjXZWTTzIGwmYyQ==
X-Received: by 2002:a17:903:120d:b0:215:94eb:adb6 with SMTP id
 d9443c01a7336-22e36391023mr46390595ad.40.1746540758651; 
 Tue, 06 May 2025 07:12:38 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058dbb71esm8962914b3a.38.2025.05.06.07.12.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 07:12:37 -0700 (PDT)
Message-ID: <391dee71-86fe-4f7e-9960-b5060fd86038@linaro.org>
Date: Tue, 6 May 2025 07:12:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] tcg/optimize: Add one's mask to TempOptInfo
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
 <20250505202751.3510517-3-richard.henderson@linaro.org>
 <b94f0dcf-6f55-45e9-866c-ad2e59ce85a7@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b94f0dcf-6f55-45e9-866c-ad2e59ce85a7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 5/6/25 04:05, Paolo Bonzini wrote:
> On 5/5/25 22:27, Richard Henderson wrote:
>> +    /* Bits that are known 1 and bits that are known 0 must not overlap. */
>> +    tcg_debug_assert((o_mask & ~z_mask) == 0);
>> +
>> +    /* All bits that are not known zero are known one is a constant. */
>> +    if (z_mask == o_mask) {
>> +        return tcg_opt_gen_movi(ctx, op, op->args[0], o_mask);
>> +    }
>> +    /* All bits known zero is zero. */
>>       if (z_mask == 0) {
>>           return tcg_opt_gen_movi(ctx, op, op->args[0], 0);
>>       }
> Just a nit, but this second check is now redundant.  z_mask == 0 implies that o_mask == 0 
> (otherwise o_mask & z_mask is not zero); therefore the "if (z_mask == o_mask)" must have 
> returned from fold_masks_zos().

Yep, thanks.


r~

