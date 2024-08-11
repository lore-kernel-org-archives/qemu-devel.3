Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A790C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 07:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sd373-0000UW-Dt; Sun, 11 Aug 2024 03:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sd371-0000TJ-Jm
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 03:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sd36z-0006Gx-SD
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 03:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723361729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k2MXdHiJvTvWazmhVydZSyXm47iFmVWNbeYyT3tm1OU=;
 b=Eq7B8Amouddy97t455HUO2qYwwQqtra4f/oKoAn8v3FeZsCzqceePlg5nGH6Q0fPblIwE9
 fdE/3w4fyqHOjMVzM0JkuetXP1Rl2laZNnITKPfCHzv6fwv44EhdLC0LO0RlwDSIlXqDsT
 nINg1B/7OwENeAX/DzLSMOpm5wX1XHk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-oVlkZJ1PPg6pAs39afoutg-1; Sun, 11 Aug 2024 03:35:27 -0400
X-MC-Unique: oVlkZJ1PPg6pAs39afoutg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4280a434147so25254225e9.3
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 00:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723361726; x=1723966526;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2MXdHiJvTvWazmhVydZSyXm47iFmVWNbeYyT3tm1OU=;
 b=ddWYHazdVr6ROVG4XY7K9RtjzGnMiO7VMgheN38LMRYZHLJafiL1gsmua9k3A0Y/48
 hvmaoMyaxP6k1t6ZoX8mZg4j6Ye1JjOqrIQIvZH510IHIjqZ/ubS3nW6NdEEoFpvP2Xn
 0wDjfnadvU4UimCw/VOe/SqvLUikR7PuqJYurjHyeHUbRGn8gIbD20XdpON5x7GvPUun
 sNNuaSFbod5teFncSpBbTsdI2jiD1HG1gZ/s1yM3AM/UnUcN1/AU9EFAYS3I3wqbo9N6
 irLy6iGexV6BhqPANT7PoaVLAEawKp6yXSZSwUvtHhOym9qwoo0m6S++4KcfszVTOoGD
 mG6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx40OqNLZki9EloHzRGsqN4lDEf65QscGDTCWkuRIMWzrHddsPP4kk3Ry/KiOVhZgoLNeLBujOp0VhbOTKBjACjBvr6ws=
X-Gm-Message-State: AOJu0Yx6WU3hFL9rmtq5QxUK9yOmG7RE8txQFxVX+i2bvMMGzO39t8pJ
 sEregu2hloU+eH2+ssQvrKxSlZI1SgzwSA7OLIFaOYLT6HR+kIiMslrbRRiKx9yhAHJ4rL4k1BF
 I6mPT81ohs9ykE/oz+tSl3QAewZ/libpKv/ZrSeaHoOHcfW/N4vXB
X-Received: by 2002:a05:600c:1c05:b0:428:14b6:ce32 with SMTP id
 5b1f17b1804b1-429c3a22bd5mr43973535e9.9.1723361725741; 
 Sun, 11 Aug 2024 00:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNIK+7KvoKygBCKPAtjNE7/UeklsK1I/B/yKNz/KxKvTDF7ZJ3/L14/Ot9m3Yyv9CaSLyVHg==
X-Received: by 2002:a05:600c:1c05:b0:428:14b6:ce32 with SMTP id
 5b1f17b1804b1-429c3a22bd5mr43973245e9.9.1723361724915; 
 Sun, 11 Aug 2024 00:35:24 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:cda4:bbcf:b3a:9142:2f8e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c750f1easm55860455e9.18.2024.08.11.00.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 00:35:23 -0700 (PDT)
Date: Sun, 11 Aug 2024 03:35:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240811025500-mutt-send-email-mst@kernel.org>
References: <20240805060544-mutt-send-email-mst@kernel.org>
 <2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com>
 <20240806092822-mutt-send-email-mst@kernel.org>
 <890f9d0a-3ded-488d-b274-8be9c38b5df3@daynix.com>
 <20240808065339-mutt-send-email-mst@kernel.org>
 <274ccd97-a473-4937-a57b-0029a18069c9@daynix.com>
 <20240808070912-mutt-send-email-mst@kernel.org>
 <ZrTTCIpXLmW8c5Kv@x1n>
 <20240808104559-mutt-send-email-mst@kernel.org>
 <ZrTjaZPyjDuJZK36@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrTjaZPyjDuJZK36@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 08, 2024 at 11:25:29AM -0400, Peter Xu wrote:
> On Thu, Aug 08, 2024 at 10:47:28AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Aug 08, 2024 at 10:15:36AM -0400, Peter Xu wrote:
> > > On Thu, Aug 08, 2024 at 07:12:14AM -0400, Michael S. Tsirkin wrote:
> > > > This is too big of a hammer. People already use what you call "cross
> > > > migrate" and have for years. We are not going to stop developing
> > > > features just because someone suddenly became aware of some such bit.
> > > > If you care, you will have to work to solve the problem properly -
> > > > nacking half baked hacks is the only tool maintainers have to make
> > > > people work on hard problems.
> > > 
> > > IMHO this is totally different thing.  It's not about proposing a new
> > > feature yet so far, it's about how we should fix a breakage first.
> > > 
> > > And that's why I think we should fix it even in the simple way first, then
> > > we consider anything more benefitial from perf side without breaking
> > > anything, which should be on top of that.
> > > 
> > > Thanks,
> > 
> > As I said, once the quick hack is merged people stop caring.
> 
> IMHO it's not a hack. It's a proper fix to me to disable it by default for
> now.
> 
> OTOH, having it ON always even knowing it can break migration is a hack to
> me, when we don't have anything else to guard the migration.

It's a hack in the sense that it's specific to this option.
But hack or not, it's the only way I have to make people work on
a full solution.

> > Mixing different kernel versions in migration is esoteric enough for
> > this not to matter to most people. There's no rush I think, address
> > it properly.
> 
> Exactly mixing kernel versions will be tricky to users to identify, but
> that's, AFAICT, exactly happening everywhere.  We can't urge user to always
> use the exact same kernels when we're talking about a VM cluster.  That's
> why I think allowing migration to work across those kernels matter.
> 
> I will agree there's no rush iff RHEL9 kernel won't backport TAP at all,
> otherwise this will trigger between y-stream after people upgrades partial
> of the clusters.
> 
> Thanks,
> 
> -- 
> Peter Xu


