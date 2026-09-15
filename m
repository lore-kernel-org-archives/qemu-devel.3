Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D49C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6SMk-0002Yz-GQ; Tue, 15 Sep 2026 08:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x6SMi-0002Yd-Oi
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 08:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x6SMg-0007Ge-Il
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 08:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789475661;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OWJmOsrwL8Vk7iqPzOJZ0vFL5sn2e8tdYQhQYPbSGMU=;
 b=g0TGMYShFMDcZKnadTh1wy6YeBAkej6IU6xpUfs2DYrARIMljVdF5ZTQFJHftAw+5q+TJG
 5XQ+pZAE9FPeznibP7oI4LqsG/iIuzx/Q+sT80KOTxgW/cmsGWPv+GJbeBAnxJ6sVhcGLm
 7xaFbxmNaTZma3YM2escwlsSWU0DClU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-ygN6ureNPduZqCiH0gkocw-1; Tue, 15 Sep 2026 08:34:20 -0400
X-MC-Unique: ygN6ureNPduZqCiH0gkocw-1
X-Mimecast-MFC-AGG-ID: ygN6ureNPduZqCiH0gkocw_1789475659
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49ccfbe060aso38475665e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 05:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789475659; x=1790080459;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OWJmOsrwL8Vk7iqPzOJZ0vFL5sn2e8tdYQhQYPbSGMU=;
 b=ScbC3slp2zIRH35p+mq36SeRiJ0RBCPe2jM3yFjnmV4SdjTuHLV9964SyiVgbQEQ2I
 sdhu/wBdFUmuYYsx/hS+yKn27cfSz8qhTs9KcOXeGc0FNQQEOkOdbKo95n6VgflIaaxD
 khWX+9cjETEGdufh84IlUO07RoutRxBUD6k+27EVLift6oXLv7zfc+8Ukv4M7Vkg8gtL
 8NalqYIerPCTN0qWyidX//TBKPCrcJ8a361ARwJ713jKpSDxrW0/1RMbA+nVzOQNCxj4
 Lf5TapBL0sgXsAJM1b0qGNenP6NalfRNj7yyadYWk6HKh0exTpSgq78vWOux3AMYYQUG
 KK6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEdXtufMhOQZuKBUMpkP/9FbRO5A1IZCQrntmOAaxE3qhRm+UQQTSD2vga/Q7gVYAFgFd35qGoWQcX@nongnu.org
X-Gm-Message-State: AFuF++ktkdyoyy6dd0iLHFwdAfrEU6e9kQk0eopFkzwaeXfCAPZqzWHB
 KORTTtnLwyKrnQDFw99x/+8eO1QRZRjMgcAKdmckKV5gWlj5nD92pN5+vBpALqGYEz/lx58L5Fl
 qsIQ+e32WkX8jIm6SFPOIiHVWg5euLd+TwOEARMnxumc1ZeTVej8Aeaa0
X-Gm-Gg: AYBFou3LPr8nuAVIBsmtevqEOWEuk+hOBqalfXd09o5le/YUeypgkstRSjr8KsO1aFg
 sw/oZGqBGV+yaLLIyfBwNFT3+glbTEUvHpRT7YSQIXHvFmSRQMLmMWKxXT8aAOv3pz2Nj4xC9/x
 z1dQeCoERhWQ3efn4P2qJ5BmkVPrqUgN9nV47cuM/YoAeENRwf8tvhdZSuP6bpRcq3ePVeoZU96
 swjUk5OH649f670V8dSu9lzzxkYslZyL0NYpSvvsUGwosCdCdtv7MiheZTYx6LUUX3v5l38M/x6
 LuyJy8u+M2pEXxPs6j5VC0qIHPQklIIBHbWOx0qED1IIHkHze1BIleuBGGqEbkRl7jjsIV/qGWt
 6X9hsoDisHdqj8RbkkKYq2hshH9nFtRSldIXM9j/zGsGJe3Zl
X-Received: by 2002:a05:600c:6298:b0:49c:de80:b833 with SMTP id
 5b1f17b1804b1-49e7a65c182mr76824295e9.2.1789475659211; 
 Tue, 15 Sep 2026 05:34:19 -0700 (PDT)
X-Received: by 2002:a05:600c:6298:b0:49c:de80:b833 with SMTP id
 5b1f17b1804b1-49e7a65c182mr76823965e9.2.1789475658724; 
 Tue, 15 Sep 2026 05:34:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33fd3bsm35304221f8f.19.2026.09.15.05.34.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 05:34:17 -0700 (PDT)
Message-ID: <d5385eac-ae6f-4c55-8cdc-0571efac64d3@redhat.com>
Date: Tue, 15 Sep 2026 14:34:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/7] hw/arm/smmuv3: Migrate the accelerator feature set
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jan@nvidia.com, jgg@ziepe.ca, ankita@nvidia.com,
 aniketa@nvidia.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com
References: <20260904180513.248396-1-skolothumtho@nvidia.com>
 <20260904180513.248396-4-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260904180513.248396-4-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On 9/4/26 8:05 PM, Shameer Kolothum wrote:
