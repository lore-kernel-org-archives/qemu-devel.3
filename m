Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91B7CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fXi-0007Wb-3S; Tue, 14 Oct 2025 09:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8fXc-0007Uw-4D
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8fXV-000414-Ve
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760450286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/BNTlvkxZn9XaDc6uy9zVT3MYPKhsoY+rc/uwu+eCiU=;
 b=F7GxGIWyQg0SSyGMOtvTKhc+MvBubRkw5TLsS/TiAhh78FXVdrCEB9k8z8eTc9Y35ahLRQ
 /8Ap810OaQ9ImVTMq6C3OSG4C6p9YYSTDSAabCYKc54SE2gpEU1uiIkGIBzU2ciWCiT56B
 7G9k40WJ6U+OrESEyvAyXHDxVF1I+HM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-6ao3ilDWPku1--0TPPwm0A-1; Tue, 14 Oct 2025 09:58:05 -0400
X-MC-Unique: 6ao3ilDWPku1--0TPPwm0A-1
X-Mimecast-MFC-AGG-ID: 6ao3ilDWPku1--0TPPwm0A_1760450284
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46b303f6c9cso4669135e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760450284; x=1761055084;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/BNTlvkxZn9XaDc6uy9zVT3MYPKhsoY+rc/uwu+eCiU=;
 b=cC4IEQ42woO8qyiPjvErysZFdoftTDq5BrHfvFyZn3NkGYTqEp9RcgUaJicXhdu0AV
 1FrP191mGbavLkZGo7TpanZrzNNDiB8yEB0JwdpT3rWbcDf5I787GE7IIBjQE0SCn18W
 zSbPyiOCv2afQmHoAb+70iPfD6f7WUuBDVC3d/LvUTnVsl1hC0NlCOSTxujGttOhmNCy
 /JBwoxZTCgLSo6fyFkOeSIr0KadirfSI9WPDHsqmbt3q6evyMnUOs8MWGffnIVghw8NU
 4YcAgiasJyqB5POuMVoadOBaY57mnLT6sPJ2yocT8ElzJ5XF3EshozCD239V4l65xgre
 orBQ==
X-Gm-Message-State: AOJu0YyPpOBNhZAlx7Nv3PB6l6uj1H/NZrgWpbIGYl2/2QGSwRzbENim
 SCxWpheTxyvBjfQnpqMBOVAVbGHggj7dmRLeSiWrqAMK5IZEBmlbcdu6mjqtePWMWdbNqP1B8EA
 YLh1T9t4jRK87BmGYzPb5fNDW0LIqzY00qnCfabtvgJzj4/CLFxJifyVL
X-Gm-Gg: ASbGncs+FYgkTQG9DrwQMxVNwcAUPLbABpr7V8nZzwQntLrxPmul55uBe7lzzRn3dVH
 4bCfFpUS4mzTqoVnHonJNVn0OJv9q0d1lVVETDTBd3CySeOD/6Cu3XDM7grAZ2mzs0znAGq8N3e
 ZwFEFKQyXPQRvPUSTruhqFuG6s6l08kXoLCe2TOukc7ib53atOKpfn+YQ+w4Y5J5JbN26WCpFNe
 CrgGG1p4ObifLs02xvMYxW/Wf2IJweugnFTsd2KOes6oDs+fu6yZYBQfJHs5Jg1uM25KKjZjMG3
 DIdbUCpmpWDQsXaeNrJoY6LUfQpok6g01C9y2bEx4f1wNb1QONS1PW9cVEjngfrTBcIcvWaPGvT
 AFmU=
X-Received: by 2002:a05:600c:3d87:b0:45b:7d77:b592 with SMTP id
 5b1f17b1804b1-46fa9a9ede8mr174685175e9.12.1760450284257; 
 Tue, 14 Oct 2025 06:58:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi8iXR8DW69AKbrKn2cFltqySicbVY/PbeTJhwwfOvX0OiMJHdbkM+9oIM6+wFpwWA2zLjhw==
X-Received: by 2002:a05:600c:3d87:b0:45b:7d77:b592 with SMTP id
 5b1f17b1804b1-46fa9a9ede8mr174684965e9.12.1760450283781; 
 Tue, 14 Oct 2025 06:58:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d49bsm24780977f8f.10.2025.10.14.06.58.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 06:58:03 -0700 (PDT)
