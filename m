Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D3CCFB420
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 18:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx9ZV-0000TQ-Ap; Sat, 05 Oct 2024 14:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx9ZT-0000TC-NR
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 14:32:03 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx9ZS-0005EN-3y
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 14:32:03 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7e6d04f74faso2659179a12.1
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 11:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728153120; x=1728757920; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Td+DcAbjfAnRecAhb2+4VhWEybU7/2uuImCxzLl8qKQ=;
 b=ll5WpH1fWG9i3iwPyTxc//Nrwb+xmleNhv6GJFYlSjdmMiHzVULKcJ2NDfEFblNZS0
 V1IFp/TKjjWRNIS4s+mQsQoufjLVy9H2gNPW3nyuY9cj9eKOVXUouF9StvtZFQLVXE2d
 7HGOUC7Yo00GoiKOD0esGta8N+Z4YZqnURYhFxfvTpSRe4xuHJoDPfolUMMBZFRI3xQ3
 M+u2hUrUkUbisXgxxujwAaIlUd3W6evu5O/Iu65/BTlfIihRbGRWKUfNtC3xIE3EUJVZ
 QGaw/1fos5hfWPNsF0zNsFww0zxu70pioZNFc+6nN3OoIufB+N+/MZ/UrhFdTAUMQz/3
 qY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728153120; x=1728757920;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Td+DcAbjfAnRecAhb2+4VhWEybU7/2uuImCxzLl8qKQ=;
 b=WESF+P6gbMyGyLO6UXT3mx1GSrxQACbGmI66i/dqIiCJRlUXpKY2hcnJV93wBieuM1
 okJ4bj3LNPOZhqJgsFaKa6gf2/3wumx7Zs9Ng7SdauqF1W/Y2W20KGpjNPz0u63bMOSV
 Kn8W4F7SkmRZP7R0zK9LE+LiztSasI+rRNnm6f88fhx4JHihmXCcWOb7KINSzUPQ/vF1
 pAscR9e3IN4E8WUWU/X+jUmMtiDmnkaSz6ECQHAfMExZo276Kvn4+WvhnYzyL7ZEt19t
 8k+nGn4/fBkULyjHnp2kdQedhEE3OIbY2eRRckMJBRQlhHNyaNLSUQ5CINPylR1IKzCf
 Imqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVazHlfvr2Bh7z+0Y2/Mm2Hj6e9Ru1cRUbZfhZ/wXTAMuGgyiai7JQArcE8zHpOi8D7wbmHc1o1jH3A@nongnu.org
X-Gm-Message-State: AOJu0YyyYAMHlYmLB7a2lxLDhGqg9o9hPSjBuzAwQxKYaoZYbuRhpGZo
 8rQMUIeJ5E2D3FRhnnd5jcX6iU1wdN37Gg+jCrleFuYgd0am2pe2xsge2wbSB2w=
X-Google-Smtp-Source: AGHT+IHrWUEKtKadMCfw2nGXJFVjA5rex21F9UKpJqg0F7BS/UK8Tns0/2aZxCXTbXq3S9W9V8UTdw==
X-Received: by 2002:a05:6a21:4887:b0:1d4:f661:8937 with SMTP id
 adf61e73a8af0-1d6e8f881e9mr4744766637.4.1728153120461; 
 Sat, 05 Oct 2024 11:32:00 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0cbc47bsm1757735b3a.34.2024.10.05.11.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 11:32:00 -0700 (PDT)
Message-ID: <f222d253-7cd1-40d5-90c4-cff26a36aab2@linaro.org>
Date: Sat, 5 Oct 2024 11:31:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] linux-user: Add strace for recvfrom()
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zach van Rijn <me@zv.io>, Laurent Vivier <laurent@vivier.eu>
References: <20240807124306.52903-1-philmd@linaro.org>
 <20240807124306.52903-6-philmd@linaro.org>
 <d6e29a8aeb083bc937e77233a61f988de6b63eab.camel@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d6e29a8aeb083bc937e77233a61f988de6b63eab.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 10/1/24 23:55, Ilya Leoshkevich wrote:
