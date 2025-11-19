Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41CECF258F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 06:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLbj8-000409-1r; Wed, 19 Nov 2025 01:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vLbj6-0003zy-01
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 01:31:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vLbj3-0007S8-My
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 01:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763533891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y36wfqXvTXg+YNQxN00iRtdWVC35z02BJ6zc8/P/hwY=;
 b=amvgI7vI8Vj7Rrdx0HE9BTi/GACZd/CIlkC+KgvjVVNZRtArP1Jp0v6VKi+oxU+SabEfXi
 1dYWRsrG3K7OFZuig0UO0wRqJQRabkbACTUF5zrkrHL/klbmloicjAkjSD/42cih+gTuY/
 /fuHGQZq3KUb4Uq7dUEel4a8pmx4c84=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-HhvD7p__N_2bWmlRJDaHHw-1; Wed, 19 Nov 2025 01:31:30 -0500
X-MC-Unique: HhvD7p__N_2bWmlRJDaHHw-1
X-Mimecast-MFC-AGG-ID: HhvD7p__N_2bWmlRJDaHHw_1763533889
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4779da35d27so29796875e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 22:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763533889; x=1764138689; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y36wfqXvTXg+YNQxN00iRtdWVC35z02BJ6zc8/P/hwY=;
 b=eQJUzfVmr6izMRfzQupPul5fqo0IcWZA5ONL6Mz/WnbDt6wn21wxWYcEmiBwyzvThP
 3sczNOtfUtV4hd2FtZX42AvVxW2Ozg0r59XMS9ES/+Paafp/rwLJDqoVIjCmU2Mg3S6d
 3i2M/RQO1A9mBYe/t8j5EgrVkBwIsAgyjc9KA5LyBeRRFMF6lEqwIqljuHMekxgu3EtR
 H7+JcLuztez2qoVhM9LqUxWMZsCdPw9M07+bDz7vj5lFLLsvWBEwmf9YnW0vz93pzeW2
 7cpmYDioZ+vurrcMaXYYZsACVoDi5Gi5NgfVzwsCEvQtWZipG2QABwtnxAPxpPAwFQvx
 ZHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763533889; x=1764138689;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y36wfqXvTXg+YNQxN00iRtdWVC35z02BJ6zc8/P/hwY=;
 b=RU4+ZSjvw9i+KEbSS9EhQjJ10mYx0RmzCCot6O5ltPlc1hwqNninDGvA8jukFT6KY/
 QZuVmOYx0aEDPs3tpfAsjHYVaCRgPAmhzhN1ufen6faDKi/3l57HAjbD5cD3Lp6B+CYm
 /NvgWDYkFWGlpbY2hUOFRkrwb1vloRtOO7ZnWeCTonfhO6U0fIulD4O0u1rCiRlnjaiG
 vqnrkA/JldmSqM9QOYoMM8bHVjxAH6GJwSiHBFLG4Xa87zTZQ61WTR9JFVHHcgEAkQmR
 0AjfVfga9Zhz9IgjTVwtFP7AiFDN5QDG4CMV7bRE6RLVR4IntN58ACCYcsjTNyQtJwlZ
 5M9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg1rLGqn1pyBGK0ieUJfDzdGgZ5EcQW1WSfAuSvUjsPZyXZARvw1XMK94FTGfHOaZSO9BvD0h4Um11@nongnu.org
X-Gm-Message-State: AOJu0YyNhPQCc/KlB41liIeGDW6CVgQL1waYp9Z6b9J3+tPYauZISyUv
 DYB85w6ioJlNeXyJbB5IMY2D/FzKeF6DJ1h2hqXKXiztmG+5IbFmIRQOvAQe7giMAdqKBk+E22X
 Hjv7GYR5zqFw6UDjgr+ciDiXw8EgTFMUmdAP9eRidArqWtgs3L/aINwkm
