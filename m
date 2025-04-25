Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AC2C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 12:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8ISP-0006yR-0b; Fri, 25 Apr 2025 08:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8ISN-0006xW-Bo
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:47:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8ISL-0006lU-5u
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745585220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wW271rH+0LI6uoHD0TgyXK9DjVc6qkJzot1aBoyyM9E=;
 b=Eqp8XOwPTEHNi1w6azWQsprnUkyqnoHYkwAYIlN5p/NtNxdA3pDUvQSBp8t4bMcBpsRcw/
 s9AIX9Gyc5U5qPqYpORuNaa6LHbKdIQOKZ8ovEhjWJl4g0Gxwkuhq77gRKQsQ8Jndon2Kb
 2GvyofkY0Vu0Tw/WUQTgD9PI2Ph619k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-63b9QgY3P3ud1e9DTfNyEw-1; Fri, 25 Apr 2025 08:46:52 -0400
X-MC-Unique: 63b9QgY3P3ud1e9DTfNyEw-1
X-Mimecast-MFC-AGG-ID: 63b9QgY3P3ud1e9DTfNyEw_1745585211
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39979ad285bso1036771f8f.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 05:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745585211; x=1746190011;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wW271rH+0LI6uoHD0TgyXK9DjVc6qkJzot1aBoyyM9E=;
 b=liAAEv61Pxd0aTn2hmwi6EFRgaiy7rQDFI3mSIaEYfIUtaeWSYZslSBjpDlKssBKY6
 4PCEXU8wzBI9xZU3fAwyNeCPTThUYXhHNZqhKx+hjeMFBUmfAAa8k/1riCY7q5oGj8j8
 mjdVEM8ahKwyverPWyDT5T4vZv6L5VzTnUFV1V2XifBW9avPPIwvxUE2cN3vaooJG8ss
 C56NmcWhso/yCvD9GZ5DcyZxgqTxZCtes3befEMJLJRMh8p5jgRbnuAuYzU/1WuwPomF
 rw9LxbFvI2kqHDwG1F+cHTMx87wEaeTAa2/Pgy8ayZRR8Bws6RcRKIwVZLkJvyQrnW4F
 NMYg==
X-Gm-Message-State: AOJu0YyAF+5dS+Luz1FLSbtJGrPWWftP2Coy6eexkRhqfGdMuGsS8dgH
 eZ71A5SZ5pdDd00JIMrECFKgDqZQp6vdWVWBgbuuQrZO5qj1Ah1aINao/gCdOL2F3XZXH/sHbrD
 jYzo5diRKY5jEYVPsgsfxiBeug09RpJlilYAeU+wzWxqI2JzrrcU8
X-Gm-Gg: ASbGncvFpQtK0Bm3jKpcpg4SZbD6xAtyoaK1ch4b5df5OlBVXinOAlYgE8Esq1ZPSUz
 b+GvEFGmmOLwBTyk+3xqFY/WmEiSb0AhqohP0nIr3czmp8j98dUxJSBQtktlXiIN4rT9MdPmtRY
 fqLER/oSyJ5Zp/N1p41g4ilH0OaqJDZ64cq8yvWAEPZBSqL7D0Et/BrEpnF6zj+mpP+VZxAPAR6
 9zJwelQC9FBqBgxQ962GRX05J5IzzdPQYCKDKpIR25ZamNdYMmFBRIY3A/YzC19HEoQjV1fZE21
 +c+txAEt/XEclFun1+OSnRQ5xw8Iy/jDxSwn3Jkq50EhPqI=
X-Received: by 2002:a05:6000:40df:b0:391:122c:8b2 with SMTP id
 ffacd0b85a97d-3a074e420bcmr1865894f8f.31.1745585210927; 
 Fri, 25 Apr 2025 05:46:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtAAh6k/P3WcQ14Ut6h9bi07QjI93tfqxSAIzeGUSffxDhP5TpU/BcMDnTN+f/+4kkQuNgRQ==
X-Received: by 2002:a05:6000:40df:b0:391:122c:8b2 with SMTP id
 ffacd0b85a97d-3a074e420bcmr1865881f8f.31.1745585210486; 
 Fri, 25 Apr 2025 05:46:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5cb16sm2230142f8f.84.2025.04.25.05.46.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 05:46:49 -0700 (PDT)
