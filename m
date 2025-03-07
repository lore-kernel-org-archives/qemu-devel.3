Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7608FC282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 08:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqShK-0008Av-2T; Fri, 07 Mar 2025 03:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqShJ-0008Aj-3F
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 03:04:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqShH-0008A5-7D
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 03:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741334682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jK0yFaBRU900Qo1bMZg+7rqMOFRuryusg/EQqR5ZJX8=;
 b=DPUwqqvnf9S6YPyAmdnWScDk8RZjDijjfTPtsu7OFXAY411Z95Cq/pkYJHAc8Wh70Wby6P
 Vl3XBxZo3co0cJ8/HoD6YNpHtvptjqluguO39iyBUio7D6/W2+x9NfCPfSBFeioMWfdgha
 OcizGn1mFqRR9+WZD9iaStx8u5/JtT4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-tuPK_1oVO3uFCapPPmJ4FQ-1; Fri, 07 Mar 2025 03:04:41 -0500
X-MC-Unique: tuPK_1oVO3uFCapPPmJ4FQ-1
X-Mimecast-MFC-AGG-ID: tuPK_1oVO3uFCapPPmJ4FQ_1741334680
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43bcddbe609so13633285e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 00:04:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741334680; x=1741939480;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jK0yFaBRU900Qo1bMZg+7rqMOFRuryusg/EQqR5ZJX8=;
 b=HDxGFW5loX+x+FyQLQCPDTyYIzgsp+mDH6f1InctYjm/j2dDKo+1EMVWzol1MhRoCG
 VeCdp7u+Ou35augcU4vqEKurEjpKU11IeexTBAZa2bN5Qd4hwymFr85CLw+zLBG6CH+F
 DSjDKPXD+p7Jixie1vzb6c0eltYrqUvcA27kYZDPMO/xaKfqf4HyTqF9sx1gzNotlc4T
 snlXU+o1Ksxb8n3irwYREObsL/IkCgaQ/O/dNdthTxH72+CuNnNLtl0PD31nJj2ryIAg
 NsMc2PsQ5dalJGfCjPMt8SexKS9TEqrEyaE51jBYsW+8pJvdROiQ5UGSS+VO1Ve0sa11
 Xoqw==
X-Gm-Message-State: AOJu0YzHHoW9ipPHxyfGWkPKru5lh7zwwrpGRQbkIMAEg0eOqneSSQh1
 1WWfGHFdHhBIXbpFtULEtuIRon+zfZSMlnpKNSAQjt7WPpqhYmvELTQS/0Rb+HgQqxDAnq78j3j
 3sEhG6dBySusowi5k9wwWWf1f04vBJRjzugiQHXPiWX90vQtq6FdJ
X-Gm-Gg: ASbGncvnQFp2GmadH8WdoNhfngJMqP+4F5AaBS3LDuQdJkIvepEFednbD4PqKFdqhei
 cMhRoPnPBGpKR2/nptvXjk6MwO7MC3GGi8Te+jr2SvgotxAWvFRvsKrEuHaGpNGGLbNdhFLhLpd
 dNWVupNjNycZ8qtAnCPpY4CGPIziFfBcXv907lW+RKH4H+azLInWZHjBmKzr0Bnul8i0XXktHZn
 pWwJBp+nXocAv2Wll4jFJszCmp0Btu4D1RLek3Dp2pJ9HLdZvK4QOecscKTGgQo3JLkJR0C3Lal
 rqaHxHyOPkTXWsysEft6J4g2wyKrojsLl9AhDTB+FA03Kf1mpROjJQ==
X-Received: by 2002:a05:600c:1c03:b0:439:9106:c09 with SMTP id
 5b1f17b1804b1-43c6021f124mr16866685e9.26.1741334679948; 
 Fri, 07 Mar 2025 00:04:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6JQaLN2wmJxK9PlOz9/R9CWGZqtMO178Ib4VFn+zU0VWZWbFAYHk8QrwWpX/0YF0fBwJMjQ==
X-Received: by 2002:a05:600c:1c03:b0:439:9106:c09 with SMTP id
 5b1f17b1804b1-43c6021f124mr16866355e9.26.1741334679530; 
 Fri, 07 Mar 2025 00:04:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4352ec1sm73960325e9.25.2025.03.07.00.04.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 00:04:39 -0800 (PST)
