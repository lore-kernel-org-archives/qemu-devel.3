Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C38E98FDD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAm5S-0007lX-OY; Thu, 09 Apr 2026 05:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wAm5Q-0007l3-AY
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 05:54:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wAm5O-0005oz-9Y
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 05:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775728444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Pp89kAiZwpw3jtnNjNoR/0X50v7RyA/+5wd8TEKCiS8=;
 b=AsN4gP37Tc6kegGd4jK81BInFmHrBAfvxNoLQaT9yaoBiwhsIOJim69cAmOfKcEJZoKT2n
 Ai5htA/2IX3EogRmcwgxBRMupsVkvhJIWvezzr/Myn4sqZ+QUfbC4Ibo4WsC9E307PtxrC
 45ZXTdrSv3uGjH8TNqJQmsq9hF8mNOE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-VpGhBJ9GNBGdoG2BT-bH9A-1; Thu, 09 Apr 2026 05:54:02 -0400
X-MC-Unique: VpGhBJ9GNBGdoG2BT-bH9A-1
X-Mimecast-MFC-AGG-ID: VpGhBJ9GNBGdoG2BT-bH9A_1775728441
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43b99add7f3so377782f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 02:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775728441; x=1776333241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Pp89kAiZwpw3jtnNjNoR/0X50v7RyA/+5wd8TEKCiS8=;
 b=nCGNZssQArOAsoWQqd+ZmuHXqWEqEwuczDZg9XGZxPqtA5qg/Rp0bGarsXEyWH27CE
 stpcphh8NJah42RwAOUreHbDcO2tPkJrilti1LjXEmyMlKfpU5fBOKoFvrsh5y9p7dwS
 mlJOBgqxvSM6b/5qWc2Y3MIeOmT944xPob/esDfV+SVn+jKgeAJm2lBqsuQI1ajIzDGT
 5zSiv3D/QXsbkrbz9rREaFn7EZsvZNBsogYnBEw9B+k41++Q1ZoJdd5rfISPUma+H8au
 1lMRheIFyonWu82P9JjahAK2YyPYSu4oHbMKVZFHPzq2xIb9UWB92iKpQ4vZWM/U0UsA
 f93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775728441; x=1776333241;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pp89kAiZwpw3jtnNjNoR/0X50v7RyA/+5wd8TEKCiS8=;
 b=frAhWB2dEEfR9Nq/Cmi6hgah8YKFYWiki1epqsw/4YlOcdm11eJGrD/AOclctScs7R
 HGAizgiMptdxf0as8Hppn7wkGlKyhFCV6cxKHjFF/P1qDebp9PI6qEoZUDJ4BVnzAN5S
 T1blMZcCg6fZbBWpreMutHztqY/BSg/gpupmGgcqL3nrGD2qdKys9ELz1/k3K4IYo+nI
 +wYfsg5lM7BrfnjkcofIwx7V79P/KdUDOmFaUU3YXNithL0FgrG0v6mVirRhhM4aEyJP
 /6GXilYFQ2WVKCYRxW5aGIBZPvn2BKLSHolONDqMclop25MUTTw4mOOx7kODcIgDxIjA
 WYzg==
X-Gm-Message-State: AOJu0YwlVM4H2+VRCjvuBOoJNLuVVn44hb3xiz+mG7MXhBBBjacvfG0S
 JGd+MdLL8l+XMkwjBoGlaJ1NqZLeNpVUZGTJGeTVxdVxbLZW4hB3cvopRu8kYQsV3K4Ow1bSnxc
 9boyN0g+IVA+aTRTuLzBEfDgK0WO77aRghKwBc214gj+yew/GwqJgELjY
