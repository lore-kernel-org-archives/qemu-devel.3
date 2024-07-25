Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FA9C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 05:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWrQs-0003M2-7o; Thu, 25 Jul 2024 01:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWrQq-0003KT-D6
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 01:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWrQo-0005sH-4N
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 01:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721886864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dh3yyuBj9HXf2A5cEfYqf0NaFgetwfgWSnefr6wKli8=;
 b=Sg/oqDl3/zMVoIHGHP/9dA9o42bLVI+uErD2W0FnHd5ht+/ozbOH1kk/KqA3weiw0r/QCZ
 Od2bx09pFEGgeEtbU1d6dIsOCp+DW3DmB8qZ9O18JPcbJ8TGLi565oG7HHWD3VbiL3bKv8
 IwAsX6opCb1rXSkEfI1XuzfQyxyk9kE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-kh7x8InlPJuolAgAxFeNkA-1; Thu, 25 Jul 2024 01:54:21 -0400
X-MC-Unique: kh7x8InlPJuolAgAxFeNkA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36832c7023bso357233f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 22:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721886860; x=1722491660;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dh3yyuBj9HXf2A5cEfYqf0NaFgetwfgWSnefr6wKli8=;
 b=JKCybj1pZgp1pPKoiTG8w7AEsjUYARxEhwPnt9LZ68E/02atqHtpxMNo4YvJTv5SdH
 +GahEbGcZEMtz34Kpmb6DWegD4/pva1MswKSPrS9r9YUCd3+hgp6oDO+CRiqZY1wxjFI
 GYu1f13GSocl+UUo/aW3mbuEN6GPGvNsvxRRq/W82SqSwQJlpOYAXlRcnQ9JdeHf+RD6
 MnlIr8e825AyJsSdca+C915hAMCOIg2f7aryqZKhfy/MpXDRfvjE1kqWkUglsA7wTBOe
 z3o1kbNz5IkDRywF59X/WvZPYh88NIV+wO8Ea53/XvUR0Q30A0BCUQGjdvrj0xse9yQE
 tV2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSybG6PAmwbhePZ2hvYqGrEeq/3agj1VBabwa2rO9aCj3oCWFe9AVB6thuiLIIP0zGVS5bSD5MVdFmCUSoNIu+6hnQ4Gc=
X-Gm-Message-State: AOJu0YxkmIPLQfgHsLVb/OnL3Xh3ze+zaXBXVwX56Kby7HwwpxHIinTQ
 cRoBVZDeR/D71bHoROZi1C9Xe7hrvFcXhFKrvypHoHfKY5+0UaFTjYHwIeLovHEfdr4dzQTzLWA
 +RCcGfIy1FoI2tmEZsbfXTw343B4Ix+4LtW8ZDtZ9+iwkuNZG/sFq
X-Received: by 2002:a05:6000:1942:b0:368:3038:8290 with SMTP id
 ffacd0b85a97d-36b36421ac8mr707595f8f.39.1721886860524; 
 Wed, 24 Jul 2024 22:54:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI3Abal444WmsilGMojUOB9llheQDVQUaMgG30HCOZkmwXntXo9Fy/JkeXGpR8m6xgr9AF9A==
X-Received: by 2002:a05:6000:1942:b0:368:3038:8290 with SMTP id
 ffacd0b85a97d-36b36421ac8mr707561f8f.39.1721886859582; 
 Wed, 24 Jul 2024 22:54:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:8427:35e3:731c:3106:ee46])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857dcesm900105f8f.85.2024.07.24.22.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 22:54:18 -0700 (PDT)
Date: Thu, 25 Jul 2024 01:54:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 "Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
 "Luu, Ryan" <rluu@amazon.com>, "Chashper, David" <chashper@amazon.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 "Christopher S . Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] ptp: Add vDSO-style vmclock support
Message-ID: <20240725015120-mutt-send-email-mst@kernel.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 24, 2024 at 06:16:37PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The vmclock "device" provides a shared memory region with precision clock
> information. By using shared memory, it is safe across Live Migration.
> 
> Like the KVM PTP clock, this can convert TSC-based cross timestamps into
> KVM clock values. Unlike the KVM PTP clock, it does so only when such is
> actually helpful.
> 
> The memory region of the device is also exposed to userspace so it can be
> read or memory mapped by application which need reliable notification of
> clock disruptions.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

one other thing worth mentioning is that this design can't work
with confidential computing setups. By comparison, mapping e.g. a
range in a PCI BAR would work for these setups.
Is there a reason this functionality is not interesting for
confidential VMs?

-- 
MST


