Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815E1CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0SY-0000Eg-W9; Tue, 09 Jun 2026 13:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX0SH-0000C1-GH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:41:41 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX0SD-00021f-9y
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:41:36 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-36b9ec98144so4867567a91.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781026889; x=1781631689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FVEzUDxbpk23CgYUInZXbTb/RsaFzxlKjWq+IPn+v3c=;
 b=dmN0g35zEvLB7W6k/thwf70AXcmrBrzZB6adBJ7NmAW5rrTamBbHBcYppH7pXLnSgr
 kzHd322ja+8E4TERqhHj/l5jO+1a5X1nx2sn11pZpRYCsp/cz0c0bXFAzCjK5OFtDZir
 FqQHHrAjxVs5OHLcm+NYoU9Pt2qpCqWOt0mpXVDWahMXh802Q9SSXZeXpSOW61NjGeW3
 buz2vG4daFs7DDuB69SybdWQVTzuj7CSX4vYiC75Yw3mLuGDeZq7q+e/Pd6c+wFoDBmw
 joHFtpgDTrOgOklQ3ABhSsHDfcduZddKdyZZBleQKSKiEvrtH9QKBlYjKAEhrrMhTQaA
 U+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781026889; x=1781631689;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FVEzUDxbpk23CgYUInZXbTb/RsaFzxlKjWq+IPn+v3c=;
 b=lQbLXtlQydyQzt7VpcOszQ7FyL7SeYe3d+2vI7P2xHbpsjJS28hU/qrqGiTwXgcnqb
 unHHVyO58nFRJXiDfnSqziF8ZdpbyIWrUMIgva+c8DHh4pHECboSpUsJ4LExQYPxOjj7
 cDFyzrFRDDYPqHtOhpMJng6QqMT86dgOpwrwSmURNP6T2WWP7WhXMuztXvqmavpsOq3u
 lhQepd0PwJCNd6WaPzt1D/aZrmI142yLBjoZ6PyIlX4WGaGfZSQbz+Lvkw9SGKRnhaJS
 dLlIlhdpAC26unPKzW0goTn06pQSXgqD2AMHojVQTpHQkGg4q76r8ifsHnZCq94bDrzR
 dQSg==
X-Gm-Message-State: AOJu0Ywk6iBxFvWeDtkwqhdMAwEUa1+rdTwyxGRgJDteh/mQ9YEwC7TR
 k7Y7zA3S+cAD24APDPsICsYGOxcaQ5LEAgCNGJN9GJLliXF3RAUoCj4emXaRw4ZqeNbus05U2RF
 38XFjtYw=
X-Gm-Gg: Acq92OHEtSxjEF1h90MM7Jc07JGaDuH1HqBapE2H7YYiWpSum+kchHnyFqjbJHQdLNa
 tFJ6Os3Hf92feFVJMm+0B3rDP5ELyxitEZKleJ62fG+nekDemfvl41BkrPBHShoKHfD3wWcljXt
 kor5IDTX+xS/MWC/YthLzCbuGuWPgsQj88G+fq4E9N9pVrKI7K+g0PbT9Q3jGN6QitdNSfmUPQ+
 sZvyFxIu+7k6r0ptCwsYbSv5YpCyEupQXiewghbRU4QoQ7cSnMUL6hUvY5Pwcc6T44MVtWopHQC
 rg2DVLz06VDgBK2owBnwFQgUHgERNxM15JLtbBITtdkKuJ6CaI3xxFmBLahaeYKxrwUUJhgylGT
 ohsKJog2P6QgUIcuIkLJGuOVoZvbK9xM5IzZldveIC4E80EU0efdi/gKzFupt0aE7iDoCIaL5WG
 MdZpb2iMI9o0Dsjzz+Zu+uDA0+txb0oeIZVU5uZzuynXY0kjc=
X-Received: by 2002:a17:90b:528b:b0:369:a359:b181 with SMTP id
 98e67ed59e1d1-37521779548mr4858953a91.23.1781026888982; 
 Tue, 09 Jun 2026 10:41:28 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37621852b31sm3241a91.6.2026.06.09.10.41.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 10:41:27 -0700 (PDT)
Message-ID: <94ce19de-b004-4f22-a681-8ffb62fd71af@linaro.org>
Date: Tue, 9 Jun 2026 10:41:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/arm: trigger timer recalc on HCR:(E2H|TGE)
 changes
To: qemu-devel@nongnu.org
References: <20260609140008.3206970-1-alex.bennee@linaro.org>
 <20260609140008.3206970-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260609140008.3206970-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 6/9/26 07:00, Alex Bennée wrote:
> Toggling the HCR state affects the offset calculated in
> gt_phys_raw_cnt_offset so we should trigger a re-calculation on its
> change.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/helper.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 22f5117ee54..4e7d1178fb8 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3799,6 +3799,11 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
>           (HCR_VM | HCR_PTW | HCR_DC | HCR_DCT | HCR_FWB | HCR_NV | HCR_NV1)) {
>           tlb_flush(CPU(cpu));
>       }
> +#ifndef CONFIG_USER_ONLY
> +    if ((env->cp15.hcr_el2 ^ value) & (HCR_E2H | HCR_TGE)) {
> +        gt_recalc_timer(cpu, GTIMER_PHYS);
> +    }
> +#endif
>       env->cp15.hcr_el2 = value;
>   
>       /*

The recalc must be after assigning to hcr_el2.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

