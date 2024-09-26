Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402CACCF9E9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 09:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stki8-0001ps-7V; Thu, 26 Sep 2024 05:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1stki6-0001pP-By
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 05:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1stki4-0000uB-IK
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 05:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727342570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xVwxEp61d36MeUHvdY6DKROPmKsWKa+K587S+dQB5rI=;
 b=a0UUV323lgCzlEvbjA0BneLHzSoEGi2pv5XDQh4bh2aSPdniiCmnhEyCaZ9Ig5yIrOnkUf
 oSx04TWl74tgGErP63nu2DLJmacEjatPUEKFbsvU37a1dSSSPZE/93L7U62VUCIROKGZGh
 GFu4dm45R1z5puf/8Nc19k2jSB0t1qU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-YIV98s7GNWWtGcCKFi-q7w-1; Thu, 26 Sep 2024 05:22:48 -0400
X-MC-Unique: YIV98s7GNWWtGcCKFi-q7w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cceb06940so4601535e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 02:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727342567; x=1727947367;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xVwxEp61d36MeUHvdY6DKROPmKsWKa+K587S+dQB5rI=;
 b=l3fe9Bf9b6SyZd43jz8qCJohJH5tLTeknFwxKLFHkdmeC2lwq37m3oYqKu4GLfLVOn
 vcRlfypZN67UOn04Kub+9cFKHwHBg9+T/ausvstkri7lZATRHDqEwKEZOLbBEGg8KvXm
 f1wIoaQJswvcAYUTirPQ6Z2YFEONmPvvlvoXN5ObXlmq8xi40fnjKsSwH+QL5nodXq+q
 QnJomJdbQBpHIeaCgYlCU8MGNTKO0yeKeiC91e/38181bhio8yaWn44zCZdcDZWyBMR4
 L76YHZzX8SMqtZ2Y04vvPQoyHyr0cJshea6UfpN//TphWuRvz5PQR3X2IUN5oCzRKuQQ
 Y6Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8LID4X7jMBHT8BGs7zb/Ohid36HEB/TsWQhYthq+astid472+iPoak/UHulmJpMzWmA56iw8hauOT@nongnu.org
X-Gm-Message-State: AOJu0YxqkEvNzQHuv/wJdcYzYdK5B8gVq9cgAkDlfS1Qm7Q4iNkkL4kD
 ffbjCKg7A+2TecscDi4ZA9Sq7f+EVi3SwWwdzC5ZfdymLUFnlWLxVB15IBNeur6TcEorsktmQrX
 8Mnt6YU7rWes0IBW6o8yW0esSh4v1p85VN+oPN5AksOIsg4LUI0kX
X-Received: by 2002:a05:600c:314a:b0:42c:bd27:4c12 with SMTP id
 5b1f17b1804b1-42e9610a9c8mr39799575e9.10.1727342567197; 
 Thu, 26 Sep 2024 02:22:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZMn6vPjZvvRr0z4ON2PfRGPV7mbPum2AR4SR2M3xZoxDr2O7HU2Jo3C+NZbT24MrobqOmyQ==
X-Received: by 2002:a05:600c:314a:b0:42c:bd27:4c12 with SMTP id
 5b1f17b1804b1-42e9610a9c8mr39799265e9.10.1727342566712; 
 Thu, 26 Sep 2024 02:22:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b?
 ([2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969ddb85sm41419025e9.2.2024.09.26.02.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 02:22:46 -0700 (PDT)
Message-ID: <ec30359e-11a6-48fd-9d06-c030307f970c@redhat.com>
Date: Thu, 26 Sep 2024 11:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] ptp: Add support for the AMZNC10C 'vmclock' device
To: David Woodhouse <dwmw2@infradead.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-rtc@vger.kernel.org, "Ridoux, Julien" <ridouxj@amazon.com>,
 virtio-dev@lists.linux.dev, "Luu, Ryan" <rluu@amazon.com>,
 "Chashper, David" <chashper@amazon.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
Cc: "Christopher S . Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
References: <00fb5876322d2fb77816304b5e2c31731d383b76.camel@infradead.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <00fb5876322d2fb77816304b5e2c31731d383b76.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/20/24 11:32, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The vmclock device addresses the problem of live migration with
> precision clocks. The tolerances of a hardware counter (e.g. TSC) are
> typically around ±50PPM. A guest will use NTP/PTP/PPS to discipline that
> counter against an external source of 'real' time, and track the precise
> frequency of the counter as it changes with environmental conditions.
> 
> When a guest is live migrated, anything it knows about the frequency of
> the underlying counter becomes invalid. It may move from a host where
> the counter running at -50PPM of its nominal frequency, to a host where
> it runs at +50PPM. There will also be a step change in the value of the
> counter, as the correctness of its absolute value at migration is
> limited by the accuracy of the source and destination host's time
> synchronization.
> 
> In its simplest form, the device merely advertises a 'disruption_marker'
> which indicates that the guest should throw away any NTP synchronization
> it thinks it has, and start again.
> 
> Because the shared memory region can be exposed all the way to userspace
> through the /dev/vmclock0 node, applications can still use time from a
> fast vDSO 'system call', and check the disruption marker to be sure that
> their timestamp is indeed truthful.
> 
> The structure also allows for the precise time, as known by the host, to
> be exposed directly to guests so that they don't have to wait for NTP to
> resync from scratch. The PTP driver consumes this information if present.
> Like the KVM PTP clock, this PTP driver can convert TSC-based cross
> timestamps into KVM clock values. Unlike the KVM PTP clock, it does so
> only when such is actually helpful.
> 
> The values and fields are based on the nascent virtio-rtc specification,
> and the intent is that a version (hopefully precisely this version) of
> this structure will be included as an optional part of that spec. In the
> meantime, this driver supports the simple ACPI form of the device which
> is being shipped in certain commercial hypervisors (and submitted for
> inclusion in QEMU).
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Please have a better run at checkpatch before your next submission, 
there are still a few ones - most relevant white-space damage.

Anyway this is net-next material...

## Form letter - net-next-closed

The merge window for v6.12 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Sept 30th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


