Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE647C48BC1
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 10:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZq5T-00014N-90; Tue, 13 Feb 2024 05:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rZq5O-00013z-EO
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:32:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rZq5M-0000tH-EW
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707820339;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K/t4fBmTkJs4iS6e8hFIdNZeF7ZyRsPtO63wLbuBZ0A=;
 b=UEpnV7iyR01xuuiPt3finjKLLoGTJ1tLGQ1wVnJyNXeSSaBvOjRYjzU+r7a4GfW9GXqHth
 mzI06g9XyK8sgBciSGlV0Dmx8Wi8rCmGfi0uN6+05ykxvjDRhEu5ZaF+1SndkLJE4tiFi4
 A0FKwQKrJy4pPIYpLbWEww1fWA2jm3w=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-wwYma7OSMsWlWY2LtuvYaw-1; Tue, 13 Feb 2024 05:32:17 -0500
X-MC-Unique: wwYma7OSMsWlWY2LtuvYaw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-680c651928eso69771426d6.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 02:32:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707820337; x=1708425137;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K/t4fBmTkJs4iS6e8hFIdNZeF7ZyRsPtO63wLbuBZ0A=;
 b=Pn8NePiSNGiClzhfZ3n9AEj0B+yhdjlPeiqrg+DE3G9x9iCL494cELFYuAkIDxvpRh
 TgbHLpssRnCz4eEGLOpkLNF1Mj261XvCzcwlnS9vCegBcdHgpe7K9ag8f+EPeDSkGEZJ
 T6VxGs0fqPN/6/qbFrsGQIncqS+1DZrJkfispF/tN46TrIqAcbI/SdYKuR7G25AjDM9w
 7Ht+AVklb9Oa3SHnZTqycpWnkpeMQveA9bpbO59weqb4TiYlP/u/eOk2Xy1eBD/gK47j
 Q39//CNZNHdwQ65O0LxqpwIekAs8pOy6Sv26wCJunsqfwo6bGwcfkEif/P2vSQvuURhx
 XFlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrE8TK2rDxadyY/5ikEzRrcyba9wPl6ur+DEKXQKWa/wmFE+9c7oHeRRFKoKq2RCwhbrHOGMpZZIi6CcL59/LAZBaDT+E=
X-Gm-Message-State: AOJu0Yxwe6kxjEBQzFQOgrUP5914YBRIfDcxwFYX/eZJpB4YvKcHtFJM
 DTDfslpkEzXyjSGjwtNGYbwvjGyBQ06hQpkE3ZpmOBUyOAAMYdheS8LrUt4iLWQxd5HzQMoa/0n
 xsUAsS9VrxVlh7sXsAlOoTeXSddQWXIaStk9rY5J21VHMuQl9y7/n
X-Received: by 2002:a05:6214:d45:b0:68c:c37a:a274 with SMTP id
 5-20020a0562140d4500b0068cc37aa274mr13619630qvr.3.1707820337376; 
 Tue, 13 Feb 2024 02:32:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUMY6pOY5vxVwF8YhuXzjJDvAbAHwj7SzW6CGQFbgRSeTLU7knStTXAG4J8IQn/xzwv10h2w==
X-Received: by 2002:a05:6214:d45:b0:68c:c37a:a274 with SMTP id
 5-20020a0562140d4500b0068cc37aa274mr13619609qvr.3.1707820337028; 
 Tue, 13 Feb 2024 02:32:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW4D2iVIJZ4cqfUKgo//RC1qeePF0WrLDB05xeb4k4GiFiaHa2pi1wOxK2Ie8/1aTx1n2Ja1PKXYNzJ7FWsLV6dgvj3YhDe/ReWVNjTxtJ8ZEy52J7A6F6HYqEopaMIY//64nLjDP1ZNdBI1/JORBVGHpfv1Af6M2c6mfOT/IsR54r0pa2hkkfgmNBl/yWqVS3hGunDsa2IHJpS/tXKTb7+RXXnfSbSr9BEFPIatUYVjdH5FKxNiuvvUiU=
