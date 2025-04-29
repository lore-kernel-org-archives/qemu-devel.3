Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A95C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ogs-0007eR-ST; Tue, 29 Apr 2025 13:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9ogc-0007DT-Fc
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:24:04 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9oga-0001cj-FW
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:24:02 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b0db0b6a677so6273622a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745947439; x=1746552239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cvMoAJS+2KJSxqqDURFqQVHEbL5B6ttMWi5mUtOdYqc=;
 b=nxbt9ECQCRyM+a9cMjKeOJIFTnJJoka6G50BoP9XaIkR6aU6HqA3Ca6TvDsQXzs+4E
 1GvfJqWQ9t8cfhVIZCl8sMYG2etyCKzgvHAUsXaeHWegvgSyVAXmoF2lDoUux+mLOI5a
 fB/VdPywbLPEjs+/KreSPI8TiVJf8U7ZLwYNrdf/sqgF73/4ElJLRymqOAP/kexonylb
 4IWoeW42rsDnjgHCzyZaPaw04ORuMe7C8gAIoPO0f5WsyrkaBXW3FTzicV5KHFK6iwUU
 21FkeeNYBcC15sK6PBhRxKQ5ZBMscfhy4pGN5x/L2F/hkqKbXpMXIg7rZENqIQUOfkVj
 Tpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745947439; x=1746552239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cvMoAJS+2KJSxqqDURFqQVHEbL5B6ttMWi5mUtOdYqc=;
 b=R6/3TuEtUJhwhjzdOaaLH8zkxprSg68myMYdvrz8Vc538ah5ICuLQujKYsJycqXny0
 NrH+G1FD13TIDgWj7UhWVnJwN5qGINDCSYbnzmQEp1aFjM2GnvL2rdUOd7QS1etoF66h
 4yjsNcwAKLm9VyirakC0p9qPVLrGiVmg/YgVl1ArYD83ukOyuNPGvFFlZNklRxqRSYnZ
 DBZmWE8DYNpcIg7HRvo2D0KDkQt/MPZPWqvRypGZz2RRNz/olBOJQZpQGRw4rKfeC2lg
 8RwsDc8p1GVsCg41M1MZYB/uy628w9GRwWS3eRgDsakPKaDSts5s1/uFZ8diLTWP7jFL
 wZCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFdYJpyhsyLWww5znvT5VkX0jx/FN5TfzZB/pReilUFUOaukyE71PMtBXQD4Ft9H2OrqEEbROkwtsg@nongnu.org
X-Gm-Message-State: AOJu0YyB+wbRiTQAdEJB9LduccsiMh3HN9QpcQgNpasDw7ZnPqJIBacj
 mXDhYS55iS6qJXSdPC2MXgBKVDueccNgPAz8LOGUhzRF4sWJIwJ+Nw7Fh9RNDkmkeDNrYw21d/k
 M
X-Gm-Gg: ASbGncuQ0P8dymN9q4oGwtqbrhdWyqqifSeOBWwW34bvVJgBarxJ8LSLW6p1kL57Lgu
 S2t4M9Yw/JyqmZjEiS+f/STs4z5FVJbVdoztQMttsLTK7OkoBZKa1jHhOfyOyXrdXE5i2QPKiMM
 CHcmOG+RO/j1Ucp7CUzOhhUGhq6wvhd5l43005ngK1jryQehFQ0MR3FQ/uz1nMK7d75vPinQqk/
 jEeK99nRB5ZefhdL+M8NlcCkEEYGEKWpR9/Y92HclspqRdwvMl5stCl8deYay89KPdz/ll80SNY
 1GopKQ3UmgaxdEdIT8NDwVhXcmt61fy/+5JxRP/+XmwVGQ/6mi1gr9PUH+VaX45ruw==
X-Google-Smtp-Source: AGHT+IG6xyCP2ZrdV2r+5ZZCM9dkQrh7IfDMMWSiU72jFOn8AW0fNJ+CD5MLCzo4Ja2bmtNmuz3L7w==
X-Received: by 2002:a17:90b:2fcb:b0:309:d115:b5f7 with SMTP id
 98e67ed59e1d1-30a23e2a68dmr5585418a91.24.1745947438777; 
 Tue, 29 Apr 2025 10:23:58 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7737c88sm9694077a91.1.2025.04.29.10.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 10:23:58 -0700 (PDT)
Message-ID: <2a3af577-7a82-4210-ae41-66841a47dead@ventanamicro.com>
Date: Tue, 29 Apr 2025 14:23:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] hw/riscv/virt: Use setprop_sized_cells for reset
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20250429061223.1457166-1-joel@jms.id.au>
 <20250429061223.1457166-10-joel@jms.id.au>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250429061223.1457166-10-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x534.google.com
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



On 4/29/25 3:12 AM, Joel Stanley wrote:
> The current device tree property uses two cells for the address (and for
> the size), but assumes the they are less than 32 bits by hard coding the
> high cell to zero.
> 
> Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
> and lower 32 bits across cells.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/virt.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index cf7e16cc6678..baa894b11aa6 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -932,8 +932,9 @@ static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
>           qemu_fdt_setprop_string_array(ms->fdt, name, "compatible",
>                                         (char **)&compat, ARRAY_SIZE(compat));
>       }
> -    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> -        0x0, s->memmap[VIRT_TEST].base, 0x0, s->memmap[VIRT_TEST].size);
> +    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> +                                 2, s->memmap[VIRT_TEST].base,
> +                                 2, s->memmap[VIRT_TEST].size);
>       qemu_fdt_setprop_cell(ms->fdt, name, "phandle", test_phandle);
>       test_phandle = qemu_fdt_get_phandle(ms->fdt, name);
>       g_free(name);


