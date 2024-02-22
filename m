Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2BCC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 07:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd3yB-0001tS-Ur; Thu, 22 Feb 2024 02:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rd3yA-0001tG-UN
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 02:58:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rd3y9-0005WZ-CT
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 02:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708588692;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLlORS3eA79Wwl5NVJief4WfuY3RNYq5UngtR7IMK5I=;
 b=DFtKxLPaFpZaA79D6Wy/gItzkA/W0WOsPeF0XHEoQXqQpDHao35uUY6Z6JJU7liFdGP7pW
 33FsxGNcrDvLTjI+MfPermMQiCL/+SmDzUE3RhTdmf4F1aQAckCqYKgfM6BsTtz55S0ba3
 8/cY4sQpMGJL8EpJF56+eiyVktrK9Hk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-F3Jg-KQcPJmFQ7APP6bvtA-1; Thu, 22 Feb 2024 02:58:11 -0500
X-MC-Unique: F3Jg-KQcPJmFQ7APP6bvtA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33d308b0c76so234585f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 23:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708588385; x=1709193185;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gLlORS3eA79Wwl5NVJief4WfuY3RNYq5UngtR7IMK5I=;
 b=GdJKIfIWzFP1tp611YiA6HLoE2+8xyMm+8vugtttL6U5xyUc0pv+NSVwDh0LyR1ReV
 Q1JBe6OZ2LeCDCihNDNkeERgeP4goLW1n1uzBBb9nepxue+0J1HLcP0NCwwb+leGn2ue
 w+6QVQtbrzXdvM6aTYbYL1QiAjcf4ngQUzDkHi6Q+RxjVtclib+IiUhMH/jCgVNtX6fo
 YVBngH3U4ZuzGZAbzJwfVcg+Tp7iySk5yzkqWPPyPBsWiX+0qxUWlsnqLaCTlhObzHQZ
 IQoG/ytGDGFYOQqYjKDwggF4fthma4d45wW1xOyybhGqUFmNZnNFknqhz0UPWCC9/rDS
 OYlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVsfxfVRceGqnRAO7mj08KKlYHwwEi6159i6/z1SZG5Gx/o2qXiUEykatLlJpgnOR1eh3aFt+R3yN2MT/pAQGVcwDLyxY=
X-Gm-Message-State: AOJu0YwzuodAUwPTrDOvcFinyB2svdXRNeyDUjKd0TxdkOLI5HgTGryC
 X//wIR331SS5h92C2bywapebMBwlZrTJQmku1D3/N0TrEm0awSR264hTyMLklFBteVzWBYyfAhV
 mFfhwznqLMRlbu48uNwjNy9+6CoyMzNpQgmwTh68nqZoaOu3Xe8Ii
X-Received: by 2002:a5d:6a07:0:b0:33d:61c7:9b2c with SMTP id
 m7-20020a5d6a07000000b0033d61c79b2cmr1517941wru.34.1708588384767; 
 Wed, 21 Feb 2024 23:53:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENCPS0Uzg2txmMdmpbgX3WhPe/la5oNsFz4nTfDe7w2FXaJ8ZUfDwVqKXZXQiVkuk5oIs+hw==
X-Received: by 2002:a5d:6a07:0:b0:33d:61c7:9b2c with SMTP id
 m7-20020a5d6a07000000b0033d61c79b2cmr1517921wru.34.1708588384373; 
 Wed, 21 Feb 2024 23:53:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 m15-20020a056000008f00b0033b728190c1sm19405972wrx.79.2024.02.21.23.53.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 23:53:04 -0800 (PST)
Message-ID: <5e2bc3c2-e7f3-4ef1-be59-b6b9fcb58b8d@redhat.com>
Date: Thu, 22 Feb 2024 08:53:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] qdev: Add a granule_mode property
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, jean-philippe@linaro.org, peter.maydell@linaro.org,
 clg@redhat.com, yanghliu@redhat.com
Cc: alex.williamson@redhat.com, zhenzhong.duan@intel.com,
 jasowang@redhat.com, pbonzini@redhat.com, berrange@redhat.com
References: <20240221205926.40066-1-eric.auger@redhat.com>
 <20240221205926.40066-2-eric.auger@redhat.com>
 <a3cefe21-f988-4269-9048-ffe4c5d18508@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <a3cefe21-f988-4269-9048-ffe4c5d18508@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Richard,