Message-ID: <c20591f7-d743-4380-ab89-0efe254acfb2@redhat.com>
Date: Tue, 14 Oct 2025 15:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 25/28] vfio: add region info cache
To: Alex Williamson <alex@shazbot.org>, John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250509131317.164235-1-clg@redhat.com>
 <20250509131317.164235-26-clg@redhat.com>
 <6519c5b0-46d2-4097-bb37-7a78f9087f68@redhat.com> <aO5RAIX6WI0MerI-@lent>
 <cb4b8412-f1a5-4c7c-b2f4-d65b72194412@app.fastmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <cb4b8412-f1a5-4c7c-b2f4-d65b72194412@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/14/25 15:49, Alex Williamson wrote:
> On Tue, Oct 14, 2025, at 7:32 AM, John Levon wrote:
>> On Tue, Oct 14, 2025 at 03:16:46PM +0200, Cédric Le Goater wrote:
>>
>>>> +    /* check cache */
>>>
>>> It would be good to add an assert to check the index value. More important
>>> we need to fix an ugly "index out-of-bounds" bug that can occur when booting
>>> a VM with a vGPU :
>>>
>>>    -device vfio-pci-nohotplug,host=0000:27:00.4,display=on,ramfb=true ...
>>>
>>> The interesting part is :
>>>
>>>    Thread 1 (Thread 0x7ffff6891ec0 (LWP 11372) "qemu-kvm"):
>>>    #0  0x000055555581b83d in vfio_region_setup (obj=0x5555588c0b70, vbasedev=0x5555588c1630, region=0x555558a9c040, index=9, name=0x555555de94ba <str.68.llvm> "display") at ../hw/vfio/region.c:199
>>>    #1  0x00005555558208a4 in vfio_display_region_update (opaque=<optimized out>) at ../hw/vfio/display.c:449
>>>    #2  0x00005555556bdd6c in graphic_hw_update (con=0x555558acf830) at ../ui/console.c:143
>>>    #3  vnc_refresh (dcl=0x7fffec048050) at ../ui/vnc.c:3262
>>>    #4  0x00005555556a15cb in dpy_refresh (s=0x555558acf980) at ../ui/console.c:880
>>>    #5  gui_update (opaque=0x555558acf980) at ../ui/console.c:90
>>>    (gdb) p vbasedev->num_regions
>>>    $9 = 9
>>>
>>> Index 9 is beyond the maximum valid index of the reginfo array :/
>>>
>>> We didn't take into account the ioctl VFIO_DEVICE_QUERY_GFX_PLANE
>>> which can return region index 9 which is beyond the maximum valid
>>> index of the reginfo array :/
>>
>> My apologies - we hit the exact same issue internally, but with a much older
>> codebase, so I did not realise this could be an upstream problem as well!
>>
>> We put this down to a bug in the nvidia driver - surely it shouldn't be
>> reporting fewer regions than are actually in use. So we applied what we thought
>> to be a gross hack of boundary checking, and not using the region cache in case
>> it's beyond num_regions.
>>
>> To put it another way, the header file says:
>>
>>     217         __u32   num_regions;    /* Max region index + 1 */
>>
>> If it's not actually the max region index + 1, what are the expected semantics
>> of this field, or of region indices more generally? We could not find any clear
>> documentation on the topic other than this comment.
> 
> '9' only defines the end of the fixed, pre-defined region indexes for vfio-pci, ie. VFIO_PCI_NUM_REGIONS.  Beyond that, we support device specific regions.  The GFX region is one such device specific region.
> 
> We enumerate these regions based on vfio_device_info.num_regions and use the capabilities feature of the vfio_region_info to introspect the region type provided.
> 
> There is no fixed limit to the number of regions a device may expose, nor is vfio_device_info.num_regions necessarily a static value.  We're currently discussing a uAPI for generating special mappings to a region that could dynamically increase the reported regions.  Thanks,

We should then improve the VFIO region cache handling by reallocating
the reginfo array on demand.

Thanks,

C.



