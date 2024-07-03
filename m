Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C15C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 20:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP6Z5-000821-Jn; Wed, 03 Jul 2024 16:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP6Yz-00081M-AY
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 16:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP6Yw-0000VA-Pj
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 16:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720038404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z4dAlQSGTqyeb66WkR7GX6NoI0tus4HYQyVTco0TlTc=;
 b=i4SVPWNUuucbvM8mOOMo9xacGhTxh3bSwZYfEbadY/Y2GP+H00EoMTleVwvV/ay2Jk+LuI
 Ha/eMm7zGb2Sv9XXvIkp9X8QFKZa3Nm87H2ePlBQOaKbdPrsCOloZgK6BSmOYZ/S0QUl5p
 JhJZP0P3ZEKywKB2DTkkA+HgPDxRysU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-bTg-SUm6MJ-N8iErFBSlcA-1; Wed, 03 Jul 2024 16:26:41 -0400
X-MC-Unique: bTg-SUm6MJ-N8iErFBSlcA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a77b2edfe06so17912266b.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 13:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720038398; x=1720643198;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z4dAlQSGTqyeb66WkR7GX6NoI0tus4HYQyVTco0TlTc=;
 b=LdXdIbPay5O4oF7YYb1BlhZi3mQ38GxU1IffhHoWIs1stoU0RIA7wDDWzKBl3ejd0E
 dmpbP3akJCtaBta3rVhliLYlTuTd/64VDZKysZYdGzdFg4nbXfju2XXKRKv1Bja+WV6s
 kdlythmU8YJHbHmTLgszclN1I9ErGLO2fM6uU9vpwObGvixAg5hV+wFh1P072dz8yOTY
 3DrHhYd1JQDNv4HjKqrRlyApuA9pH0+d/fhdWBMMXBDd9kf8Ta8TdFgf6wrmKANRbmaL
 0fRJtntfcNvLwF6V+JksWx+czcgRm85SohP4oo9ZZZj22i0TP2K+so6XdcTgpahb64fa
 /rrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo6hfaBuhNKYMRNF2IwHK+yeBctsvCaIGstISV43ORjZYq/MYUeEez8P+Q/dua8l81mRsE7mE1EgTfuRwCPqD91qiIq3E=
X-Gm-Message-State: AOJu0Yx/refQopVEKaJLKik6LjWM9LNWBAu8W26LG6rfJ6C9c9g0vPt1
 xmG3OLdrrN1Fy+OqQssIgGKmxtNsGSE3MFKqnRt6dyWw08HF/UAP2RebRfuOvulCwXUAdFJolr2
 xAoozujyN/Yk0ih1++3hXJMiSpEU3Y9zctXoOt+O2XcKlP0Swxrlg
X-Received: by 2002:a17:906:71c1:b0:a72:b4c9:2bea with SMTP id
 a640c23a62f3a-a75144a90d9mr765952666b.49.1720038398619; 
 Wed, 03 Jul 2024 13:26:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElhAPQ8v16AqBI1IlMHNo9Yo7QAteVUDc3MoQqrTSePS7fA5tPctBA5vKiuaWPVJaElF3ilA==
X-Received: by 2002:a17:906:71c1:b0:a72:b4c9:2bea with SMTP id
 a640c23a62f3a-a75144a90d9mr765951366b.49.1720038397898; 
 Wed, 03 Jul 2024 13:26:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a75112f7731sm424228466b.124.2024.07.03.13.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 13:26:37 -0700 (PDT)
Date: Wed, 3 Jul 2024 16:26:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 00/88] virtio: features,fixes
Message-ID: <20240703162544-mutt-send-email-mst@kernel.org>
References: <cover.1719951168.git.mst@redhat.com>
 <f0961f6f-642c-4dc8-8bf3-1457f71da500@linaro.org>
 <20240703125101-mutt-send-email-mst@kernel.org>
 <d18ab076-47e4-4e8a-85d5-45f14f7b7e71@linaro.org>
 <54f9b0f4-d638-4273-935a-bb9bd129701b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54f9b0f4-d638-4273-935a-bb9bd129701b@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jul 03, 2024 at 08:46:38PM +0200, Thomas Huth wrote:
> On 03/07/2024 19.01, Richard Henderson wrote:
> > On 7/3/24 09:51, Michael S. Tsirkin wrote:
> > > On Wed, Jul 03, 2024 at 09:31:45AM -0700, Richard Henderson wrote:
> > > > On 7/2/24 13:15, Michael S. Tsirkin wrote:
> > > > > The following changes since commit
> > > > > 1152a0414944f03231f3177207d379d58125890e:
> > > > > 
> > > > >     Merge tag 'pull-xen-20240701'
> > > > > ofhttps://xenbits.xen.org/git-http/people/aperard/qemu-dm 
> > > > > into staging (2024-07-01 09:06:25 -0700)
> > > > > 
> > > > > are available in the Git repository at:
> > > > > 
> > > > >     https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git  tags/for_upstream
> > > > > 
> > > > > for you to fetch changes up to 29e45afd8d6abf7a67dab5db0ab1cfbc388daefe:
> > > > > 
> > > > >     hw/pci: Replace -1 with UINT32_MAX for romsize
> > > > > (2024-07-02 11:27:19 -0400)
> > > > > 
> > > > > ----------------------------------------------------------------
> > > > > virtio: features,fixes
> > > > > 
> > > > > A bunch of improvements:
> > > > > - vhost dirty log is now only scanned once, not once per device
> > > > > - virtio and vhost now support VIRTIO_F_NOTIFICATION_DATA
> > > > > - cxl gained DCD emulation support
> > > > > - pvpanic gained shutdown support
> > > > > - beginning of patchset for Generic Port Affinity Structure
> > > > > - s3 support
> > > > > - friendlier error messages when boot fails on some illegal configs
> > > > > - for vhost-user, VHOST_USER_SET_LOG_BASE is now only sent once
> > > > > - vhost-user now works on any POSIX system
> > > > > - sr-iov VF setup code has been reworked significantly
> > > > > - new tests, particularly for risc-v ACPI
> > > > > - bugfixes
> > > > > 
> > > > > Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> > > > 
> > > > Fails testing:
> > > > 
> > > > https://gitlab.com/qemu-project/qemu/-/jobs/7257337667
> > > 
> > > Could you give me a hint how to trigger this in CI pls?
> > > All tests seem to pass when I push it to gitlab.
> > > Any special variables to set?
> > 
> > In CI, FreeBSD uses travis; I'm not sure what's involved.
> 
> s/travis/cirrus-ci/
> 
> See .gitlab-ci.d/cirrus/README.rst for information how to enable it in your
> private gitlab repo.
> 
> > I replicated it locally within a FreeBSD VM.
> > 
> > It should be reproducible with 'make vm-build-freebsd', but I think
> > that's more difficult to debug after the fact than a full vm.
> 
> Just use "make vm-build-freebsd DEBUG=1" and you should get a shell prompt
> for interactive debugging, so that's likely the best way to tackle such
> issues.
> 
>  HTH,
>   Thomas

Thanks!
As a side, is there some way to persist the stuff fetched over the
network so it does not happen each time I re-run make?



-- 
MST


