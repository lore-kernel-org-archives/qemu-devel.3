Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F56C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 12:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9NzL-0004pI-7G; Mon, 28 Apr 2025 08:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u9Nz9-0004ob-0V
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:53:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u9Nz5-0002Yt-Am
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745844795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iqV2b/L+5lcqR3kWDA28ARQJFR770kRDdI90XKn+n4k=;
 b=Pnj+P8CK5yJlduonCVswWMEnSbX7JaeK0zB7UuNSoirpAPBlzr6Aj9Hiw6gFWRfWJUbi2+
 0CqOED6U87mN/KHSdvF1Z6szEnR8JAlHCpvhjzr7/xt6E9vhZXW7vDJSsQ6iuJhvikNuuf
 WjHv03LYg1o0xeRr7gtbtSufPar7czg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-VJG1JIavNTOrZ6RSQ70CiQ-1; Mon, 28 Apr 2025 08:53:14 -0400
X-MC-Unique: VJG1JIavNTOrZ6RSQ70CiQ-1
X-Mimecast-MFC-AGG-ID: VJG1JIavNTOrZ6RSQ70CiQ_1745844793
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-44059976a1fso19005555e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 05:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745844793; x=1746449593;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqV2b/L+5lcqR3kWDA28ARQJFR770kRDdI90XKn+n4k=;
 b=HM4s4EwGkA1G3JIHfb9jk9yZY3Dq3Tri4uftQ2c2XXF35polGe/PiWjesSJp01+AQw
 mFugAXwffN32e3akOKN+Gjz3Tc24WJ3lmgClHmwV2TCDIkX5koi7Ymgd9R9tZkbHztHB
 TxGzG+K226FLuGQN+QijdgeeW4nDbglxy4A1JYppJbzND21v+C2aUS4mNkaBQZgxNxle
 wOc5v79e3Z8YsoIa5o5UjE9w1j4fTG2Fb/OK2WdB0ETnSAZzAy2d6o3BYJX8FJZCgzZd
 vWTBKy/ms1l61MnvEVfZG6E48KnEsNzEAKfJXp4gW9kFUC4+hbRdhtDcYZCQXEokfxHm
 +zPA==
X-Gm-Message-State: AOJu0YxMvaOsp3yzYAWPwhnuh9WLuL6GRH86MdzapC95ogLWIJgrCLzb
 cPTEov97fzdfB4nuW3mSp6fXBMGs9PpfxofnSmXwrKkIVU+PJ8ceKVIomu48H1iID4BZVnxDkEm
 GM6Vi4a/eRKf6WfT51q39glqMBKbnrmfB+zClatdIhuGpSFwhRpRNiLEXXbFH
X-Gm-Gg: ASbGncv8l1lj7beMsYYenV0j9wNgJAT4+5hWSlGqSHWtBt2b0ju0e9FpM+KwPZmwJKh
 hY+Y2fGApS4elaji4tXZ/pOWGRoKQOVlDRjkJlKyqbCGfg1W9GORM8SETJVzbBI8hsGclbzFPG8
 I54TnmQzUF7pqFqP44wX41ygcPA8O+wi575rnA7F/63uvTW1vVuDyyEQZ1x2kCB5/TnTrwnRsOt
 69bSBS3oIN/61PYciUAXxmz42Imj8sfJmIZaeAt8N2KDyR4SRbp1WL1xcBk/0Dk0W7xDo+o1GIi
 1P3lVMX05/cFBJkt2I7gBvyRhE6OYifS0Yut+oUF2GeJXzg7OA==
X-Received: by 2002:a5d:6483:0:b0:3a0:8429:a2e2 with SMTP id
 ffacd0b85a97d-3a08429a34cmr2636258f8f.32.1745844792740; 
 Mon, 28 Apr 2025 05:53:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXuqtezZIM4fV9OZUcXx4iCjUovmeav1NenU03d7rcG/VykJ1Fhrr0Nb7VvAvAko+cNqO5Dg==
X-Received: by 2002:a5d:6483:0:b0:3a0:8429:a2e2 with SMTP id
 ffacd0b85a97d-3a08429a34cmr2636239f8f.32.1745844792275; 
 Mon, 28 Apr 2025 05:53:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2a1dc3sm154066665e9.13.2025.04.28.05.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 05:53:11 -0700 (PDT)
Message-ID: <2e2df505-03c6-403d-83e8-5b784ec80ed9@redhat.com>
Date: Mon, 28 Apr 2025 14:53:10 +0200
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
 <08d7eb98-4d0c-419a-b143-88b7852a62a5@redhat.com> <aAuHk0WEUbS_inCn@lent>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aAuHk0WEUbS_inCn@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

