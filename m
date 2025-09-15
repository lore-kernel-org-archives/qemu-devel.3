Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C536BCAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 13:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy9ef-0002Kg-Tj; Mon, 15 Sep 2025 09:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uy9ea-0002G6-99
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 09:54:01 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uy9eV-0003NN-7S
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 09:54:00 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-24456ce0b96so48211915ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757944425; x=1758549225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pP0z3glL9FmWp+3YDaQUiTlaOF5jQcV65GjHjl0DQSo=;
 b=K2zH0TtiKCQG0JcdW0XUdgwZn3z2pxMG39FpKF5pUSaNqbLIXvfTb7KUAKbeSga+16
 cmjcQ67CbEOHtf6bLyc9B23malGEwAP0obA0D1YUytFF1ecRMEA6BPI39EFBLKSD9lVg
 59dOme6GGDDnVOrJzeeJ+a85SFaBZBgW5y/DvXiIABmCs3MpIeGKwsO2SLprT3k/Qwgi
 vr1uaAf0DAa+0NNJ2Z23cLsQm6OY4zWvE9WNIRwS7BcVgJzjcGdPmpvXvKCYObbNhI7I
 AP8leP5R5B9BmDYxHyMrMASq6niipAKaKMtI8RoFxQ61mAIPsvhshbN5/ETab/7LvMOn
 Nu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757944425; x=1758549225;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pP0z3glL9FmWp+3YDaQUiTlaOF5jQcV65GjHjl0DQSo=;
 b=mpRspbiI+r5MfFcG85gmOrHeTL972t9h1Q5uNZ7OI8/ah9SRAx1D35pN+RryVxRy+M
 TqGIMmMaVejBZTcKDcN4H3L7PFAf0XJtX1FOPioJ+nakYCqVzHA24eVi6NRw40wSdh1s
 Tw63RBypsLGffSTPJKC4H2CVBRwJeYl11Qe8/obE6Y++wKrodAH2n7MBEccpRNzp1lVo
 cxNdASt9/nh7KHyCszqlUpPf+xCVZlyRZ3SPr5SaYW/M8pmTPZ7jutr4J2mZuukJHAq/
 2HH9XSFuK4JSjM2cPxlmHZ96qt8Qxwwx5amvY9m8EZJiHBXUEqsAZY+k8yuLrFAWDjSv
 tkTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo/1FnNozwFNUvO9D7zscy3oK4mBcTpVw6MmZAu+ntRHVxk488LueNG2qesn/PrAjfd8fK1UZmvM6q@nongnu.org
X-Gm-Message-State: AOJu0YxU1xylWGARbJPmE1ZHcO5Wqsytxwd8t4GtxsZwITrB3c4Q4yS3
 o/H6MZZJHbTTk/8WPwBS10k0hwqhRu52k4EAgKELx9DOu+OkUUrpJlXHeOh1S+XAKyI=
X-Gm-Gg: ASbGncuJ+NLICfiBiYtrEmzuMDSu/cqUiyPBOzS5+S1p0nWYXmN2J1/YlaZEAuEmfrU
 Qt3w9gs2fkF0aP7Q2fh0jpc2zAvvHXsW9uWs2pf7NK8BUyZBLdvh+o9kyEqtQI9LTG4q8xsijne
 ReI3uJFn3soejIm1AghY8PEJ4YRaaSMA7OuhQNn5pLvQEhdCw3bBbhGlf3Vqg5Xt7qvYXQIyEob
 hgIS11flXNcbAMaud9c0a3eS390UTiHrOE8s+a0+InLPa7aO/pyQlmYsOuh+wN5dWNKJuRhp+iC
 tsIZdLJR3OpfGE9UkQ7dZGviIgM2OVuEII+sN8953IesiDT/eDF4lLc3MejmynJFF50b+LNMqmy
 m1iZXv7mFwPBYyNhr3ZFgOo4U8BFT780axS25lGsNwrRglB4ydvnBvpeE5w==
X-Google-Smtp-Source: AGHT+IHACe5KuVxIMppKyLnKHVwJUZ8hrb1Z8DYNSPw5EEYnlTbWDn/da5/hxZmMk13kdw1xqYIttQ==
X-Received: by 2002:a17:902:b216:b0:24e:b713:adac with SMTP id
 d9443c01a7336-25bae8dcb48mr145429755ad.28.1757944423768; 
 Mon, 15 Sep 2025 06:53:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25c3b0219f9sm130533695ad.123.2025.09.15.06.53.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 06:53:43 -0700 (PDT)
Message-ID: <8e43c44f-609c-4a30-8559-a5dcb567b950@linaro.org>
Date: Mon, 15 Sep 2025 06:53:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] target/riscv: Use tcg nodes for strided vector
 ld/st generation
To: Chao Liu <chao.liu@zevorn.cn>, paolo.savini@embecosm.com,
 npiggin@gmail.com, ebiggers@kernel.org, dbarboza@ventanamicro.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <cover.1757690407.git.chao.liu@zevorn.cn>
 <1f22506f44570abf3bb17bf144d398807be0ab40.1757690407.git.chao.liu@zevorn.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <1f22506f44570abf3bb17bf144d398807be0ab40.1757690407.git.chao.liu@zevorn.cn>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/13/25 02:17, Chao Liu wrote:
> +static void gen_check_vext_elem_mask(TCGLabel *label, TCGv_i64 mask, TCGv_i64 mask_offs)
> +{
> +    TCGv_i64 mask_offs_i64 = tcg_temp_new_i64();
> +    TCGv_ptr mask_offs_ptr = tcg_temp_new_ptr();
> +    TCGv_i64 mask_offs_rem = tcg_temp_new_i64();
> +    TCGv_i64 mask_elem = tcg_temp_new_i64();
> +
> +    tcg_gen_shri_tl(mask_offs_i64, mask_offs, 3);
> +    tcg_gen_add_tl(mask_offs_i64, mask_offs_i64, mask);
> +    tcg_gen_trunc_i64_ptr(mask_offs_ptr, mask_offs_i64);
> +    tcg_gen_ld_i64(mask_elem, mask_offs_ptr, 0);

You can remove the "mask" argument, simplifying the code here.

	tcg_gen_trunc_i64_ptr(ptr, mask_offs_i64);
	tcg_gen_add_ptr(ptr, ptr, tcg_env);
	tcg_gen_ld_i64(mask_elem, ptr, vreg_ofs(s, 0))

You can also change mask_offs to TCGv_i32, which replaces

	tcg_gen_extu_i32_ptr(pr, mask_offs_i32);

which more obviously does not discard data from mask_offs.


> +    tcg_gen_andi_tl(mask_offs_rem, mask_offs, 7);
> +    tcg_gen_shr_tl(mask_elem, mask_elem, mask_offs_rem);

The mask of 7 suggests you're only interested in the low 8 bits.  Which means either the 
load is wrong (we don't need to be loading 64 bits), or the mask and shift are wrong.


> +    tcg_gen_andi_tl(mask_elem, mask_elem, 1);
> +    tcg_gen_brcond_i64(TCG_COND_TSTNE, mask_elem, tcg_constant_i64(1), label);

The andi before the brcond is redundant with the TSTNE.


r~

