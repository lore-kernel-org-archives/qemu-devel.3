Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF5DC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 18:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsmwT-0000bJ-Uu; Thu, 13 Mar 2025 14:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsmwP-0000ZM-GP
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 14:05:58 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsmwN-0006QA-Ur
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 14:05:57 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22355618fd9so27160475ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 11:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741889154; x=1742493954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+dVK2fn4bPt5bJEjtTQ/jeN1UgjxV8+RF2i0ZnDbpow=;
 b=BW9ArKXEJBDuI3vJmSchGutMo/D9vcgSjS9X+x9/TMp83OuQ9qQcEzfi1MKdoc0EzV
 gX3U4dW/0WCQIz/sWM6x/1oDDTEMYFI8AGwoiLJhLNIQJbb8BSH77GleERk07qZ1K2GB
 /ZMZxTQFmNTDuP6sa8UYgltcGPSTGfCwuTfQLyVfhnsiVeFiEpIMlnAGe8EZyyWDkaFd
 R9QzxO+NfSrzKkxjhy1ZncpZEm0ZfQUMeFShaK1lb0REoDWuM4HcZmXgixbig7Qy8Yi/
 CWaHNtoVnkkKNZFdqAAJlWgZcJBmH3DoEgLlV0RKXzircbJgjjdAolnxCGtGeRvjBD6T
 /e8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741889154; x=1742493954;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+dVK2fn4bPt5bJEjtTQ/jeN1UgjxV8+RF2i0ZnDbpow=;
 b=KVjFVn8aUa319HAU5HFGLgoiDdQJ50XUT6ztcvAg4c5IUFC4FvujYCv8GPBJK2VGrG
 pBKCq3flBS4i8JpNfcGk4vbCGRUu6Xc3aPISyt60OHb1sVePBZgZkNgJOdgbx+o9po3J
 /6f7ZJ1sOjUXiPNfzuybFW25KpvqcF+ZR9G2bd0xXJy3oJUrmyHQh5JIYD+xrrRCalMd
 11kwJdKBdswmh2EjHcXSDr19X+M0OAYr5kRUiHmElYqpaLHG9N5GFgw1pMIit+sKKlPi
 B1zfhoFeKkNiTb0axDkFVx/6HMW56NXyTH7LPXXS/3hppOONhE3D2+GaLuIncxIjGYwM
 FbGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4YgX/T6pRsdd1GO1VgzK4smYF5nRoYifzxkO6r/Lg2yNKPLQG3a15TqZQHzaB0i7Md0WYzX963oKN@nongnu.org
X-Gm-Message-State: AOJu0YxisF+oP4bHrSAJMPTL+2pV3WUqMQZLpG3w44WbuhgtgXFvPuQS
 C5pqIqswYtTFMTkinylgjFLfz4UNh77w08L4EkdSvrg+x0SfPH56h3jNfsfanNE=
X-Gm-Gg: ASbGncuVUhjBAPou5WnXIAOG9Uunf+n4NHVtQ7kOTxGEdVql2T5XM/XX7VzkzGgmV64
 j43B6gSw9cB1AvNzye0cuqg/YVZK4hXTIFQ50TUNdabEzPDXHNULKvsznMuGvGIEEgtHYHX6snN
 VyNZDOD60P3o4zxS+2Ef3m8RWIO2WVk201uvOwumjJKZc9kARILr+5YSA4jpHhCfFCKPX3VP235
 hG22v/qdAo2SGKI1HjXvIAWvwRUo+7v58uZMVdI8/Y8v2gnkJf/zxcDZpmMiDF6peOVWkOVu1oO
 mElJ3aMdscAavSSpI/6cIRbn/Hxj65PIvgSf9eC5X8BfU3O3Mv2ixsc0OyMiu7J8ZPEToaKo7Nj
 OtsF+uKE2
X-Google-Smtp-Source: AGHT+IGtu95M3iO+DbOh8rEAAlXOZCql18KTRklQdwQekO59+0t+tsiHy6rJwCQArP3HGOq38/fYhg==
X-Received: by 2002:a17:902:f54e:b0:225:abd2:5e4b with SMTP id
 d9443c01a7336-225abd26087mr88799905ad.16.1741889153685; 
 Thu, 13 Mar 2025 11:05:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd5b27sm16314135ad.255.2025.03.13.11.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 11:05:53 -0700 (PDT)
Message-ID: <6d26b188-189c-4714-81a7-6061bb8a6ff6@linaro.org>
Date: Thu, 13 Mar 2025 11:05:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/37] include/exec: Inline *_mmuidx_ra memory operations
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-6-richard.henderson@linaro.org>
 <a6e79bf6-8b93-4b02-8888-6c2a417a34a2@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a6e79bf6-8b93-4b02-8888-6c2a417a34a2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/13/25 09:59, Pierrick Bouvier wrote:
>> +static inline int
>> +cpu_ldsw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
>> +                      int mmu_idx, uintptr_t ra)
>> +{
>> +    return (int16_t)cpu_lduw_be_mmuidx_ra(env, addr, mmu_idx, ra);
> 
> For my personal culture, is that strictly equivalent to doing the load with MO_BESW?

If you're asking if it's the same as passing MO_BESW to tcg_gen_qemu_ld_i32(), yes.  The 
tcg code generator takes care of making the value sign-extended.

If you're asking if it's the same as passing MO_BESW to cpu_ldw_mmu(), no.  The core 
functions only handle unsigned values.  This older api contained functions with a signed 
return value, so we preserve that.


r~

