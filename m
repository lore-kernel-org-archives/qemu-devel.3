Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06B2C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DEX-0001IA-RT; Thu, 03 Sep 2026 15:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DET-0001Fu-DK
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:23 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEO-00045o-1D
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:20 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3964e480f76so226771a91.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788464174; x=1789068974; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nWbGRl4D0xxd2T/AosPXgomaBayHTnR4GLenLBHLpTw=;
 b=HOdkAGSqbVrP7yfqIY/4kNVaDV8ZWYNh8zkIGXG08joTN18oOMC9FNn+hvaCqUQMOD
 VyAW7HpR+SJQtBHVztJpCPxS+D/CkLEoe2msUqOD1l+XTzIa9rbegdnzyhYRXARWP10b
 JmWri+kswzVtp8IozpB77slQIV0V4zW9cBcTbobX1ou+0l1WcBI7VqC6LJM4OE6/zBPu
 UjkSNbmb5UnzTS7J/fQPi0IyeAzD4hzuPcp8uzRE0jct52Cop7yDUHEnjjnHyBee+ULd
 jD2MB+cHkwDPA0fyl9IQg54shaPSE1tZi0sObSpzI49shM4uUlc/qPwgUpbxoOLxGdAH
 N3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464174; x=1789068974;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nWbGRl4D0xxd2T/AosPXgomaBayHTnR4GLenLBHLpTw=;
 b=INnDUlG8etbwn1HxEp1YhbdRlQsPZq8VrMjQk9AZo7KYIxTKol5v+q5R77bt2E2bny
 4XVoS+pxTmqSHtqWq9qTT6MiAEwQtwR2BUNV0+1EW1AT2nLiqLWb6dR+SUi3ojaUkkDg
 NVe9WAcsr+iF+oPRCa1n/rQGPzfxCT+n0KuH7mGjfp1IXXugR8vTy37UDTFNnJ84speR
 g0Aw8SFFazZmooNw5aNvQZxEp6h2Kp1Dd7kN8Bxjsi026Fcfx2kCLpPyuVnn+rnsdQI+
 LnkOhIg/LtwqgMePYWm13KfGFHR3wJFwdngYZApoY5bYb+u3TCcP/gwXGWe6liLK1JfX
 lykw==
X-Gm-Message-State: AFuF++lbr2aggwUdxbsiX+QSRYSnOi433KZdHo9URYD3+c8VKfjRJD6g
 TFDbxfOo1idAZK5i9B1DXuf3Q0epaibD36cNv2XrCMTKVyhmlosZ/Eh6jL3Y85ZuAgA=
X-Gm-Gg: AYBFou1KSBp2Olf4alWx7t7b9iBKsSFuTvJ4RblvlySNyc4FjXaC4k8IJ0YdgNinnDu
 XLcB+OJ9JhxERvi/ORXT9fatRgixdaYhkik+ipIVlMwvq05t3wfXt1TUE+9/dxchXaeN94rstlj
 lGjldh9ISirJzD+itVkXyLaq1ZbW+52v+G73vwt/drI/vrqC8/ziH3lA+eM4kbMKK8oUxMlQCAu
 vFUfYvF7QKyqvHSfF7rR39gz1oxp3wWgCg0Sqv3ehU2BsEd818O786c1WtPZq2bA6GcrZQ4xZa1
 c4cmShIvrw+2RIev+f1TQ42FHbFuKkn4I3Eyfa43qiDa7RTXOvlA/iqUinTqNtuDjpf2f/D34u9
 tB/5DZknF56UdMxl7jz1t8T/y0Y5JL/66NeWIw/IefTg+m7w2mE3e01q7HxFo+OKuwJIcWDVivW
 4BgQCDOGhSqdV63HT+tojm3UEqqPO0XmhOGhM2B1sG/jOiBRW2d+Zg8RNrbT+CEIuH179/COOHH
 BXDo5+tSIN8sls=
X-Received: by 2002:a17:90b:4b90:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-39b2610f2fbmr1046991a91.8.1788464173806; 
 Thu, 03 Sep 2026 12:36:13 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:36:13 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v4 00/24] Add Realm support to QEMU-VMM
Date: Thu,  3 Sep 2026 13:35:47 -0600
Message-ID: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patchset provides minimal functionality to start a Realm VM
from an Arm RME capable host using the following command line:

qemu-system-aarch64 \
 -M confidential-guest-support=rme0,memory-backend=ram0 \
 -object rme-guest,id=rme0,convert-in-place=on \
 -object memory-backend-guest-memfd,id=ram0,size=1G,share=on \
 -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..

