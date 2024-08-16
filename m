Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707D3C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ses2T-0004yc-Ea; Fri, 16 Aug 2024 04:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ses2Q-0004xT-NX
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:10:22 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ses2O-00026r-Sb
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:10:22 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fd69e44596so11436955ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 01:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723795819; x=1724400619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c/nAzd5qZjiEJ4tkmztaTnAryvM4c3uTG9Q3ZGFOvaM=;
 b=HIdpjg8twonuVjZFNi5fBi7FlV0aFH8/Gy8J09/Ae4vDKfOpiHZrQzTRx/pkgzfcTD
 m0T7UpGEddFBHi0EQbtP01TcrlDLJZuXJOl+Am/azF1B/tOuJgxfjbUhVTbFhxcQ5yyC
 qW9zziW1cmt4gZ/ng71X3QutkQbUJPT0eMxQX/s/40RrAwzpCKTom4qqPeFKtRRd/Glc
 87sOngA+g7pKdzC8gkAqDN5ly0SEGYwQbq42haEFi1hvv82x4/nQwIzBr/mNVjIBAzgi
 HJoNFcgbb/+Ke3MYIGFEjsg5+oTc5q6hIZ3cr0mMmOQ/zvqKp/kcEykY3V0IUhmPCoTP
 1sqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723795819; x=1724400619;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c/nAzd5qZjiEJ4tkmztaTnAryvM4c3uTG9Q3ZGFOvaM=;
 b=Dsd+akQ3UOD9sgDeu9GXhHR8g6dgorjQ2tNo+1a4qfO5qOn6Vb7ilg71ZW3vHEXZpo
 YErtnm/S70bL22wP0X5deOY59bkyzrKb0DI/eytHVw3D4Q5ctVwkdsy7La5lWluqFuDd
 mrQaKkK+DwnSlfkvvF1gYX+Juhmm1mu/RVzZe1tMfc/V6DfmIcaF9L1xOdCD05uptIHH
 TztoXRN7GURnX6bQmIXI3imdSJd2sGFkJZZ146n/7OJl7fhV5M0QEoHS/TjgiJC1Ni7k
 WQx9sRFM/XAtFe4RlmpCDuHwkInLu85Rn0xUctrGxaFLBlCYFK1ovTjS8MJ5Om6/5g4P
 osLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMevCHPO244lT5FP+Iwu0/4bbdRgG8A77M96GhfjP4IcziE04RLm1dQDIhp3CwJr5JJMFu1N1txwc8@nongnu.org
X-Gm-Message-State: AOJu0YxclWDwmB25t3Gef7xqTbCoX1t6tIlBfgDgtgm21Y6Vty+bDM8m
 sW+1Irro4V6CUvTJKDFzlXniHUQshzokRJstBSHWl1+RWHr0bbn4TpPVoEQ0p7Y=
X-Google-Smtp-Source: AGHT+IGImjoBLkUTyqTinXoSMvyTosTqs1H3VsUPnoR5H5ZfmPvNn9GU41i0aJGPsZe6DjY54zWJew==
X-Received: by 2002:a17:902:fa8c:b0:201:dc7b:a88f with SMTP id
 d9443c01a7336-201ee505cb5mr69400775ad.25.1723795818755; 
 Fri, 16 Aug 2024 01:10:18 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:1b6b:8c7b:90f9:144f?
 (2403-580a-f89b-0-1b6b-8c7b-90f9-144f.ip6.aussiebb.net.
 [2403:580a:f89b:0:1b6b:8c7b:90f9:144f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038d715sm20943965ad.198.2024.08.16.01.10.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 01:10:18 -0700 (PDT)
Message-ID: <6ae16141-22b3-4ecc-b31c-341c76a2fdeb@linaro.org>
Date: Fri, 16 Aug 2024 18:10:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1] linux-user: Handle short reads in mmap_h_gt_g
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, qemu-stable@nongnu.org, Warner Losh <imp@bsdimp.com>
References: <20240815213231.303424-1-richard.henderson@linaro.org>
 <8fe5dda6-a72d-4c63-8c57-75197709da9b@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8fe5dda6-a72d-4c63-8c57-75197709da9b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 8/16/24 15:57, Philippe Mathieu-Daudé wrote:
> On 15/8/24 23:32, Richard Henderson wrote:
>> In particular, if an image has a large bss, we can hit
>> EOF before reading all host_len bytes of the mapping.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: eb5027ac618 ("linux-user: Split out mmap_h_gt_g")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2504
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   linux-user/mmap.c | 19 +++++++++++++++----
>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>> index 6418e811f6..de9ab13754 100644
>> --- a/linux-user/mmap.c
>> +++ b/linux-user/mmap.c
>> @@ -853,10 +853,21 @@ static abi_long mmap_h_gt_g(abi_ulong start, abi_ulong len,
>>       }
>>       if (misaligned_offset) {
>> -        /* TODO: The read could be short. */
> 
> I note there are other short reads in {linux,bsd}-user/mmap.c.

Ah, via mmap_frag.  Hmm, yes.  Worth fixing at the same time.


r~