> On Wed, 2024-08-07 at 14:43 +0200, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   linux-user/strace.c    | 19 +++++++++++++++++++
>>   linux-user/strace.list |  2 +-
>>   2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/linux-user/strace.c b/linux-user/strace.c
>> index 98ef26b917..d76907fdc9 100644
>> --- a/linux-user/strace.c
>> +++ b/linux-user/strace.c
>> @@ -3127,6 +3127,25 @@ print_bind(CPUArchState *cpu_env, const struct
>> syscallname *name,
>>   }
>>   #endif
>>   
>> +#ifdef TARGET_NR_recvfrom
>> +static void
>> +print_recvfrom(CPUArchState *cpu_env, const struct syscallname
>> *name,
>> +               abi_long arg0, abi_long arg1, abi_long arg2,
>> +               abi_long arg3, abi_long arg4, abi_long arg5)
>> +{
>> +    abi_ulong addrlen;
>> +
>> +    get_user_ualx(addrlen, arg5, 0);
>> +
>> +    print_syscall_prologue(name);
>> +    print_sockfd(arg0, 0);
>> +    print_buf_len(arg1, arg2, 0);
>> +    print_flags(msg_flags, arg3, 0);
>> +    print_sockaddr(arg4, addrlen, 1);
>> +    print_syscall_epilogue(name);
>> +}
>> +#endif
>> +
>>   #ifdef TARGET_NR_sendto
>>   static void
>>   print_sendto(CPUArchState *cpu_env, const struct syscallname *name,
>> diff --git a/linux-user/strace.list b/linux-user/strace.list
>> index 5a86419e7d..77ca824f9c 100644
>> --- a/linux-user/strace.list
>> +++ b/linux-user/strace.list
>> @@ -1135,7 +1135,7 @@
>>   { TARGET_NR_recv, "recv" , "%s(%d,%p,%u,%d)", NULL, NULL },
>>   #endif
>>   #ifdef TARGET_NR_recvfrom
>> -{ TARGET_NR_recvfrom, "recvfrom" , NULL, NULL, NULL },
>> +{ TARGET_NR_recvfrom, "recvfrom" , NULL, print_recvfrom, NULL },
>>   #endif
>>   #ifdef TARGET_NR_recvmmsg
>>   { TARGET_NR_recvmmsg, "recvmmsg" , NULL, NULL, NULL },
> 
> I needed to implement read()/write() tracing and stumbled upon this
> series, which overall looks like a good thing to have. I spotted a few
> issues though.
> 
> 
> I get the following build error:
> 
> qemu/linux-user/strace.c:3138:5: error: implicit declaration of
> function ‘get_user_ualx’; did you mean ‘get_user_ual’? [-Wimplicit-
> function-declaration]
>   3138 |     get_user_ualx(addrlen, arg5, 0);
>        |     ^~~~~~~~~~~~~
>        |     get_user_ual
> 
> 
> The following helps:
> 
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -2666,11 +2666,15 @@ static void print_sockfd(abi_long sockfd, int
> last)
>   
>   #endif
>   
> -#if defined(TARGET_NR_socketcall)
> +#if defined(TARGET_NR_socketcall) || defined(TARGET_NR_recvfrom)
>   
>   #define get_user_ualx(x, gaddr, idx) \
>           get_user_ual(x, (gaddr) + (idx) * sizeof(abi_long))
>   
> +#endif
> +
> +#if defined(TARGET_NR_socketcall)

Or just not use get_user_ualx.

> However: aren't we printing the contents of the buffer before the
> syscall returns? Same with sockaddr. This would make the output not
> very useful.

Yes indeed.  Two of the three pointers are output buffers; the last is in/out.


r~

