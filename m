Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DD6E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxNJ-0000we-0F; Wed, 18 Dec 2024 11:58:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNxNH-0000wF-Of
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:58:15 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNxND-0000Y6-0C
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:58:15 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-3002c324e7eso73730711fa.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734541086; x=1735145886; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6BO+WFZjj4eOBvaQyM7RfaycsczFk1peGnYUzVD0+nM=;
 b=tZ0hxyPlhfIMfB302Y9QBUAH92Pk+y0b7L+KFBASmfB5bm81xfBWY6Ma+VePYEyjI2
 Ujot450mzN+NX4hx28amOYbJELkg9pfI1q9DKG1p40LorULAfLj7111ieirSQRmldssD
 aZWRzs3/srwV3cMbD/qVypHpW1qhOuGibL8bVoMStu1qqK7ltj1xuUyvSRTrk3wc6Hm3
 YkAMuwRcClQ++HQJYOcz7VxRhZ27AVHAl3Ao87VEEMX/R8a3ZTDSSrn3gb5TSnpV7uTJ
 VwHDGrgA8lOq2+Ii/DEVhgcUH3Kmsz5hBRuHhshjKXAdDCKXs4BK7W8+u39Ij45HThFz
 eRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734541086; x=1735145886;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6BO+WFZjj4eOBvaQyM7RfaycsczFk1peGnYUzVD0+nM=;
 b=YkOMMl2QCKn6PM/Hf//JYZoCcyXD1xbKDUf1aTR8gGBY8OxtUlBVi0s96cD96flDdI
 MQ4SshhzBJAqvO0513zg47cjYdjqyMeDLEO24AWBwlasT2K/kFm9jjDU9Q00IEkN7kC7
 pPI4OXPTScB1znMRkov6fvcSbR0gYEV/xsWGfw17XcPVnAvYvhxXQHDQIWYGSaf7UQPY
 0WEGyS5WUBt9Ct5szygoddRK9hCK76epXnc2iSOYgZl2R1pjoTBrNLLfx6T7f+xzt750
 rqw2cxCvObpfh20pWAY/bClJc2p6ZrGrdrxjsSsWP9eSy3bVhZUfRNS7wqgOw3DMIFaJ
 wfHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSpWukXEvb+HWtyIVC5xygAqp11cwpYdtKTG+TQXbjJT2Kz9bC0MAwS88Y7BZhg6SGR3NopTzX6Lxy@nongnu.org
X-Gm-Message-State: AOJu0Yy7ac0rLWYb1BpWDAUJEK1d+8cr8qwhI6fjOO0ygvR0ei9sWBF2
 EeAQtlzDahzdr26RQVFjIfTHKgJP5Y33EORP+/B5mW4TvqHMJ7z1Bj/E22UPS60=
X-Gm-Gg: ASbGncvibxfimf9vPBbGFAdZ3D+5kKWmndRHBbeSaLksjYdOGIKcTbP6RH9DBA6w6Fb
 DbpDDE4+hLldWVHCmFtDOt4cxDNqpbB4P8dmwtLIsjoppwnddBlw2z3DBrOk/3Yrs7i+mXlARge
 l+GmQQkdZa+oZvH+cxbjHWIH1UxhRKnOhpezuTbCSoGTTPm5EN449PY6tPNaHfx9lTqaOpFHG0q
 K1LH6JkIyhFDvMJfW7H+94pgWvCkvmX35XSBaaVQl+wXtKNRZoyIxUl/4sFNIxpEVuI159S3oQ=
X-Google-Smtp-Source: AGHT+IEz5vxoDasLusNAQ9E7xCazdUBOMo1zuXoNS5Yvp+VxqyuAqHesjx0ptEYZ9N5Z55QO0Zs1jQ==
X-Received: by 2002:ac2:4e07:0:b0:53f:232e:31ea with SMTP id
 2adb3069b0e04-541ed904127mr1386064e87.54.1734541085612; 
 Wed, 18 Dec 2024 08:58:05 -0800 (PST)
Received: from [192.168.242.227] ([91.209.212.65])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120b9f350sm1510905e87.56.2024.12.18.08.58.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 08:58:05 -0800 (PST)
Message-ID: <7d0dc3b3-8253-4555-8b8b-fa59e3d057bb@linaro.org>
Date: Wed, 18 Dec 2024 10:57:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] contrib/plugins/cache: fix 32-bit build
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, philmd@linaro.org, 
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
 <20241217224306.2900490-7-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217224306.2900490-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/17/24 16:43, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/cache.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
> index 512ef6776b7..7baff868609 100644
> --- a/contrib/plugins/cache.c
> +++ b/contrib/plugins/cache.c
> @@ -208,7 +208,7 @@ static int fifo_get_first_block(Cache *cache, int set)
>   static void fifo_update_on_miss(Cache *cache, int set, int blk_idx)
>   {
>       GQueue *q = cache->sets[set].fifo_queue;
> -    g_queue_push_head(q, GINT_TO_POINTER(blk_idx));
> +    g_queue_push_head(q, (gpointer)(intptr_t) blk_idx);
>   }
>   
>   static void fifo_destroy(Cache *cache)
> @@ -471,13 +471,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>       n_insns = qemu_plugin_tb_n_insns(tb);
>       for (i = 0; i < n_insns; i++) {
>           struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> -        uint64_t effective_addr;
> -
> -        if (sys) {
> -            effective_addr = (uint64_t) qemu_plugin_insn_haddr(insn);
> -        } else {
> -            effective_addr = (uint64_t) qemu_plugin_insn_vaddr(insn);
> -        }
> +        uint64_t effective_addr = sys ? (uintptr_t) qemu_plugin_insn_haddr(insn) :
> +                                        qemu_plugin_insn_vaddr(insn);
>   
>           /*
>            * Instructions might get translated multiple times, we do not create
> @@ -485,14 +480,13 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>            * entry from the hash table and register it for the callback again.
>            */
>           g_mutex_lock(&hashtable_lock);
> -        data = g_hash_table_lookup(miss_ht, GUINT_TO_POINTER(effective_addr));
> +        data = g_hash_table_lookup(miss_ht, &effective_addr);
>           if (data == NULL) {
>               data = g_new0(InsnData, 1);
>               data->disas_str = qemu_plugin_insn_disas(insn);
>               data->symbol = qemu_plugin_insn_symbol(insn);
>               data->addr = effective_addr;
> -            g_hash_table_insert(miss_ht, GUINT_TO_POINTER(effective_addr),
> -                               (gpointer) data);
> +            g_hash_table_insert(miss_ht, &data->addr, data);
>           }
>           g_mutex_unlock(&hashtable_lock);
>   
> @@ -853,7 +847,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
>       qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>       qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>   
> -    miss_ht = g_hash_table_new_full(NULL, g_direct_equal, NULL, insn_free);
> +    miss_ht = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL, insn_free);
>   
>       return 0;
>   }


