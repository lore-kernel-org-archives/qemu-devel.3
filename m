Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3D3C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoU6-0006NG-Bf; Wed, 04 Jun 2025 09:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uMoU4-0006My-DM
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:48:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uMoU2-0007wu-L7
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749044924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JMm9PBekN37u8clteVPeB2K5fqpH9iRWIUuwAmCwxoM=;
 b=IDs3yEsFoW1j8dmHyZuavWB6umlF3T0UsDN2ms6vwEfj1uBWIUmbHtzvmTerkglqsoQ/DV
 vnwP9R45Nn0dHAfgBaRnFGLi46LXHsplGtWSFVpMam2gK+w6SHT2qmmFy73gHdF53Vp4d9
 f9GrU/Bworgbnu+tph+ScqYuXIkzbQ8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-E6RnXppMPseDIKATOL5OZQ-1; Wed, 04 Jun 2025 09:48:43 -0400
X-MC-Unique: E6RnXppMPseDIKATOL5OZQ-1
X-Mimecast-MFC-AGG-ID: E6RnXppMPseDIKATOL5OZQ_1749044922
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a523ce0bb2so263532f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749044922; x=1749649722;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JMm9PBekN37u8clteVPeB2K5fqpH9iRWIUuwAmCwxoM=;
 b=Q82LRpeeUFxLT8Mt0jBvqIrikLqNFHuGUK8btSsBPUA41Bnd0Moao9/WeGV6+v07O7
 oI8vMcik2yK9xnu/jZ/0WexFKWp44QH8Be4OPd6lMfZZCySr8c26qkrmaoYxXyzk/8/J
 CdlD2mR2pNKbHaxb5EZtcm7IcssThdKoUv6D+eVVAT1cDXSPQCTrPdbeaXrZMz4wLMM2
 9VmzqbFVpAzlgbec9YZD3F9B9d1BQpz3nKFZ3tBhfn/wIKmlBJDSvre81w72GlZ0fWro
 4+AaAScE23hEq5+qo2XBlpO31aHVNf6LDZadx12rSVihYjDGVGx8HPnXNNv/5eDgaC8g
 o91g==
X-Gm-Message-State: AOJu0YzIIqD3Ibdb9hbOosY9Qeg3JR9KZKUxi/COHHcjOD83jwl+ms4N
 LbNjafuDw7rFn4zUu5YDh7eOjC0NJj4ikGrAQfKQiC25fq2u2A8DX6iR76iPHn+RnYVVT3ZKjTV
 7EdpQ/OfYkfYC4sLttC+PJWYKuvVRTEPwyxYE+Erpml/HSTdnPtwQ7ZaJ
X-Gm-Gg: ASbGncs05P3nga0ZW/HqI3BLjMrMdtBSxZGigqTO8AsBLPk6yKkGOP9gGV8jkXvOoZG
 +ZANEjOpazl5U+TXiZRf8BGpCcebE0/2M3UDS5cF8tR4toItXUobTCwCaT/rZjhoSC3H04+8TrS
 +6rABVnO2qQzO3lF8e75LYT0+3AjTKkCzw4WI+RT+Rov3bzmAqnBN4NBAAMVwqCg+c5vjcYx1VR
 Eg8yHuFkZx5di+tl04P4HwZbvTsqWvsexEZ/QjQ70jo0oz5d06XMX6jww9sq6WacyT8dcVizf9A
 ZxgRNuw=
X-Received: by 2002:a05:6000:188f:b0:3a4:dd8e:e16d with SMTP id
 ffacd0b85a97d-3a51d9344f8mr2439398f8f.15.1749044922395; 
 Wed, 04 Jun 2025 06:48:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoguaV55eI4D1XjhF6Bny2y6kMOciYYWSFmtf4Gbyit9jNIPj2QBRCJFJnKIr2T1ysUpcW9g==
X-Received: by 2002:a05:6000:188f:b0:3a4:dd8e:e16d with SMTP id
 ffacd0b85a97d-3a51d9344f8mr2439373f8f.15.1749044921986; 
 Wed, 04 Jun 2025 06:48:41 -0700 (PDT)
Received: from [192.168.1.46] ([92.174.52.117])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8000e3esm199673745e9.22.2025.06.04.06.48.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 06:48:41 -0700 (PDT)
Message-ID: <76b58b82-a867-4577-8644-88e419a8d85f@redhat.com>
Date: Wed, 4 Jun 2025 15:48:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 16/43] pci: skip reset during cpr
To: Steven Sistare <steven.sistare@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-17-git-send-email-steven.sistare@oracle.com>
 <d62bd9c6-1660-4d16-8d7d-5445ba6c5031@redhat.com>
 <20250601150607-mutt-send-email-mst@kernel.org>
 <899ee161-2c5d-4aa2-aa64-5135b26bc3ff@oracle.com>
 <0a50d630-57c7-4f05-93c7-73be8f575873@redhat.com>
 <c01c7c19-2422-45c7-9582-09ca37170974@redhat.com>
 <468008fc-a86f-4b90-86c3-1109d68f6fc2@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <468008fc-a86f-4b90-86c3-1109d68f6fc2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> I don't see any advantage to making this a class attribute.  I looked for examples
> of using such attributes for vfio to configure pci, and found very little.  It
> sounds like overkill since vfio already sets and gets PCIDevice members directly
> in many places.
> 
> I defined skip_reset_on_cpr based on this existing example:
> 
> vfio_instance_init()
>      pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS

pci_dev->cap_present can be modified at realize time. skip_reset_on_cpr
is a constant, for which a class attribute are more appropriate.
This is minor.

Michael,

   Are you ok with the 'skip_reset_on_cpr' bool ?

>> I wonder if the resettable interface, and more specifically the
>> RESET_TYPE_SNAPSHOT_LOAD type, might be useful. Have you explored
>> this alternative ?
> 
> RESET_TYPE_SNAPSHOT_LOAD (or a new type such as RESET_TYPE_CPR) would skip
> reset for all devices, but we only skip for vfio_pci.  All other devices
> (including virtio) save and restore state using standard migration vmstate,
> and must call reset.
OK.

C.


