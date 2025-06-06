Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F701C5B543
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 03:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNNdP-0006Vx-1y; Thu, 05 Jun 2025 23:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uNNdF-0006VP-K2
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 23:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uNNdA-00060a-Ue
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 23:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749180029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjQhcxCbIw4eqaqIgYdffwaji/bLqp74RCiYxt5Trjs=;
 b=hoKHqGRQtkAHqGD0z6EobKjzuPSSfbTov6fO9O/CpuOl8/GRO4Xr8ROJcxnlmPPBTSKtqQ
 Co8S2ASZUV3Id/9zns3vUuLrb81Vo2EeY90V0Nynlw/5D6h6159NQiFcc+ZmVm4/i0zZGq
 kCJXNqb2Gb4ZTE3lMtnm6tFkGJl0Vi8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-ZUh9qXTgPdiih_t2JqCaHg-1; Thu, 05 Jun 2025 23:20:28 -0400
X-MC-Unique: ZUh9qXTgPdiih_t2JqCaHg-1
X-Mimecast-MFC-AGG-ID: ZUh9qXTgPdiih_t2JqCaHg_1749180027
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b26e120e300so1943169a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 20:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749180027; x=1749784827;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PjQhcxCbIw4eqaqIgYdffwaji/bLqp74RCiYxt5Trjs=;
 b=oLtJd46WYcg2bs8uE+zgPXzeaNma//TZg/Fqhwl2H5DHAyU2+LiJ31MHFY5Nn1K6xO
 EhiPqQzN/vBviQlJtuewSQ0CY8oAYvuwjEdYpjHdWfBydGKGb65msze+f9n5bYj+YP2j
 mjQ3E+O/XWtKtJzWd/fVTEoCaUj/iVvow98W+pajycWy8S52cP4j+mS6H4GM4KyZBxN8
 yOjqlL+jyEdEVDBguFKPjkDfoZGo3V/FXU/EmIBPXY6zV7KhyHSWnzX/BCFHcnIpU4a9
 ZqaHrk+gpB+2nvjZP89YfieHvXbeU8dPKLGo/XDTJ3GtTVbAS8kg/Zpla/aB1CTEdwgw
 e6zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXW60tfRI9Ft+4j1sPKNQHVDgvkiz6MsuU78A90slEyDMfpSu6sFEvo57HhuWRviTMGszhWc3gcXoM@nongnu.org
X-Gm-Message-State: AOJu0YzDzKel0mUOsPfj+cvt03N4lNyBNa+cbVfxjskyNRJgvhKKX/Py
 KJCygebj8O0QR16iATI0cGXBa+Cr1eOGNkfqyux5Ik8Hx3zBSeTT25lW/Av4+xgwV8xuNnrJYsv
 SaS3ZZ17hEXmpZYeTZ7KupDQg6N1flUro82sjuaZLdi5jVqONM4ZAGdPP
X-Gm-Gg: ASbGnctQ7PBH8MnAzouphP+3GrrEj0JH35bjxAkrt9cYBg/l2jYCkWPiQFszcvzTwtv
 0DaLWjNgvbbGlJczRkS/6e8GW7neK7TjCQpJQSslM+Wd8dRteEMLhOoIvCtM9vl8sbeT57WpZln
 AFAtrvZEbVbycQEH6oG72MMKscVc7CVIfKdUv4PO91Ld8cU0aoADdU/JRNhEvC1tjenCIj1nlu+
 hBkXueeyRnVjYXfGQv6cXjuA0OdRUBEb7Z8wc4nHHLH5Vl64qOSmyENokNkQLHmGhI0sBmYJt4I
 cimps5rqxGqHMZLel7sAGCO5EQ==
X-Received: by 2002:a17:903:192:b0:234:ed31:fc99 with SMTP id
 d9443c01a7336-23601d00625mr23978255ad.21.1749180026899; 
 Thu, 05 Jun 2025 20:20:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQe/QwSitGC1z8ZKhMkEbZ1OchO4ehnGoeVZN0QOQMGHeIeaaOiiOPJJRR6zG0EDI5SFWR5w==
X-Received: by 2002:a17:903:192:b0:234:ed31:fc99 with SMTP id
 d9443c01a7336-23601d00625mr23977985ad.21.1749180026595; 
 Thu, 05 Jun 2025 20:20:26 -0700 (PDT)
Received: from [10.72.116.52] ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2360307802fsm3169295ad.20.2025.06.05.20.20.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 20:20:25 -0700 (PDT)
Message-ID: <27ea9c1e-61eb-4ea4-b3e4-e9d06b4b4ce5@redhat.com>
Date: Fri, 6 Jun 2025 11:20:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ramfb: Add property to control if load the romfile
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250605030351.2056571-1-shahuang@redhat.com>
 <746b078e-bd06-4361-aec7-2301412abb18@linaro.org>
 <kep5frpl24d74evoyf367pqkyoj6xez2pirk7xlzcoompyzq4c@ouxab77sdm55>
 <68f4f244-db07-4f65-9ca5-3cb9b70c9e61@linaro.org>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <68f4f244-db07-4f65-9ca5-3cb9b70c9e61@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi, guys

Thanks for all of your suggestions.

On 6/5/25 11:11 PM, Philippe Mathieu-Daudé wrote:
> On 5/6/25 14:21, Gerd Hoffmann wrote:
>>    Hi,
>>
>>>> Now the ramfb will load the vgabios-ramfb.bin unconditionally, but only
>>>> the x86 need the vgabios-ramfb.bin, this can cause that when use the
>>>> release package on arm64 it can't find the vgabios-ramfb.bin.
>>
>>> Simpler to directly pass the ROM path instead of using a boolean,
>>> so board (or CLI) could pass path to non-x86 rom.
>>
>> The rom is loaded into a fw_cfg file which only seabios will look at.
>> So this rom logic is x86-specific.
>>
>> edk2 ships an EFI driver for ramfb, that is how ramfb is used on !x86
>> platforms today, and I don't expect that to change.
>>
>> IMHO a bool is perfectly fine here, I don't think we will ever need the
>> flexibility to specify some other rom here.
> 
> Understood, better then! Maybe name the boolean "use_legacy_x86_rom" and
> add a comment explaining EFI driver is expected on !x86?

I think the "use_legacy_x86_rom" is good, I will change the name to it. 
And I will add a comment to explain it.

Thanks,
Shaoqin

> 
> Regards,
> 
> Phil.
> 

-- 
Shaoqin


