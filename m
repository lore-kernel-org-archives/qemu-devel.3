Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AB9C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 16:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX1UH-0005QB-HT; Thu, 25 Jul 2024 12:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sX1UD-0005PM-7Y
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 12:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sX1UA-00080c-FJ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 12:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721925512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fmhpMaKw4X5CZZDMzXoNDtyzrmJbLZhDy7YR6GMuBto=;
 b=YPnlixS3yb0Ytg/Pj+J02qAjhMR93ouMfbmllveLSQegeYZ+4OBIK21GVHcG2eoIY0Qd6c
 YbdyD6cv01ZYf5e50vQnGx0rQK2yclkvdzL3R32FZ9KLdbUwk16RMLcTnN8yMy0oxM5yAK
 e8D+chMOwuFUTcnNhPsfv06pAfzCAjA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-dPQGLHoCOpuj87uKrMG8yQ-1; Thu, 25 Jul 2024 12:38:30 -0400
X-MC-Unique: dPQGLHoCOpuj87uKrMG8yQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3687f5a2480so713721f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 09:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721925509; x=1722530309;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fmhpMaKw4X5CZZDMzXoNDtyzrmJbLZhDy7YR6GMuBto=;
 b=EBkqZM9F8aAwMQtOV8HgMQnnInv5DPj3CGH014LXYFFx4TRnfq2xlCWXH/+ysXFJ4Q
 0pRpmbZFUo4iokx+N2aNM3rQi9j1Tj2/7nIg9ymXtvfxiT/sBMoFOnMMbfgbWfQHJOAc
 5n44vUXjjCzi+FsXMPqskx3rbNJs60dngWhTq0GAiqurQrautnHC/ZJACzSOYGlPwGnI
 gvSdaikPkkmcnyvxR5qaAGIpy36m3f7P+rlk9lnWeBGrywXvtfoYu3gJSI6OVJkDgbzW
 Gq/O6p2LoUV2awPWbt61qNgpbBUfaIzpRiimkZEJggUUx5ljfFdyPp+6d0E1lWTG8Fbg
 qiAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs78TRaSjF9QfSqDb8z4tg0M9hP5QwNwP+TmK0lLemB9Wu8qNbIHoBTKhgbv0kqOO25WJ1sh/VWOHmRoY195lAuAHERDQ=
X-Gm-Message-State: AOJu0Yx3FvGd593hB6RZ03NSC9aCWhRybfx+b1K5/a5ekPgSKl2ewK6+
 0QqSWMA058RRXJn1ZKXWaQDby+jaQu5ERIeM15OY4bUzXA2G6Fu7PDrugQMsZ2fThdKY0IrWJrF
 bV0fAzwVox/bCsA2gFu9I4+20yf34KXiiqvQHg43qLdh6k2DnSZeu
X-Received: by 2002:adf:ed47:0:b0:368:7f8f:ca72 with SMTP id
 ffacd0b85a97d-36b364443d0mr1823928f8f.29.1721925509555; 
 Thu, 25 Jul 2024 09:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVkxqW5ZWpJzphEm72RP12t9yKD8nLEmAUKvkzy8Xw/le9MV4rpuQJkrCb/1ZIHocRHb/ATg==
X-Received: by 2002:adf:ed47:0:b0:368:7f8f:ca72 with SMTP id
 ffacd0b85a97d-36b364443d0mr1823895f8f.29.1721925508498; 
 Thu, 25 Jul 2024 09:38:28 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:81aa:776c:8849:e578:516a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857fdesm2828283f8f.75.2024.07.25.09.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 09:38:27 -0700 (PDT)
Date: Thu, 25 Jul 2024 12:38:23 -0400
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
Message-ID: <20240725122603-mutt-send-email-mst@kernel.org>
References: <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
 <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
 <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
 <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240725100351-mutt-send-email-mst@kernel.org>
 <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Thu, Jul 25, 2024 at 04:18:43PM +0100, David Woodhouse wrote:
> On Thu, 2024-07-25 at 10:11 -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 25, 2024 at 02:50:50PM +0100, David Woodhouse wrote:
> > > Even if the virtio-rtc specification were official today, and I was
> > > able to expose it via PCI, I probably wouldn't do it that way. There's
> > > just far more in virtio-rtc than we need; the simple shared memory
> > > region is perfectly sufficient for most needs, and especially ours.
> > 
> > I can't stop amazon from shipping whatever in its hypervisor,
> > I'd just like to understand this better, if there is a use-case
> > not addressed here then we can change virtio to address it.
> > 
> > The rtc driver patch posted is 900 lines, yours is 700 lines, does not
> > look like a big difference.  As for using a memory region, this is
> > valid, but maybe rtc should be changed to do exactly that?
> 
> I'm certainly aiming for virtio-rtc to include that as an *option*,
> because I think I don't think it makes sense for an RTC specification
> aimed at virtual machines *not* to deal with the live migration
> problem.
> 
> AFAICT the only ways to deal with the LM problem are either to make a
> hypercall/virtio transaction for *every* clock read which needs to be
> accurate, or expose a memory region for the guest to do it "vDSO-
> style".

virtio can support the second option, we already have
VIRTIO_PCI_CAP_SHARED_MEMORY_CFG, I'd just use it.


> And similarly, unless we want guest userspace to have to make a
> *system* call every time, that memory region needs to be mappable all
> the way to userspace.

This part is classic for pci, mapping pci bar has been well
studied.


> The use case isn't necessarily for all users of gettimeofday(), of
> course; this is for those applications which *need* precision time.
> Like distributed databases which rely on timestamps for coherency, and
> users who get fined millions of dollars when LM messes up their clocks
> and they put wrong timestamps on financial transactions.

I would however worry that with all this pass through,
applications have to be coded to each hypervisor or even
version of the hypervisor.

I don't really know the use-case well enough - is sending
an interrupt to linux and having linux create a device
independent structure not workable?


> > E.g. we can easily add a capability describing such a region.
> > or put it in device config space.
> 
> I think it has to be memory, not config space. But yes.

virtio config space, which is just a region in a BAR.
But yes, maybe VIRTIO_PCI_CAP_SHARED_MEMORY_CFG is cleaner.

> The intent is that my driver would be usable with the shared memory
> region from a virtio-rtc device too. It'd need a tiny amount of
> refactoring of the discovery code in vmclock_probe(), which I haven't
> done yet as it would be premature optimisation. 
> 
> > I mean yes, we can build a new transport for each specific need but in
> > the end we'll get a ton of interfaces with unclear compatibility
> > requirements.  If effort is instead spent improving common interfaces,
> > we get consistency and everyone benefits. That's why I'm trying to
> > understand the need here.
> 
> It's simplicity. Because this isn't even a "transport". It's just a
> simple breadcrumb given to the guest to tell it where the information
> is.
> In the fullness of time assuming this becomes part of virtio-rtc too,
> the fact that it can *also* be discovered by ACPI is just a tiny
> detail. And it allows hypervisors to implement it a *whole* lot more
> simply.
> 
> The addition of an ACPI method to enable the timekeeping does make it a
> tiny bit more than a 'breadcrump', I concede — but that's still
> basically trivial to implement. A whole lot simpler than a full virtio
> device.

virtio has been developed with the painful experience that we keep
making mistakes, or coming up with new needed features,
and that maintaining forward and backward compatibility
becomes a whole lot harder than it seems in the beginning.

-- 
MST


