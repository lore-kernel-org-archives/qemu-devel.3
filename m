Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A541CE93804
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 20:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC1oO-00013N-Fo; Sun, 12 Apr 2026 16:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wC1oM-00011l-Fy
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 16:53:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wC1oI-00065L-EW
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 16:53:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so25364905e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776027216; x=1776632016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dlGKgcDRVNZh/ceoFaMTbHZb+tkfz+iHzXD+62lWtK4=;
 b=Je/4GR/PSs3BRhw/lKXZQIltyjWuNkprIDmfBHGR00MBbmslolwf00jaEm0Vlwxfb6
 iHY6LN520+tiW/UXoWj+EErBEkXFdSbIiSPJBIaSKiKuCcrMff5ps9tkWPtBgIzgO4pb
 /wywht5CbYYP8QffJ5fHwvy9n1pGE2rmphdvSSeWZeJbsPcngPSUQbcHT4g0In7ef6vl
 7tcpP/zbiGHyRKzq+BKC2bvCI/NAVND3SypdDlzYTNyh13dOnCChYpfqHloUodbRfpR4
 jxSKlqBr/uoMZcC/xgFn50Z0K8BrsXd5PJpiIzW5wj6cNqY6VSnrFG/oCTlC2dpDUhpY
 GZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776027216; x=1776632016;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dlGKgcDRVNZh/ceoFaMTbHZb+tkfz+iHzXD+62lWtK4=;
 b=n/roP+Bw/js/m2neQEKPWRLbXIR0BphSg/CvqkiiCoHR9AyJz8ROvEIWKQ6QDVGdeb
 pTxGhwMHmvoj1iVwp4jTNpkEaBDrh6s7XCpjQrqncFqbTPcgHJLwS92ia2bZkfwF95jz
 EosH4bugUaFwY6GtTxgP/LBsHF2FpjCXdCa4F0LDe+wPHKgJMyT7Ak/VJIfgEb7hczui
 W2l9P/fbCbZNvJBbFvRA/ck4XbQFvtGy7Q4rGS6yY3MpF1FIDERvRWsHHyTJneF2o68I
 oJ2LnO3r99F2IGr+gXFfL0UtSigyxPV5tXkn98j4fFctN+jZ4pedmN6eojt+qDRJHWBr
 3SHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm0i4h9onDUsqPfHvv3MfXtSNDRUgIGNNnjSajkZGGUNAoBmY+0PfloyHoZ9iz2kE5qSAn1J1/SxAe@nongnu.org
X-Gm-Message-State: AOJu0YwrJxWVG4uXsBYFK8aYGgmiUuu1r61+eJJqclFjKhk49w97xGvi
 iN91GLy7wZeD/L6blhnpP7JJL0G6CqGQyV/0y0pzo7EBwfajNabN3pADM3i1X4Uq65s=
X-Gm-Gg: AeBDiesI+SKlSj2KCrRzHTYF/KoaecqfEQSSfYQKmCxz6y2dx2ADN5pRQH+E2socSkW
 JRfBrlg+PWiViZxQcuiXCfT4moo1CUrfC6csqyGbJMG/VVuG4KcCtrNPyyzstog61dXfX5ZAvbX
 2J034i+Sesb8cpDFLJo8ALRVe9WmiWvtdlOb1F13W36FezSm0HV17tG4ZkV0VnbFi8LZHXo7ITn
 0Ukip7TeJzs1aqXwzn7UGtsRJl9vbkDiT+K+bjKzHRQOPew/aZn00qEUEJusttGQZU4rivrOi4L
 t4GHoP4AAmiaiC2Z6cj5aq8vKJZ3diEmRnMmK8/zbORu68yxfyPCj1rUemcKCmYbdxCoUC7XC2z
 +w4csBljsI3G5gF/YVFDc2SvSZUuMpxLmtEjAmsmiuZ7Ek0RIee6UgPSQ1n90eIP9ImYhhgBKh0
 6LNhqMsuv+wp6WaWTDTYVhi33vToftZwxZD8cyTqTBDKgzySOD8ealfX1vEQFmMKPX2Q==
X-Received: by 2002:a05:600c:64c4:b0:486:fbd1:9dc0 with SMTP id
 5b1f17b1804b1-488d68c2c56mr132751815e9.22.1776027215811; 
 Sun, 12 Apr 2026 13:53:35 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d67ced32sm107711855e9.7.2026.04.12.13.53.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 13:53:35 -0700 (PDT)
Message-ID: <f1f030b4-acc6-414d-a0ef-4afff50278fc@linaro.org>
Date: Sun, 12 Apr 2026 22:53:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/13] hw/usb/hcd-ehci: Add descriptor address offset
 property
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
 <20260311072614.1095587-12-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311072614.1095587-12-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 11/3/26 08:26, Jamin Lin wrote:
> When 64-bit addressing is supported, the Linux EHCI driver programs the
> segment register to zero. See ehci_run function:
> https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-hcd.c
> 
> The driver comment also notes that descriptor structures allocated from
> the DMA pool use segment zero semantics.
> 
> Descriptor memory is allocated using the DMA API. The platform driver
> configures a 64-bit DMA mask so memory can be allocated above 4GB.
> See ehci_platform_probe function:
> https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-platform.c
> 
> On AST2700 platforms, system DRAM is mapped above 4GB at 0x400000000.
> As a result, descriptor addresses constructed directly from the guest
> EHCI registers do not match the actual system address used by the
> controller when fetching queue heads (QH) and queue element transfer
> descriptors (qTD).
> 
> Introduce a descriptor-addr-offset property so platforms can provide an
> address offset applied when constructing descriptor addresses. This
> allows systems where DRAM resides above 4GB to correctly access EHCI
> descriptors while keeping the default behavior unchanged for existing
> machines.

This is dubious. Maybe the AST2700 isn't modelled appropriately (like
some memory region not mapped in the correct container, or some code
path not using the correct address space).

> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.h        | 1 +
>   hw/usb/hcd-ehci-pci.c    | 2 ++
>   hw/usb/hcd-ehci-sysbus.c | 2 ++
>   hw/usb/hcd-ehci.c        | 1 +
>   4 files changed, 6 insertions(+)


