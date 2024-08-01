Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E11CC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZT2S-0004e6-Id; Thu, 01 Aug 2024 06:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZT2Q-0004Vt-IC
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZT2P-000876-4F
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SS0JvxBpftBrWMjiMHR0qXWBTzfqk5LxDx47qwzP/Ag=;
 b=LgUx7vlY9arW7CeuVjOFH3dE9kwi/0voQWsPV1MFQ0fwk7gmPrnE+IX6CGu+w3V0OlPXpE
 2yVhMQ9zcSlBqVupPdx/JxKjqudLxTgmF468vVYoSEIhboyxxyNEKW9IpUW8vswB9AspAZ
 puBZqBNRxj2WyTPeBfaX2lAboCQ+xH0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-17PMHBinPzmvY-JCq5C2hQ-1; Thu, 01 Aug 2024 06:27:57 -0400
X-MC-Unique: 17PMHBinPzmvY-JCq5C2hQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7aa7e86b5eso615514666b.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508076; x=1723112876;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SS0JvxBpftBrWMjiMHR0qXWBTzfqk5LxDx47qwzP/Ag=;
 b=JX31yHT/lh2cxAUpMu6c1uUGJRdzmBW1RiCsMFOmP+CVVXiVOtWD72xn7dh5ING3nJ
 JkUqPr+DsbZyAQOC/kx5qa/o4KaPLRGDIklP2qoL9BWkGVShLMMNjJCzkR97MTRAUED0
 1/FOhIUegrETtXPbMbGNdXhbvaZepla2Sv7HcQ3ngA4eaR3UlXJYOaApJjaPXHK/7nQL
 gxXYsX8W05E/RpBtufIMXTVEPbJOHaA7g5dw82v/b85G4xOKLWEXy1OOAuBBgr4jAdrM
 1Cn3HOKhqMo5NH5V3XbSa8Mkv7aHabqGxyJ+PIkkHB94H1pYLSlRXJcOosjuc4JRjHJH
 EMGQ==
X-Gm-Message-State: AOJu0Yy6/JwadJOF6ckV5FXOIJ9AVyKg1I/G1CC4tckeIbRNvST0KArv
 kxApPQLi/QdgQh9VxlAx0D6LdZgJxyF3oEnz9wOlLVbg85XIgFvuFoeHONJ64VwdXQAM1tp5u3+
 J1bzDV4Tc09La0+Hi2tZ0GJbdX2ur5Me9rW/Mcqg5HWp9huPm/W9ZXGwMrnOI
X-Received: by 2002:a17:907:9706:b0:a77:cdaa:88a3 with SMTP id
 a640c23a62f3a-a7daf2cd370mr151606466b.27.1722508075771; 
 Thu, 01 Aug 2024 03:27:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGogT4lM7yD5T8s+xWRPlumUDyhaeCksOxUhdyLjnDpX5ifUjW92bpAvikxOMhrUU+PGmoHlw==
X-Received: by 2002:a17:907:9706:b0:a77:cdaa:88a3 with SMTP id
 a640c23a62f3a-a7daf2cd370mr151603066b.27.1722508075032; 
 Thu, 01 Aug 2024 03:27:55 -0700 (PDT)
Received: from redhat.com ([2.55.14.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acadbb263sm879961266b.222.2024.08.01.03.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:27:53 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:27:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH-for-9.1?] hw/pci/pci-hmp-cmds: Avoid displaying bogus
 size in 'info pci'
Message-ID: <20240801062632-mutt-send-email-mst@kernel.org>
References: <20240801100742.50312-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240801100742.50312-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

On Thu, Aug 01, 2024 at 12:07:42PM +0200, Philippe Mathieu-Daudé wrote:
> When BAR aren't configured, we get:
> 
>   (qemu) info pci
>     Bus  0, device   0, function 0:
>       Host bridge: PCI device dead:beef
>         ...
>         BAR4: 32 bit memory at 0xffffffffffffffff [0x00000ffe].
>         BAR5: I/O at 0xffffffffffffffff [0x0ffe].
> 
> Improve logging to not display bogus sizes:
> 
>       BAR4: 32 bit memory (not configured)
>       BAR5: I/O (not configured)
> 
> Remove trailing dot which is not used in other commands format.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/pci/pci-hmp-cmds.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
> index b09fce9377..8421c3f74a 100644
> --- a/hw/pci/pci-hmp-cmds.c
> +++ b/hw/pci/pci-hmp-cmds.c
> @@ -83,15 +83,25 @@ static void hmp_info_pci_device(Monitor *mon, const PciDeviceInfo *dev)
>          monitor_printf(mon, "      BAR%" PRId64 ": ", region->value->bar);
>  
>          if (!strcmp(region->value->type, "io")) {
> -            monitor_printf(mon, "I/O at 0x%04" PRIx64
> -                                " [0x%04" PRIx64 "].\n",
> -                           addr, addr + size - 1);
> +            if (addr != UINT64_MAX) {
> +                monitor_printf(mon, "I/O at 0x%04" PRIx64
> +                                    " [0x%04" PRIx64 "]\n",
> +                               addr, addr + size - 1);
> +            } else {
> +                monitor_printf(mon, "I/O (not configured)\n");
> +            }
>          } else {
> -            monitor_printf(mon, "%d bit%s memory at 0x%08" PRIx64
> -                               " [0x%08" PRIx64 "].\n",
> -                           region->value->mem_type_64 ? 64 : 32,
> -                           region->value->prefetch ? " prefetchable" : "",
> -                           addr, addr + size - 1);
> +            if (addr != UINT64_MAX) {
> +                monitor_printf(mon, "%d bit%s memory at 0x%08" PRIx64
> +                                   " [0x%08" PRIx64 "]\n",
> +                               region->value->mem_type_64 ? 64 : 32,
> +                               region->value->prefetch ? " prefetchable" : "",
> +                               addr, addr + size - 1);
> +            } else {
> +                monitor_printf(mon, "%d bit%s memory (not configured)\n",
> +                               region->value->mem_type_64 ? 64 : 32,
> +                               region->value->prefetch ? " prefetchable" : "");
> +            }
>          }
>      }

what makes bar unconfigured is that memory space is disabled,
not that it has a special value.


>  
> -- 
> 2.45.2


