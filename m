Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB19CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 17:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH3Ps-0002iE-6I; Thu, 06 Nov 2025 12:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vH3Pp-0002hl-LC
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:04:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vH3Pn-0000bk-MD
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762448690;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UFpWqKYMmqGCikkkLHkoub8Z5obHEa8RsABtEjH4jMo=;
 b=AgXgqW4NA8r684mA45aeOW/QOlPDoZlPXE8Zxiq4yQxjgWkk6s8NMrAh/RsRyZK7A8M7QY
 Hfe3i8lL+zh6rN8EtMUs7CAwHSrJ/UwMiQb5qp46WHAXHmtxF/wHseYjo33gCABkDAdcxe
 G+0kErK9NYScp3tX2LV0HU65m8JhImw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-QWMyXSf5POCnboUGr-tt0g-1; Thu, 06 Nov 2025 12:04:45 -0500
X-MC-Unique: QWMyXSf5POCnboUGr-tt0g-1
X-Mimecast-MFC-AGG-ID: QWMyXSf5POCnboUGr-tt0g_1762448684
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47761eafd18so7866355e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 09:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762448683; x=1763053483;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UFpWqKYMmqGCikkkLHkoub8Z5obHEa8RsABtEjH4jMo=;
 b=M7GoeXZ8lEzPPJFzlQBh+wHzp+dAGK/mlzi/nQ7uLof1l3oAmZt6AAnk5it1BUrlj/
 VanNbbxvT00clzs6YWD6f3avHqaA+xqRchAPDYZbv2rbeABerRGz+PgO2qRSElhlc/NB
 /BR/wH+Gw43L7jesGj2Sb3ZbH15k1NWC7v/szdNyMNPJ0/VVYVZaeRgdJlI3MLqfMee7
 3cNnljhJNVBMpuFE5L6kpThqDbQQn/K4nHfrQ6AfQRZeWc24tZa0GNbzqZqxqIcZMs+w
 3Hg59F7XBgbLFVhPkuxAH8Srt5elE4gdvDEFhHH6EyO6wFJv4Defn1LA/xYVKfe2fpzQ
 hjHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0fuplPSaRICrfPeGYAR1TCOBXQkKv/Oid+LOyWLpJ4LWymTpb62w8qK+NxmplSkOaT+fk1d/yZ34z@nongnu.org
X-Gm-Message-State: AOJu0Yw2uAiCH8spXIBnO1FiqUfjpHvdR5o12Rec8OGRx3XZrySP982e
 QYJHvti/Nb4V1N+jZ81y4BGlN7v5T1HPXjnFhRdWTlhhcr+p39QTIMOx/rV1RrXV4UcWxhaAQqn
 jUVpSZY53D55EEBu7hanWiQJcvVN25U3AX2tp7ZZNhVDdAqIMETk8WyiL
X-Gm-Gg: ASbGncvmX1A9ZhidD08ZAhglQnKDCBblQtsoBEaDutba6zZ5HBmxss1J58oGvbMDGdd
 IGKPx/5so/EjotqJ9s8Rvr3KOJ7W2g1mo9FLsvFPU48uj3hUFo5BNdX1Sl0Ek8HjDhS/lV6kpoF
 gkn7jbHElSEGLKmUANJQB4kA8aSLb28bi+uGgWXiptMNiN6fszZLoZDQFvQDr4cclpq5v1qPwNK
 ALmTi9rXSEfVM7ZIr27tSoIXrOk9mCkH3eaLlfH4AaYURqpgIsdCHqhlkURDqGoGAQ/CY9IZCRO
 Ophp+yx7FiZZ3mj7hMBNJUYXDlpfmGQIU0IVhohe/CV8vOxwUnd/2H/CBFDT7HtUorxA7/8g+eU
 fd1KUcA/s+BStwPpB3yLA3skLPgY0QJivHQ7k0VKcFxBFOA==
X-Received: by 2002:a05:600c:1381:b0:477:1bb6:17de with SMTP id
 5b1f17b1804b1-4776bcde56dmr166205e9.30.1762448683530; 
 Thu, 06 Nov 2025 09:04:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBvhiISIRyDknKinyeiseGaCgCfio8tCX0U7MSJdCIYCk5CFidg18Jp/9ypbnushOE9WZ6kw==
X-Received: by 2002:a05:600c:1381:b0:477:1bb6:17de with SMTP id
 5b1f17b1804b1-4776bcde56dmr165725e9.30.1762448682943; 
 Thu, 06 Nov 2025 09:04:42 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477640fb723sm20069075e9.10.2025.11.06.09.04.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 09:04:42 -0800 (PST)
