Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C990EDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4ju-00075r-0e; Tue, 10 Sep 2024 13:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so4jX-0005np-C2
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so4jV-00044y-0o
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725989570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rqOsnL77CbWV938DL6ZPgYq9h5A6u1mM6hjyDiIqaXg=;
 b=LNKprSszunrHSCQx03VmyungXM9KJSgCm6XdO+2iV5lPH2ugu58sqVooQY5c5TL2AyGFGE
 aEw40hw/9I0AyC2pehNrqM1uqIETaAOZ8IppMYROGYRV/YYstWMktLtvb7qB0AbM7Boxz4
 HkWCi+FXU7OUVlyf5iPZoaY29RDKbfI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-a7H2XcVeP6yOHgJXA6qVyg-1; Tue, 10 Sep 2024 13:32:48 -0400
X-MC-Unique: a7H2XcVeP6yOHgJXA6qVyg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-374c434b952so2727545f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725989567; x=1726594367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rqOsnL77CbWV938DL6ZPgYq9h5A6u1mM6hjyDiIqaXg=;
 b=qvAC0L/jb0oJ5zcZ6CLAmFO8HILaBlxjv4biknlKEJZlAzqFNFK/QQl1aA4v3lFh03
 1oqviwDQlsITXYkME8o1O7fKLPwleOxEbIPmSPiaPGxppGY/RbGGvgMcr1u385XRTl43
 hGKcBNo8yVDr05JzZJ5hQtz/T7qNJ07gTdHyGms6W6n+Xk0DUFS0ODtGeVW4EB6hjkv7
 MLBq8yci+8CdhWMp9JowVtWQRkauOfqP7o2Vp6QfjES59A9W/7zqnkU2nVzB5pwXTsNN
 dLK3Mvheh4xShKGb8COnVbOjImjKB7zeKC4+932opzswLksf/xzQGVtQ/EAQ8JKBATYi
 bakQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC+ztmxV3g4UEScxXxQh3Bk6b8pRTeKd+2pad614upwnXrpAzJC5iS2fLyHNGy9oUvZXCrgM0eG5dF@nongnu.org
X-Gm-Message-State: AOJu0YzunepiPf4ERag0eurypR4mUrSxQKSi3lxvh7zAN9NSoxmDWL4I
 nAv9Mqvh0tOHZShSlNcc+AhV8leXeEAUJT5Wtv17YIfm3qcJ8m4YeyxYqy23Kge4bafHoudyQdu
 0ZX21WJfqbxDNZ9pp7nD5EpA0u1aOX5bmxiYqiBdavFv4PfV+IAsF
X-Received: by 2002:a05:6000:1281:b0:371:8c9c:d97f with SMTP id
 ffacd0b85a97d-378895b7999mr9449083f8f.10.1725989567441; 
 Tue, 10 Sep 2024 10:32:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDDea/ZaXXBj6VDEJAvb1U4RGFMUj0rA5y5cb8ZIkmMARm+2HvlVZFxc0jZv+tYq0zKS05kA==
X-Received: by 2002:a05:6000:1281:b0:371:8c9c:d97f with SMTP id
 ffacd0b85a97d-378895b7999mr9449064f8f.10.1725989566639; 
 Tue, 10 Sep 2024 10:32:46 -0700 (PDT)
Received: from redhat.com ([31.187.78.63]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895665762sm9492768f8f.45.2024.09.10.10.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:32:45 -0700 (PDT)
Date: Tue, 10 Sep 2024 13:32:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Igor Mammedov <imammedo@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Ani Sinha <anisinha@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] acpi: ged: Add macro for acpi ged sleep register
Message-ID: <20240910133154-mutt-send-email-mst@kernel.org>
References: <20240906021943.150494-1-maobibo@loongson.cn>
 <20240906021943.150494-2-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906021943.150494-2-maobibo@loongson.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 06, 2024 at 10:19:42AM +0800, Bibo Mao wrote:
> Macro definition is added for acpi ged sleep register, so that ged
> emulation driver can use this, also it can be used in FDT table if
> ged is exposed with FDT table.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  hw/acpi/generic_event_device.c         | 6 +++---
>  include/hw/acpi/generic_event_device.h | 3 +++
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 15b4c3ebbf..10a338877c 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -201,9 +201,9 @@ static void ged_regs_write(void *opaque, hwaddr addr, uint64_t data,
>  
>      switch (addr) {
>      case ACPI_GED_REG_SLEEP_CTL:
> -        slp_typ = (data >> 2) & 0x07;
> -        slp_en  = (data >> 5) & 0x01;
> -        if (slp_en && slp_typ == 5) {
> +        slp_typ = (data & ACPI_GED_SLP_TYP_MASK) >> ACPI_GED_SLP_TYP_SHIFT;
> +        slp_en  = !!(data  & ACPI_GED_SLP_ENABLE);
> +        if (slp_en && slp_typ == ACPI_GED_SLP_TYP_S5) {
>              qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>          }
>          return;
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index 40af3550b5..526fea6efe 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -82,7 +82,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>  #define ACPI_GED_RESET_VALUE       0x42
>  
>  /* ACPI_GED_REG_SLEEP_CTL.SLP_TYP value for S5 (aka poweroff) */
> +#define ACPI_GED_SLP_TYP_SHIFT     0x02
>  #define ACPI_GED_SLP_TYP_S5        0x05
> +#define ACPI_GED_SLP_TYP_MASK      0x1C
> +#define ACPI_GED_SLP_ENABLE        0x20

The comment is wrong now, isn't it?
Pls document each value, copying name from spec verbatim.

>  
>  #define GED_DEVICE      "GED"
>  #define AML_GED_EVT_REG "EREG"
> -- 
> 2.39.3


