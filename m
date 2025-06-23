Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A617C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 18:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTmAn-0006tO-KS; Mon, 23 Jun 2025 14:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTmAk-0006t5-AB
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 14:45:40 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTmAi-0001q9-Qy
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 14:45:38 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-235ef62066eso61349555ad.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 11:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750704335; x=1751309135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iQDozFzusCS6VTgwivZPv19u4pOSEZ0pyD4dawfjMcA=;
 b=Xf09knM/R/ldedhuc5+DrAWR+tbzkDM9sP8iR8R2AcRUmnIV0rs4mE9wh6j5a1Rwi+
 bGAx0kXud5nMq28vBl9BeUfRQ40mcSrVgq1UGSVZxeHuQ5eDUHd769WXzzvc0Arb8Ajz
 +Lry8YairFK5h8qlhnwf+K2N5PZQIFq6upDjT1AH29TjciGdrhQUqTsEHZFrK0c3Y0iZ
 VVh4wpjFJkM2agJmYUMrHaqTIoHOUUwgsU+KKTQscE41IesJN2mnkjfKK6VU5Hx6u0my
 U8at/o3QHvpYUSmJ0KgtwkXebEn8zGsvR1bdZI7zYlYI3V4KSgGy0UBh6vHcNJYHI5Z7
 WmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750704335; x=1751309135;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iQDozFzusCS6VTgwivZPv19u4pOSEZ0pyD4dawfjMcA=;
 b=TNVFldmiU/C91Lhsoq3YCzEWO/U9eAcBIj5z/yQMBLx1tLgHZHn5NuRDBivovawiL5
 BDfi8abRA2zygJMmZMQY8bun907SUSBCdK8GlGaJxRJ5aYG7yoc6aRknCgCtLnmeiQ1E
 jF4avSOIZYnJ5UhrdYvWClnWoi/nsmR1zNUK+yIvyG9PlLgknQPfEN06BXWRqMULpiCE
 Z28J42qVjEK02sU6BfY1dxY3lhNyNhrrjcSvfYEueN74tFYrtEgjnql0uBu4ZcDHdt1Z
 71W2euwoIFSfDvKM5pQus+zJxnRKcHEuDsCVLYDpDS/AxjX8A/07K+OMDoqJkd4VNsmF
 t09w==
X-Gm-Message-State: AOJu0YzQFZFJxBdpilhur9E+zO4Eg1rF2bl00D4uaTMhyEZv+Oqf8dK9
 t7f1HbST/JGFmXy1KYSoFUcAEI3EPbzkLT6761139jJobmJa/NP7ezSBJ3Vm2Ra2U9xJxdirZ4f
 9zrRMqhw=
X-Gm-Gg: ASbGncuPxxlg0+RGXtMj8qC1kKVNclSNt8X21IgGksGJCkO3pBueqXyGW1+n5DrKDrR
 ZvLmHwOvyg9ZBwa0FhVLp1DRAS6t8xG5E+m0RcuxcSgLcUmzhzp4dQqGLZBNh+rtGtvyDfpmZxs
 u4octb6fp6PtZha7+3D3pm+4OqZOn2AwYXkjhtPha3qtFkCtoBwPaRZO646PYs8+NpsraagHcTk
 LpKMSpZ5HMiD7i+x8hY80KZJLXi+6ngX6OQU7YMNMKDTpNHXGwZwDkJn9m+l2p9SRx5FKoW9R7I
 t9PEbO0BoKEgDdPXr69pDDzEzdUul5zWQOEJO0OgNdbfwBq9MeUHWZjAW7KhHOZnFzIjcMeL+1k
 mi4rCizUJQ/pSAdFp0J/60R7YuNCL8X9r3Ysp7t4=
X-Google-Smtp-Source: AGHT+IEVLg92mad24AvmFUCmKVGmEEdoRN3KfBrJx10E3DTMhMat+QAPrf4B8zuWqJbvcVBFssTjew==
X-Received: by 2002:a17:902:dace:b0:234:ed31:fcb1 with SMTP id
 d9443c01a7336-237d9777647mr216431215ad.20.1750704334952; 
 Mon, 23 Jun 2025 11:45:34 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159df846fdsm9652973a91.20.2025.06.23.11.45.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 11:45:34 -0700 (PDT)
Message-ID: <182c565e-1ba3-4798-aea5-5cefbef4c70e@linaro.org>
Date: Mon, 23 Jun 2025 11:45:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/27] tcg/optimize: Track and use known 1's
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
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

Ping.

On 6/3/25 01:08, Richard Henderson wrote:
> We already track and use known 0's; do the same for 1's.
> This actually simplifies some of the logical operations,
> where before required checking for a constant value.
> 
> Changes for v2:
>    - Some simplifications suggested by Paolo.
> 
>    - Merge affected bit handling into fold_masks_zosa.
>      There's an optimization ordering preference for
>        1) constant result
>        2) copy result
>        3) computed result
>      Having fold_affected_mask separate performed 2 before 1.
> 
>    - Rearrange the and->extract optimization, because it
>      would perform 3 before 1 and 2.
> 
> 
> r~
> 
> 
> Richard Henderson (27):
>    tcg/optimize: Introduce arg_const_val
>    tcg/optimize: Add one's mask to TempOptInfo
>    tcg/optimize: Introduce fold_masks_zosa
>    tcg/optimize: Build and use o_bits in fold_and
>    tcg/optimize: Build and use o_bits in fold_andc
>    tcg/optimize: Build and use z_bits and o_bits in fold_eqv
>    tcg/optimize: Build and use z_bits and o_bits in fold_nand
>    tcg/optimize: Build and use z_bits and o_bits in fold_nor
>    tcg/optimize: Build and use z_bits and o_bits in fold_not
>    tcg/optimize: Build and use one and affected bits in fold_or
>    tcg/optimize: Build and use zero, one and affected bits in fold_orc
>    tcg/optimize: Build and use o_bits in fold_xor
>    tcg/optimize: Build and use o_bits in fold_bswap
>    tcg/optimize: Build and use o_bits in fold_deposit
>    tcg/optimize: Build and use o_bits in fold_extract
>    tcg/optimize: Build and use z_bits and o_bits in fold_extract2
>    tcg/optimize: Build and use o_bits in fold_exts
>    tcg/optimize: Build and use o_bits in fold_extu
>    tcg/optimize: Build and use o_bits in fold_movcond
>    tcg/optimize: Build and use o_bits in fold_sextract
>    tcg/optimize: Build and use o_bits in fold_shift
>    tcg/optimize: Use fold_and in do_constant_folding_cond[12]
>    tcg/optimize: Fold and to extract during optimize
>    tcg/optimize: Simplify fold_and constant checks
>    tcg/optimize: Simplify fold_andc constant checks
>    tcg/optimize: Simplify fold_orc constant checks
>    tcg/optimize: Simplify fold_eqv constant checks
> 
>   tcg/optimize.c | 456 +++++++++++++++++++++++++++++--------------------
>   1 file changed, 274 insertions(+), 182 deletions(-)
> 


