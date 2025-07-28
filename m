Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3387C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 15:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugPxY-0004xm-Aw; Mon, 28 Jul 2025 11:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ugPxM-0004iM-OW
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ugPxK-0002Bk-Dp
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753717199;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aK8BuoLFAeS+eg6Hlk4zc+Pdw9VG+Sjj2feSeB0EzqA=;
 b=F8ae9pI6hmuyYR/2IfE092KU+zC+FE0EEh3j8PtRoIkr4SlGlxajfzmwM7sMe4wt7vxqI6
 0B+0WsH9iUNZrMbHub5+fSF9wylwUPz+DbZMffctkOBFaJnSuAa3+wBiZH+xLVD/ExD5tL
 N65OAQ+FqVlQ+pQCqXR1ixtD7eClqic=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-WJOX8OwFNFC3ppz5yEXviw-1; Mon, 28 Jul 2025 11:39:58 -0400
X-MC-Unique: WJOX8OwFNFC3ppz5yEXviw-1
X-Mimecast-MFC-AGG-ID: WJOX8OwFNFC3ppz5yEXviw_1753717197
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b783265641so1615481f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 08:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753717197; x=1754321997;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aK8BuoLFAeS+eg6Hlk4zc+Pdw9VG+Sjj2feSeB0EzqA=;
 b=hJjlngziGcTGLAa3LwfFGiRolSnrgkp3tV++olgcnQ6pBMQn3bcJGIdZST60tOn3oL
 vsn1boewizI3lWmhJz/QIO7nhyf4jTbYcO7IwH7i9YIOvmMgjWSfiKSfG94z8tY0kidZ
 rDh4pYpwHxHxrA+yVEhNeY1+CUbj1Y299oBJwS2hRFROdxsTiKW3yaWzHKIRxz+bjC3t
 KVi1EyPdBdI+vczKrFuZZWaFTCIvWB4T0wsERimqQ57S10PAfqL9YtfIr8W9Q175VDQ+
 cM/gVkydzl/lX5htN2PGNQM4dmFm23edFyKM2nMbPIvALLpxxseNxJ/VFIlnSiLaekcb
 Bmsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXyp3vUjNcE7XVDFxka0mbFIfgCNRZzvlKJoU6N3fMLKdhwM11P9q87n9ztO1tIFBbSGNeETDU3/Ba@nongnu.org
X-Gm-Message-State: AOJu0Yxig25IPOp32WKwpTgUY6jDjw/+UjejK3hn0/Q6z2/DcnyjkNT0
 P2bHRsmJJMLPUdyY5G53E3T1IK2S/ydhFcJPBYNgRxzWsWHtbQbtC+p6qFd5rzV+3hcXylyBUnl
 XRGqKQuTbm7RQ17w81G6bFsUCMRYrBMLDzdmZjxhsG8bIKZJDW8kOncxS
X-Gm-Gg: ASbGncsPxCxP+UqOy5kI5dx27x/tkSKm5XzOTxwkLKHeVfxFxixHsW8TFyxw38N1PD6
 sAxuApCh+pUEzvnKSWHoShSFusv95HELc2Q2L27GUKhzM4Z7QqvUIuHeXucnpH+GzdePP4h+vxn
 lIAx1Z4OctqdUuT3Ym2p0LKrsVEZKuUnUO2XILKM0C+jSd6CNuLfEm8sM9cmOrLpv1X060Qq5oe
 huHqih6MstzpdBZw4awCJoO0RX2gzW936Beh9T9HNNSbchwDa11zx8RXdFM51Cg0rHHh3sxzyPi
 4M2QC/YXC6KTOude0VCGoRQXF+KEz+5bt4eNtkDWeX9P79AzsTtCOR5bHoi/jGUXVOaatJcOeg=
 =
X-Received: by 2002:a05:6000:381:b0:3b5:def6:4e4 with SMTP id
 ffacd0b85a97d-3b776673e7emr9067916f8f.46.1753717196347; 
 Mon, 28 Jul 2025 08:39:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF67qDpb22TeRbtQzTezeRa7KUwIP9cnsc8vZXe8wtCDOrvrJDxLMeKxUYJnjRNvC4/KPQ8Q==
X-Received: by 2002:a05:6000:381:b0:3b5:def6:4e4 with SMTP id
 ffacd0b85a97d-3b776673e7emr9067891f8f.46.1753717195820; 
 Mon, 28 Jul 2025 08:39:55 -0700 (PDT)
Received: from [192.168.3.191] (228.246.150.77.rev.sfr.net. [77.150.246.228])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054f686sm157746295e9.14.2025.07.28.08.39.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 08:39:55 -0700 (PDT)
Message-ID: <9ece87e2-215e-4604-ab9f-03e65fe07fae@redhat.com>
Date: Mon, 28 Jul 2025 17:39:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 10.1] hw/pci-host/gpex-acpi:
 PCI_EXPRESS_GENERIC_BRIDGE: select ACPI_PCI instead of imply'ing it
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20250728152445.23917-1-mjt@tls.msk.ru>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250728152445.23917-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/28/25 5:24 PM, Michael Tokarev wrote:
> Commit af151d50eac24 added dependency on hw/i386/acpi-build.c
> (where this function is defined) to hw/pci-host/gpex-acpi.
> But acpi-build.c is only built when ACPI_PCI is enabled,
> and the build fails at link time if it is not.  So ACPI_PCI
> becomes a hard dependency of PCI_EXPRESS_GENERIC_BRIDGE.
> Fix it.
>
> Fixes: af151d50eac24 "hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method"
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  hw/pci-host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
> index 9824fa188d..19b6605c7f 100644
> --- a/hw/pci-host/Kconfig
> +++ b/hw/pci-host/Kconfig
> @@ -54,7 +54,7 @@ config PCI_EXPRESS_Q35
>  config PCI_EXPRESS_GENERIC_BRIDGE
>      bool
>      select PCI_EXPRESS
> -    imply ACPI_PCI
> +    select ACPI_PCI

As mentionned in the previous thread,

build_pci_host_bridge_osc_method() is called from gpex-acpi.c whose compilation depend on

pci_ss.add(when: ['CONFIG_PCI_EXPRESS_GENERIC_BRIDGE', 'CONFIG_ACPI'],
if_true: files('gpex-acpi.c'))

so the hard dependency exists only if ACPI is selected.

If one use "select", ACPI_PCI will be mandated even if ACPI is not set. I am not sure this is what we want.

"Imply" was supposed to condition the selection depending on ACPI_PCI dependencies, ie. ACPI and PCI

Eric

>  
>  config PCI_EXPRESS_XILINX
>      bool


