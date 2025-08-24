Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C33CA0FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 23:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqKCg-0004yy-0J; Sun, 24 Aug 2025 19:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uqKCe-0004y4-6W
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 19:32:48 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uqKCc-00014d-Fo
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 19:32:47 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b476cfc2670so2577346a12.3
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 16:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756078364; x=1756683164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LYGVPB7ub5S7uquRo2KwVeOP3Ng6VN28Vn2GFilaiPs=;
 b=b+w0LiFH6cHX6ic1Wbl/2CnS/vd2HeDRUog6aNJohDg70+nSgzev4BHYO04roMAys6
 juARPgZifGjZzyx30BQ5hSQMvfk8E2TsdkoteAkzEBNO6EDbvl51ZBnY5om8pdTkL2XX
 +ub8y9X4zrAyVChi45D862zhO/rqokypqumLtUF7wNeqynzEhb+3Vx/2BbsNh6C2Lu5Q
 CyCWDOb/jAZBRdrSAEINrr1Zomy3C9pV/dwIN2tGOaNjJ/x2gmkLBdxXtBb7Idw3Nex1
 md9cnfbC4OR9dJ3DWGhyNBjMvKL3EgVYriwmg05HKdQ52eekaKnwO0g7ke4+zKh1Xft9
 Zv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756078364; x=1756683164;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LYGVPB7ub5S7uquRo2KwVeOP3Ng6VN28Vn2GFilaiPs=;
 b=uMipMYWCRTsVNSd9e0wwLIPbXwM+oXAmTe5RYbyciEPydUQA/tP4d6lNK9vvpggU/V
 OtPcUEkyLyymtLpSdmjgE0h20Rcp6s/eqlyuVNKcbZsC6YJ7/48MgoD26pEb+acYeq5b
 AU2cBdIY7kfrFE9ZXPYIrTCcOsstXwR8HZV8Hx/6kmKgu0JMV4IA0UBNHvnGaeVBlmuD
 oUhJsMp5l7e4T/e6R4aB4AncN5d0E3x3tL7fNboAxlE0tPkJ3E9Gf6OoXFwuMnJ9s/8F
 pEvpGg3DUAWYqBe/LbCKI5B0IHwrQWHkOsgoEynM1pYu+j6mIQq6w+E85zq7y6XKyG5I
 /Mkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWifR1J2TmAg8Iu6GRDvCQ5lgVJOeX5A5uD5HrFQu54of8ikFa+z5rxu8e8TIdlGVD0LeW8ErbPbhcm@nongnu.org
X-Gm-Message-State: AOJu0Yy20uDmCgmDSkafaKEcJUr/97crZr3NEmc0nKBFkG4aWv9s1xg2
 +8ioQYvODAq1/34k8Rk3u7SOQ4UqMd7oBCxmU63Rmp6UzescO0RKYgmY7RpaiAlta7c=
X-Gm-Gg: ASbGncumE7ahwjmaKpUjCx+bza7Nul6xeTm0FQe7gqIUSkdZDclbsNDBj96n5GrYQnZ
 5HWsi2CnOwj32pgz7E2QzFR7YJbaqfTZGO62GQq5s7f4jTa7jVNfagXdJoBrJ8tYQSAbAe5KuOz
 eDKJ25YVkcB2IrFga6KRQzg7/Zx64BFW1NfjCmQ7ENzf9uG5tuvS5qyuObjQNGXXa81LfZBLQTI
 pgHZ/1pkkr7CsnqoBpq1+qXY4q8MaMZHJKD0WOjIyw0OrFBpnxVPAfx7ijQomIIRq/rM68/E1Dz
 tbab3kO4bZbvCLSAYCt2OQUR97Y0Qxqdo/LTF4qo5ysAFD4ZGdrmdzhu3a23X+eSk0K5hnNdTzc
 lX5OaDea/QR8pwdhoEwMrbhG7QM9P3TNf/r/6lw7ZWyyflcMMHeuIlpbLdOZSwj4M2IOCzi+9N9
 qx6FyIymcWYN/h8NlmQPs8UggKlCYTO5gM5K6qV9OiM6/DZZFvaFspBDiHiwGDBObu
X-Google-Smtp-Source: AGHT+IGSgqcSvLbMvKsUGN6aPpBASOBG8jN4AVUEUeBocKtKKMfB7NOfbJfg4joiqfcoVU4nzz1HWw==
X-Received: by 2002:a17:903:8c6:b0:240:3eb9:5363 with SMTP id
 d9443c01a7336-2462ee7390emr119415275ad.27.1756078364346; 
 Sun, 24 Aug 2025 16:32:44 -0700 (PDT)
Received: from ?IPV6:2401:d006:5c08:e100:2b1d:8711:2597:136f?
 (19r3hzjj0vw81f3fs315.ipv6.originbroadband.com.au.
 [2401:d006:5c08:e100:2b1d:8711:2597:136f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-246687b0b0fsm51317165ad.50.2025.08.24.16.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Aug 2025 16:32:43 -0700 (PDT)
Message-ID: <80a82610-0423-4e25-a88a-14c4f7d95ed3@linaro.org>
Date: Mon, 25 Aug 2025 09:32:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] target/microblaze: div: Rename and reorder
 function args
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@amd.com
References: <20250824222734.4151956-1-edgar.iglesias@gmail.com>
 <20250824222734.4151956-3-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250824222734.4151956-3-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 8/25/25 08:27, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Rename and reorder function args to better match with spec
> and pseudo code.
> 
> No functional change.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>   target/microblaze/op_helper.c | 18 +++++++++---------
>   target/microblaze/translate.c | 12 ++----------
>   2 files changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
> index 470526ee92..092977b3e1 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -69,9 +69,9 @@ void helper_raise_exception(CPUMBState *env, uint32_t index)
>       cpu_loop_exit(cs);
>   }
>   
> -static bool check_divz(CPUMBState *env, uint32_t b, uintptr_t ra)
> +static bool check_divz(CPUMBState *env, uint32_t divisor, uintptr_t pc)

The name GETPC notwithstanding, I don't think ra -> pc is a good rename.

PC often gets confused about whether that's a host or guest value.
RA (return address) is less so; it gets used often in core tcg.

If you really don't like RA, then perhaps "retaddr" (also with quite a bit of usage) or 
"unwind_pc" (no existing usage, but very descriptive).


r~

