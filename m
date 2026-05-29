Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7E2CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 12:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSw8K-0001L2-Ql; Fri, 29 May 2026 08:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSw7u-0001K5-2X
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:15:47 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSw7s-000615-Aq
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:15:45 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7dc6fbf3e86so23479797b3.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 05:15:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780056943; cv=none;
 d=google.com; s=arc-20240605;
 b=K5R47qw9NEZdHzwomZ9J/+sscMGZ+upL2J016DXmUyU72GMm/CGyuU6tzfJ5ywDK4R
 W+exUTPJbyZ4Cl8tazyy2XA6MI2gCORf/95NZUZJAI1yqdGICMQM3/qSOVlu0agkcr+N
 4BLVh6qXEHq2rD+xM8BTcjGF2GoCKNN8oBieYl/Yf9VsjTrVizQfVJkk83lMRpi4fCmT
 PokW+Vs4AtEPc2g7VLzGdbTI8nLQxgyOD7QmfPcVX6l8eYnQR7V8Cy/GYbViLWrizXw5
 Pnkyzl/+sAFoKYHXzmUiNPLbooJmmatY72x/k5E4IijeiGb26TiY4vm2OXDSsrWl29bA
 cTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=yjKGj59EYdEVZMYoNn1QX72MKnSy7HepRRbi+EYklHg=;
 fh=7lHgdMIT5YCk1xvM5iVbYsjQ0xRSKG1j4imI2iHioW0=;
 b=LU4doEGc3UaR7xgkxwu+bA7ZH2g4kwxzRve5xyXBELso0NpwVuHpcMtBqowKUdbfs0
 p9N7C+/qo55BAyHisu8jaKESnEkIcEOl+5tTDkGW4/KWIw2fGBQIcZF7ubVIgRcdK8Fj
 70ZW2vcYgo93JS7RZMrMeexolqOCyGcii3uWMZIHb3Xs5Shri/Ap5DmLVHFIQ01KcMD6
 SoKx0MyMgLB6AaIay8zU3Ai5j95gmI1vZ1XO350tNJ2xQPZbfbnmg1GbFVnA7ZfNkco9
 oULdaZxiJWLuI4dv+NTUw3G/D3YD/Tf8kdmCeYGCE0/1ZMTH+9OE5bwEi4SKlN7QZQrs
 WgBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780056943; x=1780661743; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yjKGj59EYdEVZMYoNn1QX72MKnSy7HepRRbi+EYklHg=;
 b=RK8rWFj7GEUi/ORyu5q+HzUwLVeCG+6PjSphBm/GkLTiwF62ofpgckRspgOC7t2D0j
 1ZmGKPPfMiqQl4dUJspLStD5ldG6amo0QP+gLtPc2yGXnXftFM8c3ExwFdWNIS0Ik6zb
 CSQQNlGVp51VABORsOj1JhtqwF2c0dO7yV/RHEIKsWyUjIHvwxVZGdH/6MbI05882SpY
 bRG5N2lXev7qqRU/B1kq8R+l1ZJEq6lPXaf4+uOiq2W9WGfzjNm4R0oCYF2muU27Dm9r
 sCZMXEmXIx9jy0mXrgRktg7wxMfEC/Av9zzF7Pac30SIDhwxaKy9f3EiLdZxr+Dxdnoz
 CF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780056943; x=1780661743;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yjKGj59EYdEVZMYoNn1QX72MKnSy7HepRRbi+EYklHg=;
 b=qD0plXkoF0vnNc2scbRHrvMVB+gcleL2OtxO6UkDZ1Inin+FxswSv+kAsaz81xGSe2
 JcVgOjAOF5aXmbvPvfDdw3fW24cZD6mp/bZtQzFXKcryE6hp8M19oA+w8kzvgO7JybBB
 hrB+Fsp123GLSbUsM1HouUSBrz+pS4EpzkTYFfpsL7L7OTNgMrU3JezpWGeUUEnvyuNU
 rpPQF4olE3FRkAK6gdPyxTRK9F4qZZnvuNplPK/VcpZi2UqxY7h/dvVDzv/2GIngvfIE
 5Zix/DB2uRpIpm8ga4ANY5bPabcghz1b11lvG3UHQOY6/MRI4lPb7V848c3Ugn0zag1v
 KbMQ==
X-Gm-Message-State: AOJu0YwdVLSwcSYs6eJ0MUmFNxFlbFeXxY9Frw7crVizpnMaMJrUqGHR
 +s4ZWFXf4i4RufWYKMJVoJfZsfHwyh9RiBxZooJZkSj5Ad8Yznie3uiAWtmhdFruLJ6N6injqE5
 le1lO5Qc3LVW/24Zi8hbF2R9gBYfHot7xBUwi3IvN1HfDg5hWA5TZ