On 4/25/25 15:01, John Levon wrote:
> On Fri, Apr 25, 2025 at 02:46:48PM +0200, Cédric Le Goater wrote:
> 
>> After this patch, here is what we have for the base class :
>>      static const Property vfio_pci_base_dev_properties[] = {
>>          DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
>>                                  vbasedev.pre_copy_dirty_page_tracking,
>>                                  ON_OFF_AUTO_ON),
>>          DEFINE_PROP_ON_OFF_AUTO("x-device-dirty-page-tracking", VFIOPCIDevice,
>>                                  vbasedev.device_dirty_page_tracking,
>>                                  ON_OFF_AUTO_ON),
>>          DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
>>                             intx.mmap_timeout, 1100),
>>          DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>>                                  vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
>>          DEFINE_PROP("x-migration-multifd-transfer", VFIOPCIDevice,
>>                      vbasedev.migration_multifd_transfer,
>>                      vfio_pci_migration_multifd_transfer_prop, OnOffAuto,
>>                      .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
>>          DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>>                           vbasedev.migration_events, false),
>>          DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>>          DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
>>                           vbasedev.ram_block_discard_allowed, false),
>>          DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, no_kvm_intx, false),
>>          DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, no_kvm_msi, false),
>>          DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),
>>          DEFINE_PROP_BOOL("x-no-kvm-ioeventfd", VFIOPCIDevice, no_kvm_ioeventfd,
>>                           false),
>>          DEFINE_PROP_BOOL("x-no-vfio-ioeventfd", VFIOPCIDevice, no_vfio_ioeventfd,
>>                           false),
>>          DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice, vendor_id, PCI_ANY_ID),
>>          DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice, device_id, PCI_ANY_ID),
>>          DEFINE_PROP_UINT32("x-pci-sub-vendor-id", VFIOPCIDevice,
>>                             sub_vendor_id, PCI_ANY_ID),
>>          DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
>>                             sub_device_id, PCI_ANY_ID),
>>          DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
>>                                      OFF_AUTO_PCIBAR_OFF),
>>      };
>> and for vfio-pci :
>>      static const Property vfio_pci_dev_properties[] = {
>>          DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
>>          DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
>>          DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
>>          DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
>>                                  display, ON_OFF_AUTO_OFF),
>>          DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
>>          DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
>>          DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
>>                          VFIO_FEATURE_ENABLE_VGA_BIT, false),
>>          DEFINE_PROP_BIT("x-req", VFIOPCIDevice, features,
>>                          VFIO_FEATURE_ENABLE_REQ_BIT, true),
>>          DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
>>                          VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>>          DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
>>          DEFINE_PROP_BIT("x-igd-lpc", VFIOPCIDevice, features,
>>                          VFIO_FEATURE_ENABLE_IGD_LPC_BIT, false),
>>          DEFINE_PROP_ON_OFF_AUTO("x-igd-legacy-mode", VFIOPCIDevice,
>>                                  igd_legacy_mode, ON_OFF_AUTO_AUTO),
>>          DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
>>                           no_geforce_quirks, false),
>>          DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
>>                                         nv_gpudirect_clique,
>>                                         qdev_prop_nv_gpudirect_clique, uint8_t),
>>      #ifdef CONFIG_IOMMUFD
>>          DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
>>                           TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
>>      #endif
>>          DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
>>      };
>> Graphic property and host device definitions are excluded from the
>> base class it seems. This might fit vfio-user needs but it looks
>> like a quick hack from the vfio-pci side. It needs more work.
> 
> Can you suggest a preferred approach? I'm definitely not wedded to the current
> way (after all, I didn't write it !), but I'm not sure how else we could do it.
> 
> Perhaps if there's some way to deregister properties when vfio-user
> instantiates?
> 
>>>> Can you remind me why the vfio-pci class for vfio-user can not
>>>> inherit directly from vfio-pci ?
>>>
>>> For the above reason: we'd inherit many properties that don't work for
>>> vfio-user.
>>
>> What do you mean by "don't work" ? functionally irrelevant ?
> 
> I don't know the answer to that in general. Certainly some are just irrelevant
> (like sysfsdev), but it's entirely possible the other stuff actively breaks.
> Presumably you agree it's not good to introduce potential footguns for users
> here?
Do we know which properties are required for the vfio-user variant of the
vfio-pci device ?

I'd be tempted to start with an empty abstract vfio-pci-base device class.
This wouldn't change the current vfio-pci device much, and the vfio-user
variant would duplicate the necessary properties.


Thanks,

C.


