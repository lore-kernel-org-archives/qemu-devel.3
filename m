Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31EDCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCAv-0002Cb-Kf; Thu, 18 Jun 2026 08:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waCAY-0001vg-HH
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waCAW-0000Qq-L6
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781786905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g684DBJK10dMKRVjNqjNWx6kw9YIt1QQsUFCFsS2Ntg=;
 b=LACSpW0iZxNacKg5dK3NNHdDpXNKWHqW5GM4PA3ksx3z6x0cB91H2vYsSYzhPoeDnYQApG
 ABO9JKYQvdCPZXzoZdtLhrTey0Tmq29Iobo7/CvwourqDqSLzBCzEH1N7naaHjGB9eq8zU
 GJHpAox53RBF8cXJQdDdiDb1EC6/PI0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-992er7d-Om-AOXHWsxBCSw-1; Thu, 18 Jun 2026 08:48:22 -0400
X-MC-Unique: 992er7d-Om-AOXHWsxBCSw-1
X-Mimecast-MFC-AGG-ID: 992er7d-Om-AOXHWsxBCSw_1781786901
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-462d8ccf553so666307f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781786901; x=1782391701; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g684DBJK10dMKRVjNqjNWx6kw9YIt1QQsUFCFsS2Ntg=;
 b=LWzKpn76VkwS0LyGJjrIf5CbHtn5Zn1mFw4JKNy+8ecys+Pj7pzPWtPi3yu0SoNW6M
 9A4NtVNtg781h50d/tcyahgrCqqrun8E6dJ7DMkqqmF5Y4WZoIAZK9pmQHlmPhveQyRP
 5kM/9V21B3ay5ClJGeGoIIJ6jVRYGzef64Tk3c6ujPCX1goMJWJmtUYMh32w+PELmiIn
 oa/qvr0JpxURHCZbLKwKTEfQgfoVzBJU/f+irh4B9xq2ibnZ4wQhzn8p6YY+IQdV7bu6
 8hVRuej1Dq5vD8PsY5Ml/rsh+evtMizP+y1VgKgmqyi5s0B41cwUJ8gASb2+xIDavIGt
 17dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781786901; x=1782391701;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g684DBJK10dMKRVjNqjNWx6kw9YIt1QQsUFCFsS2Ntg=;
 b=BX6MwPiAyqSkOH4MSr3vV6tWEytKFNCECXqgDp+V4hd14qAQ3IQIy9b3QDWZC9F+3n
 AwnKDj36FX/msH+ZPfw4bYyaHNKne95J9tcP7JrbbH8aakdFSAwXapVmQikBhjwuoTyf
 wwxFvIw/cfmTD+xnxozWVIT3w7AlGis3lLmetgpTOdje40Vr6hIdHfIaZw61utildIkA
 8qzymqBagu3WA7DGyvnsJ8m5o8WAS8RYaOy2OgBMn7CIGd4oExgk1lYnOqKQZba0j33p
 PXNrigMntzqZich1tr12JS3Bdmwc7icXSfeF30AAfU5AankosVdkeGiw51Hc2ulBhb8K
 eoqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nlbipv4Qnf8nz/gttXzHnM/63zZXlstOHOhUhBcz2HnROtmAtQnQFB3Scax2LDNGYADESaOKTbtnR@nongnu.org
X-Gm-Message-State: AOJu0YzIfjzyWPT/GMstNPujDEMcPV9jc925NzwRieYGqP1k/C11ZZHo
 /VqrMMXWPk+CP2x9t5wCFFiPePZGwezQd3D8tui61bRh5j2/w7N2wYt78sucSfR/0ue6yrPwN1s
 /yzQdie3cug1WHzWfSqfC/tUmmx+k5eTvjMeoaNvUGc/nPIn9juYpSPLF
X-Gm-Gg: AfdE7cknAQrtMSSXRp8SreuFfQSML24hjSgsMge8bjqztBQ2jYxBltv0/5FDXn1uq94
 P7bm3+F/y6YyEP8BojwWr3VcsmTz7JS/OOpcBGwEA9rKp77urj+xjGxDpoD/frhCiAtggNEO7w/
 7IA6zm068tesBM7JplO283I9MNt5/SYvaeMIEd70E6yxUGNWsns1UQwIsYQvLk7+WYamnnZ575L
 +7rwgscMbZ8FAyyu6BB10Wxk8WaNmbBWjwHf3tLKSvYidgjo3QaVYQkuK/z8trBHdkvBgWKXE9y
 83cE5qqq3EDa1/u3Sd+TOIDytS+87FZ9EuhHN/tJsJRQaD20rZ4/IZCWHWn7kMnxhfyxTpr4G/k
 2ULrYxb28Uo3kP2OJ+pfyoslq6tdErVro
