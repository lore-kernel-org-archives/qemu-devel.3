Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E038BEE0204
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE7b-0003pz-Kc; Tue, 10 Sep 2024 23:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE7U-0003M5-Om
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:34:16 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE7T-0001V1-3s
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:34:16 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7179802b91fso3970587b3a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025654; x=1726630454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/+89lbhweIuowc2NIf6PALR62ieSNy0H/kLOhya0yoM=;
 b=U6GNE050Tc3xmgwIL8tCvnDqqySBiIPld5hFrOItE1RqjM4X6vvCHSJjgtTHYwLors
 nlRBGkQ4nkh1l5tWQhT3r0/4azx1nDLg0OkjOyY+bIMN74aizL/mEYxUUv1y46hvzhTo
 pQEsyzqbfvCrOufRtJXQyPCFaGbvLqiESb0l2ST/0kyt/0BHpyAkdBtQ5vLg1i6TIZjC
 V5Oc5XMW4Ff8D+GErLnQDMQ2v/RodsKJBkoRrizDSIiujTl9TsBuYvBASO3qeMy8HIjZ
 dIkV7YX4xxh25JUtxufg2i7NOWvcp4kM4EVBkwgCWro+jM0DFtL1gUcaRo2vwEGRGM6p
 y8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025654; x=1726630454;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/+89lbhweIuowc2NIf6PALR62ieSNy0H/kLOhya0yoM=;
 b=OLxXIMTyXzdPiu7Bu9JI7LAcQUjhyF5ngRqQ06Qu6/w0TWW0qxy6A0mRAMwtAJdCUz
 4b9WLL1ybEsKLZwnWQvMeI9iCRS9pTlylMAIqcU5lV5b1hB6cFdyYzaEpgVFyz1keEYr
 iEnHQFhlNA2TnEUdKGzcUK29Ge/hpQceC4Fti/AEO8/mhx+9bHWPen+rsnU2WQGF25+y
 d2WVbGahP2Ea7u5kJSF3shdo1V+yCI2El2qSvQYrjAKAZf8VeNwoZDnZvSYGMtOrF4fI
 u1D5MTwitjbiR3IFJ9V///vNLAxzIMCvLQV82nqCRkqAyzcjd3deq5Xicak1Hvz7t+ht
 r2Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqQBh91Fpyl+EeP5rkVkl6eYLjjisa6csrW8aSpbZlrxxutrN9Jw1RcGLQYByUv3u+HLZqQNcdxHwg@nongnu.org
X-Gm-Message-State: AOJu0YwbD+vEByHnOnjQ/f7zjlw8b9Qfn6E90CmWIGDZkwayIQuxIq4T
 KnqaaiptmVrKflGWqqa2OdtJ/N+cdq0HuVA2HG3q9zyVNpe/Uhqc4TgRvdxBQgIoHZbgXJX8u01
 c
X-Google-Smtp-Source: AGHT+IE8tiqvyMibdzFkHRnK//vMcFFQ5kWH2q0hhZtFsmKdgzr0F/xBn1CsldsvAiq0iKV78Ztk0A==
X-Received: by 2002:a05:6a21:164a:b0:1cf:3c60:b8dc with SMTP id
 adf61e73a8af0-1cf5e15afa7mr3409799637.34.1726025653588; 
 Tue, 10 Sep 2024 20:34:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8f96sm2061476b3a.2.2024.09.10.20.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:34:13 -0700 (PDT)
Message-ID: <80ee555d-da28-4030-b5ec-077df2eba877@linaro.org>
Date: Tue, 10 Sep 2024 20:34:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/39] target/riscv: remove break after
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-35-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-35-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 9/10/24 15:16, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/riscv/monitor.c                  | 1 -
>   target/riscv/insn_trans/trans_rvv.c.inc | 2 --
>   2 files changed, 3 deletions(-)
> 
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index f5b1ffe6c3e..100005ea4e9 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -184,7 +184,6 @@ static void mem_info_svxx(Monitor *mon, CPUArchState *env)
>           break;
>       default:
>           g_assert_not_reached();
> -        break;
>       }
>   
>       /* calculate virtual address bits */
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 3a3896ba06c..f8928c44a8b 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3172,7 +3172,6 @@ static void load_element(TCGv_i64 dest, TCGv_ptr base,
>           break;
>       default:
>           g_assert_not_reached();
> -        break;
>       }
>   }
>   
> @@ -3257,7 +3256,6 @@ static void store_element(TCGv_i64 val, TCGv_ptr base,
>           break;
>       default:
>           g_assert_not_reached();
> -        break;
>       }
>   }
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

