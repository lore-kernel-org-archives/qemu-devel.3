Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33636D49232
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4hF-0001nN-2Y; Fri, 12 Dec 2025 10:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4h6-0001lO-Il
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:04:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4h4-0005ap-Hy
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=t0OOLW4/dkoiXSfZkT9aL588Muy6eLLEuHbI6fW2G4I=;
 b=hIF/TiqYH3mFqtb5acs0QNqfUxW4h6dYh6i7WtwjhMdGhDAvBdHfnbMXkh+zXC7963cV9k
 DfUiWuA0IUtEtSviw606QoC/UcOANgD5Ii4Bqx2L7h1U3p08OMafNSHV2JOqFL6n6AtsOd
 WYOirCoa+NX/nPcv0Udd7pgTWR94eVU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-VtXLa2m8MamfiwYdt9DWFw-1; Fri, 12 Dec 2025 10:04:26 -0500
X-MC-Unique: VtXLa2m8MamfiwYdt9DWFw-1
X-Mimecast-MFC-AGG-ID: VtXLa2m8MamfiwYdt9DWFw_1765551865
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a089575ab3so723435ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551865; x=1766156665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t0OOLW4/dkoiXSfZkT9aL588Muy6eLLEuHbI6fW2G4I=;
 b=cqzOQASYh5xw/zjTbmTcv1YdH//R5S+KqOoLmC7aNulO0+ZB0pALLE9cWq6NhVohvw
 c8mWuAAns78okjyFcow5lIu6zBCLjmJNOR4B+1on0iXQGCfGNdHQsds6WKF+AheJ/0F3
 biRdxBMyIEZ0ZknMSQDCAEtJFE6hbLeioHML9HcHR1xFVTEQIZw3tlJWw356Sz4Cc1Cl
 ok7QJbponEO9Sc18lTPFCOjMEEed8bAuKOQ8+wO+I55/6MqxCorUghEpyv7Cd3YJCEZF
 KTumUJbzfH1sQsWgo49z/k8CXmdp3dpu5dv55RxTXFyHKs/MIDloluyFP6GhVHvyVto+
 Wzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551865; x=1766156665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t0OOLW4/dkoiXSfZkT9aL588Muy6eLLEuHbI6fW2G4I=;
 b=vnoIXaMIkSL1ZbwOrVuLpraIQwmJC8NOHvba0goBPxIaEi79knIPHTmh9bmMqGkSdL
 RA1iFN3Aqzx0KC0Zd1cK6aSVM5kHuPBOKvmrPYmTsvzcsM43FpVX3SQFNT8ZPkrw07oM
 /W+hUfIxZcFLoZVdwBx9R87lQsm4bw/hISkbiTru8T7mmyrpp29Z2pJdDKRJzfstXo/i
 Ied5557lZML6ub5y7bvpm1JMminuzw0YGjCBmC7aWKq7jozxKG2ROvKR0nb3XCZybaJg
 qunQHkbDS8ed0tXnweRraiNhMsSeF/y7mI6SiI5sKLl95Dn/SKcyv9rXTuGe8jrDkK+V
 oCjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU81gF2aUW6ELK+1o3nWS5R6aYvDnksDdW3GHuES2CVgozGyXNhumRzAUd3E4tn85utA4mFjVUt3J/9@nongnu.org
X-Gm-Message-State: AOJu0YzKDq3hty+bkaJ8HFyWSTKXWzBTGYESAvuHxpbcbsiWpJB66gnD
 Qrki4Stdk8Z6KvHEfOvgZ8u5HYRK1zDIesyCuKxwlGC9AX75lLNIroJpFMwlwYNVUw/9lqf1o3F
 V1kRfnh2u6aa2PFBx1dLa0etkzn7d+AlsF/qHMLjm6VzN95rc5Tm/9apc
X-Gm-Gg: AY/fxX6h2Je1MaffeXfX7mIUiHcrE3hlSW+XuWrWVqn0LfrAtAhgk66dBPoGyEUMN5U
 OVVe3T2diXUrOdFj+K7xSOPVJ0OEqV3kidHXpRVT924ztv3glo3nWCna/GEE9tJC5Q/OJSiHu3U
 c18Wtf7q9jsqsuwJ1dFCtNl21TiymLJyEYrmTSCJs6V/Xeqsko2l52x8YUXV+YKa+UxizJDNem1
 W9v8ciFMINGZA6aett2S7jVWz+Hud9cuYNicfxO0TFcbQIkmrKzB78WFToDm6mn3zoMrRT4PU16
 ddNP1GmAsMY+Rdw336ZNuOWXwosxWt09lRgiww6P0o6+bexLehgR3vsQNCwXK21QWjN3pE0y/ru
 9V0DKIG53blaw+y2Ss3MZIcwYa6gbNHIB6xWhTCliVCw=
X-Received: by 2002:a17:903:1b2b:b0:246:4077:4563 with SMTP id
 d9443c01a7336-29f23c7bf87mr23435755ad.34.1765551863112; 
 Fri, 12 Dec 2025 07:04:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqlhYGOqg3swe7OAJrK9FzgAotBXNcmB8rigxY5oXDCNLkRn5bASDvMIAZHcSwiZA1i1ystw==
X-Received: by 2002:a17:903:1b2b:b0:246:4077:4563 with SMTP id
 d9443c01a7336-29f23c7bf87mr23435335ad.34.1765551862524; 
 Fri, 12 Dec 2025 07:04:22 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:04:22 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: vkuznets@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v1 00/28] Introduce support for confidential guest reset
