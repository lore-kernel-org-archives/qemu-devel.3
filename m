Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77ACC5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 16:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siche-0001zD-44; Mon, 26 Aug 2024 12:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sichJ-0001Vf-Nc
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sichH-0003ag-Pb
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724690163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q1DsyWN/762yBAGs/e9CSJMjLajFe9MXHUKOdQHKZ0I=;
 b=TQ+4gUZRfUKupMnelMZMraYxDG8zzCHOYMzPNowpdvpI/nus2c07kP7PQTCN2pjkIFvDq/
 FgFNfvpQtYpJibAFViXJoO9d7efQPFkr+JGDHqisUl/Bej6JZk9u3SGKd/p3MGJDAq9P36
 2up8UejsdT9//3K0iS5xdXA7EamzxXo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-cKxlEOZ5OBGMo1-WyxFxtA-1; Mon, 26 Aug 2024 12:36:01 -0400
X-MC-Unique: cKxlEOZ5OBGMo1-WyxFxtA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-44fe32a1a4cso62442931cf.1
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 09:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724690160; x=1725294960;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q1DsyWN/762yBAGs/e9CSJMjLajFe9MXHUKOdQHKZ0I=;
 b=XZbjsdetNJFJehokBDiqds3Z6dAtrTPYQXfq1QMf5UZuD1PN6Oei/G8Q2tVvj0T4UI
 J7abA/0bz5dFyvBhTKtqv04X98PWsuBxL/hHEsxq4jVjrXvSjHrWT1RUT1wpKcAr7I2j
 YxWnU/hTdIryr1mK/+Mk2YJ26K0p7VpaUIU4iZ5lqYYqkFbkNFAbxp+3guBpV+wH5JtK
 mEg8EP0KvUAos5udWMm1VnVOoWUlrcnd+J4NSGQllMmCIAwOB4TU5PL0oefBe7pzzo5Y
 n4yO4bOaydPDdn3hMfrJhb57GVZ+fgkRlS7XeE4FsMFc69LIxaRVoIfGs6UL8P1llqCW
 eb2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSQgaiNEeGnyVPn4EVHSD4cnKlbtIfaCyssO2bjxiDuw2O3eI8VefVFWvzQmIAhsqnrsLM4t8SGhLV@nongnu.org
X-Gm-Message-State: AOJu0YwVEBab1LlDR8FFlPXOvFKz6B8NwsqAsHhJMmYXCyTbYOKa90bb
 c1RsBf9/wRlH/fMKwNZFyhegJqcVJzYcPua1TBLhQvgtPVzLlj5OThiQO7E8eoUIIpGMrtPsVLd
 f3dq1Au8he31AVI3ftI+KJsM1AmHQpgYNEx73Ow9W11mEKqCxxWMx
X-Received: by 2002:a05:622a:2449:b0:446:34cd:9e21 with SMTP id
 d75a77b69052e-45509617165mr154645261cf.18.1724690160678; 
 Mon, 26 Aug 2024 09:36:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZwC0A16GTuBcyVL3hBN6CB4TwUcPZwPHJ7yxcIRICQQhED24Y9J0AzedUN7QLqqS4I9gnSw==
X-Received: by 2002:a05:622a:2449:b0:446:34cd:9e21 with SMTP id
 d75a77b69052e-45509617165mr154645031cf.18.1724690160264; 
 Mon, 26 Aug 2024 09:36:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe199471sm44918501cf.59.2024.08.26.09.35.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 09:35:59 -0700 (PDT)
Message-ID: <07778bc6-20a8-4671-85a1-5959dc1778df@redhat.com>
Date: Mon, 26 Aug 2024 18:35:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2] hw/vfio/pci.c: Use correct type in
 trace_vfio_msix_early_setup()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20240815135245.3325267-1-peter.maydell@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240815135245.3325267-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/15/24 15:52, Peter Maydell wrote:
> The tracepoint trace_vfio_msix_early_setup() uses "int" for the type
> of the table_bar argument, but we use this to print a uint32_t.
> Coverity warns that this means that we could end up treating it as a
> negative number.
> 
> We only use this in printing the value in the tracepoint, so
> mishandling it as a negative number would be harmless, but it's
> better to use the right type in the tracepoint.  Use uint64_t to
> match how we print the table_offset in the vfio_msix_relo()
> tracepoint.
> 
> Resolves: Coverity CID 1547690

Oh. I missed this issue.

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/trace-events | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 98bd4dccead..c475c273fd8 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -27,7 +27,7 @@ vfio_vga_read(uint64_t addr, int size, uint64_t data) " (0x%"PRIx64", %d) = 0x%"
>   vfio_pci_read_config(const char *name, int addr, int len, int val) " (%s, @0x%x, len=0x%x) 0x%x"
>   vfio_pci_write_config(const char *name, int addr, int val, int len) " (%s, @0x%x, 0x%x, len=0x%x)"
>   vfio_msi_setup(const char *name, int pos) "%s PCI MSI CAP @0x%x"
> -vfio_msix_early_setup(const char *name, int pos, int table_bar, int offset, int entries, bool noresize) "%s PCI MSI-X CAP @0x%x, BAR %d, offset 0x%x, entries %d, noresize %d"
> +vfio_msix_early_setup(const char *name, int pos, int table_bar, uint64_t offset, int entries, bool noresize) "%s PCI MSI-X CAP @0x%x, BAR %d, offset 0x%"PRIx64", entries %d, noresize %d"
>   vfio_check_pcie_flr(const char *name) "%s Supports FLR via PCIe cap"
>   vfio_check_pm_reset(const char *name) "%s Supports PM reset"
>   vfio_check_af_flr(const char *name) "%s Supports FLR via AF cap"


