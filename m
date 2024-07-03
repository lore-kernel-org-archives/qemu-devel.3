Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897D2C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 16:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP3D5-0002TX-9I; Wed, 03 Jul 2024 12:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP3D3-0002TH-Ts
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 12:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP3D2-0003Tq-4F
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 12:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720025515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YLM+htw9j8WbqJOc1tHIRDErOn3jfCOaQh9uIhPR8uE=;
 b=fom33AA+BvvAqhyUr043n1GgKckQFUqbNQ8n9i3MPu84DtcGgiR8lY55CUdZ9HldgON34K
 NAgtw2iAMs3eRFBK5kCTFyhxMWeNW5iJ4VWM4afDNsY4wqDFqfMoJG0YfJ0FoaWP85V/7v
 OWJHkkKUg6cwfs1GCCkOeiVmuDrbhYo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-Sn2E6aWFPyadKTBr9wAXHg-1; Wed, 03 Jul 2024 12:51:54 -0400
X-MC-Unique: Sn2E6aWFPyadKTBr9wAXHg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36789d3603aso1180803f8f.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 09:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720025512; x=1720630312;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLM+htw9j8WbqJOc1tHIRDErOn3jfCOaQh9uIhPR8uE=;
 b=eGtXRFM0WRehB3ydgp93ndXOyrZYE7g1+7mx4rpiN2f0PuaNpBF+Ik8cBgLrY/IWgk
 6FS8xNk8wU702j3INPJnJN5PLLU4oaSJBSkMwwMtkHRRalbirK2/8q89R8bBYSmvIton
 mD3hhvQEqCBk5OaSeRn9CkyDKBDTNA0qNUhKqpvFQkzi9KjcCTQ0BShPd4lXiE48ZnH4
 ntXZJrSy6DHlua2+xG601Xh7QT6RvLSLFVslj5WWCpt9lMeg3QmPfYotB3fsvL8FaZpi
 Dh2rgVJeovy2QPVBDiWfTLvsGZe+OdnONaY+dSbFJmJtKyTHQfgcQJbxEMON5fqYwlxU
 iyiA==
X-Gm-Message-State: AOJu0YxXZxAM+CRRmDKFirxXVuIFaUu9D8HCWhrtw7YB4qJkfhXS0y/P
 G12SO9u9zn48v8z0zHm/MWsS+DnyLBOwibdbaPRazwvgndcTZaNZmaD3pN5mNUAi9Q0vuzjk/Jl
 g3XTbnbhM1SPQzCjoEPof3IYYuPAQbtyqwRQ1CN14ExDERv+lLzJM
X-Received: by 2002:a5d:5351:0:b0:367:87b9:82d1 with SMTP id
 ffacd0b85a97d-36787b98353mr3516275f8f.65.1720025511709; 
 Wed, 03 Jul 2024 09:51:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMredrDPh0Y6LG/26eLv6qCy8gmTZtBgHSwPp5YMNYbxKK5renhOY6m6rpRzpfwkk1+ljEZg==
X-Received: by 2002:a5d:5351:0:b0:367:87b9:82d1 with SMTP id
 ffacd0b85a97d-36787b98353mr3516246f8f.65.1720025510838; 
 Wed, 03 Jul 2024 09:51:50 -0700 (PDT)
