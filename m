Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF0AE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 03:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPvy1-0003Tl-GK; Mon, 23 Dec 2024 22:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPvy0-0003TV-4m
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 22:52:20 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPvxy-0000Q7-OD
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 22:52:19 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so3719686a91.0
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 19:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735012337; x=1735617137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TAHU/QMEcO/VfUhIWi+iOp0m3EejvqFC1GmT6ypF4N8=;
 b=ikS75xlxEE1mO24FZuOOgc+xbZmL03lShulFx+UBBLLQjntLNYnRDDUFdPnzDlqw2b
 ai1S5R8Zw5NfPWWc75SjQcIXCxVcdgMQHTFl0fMVXPbYeYTA7HI3E4OnUqnG4RC1n1wa
 SOUCE0mUHLSod9VksY1R2coFyf/d/Du5dapFEXxAH5TGH03Jx49QaHWj5Yi2Xi4/mj4H
 /WdTPiCH2cBXj1Go9fzX5cF80nIK3sl3k6rR3MC6rdHwyt+OFmTpFH/KBATtyy5vmiBk
 7/2uVevX7A3W760Ri2tUki9BR0tKd5UtjrFZbt9f1l45q+hdUgvdmAnBTk52Wz3ur9UF
 wxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735012337; x=1735617137;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TAHU/QMEcO/VfUhIWi+iOp0m3EejvqFC1GmT6ypF4N8=;
 b=XGrPOIO/oIgVrDV1VQNGHG1lQk7wV8WCYkNdCJzstMnriGPmrW5VF+dwMWIoqqLZv+
 W5+iM8cxiMkKMHKr2mAzjJF+KMuW79CNLTEG9u8rn/8ulrcSfZQzx76FdWKroi37X8ck
 eM+mtKfa3OGiXcTHDEUHY9YSOaC1qujZew6pMWIy73bJaVVh/Cc7nrO4E0fBGMKeLyT5
 p2lI9ZRhJ6gpvXtv65use0DlLDOPSEmsbU9LxtvL73RuHp4lIV03RbuEdxpY6SdkXFcf
 ZYj8rMZTvlCevHiE/K8STaPw5gieDf6NtLFn7qSdwaYB7Yt1hbGoD3qB+PlL7Xl8L54g
 514A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVEewhwH2XAa+1mua17lqbZLeDpp0j2S07iA1nDzNxflDXuY60ny6uculAX84TmGkOldP5BOkQFj9z@nongnu.org
X-Gm-Message-State: AOJu0YxeE4O31MKegvW4K22Pd7liZK1RpjK9clBWtn05GgavzWl4UQP0
 pz8lR7XWCVBtRM3pHIPhJDE32L58/FhW4ig/sSzHDMhapeBgG2KABKjqyCzaex0=
X-Gm-Gg: ASbGnctvMoOBPmmfAyuCDCpntysa9/0CGsOBuO7Gbg8e+9RSnA+/HzGiPrhf41Vglgv
 A9frDS1sWThWq7ZwlMbhdXN9Ers7IwFE2toyJ9ErG+ub4qdK05HO1JUS5pKgNEfpIt04+TzxMlA
 hGdAfSg0aeeUMvocCx3rWSzkxcCL70tFjHoWngMqtShD4ypJL+Spi8qwQf9sPK5nYnCzSNMmGAD
 yM8Hb8b/flLuqxQTMII05GxSbsFxWTtfHhngoOyI3/m8AfqkXxRQPy3v40TX1TtdIhnuvTFZT/z
 gkOBN65HYwaZyqk76hHw4CxSi+VTdlTc4gcv85c=
X-Google-Smtp-Source: AGHT+IFX1+RLyDZtZjpNrNLNMuQDqUf9Yt/vSvpt7qgLQMAsW4dywpgaCV1GTXceWLYrUy+zEcRd6Q==
X-Received: by 2002:a17:90b:534e:b0:2ee:7a4f:9265 with SMTP id
 98e67ed59e1d1-2f452e22c53mr24917448a91.15.1735012337033; 
 Mon, 23 Dec 2024 19:52:17 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dca02e49sm80834105ad.278.2024.12.23.19.52.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2024 19:52:16 -0800 (PST)
Message-ID: <d20656dd-922d-416d-a2fa-9b9e33060868@linaro.org>
Date: Mon, 23 Dec 2024 19:52:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/loongarch: Fix LLSC for LoongArch32
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU devel <qemu-devel@nongnu.org>
References: <20241222-la32-fixes1-v1-0-8c62b7e594db@flygoat.com>
 <20241222-la32-fixes1-v1-2-8c62b7e594db@flygoat.com>
 <a86f364c-58ee-4e73-8c0a-110fefc1f985@linaro.org>
 <6564d4a5-9299-4de3-99ca-ec4094b9e642@app.fastmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6564d4a5-9299-4de3-99ca-ec4094b9e642@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 12/23/24 13:01, Jiaxun Yang wrote:
> 
> 
> 在2024年12月23日十二月 下午3:15，Richard Henderson写道：
>> On 12/22/24 15:40, Jiaxun Yang wrote:
>>> @@ -9,7 +9,7 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
>>>        TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
>>>        TCGv t0 = make_address_i(ctx, src1, a->imm);
>> ...
>>> @@ -28,7 +28,8 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop)
>>>        TCGLabel *l1 = gen_new_label();
>>>        TCGLabel *done = gen_new_label();
>>>    
>>> -    tcg_gen_addi_tl(t0, src1, a->imm);
>>> +    tcg_gen_mov_tl(t0, src1);
>>> +    t0 = make_address_i(ctx, t0, a->imm);
>>
>> The move before make_address_i is not required.
>> See the similar code just above in gen_ll.
> 
> I think it’s necessary, I thought the same and end up spending hours to track down the problem.
> 
> make_address_i won’t make a new temp_reg if imm is zero.

Correct.

> So when imm is 0 src1 and src2 is the same tcg reg the value will be clobbered by cmpxchg,
> causing a couple of tcg tests to fail.
> 
> I think only way to ensure t0 is a new temp reg is to perform a move here.

The correct thing to do is not to re-use the same temporary for both uses.

-    TCGv t0 = tcg_temp_new();
-    tcg_gen_addi_tl(t0, src1, a->imm);
+    TCGv t0 = make_address_i(ctx, src1, a->imm);
      tcg_gen_brcond_tl(TCG_COND_EQ, t0, cpu_lladdr, l1);
      tcg_gen_movi_tl(dest, 0);
      tcg_gen_br(done);

      gen_set_label(l1);
      tcg_gen_mov_tl(val, src2);
      /* generate cmpxchg */
+    t0 = tcg_temp_new();
      tcg_gen_atomic_cmpxchg_tl(t0, cpu_lladdr, cpu_llval,
                                val, ctx->mem_idx, mop);


r~

