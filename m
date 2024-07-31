Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747C0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 22:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZI2O-0000vM-HF; Wed, 31 Jul 2024 18:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZI2M-0000tT-5I
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 18:43:14 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZI2K-0001se-HK
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 18:43:13 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7a92098ec97so4259859a12.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 15:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722465791; x=1723070591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8D6L6mlJmw04kaqjni1MaM8sLHZt7aAWE1fCvEn+rN8=;
 b=Eec9nrvp+utPen/ZMeH+7DzwLyk70ByZE69yaUqB8MNq/72gTsw4tC22iaSWIpM/79
 2QoWdpWT/4WdWtyWh/RTgDTLpACtfzp4SFqJ7dbqIr+W5EffeIHnIz6gcL0N9KeYYxag
 mJNO8pUFIvn50+76yUsAI9pt2oJye4RpqW1XyUBO4dQnvbF374WQkZYaOOOjMJNH5mys
 O+sc0RY2o98MC5BsHzkaqF686AFh5OASYG//AHAvaIzXZouUykf/K6ZrQY/37qOv2N/V
 lrykZ1iNflliMJZRAkkpK3Yq/OY/JSII7vvbEGU9780eU1qSo9IboF7+o2w5302w2d6q
 BwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722465791; x=1723070591;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8D6L6mlJmw04kaqjni1MaM8sLHZt7aAWE1fCvEn+rN8=;
 b=eKza0mL1lNffFPXOAfisA2XN89HxvC8hawyDfgn1MsfLedwMrzrO5WhOqKxRQDgk4+
 pdnEoPxcAYlFgu6nupyvJJTp1m8JJxuUNmWrTv92NHU2Uzu6PTcyezV/AaHaZFCMrgUh
 pdrsnqbvJTBAY6OGjXlTzrm490Qcb/ndLQYtcTlyJGtM46SE5OCHnskPdO3tz/SPMkMK
 /KNrk5A+GkkiSbMWfpCPg+79TC089Z/te6Gt/oA3IH7uv7oU/376vEwe0qNh2+VQQQ/P
 SrtvO04j1afA7AJzm3VU1eNX8H5TNiJs1Vh5oCBzKlPePYnHVzdOcnRrFFwUSWlYz/jj
 Vo8g==
X-Gm-Message-State: AOJu0YwqW1EbLNLtqdW8WzVXYGsLH4ZP8QWXUdcmr569eJVG2Uy2H5z5
 a4QulU5SU5Sv7YB0UVu7nmXn9k44lSToQC8L0UBj5Yb5T0nIXpCA+76bfFpzDc4=
X-Google-Smtp-Source: AGHT+IFsFCc3Tawaz8KPT6OOy87cnZDT8hUe96ps0A5t2M466lJE+2H7t546F0h/+DNslq+ZaKfp7A==
X-Received: by 2002:a05:6a20:1582:b0:1c0:ef1c:b80 with SMTP id
 adf61e73a8af0-1c68d15ba68mr1057345637.52.1722465790543; 
 Wed, 31 Jul 2024 15:43:10 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead6e18a4sm10460802b3a.9.2024.07.31.15.43.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 15:43:09 -0700 (PDT)
Message-ID: <7c0af87c-466b-4dba-a132-b14c8d262fd4@linaro.org>
Date: Thu, 1 Aug 2024 08:43:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bsd-user/x86_64/target_arch_thread.h: Align stack
To: Ilya Leoshkevich <iii@linux.ibm.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>
Cc: qemu-devel@nongnu.org
References: <20240731144428.5882-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240731144428.5882-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 8/1/24 00:44, Ilya Leoshkevich wrote:
> bsd-user qemu-x86_64 almost immediately dies with:
> 
>      qemu: 0x4002201a68: unhandled CPU exception 0xd - aborting
> 
> on FreeBSD 14.1-RELEASE. This is an instruction that requires
> alignment:
> 
>      (gdb) x/i 0x4002201a68
>         0x4002201a68:        movaps %xmm0,-0x40(%rbp)
> 
> and the argument is not aligned:
> 
>      (gdb) p/x env->regs[5]
>      $1 = 0x822443b58
> 
> A quick experiment shows that the userspace entry point expects
> misaligned rsp:
> 
>      (gdb) starti
>      (gdb) p/x $rsp
>      $1 = 0x7fffffffeaa8
> 
> Emulate this behavior in bsd-user.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   bsd-user/x86_64/target_arch_thread.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bsd-user/x86_64/target_arch_thread.h b/bsd-user/x86_64/target_arch_thread.h
> index 52c28906d6d..25233443c14 100644
> --- a/bsd-user/x86_64/target_arch_thread.h
> +++ b/bsd-user/x86_64/target_arch_thread.h
> @@ -31,7 +31,7 @@ static inline void target_thread_init(struct target_pt_regs *regs,
>       struct image_info *infop)
>   {
>       regs->rax = 0;
> -    regs->rsp = infop->start_stack;
> +    regs->rsp = (infop->start_stack & ~0xfUL) - 8;

The formula in sys/amd64/amd64/exec_machdep.c, exec_setregs is

   ((stack - 8) & ~0xful) + 8

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

