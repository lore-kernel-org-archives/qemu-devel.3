Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92046F4180E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzdef-0002oV-2u; Mon, 09 Mar 2026 12:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzded-0002o8-LB
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzdeb-0008R6-6R
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773074423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OONw1393cXZM2tg4reXTBdd2MIJVsOZf4g9innuGPag=;
 b=g5YR2K4FIOZozETPme5xrpPozKvTt9vLK2nZayozdk+dcKGrVWUzyZZMRjkXFO49rzds3U
 fTYbD+ALnVH5t93HLEhMuyWsbkUv7GnYNDcmvBYmBpvR8Je5C05AJE/OQltJRISReMnXkH
 OUOAOCk+CMpAkfMKKsla8lCsy0yT3HA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-VHIMVez0O0eQ29ZapwxZsw-1; Mon, 09 Mar 2026 12:40:22 -0400
X-MC-Unique: VHIMVez0O0eQ29ZapwxZsw-1
X-Mimecast-MFC-AGG-ID: VHIMVez0O0eQ29ZapwxZsw_1773074421
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-485389bf0daso8517775e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 09:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773074421; x=1773679221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OONw1393cXZM2tg4reXTBdd2MIJVsOZf4g9innuGPag=;
 b=LvHUKo5VPxVLdHJujLZNoX45m3DUviZmg+bWZTrWHth6n5JyDzEJd3xRuvesuIUyIH
 S3ii6K3/J+pn7HG4k8muBb4yKCRaTISFums65WZBUaMc0LQFHMmkbdIVJPmulfvcvTCK
 D5xX6g787yCxKf5cPmOvnP/kEki/kG1KB4j7AJA1x1EOqHF3ecD8ep80lwyzWD9g2wd+
 UYsqBZ5bHZdkmantesFk/NVHxl+Eg1zK7gRBaaA6/oPEvZZU+/SeTmUNEekP7QKgpCr1
 t5z2CckVVWmt87HE/MY6WPB5gPgUs8/5hIWnPw6tmxw0OsNVnySTHv11wFwF1PYE8moa
 pf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773074421; x=1773679221;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OONw1393cXZM2tg4reXTBdd2MIJVsOZf4g9innuGPag=;
 b=wiXzqipft7nmqufPjEg1OwDUgrjaBMVGOLiK77qjoWxA6AEtjZM28/rsPtEU0e736v
 vhhjx2rfJ2dBTQSBOrV+epuKPBw8FFrmlWh2bL3FhN3UmhHhFzVyWeuZy/xXZfeMz7mW
 6q5LoRk01eMARyCGt8P/SgC5CGUzntKQoxPpD4+f6CopDZPN03ho+/3fltXAe9VNoTjY
 lypo+7M2kQydamRwNiVkQaFh3ldj1KfB3hPyIk0rlJ0B+5wx1vucn93R7jHP+l0Ny+oA
 idqkwZFTrVCDapq9l2S3QnreyfRSdkHtGi9JqMc1aLwFAb/2gpVLSOhEHXKVBtQaJofR
 ZdWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3qkjHbqWWq7G+hK9a2gO5Kp+Bpea/Bzej6RG0RgWQzQQNssyHj2i3preMCzNKNBgihYMghXiTOI/K@nongnu.org
X-Gm-Message-State: AOJu0YyRpxa7/tTf3c558N0cE2DtSF3ccBGTilcgUpggA29EL9pIDusb
 1ZMArKiCj0+7rYC2f3FydRU8GjOlL0dv4wW8grOfQseUQqMQewLt5WCIY9mWWuk95B1JiybBxxC
 cQQ3Hv9szMB0zNY9KpFgRZmWtfpoL4eU4+f5kpKVJAFJa11Vy30tKAACm
X-Gm-Gg: ATEYQzzfr6xVYr31Nqo8Ifm8BOoLXM95uHQQIgDwCpbPcsONqOHP75ZpGfw12Nx3D5V
 uLXim7p06kD2nIMewPa7JhBiSaoD1PDlqQoBHH8XO7oFWzzV2uMlYgGUqCFKx8pxbx5MRJu+VRZ
 t5eyrLQhEYRzK6X5X3BfVPTJBF9KfmV9ZpeGABmXjwiIccqBbD5jeXi74gUUxXFFCvZeT/JIuGR
 t99wxe66OjSy154/xL6d5aBdi/f5bYZiKV6uO7i83kaTUR0rbsF7pqh4wTKM74Xa06lBJDMyvkV
 50PzRLA96sN35SysEzuI69P6rx7eQIjbUJC2UcLncJ6RWV1lDSuj9NAAMGFdpePdNwwq1QQfm7/
 qXvg128eetTVChn9cyRATJVg3ZGdGItoMECxPy9hv7rNlpY1ErOf7qaqM3/g+/t9NZdV5l3NsF4
 ZYqAoXFUOgc3LGtXbcynruBLErzJbXLGBEvFvM6p7BfU3kOcgIkd4=