Message-ID: <7f465d5b-109e-46ad-963e-c551ed85db7c@redhat.com>
Date: Thu, 6 Nov 2025 18:04:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <CH3PR12MB754815B9B902E7EF66B0A1B9ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <85f315a2-e49a-4330-9419-48a8a3a4a3e3@redhat.com>
 <CH3PR12MB754844745DF256D7FF2CB07AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <e4fd6d1e-3fca-457b-ac6a-69e721d799f4@redhat.com>
 <CH3PR12MB75489F2161213432D34688D2ABC5A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <7ac24d9a-0caf-48cb-832c-812fecc5c82c@redhat.com>
 <20251105181049.GU1537560@nvidia.com> <aQuYZM/8SX+RtDtv@Asurada-Nvidia>
 <20251105185816.GW1537560@nvidia.com>
 <f0c5945d-ec24-4bb9-827c-c3e57abdea36@redhat.com>
 <CH3PR12MB7548F87103CF2AF1BE95B1EAABC2A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548F87103CF2AF1BE95B1EAABC2A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Shameer,

On 11/6/25 12:48 PM, Shameer Kolothum wrote:
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 06 November 2025 07:43
>> To: Jason Gunthorpe <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>
>> Cc: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org; peter.maydell@linaro.org;
>> ddutile@redhat.com; berrange@redhat.com; Nathan Chen
>> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>> smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
>> Krishnakant Jaju <kjaju@nvidia.com>
>> Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
>> get_msi_address_space() callback
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 11/5/25 7:58 PM, Jason Gunthorpe wrote:
>>> On Wed, Nov 05, 2025 at 10:33:08AM -0800, Nicolin Chen wrote:
>>>> On Wed, Nov 05, 2025 at 02:10:49PM -0400, Jason Gunthorpe wrote:
>>>>> On Wed, Nov 05, 2025 at 06:25:05PM +0100, Eric Auger wrote:
>>>>>> if the guest doorbell address is wrong because not properly translated,
>>>>>> vgic_msi_to_its() will fail to identify the ITS to inject the MSI in.
>>>>>> See kernel kvm/vgic/vgic-its.c vgic_msi_to_its and
>>>>>> vgic_its_inject_msi
>>>>> Which has been exactly my point to Nicolin. There is no way to
>>>>> "properly translate" the vMSI address in a HW accelerated SMMU
>>>>> emulation.
>>>> Hmm, I still can't connect the dots here. QEMU knows where the
>>>> guest CD table is to get the stage-1 translation table to walk
>>>> through. We could choose to not let it walk through. Yet, why?
>>> You cannot walk any tables in guest memory without fully trapping all
>>> invalidation on all command queues. Like real HW qemu needs to fence
>>> its walks with any concurrent invalidate & sync to ensure it doesn't
>>> walk into a UAF situation.
>> But at the moment we do trap IOTLB invalidates so logically we can still
>> do the translate in that config. The problem you describe will show up
>> with vCMDQ which is not part of this series.
>>> Since we can't trap or mediate vCMDQ the walking simply cannot be
>>> done.
>>>
>>> Thus, the general principle of the HW accelerated vSMMU is that it
>>> NEVER walks any of these guest tables for any reason.
>>>
>>> Thus, we cannot do anything with vMSI address beyond program it
>>> directly into a real PCI device so it undergoes real HW translation.
>> But anyway you need to provide KVM a valid info about the guest doorbell
>> for this latter to setup irqfd gsi routing and also program ITS
>> translation tables. At the moment we have a single vITS in qemu so maybe
>> we can cheat.
> I have tried to address the “translate” issue below. This introduces a new
> get_msi_address() callback to retrieve the MSI doorbell address directly
> from the vIOMMU, so we can drop the existing get_msi_address_space() logic.
> Please take a look and let me know your thoughts.
>
> Thanks,
> Shameer
>
> ---
>  hw/arm/smmuv3-accel.c   | 10 ++++++++++
>  hw/arm/smmuv3.c         |  1 +
>  hw/arm/virt.c           |  4 ++++
>  hw/pci/pci.c            | 17 +++++++++++++++++
>  include/hw/arm/smmuv3.h |  1 +
>  include/hw/pci/pci.h    | 15 +++++++++++++++
>  target/arm/kvm.c        | 14 ++++++++++++--
>  7 files changed, 60 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index e6c81c4786..8b2a45a915 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -667,6 +667,15 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>      }
>  }
>
> +static uint64_t smmuv3_accel_get_msi_address(PCIBus *bus, void *opaque,
> +                                             int devfn)
> +{
> +    SMMUState *bs = opaque;
> +    SMMUv3State *s = ARM_SMMUV3(bs);
> +
> +    g_assert(s->msi_doorbell);
> +    return s->msi_doorbell;
> +}
>  static AddressSpace *smmuv3_accel_get_msi_as(PCIBus *bus, void *opaque,
>                                               int devfn)
>  {
> @@ -788,6 +797,7 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>      .set_iommu_device = smmuv3_accel_set_iommu_device,
>      .unset_iommu_device = smmuv3_accel_unset_iommu_device,
>      .get_msi_address_space = smmuv3_accel_get_msi_as,
to be removed then
> +    .get_msi_address = smmuv3_accel_get_msi_address,
>  };
>
>  void smmuv3_accel_idr_override(SMMUv3State *s)
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 43d297698b..3f2ee8bcce 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2120,6 +2120,7 @@ static const Property smmuv3_properties[] = {
>      DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
>      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
>      DEFINE_PROP_BOOL("pasid", SMMUv3State, pasid, false),
> +    DEFINE_PROP_UINT64("msi-doorbell", SMMUv3State, msi_doorbell, 0),
>  };
>
>  static void smmuv3_instance_init(Object *obj)
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 2498e3beff..d2dcb89235 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3097,6 +3097,8 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>
>              create_smmuv3_dev_dtb(vms, dev, bus, errp);
>              if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
> +                hwaddr db_start = base_memmap[VIRT_GIC_ITS].base +
> +                                  ITS_TRANS_SIZE + GITS_TRANSLATER;
there are still use cases where you count target GICv2M doorbell so at
least you would need to add some logic to switch between both
>                  char *stage;
>                  stage = object_property_get_str(OBJECT(dev), "stage",
>                                                  &error_fatal);
> @@ -3107,6 +3109,8 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>                      return;
>                  }
>                  vms->pci_preserve_config = true;
> +                object_property_set_uint(OBJECT(dev), "msi-doorbell", db_start,
> +                                         &error_abort);
>              }
>          }
>      }
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 1edd711247..45e79a3c23 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2982,6 +2982,23 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>      return &address_space_memory;
>  }
>
> +bool pci_device_iommu_msi_direct_address(PCIDevice *dev, hwaddr *out_doorbell)
> +{
> +    PCIBus *bus;
> +    PCIBus *iommu_bus;
> +    int devfn;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
> +    if (iommu_bus) {
> +        if (iommu_bus->iommu_ops->get_msi_address) {
> +            *out_doorbell = iommu_bus->iommu_ops->get_msi_address(bus,
> +                                 iommu_bus->iommu_opaque, devfn);
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
>  AddressSpace *pci_device_iommu_msi_address_space(PCIDevice *dev)
>  {
>      PCIBus *bus;
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index ee0b5ed74f..f50d8c72bd 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -72,6 +72,7 @@ struct SMMUv3State {
>      bool ats;
>      uint8_t oas;
>      bool pasid;
> +    uint64_t msi_doorbell;
>  };
>
>  typedef enum {
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index b731443c67..e1709b0bfe 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -679,6 +679,20 @@ typedef struct PCIIOMMUOps {
>       */
>      AddressSpace * (*get_msi_address_space)(PCIBus *bus, void *opaque,
>                                              int devfn);
> +    /**
> +     * @get_msi_address: get the address of MSI doorbell for the device
(gpa) address
> +     * on a PCI bus.
> +     *
> +     * Optional callback, if implemented must return a valid MSI doorbell
> +     * address.
> +     *
> +     * @bus: the #PCIBus being accessed.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * @devfn: device and function number
> +     */
> +    uint64_t (*get_msi_address)(PCIBus *bus, void *opaque, int devfn);
>  } PCIIOMMUOps;
>
>  bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
> @@ -688,6 +702,7 @@ bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
>                                   Error **errp);
>  void pci_device_unset_iommu_device(PCIDevice *dev);
>  AddressSpace *pci_device_iommu_msi_address_space(PCIDevice *dev);
> +bool pci_device_iommu_msi_direct_address(PCIDevice *dev, hwaddr *out_doorbell);
>
>  /**
>   * pci_device_get_viommu_flags: get vIOMMU flags.
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 0df41128d0..8d4d2be0bc 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1611,35 +1611,45 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level)
>  int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
>                               uint64_t address, uint32_t data, PCIDevice *dev)
>  {
> -    AddressSpace *as = pci_device_iommu_msi_address_space(dev);
> +    AddressSpace *as;
>      hwaddr xlat, len, doorbell_gpa;
>      MemoryRegionSection mrs;
>      MemoryRegion *mr;
>
> +    /* Check if there is a direct msi address available */
> +    if (pci_device_iommu_msi_direct_address(dev, &doorbell_gpa)) {
> +        goto set_doorbell;
> +    }
> +
> +    as = pci_device_iommu_msi_address_space(dev);
logically this should be after the test below (ie. meaning we have an
IOMMU). But this means that you shall use an as which is not the
address_space_memory.

This works but it is not neat either because it totally ignored the
@address. So you have to build a solid commit msg to explain readers why
this is needed ;-)
>      if (as == &address_space_memory) {
>          return 0;
>      }
>
>      /* MSI doorbell address is translated by an IOMMU */
>
> -    RCU_READ_LOCK_GUARD();
> +    rcu_read_lock();
>
>      mr = address_space_translate(as, address, &xlat, &len, true,
>                                   MEMTXATTRS_UNSPECIFIED);
>
>      if (!mr) {
> +        rcu_read_unlock();
>          return 1;
>      }
>
>      mrs = memory_region_find(mr, xlat, 1);
>
>      if (!mrs.mr) {
> +        rcu_read_unlock();
>          return 1;
>      }
>
>      doorbell_gpa = mrs.offset_within_address_space;
>      memory_region_unref(mrs.mr);
> +    rcu_read_unlock();
>
> +set_doorbell:
>      route->u.msi.address_lo = doorbell_gpa;
>      route->u.msi.address_hi = doorbell_gpa >> 32;
>
> --
>
>
>
>
>
>
Thanks

Eric