Received: from redhat.com ([31.187.78.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36792881856sm2304567f8f.6.2024.07.03.09.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 09:51:50 -0700 (PDT)
Date: Wed, 3 Jul 2024 12:51:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 00/88] virtio: features,fixes
Message-ID: <20240703125101-mutt-send-email-mst@kernel.org>
References: <cover.1719951168.git.mst@redhat.com>
 <f0961f6f-642c-4dc8-8bf3-1457f71da500@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0961f6f-642c-4dc8-8bf3-1457f71da500@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Wed, Jul 03, 2024 at 09:31:45AM -0700, Richard Henderson wrote:
> On 7/2/24 13:15, Michael S. Tsirkin wrote:
> > The following changes since commit 1152a0414944f03231f3177207d379d58125890e:
> > 
> >    Merge tag 'pull-xen-20240701' ofhttps://xenbits.xen.org/git-http/people/aperard/qemu-dm  into staging (2024-07-01 09:06:25 -0700)
> > 
> > are available in the Git repository at:
> > 
> >    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git  tags/for_upstream
> > 
> > for you to fetch changes up to 29e45afd8d6abf7a67dab5db0ab1cfbc388daefe:
> > 
> >    hw/pci: Replace -1 with UINT32_MAX for romsize (2024-07-02 11:27:19 -0400)
> > 
> > ----------------------------------------------------------------
> > virtio: features,fixes
> > 
> > A bunch of improvements:
> > - vhost dirty log is now only scanned once, not once per device
> > - virtio and vhost now support VIRTIO_F_NOTIFICATION_DATA
> > - cxl gained DCD emulation support
> > - pvpanic gained shutdown support
> > - beginning of patchset for Generic Port Affinity Structure
> > - s3 support
> > - friendlier error messages when boot fails on some illegal configs
> > - for vhost-user, VHOST_USER_SET_LOG_BASE is now only sent once
> > - vhost-user now works on any POSIX system
> > - sr-iov VF setup code has been reworked significantly
> > - new tests, particularly for risc-v ACPI
> > - bugfixes
> > 
> > Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> 
> Fails testing:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/7257337667

Could you give me a hint how to trigger this in CI pls?
All tests seem to pass when I push it to gitlab.
Any special variables to set?


> qemu-system-loongarch64: -chardev
> socket,id=chr-reconnect,path=/tmp/vhost-test-9Y0NQ2/reconnect.sock,server=on:
> info: QEMU waiting for connection on:
> disconnected:unix:/tmp/vhost-test-9Y0NQ2/reconnect.sock,server=on
> **
> ERROR:../src/tests/qtest/vhost-user-test.c:255:wait_for_fds: assertion failed: (s->fds_num)
> qemu-system-loongarch64: Failed to set msg fds.
> qemu-system-loongarch64: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
> qemu-system-loongarch64: Failed to set msg fds.
> qemu-system-loongarch64: vhost VQ 1 ring restore failed: -22: Invalid argument (22)
> qemu-system-loongarch64: Failed to write msg. Wrote -1 instead of 12.
> qemu-system-loongarch64: vhost_backend_init failed: Protocol error
> qemu-system-loongarch64: failed to init vhost_net for queue 0
> # child process (/loongarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/reconnect/subprocess
> [43438]) exit status: 1 (error)
> # child process (/loongarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/reconnect/subprocess
> [43438]) stdout: ""
> # child process (/loongarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/reconnect/subprocess
> [43438]) stderr: "qemu-system-loongarch64: -chardev
> socket,id=chr-reconnect,path=/tmp/vhost-test-9Y0NQ2/reconnect.sock,server=on:
> info: QEMU waiting for connection on: disconnected:unix:/tmp/vhost-test-9Y0NQ2/reconnect.sock,server=on\n**\nERROR:../src/tests/qtest/vhost-user-test.c:255:wait_for_fds:
> assertion failed: (s->fds_num)\nqemu-system-loongarch64: Failed to set msg
> fds.\nqemu-system-loongarch64: vhost VQ 0 ring restore failed: -22: Invalid
> argument (22)\nqemu-system-loongarch64: Failed to set msg
> fds.\nqemu-system-loongarch64: vhost VQ 1 ring restore failed: -22: Invalid
> argument (22)\nqemu-system-loongarch64: Failed to write msg. Wrote -1
> instead of 12.\nqemu-system-loongarch64: vhost_backend_init failed: Protocol
> error\nqemu-system-loongarch64: failed to init vhost_net for queue 0\n"
> **
> ERROR:../src/tests/qtest/qos-test.c:190:subprocess_run_one_test: child
> process (/loongarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/reconnect/subprocess
> [43438]) failed unexpectedly
> not ok /loongarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/reconnect
> - ERROR:../src/tests/qtest/qos-test.c:190:subprocess_run_one_test: child
> process (/loongarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/reconnect/subprocess
> [43438]) failed unexpectedly
> Bail out!
> Abort trap (core dumped)
> 
> 
> r~