Received: from ?IPV6:2a01:e0a:59e:9d80:4685:ff:fe66:ea36?
 ([2a01:e0a:59e:9d80:4685:ff:fe66:ea36])
 by smtp.gmail.com with ESMTPSA id
 nf7-20020a0562143b8700b0068caa42dbf3sm1130654qvb.91.2024.02.13.02.32.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 02:32:16 -0800 (PST)
Message-ID: <6d4b5766-f8e2-4889-827d-01d3509239f7@redhat.com>
Date: Tue, 13 Feb 2024 11:32:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-iommu: Use qemu_real_host_page_mask as default
 page_size_mask
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, alex.williamson@redhat.com, clg@redhat.com,
 peter.maydell@linaro.org
References: <20240117132039.332273-1-eric.auger@redhat.com>
 <20240213044312-mutt-send-email-mst@kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240213044312-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Michael,

On 2/13/24 10:43, Michael S. Tsirkin wrote:
> On Wed, Jan 17, 2024 at 02:20:39PM +0100, Eric Auger wrote:
>> We used to set default page_size_mask to qemu_target_page_mask() but
>> with VFIO assignment it makes more sense to use the actual host page mask
>> instead.
>>
>> So from now on qemu_real_host_page_mask() will be used as a default.
>> To be able to migrate older code, we increase the vmstat version_id
>> to 3 and if an older incoming v2 stream is detected we set the previous
>> default value.
>>
>> The new default is well adapted to configs where host and guest have
>> the same page size. This allows to fix hotplugging VFIO devices on a
>> 64kB guest and a 64kB host. This test case has been failing before
>> and even crashing qemu with hw_error("vfio: DMA mapping failed,
>> unable to continue") in VFIO common). Indeed the hot-attached VFIO
>> device would call memory_region_iommu_set_page_size_mask with 64kB
>> mask whereas after the granule was frozen to 4kB on machine init done.
>> Now this works. However the new default will prevent 4kB guest on
>> 64kB host because the granule will be set to 64kB which would be
>> larger than the guest page size. In that situation, the virtio-iommu
>> driver fails on viommu_domain_finalise() with
>> "granule 0x10000 larger than system page size 0x1000".
>>
>> The current limitation of global granule in the virtio-iommu
>> should be removed and turned into per domain granule. But
>> until we get this upgraded, this new default is probably
>> better because I don't think anyone is currently interested in
>> running a 4kB page size guest with virtio-iommu on a 64kB host.
>> However supporting 64kB guest on 64kB host with virtio-iommu and
>> VFIO looks a more important feature.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> What about migration compatibility? In particular, cross-version one?
> Don't we need compat machinery for this?
See below
>
>> ---
>>
>> v1 -> v2:
>> - fixed 2 typos in the commit msg and added Jean's R-b and T-b
>> ---
>>  hw/virtio/virtio-iommu.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 8a4bd933c6..ec2ba11d1d 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -1313,7 +1313,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>       * in vfio realize
>>       */
>>      s->config.bypass = s->boot_bypass;
>> -    s->config.page_size_mask = qemu_target_page_mask();
>> +    s->config.page_size_mask = qemu_real_host_page_mask();
>>      s->config.input_range.end = UINT64_MAX;
>>      s->config.domain_range.end = UINT32_MAX;
>>      s->config.probe_size = VIOMMU_PROBE_SIZE;
>> @@ -1491,13 +1491,16 @@ static int iommu_post_load(void *opaque, int version_id)
>>       * still correct.
>>       */
>>      virtio_iommu_switch_address_space_all(s);
>> +    if (version_id <= 2) {
>> +        s->config.page_size_mask = qemu_target_page_mask();
I tested migration from v2 -> v3 and the above code is overriding the
new default by the older one.

Do you have an other concern?

Thanks

Eric
>> +    }
>>      return 0;
>>  }
>>  
>>  static const VMStateDescription vmstate_virtio_iommu_device = {
>>      .name = "virtio-iommu-device",
>>      .minimum_version_id = 2,
>> -    .version_id = 2,
>> +    .version_id = 3,
>>      .post_load = iommu_post_load,
>>      .fields = (const VMStateField[]) {
>>          VMSTATE_GTREE_DIRECT_KEY_V(domains, VirtIOIOMMU, 2,
>> -- 
>> 2.41.0


