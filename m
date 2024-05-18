Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D13AC25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 11:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8IDE-0002dJ-V0; Sat, 18 May 2024 07:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8ID3-0002ZC-Cu
 for qemu-devel@nongnu.org; Sat, 18 May 2024 07:26:41 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8ICo-0001Zu-Rj
 for qemu-devel@nongnu.org; Sat, 18 May 2024 07:26:40 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-351d79b56cdso738577f8f.1
 for <qemu-devel@nongnu.org>; Sat, 18 May 2024 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716031585; x=1716636385; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bcMphBZIO735SsDmxdTpooOZeTw0Q0LRRuf7Ju/C+Tg=;
 b=jXYg+ZSnRwlR9MfP6wWATe6MTgxME3rGY3nJwRfQu3fNLmlyf/APnXZay4AhBqAUu7
 ic3YXf16rkL8RlRIVYEWqk4TTgO6E9kigi1EPV/eWpW1p7Cpf0Kf3oqIy248nh5YP5eH
 Bubx1wA3fcGwt6bWcf2MsgXxWTDggo1b1rVyNKzSUqJKKPk+eS+zXFUFiCjCzIy55Lk+
 DeC5TtxSLPZg5mR7pl9uKQHxIPw4U8rXhwhGZKebBGCCzWKJY8oSOZR4QuoYJHcRVgEq
 87Wr8UIrF4xquWzPq8MIFMPz23shVs/2EbmRxmYZeZ2iV3Y/yz/zWEWrQwZ4rENK6rGF
 qdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716031585; x=1716636385;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bcMphBZIO735SsDmxdTpooOZeTw0Q0LRRuf7Ju/C+Tg=;
 b=w285u7q4Ne0y5MV/aLxiBucactbHw4iDjUO5Yj4g20mR5antAzYFjSf2w05/pdsabO
 hbPu3qVgbfGJVhelAqrJQdX2Z5N3/0OW+Gec64eMAntjlmYX8TFDdFHyu3BnpvbXHg+y
 h3vSG6BvgPlp4F3KyTeCmZu2SrgKMRdVfws8N00aTFMLQ2F2npepm0Xzw011KGkqZvFe
 xgPaFdSaPc9Rsb2d0RldlVXB05F4KnuBIAcWweAx8adkp2QnZxN7EEA77ylBUJNewHwe
 kdydWY26TWJdbifBIeFd4MmRy697V8AFo0XKxvliMPNUxeHHl3HBLDehq8IgRzYEtJK9
 FYbg==
X-Gm-Message-State: AOJu0Yxnk+cXj/Ey9pTKPCMEv/K9g9ZfH4J5cz22tj5PjBExgH04YkcZ
 eZUc2Y8oXkXJLl1jld/iiuHj+PcPV/7PtmxBnU1BG2UFSUybNoQqrKj5Qa+ll8c=
X-Google-Smtp-Source: AGHT+IHCEVnoK0Ul8XeQTs9+Y5k5w36VjyJ2Cj3mOdbk/inHfPgR7M5AUeYKgxswfMN7mtZkCJejrA==
X-Received: by 2002:a5d:45d1:0:b0:34f:c277:b5ca with SMTP id
 ffacd0b85a97d-3504a737728mr19891068f8f.36.1716031585201; 
 Sat, 18 May 2024 04:26:25 -0700 (PDT)
Received: from [10.1.1.126] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbc955sm23873793f8f.111.2024.05.18.04.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 May 2024 04:26:24 -0700 (PDT)
Message-ID: <95b4f2bb-3eb2-477a-b2af-19cc4ac5849d@linaro.org>
Date: Sat, 18 May 2024 13:26:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] target/ppc: add helper to write per-LPAR SPRs
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
References: <20240518093157.407144-1-npiggin@gmail.com>
 <20240518093157.407144-10-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240518093157.407144-10-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 5/18/24 11:31, Nicholas Piggin wrote:
> +void spr_core_write_generic32(DisasContext *ctx, int sprn, int gprn)
> +{
> +    TCGv t0 = tcg_temp_new();
> +    if (!(ctx->flags & POWERPC_FLAG_SMT)) {
> +        spr_write_generic32(ctx, sprn, gprn);
> +        return;
> +    }
> +
> +    if (!gen_serialize(ctx)) {
> +        return;
> +    }
> +
> +    tcg_gen_ext32u_tl(t0, cpu_gpr[gprn]);

Better to delay allocating the temp until needed, so that you don't allocate one along the 
return paths.

r~

