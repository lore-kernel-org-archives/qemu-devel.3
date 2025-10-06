Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2FFCAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 10:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5iQq-0001wj-D6; Mon, 06 Oct 2025 06:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5iQo-0001wb-Ou
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 06:27:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5iQn-00089w-1H
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 06:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759746419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hx1eRPIFFxHOm4a9J7E46IkAGP6DTYAnqRweVWO3UhI=;
 b=UKuI+8bksK0WFBPLZFmdRoSQIKiGIxNe7d59cVUpfyvoN0bcQbEZ2q0r/PiCtPhBw+l7/t
 Uwo6Zp9yivLEczGCWAm1optcPRDeMj1rxei/Qv9XK9to4b3FF+sBrTCcBOmSRopb7bbH9K
 wv1HE9wEz8mWygZ0UWuDGGq3tST/R1A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-3jGXUvm5NjyQRE-xU3QelQ-1; Mon, 06 Oct 2025 06:26:58 -0400
X-MC-Unique: 3jGXUvm5NjyQRE-xU3QelQ-1
X-Mimecast-MFC-AGG-ID: 3jGXUvm5NjyQRE-xU3QelQ_1759746417
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42558f501adso2072490f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 03:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759746417; x=1760351217;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hx1eRPIFFxHOm4a9J7E46IkAGP6DTYAnqRweVWO3UhI=;
 b=tsiOyn2qUh2cTMZDYHqrz0cbta8BZugH9gkj7pv6SIkTtQzpEklxE9VFJrf5YYRUgy
 llWvI8NBV6yVBXMiMtmjync3Bf1EgPBipQfGKYVsLwu0kZsaa9AGSpFFMP5XPydmWvH6
 7MRgi52A09UHcyv4jvn0hh1AbhisLS+YwU1b5qP3GFyF4i10+cb3FGw4IoXtMJpIrExy
 GduyLYRv0hUpkvs2yv2xjpjFv7ysheyMm3lsLW2bJ7ExOqT7ws8vuVTL73Ot88o/gg6B
 SJap18KgzxSebB+jTT4WIgoGFMrJRXVhnHOf31l9nSL5V10LgyAZKtrE8ydQbdhm7b9v
 Rj/w==
X-Gm-Message-State: AOJu0YwVo82KswaD5MjJdD3e/3zJrxnv76r+ByL/mMszK52YOYCKSur3
 XM2zFuwvAJy/GHIZN2ABH5I2oVKvtsqiO/2+rQn+CQ18vohzafP6DOLrnFkHkLYxoxymtRjDR/q
 poIBmmwGYZ+D/RDlObrXiSoy3B1i92xAxqPzKL9SsDusGK27hahSN6pJe
X-Gm-Gg: ASbGncu16CvnboHGhKimDNGhVdZDOikk3m64oMcJN9Eci5S4Y/QqKWwWsbA8cuqGgN7
 p79io9U9Dre2aFlqqriTEWKnXPE4JLf0UZA20XCMXVK66EtEtc7dgJ2ztY/jHuI224RcP1jz09p
 9d/UAekcLHpRfbwElQebR1BXAq++5swX4BJPGqpvQYkt80JyAXSoBYUcbpnpM2FifNz6bS+6Lgj
 At5FdtYwGqMqHtPQPVyd1/OnJfTNGfHuZEEzeZqgikechfznqiQbaJXOrK5+xsnILtiY1NXnwUY
 qMR4h92m9ZHacQ01B7ceeT57xyBtr2xRcW+wyPI=
X-Received: by 2002:a05:6000:43c6:10b0:425:72b3:7368 with SMTP id
 ffacd0b85a97d-42572b3739fmr4111761f8f.56.1759746417042; 
 Mon, 06 Oct 2025 03:26:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9tVSThEbRlfl5KMR9XUYu2gh6jOa/VYTVmmVj5xGGUg3oMhlQzAXj+FGtfCBlHW8wyoHL1A==
X-Received: by 2002:a05:6000:43c6:10b0:425:72b3:7368 with SMTP id
 ffacd0b85a97d-42572b3739fmr4111739f8f.56.1759746416515; 
 Mon, 06 Oct 2025 03:26:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e980dsm21747095f8f.36.2025.10.06.03.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 03:26:55 -0700 (PDT)
Date: Mon, 6 Oct 2025 06:26:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Jonathan Cameron via <qemu-devel@nongnu.org>, shiju.jose@huawei.com,
 Davidlohr Bueso <dave@stgolabs.net>, armbru@redhat.com,
 Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
 linuxarm@huawei.com, Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu for 10.2 0/3] cxl: Additional RAS features support.
Message-ID: <20251006062628-mutt-send-email-mst@kernel.org>
References: <20250917143330.294698-1-Jonathan.Cameron@huawei.com>
 <20251006101304.000055f8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006101304.000055f8@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 06, 2025 at 10:13:04AM +0100, Jonathan Cameron wrote:
> On Wed, 17 Sep 2025 15:33:27 +0100
> Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> 
> > These two features have been used in testing the related EDAC RAS
> > features drivers in Linux which are now upstream. Only minor tweaks
> > from the second part of:
> > https://lore.kernel.org/qemu-devel/20250811085530.2263-1-shiju.jose@huawei.com/
> > [PATCH v6 0/8] hw/cxl: Update CXL events to rev3.2 and add maintenance support for memory repair features
> > 
> > I've split that series up as the two parts were only slightly connected.
> > However there is some churn if this is applied without the other part of Shiju's posted
> > series. That was sent a few minutes ago as:
> > https://lore.kernel.org/qemu-devel/20250917141355.293217-1-Jonathan.Cameron@huawei.com/
> > 
> > Based on: [PATCH qemu for 10.2 0/5] cxl: r3.2 specification events updates.
> > Based on: 20250917141355.293217-1-Jonathan.Cameron@huawei.com
> > 
> > Davidlohr Bueso (1):
> >   hw/cxl: Add support for Maintenance command and Post Package Repair
> >     (PPR)
> > 
> Hi Michael,
> 
> I see you have queued some stuff up on your gitlab tree.
> Just wanted to make sure these are on the radar for possible inclusion.
> No huge rush, but I'll queue some more series up on top of these
> shortly.
> 
> Thanks
> 
> Jonathan

thanks for the reminder, will queue.

> > Shiju Jose (2):
> >   hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature
> >     attributes in cmd_features_set_feature()
> >   hw/cxl: Add emulation for memory sparing control feature
> > 
> >  include/hw/cxl/cxl_device.h | 145 +++++++++
> >  include/hw/cxl/cxl_events.h |  47 +++
> >  hw/cxl/cxl-mailbox-utils.c  | 566 +++++++++++++++++++++++++++++++++++-
> >  hw/mem/cxl_type3.c          | 169 +++++++++++
> >  4 files changed, 915 insertions(+), 12 deletions(-)
> > 