Date: Fri, 12 Dec 2025 20:33:28 +0530
Message-ID: <20251212150359.548787-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This change introduces support for confidential guests
(SEV-ES, SEV-SNP and TDX) to reset/reboot just like other non-confidential
guests. Currently, a reboot intiated from the confidential guest results
in termination of the QEMU hypervisor as the CPUs are not resettable. As the
initial state of the guest including private memory is locked and encrypted,
the contents of that memory will not be accessible post reset. Hence a new
KVM file descriptor must be opened to create a new confidential VM context
closing the old one. All KVM VM specific ioctls must be called again. New
VCPU file descriptors must be created against the new KVM fd and most VCPU
ioctls must be called again as well.

This change perfoms closing of the old KVM fd and creating a new one. After
the new KVM fd is opened, all generic and architecture specific ioctl calls
are issued again. Notifiers are added to notify subsystems that:
- The KVM file fd is about to be changed to state sync-ing from KVM to QEMU
  should be done if required.
- The KVM file fd has changed, so ioctl calls to the new KVM fd has to be
  performed again.
- That new VCPU fds are created so that VCPU ioctl calls must be called again
  where required.

Specific subsystems use these notifiers to re-issue ioctl calls where required.

Changes are made to SEV and TDX modules to reinitialize the confidential guest
state and seal it again. Along the way, some bug fixes are made so that some
initialization functions can be called again. Some refactoring of existing
code is done so that both init and reset paths can use them.

Tested on TDX and SEV-SNP.
CI pipeline passes: https://gitlab.com/anisinha/qemu/-/pipelines/2211550528
Rebased on top of version 10.2.0-rc3

CC: pbonzini@redhat.com
CC: kraxel@redhat.com
CC: vkuznets@redhat.com

Ani Sinha (28):
  i386/kvm: avoid installing duplicate msr entries in msr_handlers
  hw/accel: add a per-accelerator callback to change VM accelerator
    handle
  system/physmem: add helper to reattach existing memory after KVM VM fd
    change
  accel/kvm: add changes required to support KVM VM file descriptor
    change
  accel/kvm: mark guest state as unprotected after vm file descriptor
    change
  accel/kvm: add a notifier to indicate KVM VM file descriptor has
    changed
  kvm/i386: implement architecture support for kvm file descriptor
    change
  hw/i386: refactor x86_bios_rom_init for reuse in confidential guest
    reset
  kvm/i386: reload firmware for confidential guest reset
  accel/kvm: Add notifier to inform that the KVM VM file fd is about to
    be changed
  accel/kvm: rebind current VCPUs to the new KVM VM file descriptor upon
    reset
  i386/tdx: refactor TDX firmware memory initialization code into a new
    function
  i386/tdx: finalize TDX guest state upon reset
  i386/tdx: add a pre-vmfd change notifier to reset tdx state
  i386/sev: add migration blockers only once
  i386/sev: add notifiers only once
  i386/sev: free existing launch update data and kernel hashes data on
    init
  i386/sev: add support for confidential guest reset
  hw/vfio: generate new file fd for pseudo device and rebind existing
    descriptors
  kvm/i8254: add support for confidential guest reset
  hw/hyperv/vmbus: add support for confidential guest reset
  accel/kvm: add a per-confidential class callback to unlock guest state
  kvm/xen-emu: re-initialize capabilities during confidential guest
    reset
  kvm/xen_evtchn: add support for confidential guest reset
  ppc/openpic: create a new openpic device and reattach mem region on
    coco reset
  kvm/vcpu: add notifiers to inform vcpu file descriptor change
  kvm/i386/apic: set local apic after vcpu file descriptors changed
  kvm/clock: add support for confidential guest reset

 accel/kvm/kvm-all.c                         | 354 +++++++++++++++++---
 accel/stubs/kvm-stub.c                      |  26 ++
 hw/hyperv/vmbus.c                           |  30 ++
 hw/i386/kvm/apic.c                          |  13 +
 hw/i386/kvm/clock.c                         |  56 ++++
 hw/i386/kvm/i8254.c                         |  84 +++--
 hw/i386/kvm/xen_evtchn.c                    | 100 +++++-
 hw/i386/x86-common.c                        |  50 ++-
 hw/intc/openpic_kvm.c                       | 108 ++++--
 hw/vfio/helpers.c                           |  81 ++++-
 include/accel/accel-ops.h                   |   1 +
 include/hw/i386/apic_internal.h             |   1 +
 include/hw/i386/x86.h                       |   5 +-
 include/system/confidential-guest-support.h |  27 ++
 include/system/kvm.h                        |  54 +++
 include/system/physmem.h                    |   1 +
 system/physmem.c                            |  28 ++
 system/runstate.c                           |  31 +-
 target/arm/kvm.c                            |   5 +
 target/i386/kvm/kvm.c                       | 189 +++++++++--
 target/i386/kvm/tdx.c                       | 145 ++++++--
 target/i386/kvm/tdx.h                       |   1 +
 target/i386/kvm/xen-emu.c                   |  45 ++-
 target/i386/sev.c                           | 110 +++++-
 target/loongarch/kvm/kvm.c                  |   5 +
 target/mips/kvm.c                           |   5 +
 target/ppc/kvm.c                            |   5 +
 target/riscv/kvm/kvm-cpu.c                  |   5 +
 target/s390x/kvm/kvm.c                      |   5 +
 29 files changed, 1382 insertions(+), 188 deletions(-)

-- 
2.42.0


