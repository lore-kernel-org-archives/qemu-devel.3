Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D421CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 10:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUjBw-0004w5-FK; Wed, 03 Jun 2026 06:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wUjBv-0004vv-CE
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 06:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wUjBs-0002nK-UX
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 06:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780483875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWrxbqJk8BCGr+kHRNcnugUGt855JlAC3bWLZrYUMMY=;
 b=YdvM7qSl/YXTj+r9VyrVqCkuaVeTVcVzhVEBNoVeRe6hIsUGgypU1v26Cex+i+tOWiBK0n
 qwwUhS77NIBQ8En3TE0zN6aawKbEXoYdXjh3VJue5u/aHzt31gDW2T65jkt5Ozsg8Q9irg
 y/bMcneqwOqOpusnfwmL3EX8CRjYmbg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-QMOeXgd9PJGvvA4wU6HWZw-1; Wed, 03 Jun 2026 06:51:11 -0400
X-MC-Unique: QMOeXgd9PJGvvA4wU6HWZw-1
X-Mimecast-MFC-AGG-ID: QMOeXgd9PJGvvA4wU6HWZw_1780483870
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490addd42bbso16860245e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 03:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780483870; x=1781088670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWrxbqJk8BCGr+kHRNcnugUGt855JlAC3bWLZrYUMMY=;
 b=OHQf77C+0CYref61SxRyWzKrHf+WiKOzJ1L9e6HmtfrhkbXLQC6W8p4x4+PNh2Xk9P
 wbirB4q66JvtshL1UIW5VphsGdE0XuiD6Glu6+wsh+q+grdsNorZzrqctUybxXrTq90t
 /uxi0qvnSOYCOjqPA2er2lXtlfPwiN9vb+9J1YAQSEX7lRfoLkH2tC+nOiTcuLwGev6E
 xhO9YIxU+7AvzWpTV+BizJ6qeatJOCr7r1maMF0QtfMX6uIeGifCqAm/dBYlhW9hdELq
 DEdOo9CDWidftCubhKESqCojbBQaSqUbrYEOsQIlIltvV/g2iQ0bRuVXKVBbxzEOK42N
 sT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780483870; x=1781088670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zWrxbqJk8BCGr+kHRNcnugUGt855JlAC3bWLZrYUMMY=;
 b=EMtxYBJ4ic873wTYVQ7rDD5pTKW6zZPwGQUzxmKjjuTw2Wvbm8gsPARzOo21fJzyHy
 mVqMCH9hfSPEMRVXqo/pWsJNgXnByX7XDPs6cSFOdJX+jBpsdEhXU0eJjw2W02bOT8Bv
 MuUJXtdeHKWn5Emb1uDXe/Cw1Zdlj3adzubso8qHuzKMRt1tdKUCLAm8izXmkN8mzQNs
 KdOeLXFJ5r7oKSm+HuwNvg2Wl76oYWjJ0SyfMc8pcc4F2lJqdHPCDXWEpPJNIMrEPD39
 tOs+xoEsHzP1ZPcDdens3PlNvb+yy/XiFKVO3OktsBo8sRg9sSqBEO83CszeBn2mueZV
 k8jw==
X-Gm-Message-State: AOJu0Yw5bekwwOFyzi/mN9bYxwAs0lWDfpuuyUbNwewHc6feKv2573dJ
 pYKrq/yrCbiQmsL+OhNjvZmrzaYo8a7v/eKqdh81vyXMWCJaiDhv0tjtFJgut0ziIOdI3PuZshC
 C/aWKtibhpW3HgopXKQZ3th9U8QPrbWzA/K0OrgkxZKrOTneI3D/wy+mc
X-Gm-Gg: Acq92OFP7Ih7rVURaH0Wzjqk3pUedFN7d6uO53gbiliksDNfTc0/xlcYPTq1KzHFhWH
 rc43INQ0aP6J2VtOpispbLQLwubg6C0WEi0pYSpOI3Ed5i/pRm3inVn5e6N/dGVTvxrD/m7+y6s
 ebp4laxF4an5P7yVhhA/Hv261wQDgHfpdLSdoss2BbeQahES+ePr4pSFeMar+OZbq2hONgfNK0L
 ElzZFAwSQsSqe+/LS+Ld+O8Vp3Hqbi9ZvL8xtV6ueFHQCCILkTXcG9xqHtMu55KVKjVD9dUcaXq
 /gDupgXyNIzfenZQZ002+GAak2Obpiu2DKM6qDqoHIv9X6ujr1TRsjMyPBgYCPQhsNOwXQub2VH
 +lxHMrxbQkHQ7hXEC
X-Received: by 2002:a05:600c:3552:b0:48a:563c:c8e2 with SMTP id
 5b1f17b1804b1-490b5e73ef3mr41743505e9.3.1780483870495; 
 Wed, 03 Jun 2026 03:51:10 -0700 (PDT)
X-Received: by 2002:a05:600c:3552:b0:48a:563c:c8e2 with SMTP id
 5b1f17b1804b1-490b5e73ef3mr41742985e9.3.1780483870148; 
 Wed, 03 Jun 2026 03:51:10 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b0e88fdesm140711135e9.14.2026.06.03.03.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 03:51:09 -0700 (PDT)
Date: Wed, 3 Jun 2026 12:51:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH v2 2/3] hw/acpi: Fix Terminal Type and Language field
 order in SPCR table
Message-ID: <20260603125107.3f658f03@imammedo>
In-Reply-To: <20260529023100.42508-3-wangxiang@iscas.ac.cn>
References: <20260529023100.42508-1-wangxiang@iscas.ac.cn>
 <20260529023100.42508-3-wangxiang@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 29 May 2026 10:30:59 +0800
Xiang W <wangxiang@iscas.ac.cn> wrote:

> According to the ACPI Serial Port Console Redirection Table (SPCR)
> specification, the field order after Flow Control is:
> 
>  - Terminal Type (offset 62, 1 byte)
>  - Language (offset 63, 1 byte)
> 
> This fixes:
>   - hw/acpi/aml-build.c
> 
> Reference:
> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table
> 
> Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/aml-build.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 7edc8aed42..2adf2810c3 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2116,10 +2116,10 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
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


