Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CACCD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 13:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNWGQ-00050J-Fz; Thu, 14 May 2026 09:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wNWGN-0004yX-As
 for qemu-devel@nongnu.org; Thu, 14 May 2026 09:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wNWGJ-000373-Mh
 for qemu-devel@nongnu.org; Thu, 14 May 2026 09:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778765882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ln4iDiOj2zvIXjImWfdlCI+L3kaGOeWsl0+xvaJ5ecI=;
 b=dYzvXoamGCYCDNKMGCM7pJExpe5q1iWruPCSnwIoDRlp03lBjKf31zQCUkBcOr1deEEMlt
 JHAFwQfHtnvy+0LVVBdcSiHpYWnVNbaGKvnJ6V92/aW00ZhM8lewArSykPcYhG2qekYpBU
 heVF+GZKoyo74WJRTygB0B/W3b6pfVg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-PMkzC1yBPXaJkdnpGYOaXQ-1; Thu, 14 May 2026 09:38:00 -0400
X-MC-Unique: PMkzC1yBPXaJkdnpGYOaXQ-1
X-Mimecast-MFC-AGG-ID: PMkzC1yBPXaJkdnpGYOaXQ_1778765879
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43ff19e54beso5607462f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 06:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778765879; x=1779370679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ln4iDiOj2zvIXjImWfdlCI+L3kaGOeWsl0+xvaJ5ecI=;
 b=NagWuPcJ/l6c6yHuspbgoF/V9VVHvkrBN8zy57DGX2tVsjwzdkjFuv8E9IREZySK4v
 W3fhMr+POHK0Z1J6rS8vHYQ6i0BNvhjCIOh+HnrS5N5/P+X7dVK9jMqudJwVQCbSw6ya
 zC9s5e9c+sYS2Cm4Anip+O4+upeXmyY6q1VWTOrOS4F1Id/0JVmHL1x2L6qxp4IatPIn
 zxjGSQw4srZ3tqMuTyxxkGEWSphDqpeDZyXza3s8W+k8e5Hct+A1ASrSkPWmBztulmM1
 E8CsuVdCAR670ZBxtsHv/nJCMHuhJCvMvNtAnD+Englm2O8O9l3CPBIYnuAyXZzucgE8
 IVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778765879; x=1779370679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ln4iDiOj2zvIXjImWfdlCI+L3kaGOeWsl0+xvaJ5ecI=;
 b=ciJ1v+sLGG7xr3fiCbRwknCzdmSKMMNbBZDYHlmbnxm0d216sWkGCRD7jgYviKwsdc
 l83X5RU3oggI/9FpR544wG4OUMEWPM0lArHcHmgIKrZrFpG+BRG+82tt/nAxJisMtcvO
 cha1QHn6BycA/qQD4nkXhZgJeX2+vWYGsvg1OIl4J6O/FUmYD1tiU1dURywNaLw+w48X
 PsZJ4wS4/3HTIXezluYCVnDaOSQY5erMljRtIp3LrDHPAnVvsxmS31771HGC5b8DKGG4
 9ImCliajYiR1oh4JxdS0Gasxe4dDHkQOwlXXuGYNBCqr6teIwDAisn7xJPVTB474H4UA
 afBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/p1x7wfS0Wa5qcMDQz3zFv5/zX42nem4M1XZpswlPhpBhFJpe0+AeBAiQ1N62ViqbDtlIq5/UzYT4r@nongnu.org
X-Gm-Message-State: AOJu0Yx7iYogubOsnFGjt13E0EaVc8qqA25/TXPVW7SBlfsPxuvJB7bd
 8N1p2tkPuvF7E69GrmSZSPHw/ZS0r4CFeUIRurB6bud35Q9Skb7klGp9zZKxvlTDEON79ka9OFY
 24VCveGa04IDlhibiVEFE1TZgbuIlwkJi0tl5EHOKauLOp6e4fnytXSz7
X-Gm-Gg: Acq92OEXxMmXkjD0a1JkpFAlFzIk/kYGBkVRDm+4GMvjFGxAaRxKB1Iq0FMomtrSLpx
 PX/f9Dqx07+vteUVPmlCoRa4lfihXKeRf15nrPC+K9dzgkjJi0MWAnLQ2zyjw53o8TFWYtFSm11
 mNyEQfZWZVIoqEZZuaVHZrB3s+wDmE/MRAEn9GOu71DJ8aL1TYhs84hMMfgfvFHlFiA9dhsHCrd
 Ym2O+dyshi5mB2rh+WH5/RBNBdlnHPRjxoahl7KHvSlNdf2pABDFaALaB7B4cBp67Z7evYqFbuc
 A7dVTm6dxkUGxHXW+/WZnp+eCrS/XBfEJHxt4Vwl58do4/3WZkWFuG1s1325Smqf+Od5+Y+idz9
 /vIgf8A==
X-Received: by 2002:a05:600c:4e54:b0:489:1cd2:610a with SMTP id
 5b1f17b1804b1-48fc9a0dd7fmr117826915e9.9.1778765878974; 
 Thu, 14 May 2026 06:37:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4e54:b0:489:1cd2:610a with SMTP id
 5b1f17b1804b1-48fc9a0dd7fmr117826485e9.9.1778765878428; 
 Thu, 14 May 2026 06:37:58 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd6278b17sm21226095e9.0.2026.05.14.06.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:37:58 -0700 (PDT)
Date: Thu, 14 May 2026 15:37:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 4/4] tests: data: update x86 ACPI tables
Message-ID: <20260514153756.50cfdaa0@imammedo>
In-Reply-To: <20260508101901.930781-5-mark.caveayland@nutanix.com>
References: <20260508101901.930781-1-mark.caveayland@nutanix.com>
 <20260508101901.930781-5-mark.caveayland@nutanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri,  8 May 2026 11:17:43 +0100
Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:

