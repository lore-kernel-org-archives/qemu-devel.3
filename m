Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77540C5DF8C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 17:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxT6s-0005UI-2x; Fri, 21 Aug 2026 13:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxT6o-0005TZ-ER
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 13:32:50 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxT6m-0004PN-GO
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 13:32:50 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38101f85591so1889914a91.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787333565; x=1787938365; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AziSiQyaswun75qWBZdrTtRtHkm/3fH7WtNiAoSsvxw=;
 b=zKgOnhVh2FQJCJLUr0LkyWXUFe6TO+O5nKTczW3vod3FzqzuKbqnHpzNfN2hWa3qKY
 XjOCs3kECsY+fxDcttM9/DvLGqfXBx/UIzstSfhCitg+veXEpIciVPTwf9/TKdVpocJW
 tdIMpaiKheRrentkf5yqMyl0B8bVAM94xwSef+aTiI+eg0nQEi0Y6P+7divwH8YWIIlp
 F/BJCGDbz5EV3Fz3ThsMKo5KYY5oKFbqwBRAR0UUWpcQBCgPtSwcIBdYKoDrSGbd7YTL
 zGygzESoZqa0djpkI0Ugjl0Rqn52etREFn7Joh0xgY5kr6N8EBq3T/29cHg9npNxFFNb
 LfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787333565; x=1787938365;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AziSiQyaswun75qWBZdrTtRtHkm/3fH7WtNiAoSsvxw=;
 b=LsjiAf4akr/JF1v627pOeSmmNYaWwf2UNgFALR4KyoasvnsHAc7xABaEJK8DePqk2o
 dkOC4NnscV7yhM8uJJJZVZ6H7LEQKXsoB5rSAkuk/4Pu7cZFdCDzTN7vSDpq/gblBp4r
 EDG7h9EY8us5RJ8Toky0vxejQIKyccZOmJFCV6kVgDzeg74RddbyXgDiRWdoyiyEGChn
 w3vPFUm8CpJ5zMFL1hfOsh04AcPGvLXqzwM2CtEYc0XNoDD/e83tZgQhfl5qYz9wJ5w+
 cb4w76i5/9Z4ale3a5SfRy6jDYx3kNqLAx/u3truEuyksqMUezaf2Y1KHinbi/l/DBaj
 M74w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrp1xsHDspcoKrBKuUoz45s9eFcSJVFtm3x9X2wO65mBuxfzUqM2FjiaX6k92XhwcNi1eCxv2LuSNVY@nongnu.org
X-Gm-Message-State: AFuF++lcfJsJ51d01zuIjGfcF1E7s3R7Ilhu/dO1gupm0ji1W1quPPKZ
 +I+m9jo2ongZsBU40hQRthmmLypLLUX39mFicIhTIiFmnf+0+9kqvZk6Brgv2bRN4bQ=
X-Gm-Gg: AR+sD10KbZKD1nbtpwbQKZLjCR5KW65M+liAFI2T99c0E3uMmScujO45oJJ17qBuhs+
 VTulH3hArWn2m8GaRw2WxC3V9JCEfRli08rjS8HZUGpC+vKa2XVPCmNHE7r6HkZ/mxejEgsIZqu
 7WSHpiZjKwerD7Ck2qcGju6on+eI/lyLUffV+K+QbSZbQHk9628ewoC/T+zAYQNFwDHpuyNOvB/
 8+Net/v1xRHn4B+cT02No74SGO278Ql8bodqbRBcgCV11dhAzR4niEMlrqb3NKOrck7O4DbJmVH
 XWnYRACiiGpnLlXTrXvAdnZn1ckqBPc2MqmynC2GqZoVWJoPacyTPF+BZaVCnxUSN9z0tZw4Z/y
 gDfygaa7M1QAEbMWM7u0P35fPup0OniOepJINtFSBIR66yszn3ZNeE9CaObBLwBY/NRqEachG5y
 L2q3/OAHDHEDoXiriFNfxjIkO9HTDAlSzBWJt9kc/nw+RfOxIozdgk68koVE540VYTg6uR0FUOU
 Kva+CZqKQ==
X-Received: by 2002:a17:90b:1dd2:b0:385:3ab:fecb with SMTP id
 98e67ed59e1d1-395c4c98f17mr7683255a91.4.1787333565091; 
 Fri, 21 Aug 2026 10:32:45 -0700 (PDT)
Received: from [172.20.6.168] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4b47ae8sm4014181a91.13.2026.08.21.10.32.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 10:32:44 -0700 (PDT)
Message-ID: <bad5c8b3-668f-4893-974f-9dbca8dc6893@linaro.org>
Date: Fri, 21 Aug 2026 10:32:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio: Add aligned ld/st accessors for vring
To: Peter Maydell <peter.maydell@linaro.org>,
 BillXiang <xiangwencheng@lanxincomputing.com>
Cc: mst@redhat.com, pbonzini@redhat.com, peterx@redhat.com, philmd@mailo.com, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20260821100856.1794011-1-xiangwencheng@lanxincomputing.com>
 <CAFEAcA_kLpaz0UQi3Q315kLVqvDtxKh77kU2meN9G1_evfKBeQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_kLpaz0UQi3Q315kLVqvDtxKh77kU2meN9G1_evfKBeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 8/21/26 03:25, Peter Maydell wrote:
> I'm tempted to suggest some kind of "if pointer is aligned take
> aligned path, otherwise take slow path" either here or actually
> in lduw_le_p(), but maybe that's a bad idea. Richard ?
> 
> (I have a suspicion that other places than this one will assume
> that an aligned ldl_he_p() is not going to tear.)
I agree -- I expect most everything assumes ldl_he_p won't tear for aligned accesses.

This kinda begs the question of what atomicity the caller expects.  It's not implausible 
that an x86 path expects even unaligned accesses not crossing a cacheline to be atomic, 
since that's been a thing since 1995.  I expect both IBM architectures similarly expect 
atomicity by alignment, since that's been a thing for s390 since yonks and Power has the 
same language.

We have a bunch of code in accel/tcg/ldst_atomicity.c.inc that can handle this, we'd just 
need to provide it with the correct inputs.  And I assume we'd still like to inline the 
single access on appropriate hosts.


r~

