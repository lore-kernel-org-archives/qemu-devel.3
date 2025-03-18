Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E875C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 10:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTmG-0007ia-Bn; Tue, 18 Mar 2025 06:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTmC-0007el-W5
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 06:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTmB-0003Go-8x
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 06:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742292140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AY+W9AtPUIlt8TSzbYVK2cOvaZnOLIYmVW0xz7DXKwI=;
 b=N+PJ0+VX030oRk5WPdJsgYxVnRBhuIyWDS0YIv41ofhp577p2oGXJUYRdHSJueedIuTHvW
 lSIbd73uAG+dud8lEB1bAinv8kksaXJgVKoXhgzAgelup1qq2OQY8yz5GyA+q1Ewhe0r/J
 R7GxQoB3TyFfwGUvTG+j9cGAkJpz1Go=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-LieyN3OkOkOVKNtAm0Tiug-1; Tue, 18 Mar 2025 06:02:19 -0400
X-MC-Unique: LieyN3OkOkOVKNtAm0Tiug-1
X-Mimecast-MFC-AGG-ID: LieyN3OkOkOVKNtAm0Tiug_1742292138
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d025a52c2so21816475e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 03:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742292138; x=1742896938;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AY+W9AtPUIlt8TSzbYVK2cOvaZnOLIYmVW0xz7DXKwI=;
 b=LBLG4Kc4SeWuSoPLcLHBs2mxWePR+Mw/EUoLxPam+UukD6XmLyyov9L5mPXPld3Au7
 2zy6neBCDzKaJSilc2o0aZNuagKDpRnocUXjR3Q11SGLYSUOF61VlKBowoLxd8gw698/
 NLfQ+R2yDjesLx5nr2yfW6ga4f6JmzaxSpn7JFV4fkM5rLiWP++wTjXHqBsTFmHxvzeS
 jkFadFOcHLU9opEfQmj0T3rKozPTmmfWv0Y8F6dW6Oh08vlAGctg15WCqp7AY9mavQmt
 SrynVnrvLhOp4A8Bk0RPj6H0dWc7K+W2jBzijVcKnQGdxRUTPBmUNxs3Wx0q/2gMIhsM
 hEdQ==
X-Gm-Message-State: AOJu0YwVLj5ImBXOZryZU3wK4VngYzzgy5mcUazg1HLJ87EczX/rfkn9
 fuCU2Tfv28QmW71gJ3t7xwP2e/2dYZq8rBQC8GeRFQEPuHlGBO2sx8wnYYMccm4JT9LSXa65pKp
 AI1HVE6Lz/7TpqCQnsUcKRs3XQ8De4NGQvOq0KG+nw6UCHF1DD0Eg
X-Gm-Gg: ASbGncufg8g5ZQ0XwNE15501+YZ0EldTqgS49nEcyl3YBWYg6yH3bSOc036dLkdnzDC
 Y4tgIwOWKVqaZp1OU9ZXY3JFA0sTPTbJIOek8vrDA/D36fV6EiYD9id9DIZH40DZ3jHCzkcjGBA
 mNKO5F59SCy4ymBU1hZQhrIpUxAbLCO0mJPDDCoSXUqBUb7WJarUFg4n5W+CyDw3WKE2mug9Etb
 6d8xQG225NFMagDdSeE7FSBC+e+48N6fNSy6zqByJmRDIoZM7Ygvm6Bc6Vhyj3o6MSHEXu5jYyk
 TKDPwie5ZdMZhwv2aUEv3+kXhq/t1ApCKmpZEK4NFR4s6QoliSTHxA==
X-Received: by 2002:a05:600c:c8f:b0:43d:934:ea97 with SMTP id
 5b1f17b1804b1-43d3b9ce6d9mr11664315e9.27.1742292138231; 
 Tue, 18 Mar 2025 03:02:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD0LpL+f6v9r+BAeX8V2WP0qxa8gVWnikxv+8bLRKG+rRZI310+obcj1f5H+oH3TiuZD2P5g==
X-Received: by 2002:a05:600c:c8f:b0:43d:934:ea97 with SMTP id
 5b1f17b1804b1-43d3b9ce6d9mr11663975e9.27.1742292137838; 
 Tue, 18 Mar 2025 03:02:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3974d771160sm13918361f8f.19.2025.03.18.03.02.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 03:02:17 -0700 (PDT)
Message-ID: <7dd34008-e0f1-4eed-a77e-55b1f68fbe69@redhat.com>
Date: Tue, 18 Mar 2025 11:02:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/28] vfio-user client
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Steven Sistare <steven.sistare@oracle.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <5910cf36-ca6f-489b-a7f6-b720733f16e1@redhat.com> <Z9RHndy/dxGentRq@lent>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Z9RHndy/dxGentRq@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/14/25 16:13, John Levon wrote:
> On Fri, Mar 14, 2025 at 03:25:53PM +0100, Cédric Le Goater wrote:
> 
>>> This is the 8th revision of the vfio-user client implementation. The vfio-user
>>> protocol allows for implementing (PCI) devices in another userspace process;
>>> SPDK is one example, which includes a virtual NVMe implementation.
>>
>> This series is going in the right direction. Thanks for all the
>> changes. However, I will postpone my review for the reasons below.
>>
>> VFIO initial commit in 2012 was a single file adding support for a
>> "vfio-pci" device. Since, the subsystem has changed a lot and it grew
>> to +16K line of code. Over the years, we've had numerous additions,
>> VFIO platform devices, s390x VFIO AP and CCW devices, migration
>> support with dirty tracking, support for different host IOMMU backend
>> devices, multifd, etc. All these additions never took the opportunity
>> to introduce a VFIO interface for external usage and PPC, s390x,
>> migration, backends subsystems happily and randomly peek and poke into
>> it. The subsystem is now a happy jumble of disparate functions, with
>> weak organization and names. The vfio-common.h header file is
>> good example of the result.
> 
> Right, I certainly agree!
> 
>> It's time for a global code reshuffling. I'll take care of it (and
>> I've already started) and this means nothing new (fixes are OK) will
>> be merged before this is done. I hope I have made enough progress
>> before the start of the QEMU 10.1 cycle. There won't be any functional
>> changes, but there will be new files and new function names, so it's
>> probably a real earthquake for your series.
> 
> It's had a couple of earthquakes already, very happy to bear the pain for a
> better end result! I will try to look out for your series and review where I can
> as well.

Here it is  :

   https://lore.kernel.org/qemu-devel/20250318095415.670319-1-clg@redhat.com/

Now is the time to prepare ground for your needs.

Thanks,

C.


> thanks
> john
> 


