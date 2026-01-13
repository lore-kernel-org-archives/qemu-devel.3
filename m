Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23AAD29DDE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 07:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfYsc-0006zt-Nd; Tue, 13 Jan 2026 02:31:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfYsa-0006zD-6I
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:31:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfYsY-00072U-MI
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768289510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bMsgUrN+6siUwNWN9d/6WcgYfbmgKllwh/03b+LoBR0=;
 b=BooQ369ztnCfbFzsIYEFCvBt6gMqWkAPJ4QbMvh1g1Fj/6wyM8qI5dMTc6AIocyukJPHzE
 wnBMA94lEnX1AAPhdWEnk+TVQOr1+ysifrm/v7NuDl51UQ8by5K0K7WXik/lIrAGZHhlF/
 R8CUIll4cBRk/MGK6MDhmbcG5YZd3uM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-5bI3OArYPA2NLiWrg9oddQ-1; Tue, 13 Jan 2026 02:31:48 -0500
X-MC-Unique: 5bI3OArYPA2NLiWrg9oddQ-1
X-Mimecast-MFC-AGG-ID: 5bI3OArYPA2NLiWrg9oddQ_1768289507
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fb8d41acso4714839f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 23:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768289507; x=1768894307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=bMsgUrN+6siUwNWN9d/6WcgYfbmgKllwh/03b+LoBR0=;
 b=iuryuFb+XheKORxEaFYgKgRlMsMVh82cNsOI1bJhbWoTBsFw+Znl1GK9A7/2rMhPv9
 pwYzcfApi0vvlgRI538k9aR5tNDyKidAi2xfdPZ46wJ63UNqhQZTkrNRorpJYGOEOPD1
 hFwLIRkM0bpmmbB6rc5o+yL2lXGaC//3DZesCHMhTYfYm6K8ktbSnEfKud0XlCbnbKEi
 /TYn1cc3prDOhNUjV8zSqBzz6vOyN3exnooFYpgl1xp20wsjvDmmQci49VMfX6B3aNhH
 foZbNBN41hncbAbRV8+eYAi/8az1+jZCjnCVIr3Zh2jdWQlIfgQXPpQzQcjOlJUfyThT
 ZEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768289507; x=1768894307;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bMsgUrN+6siUwNWN9d/6WcgYfbmgKllwh/03b+LoBR0=;
 b=Gp/y/+pUJP3JQwxRT+9e24BAIR3RMtQ1FEjVHjtgwqXHw1zje/kuksfd5/C9XIu++m
 0hYaslce7ddEs+2DxbHGlNL4IfgzCHpC7KhJG+NYyXAh/JM1Uai+Lc1qBVQZyQQrZKNb
 1yqrQAEVVDvOhqxmd6u/aUXWMEcQroaAukYbOOeS8wBBm3KZDUqdWeggFgzHucx/7oDP
 VNA2UqhgNQKndGdc9w8dzUtnWBWBDkCNHpzeuL/ww5lsBCV7hRPmkZr/cN9mFNyepehY
 RwljNWqIviMXGcyIVJaWaZBWoQ22wKRrJRznuNkP07aTxI8MoSPjsno+JrswCFWMltw2
 pMMA==
X-Gm-Message-State: AOJu0Yy6jQGh5scRowV3hzos0iD9E/xHS4IK2vKRCiyf2/Dl5FvGV9bV
 ENEH0FqZARBIkvz2etRKuibzKsr49+YSCNQIHPc4tjSQpUm2WRS3Z/nt+eYgDIJ+leC0kC5dnuf
 wHyJy/fH6LQ18HhqokyatBuOxZPaWpHUIeWw73T95/bJqi5qF5bhT6+dWUqKsrqMG72YqQFuQID
 kwNOp+uBhiRpJpwjyCf/bFV/9Dzl7LsFrdXA==
