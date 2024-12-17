Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8737AE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 01:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNMYs-0005ts-SS; Mon, 16 Dec 2024 20:39:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNMYq-0005ok-Cu
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:39:44 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNMYo-0001RS-La
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:39:44 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2165cb60719so37342755ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 17:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734399581; x=1735004381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e98ac4PyAkdOZxtiFB7jpBwUg8nSqEmDKf+bDd1rSTg=;
 b=ac8zP2mP+7KCbHmdc8jtwnqLrhcc7ouwlpMcF1y+yXuf1FiOLvKn+K1D600Y4SW3ZZ
 JJ+USx0d0idEs3+XH2c2WNeYVCLpEV+lJP0pk/GCyRNwM/Or4K5tLY+xcLVia8Jx+VZK
 Nm5c9jLdqjznWhOWl9nRTTbhIEXl70r/WC1FLC93F7tH2a5IJ/UxrtbPxyi8A547p5OZ
 Vdh4bPGeDOqFXZTwsyCzjwbIBQz1kcH5ZbL2CXZLao6viMvQAkt5fBRju+wmDIvm5gbZ
 uaF2Dyqztdml4qFxhxc6dU90pNQJwyOHzndXy9jKoKtXwf2WE+BhnQ4vL4O8dk4lgw92
 zS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734399581; x=1735004381;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e98ac4PyAkdOZxtiFB7jpBwUg8nSqEmDKf+bDd1rSTg=;
 b=MvfqP9XMijdHlAzp1K6Xlnn8avlAo56fkLtqcW3NhBgv1S3MkQOSjMtOt3umbHGTbI
 6WVJoWtx6Y++UENuOhrKF81swRY/C2d7hTqbqn4oh28T6ips/PVRX43JRHjXUkRXVB7D
 nV2Ub/QJI3XUvulaA0u+TFCW96dWbjxWHlMWnv2xn1uTdNWLJS3NlpKapFC/bwIDuqRl
 7QlevQ5blf9tSgWRISnqXbvHJC4tLq7U5ndo60vRA7aKk2GMmHPv6HpOFAuYJNRHxdLp
 ZCVhpWzBI050JlFD/gftJ17KGtxJ7O4AYewfow2PF3TGjT8WZlJ/jmc4RTzyQGODI7kB
 fsgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOyAU0ZBukc54TFzWRkjsq6SN7Zal07cAziKiTVa0hVfvN7egWx8eGbj9dnob6JAEf92v5w1lQex/L@nongnu.org
X-Gm-Message-State: AOJu0YzfD746Bvhndzxuj8IuYdhlOphVSXw2k5B82G6WATgtZXsp2VNT
 O271Ql+PfE0IXe4x0R8BEvo/aYt5Z+eaz6yX/lGTXcb7+jhLI2YiO4fqGcrMNhw=
X-Gm-Gg: ASbGncsK45RPuKy9HpPLdEjrgCoDhUYRCTOvdUWZ5i6l628aT0SwG/RMABjbVZeaetH
 y2HfV5wpByEQAeSXTO9wgYXKBSuS8oVqKV2gPMxF7Yof8PpNaX332MvSeXJxVbsO7j6up+x64wz
 cuDbof6jqTly1HCpjv9OQvhue9dfzf13BSbJaid3Wek6FTu/+UxeOBSo82FrPalaPv7XcASzEMn
 vKN5UEQEcNk6Tg8N7hytoLmYfWpjnXNiP5hP29ltxWt0+EN9nDIeraR25B4ukPRj/hfByieG4R1
 x6wmnHuDRNjBpgzV8YL35jAq+lA3
X-Google-Smtp-Source: AGHT+IGSNVaLERR0mA+hwiiTOGvQ5wWK+GM5wqiMXYVRnsS5C8cVUE9/L4kP2SVpnxJl/5ZFAj9mNQ==
X-Received: by 2002:a17:902:e847:b0:216:2dc5:233c with SMTP id
 d9443c01a7336-21892a20f88mr208639905ad.41.1734399581190; 
 Mon, 16 Dec 2024 17:39:41 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dcb8desm49046825ad.91.2024.12.16.17.39.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 17:39:40 -0800 (PST)
Message-ID: <1cad3a32-a3a1-4d57-98cb-ed9bfdfd9054@linaro.org>
Date: Mon, 16 Dec 2024 17:39:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/46] tcg: Remove in-flight mask data from OptContext
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <97666202-d34d-449a-a763-99cbf353cdd5@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <97666202-d34d-449a-a763-99cbf353cdd5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 12/16/24 06:15, Richard Henderson wrote:
> Ping.
> 

