Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3F0C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJ4m-0001jW-6z; Tue, 06 May 2025 10:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCJ4j-0001by-58
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:15:13 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCJ4g-00066i-6S
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:15:12 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22e4db05fe8so5461605ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746540908; x=1747145708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hwUdbDDXm0t3Gm52LFWIHP/6V7GrN24wZGDtv9al9gQ=;
 b=c18As2xRDYqqdn10/CcjB6deC9hLDbGXL5uLmMUrqbJq//Q7OabGyZgaVizrGDBwDW
 lCD/q3nFPSTJ52EMT70qLCL+U6b7t6pB3o3/NNnIMBy9umTmPKs9g/HnKDiwdrfTYXHc
 8Cc8b1tNTjpo6qxzmjlCJxQw8gZr7ojiXIEWSabXbwD8lIC++L6fJHcLpwxU3mNBf9Fb
 QKgpwhmay2H5at7K7GqpZKNkDjPEu3Q2NtGQe1vIwOniBG+YBluphVWp8GulJKbOvWXB
 /Th3tfXwR6XoaLKirGGS5xKIsbtOVouuUbNYwfFqkPxT/BDtHA7jNgYqDSr+KdF7e4xm
 lVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746540908; x=1747145708;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hwUdbDDXm0t3Gm52LFWIHP/6V7GrN24wZGDtv9al9gQ=;
 b=CzAWET0RZLBPRY/RwXAoQOo00P7Ta8oLrwsdIVsXj3A3zp5an4JkUAVmOvj+I0q0jF
 mZHPVqcUzGnH+mR88hopAwQF5XvdIyPnub4hIx0lNAOy4csYlc6xn6JEzIPLYH2MosvO
 7cIJf4+9Wb6QqP5mtaSsScI8pXK8mSTXRhgpzRyETniRMFt7eczHmNG6nqGWR/kk0uZ5
 ySi+5XN21Z0Uz0iu6GuFj+9Hkz4Hw47gu4mF8NGoxOvP0tlOmqjjNlzMrQJ/QSbHtNT2
 jaZTsdUBlx6dHMFTa/2wUwEN2tEO5HxLrDDiDiozcIfCsE+Bky/y8L/DVD9OAb4hUWU8
 61TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNKRVbnuymih4aO2edU7zjzelLS8er3N4XxvOkHhR7ccv0hQcVYEX5vb30uf4Rfcs9VTTiQB43/X+w@nongnu.org
X-Gm-Message-State: AOJu0YwjagO3fKy7eI1Re8P4tBMFhOQ6WqvgJLNCwlKdqOalkckTZCdr
 yzv3J3Kasf6mw6f4m/dJR0VckhymU4i2yNkf4VeXXBj/e4n+844yhpvflIox7PPP7UfC0H0nJhm
 M
X-Gm-Gg: ASbGncvJrEr4y/qOdocoTRIHaCD2fLt6BIBiFuJo8gRT9P6EK3iPFGlOLP6jieKzojQ
 w38bgQgTaXZhDFVs5v5nA5RLdSteE4t+qQYoj30ahAwxrSTMtg66pIW4UMlIYW2+UIrbysdsdR+
 dB5Rb39+dIVE91xR9Sbg+syIVeG/GdafLSJzNw8kzVmHJVqLIal5tGZpANhf4xffeZ9O1igWSTb
 ck2pY2vjJ94XaCB+BqCe6l7hxcnBWvmEEOSY5GVshVbS9d6SkAb+ex/6FuJqSGtNx3DhRyxV6rL
 FlGYEKFHDG0kj5Vl4qYs+FGB1bLh4/FwBGP13L6RSLONrA3zbxNuiCt1xLTALfzXvpb7oLrvKUh
 rNWHzdYY=
X-Google-Smtp-Source: AGHT+IH0zy8y3Ko7HcebSwAIDUPK9GdcMvxl1KAAi5fvBteKA5fItESmHUDJUIyHkCMv+EwB7Hh3ew==
X-Received: by 2002:a17:902:ce8c:b0:223:4c09:20b8 with SMTP id
 d9443c01a7336-22e1eae3f54mr150027035ad.37.1746540908090; 
 Tue, 06 May 2025 07:15:08 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522a77dsm73649555ad.177.2025.05.06.07.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 07:15:07 -0700 (PDT)
Message-ID: <05e2dae2-5cc2-422d-999f-97ae70e2b4e1@linaro.org>
Date: Tue, 6 May 2025 07:15:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/20] tcg/optimize: Build and use z_bits and o_bits in
 fold_extract2
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
 <20250505202751.3510517-16-richard.henderson@linaro.org>
 <6a880c79-f30e-4fe6-af98-1fccf334e2dd@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6a880c79-f30e-4fe6-af98-1fccf334e2dd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 5/6/25 04:12, Paolo Bonzini wrote:
> On 5/5/25 22:27, Richard Henderson wrote:
>> +    uint64_t v1 = ti_const_val(t1);
>> +    uint64_t v2 = ti_const_val(t2);
> 
> Are v1 and v2 needed at all?
> 
> If starting from z1==o1 and z2==o2, you will always end up with z1|z2 == o1|o2 after these:
> 
>> +        z1 = (uint32_t)z1 >> shr;
>> +        o1 = (uint32_t)o1 >> shr;
>> +        z2 = (uint64_t)((int32_t)z2 << (32 - shr));
>> +        o2 = (uint64_t)((int32_t)o2 << (32 - shr));
> 
> or these:
> 
>> +        z1 >>= shr;
>> +        o1 >>= shr;
>> +        z2 <<= 64 - shr;
>> +        o2 <<= 64 - shr;
> 
> so fold_masks_zo would do the job.

Yes indeed, thanks again.

r~