X-Received: by 2002:a5d:588d:0:b0:43f:dbbf:6d93 with SMTP id
 ffacd0b85a97d-462410d3c5bmr13847985f8f.27.1781786901194; 
 Thu, 18 Jun 2026 05:48:21 -0700 (PDT)
X-Received: by 2002:a5d:588d:0:b0:43f:dbbf:6d93 with SMTP id
 ffacd0b85a97d-462410d3c5bmr13847930f8f.27.1781786900712; 
 Thu, 18 Jun 2026 05:48:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619a041986sm38334050f8f.23.2026.06.18.05.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 05:48:20 -0700 (PDT)
Date: Thu, 18 Jun 2026 08:48:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/1] hw/acpi: correct field sequence in SPCR table
Message-ID: <20260618084645-mutt-send-email-mst@kernel.org>
References: <20260618124020.640794-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618124020.640794-1-heinrich.schuchardt@canonical.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Thu, Jun 18, 2026 at 02:40:20PM +0200, Heinrich Schuchardt wrote:
> On LoongArch and RISC-V invalid SPCR tables are created:
> 
> Terminal Type : 00
> Language : 03
> 
> The correct values are:
> 
> Terminal Type : 03
> Language : 00
> 
> This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
> SPCR creation to common location") that swapped the fields.
> 
> See the specification of the table in
> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table
> 
> This page shows version 1.10. But the sequence of the fields was not changed
> since version 1.0.
> 
> Our LoongArch and ARM code uses version 1.07 of the specification.
> Our RISC-V code uses version 1.10 of the specification.
> 
> Fixes: 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate SPCR creation to common location")
> Origin: https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
> Bug-Ubuntu: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2146419
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Thanks for the patch!
Yet something to improve:

That's not the way to submit expected table changes -
it would prevent backporting and rebasing.

Pls follow instructions in ./tests/qtest/bios-tables-test.c

Thanks!

> ---
> v3:
> 	update test data
> v2:
> 	Mention the different specification versions used by our code
> 	https://lore.kernel.org/qemu-devel/20260326144835.67911-1-heinrich.schuchardt@canonical.com/
> v1:
> 	https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
> ---
>  hw/acpi/aml-build.c                   |   4 ++--
>  tests/data/acpi/loongarch64/virt/SPCR | Bin 80 -> 80 bytes
>  tests/data/acpi/riscv64/virt/SPCR     | Bin 90 -> 90 bytes
>  3 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 9b3cdd3781..990abc64cd 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2144,10 +2144,10 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
>      build_append_int_noprefix(table_data, f->stop_bits, 1);
>      /* Flow Control */
>      build_append_int_noprefix(table_data, f->flow_control, 1);
> -    /* Language */
> -    build_append_int_noprefix(table_data, f->language, 1);
>      /* Terminal Type */
>      build_append_int_noprefix(table_data, f->terminal_type, 1);
> +    /* Language */
> +    build_append_int_noprefix(table_data, f->language, 1);
>      /* PCI Device ID  */
>      build_append_int_noprefix(table_data, f->pci_device_id, 2);
>      /* PCI Vendor ID */
> diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
> index 3cc9bbcfb8051e632592d9db0fe3dba0af53ed8d..7bb819cd0d2ad20269e40e4a738709a45260cbb2 100644
> GIT binary patch
> delta 23
> TcmWFtm|!Qw%<vxw7?1z}S|J61
> 
> delta 23
> TcmWFtm|!Qw!2BNw7?1z}S{?;}
> 
> diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
> index 09617f8793a6f7b1f08172f735b58aa748671540..59d2c8f7f215a604612cbd0294c18bc6301e208a 100644
> GIT binary patch
> delta 10
> Rcma!wnqbGo%rMbG3IGpM0&@TW
> 
> delta 10
> Rcma!wnqbGoz&z1G3IGpJ0&@TW
> 
> -- 
> 2.53.0


