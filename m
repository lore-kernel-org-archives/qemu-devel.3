Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CD7C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh8x3-00028k-Ef; Tue, 07 Jul 2026 12:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wh8wl-00024H-UC
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 12:47:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wh8wj-0007LC-Fm
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 12:46:59 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cad4170e8eso53360025ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783442814; x=1784047614; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RvaL0DDq39uCFSvYJsyZPoc1EYuojl4rkk8dCWR8msk=;
 b=v4zdd6yWlSOPR5etJgDBQMnSdbZyU5Rd+AbWRuLoeIAqYbwKVkR7PwNJ4ohfAxf+I4
 a6445nSw1nFBj7bbO8Ogex1EBdCnzw06iFvxmoM4CFB0ZfyVBm5JN4hNRO3qvn0gDDRU
 CJSbs11Q/5zec7KcWFjOATUN0Z2XgCtaN7D7k3SJbzQ3r1WHKf5ooCppKBP7FdjnRXhU
 C4gIRFFC+W6NYwOwLEPsWbfh2IHz3H4Ng7O5LGI0uRs0dgOBvKnzapWZeI7w8o1/Y88u
 G8n20gB9BkKKcFxsW1P8D+QzJPoy7JoZDeTJR5T916bFXPTpD7K76reunoGcHAUOY+Qr
 TxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442814; x=1784047614;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RvaL0DDq39uCFSvYJsyZPoc1EYuojl4rkk8dCWR8msk=;
 b=i/4y72arqqtJba2L01I4gTM9YvaNoWHHJXJwG3JjeHZ6b5wXgAjUotM2s7s9Htxv0s
 1zlVpekjjoVe32KyXhoYZKSUDtzVFwSi2KfCYIjisIWpPcJtXFHtF+7zb3AHBxrMwJ+o
 nnPDLC67YK0EdSVReKhoVNyX507J9asTKLQoWB4/w8gmQw8vcXXhEvuMYX0UUPiypH8Q
 YPciJe6QTFDGVA7MTZoj7GXrYfmfOrOw8aKQHS30B8xx9+5rSVDzuioi77Xu+D0nWR6b
 cB+P3ZQiLaqzM/KECJqDRI2bFewkNvoFJYH7jJjEl0B7h72zYcpHTgGr5JSxlPhtuvMi
 QcNQ==
X-Gm-Message-State: AOJu0YyySRPHfEjJbwgwRbw9RoXVzHWnUe/3vnKZrfYi1LPtqCOqi26a
 U2gy61TV9C6x+zs2CpsPRhLfz9+vKSfzAxgjoi1W4+zzPukuDlxqlxWoj1PMtHyzFVZHpYkBPXH
 XMWOZ
X-Gm-Gg: AfdE7cnqCGOwE7cvb8JLaUqEoRuDEU/fZ9xmx/mAbTUSfFFHM+sncXv/buBQwx2mNlt
 fqN61fIE4B11J97wYv8aI+zd/qPkNKEvquFEZ/xTGHcRQhQb0hBZd4jLDootzvURSyBKp5hTPD8
 +rXTO112NxCUHTVx0VSG7IED2CO/kU64R9FDS4M0o9YbT+v6eb1qyE4dPCcXoMvtwwXi9lkyoeJ
 +LCE1c0IeAgbGH5zTwGSplcdBnGMdX0aHeqHyDiwPeHUuhDpR5QptIYTaN17ZFVOawYpKpOX9Zg
 rX22cvRFkASozbTVRYXy9oPG9KVoPrXh10B6ogTMNPX/c8Alhp+VMGvHSIuXU4DIFnyRDqzdiLA
 SMwla0zO1eeVBtzQF99mzS/j8fiVS3V+gzd4BKXx9JPN6oEfUksv17S4EqnNl4UavZw2TnQflHd
 BCKIJ+bcG9JptysApzc4e1Vjm02sXqeKfvmafgvxt0VA1yF0UKwLuFoy4=
X-Received: by 2002:a17:902:ea0a:b0:2c9:bd37:ae76 with SMTP id
 d9443c01a7336-2ccbf1a34demr58472385ad.47.1783442814251; 
 Tue, 07 Jul 2026 09:46:54 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3d952sm15055075ad.61.2026.07.07.09.46.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 09:46:53 -0700 (PDT)
Message-ID: <922b316d-961f-4747-832b-c5e28bdaefa0@linaro.org>
Date: Tue, 7 Jul 2026 09:46:51 -0700
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Ping 3.

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