X-Gm-Gg: ASbGncswL8Skfs+7cd7m8sxTJ3zs4KFZmtNDIn7kBFhMtP7CbfZ0FNIlzin+y/4Surw
 OWfdxr7aUZj6J5Xida1uqvAjCT46Rrc6i8XgJO8nhHyOJiV0PvXxt+0bwALselo+sJBjE59JtAA
 6+TCkN5dEmig3h0nbSx3kDp/keW1AIjmlpuaLy1dlQQ4ljhvEKoSyx096Cc6yn1gp9J4V0wKGgR
 S0Xmh5aitO33Lr9q7M9Rd3iogSNl+t0k6Le6kpxEhYcqUEBdJenU/4n8vi4/CbguArRX/smc1IL
 JfREtObqYN8q5mCP9qtxOVWyP8C01XtdPrVYEEpqWPZwhYAd28Ctg5aTBB3qhfAYdXDg0NPg/Ub
 2kC95gZUHBzyccf84m/l8zbyG17zfIg==
X-Received: by 2002:a05:600c:6289:b0:46e:3d41:6001 with SMTP id
 5b1f17b1804b1-4778fe8cae9mr174395675e9.34.1763533888807; 
 Tue, 18 Nov 2025 22:31:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUIxqa/WHaOdUoMen5yKHUk9skg8FgqRjWYcJ7kQMtjWnkPr0GZBGtUGv36sLNO7sRxEICIw==
X-Received: by 2002:a05:600c:6289:b0:46e:3d41:6001 with SMTP id
 5b1f17b1804b1-4778fe8cae9mr174395245e9.34.1763533888208; 
 Tue, 18 Nov 2025 22:31:28 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae88sm35288527f8f.6.2025.11.18.22.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 22:31:27 -0800 (PST)
Date: Wed, 19 Nov 2025 01:31:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 farosas@suse.de, jinpu.wang@ionos.com, thuth@redhat.com,
 berrange@redhat.com
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
Message-ID: <20251119012954-mutt-send-email-mst@kernel.org>
References: <20251107020149.3223-1-jasowang@redhat.com>
 <20251113110004-mutt-send-email-mst@kernel.org>
 <aRYJRZyNrDcDzTuG@x1.local>
 <20251113114710-mutt-send-email-mst@kernel.org>
 <aRYRhg7lKDCBUIrf@x1.local>
 <20251113124207-mutt-send-email-mst@kernel.org>
 <aRYyTeNNIPW_WIJW@x1.local>
 <CACGkMEsZtgmreUbd8BJQb9V7V2Pw-dafjLao1aVxPowuM3LHng@mail.gmail.com>
 <20251116014436-mutt-send-email-mst@kernel.org>
 <CACGkMEtgvfnanNQYejO+7f_by+04HsNNBBNdT+iot9_T3i2nUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtgvfnanNQYejO+7f_by+04HsNNBBNdT+iot9_T3i2nUA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Nov 19, 2025 at 10:06:16AM +0800, Jason Wang wrote:
> On Sun, Nov 16, 2025 at 2:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Nov 14, 2025 at 09:51:00AM +0800, Jason Wang wrote:
> > > > So IIUC there will be a cluster, it may contain different groups of hosts,
> > > > each group should have similar setups so that VMs can freely migrate
> > > > between each other within the same group (but may not easily migratable
> > > > across groups?).  But I don't think I know well on that part in practise.
> > >
> > > Towards this, we may need to develop tools somewhere to report TAP
> > > capability. Or as replied in another thread, developing software
> > > fallback for new features, but it seems a burden.
> >
> > Or more generally, host capability from QEMU POV.
> 
> Or you mean managment POV actually, for example TAP is usually created
> by libvirt.
> 
> Thanks

So what you propose is really this:

1- create tap
2- run qemu check that it did not fail
3- if it fails guess what the right set of flags is to make it not fail
  and switch to that


and I am saying qemu should help with 3.


> >
> > --
> > MST
> >


