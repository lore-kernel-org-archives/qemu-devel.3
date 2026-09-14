Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E16AC88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x63Kr-000132-Q5; Mon, 14 Sep 2026 05:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x63Kp-00012a-NI
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:50:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x63Kk-0004ER-P9
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789379441;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HDP0b/hfgT/6WkN55haVeTscJbVXp5zqLJ+JvZFgjk=;
 b=N0o13XsjhpKvyQ6raAU0uLHMaoyC3+q6w0LXFjvRuJawEGk4MKLqiN4JL79B8nK+PjTnT4
 lHFvqLgBDPMW/PlPE9wLSB1sbjquHLQpFejaaTiZ5zacBlGbcT8GeCNAt6H3gHqdYuxWhO
 M3vKlr2Y5Wwo7iFpHM6+03Mp6sAIqXU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-Z5TOlTKbNUOhFcCockDZVA-1; Mon, 14 Sep 2026 05:50:40 -0400
X-MC-Unique: Z5TOlTKbNUOhFcCockDZVA-1
X-Mimecast-MFC-AGG-ID: Z5TOlTKbNUOhFcCockDZVA_1789379439
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e635a6002so30957695e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 02:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789379439; x=1789984239;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7HDP0b/hfgT/6WkN55haVeTscJbVXp5zqLJ+JvZFgjk=;
 b=pWoJmNidi6h3g1OEf0oZVBCL6nh9bEsKZhIRqXlMBfxcukEVDdkm+Gp5UHrrFA0ioL
 wA0AGpHK48z6kQ6mRWBVTvqK8PUXaYT2sGriFFin/r1WgyRJU2K0FN6oREKztupjPjeE
 riVFbeE0vQx5DKgBi2lS7dSiscZNQ6vxGc5ftnrjae1cKBHYX5oyrFsijiduAoBwUwli
 9v0M+JEk8XsjJ4by64ilfChVHo4WkhHU6BEcWSFQVwiV95wst3nFcW8MVM4jJTNNQAWM
 pMEUHYYGssIYSRu0qo4lPNRtFV59TCzFTpZYqEIGyzjOEFHj1+PekBRMGM4xp7feFuOv
 OcaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxS07twOox7AWnuGxF0AjIqM5+7J/Ist+szcrKZbc8GVu1WRlcBD9/dVn8/lc527RB+4KJRJ74N3M1w@nongnu.org
X-Gm-Message-State: AFuF++nfmO1LKq7jggonsyMASDM1d4Et9mOOWKjt8/uxxqqrDG7RRP+Z
 7QU9jUwCDDZ2g7gZywlBqmm6LrKF2aqn9wk/9f/Fp99J8HLVhsWHHtQDMvmnvSGTn66VWMwqFJW
 njLWAVVe6p/QWKBlYEYWdov0Jppo7lLZHbUBIDqCXM27Pwv7cq0CXEFcn
X-Gm-Gg: AYBFou2WR0ixd+jdZddiT5Aw8MKAA8otfmAJoxM6E8kTmIz0if8B7S0mddvlK98OKsy
 T1SbiizB8jYNzjTjk/Him8zhfG9FBrDZIW0UzOhUGDrZTGqAeyLaV6rHci0SH7a3a5eSmkm8iKc
 efiA2gz3HTRi7YxK0VODznIXUJLEqvR/5JHX4HGw4HCw0jKU38JqfHlWFC7A5lNFMX6Lzj5fujI
 DjbgUBhpANm7gURRyLemu3PaL2GP9v04qruMlDp3ZioNiTSV4hrMfcMZ5Qfvh4i/6v0ehnY372R
 cDENsmzxcLgUAHGt60jI/q+VrP1ztbD/qjymbTFDXIQ1cIIy5QFRxZi6VCR3EuTfAVPWwMYPVYp
 qq1ADFnArD/oQVNIYZjcfWQAQGxoz2QGK6dXrwH/gIpqQT/yA
