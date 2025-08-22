Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3085CCA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 11:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQJy-0005Cj-3Q; Fri, 22 Aug 2025 07:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1upQJr-0005C4-UI
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 07:52:32 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1upQJp-0006KA-Ra
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 07:52:31 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-77031d4638bso486138b3a.1
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 04:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755863547; x=1756468347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Wn1bCZjgDcOwXxqHfGPWrlWCMkfWjCkq46iJlSADHTM=;
 b=gZ5dAjysVZYb3mA+YDJ34pgV/Fr0Cs7irry+Hh23tG05dhyKoet+60KOJZ+lizIaj3
 lAp2HtG0HLU2bI5f1vTMGgXnDy1uUJdZvjcvviWDYWi6qWnM+kFQaV86Dk0W0JtkbUk1
 W5bVAbzaSTrDnZHaoPAuVVZKPrFxuozRxPVyObTTXdl8qxgIbAW3XVKWACCvnq7lz/r6
 GQQ2mm8WmJRdGQo2NY3G0NnpcqdEFQ8pv27/NESyhAEUe7GWFOdYX258O5IQgaLjwu0B
 DqiEL3jpvamT1yb0vnRG1Aj24dJBwzx1yImttaX16v2NRFSGiXrAAXYhHr5MrzXZbTvO
 gXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755863547; x=1756468347;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wn1bCZjgDcOwXxqHfGPWrlWCMkfWjCkq46iJlSADHTM=;
 b=OWOFjjuKDoIUgdSMu/njvrrfmMfoNWE4jGiR6TzxcjmQ5wqOxKD7E+BUFm31/tC4V8
 NdSxNGLlRGmzirWtrHWRNvuDIOrPgPhOWtm9UkPtzvvupQD7tMvUfc+OEc784hecV9uO
 Y1Aj2df1eI8lEvTCg7vVkYcH31Nv81SAx+7nZzh8NO/w5lf/DzI4QLtcAvbbnNJZm7ji
 WckyO50C9fMyDAJmWByweGufhFssMyTZhVc/WU6UU3paRerzMRPns6Ql1fG9Xjv4fnO4
 M0Z/yBvRogkQcckbIzv3QiAf3Jvfz7USkICIjKkV8i5wCY2Ob3gP8MQlnOHI6RkUqgcw
 Bg4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWTBUtn0mI7Ohp3/LXPGevP4Zd9ZPiHL+Z1WSLQyIT4p6FGWcXeDrTSaWAH4xZU4HjMcpfTUuZIKcB@nongnu.org
X-Gm-Message-State: AOJu0YxkDG1oHkkdAxUs+qPvkaorKKiX64ikGm4YidYqrzBCUy6Kppyh
 bx6mm4PfS4OSpgQtD/2KSyCj7ec+CAO4IplLZPRhnqR/n0m6jIsaUZirxLK5hfvlSaQ=
X-Gm-Gg: ASbGncvx1Bmqc2FPoBq669cvLZ4ptt1JKdZpnDiYMQ3uSjvWfCXiDMJUCwkQZdGct+R
 25nlF8CrOHrmwOHJG70YQppexzf7Bu9R9e4SrnshgrGB/e34wr1330f7m3IcVc5NthXDPVYOoOc
 JN56ZSo9/JfM/od0O8/giyDfw1woh43NSIM3qdeanO74ahJNec3N2vYEvy+jOrAkZT+EohwT3Pz
 LrOxv2EctK+NLTBHF38rQbWunabKy1CD/LQDDDQfQuPSY488gmIZHu0S+tbIF06nxdmOtLK4YGY
 Avuo2q8hqg/AlD6CEUOW5aAvNSpP0vaDEN5qaIk7cunl397HgOjnXzyHfT2nGIEmxzuX6/H93nv
 f0z19ECNGuRjMYJl3XyZMP8uRhNQcRwnXncj5wF6EyT7KqJjMJiKTF4yvqOQ9vSr3XfOegyaNIY
 o4aDpxqGy0cIu/hxZg16sWgrv3GjpWMXnv+zVZuBO14cJfpTuD56Vnbx1vtBVENM2o
X-Google-Smtp-Source: AGHT+IG3SZ9Hkg7REWGAA1sT8xftCOlnwEfPeuuOv6hn/fbODIxvOTjlhvV1njppnPTYdZAHs/7V7Q==
X-Received: by 2002:a05:6a20:3944:b0:232:4a42:dfd1 with SMTP id
 adf61e73a8af0-24340d7c205mr4435343637.36.1755863547315; 
 Fri, 22 Aug 2025 04:52:27 -0700 (PDT)
Received: from ?IPV6:2401:d006:5c08:e100:56e2:b289:a647:a268?
 (19r3hzjn0zxz3knrhj8r.ipv6.originbroadband.com.au.
 [2401:d006:5c08:e100:56e2:b289:a647:a268])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b47640b2d37sm6973268a12.46.2025.08.22.04.52.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 04:52:26 -0700 (PDT)
Message-ID: <a01f5867-68a6-41e4-9204-66f40616eceb@linaro.org>
Date: Fri, 22 Aug 2025 19:26:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] accel/tcg: Unify big- and little- endian atomic ops
From: Richard Henderson <richard.henderson@linaro.org>
To: Danila Zhebryakov <d.zhebryakov@yandex.ru>, qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>
References: <20250821113348.91339-1-d.zhebryakov@yandex.ru>
 <20250821113348.91339-2-d.zhebryakov@yandex.ru>
 <35a78a36-989e-425a-b99e-bda52da8d20c@linaro.org>
Content-Language: en-US
In-Reply-To: <35a78a36-989e-425a-b99e-bda52da8d20c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 8/22/25 19:24, Richard Henderson wrote:
> On 8/21/25 21:33, Danila Zhebryakov wrote:
>> @@ -1894,6 +1894,14 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, 
>> MemOpIdx oi,
>>           notdirty_write(cpu, addr, size, full, retaddr);
>>       }
>> +    if (unlikely(tlb_addr & TLB_BSWAP)) {
>> +        assert(!( (  full->slow_flags[MMU_DATA_STORE]
>> +            ^ full->slow_flags[MMU_DATA_LOAD ])
>> +            & TLB_BSWAP));
>> +
>> +        *need_bswap = !need_bswap;
>> +    }
>> +
> 
> How is this supposed to work?
> 
> (!) TLB_BSWAP is a slow-flags bit, so it will never be set in tlb_addr.
Whoops, we've just got finished merging the slow flags back in.
I'd best do this again with more coffee tomorrow.


r~

