Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBAFCF6AB6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 10:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdmob-0000Lq-W9; Thu, 08 Jan 2026 05:00:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdmoW-0000LJ-5p
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:00:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdmoT-0004g1-Gv
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767866416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QXLtBCTYSaQpgBaPW8Jq7zciX4McxnJpkA483ULdM+I=;
 b=gyQvnIZ5dMDnTQzR1EAZbo8VA+hs7rmt8969pUcdaTIsGUhCZf2atc8jBhY8wKZAfGfJPr
 Drlo3vJWtnE0DFM5ysSwl9GacgXcCSGGSCtVBtluJaxKqf7STu2U00WTGdRzl0afsonqgj
 PRbxOj+4JBxUBI8LEqwIP8ZKZ6LSvNA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-B3afab_jPZypkfKFbar6Fg-1; Thu, 08 Jan 2026 05:00:14 -0500
X-MC-Unique: B3afab_jPZypkfKFbar6Fg-1
X-Mimecast-MFC-AGG-ID: B3afab_jPZypkfKFbar6Fg_1767866413
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477bf8c1413so20723955e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 02:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767866413; x=1768471213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QXLtBCTYSaQpgBaPW8Jq7zciX4McxnJpkA483ULdM+I=;
 b=ALP3+bW3wfDQlvvPBcWdTY6StbKXeT/ZVLYitjcMUpHD3mnrDi2+TjHvyWP4iZXRwr
 4aulbXVNgNB41TmzLMS7mZ886p0GEdNmOk0+vqM5FFxEP5tIjRQgBEdC+GqejzYCyJob
 15+KDD253YTB0RaCOe/de1jZpjod/ySWdyLhFKOcxDmTjEZ0PW5Ng+pz68iWmRZ5bcYJ
 +TNyPm0mnWGs1fUPlW8ZxvgUYNhdW3MVrLDiE/ZMhv0XjKwI8uEvkMc/DToM4Drmcq0v
 PA2nuCLzn0h5GKS1pGC7P4tbBsruKpANrBYAmvRCKuAjXt938EcW0iQTFekxHQ0U4gJ4
 XlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767866413; x=1768471213;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QXLtBCTYSaQpgBaPW8Jq7zciX4McxnJpkA483ULdM+I=;
 b=Ak9vpQoiccSfLSGi8uDtKslTkIDWodMlmodww/rTJeqOgPNmXpwuiRQgRUq5UyZYvt
 1HnSXuKoqYpwhil0JBbFrEZRh1Fl03zr0UT7H2E0XBQ2oiIIuTydCzY5Hl65r5j+5ez+
 VLAjrxEmtpmy3LuEcNIpxkPRM75peOYo1jadHsjIxWZ94DkUy7F5Z/MlEzm/FjpovLVA
 mSvGDgZ6j2xDpL/EJRnyq2Gdd70WB08mhqvQGSfxdPUrtOvofXBig9cv633qXsEp1lkr
 MGTbCLQVQfpDQ5ctuufZfJSlFIr3JXs/dAt1cQJbS/i5l9urmr0hHYnTysmNsPwv/xN7
 LbKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTBr4g+eXBijZ5HQbpVhrG+6XTS0rcl9Mq3hZBdDZ99gro4cRznzh0BISC4Xm6cRwD0UhnGgj90mkR@nongnu.org
X-Gm-Message-State: AOJu0YwZX7KubfIrISYQfrA/DdIhzx/2myrKGexq25atYA24YLhcxv2/
 md7C7+umracL+l8DFGXGRdh1mCKBMYh9cRvHlDdosv1W13vK/Pw4yal1g3qz/iRvbBedWp3WJ7P
 BlegrREulJJqcFXXInywVl5o1uh+s/89xPrgeCDPuwF9XmetpLACBZFNE
X-Gm-Gg: AY/fxX6QZTUzAvu+xXWqxfWTchoPTC9BeMiEpjfTHzQO5Kn5P+sGqpFgtirkD9Qtc5Z
 5omS6MzXRNlfc6vfkJVF7L8/oQDn6ZsTtz1bK666Jcq2MAIi+QST/RWAbNbsN8GgctWOqqxFgmg
 991sRYNnNMpxtmjcHYi6zA79GWxicSlHUxrmDTLHn3WJDuOtISMYCdtAD59RC1K3ZGBhDXFQuRg
 JFJsumx7NqEuyFxItBbSGLPXYiJjnh4HuDVWmlOEREFfdiZ6zpZXPCFHT/JoZkawXDxX7jBXc3v
 GdVGlNCg06zAJgJR1dFiPylLc7nRBAp/Te3Qf80hoNPcBPzY/sYFTlja9an0JtlyV5/RhVDnGdX
 WWGEbWH8=
X-Received: by 2002:a05:6000:2085:b0:430:f1e8:ed86 with SMTP id
 ffacd0b85a97d-432c36280afmr6872780f8f.4.1767866413123; 
 Thu, 08 Jan 2026 02:00:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSqtRBunMUUjWcSZPhmpVqsDMegmROLY3bLTrYHOHconUaRp6s99bTc06SjYpSkhgxKu+K0g==
X-Received: by 2002:a05:6000:2085:b0:430:f1e8:ed86 with SMTP id
 ffacd0b85a97d-432c36280afmr6872736f8f.4.1767866412670; 
 Thu, 08 Jan 2026 02:00:12 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dadcfsm15408754f8f.3.2026.01.08.02.00.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 02:00:12 -0800 (PST)
Message-ID: <7280f6c9-413f-4886-81e4-7d4b374d6ea2@redhat.com>
Date: Thu, 8 Jan 2026 11:00:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 44/50] target/s390x: Drop CONFIG_ATOMIC64 tests
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-45-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260108053018.626690-45-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/01/2026 06.30, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/mem_helper.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
> index 9e5bd3ed07..cc0755c91f 100644
> --- a/target/s390x/tcg/mem_helper.c
> +++ b/target/s390x/tcg/mem_helper.c
> @@ -1814,9 +1814,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
>        */
>       if (parallel) {
>           uint32_t max = 2;
> -#ifdef CONFIG_ATOMIC64
>           max = 3;
> -#endif
>           if ((HAVE_CMPXCHG128 ? 0 : fc + 2 > max) ||
>               (HAVE_ATOMIC128_RW ? 0 : sc > max)) {
>               cpu_loop_exit_atomic(env_cpu(env), ra);
> @@ -1855,12 +1853,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
>               uint64_t ov;
>   
>               if (parallel) {
> -#ifdef CONFIG_ATOMIC64
>                   ov = cpu_atomic_cmpxchgq_be_mmu(env, a1, cv, nv, oi8, ra);
> -#else
> -                /* Note that we asserted !parallel above.  */
> -                g_assert_not_reached();
> -#endif
>               } else {
>                   ov = cpu_ldq_mmu(env, a1, oi8, ra);
>                   cpu_stq_mmu(env, a1, (ov == cv ? nv : ov), oi8, ra);

Reviewed-by: Thomas Huth <thuth@redhat.com>


