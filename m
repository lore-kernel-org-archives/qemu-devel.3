Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D047C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 15:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9QEI-0003fe-Nk; Mon, 28 Apr 2025 11:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u9QED-0003ej-9d
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u9QE5-0007aa-Ah
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745853415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nfqPFO4/1FBkTuIfv1GfJlCIfTUAtLsrwtuVYQq36us=;
 b=WbH9EZq/eQFmZ7e4ji6edYsevV2c+3ROaZpN09npgA7LlTRe9WaENU1o3pjTp7WEjs8ypF
 42Ym+AYQW70ZlTdG6Nb+RDqnKnfM8tbvDNgK2kRWGBWUMsUYKUSVuHYZKvqYgPFNvUqZhZ
 X5IrE8q5KA+lvCP1kYumHeZ54J4JX1w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-JEmKD37MOvKXclgIG-RBMQ-1; Mon, 28 Apr 2025 11:16:53 -0400
X-MC-Unique: JEmKD37MOvKXclgIG-RBMQ-1
X-Mimecast-MFC-AGG-ID: JEmKD37MOvKXclgIG-RBMQ_1745853412
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912539665cso2352033f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 08:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745853412; x=1746458212;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nfqPFO4/1FBkTuIfv1GfJlCIfTUAtLsrwtuVYQq36us=;
 b=lNe5PaeeA8K7bTs7Kk5taabl5bQT+p9kUPxF3BrBrof+TTSFBaEc5NTgHDhL/9zThR
 Ab+ideVBA82PkeMJekmcE/8sdBS6Iod+rFDjGyyhCL/7+bNCk/wO4tU8scwoWZAAYECS
 lcdqUXC25TnlRqCr0Ps/c1WRsO6y1uXaUZyJvq/FczUjUW8J0apLHOasivkf+vLbY8xp
 DcDc05c7JCl4RjpY5V0mZzMgzyjEbyhsSY4Rp+5N8qMdi0EP8xFzDWGBGxLvygr5sSch
 i1nzi9q+kkHSoTNLShk5M9L69lI/innEQeUgAZD4n237B4exMq49dmxjuUBwjfe+vJdL
 Fuxw==
X-Gm-Message-State: AOJu0YzHbCw5eoXF1dTDVhh1omKZE2lrSxSss6ea9n7lGgM8IgHfqZsL
 14TrDE1Nh3/z1eIO//kf4rHQTtedXIkxKStVV4raNef6ChonYrctzQB0QZlU8n8uawBhk0iV4u3
 wHeYDE7iIZfTvNLPbghVipsidnaOOpXqaSpHVVLFNZrfFcTQq7lYO
X-Gm-Gg: ASbGnctGB7/xgp4nNSRAm32o/2DI8WzHxjFamZZZHu6qlKVP1N4lkRjLiT2uzuTkSx4
 iMAA9j7IYHq25/rHGVOht3khop+AlRgPsmTBnmgnsDt1kkNjMj01Ig9siRw731Ii5RxV0Ih1QG9
 Ipv4PmpErTnLL7EAvt2zRvKu+w/sLBNNakMpdcQmQ7Td4076J4tpK5ejKkEbCm/Ghn/yKt2knBN
 41PnlMcKKxKuOaoK7SI47qnnfBWHsZyd1/czwsWoj31+IPLNmQw8pSQhJ/vyYufzSLd3cXvO2G8
 BevmHB4XhaG8gIQ65V79PTYIqxMHF/ZSdHXoujHvZzJrezFVFA==
X-Received: by 2002:a05:6000:1a8e:b0:39c:30f7:b6ad with SMTP id
 ffacd0b85a97d-3a074d46321mr10603244f8f.18.1745853412472; 
 Mon, 28 Apr 2025 08:16:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa/n/IxvE9Zb9tyTnvnKIkNVDoBA1igOMq/sc3mVvFLbErFLbNoKXX7lYwtB7IjTix89R+7A==
X-Received: by 2002:a05:6000:1a8e:b0:39c:30f7:b6ad with SMTP id
 ffacd0b85a97d-3a074d46321mr10603208f8f.18.1745853412078; 
 Mon, 28 Apr 2025 08:16:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca435dsm11370667f8f.21.2025.04.28.08.16.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 08:16:51 -0700 (PDT)
Message-ID: <cc1c765d-2eab-4acb-a5e4-48521d51976e@redhat.com>
Date: Mon, 28 Apr 2025 17:16:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] vfio: add region info cache
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-13-john.levon@nutanix.com>
 <1eb29556-a03d-48c2-91d0-b4934b226e51@redhat.com> <aApmSCNUQsDxh9hX@lent>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aApmSCNUQsDxh9hX@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/24/25 18:26, John Levon wrote:
> On Thu, Apr 24, 2025 at 06:08:21PM +0200, Cédric Le Goater wrote:
> 
>> On 4/9/25 15:48, John Levon wrote:
>>> Instead of requesting region information on demand with
>>> VFIO_DEVICE_GET_REGION_INFO, maintain a cache: this will become
>>> necessary for performance for vfio-user, where this call becomes a
>>> message over the control socket, so is of higher overhead than the
>>> traditional path.
>>>
>>> We will also need it to generalize region accesses, as that means we
>>> can't use ->config_offset for configuration space accesses, but must
>>> look up the region offset (if relevant) each time.
>>
>> This change is an optimization for vfio-user. I would prefer to keep it
>> for after enabling vfio-user.
> 
> It's not vfio-user specific. Just to clarify, you want this code:
> 
>     static int vfio_io_region_write(VFIODevice *vbasedev, uint8_t index, off_t off,
>                                     uint32_t size, void *data, bool post)
>     {
>        struct vfio_region_info *info = vbasedev->regions[index];
>        int ret;
>    
>        ret = pwrite(vbasedev->fd, data, size, info->offset + off);
>   
>        return ret < 0 ? -errno : ret;
>     }
> 
> to become:
> 
>    static int vfio_io_region_write(VFIODevice *vbasedev, uint8_t index, off_t off,
>                                    uint32_t size, void *data, bool post)
>    {
>            struct vfio_region_info info;
> 
>       ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, &info);
> >       struct vfio_region_info *info = vbasedev->regions[index];
>       int ret;
>   
>       ret = pwrite(vbasedev->fd, data, size, info->offset + off);
> 
>       return ret < 0 ? -errno : ret;
>   }
> 
> 
> i.e. every region read/write needs to look up info each time?

Oh I didn't this. So the introduction VFIODeviceIOOps is not seamless.

> If not, what are you suggesting?

vfio_device_io_region_read and vfio_device_io_region_write should come
separately in patch 13.

Let me comment more this patch.

Thanks,
C.