X-Received: by 2002:a05:600c:a00b:b0:499:900c:9c69 with SMTP id
 5b1f17b1804b1-49e7a6626d0mr21781065e9.9.1789379439292; 
 Mon, 14 Sep 2026 02:50:39 -0700 (PDT)
X-Received: by 2002:a05:600c:a00b:b0:499:900c:9c69 with SMTP id
 5b1f17b1804b1-49e7a6626d0mr21780835e9.9.1789379438878; 
 Mon, 14 Sep 2026 02:50:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e636f7fa2sm306163015e9.15.2026.09.14.02.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 02:50:38 -0700 (PDT)
Message-ID: <005af326-6624-44fa-9713-75ef2d5076fd@redhat.com>
Date: Mon, 14 Sep 2026 11:50:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/7] hw/arm/smmuv3-accel: Drain the vEVENTQ when the
 VM stops
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jan@nvidia.com, jgg@ziepe.ca, ankita@nvidia.com,
 aniketa@nvidia.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com
References: <20260904180513.248396-1-skolothumtho@nvidia.com>
 <20260904180513.248396-3-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260904180513.248396-3-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Fault events sit in the kernel vEVENTQ until smmuv3_accel_event_read()
> moves them into the emulated event queue. The vEVENTQ is an iommufd object
> that is not migrated, so anything left in it when the source stops is lost.
>
> Drain it from a VM state change handler, which runs before any state is
> saved. Propagating an event writes the record into guest RAM and raises the
> event queue interrupt, and both guest RAM and the GIC are saved before the
> SMMUv3 device state. A pre_save hook would run after both, hence using
> qemu_add_vm_change_state_handler().
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index fc503578f5..73509dbd8d 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -18,6 +18,7 @@
>  
>  #include "smmuv3-internal.h"
>  #include "smmuv3-accel.h"
> +#include "system/runstate.h"
>  #include "system/system.h"
>  #include "tegra241-cmdqv.h"
>  
> @@ -518,6 +519,37 @@ static void smmuv3_accel_event_read(void *opaque)
>      }
>  }
>  
> +/*
> + * Drain the kernel vEVENTQ into the guest event queue whenever the VM stops,
> + * so that a migration does not strand events in an object it does not carry.
> + * Propagating an event writes the record into guest RAM and raises the event
> + * queue interrupt, both of which are saved before the SMMUv3 device state, so
> + * a pre_save hook would be too late for either.
I prefered the description in the commit msg: 

"and both guest RAM and the GIC are saved before the
SMMUv3 device state" which sounds clearer to me.. A pre_save hook would run after both
, which would be too late hence the choice of this VM state change handler.



> + *
> + * VFIO registers at a higher priority and the stop path runs in descending
> + * priority, so the devices are already in STOP by the time this runs.
> + */
> +static void smmuv3_accel_vm_state_change(void *opaque, bool running,
> +                                         RunState state)
> +{
> +    SMMUv3State *s = opaque;
> +    SMMUv3AccelState *accel = s->s_accel;
> +    Error *local_err = NULL;
> +    int ret;
> +
> +    if (running || !accel || !accel->veventq) {
> +        return;
> +    }
> +
> +    do {
> +        ret = smmuv3_accel_event_read_one(s, &local_err);
> +    } while (!ret);
> +
> +    if (ret < 0) {
> +        warn_report_err(local_err);
> +    }
> +}
> +
>  static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
>  {
>      IOMMUFDVeventq *veventq = accel->veventq;
> @@ -1146,5 +1178,8 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
>          qemu_add_machine_init_done_notifier(&s->machine_done);
>      }
>  
> +    /* For migartion of vEVENTQ pending events */
migration
> +    qemu_add_vm_change_state_handler(smmuv3_accel_vm_state_change, s);
> +
>      return true;
>  }
Otherwise looks good to me
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


