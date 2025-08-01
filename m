Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B8FC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 21:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhwvo-00019d-5M; Fri, 01 Aug 2025 17:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhwDu-0003uN-Hq
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 16:19:26 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhwDs-000256-SH
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 16:19:26 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76bc55f6612so2388209b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754079562; x=1754684362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CptNeUlPmzJxhRSJy4CfQx61s83a/WcunKZ6vxtsxjk=;
 b=T4HAbsNG172Ddtkq3uGh1InlirySy8FMpP8zdCF9UnJZ6q/3+zaEfoSwnBag7qfirI
 zyo1/auHFGxM3ahlg0iQskTPWlkWwAiClTkGHioBc0zgKnNBu4chuPW1aG7/lhV6R5JF
 B9iKNDVHUdvw+ZHs/bXq5DexiI+/XHnp4HEiZUe4wwySZRjZ20UDaRw8CcaS3sYcOhne
 m6JMIoGM5Cp88d3LNGIW3+1lGllD/TcFlAYrWbnJ/v+PGQQs8feoedHZ7NPKimSVjG52
 Dgkw9t3K802Q9YwQWKNwE/DPg7NAdZUNIAloOznle52J67YU+a8CKKiNm+FNEMfdr0Py
 M2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754079562; x=1754684362;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CptNeUlPmzJxhRSJy4CfQx61s83a/WcunKZ6vxtsxjk=;
 b=Nm8OeUHzogf6U0+KdDNBQpIYNO2zXueHXWz2cqo1VL5kdaGs/p4sWpxVEepbWv363W
 e1Clpybzjf4r6CHPME93X+m/bLHp0IsetHsOPrPwcHTmymrETmqu0LUr7ky2uUyo/FdU
 44GtlLiso9P+5wSYh0OWwGIs2MM5LbjuA0X8Fj/7BjAeAaupJI4Zj1O/l7YSQnFe7WM7
 KJ30zWWXsr3Vuv3EEoQBQdW010iYtMVFIcz3jgT2YRQMBG532/OXKvHBOEVQUy0oSjFr
 YRzXnJOfOq2v9SZwi+hQGY6aaOI7LMoT4qS2k04n5SprotwXX/EcQtN2mU73B1L1oxdA
 AB1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbbNBkyo0Jizpl49VHwrk5HBabjeAWWQDOdPU0zyG+sBoocLiwF0wlgGBzZezp3761VyiEQfD7m/RI@nongnu.org
X-Gm-Message-State: AOJu0YzcS45lGoS2dr9XVEjJA5TFraenZDVlBSjT/la8n0QpauTtkwPv
 ELTPanv/8CkSp8l4HgNcoeWP2TOv5BAyVi6LBFwp1OA1mVXvQkH0ZenqoU00EvxauqM=
X-Gm-Gg: ASbGnctWTdK46+85izvqvMUcI+CWGkMt3vAW2JzbhUf9kNKoQcsSfrPdDB3pIz0BSAi
 /FSSOhrMEIxhXXZju60VTmgBXgutTfm9+GO6RUeeHiYP+UwWdxd/Su4tyBTL41smhlgODZFF8Dh
 9tJj0CDjM6w1+q/HRDnZNk0gCgUHvTDNW8/hzXEPsTLTl5RNlg0OniWJ4EEbTZ5BlT3iEvBf3xX
 V1TALF3n/RVQzYqmd1nFhFW0MZ6wEHaqKd4iGh2cQF/0mLXwgymjdji7Uzz9UFJj1LODllrUvEI
 w3QNBqLJFjPsbxzhwXE7MYy/mkVDHalyfKwVcZE/aKtgGLPB+v+sZce1eEckAwGXVDpGbH48K56
 XSvMjoMVD8qkl+x+x9L17Ydi4yFojBAHBT9jMNM4CJRiXkyg2Ji0=
X-Google-Smtp-Source: AGHT+IENmDtsjaMEUtyKwuN4Oqxn8s67iHVaD29mCGEEetaPoizsmt5U4P6yio5n7Wl6C8zBEtonIA==
X-Received: by 2002:a05:6a00:240d:b0:73b:ac3d:9d6b with SMTP id
 d2e1a72fcca58-76bea8c3e72mr1089194b3a.4.1754079562546; 
 Fri, 01 Aug 2025 13:19:22 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbd05dsm4697688b3a.81.2025.08.01.13.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 13:19:22 -0700 (PDT)
Message-ID: <383bbb24-3b38-412a-8036-b29f88374cf4@linaro.org>
Date: Sat, 2 Aug 2025 06:19:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 47/82] target/arm: Expand pstate to 64 bits
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-48-richard.henderson@linaro.org>
 <b2e40787-6043-4d4c-9cbb-731d0e92e25c@linaro.org>
 <f398a65b-7b1f-492d-a612-eb3d6322ae4a@linaro.org>
 <afb60f16-5ed1-4612-ba78-d849d9fa3998@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <afb60f16-5ed1-4612-ba78-d849d9fa3998@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/2/25 02:12, Pierrick Bouvier wrote:
> My comment was related to vmstate_pstate64. Sorry it was confusing as I left the last 
> change concerning helper-a64.c, which was not related at all.
> 
> So the comment was that vmstate_cpsr already contains the lower 32 bits of pstate, and 
> thus we could save only the upper part in the new field.

That was part laziness.  By saving the lower half twice, I can simply do

   pstate_write(env, val)

to load the data, rather than

   pstate_write(env, (val << 32) | pstate_read(env));

or something, to merge the halves.


r~

