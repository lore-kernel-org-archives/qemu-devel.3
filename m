Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718B4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 20:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXRy8-0005SO-VE; Fri, 26 Jul 2024 16:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sXRy7-0005Rp-IR
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 16:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sXRy5-0003Ga-DP
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 16:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722027311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g6F3/9CRXZbbG6wJJvftOijKu280GGcu93VWB1ey/5c=;
 b=KWB90a3q03y1k7rTguqUBtw/aVNSQ03U7bt2r1o/A/e5wYL72A3RaGtqPaGHNy4Js8qi4J
 KYN0TfWdasrmDekuU1J4qHTycZnD4W9Keh3pGmCZ0Z4xkoyro8KUsYcMw7knP//Nc3HtdQ
 5s85ceAb3CgRJ/l0It5f1YpPFclcOOQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-0-KJ_FXfNBO0ZfheEKiT2w-1; Fri, 26 Jul 2024 16:55:10 -0400
X-MC-Unique: 0-KJ_FXfNBO0ZfheEKiT2w-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5d5ba9e5d8bso225899eaf.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 13:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722027309; x=1722632109;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g6F3/9CRXZbbG6wJJvftOijKu280GGcu93VWB1ey/5c=;
 b=weH4jCg46+R3YSOgqh8zKVcywEjfYXgtBnLBX7OgxBfbUG470DL0B4WPcl5tYpXzKU
 ooWhduf0zzZdPJsFteBFdOMQzCTu7+PNQOK/8kFIJzqUJrwOdT/fDuyTgA+f12ZxkZGW
 1jIQUjHpiSBhxfFqkNLwk9h4Lkz0LLc4NA3iuXsV7fAxYvCasyy79g3EU4qIceLzm2Bf
 zNOtv6apVXv8Fzi6kHia/oJT3j7c7DvBH0UBz7If5GjZJ3iVU5LsoNZuLAUtqujxleH1
 dtT2P/0NxyQAciG1cQ+uaUP3QOz5kKrhfWv2WoV+tKoN74OHsY/XepeA7+5HhTgaQVqz
 o2fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX72y59B7eCXMwaVRRKy/VMeB0IWLAwezntomQu9jKvQqh3FwttzTHQ3GtGSvlAUpRZ01TBIZTIh9X7@nongnu.org
X-Gm-Message-State: AOJu0YzKDVdJFbi/Y54ZIedirciE2dKiCx45+CpzLBlXNDSM14TIz4fe
 DUVAzKeLNiPkR9a5rO36En7xRr8MR6qFTwR5yu+GG5WtjlJz3LANyvJzAupdN8f2c2dmAIJzAh5
 WluNV/z/+4SBiHHrDDmPvB1ulsi3z0gCXmDSSYXTNxXcdhErvqo9R
X-Received: by 2002:a05:6358:886:b0:1ac:f854:c49e with SMTP id
 e5c5f4694b2df-1acfaac04bbmr481594055d.0.1722027309295; 
 Fri, 26 Jul 2024 13:55:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGsJcuvK2IWCF2MQ+WDTMgV/bGorETff7fOWyrM3dEjiVwJuzBYvze+5Z2rm9TssH/INO7Qw==
X-Received: by 2002:a05:6358:886:b0:1ac:f854:c49e with SMTP id
 e5c5f4694b2df-1acfaac04bbmr481592555d.0.1722027308787; 
 Fri, 26 Jul 2024 13:55:08 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb3fb090e2sm19975616d6.138.2024.07.26.13.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 13:55:08 -0700 (PDT)
Date: Fri, 26 Jul 2024 16:55:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <ZqQNKZ9_OPhDq2AK@x1n>
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com>
 <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <20240726032520-mutt-send-email-mst@kernel.org>
 <fb5fbcbd-ff55-466f-b48b-aa12adca3179@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb5fbcbd-ff55-466f-b48b-aa12adca3179@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 26, 2024 at 07:39:46PM +0200, Thomas Huth wrote:
> On 26/07/2024 09.25, Michael S. Tsirkin wrote:
> > On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wrote:
> > > On 26/07/2024 08.08, Michael S. Tsirkin wrote:
> > > > On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
> > > > > On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
> > > > > > USO features of virtio-net device depend on kernel ability
> > > > > > to support them, for backward compatibility by default the
> > > > > > features are disabled on 8.0 and earlier.
> > > > > > 
> > > > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > > > > Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
> > > > > 
> > > > > Looks like this patch broke migration when the VM starts on a host that has
> > > > > USO supported, to another host that doesn't..
> > > > 
> > > > This was always the case with all offloads. The answer at the moment is,
> > > > don't do this.
> > > 
> > > May I ask for my understanding:
> > > "don't do this" = don't automatically enable/disable virtio features in QEMU
> > > depending on host kernel features, or "don't do this" = don't try to migrate
> > > between machines that have different host kernel features?
> > 
> > The later.
> 
> From my experience, it should rather be the former. We've seen similar
> issues with the s390x machine in the past when trying to automatically
> enable features depending on the availability of a kernel features. While it
> looks nicer at a very first glance ("hey, a new feature is available, we
> enable that for you, dear user!"), you end up in migration hell pretty
> quickly.
> 
> Maybe we could elevate the "--nodefaults" command line switch to avoid
> enabling such features automatically?
> 
> Anyway, while we're discussing solutions: We are in softfreeze already.
> Should we disable the UFO bits in the new 9.1 machine type for the time
> being to avoid that more people are running into this problem?

Probably too late for this one; this patch was merged in 8.2.
Unfortunately CIs won't even cover a test across two host kernels, even so
it'll need to be unlucky enough to one has USO one not..

But I do agree with Thomas here.

I think the only feature that can be auto-enabled is the ones that do not
affect guest ABI.  When affected, the only right way to me to enable them
should be exporting -device interface so that Libvirt can opt-in on
enabling them when the host support is detected.  For QEMU users, that
means user needs to explicitly enable them or they're off.

Or, there's also another option that we turn default to ON for such
feature, but when most of the kernels should support it.  With that, we can
set OFF in compat property for old machines, and we should fail the new
machine from boot when running on an old kenrel without the feature.

Thanks,

-- 
Peter Xu


