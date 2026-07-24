Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8985C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 17:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnJRx-0003F3-NS; Fri, 24 Jul 2026 13:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wnJRu-0003Eb-18
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 13:12:38 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wnJRs-0001TC-8G
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 13:12:37 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso7440925ad.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 10:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784913154; x=1785517954; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JfySnRHn8mJcM9vGORcDFI5E7FMJjzg6nhHCig9GtFA=;
 b=jf80QJd4Y0vPNIy/qclDMRIUDh/d+D1qq4lPOWaQAH+50Y2ByAn861ZGV6/rJnDGbR
 21gwjMK7N4keYRRbJQz1mg4U9aBL6+JdGWo7h9DfydaFolfM3pW3slyvSVRAWf7cqX4v
 LN7A5MnUsn+06YjtxHSWUEeulYfgxlOGW4wiSGnAvyV+IAhdeGkLDB1E3bpzXB5Nin5J
 QrX60QWDrlgSHDJ8axyq5YCrTDivaETtJ6MGtvtjMb6yMCb7SrQwbOeBWf6snpRTAiKg
 rJtpBiie7My4HqvigsBg2vJvtN3iOEH868nVChdjqZeAS32hXUacM8Gm4/bqKgKqSnhP
 Fipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784913154; x=1785517954;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JfySnRHn8mJcM9vGORcDFI5E7FMJjzg6nhHCig9GtFA=;
 b=ewo9Sb3mEjiMXQ+8Jq9uFwNWA3Rk8BZ7Gzog7DY/Tk60M1K/aEcqxNyfNQhGW3XxHq
 mFOqDW6S8M3BykpFf5n3fg/q85QtqbQ3L0xFtPeJ0G/Dd8ABFoWwVKbujrsSUI0KwEkm
 fiZMzQJQElikXvpLdYYiH8DgDPMfjWRjKrTyLN0pSbhRdy37v/Ue07uEgu6G6Jbi5Qo5
 BIMGnpbC6YmVHYU5pIV8XleiTszWatg9q1mdNuKqxS09dhN23UolehDUoPLEzWf+GloZ
 46Am1LNNVl+WshTTqzFmq7nD6V774LWxXPyYfIqbJMC5ArjsdyyNdbpyk2TaHWX5hzQP
 ZVeQ==
X-Gm-Message-State: AOJu0YwIv0LBlABwurJ3VkJy8KqqUulIS/uQNIK80NbsWZPyUjW/AGIg
 SQOLXiyQFd52DlTWZdsGwR9VwyLIxqja01ezvRUvpMGSiW2qNhRC9xJzregekNZIj5ijfNPqCTC
 uJl9Q
X-Gm-Gg: AR+sD11ya3RgEfN+e8m/KLEZEV3yyBPS84tTjjoHACEMV/mWelO3nEBm9dHPY+vtzyk
 XhyjKOKPBKVnztgdR2v5G0maJO7BYGPPJV8nFzf7ulFuedvd2Raeg+xT8Rut8HFbvPXkD7Qy6hd
 WYEaDpY4oNELO359x7hwwnwgp7ial05EYuEYDSiQlwb5EXRoYJuqY3u1jqZGgZsiUgbRn1bTici
 tvGIjswjgeoXvWzDaSO0+8/KhFM3tAIBN7IudG1Ve0FxQpG5zTuHltGHv/02OIPbhGSkMNVfxea
 lNOJKBUUqRbFTcdzBi1HPvd0JJ0+o91RQoXpQ0cpKtZgRrBqw6dlfhWAuC33RbxLlbUSx4lYfX8
 mIUGijULbM2XAXQOpvO6BoukLLnxiw4WdNps8Yx8HTNTnLwOncvCTuZ4QtV69ndzG8Bn0SLblG5
 5RHydUGhvuxf1awsEOTssUq9lLTB1JkJzIrTo4OsoboA==
X-Received: by 2002:a17:902:f601:b0:2bf:7b62:a038 with SMTP id
 d9443c01a7336-2cfa6a55fadmr82216685ad.9.1784913154202; 
 Fri, 24 Jul 2026 10:12:34 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf8f313287sm55025455ad.58.2026.07.24.10.12.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 10:12:33 -0700 (PDT)
Message-ID: <84d67618-32d4-4070-a066-bf06c487e2ed@linaro.org>
Date: Fri, 24 Jul 2026 10:12:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Update cc_op for SAHF
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-stable@nongnu.org
References: <20260609002802.729485-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260609002802.729485-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ping 4.

r~

On 6/8/26 17:28, Richard Henderson wrote:
> Removing the call to gen_compute_eflags meant we no longer
> updated cc_op after computing EFLAGS.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: da7649c6aeef ("target/i386/tcg: do not compute all flags for SAHF")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3537
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/emit.c.inc | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index ce636b6c56..59948fe64d 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -3768,10 +3768,13 @@ static void gen_SAHF(DisasContext *s, X86DecodedInsn *decode)
>           return gen_illegal_opcode(s);
>       }
>       tcg_gen_shri_tl(s->T0, cpu_regs[R_EAX], 8);
> -    gen_neg_setcc(s, JCC_O << 1, cpu_cc_src);
> -    tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, CC_O);
> +    gen_neg_setcc(s, JCC_O << 1, s->T1);
> +    tcg_gen_andi_tl(s->T1, s->T1, CC_O);
>       tcg_gen_andi_tl(s->T0, s->T0, CC_S | CC_Z | CC_A | CC_P | CC_C);
> -    tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, s->T0);
> +    tcg_gen_or_tl(s->T0, s->T0, s->T1);
> +
> +    decode->cc_src = s->T0;
> +    decode->cc_op = CC_OP_EFLAGS;
>   }
>   
>   static void gen_SALC(DisasContext *s, X86DecodedInsn *decode)