It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
back.  It is compatible with Steven Price's v16 revision [1] of his work adding
CCA support to KVM.

This revision is based on Michael Roth's work on guest memfd in-place memory
conversion [2], rebased to QEMU master.  I left out the AMD specific changes  
from Michael's work because I can't test the result.  Other than the
modications to the linux headers, this series is identical to V3. 

It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
here [3], along with the TF-A [4] and RMM [5] for the SBSA machine (compatible
with Steven's v16 patchset).  The Repository for the kernel [6] is also
available.  Note that for the latter, defines for
KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES and KVM_CAP_ARM_RMI have been modified to
follow QEMU master. 

Instructions to compile and run the entire stack can be found here [7].

Device Assignment is not included.

Thanks,
Mathieu

[1]. https://lore.kernel.org/kvm/20260803134403.80630-1-steven.price@arm.com/
[2]. https://lore.kernel.org/kvm/20260528000416.8161-1-michael.roth@amd.com/
[3]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v4?ref_type=heads 
[4]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
[5]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v16?ref_type=heads
[6]. https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v4?ref_type=heads 
[7]. https://gitlab.com/Linaro/cca-public/build-instructions

RFC v3: https://lore.kernel.org/kvm/20260825220101.3443954-1-mathieu.poirier@linaro.org/
RFC v2: https://lore.kernel.org/kvm/20260728192630.240375-1-mathieu.poirier@linaro.org/
RFC v1: https://lists.gnu.org/archive/html/qemu-devel/2026-07/msg02307.html


Jean-Philippe Brucker (23):
  linux-headers: Add RME related definitions
  target/arm/kvm: Return immediately on error in kvm_arch_init()
  target/arm: Add confidential guest support
  target/arm/kvm: Split kvm_arch_get/put_registers
  target/arm/kvm-rme: Initialize vCPU
  target/arm/kvm: Create scratch Realm VM when requested
  target/arm/kvm: Use kvm_vm_check_extension() where necessary
  hw/core/loader: Add a ROM loader notifier
  target/arm/kvm-rme: Keep track of images loaded in Realm memory
  target/arm/kvm-rme: Populate Realm with runtime images
  target/arm/cpu: Set number of breakpoints and watchpoints in KVM
  target/arm/cpu: Set number of PMU counters in KVM
  target/arm/cpu: Don't read Realm registers
  hw/arm/virt: Set proper conduit method for Realms
  hw/arm/virt: Embed Realm VM type with IPA address space
  hw/arm/virt: Reserve one bit of guest physical address for RME
  hw/arm/virt: Disable DTB randomness for confidential VMs
  hw/arm/virt: Move virt_flash_create() to machvirt_init()
  hw/arm/virt: Use RAM instead of flash for confidential guest firmware
  target/arm/kvm-rme: Add DMA remapping for the shared memory region
  docs/interop/firmware.json: Add arm-rme firmware feature
  hw/arm/boot: Load DTB as is for confidential VMs
  hw/arm/boot: Skip bootloader for confidential guests

Mathieu Poirier (1):
  target/arm/kvm-rme: Add mechanic to initialize realms

 docs/interop/firmware.json                 |   5 +-
 docs/system/arm/virt.rst                   |   9 +-
 docs/system/confidential-guest-support.rst |   1 +
 hw/arm/boot.c                              |  70 ++++-
 hw/arm/virt.c                              | 142 +++++++--
 hw/core/loader.c                           |  15 +
 include/hw/arm/boot.h                      |   9 +
 include/hw/arm/virt.h                      |   2 +-
 include/hw/core/loader.h                   |  17 ++
 linux-headers/asm-arm64/kvm.h              |   9 +
 linux-headers/linux/kvm.h                  |  10 +-
 qapi/qom.json                              |  13 +
 target/arm/arm-qmp-cmds.c                  |   1 +
 target/arm/cpu.c                           |   5 +
 target/arm/cpu.h                           |  10 +
 target/arm/cpu64.c                         | 122 ++++++++
 target/arm/kvm-rme.c                       | 336 +++++++++++++++++++++
 target/arm/kvm-stub.c                      |   9 +
 target/arm/kvm.c                           | 202 ++++++++++++-
 target/arm/kvm_arm.h                       |  20 ++
 target/arm/meson.build                     |   5 +-
 21 files changed, 962 insertions(+), 50 deletions(-)
 create mode 100644 target/arm/kvm-rme.c

-- 
2.43.0