X-Received: by 2002:a05:600c:500d:b0:483:709e:f238 with SMTP id
 5b1f17b1804b1-48526968008mr187248925e9.29.1773074421221; 
 Mon, 09 Mar 2026 09:40:21 -0700 (PDT)
X-Received: by 2002:a05:600c:500d:b0:483:709e:f238 with SMTP id
 5b1f17b1804b1-48526968008mr187248595e9.29.1773074420752; 
 Mon, 09 Mar 2026 09:40:20 -0700 (PDT)
Received: from ?IPV6:2003:cf:d737:d0cf:29d5:15fb:d605:1d53?
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad1cb7csm28486892f8f.0.2026.03.09.09.40.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 09:40:19 -0700 (PDT)
Message-ID: <db80a6cc-2e77-4da4-980f-20a63f398eb8@redhat.com>
Date: Mon, 9 Mar 2026 17:40:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC 2026] vhost-user memory isolation proposal feedback request
To: Han Zhang <ihanzhzh@gmail.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, tfanelli@redhat.com
References: <CAHjCdDAJomXwQ8Z0kkiDGn_8hLWredsby3Nwy4rRgeC9sywc8A@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAHjCdDAJomXwQ8Z0kkiDGn_8hLWredsby3Nwy4rRgeC9sywc8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 09.03.26 12:17, Han Zhang wrote:
> Hello,
>
> My name is Han. I previously implemented a virtio-based communication
> mechanism between confidential virtual machines, and based on that
> experience I would like to apply for the QEMU GSoC 2026 project
> "vhost-user memory isolation". Before finalizing my proposal, I would
> like to check whether my understanding of the project direction is
> correct.

Hello Han!

Thank you for your interest in this project, good to hear you already 
have experience with virtio!

> My current understanding is:
> without changing the existing vhost-user protocol, add a
> memory-isolation mode for vhost-user devices so the backend no longer
> directly accesses guest RAM. Instead, QEMU intercepts virtqueue
> requests, copies data between guest RAM and isolated buffers, and
> forwards notifications. The backend only sees QEMU-managed shadow
> virtqueues and descriptors pointing to isolated buffers.

That is correct.

> After reading the relevant code paths around vhost-user-blk and SVQ,
> my current understanding of the required work is roughly:
> 1. Extend the generic SVQ path for the vhost-user case, including
> adding a used_handler so completion handling can perform copy-back and
> cleanup before returning requests to the guest virtqueue.

You mean used_handler as a counterpart to avail_handler?  That makes 
sense indeed.

> 2. Move the SVQ vring memory to memfd-backed shared regions and
> register them with the backend through add-mem-reg/rem-mem-reg, so the
> userspace backend can access the shadow vring.

That must happen in some capacity, although I would have assumed that 
there is already a mechanism for this, for the vring memory itself.

> 3. Allocate bounce or isolated buffers at the SVQ callback point, copy
> data from the guest virtqueue into those buffers, forward rewritten
> descriptors to the backend, and copy data back on completion.

Right.  And these too would need to be shared with the back-end, too.  
Ideally, they are cached, of course, to reduce the number of buffer 
add/remove functions that need to be run.

> I am mainly trying to validate whether this is the right architectural
> direction, especially the split between generic reusable vhost-user
> SVQ code and device-specific handling such as the vhost-user-blk
> bounce-buffer path.
>
> I would appreciate feedback on the following:
> 1. Is this interpretation of the core goal correct, especially "QEMU
> performs data copy, backend only sees isolated memory + SVQ"?

Yes, it is.

> 2. For isolated buffers, is qemu_memfd_alloc + add-mem-reg the
> preferred direction, or is there a better approach?

I’ll defer to Tyler and Stefan on this, but in general, I would say if 
it works, it works.  It does sound good to me, fwiw.

> 3. For code organization, what split is preferred between generic
> vhost-user code and device-specific code (for example vhost-user-blk)?

Ideally, it is completely generic, nothing in the device-specific code.

> This is my first time participating in an open source project, so I
> would greatly appreciate any correction or guidance.

Perfect for GSoC! :)

Hanna

> Thank you very much for your time.
>
> Best regards,
> Han
>