X-Gm-Gg: AY/fxX4I4e+zcQNF/xk//G3/Ah1C+t02KSdsHJB+x76e0wOh+HdqNclAkxaC0YzeSVD
 BDyUlljbVATcMnXZOahi2FRN3qAWHyjrhNFuiy6I7EwUkuDi2PlGJAEJNVPFkmaA2Hwq7K8qBFo
 lxKqHTboDc7I7QyxrI+MH+Cg/7hACebH48iPFE2OSRMne010girlJ6zTp288xfazgv1yxlxWjXQ
 0y4wIHTycU5IjoBJQplzxrgCm2s+klXZHKPsM8ZyVKetjSIUDlwl898+Duh0YETPOJh6HHmNjmu
 R2MhH2KctQb2XwhO/jHQFyVQCpChxxi6Xs69J3CN45EF3v9yq/ExUIL4UVzFUt5AbdPMfWIM8MP
 JCH+dW1Ysv01vKos7kTUwffuUXLqScBaokq3hJ6QXa4vNazSo
X-Received: by 2002:a05:6000:208a:b0:431:67d:53b3 with SMTP id
 ffacd0b85a97d-432c376110emr25686785f8f.43.1768289506967; 
 Mon, 12 Jan 2026 23:31:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsnE3Qa037YYahyuu89rX2Y77FzpC93LittPIMdArpjQzfWwIDGqFIh9fhRpAF70eIME07KQ==
X-Received: by 2002:a05:6000:208a:b0:431:67d:53b3 with SMTP id
 ffacd0b85a97d-432c376110emr25686757f8f.43.1768289506507; 
 Mon, 12 Jan 2026 23:31:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacd1sm41875536f8f.4.2026.01.12.23.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 23:31:46 -0800 (PST)
Message-ID: <92edd0d0-2f8a-47a6-ac38-f92d0d534d2b@redhat.com>
Date: Tue, 13 Jan 2026 08:31:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/vof: Fix build error
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20260112124722.1029212-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260112124722.1029212-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/12/26 13:47, Cédric Le Goater wrote:
> Newer gcc compiler (version 16.0.0 20260103 (Red Hat 16.0.0-0) (GCC))
> detects an unused variable error:
> 
> ../hw/ppc/vof.c: In function ‘vof_dt_memory_available’:
> ../hw/ppc/vof.c:642:12: error: variable ‘n’ set but not used [-Werror=unused-but-set-variable=]
> 
> Remove 'n'.
> 
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/ppc/vof.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> index 5ecfc6891047eb63f498fe286d57f52a54c0a0db..fa7b73159a0b476dfc49326139d75cb87ca487c1 100644
> --- a/hw/ppc/vof.c
> +++ b/hw/ppc/vof.c
> @@ -639,7 +639,7 @@ static gint of_claimed_compare_func(gconstpointer a, gconstpointer b)
>   
>   static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
>   {
> -    int i, n, offset, proplen = 0, sc, ac;
> +    int i, offset, proplen = 0, sc, ac;
>       target_ulong mem0_end;
>       const uint8_t *mem0_reg;
>       g_autofree uint8_t *avail = NULL;
> @@ -677,7 +677,7 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
>       g_assert(claimed->len && (g_array_index(claimed, OfClaimed, 0).start == 0));
>   
>       avail = g_malloc0(sizeof(uint32_t) * (ac + sc) * claimed->len);
> -    for (i = 0, n = 0, availcur = avail; i < claimed->len; ++i) {
> +    for (i = 0, availcur = avail; i < claimed->len; ++i) {
>           OfClaimed c = g_array_index(claimed, OfClaimed, i);
>           uint64_t start, size;
>   
> @@ -705,7 +705,6 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
>   
>           if (size) {
>               trace_vof_avail(c.start + c.size, c.start + c.size + size, size);
> -            ++n;
>           }
>       }
>       _FDT((fdt_setprop(fdt, offset, "available", avail, availcur - avail)));

Applied to vfio-next.

Thanks,

C.


