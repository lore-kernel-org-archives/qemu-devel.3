Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6003AC5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 00:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siN9l-0003eW-74; Sun, 25 Aug 2024 20:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1siN9c-0003cl-T0
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 20:00:17 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1siN9Y-0000E2-VO
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 20:00:16 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2d3b595c18dso3372623a91.0
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 17:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724630406; x=1725235206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FDr9gSVjVQU1bimm6GY+JLZZEUF+PQ7rjmE1idPWavw=;
 b=clNj3hVi/6vQtRwnlhL88dstVdC+6Cohlj9wqlRKHNc5OsEbwHBXNtHUIrCWB8TtRE
 FBKlX9OBE5cOWZbxPayBgF5sOaQABKkf9PuSBtlP6QX5WlMsHds/sIRdxxdZ1AYfj1fk
 CSWK1I/9p52Jb3NWlfIhJwfYoxLkCro6W0oi9Z+ooAXoNZwwza/1OenYLA6xbUuGneXw
 cyFzCZvi1oviZM+aasoZj/XRZt1OD7U3YGGhXsp8wgBHtCWMftlVFdGhRyjvxCZ+aN7+
 H8EhIepHBPSu4pY1Nrz7HQ2XjLQOD/w4+IjVWMZSkW7Yk5ZXsL5F93inx3oHfvVUvU/V
 iMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724630406; x=1725235206;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FDr9gSVjVQU1bimm6GY+JLZZEUF+PQ7rjmE1idPWavw=;
 b=R4YZEwGrMwhRz8A1Ya9PWzpkPGsPIo/Vyu9cZwr1JW8BhIhs3AjagBHX+TJllbo4du
 ul/xaR6W7bEzei5fqQtWbh3sPTefPQX4VmA4VzjwLDDX+OKGRnu5+GarIOiaxBBBPmTH
 EIUtPWRiUeUK3lvhTtWbNpm52Q9IQJFf//2fWUIZ7vc4EOstIcZwfJZ29zxyNarkyS0W
 OGxIE6dBu89hLBmG4LKU4sq/kWpKYYv508WKZzWLoFc7C4o1AYkUqrdafQt595/3dvBj
 IYGypUgwD5NucjNg8CacXXwgDWXDfsYYtw4fzVeBcVFrdHbB9fxerTeWXBTyZtPKELzc
 mDTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7vrBT9wmevz772zyVM3jXgopT4PzmDyDMvus1mzby4f3BxDouExSa8VQ74zCcIN8BmV2l18N3f3eE@nongnu.org
X-Gm-Message-State: AOJu0YxtL4UHt3gvKaP7yJg6n6fV2kdK/EgtWNT1HSX9m+l0XB+kxT6H
 6OhYJpzxLxPyWP63BHeC1/7AaPO5AIDq8++e6PfCZlTvLVWEkaLvc4K2U9UwgxM=
X-Google-Smtp-Source: AGHT+IEjhjaY+puL0bFy+rQGub475+DH0n/JGbDEqi4Y9TvdLaG/RzLNzTW4q4dwR9rpSUCvNWTX4g==
X-Received: by 2002:a17:90b:4ac5:b0:2c2:4109:9466 with SMTP id
 98e67ed59e1d1-2d60a90006amr19158272a91.8.1724630405913; 
 Sun, 25 Aug 2024 17:00:05 -0700 (PDT)
Received: from [172.16.0.208] (180-150-104-113.b49668.bne.static.aussiebb.net.
 [180.150.104.113]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d5ebbd9d72sm10675958a91.49.2024.08.25.17.00.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Aug 2024 17:00:05 -0700 (PDT)
Message-ID: <10bf932c-ec07-4f2d-ae11-93fdd2bf84ee@linaro.org>
Date: Mon, 26 Aug 2024 09:59:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/17] target/riscv: additional code information for sw
 check
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com
References: <20240823190140.4156920-1-debug@rivosinc.com>
 <20240823190140.4156920-5-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240823190140.4156920-5-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/24/24 05:01, Deepak Gupta wrote:
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 12484ca7d2..9f08a67a9e 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1761,6 +1761,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>                   cs->watchpoint_hit = NULL;
>               }
>               break;
> +        case RISCV_EXCP_SW_CHECK:
> +            tval = env->sw_check_code;
>           default:

Missing break.
This should have warned about fall through...



r~

