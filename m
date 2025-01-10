Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF9BE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 15:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWGWq-0003Bv-12; Fri, 10 Jan 2025 10:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tWGWo-00039w-2Z
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:02:26 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tWGWm-0002Jl-8i
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:02:25 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2163b0c09afso38078815ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 07:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736521342; x=1737126142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ek+uyOLF1atCbWyakug3u6hJF1xPQjfK4a2Lzu5BY9w=;
 b=d933aFZASkmeA7jntgiWaH4P2AYi9k0ZMjOUdwjf5ExbGGmvp8xWD4LGiP4tf+IzBj
 Yj5bAW/bhB7mBNRSJJ4AFBaH1g1fRJ4GOFl5AOZ4AkPcVf5bTNh3DPWPV9ah/Z1BjoPj
 5eXh4/Af6liWEAO6HG6K/g7IECI6MN78tszS2lzJ4vwo7zpggijv68B3aVI4Ia53hGbg
 tY6SwApMZ9WgJWpjdUa81XfD64WEUwa5Ld2Le/A7cndAFufUMM2lebkInbxHQsDjWxCQ
 NBTEvJbKrhrZtC/ld+Y+ZL0V5yExDTujaAA5fYcwIhQ36weD6mK1KE0lHg+CF++K89F1
 HY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736521342; x=1737126142;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ek+uyOLF1atCbWyakug3u6hJF1xPQjfK4a2Lzu5BY9w=;
 b=oq80KJwpyfMz5+a03877B4mVeZaAA6lPfOTB4sT4LR4DjgKkuhSrrUi+VvG4SC0Aaj
 yni8Idpe2NDqIprp6Pn4Lxj1a7lxiAWGT9WhS4Mmy2KX1ieXmmjzftWcPgmUq5IpRPLA
 d7Yk7TyDAZytkPe+JRpCq2Ugyg9ILF8OY/hHHKqn66RxZBxDF8ukvVN9GluJxAjQk1Ck
 ycDEQHuZjiwhHfwYAjgmAOdMnGdIxNvfF3YaRVaJwnOQNyY6o8RyfWW1L/e4rO+mM13x
 TO8xmDHZvWVyox01BRGe9AkDcdEdf1x43OJuuPl+YawaGNgKSU72tuIecn9rfDlGSGrg
 ykIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd3tAKtsWFo1WRR0NyqRtKZ7/5vIpfmY1C7HU7CKNiIyh8PjO+C+rd4ARJi0PGr73xGB4QTKnLWfRR@nongnu.org
X-Gm-Message-State: AOJu0YwaNyLhyiPAvN8d6DQZLDPRhHx2EF6KoSo/BxaDRk3HUM3Ypedy
 Zd4dc2iXsHqAfgBoprPSnkkK7Kd+PrYhCCDPfyqDg9MKohOLLtYZHbhvNCwS9M0=
X-Gm-Gg: ASbGncueIDMIbvThGEcd2IyAvje8EFhkJne7c552eKE33GO5fwsoUY8u54+JSMhxMl4
 y9VqrJdWgwdb/BD8dWFcpKeUemfNX0zG4vk9P+yV19PrCcgRr0/66smQ28ocjK3MIjEoWqwP4MW
 YzwEl1MhU+6r8UNnzBmvEEzvGniHKbkYmcmt6d/EVq/5dZ8mpIpNZstY7mY4nLZxPmkWgfDRKB4
 6suHIfAtpCHKgPKg8h05WruuEn6lOWbCSncS9WeuzwhYdyV+CXRQfBB1E6ZFBIULzKqmMWRFdPh
 5DWu14+kqDQ9X9ifHyLtjxqDKJMxdlw=
X-Google-Smtp-Source: AGHT+IE4xFqR2xiM1NOCK2c/F3PxVT/xQqH2U8wWJ0viU09D/2yvQN0DMwdOwIRT7lG6fkcd5u/anw==
X-Received: by 2002:a05:6a00:3019:b0:725:f376:f4f4 with SMTP id
 d2e1a72fcca58-72d21f477f0mr16400730b3a.13.1736521342320; 
 Fri, 10 Jan 2025 07:02:22 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d4056a34esm1647210b3a.49.2025.01.10.07.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 07:02:21 -0800 (PST)
Message-ID: <d16368ac-79da-4ec7-a412-92c17d67d9a9@linaro.org>
Date: Fri, 10 Jan 2025 07:02:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/22] accel/tcg: also suppress asynchronous IRQs for
 cpu_io_recompile
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Julian Ganz <neither@nut.email>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
 <20250109170619.2271193-23-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250109170619.2271193-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 1/9/25 09:06, Alex Bennée wrote:
> While it would be technically correct to allow an IRQ to happen (as
> the offending instruction never really completed) it messes up
> instrumentation. We already take care to only use memory
> instrumentation on the block, we should also suppress IRQs.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Julian Ganz <neither@nut.email>
> ---
>   accel/tcg/translate-all.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 453eb20ec9..d56ca13cdd 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -633,9 +633,10 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
>        * Exit the loop and potentially generate a new TB executing the
>        * just the I/O insns. We also limit instrumentation to memory
>        * operations only (which execute after completion) so we don't
> -     * double instrument the instruction.
> +     * double instrument the instruction. Also don't let an IRQ sneak
> +     * in before we execute it.
>        */
> -    cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | n;
> +    cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | CF_NOIRQ | n;
>   
>       if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
>           vaddr pc = cpu->cc->get_pc(cpu);