> Update the x86 ACPI tables to reflect the IRQ descriptor changes for ISA serial
> ports:
> 
>      Device (COM1)
>      {
>          Name (_HID, EisaId ("PNP0501") /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
>          Name (_UID, One)  // _UID: Unique ID
>          Name (_STA, 0x0F)  // _STA: Status
>          Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>          {
>              IO (Decode16,
>                  0x03F8,             // Range Minimum
>                  0x03F8,             // Range Maximum
>                  0x00,               // Alignment
>                  0x08,               // Length
>                  )
> -            IRQNoFlags ()
> +            IRQ (Edge, ActiveHigh, Shared, )
>                  {4}
>          })
>      }
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h   |  47 ------------------
>  tests/data/acpi/x86/microvm/DSDT              | Bin 365 -> 366 bytes
>  tests/data/acpi/x86/microvm/DSDT.ioapic2      | Bin 365 -> 366 bytes
>  tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 2985 -> 2986 bytes
>  tests/data/acpi/x86/microvm/DSDT.rtc          | Bin 404 -> 405 bytes
>  tests/data/acpi/x86/microvm/DSDT.usb          | Bin 414 -> 415 bytes
>  tests/data/acpi/x86/pc/DSDT                   | Bin 8598 -> 8599 bytes
>  tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8509 -> 8510 bytes
>  tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9923 -> 9924 bytes
>  tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15469 -> 15470 bytes
>  tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9062 -> 9063 bytes
>  tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10252 -> 10253 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8549 -> 8550 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5087 -> 5088 bytes
>  tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8670 -> 8671 bytes
>  tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9957 -> 9958 bytes
>  tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8456 -> 8457 bytes
>  tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8604 -> 8605 bytes
>  tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12391 -> 12392 bytes
>  tests/data/acpi/x86/q35/DSDT                  | Bin 8427 -> 8428 bytes
>  tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8444 -> 8445 bytes
>  tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9752 -> 9753 bytes
>  .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12637 -> 12638 bytes
>  .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8706 -> 8707 bytes
>  tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8473 -> 8474 bytes
>  tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12040 -> 12041 bytes
>  tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12985 -> 12986 bytes
>  tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33842 -> 33843 bytes
>  tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8891 -> 8892 bytes
>  tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13218 -> 13219 bytes
>  tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10081 -> 10082 bytes
>  tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8502 -> 8503 bytes
>  tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8515 -> 8516 bytes
>  tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8444 -> 8445 bytes
>  tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9786 -> 9787 bytes
>  tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9557 -> 9558 bytes
>  tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13280 -> 13281 bytes
>  tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8289 -> 8290 bytes
>  tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8285 -> 8286 bytes
>  tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8433 -> 8434 bytes
>  tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8528 -> 8529 bytes
>  tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12985 -> 12986 bytes
>  tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33842 -> 33843 bytes
>  tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 9033 -> 9034 bytes
>  tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9059 -> 9060 bytes
>  tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18661 -> 18662 bytes
>  tests/data/acpi/x86/q35/DSDT.viot             | Bin 14684 -> 14685 bytes
>  tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35790 -> 35791 bytes
>  48 files changed, 47 deletions(-)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index cef44135bc..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,48 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/x86/pc/DSDT",
> -"tests/data/acpi/x86/pc/DSDT.bridge",
> -"tests/data/acpi/x86/pc/DSDT.ipmikcs",
> -"tests/data/acpi/x86/pc/DSDT.cphp",
> -"tests/data/acpi/x86/pc/DSDT.numamem",
> -"tests/data/acpi/x86/pc/DSDT.nohpet",
> -"tests/data/acpi/x86/pc/DSDT.memhp",
> -"tests/data/acpi/x86/pc/DSDT.dimmpxm",
> -"tests/data/acpi/x86/pc/DSDT.acpihmat",
> -"tests/data/acpi/x86/pc/DSDT.acpierst",
> -"tests/data/acpi/x86/pc/DSDT.roothp",
> -"tests/data/acpi/x86/pc/DSDT.hpbridge",
> -"tests/data/acpi/x86/pc/DSDT.hpbrroot",
> -"tests/data/acpi/x86/q35/DSDT",
> -"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
> -"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
> -"tests/data/acpi/x86/q35/DSDT.bridge",
> -"tests/data/acpi/x86/q35/DSDT.noacpihp",
> -"tests/data/acpi/x86/q35/DSDT.multi-bridge",
> -"tests/data/acpi/x86/q35/DSDT.ipmibt",
> -"tests/data/acpi/x86/q35/DSDT.cphp",
> -"tests/data/acpi/x86/q35/DSDT.numamem",
> -"tests/data/acpi/x86/q35/DSDT.nohpet",
> -"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
> -"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
> -"tests/data/acpi/x86/q35/DSDT.memhp",
> -"tests/data/acpi/x86/q35/DSDT.dimmpxm",
> -"tests/data/acpi/x86/q35/DSDT.acpihmat",
> -"tests/data/acpi/x86/q35/DSDT.mmio64",
> -"tests/data/acpi/x86/q35/DSDT.acpierst",
> -"tests/data/acpi/x86/q35/DSDT.applesmc",
> -"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
> -"tests/data/acpi/x86/q35/DSDT.ivrs",
> -"tests/data/acpi/x86/q35/DSDT.type4-count",
> -"tests/data/acpi/x86/q35/DSDT.core-count",
> -"tests/data/acpi/x86/q35/DSDT.core-count2",
> -"tests/data/acpi/x86/q35/DSDT.thread-count",
> -"tests/data/acpi/x86/q35/DSDT.thread-count2",
> -"tests/data/acpi/x86/q35/DSDT.viot",
> -"tests/data/acpi/x86/q35/DSDT.cxl",
> -"tests/data/acpi/x86/q35/DSDT.ipmismbus",
> -"tests/data/acpi/x86/q35/DSDT.xapic",
> -"tests/data/acpi/x86/microvm/DSDT",
> -"tests/data/acpi/x86/microvm/DSDT.usb",
> -"tests/data/acpi/x86/microvm/DSDT.rtc",
> -"tests/data/acpi/x86/microvm/DSDT.ioapic2",
> -"tests/data/acpi/x86/microvm/DSDT.pcie",
> diff --git a/tests/data/acpi/x86/microvm/DSDT b/tests/data/acpi/x86/microvm/DSDT
> index f477668f2ee80241e47b340ad4a30f5480df2049..475a59328c5e111c04d92cb971ac13b2a9e9c403 100644
> GIT binary patch
> delta 47
> zcmaFM^p1(kCD<h-kCB0a>DNRqX-1EUYUYf_6XO*51-ba#8GkVUU}oS@7GMyZ*!utg
> DFjow9
> 
> delta 46
> zcmaFI^p=UsCD<h-myv;iNpK>UG^6`OHFHLziE)a20$jZAj6axvFf(u{2{26TdjJ3k
> C0}FKk
> 
> diff --git a/tests/data/acpi/x86/microvm/DSDT.ioapic2 b/tests/data/acpi/x86/microvm/DSDT.ioapic2
> index e5924a49962e0cff4228bcfc77ebcf48cb4a2219..f4ef9bfcfaca231454aab43d6e29d18d95c6c7ff 100644
> GIT binary patch
> delta 47
> zcmaFM^p1(kCD<h-kCB0aY0E?|X-1EUYUYf_6XO*51-ba#8GkVUU}oS@7GMyZ*!utg
> DCs7P9
> 
> delta 46
> zcmaFI^p=UsCD<h-myv;i>GVV{X-4;nYUYea6XO*51h{zJ8GkVUU}oS@5@49v_W%GN
> CLkuqf
> 
> diff --git a/tests/data/acpi/x86/microvm/DSDT.pcie b/tests/data/acpi/x86/microvm/DSDT.pcie
> index b646a05551c1ed902413a462442346ce246f8675..54498ff6ed2cb09d3043311d1df1d043b52ab1a8 100644
> GIT binary patch
> delta 48
> zcmZ1}zDk_SCD<io6*mI|)5D2e(u^(>)yx@<C&nrA3v%(fGyY)y!OXy+EWjYRu~&v0
> E05LrarvLx|
> 
> delta 47
> zcmZ1_zEYgaCD<ioB{u^D(~pT<(u~d%)yx@<CdMi932^bcGyY)y!OXy+B*3t-Plg)+
> DDIN=_
> 
> diff --git a/tests/data/acpi/x86/microvm/DSDT.rtc b/tests/data/acpi/x86/microvm/DSDT.rtc
> index e375473b5f033d374dd2a64a9f814fd16c3e262f..5ea1b89d68bb18d14c4061b9b68b30e614bfaacd 100644
> GIT binary patch
> delta 48
> zcmbQjJe8TtCD<ioDkB2}(}{^((v1ES)yx@<C&nrA3v%(fGyY)y!OXy+EWjYRv6r0@
> E02^To2><{9  
> 
> delta 47
> zcmbQrJcXIdCD<io3L^sp)BTBD(u{r+)yx@<CdMi932^bcGyY)y!OXy+B*3t-kDU<!
> D6Tu4!
> 
> diff --git a/tests/data/acpi/x86/microvm/DSDT.usb b/tests/data/acpi/x86/microvm/DSDT.usb
> index d63fd84620a2689120b32262f964e6a098d71632..cb19cd1b29abd64e5dcce33b039e9c47eefc5fd7 100644
> GIT binary patch
> delta 48
> zcmbQoJfE4%CD<ioJ|hDI6W2s8X-3b9YUYf_6XO*51-ba#8GkVUU}oS@7GMzE*el2g
> E00zAZZ2$lO
> 
> delta 47
> zcmbQwJdc^nCD<io9wP$-lj1}!X-1EUYUYea6XO*51h{zJ8GkVUU}oS@5@6WaC&&l@
> D|FjBi
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
> index 6ea2d36d138daffb59a8636759078500adc58f24..056f4c5304660e9b2162d8707a0dbfd0ef5adec8 100644
> GIT binary patch
> delta 82
> zcmbQ{Jl&bgCD<iox*`Ju<Gqbs+lA!3p2frmJH-n)JqvL5G>C5E4mL1|=ZJT731WzD
> ma^HMkD29>Ic(RR%BEKLPpF86Z<{!)q9LfR=f}68Nw0Qv<Fc%5{  
> 
> delta 81
> zcmbR4Jk6QQCD<ionj!-O<M)kR+lAyjpT)!nJH-n)J_~U6G>C5E4mL1|=ZJT731WzD
> la@%}gD29>IXtIrnBA);kuRG%p<{!)q97+NVn{!08c>xKT7YYCX  
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
> index d8c173aa613f51b1c76ea7b9dee19e899cba240d..9b49234dd0b25d8eb9f9ed1b57d62acb9caa3da8 100644
> GIT binary patch
> delta 82
> zcmdn%w9kplCD<jzPLY9uQEemFb|E>(hcWTNPVoYs4+5M$4WgU4gAEMgIpQ5%f*7Kk
> m+&AABieY3lo@^tc$S=sn=g#<p`3Exthq3^J;O1<ROFRJP7#7|D
> 
> delta 81
> zcmdnzwAYEtCD<jzR*`{$(S9S>b|E>3hcWTNPVoXB4+5M$4WgU4gAEMgIpQ5%f*7Kk
> l+&14AieY3lnrtJY$S1(X>(2Ot`3Exthmrup<{XhrJOI{H7Ty2=  
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
> index ba363d6af76af728b7c88bbaf47f7e0ea3dcb41f..8541991737151a1e2f4dbb7c5ef49787d47d4832 100644
> GIT binary patch
> delta 82
> zcmX@?d&HN^CD<k8h#CU}<Lr%GPsHWCp2frmJH-n)JqvL5G>C5E4mL1|=ZJT731WzD
> ma^K7&5yQx6JULTRkzbID&z<oH^ABbQ4rKub!Ob%ywRr(Dofj|w
> 
> delta 81
> zcmX@&d)SxDCD<k8uo?pc<CcwFPsHUspT)!nJH-n)J_~U6G>C5E4mL1|=ZJT731WzD
> la@))!5yQx6G&xgJkxzh&*PZbP^ABbQ4kZDG%`+vnc>y947cc+-  
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
> index b68302363cb24181988d6e3dceb04a0946838d5e..c9f1741f5c3286373e0582f68ca5cca9e5ab2f45 100644
> GIT binary patch
> delta 83
> zcmaD`@vef)CD<h-&xV14@y$lA?LrEDy-YFj!A|i4t-VYE&YlL*P29l-2Jsy6jxIqA
> n(M|4~9}2}VG8#{|6H(+B<l=K@{K5Q#nSn!DfI)C^u80NzW)K(S
> 
> delta 82
> zcmaD?@wS4?CD<h-*M@<Ck#!^2b|Hn{UZ$A%V5fM2mR_a+XHSFZChlMZgLsa3N0%Um
> m=q9(#4~1eF8I2~}i74_3aPhh`{$T#W%)p@}z_2(^L<0a2uNLC~
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
> index 20688edf2da41146ece4faa4141517408a42870c..0812b021e25e186c69172311ef2062732db0ebfd 100644
> GIT binary patch
> delta 82
> zcmaFn_S}ujCD<h-U73M_F>oVSyNI0EvzYi`r+5LUX93Qh2GLF2!3GBL9Py4WK@8DN
> m?wi+(#4s`%Pv#L*<QL@Pb7%a){DYZ+Ls@`9aI>|THZK4L%oaTW
> 
> delta 81
> zcmaFv_RNjTCD<h-O__m#F>51NyNI0UvzYi`r+5L!X93Qh2GLF2!3GBL9Py4WK@8DN
> lZkyMO#4s`%P393(<P+fHb!Ys+{DYZ+LrH*PvyGTGF97w$7Cis}
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
> index 8d4be05d2c71ca8de6d732d3e48e0e323143160c..8247d79552d1d3af270c331c4d130b3591067202 100644
> GIT binary patch
> delta 95
> zcmeAP=ndd<33dtL)nH&?{I`)ySCZ4~SxkJeQ@nuFWCuwRM)%F3k}-^i#?Jn}h8*!8
> yo-RC&7g!lN;zK=MfMjrpBNsnMymL^npdc5YJL3=LAIuCK$^s06n;%MP^8x^{8yBVk
> 
> delta 75
> zcmeAT=n3F*33dtL(O_U;6yM0DE6M5kEG9nKDPF*FvV)`uqub_C$rwg{BWHhKLymY4
> fPZu7?3#^Qjd!!^de=z@GX5df~VA%XfN}Cq|+i4SC
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
> index 2b5b885b862a2fe8bc4a24446400dccf685dab85..41a4cc2a1a498bd810718b848651ff866ad7bb00 100644
> GIT binary patch
> delta 82
> zcmaFr^vsFNCD<h-O_70tQD`IAb|E>>$1(B2PVoYcj{}@N4WgU4gAEMgIpQ5%f*7Kk
> m+&AABieY3lo@^tc$S=sn=g#<p`3Exthq3^J;O1<RUpxQ@I2UgK
> 
> delta 81
> zcmaFn^wf#VCD<h-Rgr;#QF|lTb|E>B$1(B2PVoW`j{}@N4WgU4gAEMgIpQ5%f*7Kk
> l+&14AieY3lnrtJY$S1(X>(2Ot`3Exthmrup<{Xh<JOK9l7jFOn  
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.hpbrroot b/tests/data/acpi/x86/pc/DSDT.hpbrroot
> index cc6f26a3f8fe85f34a8acb5432bab3cf4d3ab1f6..2573df7906b4315af7e925de55dd7b93cf75a9a4 100644
> GIT binary patch
> delta 82
> zcmcbw{y?3}CD<k8fiMFDW8g+E9zi)TotXGwr+5J;od9P~gXkviU;~4Aj(A6xAcp8B
> m_su4PF^r7HlP3x(@(XhDxikJ?{=v+^p)9~4xcPvPJR<;?;uO>X
> 
> delta 81
> zcmaE$eqWu-CD<k8zAys=W7bA49zi)zotXGwr+5KJod9P~gXkviU;~4Aj(A6xAcp8B
> lx6LMkF^r5xlP3x(@(FP9x-<S@{=v+^p(Mbt`Jj+IBLIoK6x09!
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
> index 052a84e294eee4ecef9a36341493f841caf887a5..117488ca8ac05841815d70bd0104180f0d814cd0 100644
> GIT binary patch
> delta 82
> zcmV-Y0ImPtL*GLRL{mgm-yr}10a~#Nw-O#g>s((`LSGO{>QF;TFk6BPQ!p@J2wy=&
> oQUF_mPqW_=qyYgllY|r@4-pCuM*;W)_yYh4BM<-)v$GT{4NMIfM*si-
> 
> delta 81
> zcmV-X0IvVvL*7FQL{mgm-XQ=00duhmw-O#f>s((`LSGO`>QF;TFk6BPQ!p@J2wy=&
> nQUF_mPP5+<qyYgklY|r@4iE|rM*;W)_yYh4A`k$xv=l21I)NBR
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
> index 7efc12a46cb87c0684b7d880b2cc94d302744e03..ffa0d1312a6d5edb3afaab57547af60e1229c628 100644
> GIT binary patch
> delta 82
> zcmaFr`^=ZiCD<k8nHmEF<ED*VY!Y%_&tl?(o#F+Yo&`928bmj72OAi~bHqEk1TjQ6
> mxo_5!h+$+jp4=^|$S=sn=g#<p`3Exthq3^J;O1SD+PnZKrx!K=
> 
> delta 81
> zcmaFn`_z}qCD<k8sTu<V<LQlDY!Y&w&tl?(o#F)?p9MI38bmj72OAi~bHqEk1TjQ6
> lxoy^yh+$+jn%pg^$S1(X>(2Ot`3Exthmrup=G~IoyZ{$C7d8L@  
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
> index 7eedfcd64ebd0193744864b4f6cbead35c7c3ab2..fd5cabdc3b412faff60305af9d049bbb645f70ef 100644
> GIT binary patch
> delta 82
> zcmeBh>U83A33dtLRAgXaT)vS@Q%KJ1SxkJeQ@nuFvjAsLgXkviU;~4Aj(A6xAcp8B  
> m_sxMqF^r7Hlh+9=@(XhDxikJ?{=v+^p)9~4xcRQIHZK6MsTJ)2
> 
> delta 81
> zcmeBl>Tu$633dtLP-I|WJg|{VQ%KJ9SxkJeQ@nuVvjAsLgXkviU;~4Aj(A6xAcp8B  
> lx6Oe<F^r5xlh+9=@(FP9x-<S@{=v+^p(Mbt`JS*gF94yS73}~3
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
> index 910b4952a0757025cfed1c60416d16054e70846f..0ea31f7c108463dce0d5fd89b63edc0c39cd0f01 100644
> GIT binary patch
> delta 95
> zcmbQ^JlC1aCD<iot|9{iW7bBly+WK`&tl?(o#F+YCSMQ|VRYa8R49hg(Ae4E*N`LL
> y!_$Sw@d7I&M|`NK3y=&BapdCXh<6SO78K;-b7%a){DYZ+Ls@`9aC4!EHZK4i4j9G&
> 
> delta 75
> zcmV-R0JQ&|L!3hjL{mgmoFM=J0fVs$y%GsY=3HM>LSGO;lh6_r0Y<as5?lcfGDA;I
> hF$iBsNkj}m&;<dL926J{_yhO@00<%w0JCxwD-B#;6$k(T
> 
> diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
> index 45d3dbe1b69143a956b4f829913ca47f07134741..a872aa6f49d8cb7b67f1c130c9deedbbb6af1206 100644
> GIT binary patch
> delta 84
> zcmaE!@FIcBCD<h-!+?Q-F>52&b|HnP^Nca^!A|i4o#z+>oIMSqo4A7w4B|QB9bJML
> oqMO_|KNN~#WHg>^C!)wN$i?T*_=EWeGXsaR0E6J>T#;YW0AE!Yi2wiq  
> 
> delta 83
> zcmaEn@H~ObCD<h--GG6Cv3Vocb|Hnv^Nca^!A|i49p@MWoIMSqo4A7w4B|QB9bJML
> nqMO_{KNN~#WHg#=C!)wFz{Ts%_=EWeGXsZ`0K?`ykzdjPPD>bx  
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT b/tests/data/acpi/x86/q35/DSDT
> index 377e880175f6f11101548c0c64da61b5aee00bd9..a8c861548911887910e12e072bdb3e4cb6567f31 100644
> GIT binary patch
> delta 65
> zcmaFu_{NdTCD<k8jRFG$<C=|J^75Q+(lPPDPVoYMla1sZ7`-PK%YR@ro}8kf$S=sn
> V=g#<p`3Exthq3^J;N-~)5del35)A+V
> 
> delta 64
> zcmaFk_}Y=nCD<k8wE_bJ<I#;=^75Rn(lPPDPVoZ1la1sZ7`-MJ%YR@rnw+Ab$S1(X
> U>(2Ot`3Exthmrup<S7af0C`ao4FCWD  
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.acpierst b/tests/data/acpi/x86/q35/DSDT.acpierst
> index 026bfdfebf66c1803f158ac8c115eb5f49b5cb19..9e37e5c22777af3cbd49e9ce78e0d06507232339 100644
> GIT binary patch
> delta 65
> zcmez4_}7ukCD<k8uL1)Dqt8Yzd3jEEnV9%sr+5MX$wu;ljNX%5<UcSPPcBtZ<QL@P
> Vb7%a){DYZ+Ls@`9aPks`2mpnI5+?uv
> 
> delta 64
> zcmezC_{WjUCD<k8j{*Y&W9mjOd3jDZnV9%sr+5Ls$wu;lj9!yl<UcSPO)gbX<P+fH
> Ub!Ys+{DYZ+LrH*P@=}Ee0C=_%CjbBd
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat b/tests/data/acpi/x86/q35/DSDT.acpihmat
> index f1b8483d8da21dd57f3e5e7a1e4eb787df2c38ac..0b10e246a71b3f68dfed557ae281ee196691276b 100644
> GIT binary patch
> delta 65
> zcmbQ?Gt-C5CD<iIQjLLuF=Hc_j|!)obWD7(Q@nuR<aiYaM(@cBR6Z~oPoAi%$S=sn
> V=g#<p`3Exthq3^J;N%0U5dcDQ5oQ1Y
> 
> delta 64
> zcmbQ~GsB0=CD<iILXClev2i1pj|!)&bWD7(Q@nuh<aiYaMz6^WR6Z~oO`fQ#$S1(X
> U>(2Ot`3Exthmrup<b$da05*jYW&i*H  
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
> index a7731403f460a235bf705770a1547dafeee069ab..8f7f626906ee76e5d077e2709d249b19cb2675d7 100644
> GIT binary patch
> delta 66
> zcmcbcbT5g^CD<h-&X9qDQD!68I$cgDqnP+$r+5Lc%?EYYFfw{i&eQ+EXgoRIK#^aN
> Wi_e|$2lEeR1`cHb2EoaF2Im2+u@jU4
> 
> delta 65
> zcmcbYbT^61CD<h-){udL(R3r%I$cgjqnP+$r+5L+%?EYYFfw{g&eQ+EXf!$AK#@;?
> Vi`Sj;2lEeR1`Z_whROW~=K-Gm6O;e|
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
> index cb4995de7e33cd9f2d134ec96651d217873d6944..7a19fb922d841ae8b004b1586de53d865cb83b03 100644
> GIT binary patch
> delta 65
> zcmZp2X?Edq33dr#R$^daRNBa8roibY9TOky6ffX6*;B!R(R*^2!Usm<$<>OA{DNG3
> V?u<W}e=sv}C<`zMPF|%L0RR#65J&(3
> 
> delta 64
> zcmZp6X>#Fm33dr#Qet3WwBE>Nroibc9TOky6ffXA*;B!R(Q9&-!Usm9$<>OAd;(m&  
> U?u<W}e=sv}C<!o3Uac4b00#>YNB{r;
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.applesmc b/tests/data/acpi/x86/q35/DSDT.applesmc
> index 92c8fdb6cbb8ae8bdf5ede9679eea92486eaf372..c33430f4ffc646eb2294c65a4eb269d9354c4f50 100644
> GIT binary patch
> delta 94
> zcmbQ~G|P$0CD<iIN|AwqarQ<od3jD3xtRE1r+5LM$wu-HjGmi|<>eR+jh+2{4LRaH
> xJY9GkFR(Il#D{vi0LkDGM=pMjc;}#CK|wA)cg7#gKbRRflm!?BCm&RZ002W%7Ht3k
> 
> delta 74
> zcmbQ`G}DR8CD<iIQjvjyamz+7d3jD}xtRE1r+5MH$wu-Hj2@ed<>eUpjhy{`4LRaH
> eJY9GkFR(IB&QXxy{K5Q#nSnz|fMN0>g$Mw{l@kj9  
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.bridge b/tests/data/acpi/x86/q35/DSDT.bridge
> index 957b3ad90c787616eac212865bce0a19a5ac1e6e..5185e0636be78abb0ffbcbe7cd06eac56ce60493 100644
> GIT binary patch
> delta 66
> zcmeB(>x|=a33dtL)MsE|Jid`jUY^tEYfOBwQ@nu7W+VA$yo}zHC3QbA8c*iZQ{)%q  
> W;&W&G!Tf`nfkRn<L2$CA-gy9Yr4j@H
> 
> delta 65
> zcmeB->xkoW33dtL&}U#^e6W#AUY^tYYfOBwQ@nulW+VA$yo_FxC3QbA8cpWXQ{)ri
> V;&o^I!Tf`nfkR1vVX~Fpc>riC5(EGM  
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.core-count b/tests/data/acpi/x86/q35/DSDT.core-count
> index 50ca91b065d9a2ba95f97d01856865f0e7c615f6..39f481a88419fbb95231eda19846f6064e09d96b 100644
> GIT binary patch
> delta 92
> zcmdm)x+|5-CD<iomk|R4qsm6Ew+5VU(lPPDPVoYMlMEdgy(c>welRq4_V+d9i1+Yx
> v;c>jc%E%EP>gfU`gF_s-_&MU8gMtMGx%k`}e=z@GX5dg3U=W;~XcPee%_<l%  
> 
> delta 72
> zcmdm$x-*r_CD<iorx61KqwPknw+5W9(lPPDPVoZ1lMEdgy(T*ve&9E9_V+d9i1+Yx
> c;c>jc$~c+FNP_bR^ABbQ4kZDG$w@{L03N6mfdBvi  
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.core-count2 b/tests/data/acpi/x86/q35/DSDT.core-count2
> index f460be2bf74ae512db8f24418b42e8cf2a56202d..354132347ba51404e9ba2a64aa0b0b2aa9977ef8 100644
> GIT binary patch
> delta 67
> zcmdng!L+%9iOVI}CB(Refq}7fBUf4zr<-(4e6UlzfZycGCI?3E$-A09Fd9!@-K@wj
> X$i?T*_=EWeGXsaR0E6J<Tg?#w%=;Ac
> 
> delta 66
> zcmdno!L+G^iOVI}CB&$Ofq}7aBUf4zr>k^Ke6UlzfbZnWCI?2Z$-A09Fd9u>-K@wb  
> Wz{Ts%_=EWeGXsZ`0K??l%@F{-`xNs4
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.cphp b/tests/data/acpi/x86/q35/DSDT.cphp
> index 7c87d41d03fcfd2b5b82f2581f16de6bc0bb10bf..d059d32caf9f46026f06f170e4c8ea59aca101b3 100644
> GIT binary patch
> delta 65
> zcmdn(y2q8vCD<ioj}ij|qx?p$_X?bD(lPPDPVoYMlbIA97`-PuD}G=!o@}C|$S=sn
> V=g#<p`3Exthq3^J;N)bb2moN<5fcCa
> 
> delta 64
> zcmdnvy4#h@CD<iow-N&bqs2z9_X?b@(lPPDPVoZ1lbIA97`-MtD}G=!nrxz^$S1(X
> U>(2Ot`3Exthmrup<P@a{095A@6951J  
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
> index da86b25f51b550ab20771111cb0a2bc49e713186..89bf38c3708d0ff1a27002fdc36bcfe51283c774 100644
> GIT binary patch
> delta 66
> zcmZ3KzBrxBCD<iou`vS!<NJ+VTMW58WMkrko#F)?WGA06Ol0()tY!3p(Ri}7u_C`9
> W7oR)h59S}t3>?Y=41$xrj3WTBeiF6-  
> 
> delta 65
> zcmZ3Sz9^l`CD<iokud`U<Ijy;TMW6}Wn<!lo#F-jWhS36Ol0($tY!3p(P*-?u_B)U
> V7q2_x59S}t3>-=V43oW$BLJcw61D&U  
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.dimmpxm b/tests/data/acpi/x86/q35/DSDT.dimmpxm
> index a2d812e5a23a3ce7739789246b342e703f8c96c0..1dfd971925a52e1b0281ed4e0f819bc73edac81e 100644
> GIT binary patch
> delta 65
> zcmV-H0KWg>PU21qL{mgmVkZCq0nD)ql_d#A8(d#gLSGP0lc*&?0ZWtVCGY_=liDUB
> X4-pCuM*;W)_yYh4BM<-)lL;qSu;~*W
> 
> delta 64
> zcmV-G0Kfm@PT@`pL{mgmVJ83p0p+m@l_d#98(d#gLSGO~lc*&?0ZNnUCGY_<liDUB
> W4iE|rM*;W)_yYh4A`k$R3MW{ikrN#N
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.ipmibt b/tests/data/acpi/x86/q35/DSDT.ipmibt
> index 43ac1bd693d1b3f67d2a9e89ccaf8a56656df22d..4d64e1b90bb7bb1446a3c24ed838be7595a7e29c 100644
> GIT binary patch
> delta 66
> zcmdnywB3ozCD<jzT#<o+@%~0Gd3jDpg_!tYr+5L+$wu-HjBcBY<*gYRjVG^HP~;cn
> W;&W&G!Tf`nfkRn<L2&Xtg$Mvpo)H`X
> 
> delta 65
> zcmdn)w9SdjCD<jzOp$?s@yA9kd3jC;g_!tYr+5L6$wu-HjINuD<*gYRjV7;GP~;Qf
> V;&o^I!Tf`nfkR1vVe);22mnPY5gY&j
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.ipmismbus b/tests/data/acpi/x86/q35/DSDT.ipmismbus
> index 1b998820d46e522b3129e42a867ed691c1f83e8f..6b23a3ea38c5cf17ba35d4601265d7b1120c6c41 100644
> GIT binary patch
> delta 65
> zcmX@?bi|3vCD<jzMUjDlF<>K?yga9$LQH(HQ@nuNWFvV8M(@eR@*fzDC#NVV@(XhD
> VxikJ?{=v+^p)9~4IC-+d1^_)P5g7mg
> 
> delta 64
> zcmX@&bl8c@CD<jzS&@N(F>@oAyga9`LQH(HQ@nudWFvV8Mz6`m@*fzDCZ{MU@(FP9
> Ux-<S@{=v+^p(MaCd5XdY05P%=82|tP
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
> index 026bfdfebf66c1803f158ac8c115eb5f49b5cb19..9e37e5c22777af3cbd49e9ce78e0d06507232339 100644
> GIT binary patch
> delta 65
> zcmez4_}7ukCD<k8uL1)Dqt8Yzd3jEEnV9%sr+5MX$wu;ljNX%5<UcSPPcBtZ<QL@P
> Vb7%a){DYZ+Ls@`9aPks`2mpnI5+?uv
> 
> delta 64
> zcmezC_{WjUCD<k8j{*Y&W9mjOd3jDZnV9%sr+5Ls$wu;lj9!yl<UcSPO)gbX<P+fH
> Ub!Ys+{DYZ+LrH*P@=}Ee0C=_%CjbBd
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.memhp b/tests/data/acpi/x86/q35/DSDT.memhp
> index 7346125d23fb3174c0ce678a2cdf2fdc77c4a9fa..2a463e3e130190bab1246f100a590b1cbd2aae98 100644
> GIT binary patch
> delta 65
> zcmdnxv)hNuCD<jzT8)8$v3?_0o(iX%bWD7(Q@nuR<VF<-M(@doR6Z~oPu{Gm$S=sn
> V=g#<p`3Exthq3^J;N(ZD5dd+@5{&==
> 
> delta 63
> zcmV-F0KosdOu9@8L{mgmIwk-B0hqB0ZX^js8(d#gLSGO~lYt~a0ZNm?B=7+;ld~lu
> Vlb|I93HSr}0{{pj5CD_oC0J)56LtUq
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.mmio64 b/tests/data/acpi/x86/q35/DSDT.mmio64
> index 15a291dbfb62e6ceb0249e02eb25b319744e351f..8e0b75edb910133b674ad43d5294dc8cc4f3d4cd 100644
> GIT binary patch
> delta 65
> zcmccWb<K;*CD<h-OqGFw(P1N3g)*nROiX;RQ@nux<Zk6aM(@dYl|L{VPd=xj$S=sn
> V=g#<p`3Exthq3^J;N-t55deax6Al0X
> 
> delta 64
> zcmccSb=8Z@CD<h-RF#2&F>)hUg)*m`OiX;RQ@nuR<Zk6aMz6_tl|L{VO+Kfh$S1(X
> U>(2Ot`3Exthmrup<bNs=0Ci6j4gdfE  
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.multi-bridge b/tests/data/acpi/x86/q35/DSDT.multi-bridge
> index 889a9040d950dd08980408d57f1037a5fc20c961..988d6f2b40d68f7a3d5e5b099cba4d7fb427126b 100644
> GIT binary patch
> delta 96
> zcmaEm{xF@(CD<k8p)msk<H3zw^733QI*c*#!A|i4-J6Z&eFYi4CpQ{=Ff?}d_ci2*
> z_waP#alF9F$Ppjv=>jB!LmavIIpUpzf&~S+_}m$PF#lj?;7}G|5Zt`b(4GkZXzdx^  
> 
> delta 76
> zcmaEu{ve&pCD<k8fiVLE<E@Qc^735GI*c*#!A|i4U7L;NeFYi4CN~;<;5Tyi_ci2*
> g_waP#alF9FIN8Tgg7XLS4`v1qB>{%biwy0V0H1mmZ2$lO  
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.noacpihp b/tests/data/acpi/x86/q35/DSDT.noacpihp
> index 780616774f97a2d7305faf9e9a9d12afeb0e2fa2..fbf5a94ca16f761b6eabd665258042888a9b8ea7 100644
> GIT binary patch
> delta 66
> zcmaFp@W_G7CD<h-Nr8cZv2P<+i7cm!UQB$jQ@nuB=62aUMn><+-{d|p8c%*MugEXR
> W#pllWgZT$D1BbEzgWzN_1#bYSl@iSW
> 
> delta 65
> zcmaFl@X&$FCD<h-QGtPhars8B5?M}Xy_oo5r+5MH&F!*zjEr8BzsY@IG@ATeUXf3L
> Vi`Sj;2lEeR1`Z_whRNaz-T;}L63qYr
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.nohpet b/tests/data/acpi/x86/q35/DSDT.nohpet
> index 0f862ab2938e0e11aa8335630fad389095b37edd..d158841273146883c1e15be331bd6f9d53d78e9e 100644
> GIT binary patch
> delta 65
> zcmccXaL<9uCD<h-PJw}ev2-KXL^)13>6rLnr+5Ls$xGxM7`-PymHWVGJo%cuBEKLP
> VpF86Z<{!)q9LfR=f|FSlA^?tr5?}xT
> 
> delta 64
> zcmccTaMyv$CD<h-R)K+mv2P>SL^)1Z>6rLnr+5M1$xGxM7`-MxmHWVGH2IpmBA);k
> UuRG%p<{!)q97+NVli3s^0D#^SU;qFB
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.numamem b/tests/data/acpi/x86/q35/DSDT.numamem
> index df8edc05b69ecd1331973b16e534b44616b50f58..384fccb6b424645f418b854c0dab258b4a88a7ad 100644
> GIT binary patch
> delta 65
> zcmez9_{ovWCD<k8lL7++qs2xpRe4S~>6rLnr+5Ls$rkbsjNX$g<v%bQPtH<M<QL@P
> Vb7%a){DYZ+Ls@`9aPmxr2mp455y=1m
> 
> delta 64
> zcmez5_|cKeCD<k8qXGj1W8g+ERe4TV>6rLnr+5M1$rkbsj9!x~<v%bQP0mtK<P+fH
> Ub!Ys+{DYZ+LrH*P@+^f20BQ>n$p8QV  
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.pvpanic-isa b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa
> index da3ce12787c28e555b6ba5eacb26275bdd4587f1..c77ecc8cd7c627a86b8142493228625b6c6fbb04 100644
> GIT binary patch
> delta 67
> zcmccMbkT{+CD<h-P?3RwF?S=EygaA3VoZFnQ@nulWFvV8CI{)wCGsJRjK-5sDk$;`
> Xa`Cw{{$T#W%)p^6z#usJhe8AZUfmI4
> 
> delta 66
> zcmccUbis+sCD<h-K#_rgv3w(!yga9uVoZFnQ@nuFWFvV8CV#2TCGsJRj7F1BDk$;^
> WaPhh`{$T#W%)p@}z%cozLIeO(C=p=*
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count b/tests/data/acpi/x86/q35/DSDT.thread-count
> index 50ca91b065d9a2ba95f97d01856865f0e7c615f6..39f481a88419fbb95231eda19846f6064e09d96b 100644
> GIT binary patch
> delta 92
> zcmdm)x+|5-CD<iomk|R4qsm6Ew+5VU(lPPDPVoYMlMEdgy(c>welRq4_V+d9i1+Yx
> v;c>jc%E%EP>gfU`gF_s-_&MU8gMtMGx%k`}e=z@GX5dg3U=W;~XcPee%_<l%  
> 
> delta 72
> zcmdm$x-*r_CD<iorx61KqwPknw+5W9(lPPDPVoZ1lMEdgy(T*ve&9E9_V+d9i1+Yx
> c;c>jc$~c+FNP_bR^ABbQ4kZDG$w@{L03N6mfdBvi  
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count2 b/tests/data/acpi/x86/q35/DSDT.thread-count2
> index f460be2bf74ae512db8f24418b42e8cf2a56202d..354132347ba51404e9ba2a64aa0b0b2aa9977ef8 100644
> GIT binary patch
> delta 67
> zcmdng!L+%9iOVI}CB(Refq}7fBUf4zr<-(4e6UlzfZycGCI?3E$-A09Fd9!@-K@wj
> X$i?T*_=EWeGXsaR0E6J<Tg?#w%=;Ac
> 
> delta 66
> zcmdno!L+G^iOVI}CB&$Ofq}7aBUf4zr>k^Ke6UlzfbZnWCI?2Z$-A09Fd9u>-K@wb  
> Wz{Ts%_=EWeGXsZ`0K??l%@F{-`xNs4
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm12 b/tests/data/acpi/x86/q35/DSDT.tis.tpm12
> index 67ebd7c158759221b801ecb67d8562d92fa219d5..393cc7caca7ef7766ef9ab7f4c876af88964c7d7 100644
> GIT binary patch
> delta 78
> zcmX@<cFK**CD<jzOPPUz@%2V7ZFw#ahnV<ar+5JehspNx_Kd!p>*bx8`Hh|ZeGNI{
> iJv?1_951jkPJS;h#^cWTgZT$D1BbEzgW%+kN)Z5MbrqNZ
> 
> delta 75
> zcmX@*cG8W@CD<jzQ<;H*@#{t|ZFw$thnV<ar+5K>`^on5_KZH8>*bx8`Hh_YeGNI{
> fJv?1_951jkPM)JA!TE#v2QveQk^sZxPf8I0DiRd}
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm2 b/tests/data/acpi/x86/q35/DSDT.tis.tpm2
> index c6b58472157d575e2625557d1346586be06b927c..b0abfd68bde79bf6f0d4acfc959e88477a2097b5 100644
> GIT binary patch
> delta 66
> zcmaFt_QZ|LCD<h-MVWztaoR>MZFx>7r<nL)r+5Lc$#(J%jP9H3<ztu`jVIqxQsfup
> W;&W&G!Tf`nfkRn<L2xp+as&W&fe|kN
> 
> delta 65
> zcmaFj_SlWfCD<h-S($->as5UvZFx>dr<nL)r+5L+$#(J%jBcCj<ztu`jV9kwQsfih
> V;&o^I!Tf`nfkR1vVKR?$1ORF(5ibA$
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.type4-count b/tests/data/acpi/x86/q35/DSDT.type4-count
> index 17a64adb2055ad3168754ca121bf29851d2ee496..e1f05c12982fa847a4e153e4cb066558071505a6 100644
> GIT binary patch
> delta 67
> zcmaDlk@49?MlP3Nmyl;33=E8p8@VLiIo+gV;)9*y1^g!KxH~X<PtJA!z-T-<&O?!3
> Xkc-cq@dxt{W(E#r0S3Xzy&e$&vfUE|
> 
> delta 66
> zcmaDhk@4w7MlP3Nmyo9(3=E7>8@VLiIbEe=;)9*y1$-y#xH~X<P0n@yz-Tl%&O?z;  
> WfQ#3i@dxt{W(E!=0fxza9uWYgL=yx6
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
> index 6eb30e8f4b2c54e4789c649475adff356c8c58a4..a8d0d543d76d8567ea02eb028bb539566af24c23 100644
> GIT binary patch
> delta 65
> zcmcapbhn7hCD<h-){=pNv2G)mk2$B8d`x_>Q@nuF<aqNIM(@c_%s((1PrhoQ$S=sn
> V=g#<p`3Exthq3^J;A9rd2mq{Q6B7Uc
> 
> delta 64
> zcmcaxbf<{RCD<h-#*%@7ar#CsA9GGm`Iz`%r+5L!$?@hbj9!zUn15h2ntatlkxzh&
> U*PZbP^ABbQ4kZDG$*h(U0G=ch6951J
> 
> diff --git a/tests/data/acpi/x86/q35/DSDT.xapic b/tests/data/acpi/x86/q35/DSDT.xapic
> index 111bb041dc0d114351add07c040dde61643d157a..c1719edeb7e5ac5d3b7988812558ccafe26c00bd 100644
> GIT binary patch
> delta 67
> zcmX>%o$35^CN7s?myq+_3=E8g8@ZUeINhXU;)9*y1^gz9b~!M5PY&z)z-T<#y<3rA  
> Xkc-cq@dxt{W(E#r0S3XzW!(_~)AJM@
> 
> delta 66
> zcmX><o$1_kCN7s?mymPa3=E828@ZUeI9;V<;)9*y1$-xqb~!M5O%Ch&z-Tnty<3q_  
> WfQ#3i@dxt{W(E!=0fx!t-4OuAZWJ5<
> 


