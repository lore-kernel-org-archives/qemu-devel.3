Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D31FC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 10:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl3qp-000296-0s; Thu, 20 Feb 2025 05:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tl3qZ-00027Y-4F
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:32:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tl3qK-00069P-QC
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740047503;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKt/skCUk5vHOzbp6CP8AXEJLpW+OsLEcujEVE6UPSI=;
 b=ihtZElmVdovIR3Dm6fp0t7+kHeUXuPVj99+Rl6uKF7sQSd5PtW1VmGcNMZ95/Ecd/HDeyA
 ufHhrZPSuLBMPJdmCrRuFYz7p/GglXMoLEKY3QEvpWXlKSrx1TKEWGkNkSatxhWWbWrpoF
 /MlIBeHrnnbxawMQXE6gAjOisnGfb/Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-hNyBps4LNPSmP599lyY0RA-1; Thu, 20 Feb 2025 05:31:41 -0500
X-MC-Unique: hNyBps4LNPSmP599lyY0RA-1
X-Mimecast-MFC-AGG-ID: hNyBps4LNPSmP599lyY0RA_1740047500
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-438da39bb69so5012605e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 02:31:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740047500; x=1740652300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qKt/skCUk5vHOzbp6CP8AXEJLpW+OsLEcujEVE6UPSI=;
 b=OzFlxsmgHnGDjk/BIT3Ou229vQk1fgkzY0s5buosOjx0WDqpmzoqfujNyu0XQa1Vb3
 Ne4cKzYf521KY5+dGCT49MYyZ3Nvvz4atPyPLcWPGMz6XH7t3/gr7NLczwvdxgY2DvTC
 ydoMapEsJeaL5+lVs/Qz5iFMNT7iChZTPWUNN5FXRnks4a+P7A8thMqLselAMmpSxScz
 STh8K/RakBU1mFPEfl59uF0s20uBnd8tteRPI/zfocpM1iOUoMZ/y03fa5CYISssL3qJ
 odSxCO3hUaFyS4d+GVIDH1vUALTa3HIObuSLc+T0uazuA8IbTjXYYIQv+3M1C2tgaX/c
 dCvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJaadOULurO1nrDdu6J5MzbGF5XM4jXxdg1eJifzB0aw1mJOA02C2H6nTabMeHEYknzt+HEdiVevTl@nongnu.org
X-Gm-Message-State: AOJu0Yx73Wr2GsxL48dwDkS44hagUL3QVCtjzTkD98x9RsbS1sCcs4Ak
 vyUgBxSBrMiNszVZ216a/GQbYkG5N/Qc1on3Yugi0Gb2OeO5kMiGn9DRbsgdrM/yE9a+vlmcQPj
 nMFYAu9K9+s3MR/KwJqKYZx4ZOCy3SifemN9fUf8TdUnJxy4dF43R
X-Gm-Gg: ASbGncsrfjXdM7esrcWsu31OqJTbf7FNKAZGQoAqA9z0uy1Wc/DzRDFocdy65tOoJsh
 JlDiC8/xeRuM6rFM+EndoKbLoUCo3OUXtVm0fW9xLhbxPRE71lIwRNl0aZMpPbB23LeXgTjrJMl
 V3WEsHaMcRFuX0x2mj2B1gcr2JbbO1hIDP/Ki6OXD49I0yXfG/8q7GNgXvm3xSWJ2QQqsg+EPBO
 KsrK6tthwvupKRdd4KxwmJPTjXdzaeI2mhJGOEBckqokzRGNen3+/nu/3iPwSDd9QGfRlDBmawB
 wKXzB+99SSfOfy3soPYfWafG4AjTfvAxrRFTUVReQbdU1DNjKj0w
X-Received: by 2002:a5d:6e89:0:b0:38f:231a:635e with SMTP id
 ffacd0b85a97d-38f58794638mr6506870f8f.25.1740047500266; 
 Thu, 20 Feb 2025 02:31:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFphOpNDqtsEISIwv5K6fCFdJEOU4/WyJAze3IDVTN0O39jWrSsL8JPOx/UNqUI0JiLW2RFag==
X-Received: by 2002:a5d:6e89:0:b0:38f:231a:635e with SMTP id
 ffacd0b85a97d-38f58794638mr6506825f8f.25.1740047499615; 
 Thu, 20 Feb 2025 02:31:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f8273sm19792375f8f.89.2025.02.20.02.31.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 02:31:38 -0800 (PST)
Message-ID: <4b7cfa82-c730-43af-ab47-53f20131104a@redhat.com>
Date: Thu, 20 Feb 2025 11:31:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] hw/vfio/pci: Prevent BARs from being dma mapped in
 d3hot state
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, clg@redhat.com,
 zhenzhong.duan@intel.com
References: <20250219175941.135390-1-eric.auger@redhat.com>
 <20250219115844.062c5513.alex.williamson@redhat.com>
 <20250219141945.5e74c7f3.alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250219141945.5e74c7f3.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi Alex,

On 2/19/25 10:19 PM, Alex Williamson wrote:
> On Wed, 19 Feb 2025 11:58:44 -0700
> Alex Williamson <alex.williamson@redhat.com> wrote:
>
>> On Wed, 19 Feb 2025 18:58:58 +0100
>> Eric Auger <eric.auger@redhat.com> wrote:
>>
>>> Since kernel commit:
>>> 2b2c651baf1c ("vfio/pci: Invalidate mmaps and block the access
>>> in D3hot power state")
>>> any attempt to do an mmap access to a BAR when the device is in d3hot
>>> state will generate a fault.
>>>
>>> On system_powerdown, if the VFIO device is translated by an IOMMU,
>>> the device is moved to D3hot state and then the vIOMMU gets disabled
>>> by the guest. As a result of this later operation, the address space is
>>> swapped from translated to untranslated. When re-enabling the aliased
>>> regions, the RAM regions are dma-mapped again and this causes DMA_MAP
>>> faults when attempting the operation on BARs.
>>>
>>> To avoid doing the remap on those BARs, we compute whether the
>>> device is in D3hot state and if so, skip the DMA MAP.  
>> Thinking on this some more, QEMU PCI code already manages the device
>> BARs appearing in the address space based on the memory enable bit in
>> the command register.  Should we do the same for PM state?
>>
>> IOW, the device going into low power state should remove the BARs from
>> the AddressSpace and waking the device should re-add them.  The BAR DMA
>> mapping should then always be consistent, whereas here nothing would
>> remap the BARs when the device is woken.
>>
>> I imagine we'd need an interface to register the PM capability with the
>> core QEMU PCI code, where address space updates are performed relative
>> to both memory enable and power status.  There might be a way to
>> implement this just for vfio-pci devices by toggling the enable state
>> of the BAR mmaps relative to PM state, but doing it at the PCI core
>> level seems like it'd provide behavior more true to physical hardware.
> I took a stab at this approach here, it doesn't obviously break
> anything in my configs, but I haven't yet tried to reproduce this exact
> scenario.
>
> https://gitlab.com/alex.williamson/qemu/-/tree/pci-pm-power-state

So if I understand correctly the BAR regions will disappear upon the
config cmd write in vfio_sub_page_bar_update_mapping(). Is that correct?
I will give it a try on my setup...
>
> There's another pm_cap on the PCIExpressDevice that needs to be
> consolidated as well, once I do some research to figure out why a
> non-express capability is tracked only by express devices and what
> they're doing with it.  Thanks,
I am not sure I get this last point though.

Thanks

Eric
>
> Alex
>


