Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311E8D41D65
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjJq-0003Iz-Re; Thu, 11 Dec 2025 11:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTjJp-0003IE-DE
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:15:05 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTjJn-0007k3-Tq
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:15:05 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3f0ec55ce57so137052fac.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765469702; x=1766074502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lWmx1SuovpB3ZuxFc8qaqvv/wEzaDCkbttm1kioPFy4=;
 b=whPJN7ZgzQvGJTqIFNLEqWIU9Jwh2Sl2r0EFaA49QlTH6UnGF6C/qRjET2vp6S+CCo
 UNfMDsgoH0Vijta4b97HzW5iCR1QhV6A5gDBCrlTfjnS54vfWvQ5yM25/5s71f5+frUK
 DKPH004r3w/6EVis04BVp/OFXHpFuSn/yEcpUJ2UJkn0lq8GoCiQ6B5NumIRibExFARm
 FHH5UhgNXrKUzlJ0n3I+Zox89+1ZGs4G9zOWW7SPqEv6VGedeUHC20t6kFMSaG0tXhgB
 Az4TwLvJPh6fF+H40UaNXtTuF7wuCdAgGzbbjaCgdwxZ1Mt6vj2pHXnQE/gOPr33Jscd
 TWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765469702; x=1766074502;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lWmx1SuovpB3ZuxFc8qaqvv/wEzaDCkbttm1kioPFy4=;
 b=Kp8j7j7Mg4dnBdPnxADMZ58h1aZrXL3dQUBooaNhTfUKlozD6VBdhPBuit2w04uhgT
 hWrysiOnMCYMQoGXJ9KYz50uojSCp3Gy/IdR4/g/o9KqASt3Bycqf8WqdD5b2eTTLrux
 dvq+tr6GYqj7hsGQkKUAMltvQNqxaZYZ2K9OD1SiULZ87RkL3JoRj0BMtrUxmv7Qr1vD
 CeoQVi7+M1OhoOXrQQovLsOD3/+BdciUMJ3CNL0+yYtaSxWpcIb8cPTnC918gqn4UqG1
 m7sN5suVcSiYZH8yUy8xqFe6XHWLcE/B632lMGEaAOWaLWd0FE+wlpCNTHZy/DyJQb2q
 hfXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsfnXTVrAkQQyV+T2yEBcBL0oj7x+qskZ7aeg7hE6ck3j7QgfWVtPyRuo4NgDIIhUfgoI4PTn2kte4@nongnu.org
X-Gm-Message-State: AOJu0Ywgi7xVYYXPX6nHW7bujS/X81DnIkJQqESKKxj2a8Abap0Qtb1J
 goWMbN7P3J2x6uvZPtkKzEfFOQXykfs6bOdj5V7MeWkXh7fr0srINj/3MkDNDlVruXY=
X-Gm-Gg: AY/fxX4lwAogtXRscN5ILgER2aUKx8tcDy8ZOjp25lmDV8ZUVsguAlXH9O+f6Rj89ah
 9OemVwXE+RTlDfjjR549pwErEJXVA0cKu0w8rxfKoN3T3v6GdE0XjWPmKo0v5vcfzI/QqXoAENn
 Y4zqLe9HqO2ao2Wi4+0aA0S6mrr9EpTXYwiqnDTJQHqPl0T0HxCG7IZ0jgXDhSF+bZeygDFbzeY
 kskEgaHVW2RPtuZ9G36p2ENXbthKbtURjDlEghJCg4Y0OQNghrvRoGmDmyFwsS3D/utjeHr4Zjc
 OY7fh7jRf9k+LzQhDNG044b4ZsY9VShQEDdnSEb/U+JUOp2T4LVR9rZyOnBKZ/QK49jdGl6l7FA
 /vRDY9lzedvzygOpVZCmVC2/CgxOA9Rd2FNbtKcbSl8yC8JD1ANMymN7lAwZlBYALt32kZpf1W/
 ADmNH7C77Ywe7ep1oq0PSmH0gvgNX4nCEPQr0ikX/vWAWDSY25bWoKBnt6CV5Tz8UT
X-Google-Smtp-Source: AGHT+IHl97s9+QIJUKsXY9lep1wWiyvgbfHcsrkKDIOj56kZDmGqfhqTG+I3gHLZRi4kIA86heVnsQ==
X-Received: by 2002:a05:6870:d69c:b0:3ec:4f31:42a with SMTP id
 586e51a60fabf-3f5bdbcbba2mr3622610fac.7.1765469702325; 
 Thu, 11 Dec 2025 08:15:02 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5d4e12e4fsm1946137fac.2.2025.12.11.08.15.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 08:15:02 -0800 (PST)
Message-ID: <9b0836f8-6937-427e-b6d2-efe83dd23597@linaro.org>
Date: Thu, 11 Dec 2025 10:15:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] target/i386/tcg: simplify effective address
 calculation
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-9-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210131653.852163-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

On 12/10/25 07:16, Paolo Bonzini wrote:
> Split gen_lea_v_seg_dest into three simple phases (extend from
> 16 bits, add, final extend), with optimization for known-zero bases
> to avoid back-to-back extensions.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 64 ++++++++++++-------------------------
>   1 file changed, 20 insertions(+), 44 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 0cb87d02012..2ab3c2ac663 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -627,54 +627,30 @@ static TCGv eip_cur_tl(DisasContext *s)
>   static void gen_lea_v_seg_dest(DisasContext *s, MemOp aflag, TCGv dest, TCGv a0,
>                                  int def_seg, int ovr_seg)
>   {
> -    switch (aflag) {
> -#ifdef TARGET_X86_64
> -    case MO_64:
> -        if (ovr_seg < 0) {
> -            tcg_gen_mov_tl(dest, a0);
> -            return;
> +    int easize;
> +    bool has_base;
> +
> +    if (ovr_seg < 0) {
> +        ovr_seg = def_seg;
> +    }
> +
> +    has_base = ovr_seg >= 0 && (ADDSEG(s) || ovr_seg >= R_FS);

I guess def_seg is -1 for LEA, so ovr_seg can still be -1.
I wonder if it would be clearer to avoid this duplication of segment earlier in decode?

Anyway, for here, maybe clearer as

     has_base = ovr_seg >= R_FS || (ovr_seg >= 0 && ADDSEG(s));

even though the end result is the same.

Nice cleanup.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