Message-ID: <75433541-d80f-47aa-9296-23923c5149c5@redhat.com>
Date: Fri, 7 Mar 2025 09:04:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] vfio/igd: Decoupling quirks with legacy mode
To: Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <corvin.koehne@gmail.com>
References: <20250306180131.32970-1-tomitamoeko@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250306180131.32970-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/6/25 19:01, Tomita Moeko wrote:
> This patchset intends to decouple existing quirks from legacy mode.
> Currently all quirks depends on legacy mode (except x-igd-opregion),
> which includes following conditions:
> * Machine type is i440fx
> * IGD device is at guest BDF 00:02.0
> * VBIOS in ROM BAR or file
> * VGA IO/MMIO ranges are claimed by IGD
> * OpRegion
> * Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
> 
> If one of the condition is not met, the quirks will not be applied.
> However, for recent generations, espcially Gen 11+ devices that removed
> VBIOS support, not all the conditions are required. For example, on EFI-
> based systems, VBIOS ROM is unnecessary, and VGA ranges are not used.
> 
> To have better support on newer UEFI-based VMs, this patchset makes the
> quirks independent of legacy mode. The BDSM and GGC register quirks are
> applied to all supported IGD devices, new x-igd-lpc option for the LPC
> bridge / Host bridge ID quirk is introduced for possible Q35 support.
> It also prepares for supporting IGD passthrough when it is not primary
> display later (kernel change will be merged in 6.15).
> 
> To maintain backward compatbility with exising configuration, legacy
> mode will automatically be enabled when:
> * Machine type is i440fx
> * IGD device is at guest BDF 00:02.0
> If the legacy mode behavior is unwanted, option x-igd-legacy-mode=off
> is provided for users to disable it. Setting x-igd-legacy-mode=on checks
> if the condition above are met, and set up all the required quirks.
> 
> The default value is x-igd-legacy-mode=auto. When the above conditions
> are all met, it acts as before and continues on any error. Otherwise it
> is equivalent to x-igd-legacy-mode=off.
> 
> When x-igd-legacy-mode is set to on or off, QEMU will fail immediately
> on error.
> 
> The first 2 patches of this patchset was taken from a previous one,
> details can be found at:
> https://lore.kernel.org/all/20250124191245.12464-1-tomitamoeko@gmail.com/
> 
> This patchest was mainly tested on Alder Lake UHD770, with Debian 12
> (kernel 6.1), Windows 11 (driver 32.0.101.6458) and Intel GOP driver
> 17.0.1081.
> 
> Due to I caught COVID these days, I am unable to deliver the proposed
> documentation update before QEMU 10.0 soft-freeze next week. Please help
> decide whether to make this patch series in 10.0 or next release.
> 
> Changelog:
> v3:
> * Use OnOffAuto for x-igd-legacy-mode option, default is auto, to keep
>    current behavior.
> * Added a new patch to solve the possible KVMGT/GVT-g fail.
> Link: https://lore.kernel.org/all/20250303175220.74917-1-tomitamoeko@gmail.com/
> 
> v2:
> * Keep legacy mode for compatbility
> * Renamed from "vfio/igd: Remove legacy mode"
> Link: https://lore.kernel.org/all/20250224182927.31519-1-tomitamoeko@gmail.com/
> 
> Tomita Moeko (10):
>    vfio/igd: Remove GTT write quirk in IO BAR 4
>    vfio/igd: Do not include GTT stolen size in etc/igd-bdsm-size
>    vfio/igd: Consolidate OpRegion initialization into a single function
>    vfio/igd: Move LPC bridge initialization to a separate function
>    vfio/pci: Add placeholder for device-specific config space quirks
>    vfio/igd: Refactor vfio_probe_igd_bar4_quirk into pci config quirk
>    vfio/igd: Decouple common quirks from legacy mode
>    vfio/igd: Handle x-igd-opregion option in config quirk
>    vfio/igd: Introduce x-igd-lpc option for LPC bridge ID quirk
>    vfio/igd: Fix broken KVMGT OpRegion support
> 
>   hw/vfio/igd.c        | 529 +++++++++++++++++++------------------------
>   hw/vfio/pci-quirks.c |  51 +----
>   hw/vfio/pci.c        |  33 +--
>   hw/vfio/pci.h        |  11 +-
>   4 files changed, 248 insertions(+), 376 deletions(-)
> 


Applied to vfio-next.

Thanks,

C.