On 2/21/24 22:58, Richard Henderson wrote:
> On 2/21/24 10:58, Eric Auger wrote:
>> Introduce a new enum type property allowing to set an
>> IOMMU granule. Values are 4K, 16K, 64K and host. This
>> latter indicates the vIOMMU granule will matches the
>> host page size.
>>
>> A subsequent patch will add such a property to the
>> virtio-iommu device.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   include/hw/qdev-properties-system.h |  3 +++
>>   include/hw/virtio/virtio-iommu.h    | 11 +++++++++++
>>   hw/core/qdev-properties-system.c    | 15 +++++++++++++++
>>   hw/virtio/virtio-iommu.c            | 10 ++++++++++
>>   4 files changed, 39 insertions(+)
>>
>> diff --git a/include/hw/qdev-properties-system.h
>> b/include/hw/qdev-properties-system.h
>> index 06c359c190..626be87dd3 100644
>> --- a/include/hw/qdev-properties-system.h
>> +++ b/include/hw/qdev-properties-system.h
>> @@ -8,6 +8,7 @@ extern const PropertyInfo qdev_prop_macaddr;
>>   extern const PropertyInfo qdev_prop_reserved_region;
>>   extern const PropertyInfo qdev_prop_multifd_compression;
>>   extern const PropertyInfo qdev_prop_mig_mode;
>> +extern const PropertyInfo qdev_prop_granule_mode;
>>   extern const PropertyInfo qdev_prop_losttickpolicy;
>>   extern const PropertyInfo qdev_prop_blockdev_on_error;
>>   extern const PropertyInfo qdev_prop_bios_chs_trans;
>> @@ -47,6 +48,8 @@ extern const PropertyInfo
>> qdev_prop_iothread_vq_mapping_list;
>>   #define DEFINE_PROP_MIG_MODE(_n, _s, _f, _d) \
>>       DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_mig_mode, \
>>                          MigMode)
>> +#define DEFINE_PROP_GRANULE_MODE(_n, _s, _f, _d) \
>> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_granule_mode,
>> GranuleMode)
>>   #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
>>       DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
>>                           LostTickPolicy)
>> diff --git a/include/hw/virtio/virtio-iommu.h
>> b/include/hw/virtio/virtio-iommu.h
>> index 5fbe4677c2..a82c4fa471 100644
>> --- a/include/hw/virtio/virtio-iommu.h
>> +++ b/include/hw/virtio/virtio-iommu.h
>> @@ -31,6 +31,16 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIOIOMMU, VIRTIO_IOMMU)
>>     #define TYPE_VIRTIO_IOMMU_MEMORY_REGION "virtio-iommu-memory-region"
>>   +typedef enum GranuleMode {
>> +    GRANULE_MODE_4K,
>> +    GRANULE_MODE_16K,
>> +    GRANULE_MODE_64K,
>> +    GRANULE_MODE_HOST,
>> +    GRANULE_MODE__MAX,
>> +} GranuleMode;
>> +
>> +extern const QEnumLookup GranuleMode_lookup;
>> +
>>   typedef struct IOMMUDevice {
>>       void         *viommu;
>>       PCIBus       *bus;
>> @@ -67,6 +77,7 @@ struct VirtIOIOMMU {
>>       Notifier machine_done;
>>       bool granule_frozen;
>>       uint8_t aw_bits;
>> +    GranuleMode granule_mode;
>>   };
>>     #endif
>> diff --git a/hw/core/qdev-properties-system.c
>> b/hw/core/qdev-properties-system.c
>> index 1a396521d5..3a0b36a7a7 100644
>> --- a/hw/core/qdev-properties-system.c
>> +++ b/hw/core/qdev-properties-system.c
>> @@ -34,6 +34,7 @@
>>   #include "net/net.h"
>>   #include "hw/pci/pci.h"
>>   #include "hw/pci/pcie.h"
>> +#include "hw/virtio/virtio-iommu.h"
>>   #include "hw/i386/x86.h"
>>   #include "util/block-helpers.h"
>>   @@ -679,6 +680,20 @@ const PropertyInfo qdev_prop_mig_mode = {
>>       .set_default_value = qdev_propinfo_set_default_value_enum,
>>   };
>>   +/* --- GranuleMode --- */
>> +
>> +QEMU_BUILD_BUG_ON(sizeof(GranuleMode) != sizeof(int));
>> +
>> +const PropertyInfo qdev_prop_granule_mode = {
>> +    .name = "GranuleMode",
>> +    .description = "granule_mode values, "
>> +                   "4K, 16K, 64K, host",
>> +    .enum_table = &GranuleMode_lookup,
>> +    .get = qdev_propinfo_get_enum,
>> +    .set = qdev_propinfo_set_enum,
>> +    .set_default_value = qdev_propinfo_set_default_value_enum,
>> +};
>> +
>>   /* --- Reserved Region --- */
>>     /*
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 2ec5ef3cd1..2ce5839c60 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -44,6 +44,16 @@
>>   #define VIOMMU_DEFAULT_QUEUE_SIZE 256
>>   #define VIOMMU_PROBE_SIZE 512
>>   +const QEnumLookup GranuleMode_lookup = {
>> +    .array = (const char *const[]) {
>> +        [GRANULE_MODE_4K]  = "4K",
>> +        [GRANULE_MODE_16K] = "16K",
>> +        [GRANULE_MODE_64K] = "64K",
>> +        [GRANULE_MODE_HOST] = "host",
>> +    },
>> +    .size = GRANULE_MODE__MAX
>> +};
>
> Does it ever make sense to use anything other than host?
> Especially since 4k fails on a 64k host, as you report.
Let me reuse Jean-Philippe's support matrix:
Before this series, 4KB granule was always used by the virtio-iommu.
The support matrix was:

 Host | Guest | virtio-net | IGB passthrough
  4k  | 4k    | Y          | Y
  64k | 64k   | Y          | N
  64k | 4k    | Y          | N
  4k  | 64k   | Y          | Y

with this series, host becomes the default. It fixes the 64KB/64KB config by default. It allows 64KB/4KB (virtio only) with manual 4K granule setting. If we don't have this 4K granule we cannot support that use case.

 Host | Guest | virtio-net | IGB passthrough
  4k  | 4k    | Y          | Y
  64k | 64k   | Y          | Y
  64k | 4k    | 4K         | N
  4k  | 64k   | Y          | Y

Besides I need 4KB to handle the compat for older machine types.

> Why would we want to be able to select a granule that doesn't work?

> There are a few older hosts with 8k pages, e.g. Alpha, MIPS, Sparc.
OK. those are not integrated with virtio-iommu but I can definitively add 8K

Eric
>
>
> r~
>