Message-ID: <08d7eb98-4d0c-419a-b143-88b7852a62a5@redhat.com>
Date: Fri, 25 Apr 2025 14:46:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] vfio: add vfio-pci-base class
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-9-john.levon@nutanix.com>
 <3f53b147-2517-4650-8e87-0b6bc7f36794@redhat.com> <aAqyga6DrXMBU2S-@lent>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aAqyga6DrXMBU2S-@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

On 4/24/25 23:52, John Levon wrote:
> On Thu, Apr 24, 2025 at 05:17:28PM +0200, Cédric Le Goater wrote:
> 
>> !-------------------------------------------------------------------|
>>   CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> On 4/9/25 15:48, John Levon wrote:
>>> Split out parts of TYPE_VFIO_PCI into a base TYPE_VFIO_PCI_BASE. The
>>> base type contains properties generic to all vfio-pci implementations
>>> (although we have not yet introduced another subclass).
>>>
>>> Note that currently there is no need for additional data for
>>> TYPE_VFIO_PCI, so it shares the same C struct type as
>>> TYPE_VFIO_PCI_BASE, VFIOPCIDevice.
>>
>> I don't understand how the properties are distributed between the
>> abstract vfio-pci base class and the vfio-pci class. What's the
>> rationale ?
> 
> It's for properties that apply to all vfio pci classes, and those that are
> specific to the kernel vfio pci implementation.

It seems quite vague to me.

After this patch, here is what we have for the base class :
     
     static const Property vfio_pci_base_dev_properties[] = {
         DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
                                 vbasedev.pre_copy_dirty_page_tracking,
                                 ON_OFF_AUTO_ON),
         DEFINE_PROP_ON_OFF_AUTO("x-device-dirty-page-tracking", VFIOPCIDevice,
                                 vbasedev.device_dirty_page_tracking,
                                 ON_OFF_AUTO_ON),
         DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
                            intx.mmap_timeout, 1100),
         DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                                 vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
         DEFINE_PROP("x-migration-multifd-transfer", VFIOPCIDevice,
                     vbasedev.migration_multifd_transfer,
                     vfio_pci_migration_multifd_transfer_prop, OnOffAuto,
                     .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
         DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
                          vbasedev.migration_events, false),
         DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
         DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
                          vbasedev.ram_block_discard_allowed, false),
         DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, no_kvm_intx, false),
         DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, no_kvm_msi, false),
         DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),
         DEFINE_PROP_BOOL("x-no-kvm-ioeventfd", VFIOPCIDevice, no_kvm_ioeventfd,
                          false),
         DEFINE_PROP_BOOL("x-no-vfio-ioeventfd", VFIOPCIDevice, no_vfio_ioeventfd,
                          false),
         DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice, vendor_id, PCI_ANY_ID),
         DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice, device_id, PCI_ANY_ID),
         DEFINE_PROP_UINT32("x-pci-sub-vendor-id", VFIOPCIDevice,
                            sub_vendor_id, PCI_ANY_ID),
         DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
                            sub_device_id, PCI_ANY_ID),
         DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
                                     OFF_AUTO_PCIBAR_OFF),
     };
     
and for vfio-pci :
     
     static const Property vfio_pci_dev_properties[] = {
         DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
         DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
         DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
         DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
                                 display, ON_OFF_AUTO_OFF),
         DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
         DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
         DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
                         VFIO_FEATURE_ENABLE_VGA_BIT, false),
         DEFINE_PROP_BIT("x-req", VFIOPCIDevice, features,
                         VFIO_FEATURE_ENABLE_REQ_BIT, true),
         DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
                         VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
         DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
         DEFINE_PROP_BIT("x-igd-lpc", VFIOPCIDevice, features,
                         VFIO_FEATURE_ENABLE_IGD_LPC_BIT, false),
         DEFINE_PROP_ON_OFF_AUTO("x-igd-legacy-mode", VFIOPCIDevice,
                                 igd_legacy_mode, ON_OFF_AUTO_AUTO),
         DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
                          no_geforce_quirks, false),
         DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
                                        nv_gpudirect_clique,
                                        qdev_prop_nv_gpudirect_clique, uint8_t),
     #ifdef CONFIG_IOMMUFD
         DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
                          TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
     #endif
         DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
     };
    
Graphic property and host device definitions are excluded from the
base class it seems. This might fit vfio-user needs but it looks
like a quick hack from the vfio-pci side. It needs more work.

>> Can you remind me why the vfio-pci class for vfio-user can not
>> inherit directly from vfio-pci ?
>
> For the above reason: we'd inherit many properties that don't work for
> vfio-user.

What do you mean by "don't work" ? functionally irrelevant ?

Thanks,

C.


