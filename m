Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99413D0D146
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 23:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vddCa-00059g-IH; Wed, 07 Jan 2026 18:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vddCY-00050y-82
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 18:44:30 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vddCV-0007e5-UZ
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 18:44:29 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a1022dda33so16984325ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 15:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767829466; x=1768434266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2xsSiA6IJiYIuZkZVeO4oiNpAiKFrrFc6oCDea+yLas=;
 b=Mw/cvm+DhHEYVogE285agkI5qorbkhY0RahPz3g1Y55AmxWLXbjWDe41+KVfxmfcfs
 k8Pk8x2syjQ3VnzCLTm/AhdrKEJlQAXRsbFYLJ8NA/nABK8JKakIIMqXxVWuE5zgn8Si
 xi+WlLh+42cY/8StIKlC6qrS+XL8TyT3vzZeQnvTCIZObKV0IumtIr3a7wcb+1NkpdJU
 EZCwIjj5C8ivIK055dXziz4zthRSDDIiYmCtXurWFdxpQElUSZvuaQAEYYIQR3xRQ7Gs
 X2DNjcD/rZKgkDpOk2bOySi7ushW/RnN+UO/UsVO+l2FUaq+C9U81duKrZKAF5JKipse
 0QKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767829466; x=1768434266;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2xsSiA6IJiYIuZkZVeO4oiNpAiKFrrFc6oCDea+yLas=;
 b=S7I0VjFCqT11QNtPD2Wduc3zuYMwrY3tqG1IFiUS/pTSGCB5J5zelydc8IoUIfweG8
 EX5z9E3FqvxIMjzh4XzxfMq3A1tlZ4F7PjelBtv3Z1QqZ7EldqVtmh8rOp6vO+w/FePz
 KyFjawea4bKZQU/pMRTs6bRAMYpbZG7VLizkSeYAai2yduQY71FeAwn++KfCw3976W05
 wlYYqcvIFSPfiCUmhuEhSYFcUrO1FscTRD81uv8kRo+Fe3dyCY7NyHUVzd/w1Jf+oWly
 59dvuUvxdvO1n32pnCa4mslELOuZKTBIdrd1FQgRTqr3P7aWJ7ktwkd852l+4zZCU87s
 NUYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMG4d14/TjPgiE/oPUCrWBD4qokcY187WCd3u+i5cjmotoM0hiB/OscXQyipMrdCDORdWf2qqSmD0r@nongnu.org
X-Gm-Message-State: AOJu0YxkYVV0qaG2FjATr1vd7csnCVMSGsK3cx0FbmJyyBREWJKZl8rN
 QwLsfR7RM3DRIGuauXdzCqfnQTT4kI+pdIuX4VcT8xfk3eN0zlEHFLsmeaQNW5DZISvuXVf3K4Z
 JocR2ZdE=
X-Gm-Gg: AY/fxX5nioM991COlYxpHlNA4fBkbW2JroimLDt22SUwDJ0dWmXQgOuNn3gjzfXRkIr
 L52IVo1GrIq4hrtbj7OGMlMEoVxQwYkg/Y+OrQdTcGyzp88sKaL5uNr+F7/HDvg7b5A+O4RO+GL
 NhSooDz2JBKEuAdpPAdzSUMzeQVs3YWXooDOMM8nfoUc+3vZPgihPEE0Hn/Cy9t3KNoR9OA/SHC
 nFT0QFcMS382edY7YaEfvQuvM+2NAV4o2zXvYeq0GKwFkywBAuzmekCyhinI7M5zAWuy1p2DNju
 3EaoX/wQoQM+yssy4xQxqcZGt9rLtlSYAsGg8HlQsoAWjbT0vaQ9jSHkanlrdh30Qm+GsnugnXV
 q2lp2Lii0T/c3ID3mwlco0H/bs2IU4gbKpp2qc2ifvUswp7UEhIX8tVSnTeQrFr/k2N0igjTlZj
 h8KCCb1TCuG/ui99wYK1WlrfZER8eL0g==
X-Google-Smtp-Source: AGHT+IGnz9/XsliFcL8J3M5pgSKU4Q163xKpx+sE+r/5EAmtnZWDiWn2LzDfYUag2m4tDJdunt8Ghg==
X-Received: by 2002:a17:903:32c9:b0:296:2aed:4fab with SMTP id
 d9443c01a7336-2a3ee43595bmr36668585ad.23.1767829465738; 
 Wed, 07 Jan 2026 15:44:25 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2fe3sm60423105ad.59.2026.01.07.15.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 15:44:25 -0800 (PST)
Message-ID: <9a0b5cc2-fddc-4c9d-a310-4ff4bc785c7c@linaro.org>
Date: Thu, 8 Jan 2026 10:44:21 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/i386/tcg: remove register case from
 decode_modrm_address
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260107151400.273916-1-pbonzini@redhat.com>
 <20260107151400.273916-6-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260107151400.273916-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 1/8/26 02:14, Paolo Bonzini wrote:
> Unlike the older code in translate.c, mod=11b *is* filtered out earlier
> by decode_modrm.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index 243df7e3735..7b595607fa7 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -2024,12 +2024,6 @@ static AddressParts decode_modrm_address(CPUX86State *env, DisasContext *s,
>       rm = modrm & 7;
>       base = rm | REX_B(s);
>   
> -    if (mod == 3) {
> -        /* Normally filtered out earlier, but including this path
> -           simplifies multi-byte nop, as well as bndcl, bndcu, bndcn.  */
> -        goto done;
> -    }
> -

I can see that this is true, but one has to dig around to see that it's so.

There's enough prep code duplicated between decode_modrm and decode_modrm_address that I 
think it would be worthwhile to merge the two functions and simplify.

Also, not do things like

         switch (mod) {
...
         default:
         case 2:

where the default isn't reachable.


r~

