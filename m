Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0F7CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95G9-0004yH-4X; Wed, 15 Oct 2025 13:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95G6-0004xl-Fx
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:25:54 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95G2-0007sr-LH
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:25:53 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so44032225e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760549145; x=1761153945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4yb5QG4a7Y3basfKirTh6eapcJbf1d3WeZHKAe9HrKg=;
 b=R7okyWFVhrI6wmZcI5rSaQW2l02zqkl/uvUexkQf+wMAAF97EP9bKOB/GNpvM80scm
 PXVBhuVdo71fHa6IgeB0AksBAR+FvN8A3Jpf27pEcscq9YFPQxSP7SlCXDYmyVGZawdw
 Yy3dwCM9l5757zbmde329xAv6vEFTvCYKFw68O5ObA+orGfxrjQhqYpwJyaJSTfLEvlr
 oy6B+cC1bCXTPbNOCtx8TC6+l8wO0m1/5yn0M4tsGooKhpQNMaOb06/BGIuR6Qpa8EEw
 JQVNUTx3RBm7TVoSkj5Qco48dfbh5+oAKgGVXw+UoL5X8Q7douVZt1C72CKqGTpzEmZt
 LXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760549145; x=1761153945;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4yb5QG4a7Y3basfKirTh6eapcJbf1d3WeZHKAe9HrKg=;
 b=kfb02QYeFLVsSOiI4GZ9i665J+8SgKzXIE2TU2L+cvZ1PisysnuGwa1TeGqbMcVsku
 4ls8sj6ku6TL5MuIiukG3eZLcmy71Q5Z6TX1awzbGKd+GCL7PsD0KvuPhBxKfWsxwvXy
 SyeKXsENJCf4KdP/udOognRo2KEIA+4YDh8IN7XfThWEgacAjsLY8c4Xf002GqsWehYv
 I4vQOGMllc/z02FR58tr8DdmFoJpMnX4Yh6GbtZ0RU6c1B+eyUUbj2NQ6bxIoaJPy7ji
 nt6VGY9O8cSi7i3yl7bCRdlJQyEGwcco0eV/rlfJy9HBQgjyN6570zMNOpoRjYAad8sG
 SNuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc7IvBcJIzgvx0kD7tHcPVP0q/b9KOD5L63AgCn+AbDUyKbCL00FAjBpCYL3EbZYenkP2d3z/0W/2J@nongnu.org
X-Gm-Message-State: AOJu0Ywaf7DbJjd8mvXbLG5HHrGIcs9YLJDTKyfkoFnhgZsP9ivZBY+s
 zJFQkoWk+Z/HGa/0MO+o2d8cFy15D4uvmKicBSZ9DHaHhI1Bp3UejoW7ZV5XCOvuXBY=
X-Gm-Gg: ASbGncsIhPnJyJ+mVvSzBfvHFJQrJyqL1/ZtVN+JIKNRbBeo0QTIlVzYH/XdGuXzOHE
 62ljDjV1plTWdPTCI455NFDL1H12AysSpqPJsKiVWQCsQmPPPJsDjvWhpPC3dN3+L2dr8kGWRJB
 ggWx7VnRBH9rebIrgrdrVogE7CyTXUDuB4JmELN0+iwyYUhPHExB8ex1kQ70lJ8NszpCnY688pG
 Houf8BSuzueF/3xfqonpQuybUFW4So/b5BCr7mRE6jUiNZ9TRo1ue30Vy1MgEeJm8pz1saemS7P
 xuAHGD057DeRipT+JFJb4I0yF/yJVSFGNcKB83npPCASq7FH7ebLU+UYhcGaSKDe5yBq+5hSjDc
 oYag6EfNME1e1eHAziv6c7flRNbpHw1lsxUJGmPbo1AHTl58AN8m6pBTgqfWH5zGP1K1/dJfp2c
 i+cp2uiKXrd+By3cn10cKD0HY=
X-Google-Smtp-Source: AGHT+IGddQyXZnQ8RoDu4Si3D5BcIjeQuhgmNoSXQX/w13sUrbbOq/q+Tj1HI/epsOhPh31Ut3z81Q==
X-Received: by 2002:a05:600c:8b16:b0:46e:4004:a296 with SMTP id
 5b1f17b1804b1-46fa9a965a9mr201295755e9.9.1760549145332; 
 Wed, 15 Oct 2025 10:25:45 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb484c71csm318860555e9.8.2025.10.15.10.25.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 10:25:44 -0700 (PDT)
Message-ID: <f83dcc75-64d9-4c23-97e1-2766c3d96512@linaro.org>
Date: Wed, 15 Oct 2025 19:25:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] target/openrisc: Replace MO_TE -> MO_BE
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>
References: <20251010070702.51484-1-philmd@linaro.org>
 <20251010070702.51484-12-philmd@linaro.org>
 <41bd1de3-77cf-4d3e-aa16-0c93a52b805a@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <41bd1de3-77cf-4d3e-aa16-0c93a52b805a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 10/10/25 21:00, Richard Henderson wrote:
> On 10/10/25 00:06, Philippe Mathieu-Daudé wrote:
>> We only build the OpenRISC targets using big endianness order:
>>
>>    $ git grep TARGET_BIG_ENDIAN configs/targets/or1k-*
>>    configs/targets/or1k-linux-user.mak:2:TARGET_BIG_ENDIAN=y
>>    configs/targets/or1k-softmmu.mak:2:TARGET_BIG_ENDIAN=y
>>
>> Therefore the MO_TE definition always expands to MO_BE. Use the
>> latter to simplify.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/openrisc/translate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
>> index 6879a0cff80..a626ffaf25b 100644
>> --- a/target/openrisc/translate.c
>> +++ b/target/openrisc/translate.c
>> @@ -61,7 +61,7 @@ typedef struct DisasContext {
>>   static inline MemOp mo_endian(DisasContext *dc)
>>   {
>> -    return MO_TE;
>> +    return MO_BE;
>>   }
>>   static inline bool is_user(DisasContext *dc)
> 
> Add the same sort of 'little-endian enabled by SR[LEE]' comment that you 
> did for RISC-V.

I squashed:

     /* The SR_LEE bit sets the (little) endianness, but we don't 
implement it. */

> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!