> Add a subsection carrying idr[0] to idr[5], needed when accel=on. pre_load
I would explain what you try to achieve before the how.
> saves the locally resolved values and post_load fails the migration if the
> incoming ones differ. Accepting the source values would leave QEMU
> advertising features the destination host cannot provide.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.h       |  1 +
>  include/hw/arm/smmuv3.h     |  7 ++++-
>  hw/arm/smmuv3-accel-stubs.c | 12 ++++++++
>  hw/arm/smmuv3-accel.c       | 58 +++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3.c             |  1 +
>  5 files changed, 78 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index ea11d513cc..a91d188d61 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -99,6 +99,7 @@ void smmuv3_accel_idr_override(SMMUv3State *s);
>  bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
>  int smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
>                                       void *buf, size_t size, Error **errp);
> +extern const VMStateDescription vmstate_smmuv3_accel;
>  void smmuv3_accel_reset(SMMUv3State *s);
>  SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj);
>  
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index d39fe8850b..9e0836b81a 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -26,6 +26,9 @@
>  
>  #define TYPE_SMMUV3_IOMMU_MEMORY_REGION "smmuv3-iommu-memory-region"
>  
> +/* Number of IDR registers, IDR0 to IDR5 */
> +#define SMMU_NUM_IDR 6
> +
>  typedef struct SMMUQueue {
>       uint64_t base; /* base register */
>       uint32_t prod;
> @@ -41,7 +44,9 @@ struct SMMUv3State {
>      uint8_t sid_size;
>      uint8_t sid_split;
>  
> -    uint32_t idr[6];
> +    uint32_t idr[SMMU_NUM_IDR];
> +    /* Locally resolved IDRs, saved by pre_load for post_load to check */
> +    uint32_t local_idr[SMMU_NUM_IDR];
>      uint32_t iidr;
>      uint32_t aidr;
>      uint32_t cr[3];
> diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
> index b8dd7e7b89..b57b5c01e7 100644
> --- a/hw/arm/smmuv3-accel-stubs.c
> +++ b/hw/arm/smmuv3-accel-stubs.c
> @@ -8,6 +8,7 @@
>  #include "qapi/error.h"
>  #include "hw/arm/smmuv3.h"
>  #include "hw/arm/smmuv3-accel.h"
> +#include "migration/vmstate.h"
>  
>  bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
>  {
> @@ -53,6 +54,17 @@ int smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
>      return 0;
>  }
>  
> +static bool smmuv3_accel_vmstate_needed(void *opaque)
> +{
> +    return false;
> +}
> +
> +const VMStateDescription vmstate_smmuv3_accel = {
> +    .name = "smmuv3/accel",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = smmuv3_accel_vmstate_needed,
> +};
>  
>  void smmuv3_accel_reset(SMMUv3State *s)
>  {
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 73509dbd8d..287ea91fbe 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -18,6 +18,7 @@
>  
>  #include "smmuv3-internal.h"
>  #include "smmuv3-accel.h"
> +#include "migration/vmstate.h"
>  #include "system/runstate.h"
>  #include "system/system.h"
>  #include "tegra241-cmdqv.h"
> @@ -1096,6 +1097,63 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
>      return all_ok;
>  }
>  
> +static bool smmuv3_accel_vmstate_pre_load(void *opaque, Error **errp)
> +{
> +    SMMUv3State *s = opaque;
> +
> +    if (!s->s_accel) {
> +        error_setg(errp, "Incoming stream carries SMMUv3 accelerator state "
> +                   "but this arm-smmuv3 has accel=off");
> +        return false;
> +    }
> +
> +    /* Save the locally resolved IDRs before the stream overwrites them. */
> +    memcpy(s->local_idr, s->idr, sizeof(s->idr));
> +    return true;
> +}
> +
> +static bool smmuv3_accel_vmstate_post_load(void *opaque, int version_id,
> +                                           Error **errp)
> +{
> +    ERRP_GUARD();
> +    SMMUv3State *s = opaque;
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(s->idr); i++) {
> +        if (s->idr[i] == s->local_idr[i]) {
> +            continue;
> +        }
> +        error_setg(errp, "SMMUv3 IDR%d mismatch: source 0x%08x, "
> +                   "destination 0x%08x", i, s->idr[i],
> +                   s->local_idr[i]);
> +        error_append_hint(errp, "ril, ats, oas and ssidsize must resolve to "
> +                          "the same values on source and destination.\n");
don't you want to be more precise then and just check the corresponding
fields?


> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static bool smmuv3_accel_vmstate_needed(void *opaque)
> +{
> +    SMMUv3State *s = opaque;
> +
> +    return s->accel;
> +}
> +
> +const VMStateDescription vmstate_smmuv3_accel = {
> +    .name = "smmuv3/accel",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = smmuv3_accel_vmstate_needed,
> +    .pre_load_errp = smmuv3_accel_vmstate_pre_load,
> +    .post_load_errp = smmuv3_accel_vmstate_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(idr, SMMUv3State, SMMU_NUM_IDR),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  void smmuv3_accel_reset(SMMUv3State *s)
>  {
>      SMMUv3AccelState *accel = s->s_accel;
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index ed19536a4d..66d95e1076 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2137,6 +2137,7 @@ static const VMStateDescription vmstate_smmuv3 = {
>      },
>      .subsections = (const VMStateDescription * const []) {
>          &vmstate_gbpa,
> +        &vmstate_smmuv3_accel,
>          NULL
>      }
>  };
Thanks

Eric


