Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D3BC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURZd-0000te-JH; Wed, 25 Jun 2025 10:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURZL-0000jp-FP
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:57:50 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURZJ-0006px-Q6
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:57:47 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3134c67a173so7408500a91.1
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750863463; x=1751468263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HF24CoFm//ykVvecIjhkfKTAyH3l9nklAC4Aykw78SU=;
 b=sSpSumpbYvPugFwtTTs4GXJ8XRjOGzJmkS9pEpeeBwUAHI5ogu134U36wf1UdwfhUw
 y5jnZbklCXK4yu5098tpqFU8Ydtbp3cEtD478lGsRcHRlnxO/l3MTVTXkaWcyUkq9IZk
 FNgBNmlLwt3gikMBmSmUpwL8n5xBkTsvnVh1L788Q6STQzhc6vbX2RHhXqVVW02uOUPd
 GR50wufgQZhHYIcRSEsdigMOT6p9ignPVKH+ZDdaP7OgvcGA2sn0OW6/RNkX2CK4ywf0
 Gn1ix+xfqaCkn4jh2KlzKJraTTt08cSsIPZlLCboyDzOBBuePbRAHH5XDhO6JhakVLvd
 mdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750863463; x=1751468263;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HF24CoFm//ykVvecIjhkfKTAyH3l9nklAC4Aykw78SU=;
 b=CJXL5jVqlX4rVFSeTExAUeogH00WGzsLwGM6JwwO1ohOd8Ipa7kSXDAATOMK1tX77N
 pjVtX5AQMkYIwW3ZeWoQ1YtnFapYZRddW/e0gWmAkuZ/BtcHi8ITOCfBgYsePj3k6OR7
 AEsVQ9XBtqKK4YkZba/5x1N7BP17q6DFEYCycx2fBXVcKmjMASLc1L0ZWAwgw7+OsnUa
 jhZOV1TaQ8G1vLRO6p+Fu9MBayxRUuCKc7YmA4EPgwyTJOX3ugg3YYobk/tWNC0+rw54
 kyl8wZGkxA469Y4FXreCHu/UtCdGXzHayfnLJuiLB9wYgBgfCCJWV2tdJ5KwTgcKHpmp
 gEdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7enl+mIZ7i5g/DrXU3hgvK54BjD1NQL6tPPse3hPe9oMvkQPYffmQ/LdtR9uogQwb0spPR2+KED/t@nongnu.org
X-Gm-Message-State: AOJu0YwKVwB3QIxNfdGg0t6jmVAYBzAe/ENsTTf8N+HBB1TViX4GEDbI
 OpZcHKEUOkhlbUXKdAsrK0LJKDsgeUvKMH3L7f9efPKVbV4Kdo/IAHJ48i4CE6eghPI=
X-Gm-Gg: ASbGnctgwKtzb9gCRShOu7JAZarjOQ+a4RhL5RsYRf7V/ez5qqynvukgMCOK79flCi7
 0BRVmsSyGzQT6Ts2gTIoY0w/MRCLVr0cgTwoYb8LRKghHCFNevKVIkN6Ul5jlRp/eDkQ+iLnOiw
 KwvyxmbbxyJ0aL+Vs4U/ChsFFh+dmzHvOQPwaPoM/P3EqCoULr5BHgUrAyZfT5v06uCmhNF2XDB
 uZK/uRVs9oO5EVA++5rCdnLg6sW5pQk4dbB/MIquI6CAsdlztES4aq1h02yEhn6rBsAjB72FL9/
 0pEZnQ5a7qVlcKgdxNPRemJgINeZ86IQIRvZgDr+fajk0SfVYXVMPm5uY1kf+HbYzywPJjT8Q6I
 =
X-Google-Smtp-Source: AGHT+IFGpWyHdCQIFG0bnHg2TSFBhLCCIL3263NN8YoPKglchUEh4hsoa3YDKlVBmkhkPMXAeJ+QrQ==
X-Received: by 2002:a17:90b:2790:b0:311:baa0:89ce with SMTP id
 98e67ed59e1d1-315f25e1a89mr6109691a91.12.1750863463414; 
 Wed, 25 Jun 2025 07:57:43 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-315f53c346asm2150309a91.29.2025.06.25.07.57.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:57:43 -0700 (PDT)
Message-ID: <0ec0c29a-3460-4006-bbde-ee971f015c7a@linaro.org>
Date: Wed, 25 Jun 2025 07:57:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/27] tcg/optimize: Simplify fold_orc constant checks
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-27-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

On 6/3/25 1:09 AM, Richard Henderson wrote:
> If operand 2 is constant, then the computation of z_mask and a_mask
> will produce the same results as the explicit check via fold_xi_to_i.
> Shift the calls of fold_xx_to_i and fold_ix_to_not down below the
> i2->is_const check.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


