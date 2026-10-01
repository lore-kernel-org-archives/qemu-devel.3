Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B600BCA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCJUd-0001Gi-Un; Thu, 01 Oct 2026 12:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xCJUV-0001Fn-4F
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xCJUR-0008Q8-DE
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790871513;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LuXYpgOQm1AttIIeOJOdYwxpznPcfbjtVG4fdDhUykQ=;
 b=gVTyMK18DbwM03jhyGjF4ahTRY8ORiERLiCUDjGnuHQjS3fVyAP5NLvbNOjU8K/zrf2QZO
 svClsP3/22lyXd8r+Ec7mrE1X6fsDzReam/6+A9saC4Da1EzhkLNitZCrEa4QlL9eNY+S6
 l5nzmhxhZuLCRRqswoZZrnRbhyQei9A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-bq9x55DVNTSl7jMd8F9ftA-1; Thu, 01 Oct 2026 12:18:32 -0400
X-MC-Unique: bq9x55DVNTSl7jMd8F9ftA-1
X-Mimecast-MFC-AGG-ID: bq9x55DVNTSl7jMd8F9ftA_1790871511
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a01b112fa2so20467615e9.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 09:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790871511; x=1791476311;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LuXYpgOQm1AttIIeOJOdYwxpznPcfbjtVG4fdDhUykQ=;
 b=O1+MW+pFMI0wVgQJ5NvIbZ10tYTsg6kjRadGd97TA6Vaw0cZah2qPu9efFhyOKS/ib
 HNjYoa66koJhuzzn3HX/zh3gkpctVRhuLStQCQMxQA0/ZIaG1YyHW7Y5Ngz6S9/JiQuL
 YTKA0VGchDAq1LiI6WTK98F4oF84GIQ1NJ437/B0khTfu9ooni3INCOwsAHUiv8TIMXZ
 Z9BJofXoc5fCvFOiArRJA4ijTrr5sl2E8j0ZXqFurbuY5z+rn94PkHruEhi4CLBAMwuq
 SDay8fSFv1FJVGlzJlW4vOT4g555gUFpj20jxkGQVbbHWtLXoNolT6mVVPJCiKLCFXNv
 KoMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByrTVXDKBaTGHcS+1i4IAnngIJqK1ZP+PIg2dsfVrq4XXwfRQiPYtswu7pHKFrMylZ7iIzN0HxGkxl6@nongnu.org
X-Gm-Message-State: AFuF++nUXgVRV6mF4eYLAYW0Z1pRZpNM6fTqirgRbZkjV1yEAsl7qbAb
 juwZH+4lR6oMOjpa2u5nsFXEFkk/O8KgXFac45oS5cOaqzjxP1uXifcBIL1KsA4GmZHdlmADryb
 Avq+9nSQq2Uj3auQ8Yl8lIwWxpXfXxa2jgcuvgHP/78YuCxBx8M4otBZ4
X-Gm-Gg: AYBFou3pzrI/XIMCH08g7G8Qea57Agez1bLdMjIZBdFxO1q5rJjdUeSPfdmQp+e9UlZ
 QkBDcMrVRZM6zxN67jr7m7sOFoGdeFDVbrhz3aSo03e4V9vk3Xsw6c300ldPig4E1t+IptHo36M
 J0Oockp/3nKSQHdKY39gkI5o7obG4eazfRv6eBRpcEW/eCUWnjpVzy3oGiFDphMNjdUHQdhWUKt
 xGZ3CHMod3uSn9HM32IK//o0zdNi+e5mR4igMqipLKX6miwl0i+7Xk+wHp1rYdEJV1zPisOJYcO
 HyIvPkLkBK1aKnH2K7fa0QoIPkSKGg2eEL3iuzxa0PxaacoSy+T4e3yrk6OrB6Hxe9PoDJILGYD
 GgvXJH8OVB/fOjrzJWy4xsBNg9RPOdB9Vsr3Zk2JOEYzZvtnU
X-Received: by 2002:a05:600c:6085:b0:4a0:2150:55fb with SMTP id
 5b1f17b1804b1-4a02751a80fmr2471005e9.4.1790871511042; 
 Thu, 01 Oct 2026 09:18:31 -0700 (PDT)
X-Received: by 2002:a05:600c:6085:b0:4a0:2150:55fb with SMTP id
 5b1f17b1804b1-4a02751a80fmr2470595e9.4.1790871510645; 
 Thu, 01 Oct 2026 09:18:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01f900c23sm48043975e9.1.2026.10.01.09.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 09:18:30 -0700 (PDT)
Message-ID: <b434ecce-ef8d-495d-b650-305a3bf66f83@redhat.com>
Date: Thu, 1 Oct 2026 18:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/7] hw/arm/smmuv3-accel: Add a helper to replay all
 STEs
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jan@nvidia.com, jgg@ziepe.ca, ankita@nvidia.com,
 aniketa@nvidia.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com
References: <20260904180513.248396-1-skolothumtho@nvidia.com>
 <20260904180513.248396-5-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260904180513.248396-5-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Add smmuv3_accel_replay_stes(). It walks the guest stream table and calls
> smmuv3_accel_install_ste() for every device behind an accelerated SMMUv3,
> which rebuilds the vDEVICE and the nested HWPT. The incoming migration path
> uses this instead of transferring per device host state, all of which can
> be derived from guest RAM once strtab_base and CR0 are restored.
>
> No caller yet.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.h       |  1 +
>  hw/arm/smmuv3-accel-stubs.c |  5 +++++
>  hw/arm/smmuv3-accel.c       | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index a91d188d61..24828ba9ab 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -92,6 +92,7 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
>                                Error **errp);
>  bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
>                                      Error **errp);
> +bool smmuv3_accel_replay_stes(SMMUv3State *s, Error **errp);
>  bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
>  bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
>                                  Error **errp);
> diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
> index b57b5c01e7..0514915e45 100644
> --- a/hw/arm/smmuv3-accel-stubs.c
> +++ b/hw/arm/smmuv3-accel-stubs.c
> @@ -28,6 +28,11 @@ bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
>      return true;
>  }
>  
> +bool smmuv3_accel_replay_stes(SMMUv3State *s, Error **errp)
> +{
> +    return true;
> +}
> +
>  bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
>  {
>      return true;
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 287ea91fbe..6678e49f6e 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -407,6 +407,40 @@ bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
>      return all_ok;
>  }
>  
> +/*
> + * Install the STE again for every device behind this accelerated SMMUv3, by
> + * reading the guest stream table once more. Stops at the first failure.
> + */
> +bool smmuv3_accel_replay_stes(SMMUv3State *s, Error **errp)
> +{
> +    ERRP_GUARD();
> +    SMMUv3AccelState *accel = s->s_accel;
> +    SMMUv3AccelDevice *accel_dev;
> +
> +    if (!accel || !accel->viommu) {
> +        return true;
> +    }
> +
> +    QLIST_FOREACH(accel_dev, &accel->device_list, next) {
What if you have different device topology on src and dest. Is it detected?
> +        uint32_t sid = smmu_get_sid(&accel_dev->sdev);
> +        SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid,
> +                               .inval_ste_allowed = true};
> +        STE ste;
> +
> +        /* Skip a device the guest has not programmed */
> +        if (smmu_find_ste(s, sid, &ste, &event)) {
> +            continue;
> +        }
> +
> +        if (!smmuv3_accel_install_ste(s, &accel_dev->sdev, sid, errp)) {
> +            error_prepend(errp, "Device 0x%x: Failed to install STE: ", sid);
maybe, from a user point of view it is not obvious why we get this error
as migration load is not mentionned.
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  /*
>   * This issues the invalidation cmd to the host SMMUv3.
>   *
Thanks

Eric


