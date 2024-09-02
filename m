Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06182CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 06:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl06O-000593-NP; Mon, 02 Sep 2024 01:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sl06M-00058D-Nq
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 01:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sl06L-0004kG-7c
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 01:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725256783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VhZxB5vswG2Ct8al9vaG9TBWQ/Nn9ErDRSjGjEw7ce8=;
 b=VXJ/aZz8vzLYzjsnTNfKvPaAaGCmDzklRKDfDilYHfm0/W0caRXB0lJLM4pw01qzpzGIvs
 y8mBw3noI7Nt6UoUCzPDdVd77g8AWVlll/nPYJJUEdT90IrvVxCwisIgwWzwLLszZfYC50
 b1wBWeznoH5VQCRRZyvwi9A3yIoqprM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-0ByJcy2APnW84_2K_I2O-Q-1; Mon, 02 Sep 2024 01:59:42 -0400
X-MC-Unique: 0ByJcy2APnW84_2K_I2O-Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6c359012445so19927426d6.3
 for <qemu-devel@nongnu.org>; Sun, 01 Sep 2024 22:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725256782; x=1725861582;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VhZxB5vswG2Ct8al9vaG9TBWQ/Nn9ErDRSjGjEw7ce8=;
 b=PxqHHkxPFHP16GT0bGjHZmbTEGys50bCFLvc//vNsHfUMQ7vsKRP6TPUc683K11bXk
 DJgJN7WDYmTJjk2mwrepDUo00uE0eUUR2wVrcf/uFVCzq9bvtnEFFslX5/EBzFgfcEsc
 J8eO87nNjqexetYpnCRqFm6ievX7NuVsZRenu6+tWzSGr1Sx1e0GUu/xDG55Thu/pc3n
 CfUAfxS1KY6RzmavGMq/6r8hloisK9JUOETypOmUNseDqU6sXK1pMycSjqn4jAldRZue
 ZjCme25n1wH/vBa5EmxkNKEsDWWDo7HKUNhzrQSlv9JRXGhzQn8zpn8zJo6wHcZNHF5s
 brHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmpBR3D90EFXppKHJ6kPxHez7eqJ9CZynOvKkH2+xh43fxx5npwMFQEENsws4GbNT96i3SRHasZ5J0@nongnu.org
X-Gm-Message-State: AOJu0YwIWDkGakYEzZad2DWanOTwFwz9xvprJ+SlNePt6M3i9To/8q0Z
 ECLaVEW5gFKiOb1JG8FdxlvP61Eux2fRsl5H5Av+nUa9PEsjSLt/KU+uIIBvU9bVjYmmK8Lv6mw
 qZIg/aCObZGEFkAZi9PUUyK3EJYry4LYaVJnwUpdbQ/yZrDHtouV5
X-Received: by 2002:a05:6214:590e:b0:6c3:5db2:d994 with SMTP id
 6a1803df08f44-6c35db2dc82mr48293536d6.5.1725256782397; 
 Sun, 01 Sep 2024 22:59:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwgjhgjj6QLTwYceoJotRgtbWgMx07X1VYoggMUa0hXkjWjTHtzL1COGFhTIhvf2YMY4Yv1w==
X-Received: by 2002:a05:6214:590e:b0:6c3:5db2:d994 with SMTP id
 6a1803df08f44-6c35db2dc82mr48293436d6.5.1725256782049; 
 Sun, 01 Sep 2024 22:59:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340bfa80dsm39192126d6.5.2024.09.01.22.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Sep 2024 22:59:41 -0700 (PDT)
Message-ID: <6cd148e6-76ef-42f7-9d29-77a142ad4aa1@redhat.com>
Date: Mon, 2 Sep 2024 07:59:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] vfio/igd: add passthrough support for IGDs of gen
 11 and later
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>,
 qemu-devel@nongnu.org, c.koehne@beckhoff.com
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20240828134328.94528-1-c.koehne@beckhoff.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240828134328.94528-1-c.koehne@beckhoff.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/28/24 15:43, Corvin Köhne wrote:
> Hi,
> 
> Qemu has experimental support for GPU passthrough of Intels integrated graphic
> devices. Unfortunately, Intel has changed some bits for their gen 11 devices
> and later. To support these devices, we have to account for those changes. This
> patch series adds the missing bits on the Qemu side.
> 
> I've tested the patch series on an ElkhartLake and TigerLake device. On the
> guest side, I've tested an EFI environment (GOP driver), a Linux guest and a
> Windows VM. The driver of all guests are able to use the GPU and produce an
> output on the connected display.
> 
> Corvin Köhne (7):
>    vfio/igd: return an invalid generation for unknown devices
>    vfio/igd: support legacy mode for all known generations
>    vfio/igd: use new BDSM register location and size for gen 11 and later
>    vfio/igd: add new bar0 quirk to emulate BDSM mirror
>    vfio/igd: add ID's for ElkhartLake and TigerLake
>    vfio/igd: don't set stolen memory size to zero
>    vfio/igd: correctly calculate stolen memory size for gen 9 and later
> 
>   hw/vfio/igd.c        | 185 +++++++++++++++++++++++++++++++++++++------
>   hw/vfio/pci-quirks.c |   1 +
>   hw/vfio/pci.h        |   1 +
>   3 files changed, 161 insertions(+), 26 deletions(-)
> 


Applied to vfio-next.

Thanks,

C.



