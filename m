Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA35C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x57QZ-0004TU-8V; Fri, 11 Sep 2026 16:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x57QX-0004TL-QK
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:00:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x57QV-0006ko-LI
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789156846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PA5JvQvv2eO0uUxaAy4dAVO00N0NtyXMUx78WX5Xjn8=;
 b=W9alKsVsmU8uArxQ24GpEcEsi851ULK/j1dPtuI1Q6UsKJ1jRQ8k7rjhNpVMBC5K/0sxPR
 7yz7aECu5o+AvevxnhczymNBfwzRVhZDrC9qtKq2WDrbFQK/vIqiWU2GdZwIyECWdhIBes
 fnPyCpURsjPptYWn5Yp9kOPEO8YDAhQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-kkwJUejzPeeMRyygisqEaQ-1; Fri, 11 Sep 2026 16:00:44 -0400
X-MC-Unique: kkwJUejzPeeMRyygisqEaQ-1
X-Mimecast-MFC-AGG-ID: kkwJUejzPeeMRyygisqEaQ_1789156844
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-499913d1a79so9147935e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 13:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789156843; x=1789761643; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PA5JvQvv2eO0uUxaAy4dAVO00N0NtyXMUx78WX5Xjn8=;
 b=J7nQO9WK3dYmQK08YxT8E3NOEoHvblVIWRZs7eEgOT3FmwGyfnjBUTeadeNXpWWLGj
 fOqwD/IRj1eJ9pMQFDFmk9c+b5mzZuJLtv563Kd0m9oXVsNGGd+vJdubSjweErLEEOcD
 MupXfOe8Wz2fyq0kfbn+buIpDCpw+SNS3eeU+Y7kMmjNx/K3B2rKy++vvxUMVQiBdYqA
 JKEimkEM5u5B700s3D33tJ+pMrgjivTx2TkxAeWRfooJOBt/kDV692opezuVIAqwPTwF
 v2HJ+Pu5JKzMGo8XrR/+JE0McohVOms4+gmF35Bv0W2McQw/8BeaQJRbWEx7nzxksugd
 GklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789156843; x=1789761643;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PA5JvQvv2eO0uUxaAy4dAVO00N0NtyXMUx78WX5Xjn8=;
 b=Rc75hwfxSelQ6QypPO86ZDDo6hjscp4NxEVObraVOnY3AQwJIUPGln+dtVXcaD9nos
 0fbaiDBovmct0odUVp0hlg3a2R7Cl2FyNlLg8ylBktj9wuU/PsQh9HVmRWZk5BfXHaC4
 g6dWaTx2v+tSdbjKSiGNceU8JCnAUqnSJJtBJccGIdyCk2Z5gIG5v6/DeWeoS+EcPUYU
 0WrWCDso5mhxdhraP395KzJGA/d6avDHR9+oaQpuGpxgaRdQC9xPjFUvhdZIMRwLghOc
 AH5tsc59vFDKws609muPUuq1BVC3LxhWIF8WIjlZ218M+SreTAwauR5m+kZ0woB7Zgm0
 rflg==
X-Gm-Message-State: AFuF++kua3xIAp4tENQtTYn4XSOvB0Y/9zfs0eaqtYUa+/EEfQIHOQNP
 lcjeockY1VKaXpkPEZzRJjnPG4qwuNbPm1lTH2bsllaCTfy6V48ISxRQDCkTbM2ZGZH++SWztEF
 B6JsF2JJZu1yQ69GFmoGynYVYVH6wj4XLW0nnOHODJduQTAKALhfvQNvk
X-Gm-Gg: AYBFou3/JivKgsc2MlNhNcrdrw8K77ngEKwaioA7Q1DvBjCwqeXIqc6OY+szC+kPRkk
 UNK15PiAh/zylZn/kTcTovJGQ8XwWYKlSHgL5gXN7U9N3zscUX9pVlR7Iv4sTdmAUTgmjqAlwX2
 G/vP5xhSInH5SpgqxVTVGcJD1OCBMr9+QQXfDGrHAxyKTSQP2XihApdyyjRvqixceXxxpz0tZUX
 UljNxTJJwVHgef1HO18bWsINauYshl6v3cgVoN7etm3vCFRu91cnYbu9LBaHs/7DV4DayB5TpaR
 on7eB3/JlCAWpfB4jxEGd/F8DQdC6BAMZPKjiAOk2575gX8v0sCSE57C4XVQ0Xo40c4=
X-Received: by 2002:a05:600c:3494:b0:49c:e3c3:5efd with SMTP id
 5b1f17b1804b1-49e619aab42mr157612215e9.9.1789156843368; 
 Fri, 11 Sep 2026 13:00:43 -0700 (PDT)
X-Received: by 2002:a05:600c:3494:b0:49c:e3c3:5efd with SMTP id
 5b1f17b1804b1-49e619aab42mr157611495e9.9.1789156842865; 
 Fri, 11 Sep 2026 13:00:42 -0700 (PDT)
Received: from redhat.com ([147.235.223.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60acff8bsm99560545e9.9.2026.09.11.13.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 13:00:39 -0700 (PDT)
Date: Fri, 11 Sep 2026 16:00:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PULL v2 00/75] pci, vhost, virtio, iommu, apci: features, fixes
Message-ID: <20260911155428-mutt-send-email-mst@kernel.org>
References: <cover.1789117222.git.mst@redhat.com>
 <6134ac71-f451-4caf-88df-af001641a05f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6134ac71-f451-4caf-88df-af001641a05f@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Sep 11, 2026 at 09:06:26AM -1000, Richard Henderson wrote:
> On 9/10/26 23:01, Michael S. Tsirkin wrote:
> > The following changes since commit 1df256f5968e9f7c3c4533a1383b071c044a36d6:
> > 
> >    Merge tag 'qom-qapi-pr-pr-v1' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2026-09-08 18:35:31 +0100)
> > 
> > are available in the Git repository at:
> > 
> >    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > 
> > for you to fetch changes up to 2f8991c0b9c400f55897849a538580039b61865a:
> > 
> >    MAINTAINERS: add Junjie Cao as CXL reviewer (2026-09-11 04:59:15 -0400)
> > 
> > ----------------------------------------------------------------
> > pci, vhost, virtio, iommu, apci: features, fixes
> > 
> > new vhost-user-media device
> > virtio-net now supports live-TAP local migration
> > cxl now supports CFMW restrictions and per-window options
> > intel_iommu now supports concurrent page fault handling with PRI
> > pci now batches memory transactions around mapping updates
> > vhost-user-blk now allows toggling inflight-migration at runtime
> > virtio-rtc now supports smeared UTC clock type
> > intel_iommu now exposes SMPWC when SVM is enabled
> > new reviewer for CXL patches
> > 
> > Fixes, cleanups all over the place
> 
> https://gitlab.com/qemu-project/qemu/-/pipelines/2840522620
> 
> Between the 6 failing jobs, I think there are 2 failures replicated:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/16454091774#L800
> 
> 18/34 func-quick+func-x86_64 - qemu:func-x86_64-linters               FAIL
> 6.00s   exit status 1
> 34/34 func-thorough+func-x86_64-thorough+thorough -
> qemu:func-x86_64-tap_migration     ERROR            0.19s   0 subtests
> passed
> 
> 
> r~

That's the new test. I dropped that.


The func-rx-vnc is due to the test using a fixed port which is
always a bad idea, making the test flaky.

Pushed to same tag, could you try again pls?

Vladimir FYI tests/functional: add test_tap_migration is dropped
due to linter issues and missing iproute2 dependency.

-- 
MST


