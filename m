Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2936DC9832A
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 17:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAVty-0004Ec-QM; Sat, 26 Sep 2026 13:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAVtp-0004EK-0Y
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 13:09:22 -0400
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAVtn-00029K-3X
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 13:09:20 -0400
Received: by mail-pj2-x0e.google.com with SMTP id
 d9443c01a7336-2ddaa08c890so7703005ad.0
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790442557; x=1791047357; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sOpSJ5ppxRArQ1cKwJRvawiw7z9jiNW+BXDcOQ44qvo=;
 b=cw60Cdf/ptVN6xrxNexFFJaMntmbkvFRZ3TCtJdqj/CFUNotOSG4uUPEOPanefMdJn
 tlOEi/f9+D5ZIVYeSkJLtRCvltZxwLlwZBG2agK0MqFOAhbZsh2JspxRlCxBRHpVOehf
 CWrdc2H5CeUiQ6o8hYJFFNjDwPHeNPi1e0dEwp6+uDOyiE3eg5eCc8Qqmsn4hWOvzx5L
 wn2K9wDqhAQmfNyFjS+zdbShdb/rDY6AWLzgR26b0YRZFWZpSuCrHqe7AK4BX0sdQGVu
 jjMCHVN8Lq9PWJZ4s16IUR86/7olbYPFoVy3+/z6y0TkPsPs4CkXHMmWfktmCRlzpU9+
 RBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790442557; x=1791047357;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sOpSJ5ppxRArQ1cKwJRvawiw7z9jiNW+BXDcOQ44qvo=;
 b=qO3HoHKBVcVI3sZjifUPNYLS6NF14uiCwr/AeQe/f8kqM0AkaCjtOUSg62IFtrA1zC
 U6DaNmv5OOS+6QBpSgqRTBVeED8vNLM7qtIC93pfXQ6YUYSSXAohbh2AC8q25/xXbxlQ
 U2LZBfTQhbde92fnURJl4u/37SqpurNlLkhkiMv1ypXWCrFGwjmlpP4GK8n3uJZ8JCgd
 JdGJNzaEJKTWb6lA634XoeaSipSsezbmzK6nuB/LmGtZtdFfzEJvCgSQwec0pTmseTjd
 qAV9eOH8kPxwxwd0IHmZcKTpe73G7UbOzmRDOV8dmaLwO1ZpTlN3a03faBLKJvMbtF8s
 R4Xg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKr0KIdv0ox/WLeN67XfqTcE67s8cEPvOETQqqJeI2w2azUFslTaE4FItzk3obBtTyk7a/RrVI8lSr@nongnu.org
X-Gm-Message-State: AFq9FYIZ76t+aVWw+0Jw69AJaWNpKDwzSulviV0ZfNt3drVXKDWK5G1R
 BVLSgiSZyt8zYVXoGedHTdtph4aAUc1HyUlmhjNdykfs+R3VPbUA6jnaKZIRtYOZ2tE=
X-Gm-Gg: AYBFou2OSvWW7w3i9QDKW0NKoef+Ts6fmI3gfSbzQexwUy1xGoHmpONGvMyTEtOsl4t
 hlF7of0kjreAasjdMNQfHkt4nt9Ue9eA6Tqzk35eO/fN59IVXknly4z4LP/K/l8hFsuxD1D+z4O
 Ya9UR8xKuIAQeA5+fhCu/PW1Q/+E1NTLelGY37Bkwz4s77ErAWCpC0dW2qUsYROoVDlIy8iH21m
 prdmFfjfTw/Gz3ZUCYbO+EKy9KV2ZL1RQ3eu16fNA1oiQlo6hdtK1qBLSM9v8bIijRyRGyLCfgF
 WVaRGH90f7gLDOAZWQ+l/rAITAPcOccUo/fTqMhzT3AAfR+XpLB5YXKjQ3LlldWs05+5EcXkmfS
 +qfLTvkKcnnDTyOcgf0m9iaSVBi1QUgRPYba2V+kxfkB7jH08DnkJw+Utl1/jjZP3xB1qHX6g0N
 KrMcrDyR6RbNJ90zKfo/HZmBoJ0K6SrGE8Q5m4sIMba7gl/Hd45tbETf4wgS34o39UMTdmUaey/
 OrA9iYay+6YQsPcG9eBIz5cBzb+BeHU/AQ2G1S6
X-Received: by 2002:a17:902:d4cc:b0:2dd:c100:7cb9 with SMTP id
 d9443c01a7336-2df7dc5152bmr72839215ad.53.1790442557170; 
 Sat, 26 Sep 2026 10:09:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc787854d17sm2624246a12.4.2026.09.26.10.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2026 10:09:16 -0700 (PDT)
Message-ID: <b85730f0-ced2-432c-87a8-3b21c6342ad8@linaro.org>
Date: Sat, 26 Sep 2026 10:09:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/tcg: fix lea address for instructions with an
 override prefix
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20260926072815.467722-1-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260926072815.467722-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/26/26 00:27, Mark Cave-Ayland wrote:
> Always add the segment base when an override prefix is specified in segmented
> mode. Otherwise the generated address is calculated incorrectly when an override
> prefix is specified and HF_ADDSEG_MASK is not set.
> 
> Fixes: 55a15eb3504 ("target/i386/tcg: simplify effective address calculation")
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   target/i386/tcg/translate.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> 
> Paolo/Richard: I'm not sure if this patch is exactly correct, however it fixes
> a regression when launching the OpenWatcom installer under MS-DOS. Current
> git master aborts the installer with a GPF error in the guest caused by this
> instruction:
> 
> 0x0041e0b5:  66 2e 8e 1d 0c 00 00 00  movw     %cs:0xc, %ds
> 
> where def_seg == 3, ovr_seg == 1 and ADDSEG(s) is 0. Without this fix the target
> address is calculated as 0xc instead of 0x41e00c.

It isn't the root cause, no.  Here we go:

x86_update_hflags:
>             hflags |= ((env->segs[R_DS].base | env->segs[R_ES].base |
>                         env->segs[R_SS].base) != 0) << HF_ADDSEG_SHIFT;

cpu_x86_load_seg_cache:
>             new_hflags |= ((env->segs[R_DS].base |
>                             env->segs[R_ES].base |
>                             env->segs[R_SS].base) != 0) <<
>                 HF_ADDSEG_SHIFT;

So we've been incorrectly including CS in ADDSEG since 55a15eb3504.

Thus

-    has_base = ovr_seg >= R_FS || (ovr_seg >= 0 && ADDSEG(s));
     switch (ovr_seg) {
     case R_DS:
     case R_ES:
     case R_SS:
         has_base = ADDSEG(s);
         break;
     case R_CS:
     case R_FS:
     case R_GS:
         has_base = true;
         break;
     default:
         assert(ovr_seg < 0);
         has_base = false;
         break;
     }

might be the most legible way to fix the above expression.


r~

