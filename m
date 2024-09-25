Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331B7CCF9E4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stU5X-0007Ag-Kj; Wed, 25 Sep 2024 11:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU5W-00071T-9Q
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:37:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU5U-0004HD-Ou
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727278670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5C+5Od2ouVlcj2zsMiyRnNuzmSt1N2kNzGrf070a4Cs=;
 b=hBRt2Fq+et4hjd0EyVsP8n5I9yS8Mmda097uiVzsctMAaTzw4ctw7sxn/wISJTYf6OLXsw
 gOmAUGFw4GhSt9RwM6lqcCDEdI01RgWivAkOZQtv71quUlKGU2gz3f3h2+W9ED5nK42EWj
 soYkQFGKWd/KLppiPO3IHI3BnY96D2U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-09_RjI1ANrqEMrOMwRvFuw-1; Wed, 25 Sep 2024 11:37:48 -0400
X-MC-Unique: 09_RjI1ANrqEMrOMwRvFuw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb0b0514bso57172205e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727278667; x=1727883467;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5C+5Od2ouVlcj2zsMiyRnNuzmSt1N2kNzGrf070a4Cs=;
 b=SdA+feRgkJsIOo1aPQ42aRnt/1WFRcPrTZwsYWTEyFlZ+yEkvoEE6ygBZyhZot0lgJ
 6zRuy8BaIki4rgRebL+n2hWHnSMg6XKsL3NYOoBSodH+dCtSZpNxDyILahNQ37cNBgsl
 XBPk/yPCxn4u9nLll2M7se9P4ftUb2ax90Ae86YcbkwhSWbYwWawQqs/QhBnnFuD6Vbq
 OjhQBWTtCsh8InqfPObXWyiqvpdDSpCwRhYQWg6KgBjTerYq7E7K35zhw7otBFhZ5h50
 u9PtqcedjyRJOZqfiT6J+yloeKXnjzeSeBw823SMNrijNVOkscOhHGGJMWN0Icw3aTDM
 lH7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLJPNxbA5rbvILP++ZRjn2eVuFBqtovYofyBi3m5oYaM47ZZW25Q/kK9I+lRcOAA91qSgAYelvTrqL@nongnu.org
X-Gm-Message-State: AOJu0Yw3efvkslFO7Dh5lQWn6ZLNRF/1FHmv8TxtZ9+vXa1yWZiXIAD6
 XXpOwXDVPNDzs3aJCRgqRrH3wW6/eEYrdOlFne0Kg5EXLclH8qTADqN6w5ROUAvsVrx1R1x/ala
 QP029If5Xe/pG0FhGUUla1vLNUpcd2XddYCs5qbitqtk0whrq5NxN
X-Received: by 2002:a05:600c:3584:b0:42c:af2a:dcf4 with SMTP id
 5b1f17b1804b1-42e96146559mr22140345e9.27.1727278667503; 
 Wed, 25 Sep 2024 08:37:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsc2jihOjoa1GVFqSbsmeyewLcmygreefngdMMm5SLAIHXhsqEE3z+2ACIkL88roVEHRS9Mg==
X-Received: by 2002:a05:600c:3584:b0:42c:af2a:dcf4 with SMTP id
 5b1f17b1804b1-42e96146559mr22140085e9.27.1727278667077; 
 Wed, 25 Sep 2024 08:37:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2a8a8fsm4282604f8f.15.2024.09.25.08.37.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 08:37:46 -0700 (PDT)
Message-ID: <549478eb-9816-4208-bd03-b9cdfb52121b@redhat.com>
Date: Wed, 25 Sep 2024 17:37:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/23] hw/ppc/e500: Add missing device tree properties to
 i2c controller node
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-6-shentey@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240923093016.66437-6-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/23/24 11:29, Bernhard Beschow wrote:
> When compiling a decompiled device tree blob created with dumpdtb, dtc complains
> with:
> 
>    /soc@e0000000/i2c@3000: incorrect #address-cells for I2C bus
>    /soc@e0000000/i2c@3000: incorrect #size-cells for I2C bus
> 
> Fix this by adding the missing device tree properties.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/ppc/e500.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 228287b457..e2a4f265a5 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -196,6 +196,8 @@ static void dt_i2c_create(void *fdt, const char *soc, const char *mpic,
>       qemu_fdt_setprop_cells(fdt, i2c, "cell-index", 0);
>       qemu_fdt_setprop_cells(fdt, i2c, "interrupts", irq0, 0x2);
>       qemu_fdt_setprop_phandle(fdt, i2c, "interrupt-parent", mpic);
> +    qemu_fdt_setprop_cell(fdt, i2c, "#size-cells", 0);
> +    qemu_fdt_setprop_cell(fdt, i2c, "#address-cells", 1);
>       qemu_fdt_setprop_string(fdt, "/aliases", alias, i2c);
>   
>       g_free(i2c);


