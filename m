Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D82D743D0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 20:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDqtb-0006v3-9m; Wed, 20 Nov 2024 15:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tDqtZ-0006uY-OW
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 15:01:49 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tDqtY-0003ec-CD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 15:01:49 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7181a8af549so39522a34.2
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 12:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732132906; x=1732737706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=78eMfQrgZS2q8peDqLsp12hwJsSrdJAfcYjS0wbbuU4=;
 b=zsINx+2xTIy6Kqk5TCixZ8swjQm6AGpXhkyJNVnel+YL/ZHUpyPZsZdqWycfcGE+c9
 V7xVTyZX7TgvaTfk2blytOt9CirNwcR6ykAHy9dIywh7p9/A4P9bnuv1dTCBFi1IxDSA
 tO/TqL5MYQJ1meH/05+JZvkdvZCsFgUzoM9hhDXjqat6OGfySAaf5vyrWDj1X+X5qsVt
 +EK/RZRWOVQXRhKB3+dbsz6RrfR7W+IeA7yxrbLrfVCsU341hR+FDtmCkHk+LeLwblxc
 Lqb3nGnu4KxPirdMKn8HKq8/Y3mvBoQJib6HXjEagKhFq6jK/aA1lx/WGAFtPPUEuP4d
 euEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732132906; x=1732737706;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=78eMfQrgZS2q8peDqLsp12hwJsSrdJAfcYjS0wbbuU4=;
 b=kVcn/1J4iR6OGLtR/yWL8W5eLu+onu15wGjQlTeto/+0L1is1MmJ3RhQ4xMOp1eTkv
 +CfFuuWV/pSz/Wi28klIr7hassWr3o1i9F4Q6IrqQW+AHKU9PENGTzvGYzESCfC58gLd
 VsSbcnzLuduc8HQ2S/0WGLrQjh7K6XOJpf2V0zfLUlWG+d1nDpzGMnItrl5clyECH5d+
 5Yy0yue70giDoZbfaDbV+jtmDF1tbCqsvo4eae0FPSj8jwtxi0FtRjickloVwhHyPuoE
 HUJv3Tqd29s0+fANo/WJTyotnncG+r/py3Zz6V/hu83rx9wr7DNqBjywWotDlFRD9JZ/
 yxUQ==
X-Gm-Message-State: AOJu0YzxOFtJ/x9ABbiM115kv85Vf0YFkN+/3l8eFwdg3sIi2liiYLwO
 BSWsZV4V0YlsicqgG1j9iQcYIEGlMnWK1sWAsYWvcQFnZUak3vkyybayb8Z4osE=
X-Gm-Gg: ASbGncvsVZfbrpF3NI5B0YzX+VmJGxecuOWZo5We7Dn8qfkk9tst2D9DeBJX0nMoPHU
 HLDPGwdsd12P8r8Nxkbya8gX8VXj1if4cvlaTSnSTf1LxLZfv/hUd7Mj+Kr7qXZMVVO42SPcV2D
 9OBHwB4fb1Pxkc2EjH7K2XTu3LeYrhJZwztx/QBeNJGwKclERGvyn9xhehc1BfCeTXntgafgqpj
 gJvocHD3aJHtPJZobAQVISC3BK0WcBI6itD+WMfFvhnKylUvIejd0qVOIwEJhfM/A==
X-Google-Smtp-Source: AGHT+IHMddxtcflxB34OMWKgoABeVcB7KGEf/XMKuu04pSjQW2pn3PBXiKKG7o005g26tT0kk63/ig==
X-Received: by 2002:a9d:7d86:0:b0:710:dab2:684 with SMTP id
 46e09a7af769-71ab31c4202mr3933346a34.25.1732132905791; 
 Wed, 20 Nov 2024 12:01:45 -0800 (PST)
Received: from [10.25.2.133] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71a780ea639sm4144887a34.6.2024.11.20.12.01.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 12:01:45 -0800 (PST)
Message-ID: <aa021534-5998-414a-a0b5-12239a310634@linaro.org>
Date: Wed, 20 Nov 2024 14:01:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix strace output for s390x mmap()
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-stable@nongnu.org
References: <20241119211138.148806-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241119211138.148806-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

On 11/19/24 15:11, Ilya Leoshkevich wrote:
> print_mmap() assumes that mmap() receives arguments via memory if
> mmap2() is present. s390x (as opposed to s390) does not fit this
> pattern: it does not have mmap2(), but mmap() still receives arguments
> via memory.
> 
> Fix by special-casing s390x.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d971040c2d16 ("linux-user: Fix strace output for old_mmap")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   linux-user/strace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index b70eadc19ef..50f41e746ec 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -3971,7 +3971,7 @@ print_mmap(CPUArchState *cpu_env, const struct syscallname *name,
>   {
>       return print_mmap_both(cpu_env, name, arg0, arg1, arg2, arg3,
>                              arg4, arg5,
> -#if defined(TARGET_NR_mmap2)
> +#if defined(TARGET_NR_mmap2) || defined(TARGET_S390X)

I think we should explicitly match syscalls.c:

#if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
     (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
     defined(TARGET_M68K) || defined(TARGET_MICROBLAZE) \
     || defined(TARGET_S390X)


r~

