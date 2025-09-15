Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B33FCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 13:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy934-0006cT-B4; Mon, 15 Sep 2025 09:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uy92v-0006bS-Pj
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 09:15:07 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uy92n-0005uu-Ir
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 09:15:04 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-77264a94031so3012833b3a.2
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757942088; x=1758546888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dzknIR9WorL3EsWUkasVWrX0WbxR3NzxaQReDN++GNs=;
 b=u8+zJhwiXBUf7+igem6Ay9/3iKQAQyN4stVwT1UQaDQYb4XkTBgiWasgcYLnTPl5Jm
 F9cf7dVniedmUa+mDYPHx8o8UI50YX0k8ki9XfuPzyzYscOa9hQKisOaqHKmg2YnUTCz
 n89DcxZe4yorINusrR2wUw1bJbfALFeNgqhbaIb+O8vnbyBI5OP0KoV6qqg4hxpKVLIr
 02GF79GiAW6ZAsPIuIq9BikL98NPzW5tZZ1RI0FFb8h/V9lU4uo2bzdsPbelvAPbwDZm
 XJhSS67KHNO3NaaZhQgRNGb8/huomb5K/SwOpDdXs7WGzpnI0WyIY51C7bu5+T8/2tPP
 XfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757942088; x=1758546888;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dzknIR9WorL3EsWUkasVWrX0WbxR3NzxaQReDN++GNs=;
 b=PyoJvKM885GSX7f3htJXOPFlM0oVIZsHgAtkD5QiycJ2FFaxFPa0ZKQQLE6v5i58TV
 MmSjmkklktf+1z3rwnw4bru75SCv7toQWOJ3bCr/glrlaWdToymb6w9fWtY3vmx8j7P5
 EGN6/rjRTg8fkk+K7nXqayZIGCNQ7m5wA+z07hg9T13HsWP6bTCf48LCoinm0VBpD/dV
 8CPwzP47+V3wdiUPqwwOa6OX9npbYlgFL2mfmIzfx5NWZWPpFMgwCYNrWR+HEsWlxWYM
 fSrnATA4odP6sx89P2dnuYsxHiTotYjRMHC3T/hA5FijJlpzXm/sMdg/ysCwSWy6XoJw
 GaKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtUWiL3oE6gRC9QI+a3pFTu0kiipAtyN8rCNMmBWrmkLCWSfc58FuGnQIWX50BEVpQ/T1igRaDzFEk@nongnu.org
X-Gm-Message-State: AOJu0Yz/t+KKJHliAcDX3qn5wW0H8MOA7zRotBQUP1OJ3P3+QtgyLKv/
 r+0OpAAmFKZMG1Oa5S1ejxlEBjX34+CY2m0jTZcgjj9R1IisGb0m196Bo/JmGApVCKw=
X-Gm-Gg: ASbGnctQtjhHkRqTWI4Ta3hCicbo69UB8kaU0OejLWrnl17G+WGJ6Kbd6ikMM9ot7d1
 lvhz5LmK9e+mt9Z2/V7y9Gx7+NDDZhyO6fuoVbrlOHxadmG7CdD9exLeW4xAYROvw0R/a0ep3t+
 L82YYf7fqksrpfS6NwDnk7DY9I1U3VoKz9A2jSuCncFLsXu46Js+L4JlORcreaX5+Y8wn1evwOv
 nUND8BmnOsvwPI1QChXR8UV3Gp2S3N8FIcZESLVJB5v9N/GGY3lz2ApAjyixoTsCEB+wZPYtAVa
 26+MZBKHLKiBMXEsSkDlbyuHnUOjRaFOht62wApu8DZ9HtSFAxBbv9Lnfj73jJTntgcGW/tjZU/
 T2yRNURC8MroFVRhXfUePj/mBi6dO6MBdrkqx
X-Google-Smtp-Source: AGHT+IHC0qXCTjhQn4uuEpgJSebS3ujEHmrfK2UtxgYxQ2kDJpYLkkNp0dUBo9l7RPFSnCiHg2ZgfQ==
X-Received: by 2002:a05:6a00:813:b0:772:3aa4:226e with SMTP id
 d2e1a72fcca58-776121637ffmr14294722b3a.19.1757942087916; 
 Mon, 15 Sep 2025 06:14:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77607c47260sm13675673b3a.94.2025.09.15.06.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 06:14:47 -0700 (PDT)
Message-ID: <8ca09e2d-47d1-4259-97a7-481d68a979fa@linaro.org>
Date: Mon, 15 Sep 2025 06:14:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/ppc: Move floating-point compare instructions
 to decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com
Cc: harshpb@linux.ibm.com
References: <20250619095840.369351-1-rathc@linux.ibm.com>
 <20250619095840.369351-3-rathc@linux.ibm.com>
 <7857ae80-63eb-4d18-9618-d6c94cdd0c17@linaro.org>
 <768c783a-7165-482e-aa28-86430a4527a9@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <768c783a-7165-482e-aa28-86430a4527a9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/11/25 02:29, Chinmay Rath wrote:
> 
> On 8/27/25 12:49, Richard Henderson wrote:
>> On 6/19/25 19:58, Chinmay Rath wrote:
>>> +static bool do_helper_cmp(DisasContext *ctx, arg_X_bf *a,
>>> +                          void (*helper)(TCGv_env, TCGv_i64, TCGv_i64,
>>> +                                         TCGv_i32))
>>> +    REQUIRE_INSNS_FLAGS(ctx, FLOAT);
>>
>> ...
>>
>>> +TRANS(FCMPU, do_helper_cmp, gen_helper_FCMPU);
>>> +TRANS(FCMPO, do_helper_cmp, gen_helper_FCMPO);
>>
>> It's probably better to standardize on TRANS_FLAGS even though the flags checked is the 
>> same for both of these.
>>
> Hi Richard,
> 
> I did notice in the code that there are quite many instructions using TRANS and doing flag 
> check in the common helper.
> For example, in target/ppc/translate/fixedpoint-impl.c.inc :
> 
> /static bool do_set_bool_cond(DisasContext *ctx, arg_X_bi *a, bool neg, bool rev)
> {
>      REQUIRE_INSNS_FLAGS2(ctx, ISA310);
>      uint32_t mask = 0x08 >> (a->bi & 0x03);
>      ....
>      return true;
> }
> 
> TRANS(SETBC, do_set_bool_cond, false, false)
> TRANS(SETBCR, do_set_bool_cond, false, true)
> TRANS(SETNBC, do_set_bool_cond, true, false)
> TRANS(SETNBCR, do_set_bool_cond, true, true)
> /
> 
> Do we want to standardize the use of TRANS_FLAGS in all such existing insns ?

Yes, I think so.


r~

