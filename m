Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AC8C88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x63BL-0006LS-0B; Mon, 14 Sep 2026 05:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x63BJ-0006KL-IG
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:40:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x63BH-0001qL-GK
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789378853;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KuTD4uLou3S6P+YVvK2ph7DlkjkW8DiH31MVPYP/58s=;
 b=iq6qg/hFp8DoyR4/5bXQe+Uea80Paga6G8p2c2vnIJDFDb5NZee++tY67NUs1CSRuEW9Y0
 jzhaTFZ3eZ/N8KMkSH5laHUBPsKS8q98BF/d46OinWlvQKVu8LAfSo/AUQ49z+vLvrePp5
 MlII8Z5PnYafgneMwb4N8W+k5RBZeis=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-oE39uzKjOGGTu44TMoswsg-1; Mon, 14 Sep 2026 05:40:52 -0400
X-MC-Unique: oE39uzKjOGGTu44TMoswsg-1
X-Mimecast-MFC-AGG-ID: oE39uzKjOGGTu44TMoswsg_1789378851
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c294ae16988so372244066b.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 02:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789378851; x=1789983651;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KuTD4uLou3S6P+YVvK2ph7DlkjkW8DiH31MVPYP/58s=;
 b=Nrn3pebg1oI0hhaSO10QvyJG5MKFq7sfozl7MNTNKU4xeVEJsKdqAfbLYCZfsN/cSp
 vTv2EF18uz36GC2N6RpQiK5SldIupC3sD3Vrg1EhHJG4azSGnAcHM2ZBLMvaTEbkLj/i
 0jxi51QOVMVHhnNAc8uTwzadeZfqAs9Mbtq2WMsjvjJNvAFXzFt8E3Fd5n85+p+VK1eQ
 xg9JLAg8lacXsH/H/c8mBgvqovBGH7yqZPR/xmGxkWr/1BtAcIzI7Kd57Vik5nq0+B6T
 phQzneenubqINwF22ZkRyEXdM/dz3Er3Mp2TCxRP7+5vPmx7dpYbKZftUxa5UStIlLc1
 Glrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXmnMWNdK46eSBhjcX8zN/bVgqwbD0dBnhyCwHGDirOxtfawPylI7scEsjZ3EcGWjfLtCpPtkxvYEi@nongnu.org
X-Gm-Message-State: AFuF++kqaLjMxORAUi8kVsQen0QaWKpTwsi8aTG3nB+Zwx+RFt7sEPgm
 0cJFOZU1iq12w3nf/Psu8Jzj7qMTZwc+Pksq4DCW/l4E/3ERJ4lsbv+Z9FMLubn0VqNEhshmxqV
 h+MnJXkKqY33Wu8OOrTkY58hqSsxSEFIofdvU3Dyz981+AW7vhvCq62I1
X-Gm-Gg: AYBFou3VZ/Bu7k9zsDe5WeP534Wd+37JCZo6adyDLDaWh9eqKTn9A8ypImOT4PPmekT
 eKE3cFaSFU5yvyvYFuZTwg90WyOWX7GaefvBVjZInPwS8ni7lcafHkTvmTTeg+yxVw/GfsLugOF
 g1wPTCrnafVTCOry7U6JFlNs0aCI/YJw5WyXHms1dfl30+0Wb/UZJYf+KmKcQqxoAzI4jwP0v05
 NlBA3ZYkadRyDywJC86GmOMRKSHMBI6PlAHSkjSSWsHH1o4AVKakB5gPVKCGid3WYq5ffOpk+Nh
 GfJ1bdyHJPX0HbIdHuiaBK7Oujn657Snv3ALWtljvRWdaWPmrt+OiU817p/Ech34zTT8zC7gtRN
 T5lP4pkYutLcQ3fiM8r9sWTVo3R1TcFu+KFh/peWfMZI4zySB
X-Received: by 2002:a17:907:6d15:b0:c26:19de:9ad3 with SMTP id
 a640c23a62f3a-c29b874789cmr110763666b.43.1789378850983; 
 Mon, 14 Sep 2026 02:40:50 -0700 (PDT)
X-Received: by 2002:a17:907:6d15:b0:c26:19de:9ad3 with SMTP id
 a640c23a62f3a-c29b874789cmr110761866b.43.1789378850624; 
 Mon, 14 Sep 2026 02:40:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2966066b6asm387939566b.34.2026.09.14.02.40.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 02:40:49 -0700 (PDT)
Message-ID: <b4077c0f-61bc-4619-bf20-ce4992c6bf29@redhat.com>
Date: Mon, 14 Sep 2026 11:40:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/7] hw/arm/smmuv3-accel: Factor out the single vEVENT
 read
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jan@nvidia.com, jgg@ziepe.ca, ankita@nvidia.com,
 aniketa@nvidia.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com
References: <20260904180513.248396-1-skolothumtho@nvidia.com>
 <20260904180513.248396-2-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260904180513.248396-2-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
> Move the body of smmuv3_accel_event_read() into a new helper,
> smmuv3_accel_event_read_one(), that reads one vEVENT and tells the caller
> whether it propagated an event, found the queue empty, or failed.
it is not totally obvious that "queue empty" reason matches EAGAIN/EINTR.
>
> Subsequent patch will make use of the helper to drain the queue.
>
> No functional change intended.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 91aca1aa14..fc503578f5 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -484,28 +484,38 @@ int smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
>      return 0;
>  }
>  
> -static void smmuv3_accel_event_read(void *opaque)
> +/*
> + * Read one pending vEVENT and propagate it to the guest event queue.
> + * Returns 0 if an event was propagated, 1 if the queue is drained, -1 on
> + * error with @errp set.
> + */
> +static int smmuv3_accel_event_read_one(SMMUv3State *s, Error **errp)
>  {
> -    SMMUv3State *s = opaque;
>      IOMMUFDVeventq *veventq = s->s_accel->veventq;
>      struct {
>          struct iommufd_vevent_header hdr;
>          struct iommu_vevent_arm_smmuv3 vevent;
>      } buf;
> -    Error *local_err = NULL;
>      int ret;
>  
>      ret = smmuv3_accel_event_read_validate(veventq,
>                                             IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &buf,
> -                                           sizeof(buf), &local_err);
> -    if (ret < 0) {
> -        warn_report_err_once(local_err);
> -        return;
> -    }
> -    if (ret > 0) {
> -        return; /* EAGAIN/EINTR */
> +                                           sizeof(buf), errp);
> +    if (ret) {
> +        return ret;
>      }
>      smmuv3_propagate_event(s, (Evt *)&buf.vevent);
> +    return 0;
> +}
> +
> +static void smmuv3_accel_event_read(void *opaque)
> +{
> +    SMMUv3State *s = opaque;
> +    Error *local_err = NULL;
> +
> +    if (smmuv3_accel_event_read_one(s, &local_err) < 0) {
> +        warn_report_err_once(local_err);
> +    }
>  }
>  
>  static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
Otherwise looks good to me

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric




