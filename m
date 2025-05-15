Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72970C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 13:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFYfQ-0005vH-2G; Thu, 15 May 2025 09:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFYfN-0005t7-Oc
 for qemu-devel@nongnu.org; Thu, 15 May 2025 09:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFYfK-0004vL-Nw
 for qemu-devel@nongnu.org; Thu, 15 May 2025 09:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747315824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vj4jQcPN3jhIfyvsQfO6JdoX0LXD6ObhBGP1ZMCIjoc=;
 b=di/HigCGb+ZH5EKmVz7o9HH6x62CRZXwdMsgSAsPBaANlqrE527zFT52dl88KtFmWZ1bHY
 0Dvekue+G+CNdIpDO8MzRsnWEqCG6RH80I6D6InKAa3KlFGXIFxq6I3MpS+5MWpB5rIvjS
 kvWWpweRgUbXtQCeult6aCyUfyBDI8Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-LVhEl8gKOuuKITRekUaEtg-1; Thu, 15 May 2025 09:30:23 -0400
X-MC-Unique: LVhEl8gKOuuKITRekUaEtg-1
X-Mimecast-MFC-AGG-ID: LVhEl8gKOuuKITRekUaEtg_1747315822
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-442fbff4befso1370515e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 06:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747315822; x=1747920622;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vj4jQcPN3jhIfyvsQfO6JdoX0LXD6ObhBGP1ZMCIjoc=;
 b=D7NZ0F1iYpAOGq5YJPVLCRon2ciCONZaWOs80kY8GG+E/ttjqdzuubEVhYxiJVgKXh
 0QMqqZ1bpvpP67jkWoHoGH4bQK8eeScqqPl7QDAub2us638YAmYWsOE7zqOTKg2H5Wwc
 cA5VCPzx/x9gnEIMdBreyOKJV+bDrgLNlFvEkvJWKfXYY2lNa8TuqFnqN2GsySbmBCM4
 K20pVxHhyeXyxpEmlgB4D+qK7VSarpHo1gw2UVXHb0CyL5dywF/uPLRJCAv6wwiC2suv
 mHcMxxuXsf3rhZ+Nus1PXtaLQIphcb2Ib18UaBCOTJo3fW0vWnXSkok/65jdkDQylmKL
 SANA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkzHwdV4GwpEoWR5jZi87ooLALXlrxka0FgUK2l5jweVJ97YIuXToxa/NPTGv8eFw/L/yVM6gVWEpb@nongnu.org
X-Gm-Message-State: AOJu0YwiGDagewQCE6jFqtbyH+/Uj4JpKiDWvNuI4Ak2z4U3bdvrtTqJ
 pNAwRnoLBHHKrfNpX87cZMG8CIDIZItV0bQaMtx67nmfgaXc56ODKndRSN8LGscg0q+U39EYaO9
 As7kKtC49tbvtpi+4PwdKRMQOSkijVkn9ZFPRWy8/UrbyN/DYkJuE
X-Gm-Gg: ASbGncutFutOdAnX8DCsTbMwDK0DldC2flXg+jHXTOTVsoRk2vANCRxVHRlusMnnIJh
 EBI16Qsg2ed2XSHoxMxI2kXLYl4wxP9u9UuhFBJG4IzPo8pD8rZYGcnrtn1jS3ufwqK04wqYnJF
 thYVLLd7wk2bqoHuu10YON3/r53KA1pV8kAEWcsWSzOZXGCOLr0hOtFeItqSXM9S7EX7LVXMX94
 rVHRyUlkuv38ZqrX2Ub8SLccs3rBw4pKMwTs6jkFWeudLkfkTLrdDm3BHVDoNx1NpcafVwNWS5p
 5M0vUQRzcs8b2mjdSdi+li5Uddw4j1jyMDJ5BnHcEdXMuIwM1Q==
X-Received: by 2002:a05:600c:a014:b0:43b:d0fe:b8ac with SMTP id
 5b1f17b1804b1-442f9714d93mr28749955e9.30.1747315822340; 
 Thu, 15 May 2025 06:30:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8mrXyIDzbqUT5oVx98a/34rmnu81RgacNFYs+1jw1CUt4jlA3OGkmDSZ/SXR+4CDdGorYMg==
X-Received: by 2002:a05:600c:a014:b0:43b:d0fe:b8ac with SMTP id
 5b1f17b1804b1-442f9714d93mr28749585e9.30.1747315822008; 
 Thu, 15 May 2025 06:30:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4c5e1sm22505811f8f.89.2025.05.15.06.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 06:30:21 -0700 (PDT)
Message-ID: <f217e9fe-34ae-48c6-a5a8-dd157cc0a43c@redhat.com>
Date: Thu, 15 May 2025 15:30:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 09/42] vfio/container: discard old DMA vaddr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-10-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-10-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On 5/12/25 17:32, Steve Sistare wrote:
> In the container pre_save handler, discard the virtual addresses in DMA
> mappings with VFIO_DMA_UNMAP_FLAG_VADDR, because guest RAM will be
> remapped at a different VA after in new QEMU.  DMA to already-mapped
> pages continues.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Looks OK. Too bad the pre_save() handler doesn't have an
'Error **' parameter.

It shouldn't be too complex to add in vmstate_save_state_v().


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/cpr-legacy.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index 638a8e0..519d772 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -17,6 +17,22 @@
>   #include "migration/vmstate.h"
>   #include "qapi/error.h"
>   
> +static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
> +{
> +    struct vfio_iommu_type1_dma_unmap unmap = {
> +        .argsz = sizeof(unmap),
> +        .flags = VFIO_DMA_UNMAP_FLAG_VADDR | VFIO_DMA_UNMAP_FLAG_ALL,
> +        .iova = 0,
> +        .size = 0,
> +    };
> +    if (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
> +        error_setg_errno(errp, errno, "vfio_dma_unmap_vaddr_all");
> +        return false;
> +    }
> +    return true;
> +}
> +
> +
>   static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>   {
>       if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
> @@ -32,6 +48,18 @@ static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>       }
>   }
>   
> +static int vfio_container_pre_save(void *opaque)
> +{
> +    VFIOContainer *container = opaque;
> +    Error *err = NULL;
> +
> +    if (!vfio_dma_unmap_vaddr_all(container, &err)) {
> +        error_report_err(err);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
>   static int vfio_container_post_load(void *opaque, int version_id)
>   {
>       VFIOContainer *container = opaque;
> @@ -52,6 +80,7 @@ static const VMStateDescription vfio_container_vmstate = {
>       .name = "vfio-container",
>       .version_id = 0,
>       .minimum_version_id = 0,
> +    .pre_save = vfio_container_pre_save,
>       .post_load = vfio_container_post_load,
>       .needed = cpr_needed_for_reuse,
>       .fields = (VMStateField[]) {


