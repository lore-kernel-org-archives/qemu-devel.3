Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0F3C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 05:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOUs3-0005E8-U7; Mon, 09 Jun 2025 01:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uOUs0-0005Df-5r
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 01:16:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uOUrw-0006nR-SA
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 01:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749446183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xIj3bwdK3xF5l0idjlHnLpavp2amLY/arr5aX2FHYIs=;
 b=BBHdnDLjq42Y7m86Ce7zgIB9QLRj5LrpU0aOqHWS9VDONsQMm6iojfdz7DU7M9kREIxyYU
 +rKbo6G0Oo//pePSBqX4I3FFpcUR/tvwVp7i/RCmR/0mdkY5UQ7ZnI/7m2coR42LeQLPxk
 zXI3O0e+1JSo/pRjIQLoTE1qG4NstfY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-ePYtnzBVOoSQIv8XafWYfw-1; Mon, 09 Jun 2025 01:16:20 -0400
X-MC-Unique: ePYtnzBVOoSQIv8XafWYfw-1
X-Mimecast-MFC-AGG-ID: ePYtnzBVOoSQIv8XafWYfw_1749446180
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-23507382e64so37627045ad.2
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 22:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749446179; x=1750050979;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xIj3bwdK3xF5l0idjlHnLpavp2amLY/arr5aX2FHYIs=;
 b=awOutV/yHri6sxipJqA1Z5y00ei70Eg5Rf/QevwUuzc8R50Vf1xLXcqqvK5lJSNCKC
 HeXlRt99zmDAQSlvRFpsVuytqhx6UXw5cEI9TDirDFIrQLDq9jUsb+FKt21ETeFWRTFu
 i7BSwyQO6iiu64RFgf3ZDBoKgKxLGk8S0QgE+v9/TIayQa2BPPk4b54pW50LOgJjFKJ2
 FNfekNWxENKcN9d0oruYUsKzvNU8zORn2cee7KNnBX0rPdptNv76qYFTOAl7YTLQa4St
 1BckEm2Kg4/7E9XxZXCEgDvPFSl21ag2MU4IIlVB3XV4wx2rGVZziWi01PsBndp9ZiBO
 llzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6MvEfc2oCvhOMmVw26nFZDdRMHedI1GISwZNrYI6neOPJuq9VujVwjbnU55SVKlNGhpRvvWbKIDz1@nongnu.org
X-Gm-Message-State: AOJu0Yyqji0vM8uMggEGLaejTGGYzOAqkY8ifxXjYB372rKrePMscRbS
 /D0RZtIMbeMWE3cWlTozSUswC2XbeuH3gaGPTKPqBnCIv8dZXt+Ml6lD/CXEK539JWanDnpFmd9
 md0/HuaG/ZHTy5Ipmz9yRGirRQYJThEai7WKUzsrZXiR+NKxqQsJez7/x
X-Gm-Gg: ASbGncuevXs0UsDx20tKR2G8Ap2EFxrgG2U56Uy1kPvmuIq/KrN4/vdUTEM5+eVFO0y
 BIyJIXVXx7IsbsYzzMVnRPAfaRRCxGdZb6PF5AK9w9o9licQhHTzDQZUxxZYJPCFsdqZECDhI2c
 tf0VsS8y/PVkv1JIVkqViCkXiAiy/YaPP+VmUjiXamdcAik++51ZuRpDxJN8bX8BKTETsFqnl5/
 bBgMAHDcHuRvRw4RftcVbrKBaw6rDLxiTsEmADgr1eh31xFycxnRxNTcmVPcfyOd232PCNgwIup
 pc3rq4Y6EEL6qvA=
X-Received: by 2002:a17:903:1107:b0:235:225d:3098 with SMTP id
 d9443c01a7336-23601debd84mr163971995ad.46.1749446179581; 
 Sun, 08 Jun 2025 22:16:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbxRQ5KHTHwQjMCx9K1gh5f4ie+gizFc0aGEiP+WBeKi8yfDLa7no/GNNN4twhBo53NEG37Q==
X-Received: by 2002:a17:903:1107:b0:235:225d:3098 with SMTP id
 d9443c01a7336-23601debd84mr163971805ad.46.1749446179288; 
 Sun, 08 Jun 2025 22:16:19 -0700 (PDT)
Received: from [10.66.193.79] ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603077fcbsm47245675ad.47.2025.06.08.22.16.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Jun 2025 22:16:18 -0700 (PDT)
Message-ID: <c2e0ece0-1ee1-4867-b01c-20e847ef6af3@redhat.com>
Date: Mon, 9 Jun 2025 13:16:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ramfb: Add property to control if load the romfile
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <20250606070234.2063451-1-shahuang@redhat.com>
 <aEKeNSc8mAZ8vhGj@redhat.com>
 <cf34f5b2-d422-453f-85d4-15938ae59e9f@redhat.com>
 <c373ee81-d094-4b40-93c9-5ece6e24e520@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <c373ee81-d094-4b40-93c9-5ece6e24e520@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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



On 6/6/25 4:07 PM, Cédric Le Goater wrote:
> On 6/6/25 10:06, Cédric Le Goater wrote:
>> On 6/6/25 09:52, Daniel P. Berrangé wrote:
>>> On Fri, Jun 06, 2025 at 03:02:34AM -0400, Shaoqin Huang wrote:
>>>> Now the ramfb will load the vgabios-ramfb.bin unconditionally, but only
>>>> the x86 need the vgabios-ramfb.bin, this can cause that when use the
>>>> release package on arm64 it can't find the vgabios-ramfb.bin.
>>>>
>>>> Because only seabios will use the vgabios-ramfb.bin, load the rom logic
>>>> is x86-specific. For other !x86 platforms, the edk2 ships an EFI driver
>>>> for ramfb, so they don't need to load the romfile.
>>>>
>>>> So add a new property use_legacy_x86_rom in both ramfb and vfio_pci
>>>> device, because the vfio display also use the ramfb_setup() to load
>>>> the vgabios-ramfb.bin file.
>>>>
>>>> After have this property, the machine type can set the compatibility to
>>>> not load the vgabios-ramfb.bin if the arch doesn't need it.
>>>
>>> Can you make this a series, with an additional patch that updates the
>>> current in-dev machine types to use this new property, so we're clear
>>> about the proposed usage.
>>
>> yes. And please change the vfio-pci property name to use underscores.
> 
> Sorry, to *not* use underscores : use-legacy-x86-rom

Thanks for pointing out it. Will fix it.

Thanks.

> 
> 
> Thanks,
> 
> C.
> 
> 

-- 
Shaoqin