I'll take a look tomorrow morning.

Pierrick

> On 12/10/24 09:23, Richard Henderson wrote:
>> The desire is to start re-using some of the fold_* functions
>> while lowering or simplifying operations during tcg_optmize.
>>
>> Many of these fold_* functions set z_mask, s_mask, and a_mask,
>> which hang around until the end of the tcg_optimize loop and
>> are applied by finish_folding.  This disconnect between set
>> and apply is a problem -- we would no longer be applying the
>> masks to the correct opcode.
>>
>> Fix this by making the masks local variables, passed down to
>> be applied immediately to the opcode being processed.
>>
>>
>> r~
>>
>>
>> Richard Henderson (46):
>>     tcg/optimize: Split out finish_bb, finish_ebb
>>     tcg/optimize: Copy mask writeback to fold_masks
>>     tcg/optimize: Add fold_masks_zsa, fold_masks_zs, fold_masks_z
>>     tcg/optimize: Use finish_folding in fold_add, fold_add_vec
>>     tcg/optimize: Use finish_folding in fold_addsub2
>>     tcg/optimize: Use fold_masks_zsa in fold_and
>>     tcg/optimize: Use fold_masks_zsa in fold_andc
>>     tcg/optimize: Use fold_masks_zs in fold_bswap
>>     tcg/optimize: Use fold_masks_z in fold_count_zeros
>>     tcg/optimize: Use fold_masks_z in fold_ctpop
>>     tcg/optimize: Use fold_and and fold_masks_z in fold_deposit
>>     tcg/optimize: Use finish_folding in fold_divide
>>     tcg/optimize: Use finish_folding in fold_dup, fold_dup2
>>     tcg/optimize: Use fold_masks_zs in fold_eqv
>>     tcg/optimize: Use fold_masks_zsa in fold_extract
>>     tcg/optimize: Use finish_folding in fold_extract2
>>     tcg/optimize: Use fold_masks_zsa in fold_exts
>>     tcg/optimize: Use fold_masks_zsa in fold_extu
>>     tcg/optimize: Use fold_masks_zs in fold_movcond
>>     tcg/optimize: Use finish_folding in fold_mul*
>>     tcg/optimize: Use fold_masks_zs in fold_nand
>>     tcg/optimize: Use fold_masks_z in fold_neg_no_const
>>     tcg/optimize: Use fold_masks_zs in fold_nor
>>     tcg/optimize: Use fold_masks_zs in fold_not
>>     tcg/optimize: Use fold_masks_zs in fold_or
>>     tcg/optimize: Use fold_masks_zs in fold_orc
>>     tcg/optimize: Use fold_masks_zs in fold_qemu_ld
>>     tcg/optimize: Return true from fold_qemu_st, fold_tcg_st
>>     tcg/optimize: Use finish_folding in fold_remainder
>>     tcg/optimize: Distinguish simplification in fold_setcond_zmask
>>     tcg/optimize: Use fold_masks_z in fold_setcond
>>     tcg/optimize: Use fold_masks_zs in fold_negsetcond
>>     tcg/optimize: Use fold_masks_z in fold_setcond2
>>     tcg/optimize: Use finish_folding in fold_cmp_vec
>>     tcg/optimize: Use finish_folding in fold_cmpsel_vec
>>     tcg/optimize: Use fold_masks_zsa in fold_sextract
>>     tcg/optimize: Use fold_masks_zs in fold_shift
>>     tcg/optimize: Use finish_folding in fold_sub, fold_sub_vec
>>     tcg/optimize: Use fold_masks_zs in fold_tcg_ld
>>     tcg/optimize: Use finish_folding in fold_tcg_ld_memcopy
>>     tcg/optimize: Use fold_masks_zs in fold_xor
>>     tcg/optimize: Use finish_folding in fold_bitsel_vec
>>     tcg/optimize: Use finish_folding as default in tcg_optimize
>>     tcg/optimize: Remove [zsa]_mask from OptContext
>>     tcg/optimize: Move fold_bitsel_vec into alphabetic sort
>>     tcg/optimize: Move fold_cmp_vec, fold_cmpsel_vec into alphabetic sort
>>
>>    tcg/optimize.c | 597 ++++++++++++++++++++++++++-----------------------
>>    1 file changed, 315 insertions(+), 282 deletions(-)
>>
> 


