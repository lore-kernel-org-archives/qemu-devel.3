Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE0ACA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utnVj-0006c2-BL; Wed, 03 Sep 2025 09:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utnVW-0006au-T8
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:26:39 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utnVT-0000Mn-QX
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:26:38 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-61ce4c32a36so10788189a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 06:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756905993; x=1757510793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L+R1a6Xx2omEsx85WCdOxhZg1/kv7dg7630bglxmvYE=;
 b=cFwf52tQUa4hgEgjyCrzR0a0oocmKP6fgqwD/CKxtgmVhecxgjCL8pR3sR0LR0SOkS
 vdDBHVd2+78LrU+msX1O+aEtckx+3jZHry/iOUJjpxDvmZ/OgoFr2uWv4sQ5IfNb8NU4
 3kzgid/namsp6adXjaPzTh6zkvjDPQ7Nb1Uh3obgBHhEOOrBsmnlzt4qyzh/B+ph4ZiF
 F9kQwg4uCGOL+XK2IG5PozwxqYFer3shiLnp8UmhFisOcAzI9llOEhKLt8MwYaoES/Yt
 /TSkW3LIoON79RtVaH5Unf64daSZlw4kQFRw1W6eJlKWYfyKEOjtuc+PnBowUXzz3AuD
 NEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756905993; x=1757510793;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L+R1a6Xx2omEsx85WCdOxhZg1/kv7dg7630bglxmvYE=;
 b=Shv+bP+Z3GhulJbkqRuD7SDavOARBniI6rFgdvC9jxrGSnZ1q8+68bqd5P3CHV2z7m
 jY29M3XoTbFWbhsq3kZfrV3ak9fd61mVdH6Q35HsBCytUHjX44TrQ0RfuiroiOMq3cBI
 racXL0D4UQXLj9E7pXZRlD7CP0nOW+5fHDm/gI3i3EN8q3ByDi/LMIlcOK7q5Cq5+stw
 0swt4CHfIlAD6fGCFgmNoKZQd8Dwu75NRoF2FoqDr1BukEm4xUrADLWY9TMMVZSdIcEV
 H4hL/xNL5mmuLJ+Y1zT4JgX3DcGB/HYvPP2jntfyX1BvRToIPiSuX3Ik+a5Cl5E1f+xI
 m+Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqLGEwUaO8n/eMe2QOhnjhTSju4qff3UIT/J/oWEyx3mPosOG2Odj6KO+mnpVH+koPmUQlX4N6UIb5@nongnu.org
X-Gm-Message-State: AOJu0YxDxI7+YBb7gJxdMkXZ/1evnTT5naA6WS/ms3BWiY/7Rti+ERmT
 MdA70UeEMaYKRon5pYsECHdxTC7CmtEZ/OQeLjEAzS8CAO15TdJz57IDxAKeckcyEz8=
X-Gm-Gg: ASbGnctTsRZFYW9Yj03D6uAQNJ4na/onwuhkQ2dUPXpSCRarksAqJkKrKw9xgVMRoIQ
 KAq6HI6BVYcrejjkaYjX0EUMtb7bXPJYxLA8KETBZ19FxQdsKqjtI/7B/555ngPPiKpriWDztAh
 TywAnDqmdZRFKmRhkWuEhtt0TwXc92Xgw/lKlBJlYFwtaTmQtEDE4weCp/26fibt3Dec8TvPIAv
 BxeS1iuOgu2+ILuEXIZrRAxLAHB1fkJh1CA1nzVz5vIQpOnFsIbBj4Q7RteNUM707q1N1CGDak9
 /LuNlIB0gwEGG2MT9ftDeE9jCD0rV5cjPpARWxNOGGui3m59BbbEaJs6hu1pCNQ/4mHbCVWEbhi
 PQcze1dlEZjUNrYL/SajyIm18E8QYZeqcGRreCZX0dhMJ3mVKaXrYo6vxfTF1d6WjNXtXeXw=
X-Google-Smtp-Source: AGHT+IHgWRZmPddaB7b/fWPTtXZY9TxRv3KNbqiAhM3VKQ0XkPm0zShEQZ1sDG5aPGIJru+Cs+nNRQ==
X-Received: by 2002:a05:6402:4489:b0:61c:4436:a0eb with SMTP id
 4fb4d7f45d1cf-61d26d72fd7mr13293157a12.26.1756905993109; 
 Wed, 03 Sep 2025 06:26:33 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc4e50fbsm11670072a12.38.2025.09.03.06.26.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 06:26:32 -0700 (PDT)
Message-ID: <b70f4859-c520-4a00-b9c5-fd988dc6872a@linaro.org>
Date: Wed, 3 Sep 2025 15:26:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/3] target/riscv: rvv: Add Zvqdotq support
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250903130125.1701363-1-max.chou@sifive.com>
 <20250903130125.1701363-3-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903130125.1701363-3-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52f.google.com
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

On 9/3/25 15:01, Max Chou wrote:
> +#define OPMVV_VQDOTQ(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2)          \
> +static void do_##NAME(void *vd, void *vs1, void *vs2, int i)            \
> +{                                                                       \
> +    int idx;                                                            \
> +    T1 r1;                                                              \
> +    T2 r2;                                                              \
> +    TX1 *r1_buf = (TX1 *)vs1 + HD(i);                                   \
> +    TX2 *r2_buf = (TX2 *)vs2 + HD(i);                                   \
> +    TD acc = ((TD *)vd)[HD(i)];                                         \
> +                                                                        \
> +    for (idx = 0; idx < 4; ++idx) {                                     \
> +        r1 = (TD)(*((T1 *)r1_buf + HS1(idx)));                          \
> +        r2 = (TD)(*((T2 *)r2_buf + HS2(idx)));                          \
> +        acc += r1 * r2;                                                 \
Incorrect typing or casting, take your pick.

I suggest

     for (int idx = 0; idx < 4; ++idx) {
         T1 r1 = ((T1 *)r1_buf)[HS1(idx)];
         T2 r2 = ((T2 *)r1_buf)[HS2(idx)];
         acc += (TD)r1 * (TD)r2;
     }


r~

