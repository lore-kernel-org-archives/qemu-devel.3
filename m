Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317BCC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 14:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRGn-00006K-Fz; Thu, 16 Jan 2025 09:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYRGl-00006A-3Z
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:54:51 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYRGi-0007FR-W8
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:54:50 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21bc1512a63so20184875ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 06:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737039286; x=1737644086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PcKpFyHrFqx++Jmi8B0jpQqij7G8nJ21wizbPNXsTMw=;
 b=JdQvDFOgdzdxL6q3CF/C7NF9m914CLWllrk/mQ3YkCY20YqmTQxM3T5Mu5msPGE8Yu
 FaL2mR9xv5To+tSsso9oB3C674AWcjHuSCUVQLNGdZ0E9geKA0ER8WGglT2Cy85/fdvA
 PVF4m4VO6xyUM4aI93+DKmsGia+Ko/FOWbeLO4eqY/ZWZY4NxkzRSVXG014UQE0bqOgU
 MMxX1UUiRMq4+llZDQ2D1G7ZDt5YdRKqZNidzz44yfnq0XfS0ZgTGjftdNIPlZE1Lszm
 B52V3XxhRunRzmjddaYeEN0CEdhPv07/zyF0p+leRVnTjlqyp07OQEeTCJZFVo690gGk
 j9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737039286; x=1737644086;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PcKpFyHrFqx++Jmi8B0jpQqij7G8nJ21wizbPNXsTMw=;
 b=vkeOsYxXI0OJBFzKFVJrtlaYnt/FnwcxqBp887PGZ3FWlBSGxz9ukacVUy3jkWQMUt
 bDU338CbLLqzbHUFrlQ2U9v5L7TYB7BDW114DR5BttDYCjabLQuRnMUnrgZgHUNw4msg
 m6Zeipv8+D8aQjBd7JA1cq8UUIavNRpOk47I45QTurnpB7+s8xNUOWr9o8a7WQDQK8Kg
 zj4CZT9ainmyHJ6BUXl7BFBUH4pUojcTEhN6qSrF2h3q+vF7hYv8Z4EpigaU50KmWYci
 Sul8rREf8HAoEJ5Iypg+2ZTwpd+odhSrpSKxRzziLjA7d5aYnmX3zqd3+78p9U1gtB9W
 LmrQ==
X-Gm-Message-State: AOJu0Ywg2BJbBkLQ0PCFy2wD6biEneL/Nf40BYn0yf7fHAcOqnbBZQHc
 ScQWw4HOF3/Vpri/7I4D+Xxaz2PemPjkcDo4bvJ/Ae7JRZZq+nIxzs6EDhaP1bU=
X-Gm-Gg: ASbGncvUZMhiBJmVRkeXfrgLiqGWOPs+LG+I/Aj3Lr33H8jY4z/aA5fmonN50NGn0VU
 icLyuN9YiAEOJBfwhl/6UTJaDmd85QpjwJxI7PaWXShEPITShdktQcjECxpIWWlv6XEcspWrk68
 lJbuo4rm+G996fXvAtbFhxRdmRxklBLnv/Mjw4oB0ox4VNxsx9Mdgmgj/vws1skJRmt7PlNKsAU
 Mw+G91wRixOYkCZi0qwHPdv0ruNAxyq3j6q9Uh/IEWZXR/o5FmkPadzMOF/Jfpg8g+sp9D8aLAG
 AgoPj1G6mKjPti0ZZ8J1aC0=
X-Google-Smtp-Source: AGHT+IETDXjQgrRSCg9KKk6FZgN0klR0WwnIhqLwASfx4LgE3uLfBBijPMBW9In8E2hseuwmFp5kOg==
X-Received: by 2002:a17:902:e5d2:b0:216:591a:8544 with SMTP id
 d9443c01a7336-21a83f672f6mr530344645ad.34.1737039286181; 
 Thu, 16 Jan 2025 06:54:46 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2ceb9aeasm1465815ad.90.2025.01.16.06.54.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 06:54:45 -0800 (PST)
Message-ID: <e74110e7-2dc4-4626-b64d-f42e3ffe7413@linaro.org>
Date: Thu, 16 Jan 2025 06:54:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Call tcg_tb_insert() for one-insn TBs
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
References: <20250115232022.27332-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250115232022.27332-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 1/15/25 15:20, Ilya Leoshkevich wrote:
> Currently single-insn TBs created from I/O memory are not added to
> region_trees. Therefore, when they generate exceptions, they are not
> handled by cpu_restore_state_from_tb(). For x86 this is not a problem,
> because x86_restore_state_to_opc() only restores pc and cc, which are
> already correct. However, on several other architectures,
> restore_state_to_opc() restores more registers, and guests can notice
> incorrect values.
> 
> Fix by always calling tcg_tb_insert(). This may increase the size of
> region_trees, but tcg_region_reset_all() clears it once code_gen_buffer
> fills up, so it will not grow uncontrollably.
> 
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   accel/tcg/translate-all.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 453eb20ec95..6333302813e 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -531,23 +531,23 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>           tb_reset_jump(tb, 1);
>       }
>   
> +    /*
> +     * Insert TB into the corresponding region tree before publishing it
> +     * through QHT. Otherwise rewinding happened in the TB might fail to
> +     * lookup itself using host PC.
> +     */
> +    tcg_tb_insert(tb);

I think what we need is to mark the tb CF_INVALID before inserting it. That way we'll 
never match in tb_lookup (comparing guest state, including cflags), but *will* find it in 
tcg_tb_lookup (comparing host_pc).


r~