X-Gm-Gg: Acq92OFP7GGFecLth2NFWv3I3GQqsfnuQRdRE0uS9SlcIQzOIHWwm9/NKRRtmDNQm4G
 u19dkaerSg5E5FH2h5RMlrUXtQ85TIGrca0kABZQ/LFNs912IFjnzKpzdpxcwguOVx3EmFejxfa
 UsMklX6Z7EP3y2JXlAXBBmRa4KBmvbVTpjBcHFFsHQTeXJ8QmgVnkx/wA+FzS2trwREcbBQqPEL
 Ru0hTD4rf8HyzHaxM9+paZzlTGYa65ER75PTxpMG03ppujK3yRwulaUcpYMRvmWLgTWZH0wcQpy
 2kl78YOB/Jq+psI7Icsp7g5+L/93oH9PP3X1WGlMv7w8V61/XKJ0e5IcdYhf8V2tN8RWYozjuy8
 y3A==
X-Received: by 2002:a05:690c:600c:b0:7d1:c256:b5c2 with SMTP id
 00721157ae682-7de49c3369bmr20746167b3.33.1780056942332; Fri, 29 May 2026
 05:15:42 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2026 13:15:31 +0100
X-Gm-Features: AVHnY4JLeR9AeYFBA5aawGm6vGHoYnsK642CUtkYU-vZUDUKpXBaG742LlgMaNQ
Message-ID: <CAFEAcA-H-bsjnvCPg71BMre7=6ZQ9f-tSU_XZcPPSgXkK+dDXA@mail.gmail.com>
Subject: KVM Forum 2026: Call For Presentations
To: QEMU Developers <qemu-devel@nongnu.org>, rust-vmm@lists.opendev.org, 
 kubevirt-dev@googlegroups.com, kvm-devel <kvm@vger.kernel.org>, 
 coconut-svsm@lists.linux.dev, libvirt-devel <devel@lists.libvirt.org>, 
 edk2-devel-groups-io <devel@edk2.groups.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

####################
KVM Forum 2026
November 12-13, 2026
Vancouver, Canada
####################

On behalf of the program committee for the KVM Forum, I am pleased to
announce the KVM Forum 2026 Call for Presentations.

CALL FOR PRESENTATIONS
======================

We encourage you to submit presentations via Pretalx at

     https://kvm-forum.qemu.org/2026/cfp/

All presentation slots will be 25 minutes + 5 minutes for questions.

Suggested topics:
- Scalability and Optimization
- Hardening and security
- Confidential computing

KVM and the Linux Kernel
- New Features and Architecture Ports
- Device Passthrough: VFIO, mdev, vDPA
- Network Virtualization
- Virtio and vhost

Virtual Machine Monitors and Management
- VMM Implementation: APIs, Live Migration, Performance Tuning, etc.
- Multi-process VMMs: vhost-user, vfio-user, QEMU Storage Daemon
- QEMU without KVM: Hypervisor.framework, Hyper-V, etc.
- Managing KVM: Libvirt, KubeVirt, Kata Containers

Emulation
- New Devices, Boards and Architectures
- CPU Emulation and Binary Translation

Developer-focused content
- Tooling improvements
- Enabling Rust
- Testing frameworks and strategies

Speakers are expected to attend in person.

IMPORTANT DATES
===============

The deadline for submitting presentations is:
   2026-08-01 00:00 (Canada/Pacific)

Accepted speakers will be notified on August 21, 2026.

ATTENDING KVM FORUM
===================

The cost of admission to KVM Forum 2026 is $75. You can get your ticket at

     https://kvm-forum.qemu.org/2026/register/

Admission is free for accepted speakers.

The conference will be held at Coast Coal Harbour Hotel Vancouver by APA
in Vancouver, Canada. More details about the location, and about the
reduced price rooms available for attendees at the conference hotel,
can be found at:

     https://kvm-forum.qemu.org/location/

If you need a visa invitation letter in order to attend, please reach out
to the organizers at kvm-forum-pc@redhat.com.

We are committed to fostering an open and welcoming environment at our
conference. Participants are expected to abide by our code of conduct
and media policy:

      https://kvm-forum.qemu.org/coc/
      https://kvm-forum.qemu.org/media-policy/

CONTACTS
========

Reach out to us should you have any questions. The program committee may
be contacted as a group via email: kvm-forum-pc@redhat.com.

--
Peter Maydell

