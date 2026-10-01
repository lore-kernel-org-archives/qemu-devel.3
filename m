Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07498CA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCJni-0005Bl-18; Thu, 01 Oct 2026 12:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xCJnf-0005At-UR
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:38:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xCJnd-00020a-Tr
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790872704;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u6M9UKb1fxNfsLXR0PSjA271oDVBL/V4De3OzMxeH9Q=;
 b=HaVyZc5u9TUvHgzYvV+gQ9Gcls7KobJyhsm3UifhIVeNRZ0X8QXgopshl7OHA6kCwyPOWC
 vVHl+0rCIdtpdTECUlgz3KkvJ684dTHh8aSZulXYTV+7jxc/DLzxzz/SK6C0DJ4u9tvbPW
 uotjo+6lN19EKYYXTUaSSomb1evhImA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-jx8tr0DqO3ynnlKWB-Hq8g-1; Thu, 01 Oct 2026 12:38:23 -0400
X-MC-Unique: jx8tr0DqO3ynnlKWB-Hq8g-1
X-Mimecast-MFC-AGG-ID: jx8tr0DqO3ynnlKWB-Hq8g_1790872702
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a01d1fb07bso13620995e9.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 09:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790872702; x=1791477502;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u6M9UKb1fxNfsLXR0PSjA271oDVBL/V4De3OzMxeH9Q=;
 b=D4KjbaaddbHSc0GqKO+0JFYNYW6RMHTDMl9H41u2NlB0JKOh6IszOH1DyzxPMqrme0
 LsGgrEtE2DJYZkt5oFui+ADBm5wPinf0dGUw9qPUCM1KgBf+UtvO2yiSlkTm/1a0wHMO
 oG8844zQl+1SfJG7sb/8IE5iWBfXIFK8ZW7Fmghex5Hnhj017IBvjeUdRH3TyMq93McH
 IUIG8oLo4zpYTtxVN2Y1lOe9DPNUApTghXESWbGJjWFQxGSrPDNX627ZyeqAhckfckVt
 ql79X2rAfAaD8MuYsYo2pQ0TAGelX5vlwIZmht+GiOwo/gMx31oA62U+2Fc7eaJ4W9ws
 bC9w==
X-Forwarded-Encrypted: i=1;
 AKwUvByWQOMJ/dwRg9SwpcuXifJCmxr/FtJNPaYvZoUz8Fd0x0i9RlcztDwR3TvMC1iu9FFrFVZ5B3xVXT5m@nongnu.org
X-Gm-Message-State: AFuF++mpxpYwFNdGyQb8Ay1QASsD1tAYHX3cAqj0oG0GC9E5HhrjfSGj
 j8VUU9hnC+k3ELIuFhutjcUc5tvjh8XcsO5OU/I2RHQgEzp0wNEJQFeX6SwXftU2qulS+fVd2j1
 K1EUVN7UqkzdXE21Dh0+FxROIXTTIahAxRExmahplyzz0LUHvhRD8eFl2
X-Gm-Gg: AYBFou0BC2+ad3iTpBa62Ml0OOjebGfrQ9aZ25tNu3V+8rZP1uJbOsHiWpYYFObaQgO
 s1iq8jIpiEoAe0hOH3N9InZzsf9NCYqPD/VVfUTnrGBT1BmDqXlZxj7ZQ0PkE++qqX5vS9KbxAp
 h11kpRZX5WUtc0O0tEyeyvy6+Tyk5IXhh0LcAfCdyX7NV+ncHbnoHN11w663xZ8VPvCV26J9D15
 v/NVNoArUfRBD8XvC/a+Qurs2zQFQvpHVnnEc5N92u/2SgV9Rfkm2ksX80ZENhMQRUZLOUZhcmB
 m+BRBfCtFOJcUJnNHzHr0IstkUR+I6q5AqP0VnNM9GuVI6KR9mRy3wTZBgUoIdmVwBjy/p1uBys
 39SIn5+vDwrYJAOUCb88wrwMsGmCXWeOjvRiWXKxMiPiGkKu5
X-Received: by 2002:a05:600c:3e05:b0:4a0:dca:b78 with SMTP id
 5b1f17b1804b1-4a027578502mr3522615e9.27.1790872701835; 
 Thu, 01 Oct 2026 09:38:21 -0700 (PDT)
X-Received: by 2002:a05:600c:3e05:b0:4a0:dca:b78 with SMTP id
 5b1f17b1804b1-4a027578502mr3522295e9.27.1790872701432; 
 Thu, 01 Oct 2026 09:38:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b0690c47dsm7173820f8f.15.2026.10.01.09.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 09:38:20 -0700 (PDT)
Message-ID: <9b1fdb01-aa08-4cb3-a476-e644dfb15223@redhat.com>
Date: Thu, 1 Oct 2026 18:38:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/7] hw/arm/smmuv3-accel: Restore accelerator state on
 incoming migration
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jan@nvidia.com, jgg@ziepe.ca, ankita@nvidia.com,
 aniketa@nvidia.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com
References: <20260904180513.248396-1-skolothumtho@nvidia.com>
 <20260904180513.248396-6-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260904180513.248396-6-skolothumtho@nvidia.com>
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
> Extend the accel subsection post_load, after the IDR check, to bring the
> host side back in line. It allocates the vEVENTQ, which the A_CR0 write
> handler normally does, using the restored s->eventq.log2size. It attaches
> the HWPT for the restored GBPA to every device. Then it replays the STEs,
> which overrides that HWPT wherever the guest has a usable entry.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 6678e49f6e..b653f3f4ce 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -1165,6 +1165,28 @@ static bool smmuv3_accel_vmstate_post_load(void *opaque, int version_id,
>          return false;
>      }
>  
> +    if (!s->s_accel->viommu) {
> +        return true;
> +    }
> +
> +    /* Normally done by the A_CR0 write handler, which is not replayed. */
> +    if (!smmuv3_accel_alloc_veventq(s, errp)) {
> +        error_prepend(errp, "Failed to restore the vEVENTQ: ");
> +        return false;
> +    }
> +
> +    /* smmuv3/gbpa is listed before this subsection, so it is in place */
> +    if (!smmuv3_accel_attach_gbpa_hwpt(s, errp)) {
> +        error_prepend(errp, "Failed to restore the GBPA HWPT: ");
> +        return false;
> +    }
I would recommend to document the order of operations somewhere, ie.
registers first, data structures in guest RAM and also list all the host
resources that need to be reconstructed

Looks almost too simple :-)

Eric
> +
> +    /* Everything else comes from guest memory, which is already restored. */
> +    if (!smmuv3_accel_replay_stes(s, errp)) {
> +        error_prepend(errp, "Failed to replay the stream table: ");
> +        return false;
> +    }
> +
>      return true;
>  }
>  
Eric