X-Gm-Gg: AeBDieud3kxCJleLHo+eHVHVlA1D105WB9V6hpHqbNETlRkcmMM0AfW8uzV8yQMdue8
 9USMfzsl/XyXZmaWvQKrotOGjrnIFnsWoJXOrrjBZhQVkYm1ZfTfWS/2JGs4W3KhE7a/ogq9l3P
 14abICck0SbUWb1ytk+3Ln08IsSqCNNsfQNN3gGtzS5860ANxwfRcuJnTqf24WT+ftNA1QObFz7
 zXzXtDLQHE/xEw+fm4EJO4hWJgT94drvcKlzItEfSAPoW2rjzI2W/dqWnGSkj3kQR/YwcRpR+O8
 JPVZ9TtDo73MzG9WMesPjzSj0i1oaaCkXu4P+wR9lbGQ6mnCsFR4KsgjgKuS8pnxK3mFyOjw2i0
 OZ2VuNyhjt8xZis9wsxl1d8LpeFlvKvoPH5PwShD+uLPjYN1hO3aGXiEcpA==
X-Received: by 2002:a05:6000:2609:b0:43d:c06:bcd7 with SMTP id
 ffacd0b85a97d-43d595d8724mr3811385f8f.26.1775728440872; 
 Thu, 09 Apr 2026 02:54:00 -0700 (PDT)
X-Received: by 2002:a05:6000:2609:b0:43d:c06:bcd7 with SMTP id
 ffacd0b85a97d-43d595d8724mr3811326f8f.26.1775728439774; 
 Thu, 09 Apr 2026 02:53:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4e1c27sm63541935f8f.26.2026.04.09.02.53.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 02:53:59 -0700 (PDT)
Message-ID: <ed00dc34-858e-4d5f-9b43-28c39ef561d7@redhat.com>
Date: Thu, 9 Apr 2026 11:53:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vfio: quieten dma-buf warning
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>
References: <20260317195323.776669-1-john.levon@nutanix.com>
 <20260317195323.776669-3-john.levon@nutanix.com>
 <2bbd13e7-5d14-48c8-90a7-231a38537180@redhat.com> <adYYg-OgUUavR31j@lent>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <adYYg-OgUUavR31j@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/8/26 10:57, John Levon wrote:
> On Wed, Apr 08, 2026 at 09:52:53AM +0200, Cédric Le Goater wrote:
> 
>> On 3/17/26 20:53, John Levon wrote:
>>> Don't report this error every time,
>>
>> warn_report_once() is not every time.
> 
> It's every time the VM boots for an obscure feature that is totally irrelevant
> to non-kernel-vfio backends.

I agree. It's irrelevant for vfio-user.
  
>>> as it is specific to the kernel vfio
>>> implementation; we shouldn't warn about things that always happen, such
>>> as when this is backed by vfio-user.
>>
>> What bothers you is the "... kernel: " message ?
> 
> The existence of an incorrect and meaningless warning is my complaint.

I sense your irritation from across the Channel :)

>> We could use (!vbasedev->proxy) to change the "kernel" string to
>> an another one related to the device implementation. What do you
>> think ?
> 
> If I'm "allowed" to check for this to suppress the message entirely, then works
> for me.


VFIO_DEVICE_FEATURE_DMA_BUF should be available in Linux v6.19 and
QEMU 11.0. It is an important feature for large GPUs, PCI P2P DMAs
and most entreprise distros should have a KVM/VFIO and QEMU in sync
for it. The lack of dmabuf support is not fatal but it deserves some
"warning". I'd rather keep it that way.

The vfio-user implementation doesn't care. I agree. Sorry it was not
my focus. Anyhow, this raises an interesting question on the lack of
support of a feature for a specific backend.

I see 2 possible approaches,

1. quick one:

   Return -ENOTSUP and test the value in vfio_region_create_dma_buf().
   It's cleaner than masking EINVAL IMO.

2. cleaner one:

   Add a capability field to VFIODeviceIOOps to advertise supported
   features:
                                                              
     #define VFIO_IO_CAP_DMA_BUF        (1 << 0)
     #define VFIO_IO_CAP_MIGRATION      (1 << 1)
                                                                    
     struct VFIODeviceIOOps {
       uint64_t capabilities;  /* Bitmask of VFIO_IO_CAP_* */
       ..
                                                                   
and test vbasedev->io_ops->capabilities where needed.

How's that ? I can implement option 2.

Thanks,

C.




