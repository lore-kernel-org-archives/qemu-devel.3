Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A17CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 09:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6moR-0000tN-UQ; Thu, 09 Oct 2025 05:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6moI-0000oX-F3
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 05:19:42 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6moC-0007fx-00
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 05:19:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e4ad36541so7922425e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 02:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760001567; x=1760606367; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tfz23iC1uiDn8qWaRnTEstu7/K/eo7uOk4dqFFL6EgA=;
 b=n9Xut/7OBfsXn44rJuY1rIiH22zdhaREaY9ajiWHAxe2x288zGHOsVZMqGWTed1UMr
 WxmAyBMFzDjHMql580LrCYmLrlZ8aFEQKELFwAGlWJ+s2yenDSHlPJ3kjhZxbM4Wkylj
 N+/Cb7Bn13OeTqU+7QRCf3y1/P8Ig0V3Hb2qn4/pwsTlMVjzN3Vch/+gkIYYJmF7peNh
 yCwwy8GBEVhnM0G0NsFKPFACK0lWDB4iGLkFfAsABVR8eUtXRZfMSYWQPH6Kakbv2snr
 GP9dKVKKZXJhplu0l2AUy7pSCg1bdHMPRy35N1p4U3b4hqWk3Gj/i7wnFTysTlUKI/Y6
 xbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760001567; x=1760606367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tfz23iC1uiDn8qWaRnTEstu7/K/eo7uOk4dqFFL6EgA=;
 b=ZFCi1KlqDFjx0081P5NhdhrS0RuvHeCrckijOcHr1c999jtTQHXV2KVs0Qk8MLL+d9
 lKTOyAOhdva7JuEVUPT2Ge8xJWfHFL5Na5nnmZz9aOiPZBkU+pTYXPy/wb1FEdhC3aHj
 RqmJSfFJwUE9Nr/JyZsmzBJ7vkXg97acR7FQrGZbbuoin6BpdpvbysLHtiWMzAqoZnUQ
 j8G1Loi+2bV88ysStoi7i99ZueOYECzbanD1Vj5ZLntQHd0WotJ3hQJaqRLapYtoamVe
 NItBegmQ8DuqguxB9zqUd/uDKkhP+yWB9d5Kc69kieUG4H3uYQlIiERo3cbQ0lcuvsTm
 wt+g==
X-Gm-Message-State: AOJu0YxVOHhDT+NzKojL1oRa6gK0RTgPUj8/AoEgbGS71NiliswxXXLW
 V1qcYlQaFZ2ErsJ7i4fn+fbg/T8bm82YPh+FWJjMokmsebEqCepr+MuHhXlPFFGv7Pf147Gidg6
 fgJr1WC2PLw==
X-Gm-Gg: ASbGncsTMhOozTkfkDlaL0bX7NtHQ7rE21m8cpQW4h0gOX6XIGf3rOrjL+7LdQXUghI
 u+SOPA7qV1NH3OM5t9IzvR7MnIgfe6L+Okxp/LvzQDVAH1r9ij3zmrxC+7hStGl0Kjt5Mm81urn
 HxumaYlxRBYoz1OrmIvGNMc4uMJUTiDXe7pB26A1HA6qZg+ygerM4YgAUrZjxHUkzMyRmlF/9eJ
 EKsLf8yPnvgBflSmI4d/YvC3RTrRmkRNQWl/7hC8Cx8Op+WXltfGZzsNix2wq7CnpBnQeYUyMbA
 2wZftS6ZS6xXbf/XTNbOy8gy0b+3OCR8npb956h8S4zJ4jqfpVOoukimYX8iQezlBsCBkj0qYp8
 jFX43E7OjseKa8QKvXmk4OfI8mMhZWRPt3SzsP8o3k0613jedllerLU/lP7KYcez4y3paxkUz/R
 xJI4PDmdGxqf7tQY1nABKebWtrZzIL
X-Google-Smtp-Source: AGHT+IHno8mGOZIh7UCF2eLax8iKZo7i4ZE83gXj3Mkq2CFyleHELVk1LyOvKaOHt1dyhW48JL6Tyw==
X-Received: by 2002:a05:6000:26c5:b0:3ee:1357:e191 with SMTP id
 ffacd0b85a97d-4266e7d9252mr4082637f8f.30.1760001567236; 
 Thu, 09 Oct 2025 02:19:27 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9780sm33442643f8f.29.2025.10.09.02.19.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 02:19:26 -0700 (PDT)
Message-ID: <f9e70ff3-f782-44f9-8df0-7a5bd117d1a1@linaro.org>
Date: Thu, 9 Oct 2025 11:19:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] target/openrisc: Replace MO_TE -> MO_BE
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>
References: <20251009081903.13426-1-philmd@linaro.org>
 <20251009081903.13426-4-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251009081903.13426-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 9/10/25 10:18, Philippe Mathieu-Daudé wrote:
> We only build the OpenRISC targets using big endianness order:
> 
>    $ git grep TARGET_BIG_ENDIAN configs/targets/or1k-*
>    configs/targets/or1k-linux-user.mak:2:TARGET_BIG_ENDIAN=y
>    configs/targets/or1k-softmmu.mak:2:TARGET_BIG_ENDIAN=y
> 
> Therefore the MO_TE definition always expands to MO_BE. Use the
> latter to simplify.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/openrisc/translate.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index df0ebcd3138..4ece2547614 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -647,7 +647,7 @@ static bool trans_l_lwa(DisasContext *dc, arg_load *a)
>       check_r0_write(dc, a->d);
>       ea = tcg_temp_new();
>       tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
> -    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TE | MO_UL);
> +    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, MO_BE | MO_UL);
>       tcg_gen_mov_tl(cpu_lock_addr, ea);
>       tcg_gen_mov_tl(cpu_lock_value, cpu_R(dc, a->d));
>       return true;
> @@ -665,13 +665,13 @@ static void do_load(DisasContext *dc, arg_load *a, MemOp mop)
>   
>   static bool trans_l_lwz(DisasContext *dc, arg_load *a)
>   {
> -    do_load(dc, a, MO_TE | MO_UL);
> +    do_load(dc, a, MO_BE | MO_UL);
>       return true;
>   }
>   
>   static bool trans_l_lws(DisasContext *dc, arg_load *a)
>   {
> -    do_load(dc, a, MO_TE | MO_SL);
> +    do_load(dc, a, MO_BE | MO_SL);
>       return true;
>   }

Hmm should we move MO_BE within do_load()?

