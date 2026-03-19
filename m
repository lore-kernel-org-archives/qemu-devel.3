Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21271075297
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3AM4-0001ap-Sw; Thu, 19 Mar 2026 06:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3AM1-0001aE-OA
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 06:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3ALy-0007aZ-W9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 06:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773915104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=O5BHz+eUozNfmtmQx/RnGlqSRrGcc8F7je4nlwnZEeU=;
 b=Mx98P/8hldsPnZkBDd/Yh38ijoyIm1fCB3wbj+6umJO/zIvwUe2patNW2sKyLIZQoIDxfk
 jd0uONbcpRekatijJEaamKVOt3PhwRabyxZ0Nr8Ckkw6mJ49CB9Yj/GiSJ7vHeSvfYOjSz
 R0rYm2n+5Jbiv/PJh3fTGWDO3k6Hkkc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-netoCCz7MnmRbH8chrRF_Q-1; Thu, 19 Mar 2026 06:11:43 -0400
X-MC-Unique: netoCCz7MnmRbH8chrRF_Q-1
X-Mimecast-MFC-AGG-ID: netoCCz7MnmRbH8chrRF_Q_1773915102
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82a6c364372so3392086b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 03:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773915102; x=1774519902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O5BHz+eUozNfmtmQx/RnGlqSRrGcc8F7je4nlwnZEeU=;
 b=Kyy1MOVMFD0kaeKKGu2Zikxl8aTesdV2x2w5A0zVs1OAw6CRpLQUmkSLaB86gVLYOi
 TIAOq9OwNnnJx2qlou8i8K6JAv6LdiIerP30n62ro3mH911I9yxVZPpKCXyFVGPudO+g
 mj1D6uGsGIfeMb7naP8swct54CdiQRZn1FMQC14IsF9lieZrNsmSuD6SfxwF9Qh5opv1
 8Aj9jtom5GBEZu/JABA2xOEWuWplcaxI/nUzMxUAZNVvEJK93JMSmT+gOoxk5VdXfVBX
 xwmnWmUknTeD0fCbCudqf6YTojqDvo4QNjp8VBmxG/oMPm1Do22UgQdTmgNd6nauatpk
 fLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773915102; x=1774519902;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5BHz+eUozNfmtmQx/RnGlqSRrGcc8F7je4nlwnZEeU=;
 b=NXsbuvDRzmI2zmZgCzxEfhX6d6nyIsT2mb6hxHiKPbZhcs5yeI15bPRlOE1IBWncRV
 iOqJ1cesPHnBDFByn8oJ/HkI//U3CBr/pNKDRwoIikWRLPHHiknG0H7YPs06IZI0zpfV
 cBs64xHLYQ/O5mcpEhtuz48hner6d7NxOoF4XAe42BfwuyjknmoSOeO39L/Om8H8S0Hb
 dzzUjAGV9ELRv7luhqQNNJsP5PM5pyODl/cXDpnqgIxd/WSVAj/ICosdfxzU51IQ1EwO
 2uenzcENgGYHR5r142HIfVbjYCYJmXb2LrcbGLRb0R4ZDPqEcGVAvihcAiHj/YU7hzX+
 7l0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoUiFyMkWZ8XXXhFEJJgwi2QAfa6Xs9QX7qhCejQ1cctGTVuQNNhKr0XRjr7vrVmYSrl3SqHmm7K4m@nongnu.org
X-Gm-Message-State: AOJu0YyFQy3CUVKqlJz1qLNgsxNM4OVBz/Y1SYqoFU9NjW+4TgE88oju
 0cNohvmJi3MBSaG8MdcJ9fU/K+ENMQ8+UJ2QcQUUwBZXJpUEQAuFHj5ZcL3vOVNAiNYw6fxKi9o
 F0nF4z8lxCQ7OwO7PXYGOM/krQReIiwRG483MQDITj07xnqyQ1pXEl3Td
X-Gm-Gg: ATEYQzzMXGCy/oCLSBVugaceWC9hdC45+dNsLCjOhffPv5T2v0uZoNnMXVBtkq3uTrt
 YNFGNixUuExSnhTojWWOqLHdzY+/BF1zK5IcijcaMophVjwRXkwdrX86lbdXsZsdg3UZq/xoh0k
 QRPCzwlpLBq6bcRS7YPwHiW0Gt7eSEv8c85hSNcY72CYYbMFdCSwQ+Sypg8/QHpkFHX2V09zJH2
 J4LgSC3802zx+GU/AODzPDNNbL/8gR2kjCsizhE+x9KovtXJi42Y2kCyQj6AE91SPeG3pY6njR4
 JK5gQUe0xh+VeTqNok0KLv6G6MstJK4NM0GrdO6we9RByl3rUQMaTASvcOrumPEe2xO7KJUyQjf
 oAr810rNvuWl8LLnkAIakM3e4kVgzOkoCQhg5eTvdyHDDTmjTRv7SXCs=
X-Received: by 2002:a05:6a00:3c91:b0:827:17b7:58cf with SMTP id
 d2e1a72fcca58-82a6add5221mr6624579b3a.23.1773915102246; 
 Thu, 19 Mar 2026 03:11:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:3c91:b0:827:17b7:58cf with SMTP id
 d2e1a72fcca58-82a6add5221mr6624559b3a.23.1773915101693; 
 Thu, 19 Mar 2026 03:11:41 -0700 (PDT)
Received: from rhel9-box.lan ([122.163.114.34])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-82a6bbb2f34sm5594319b3a.30.2026.03.19.03.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 03:11:41 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, philmd@linaro.org, pbonzini@redhat.com,
 mjt@tls.msk.ru, qemu-devel@nongnu.org
Subject: [PATCH for-11.0 0/2] Build fixes for minimal microvm
Date: Thu, 19 Mar 2026 15:41:26 +0530
Message-ID: <20260319101128.116301-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Some build fixes for building a minmal qemu for microvm 

cc -m64 @qemu-system-x86_64.rsp
ld: libqemu-x86_64-softmmu.a.p/target_i386_kvm_kvm.c.o: in function `hyperv_init_vcpu':
target/i386/kvm/kvm.c:1757:(.text+0x5d83): undefined reference to `hyperv_is_synic_enabled'
ld: libqemu-x86_64-softmmu.a.p/hw_i386_x86-common.c.o: in function `x86_bios_rom_reload':
hw/i386/x86-common.c:1104:(.text+0x240d): undefined reference to `x86_firmware_configure'
collect2: error: ld returned 1 exit status

The build is done with the devices file:

CONFIG_PCI_DEVICES=n
CONFIG_MICROVM=y
CONFIG_VIRTIO_BLK=y
CONFIG_VIRTIO_SERIAL=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_INPUT_HOST=y
CONFIG_VHOST_USER_INPUT=y
CONFIG_VIRTIO_NET=y
CONFIG_VIRTIO_SCSI=y
CONFIG_VIRTIO_RNG=y
CONFIG_VIRTIO_CRYPTO=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_GPU=y
CONFIG_VHOST_USER_GPU=y

and with these confiure options:

../../configure ${common_configure_opts} \
              --without-default-features \
              --target-list=x86_64-softmmu --enable-kvm --disable-tcg \
              --enable-pixman --enable-vnc \
              --enable-virtfs \
              --enable-linux-aio --enable-linux-io-uring \
              --enable-numa \
              --enable-attr \
              --enable-coroutine-pool \
              --audio-drv-list="" \
              --without-default-devices \
              --with-devices-x86_64=microvm \
              --enable-vhost-kernel --enable-vhost-net \
              --enable-vhost-vdpa \
              --enable-vhost-user --enable-vhost-user-blk-server \
              --enable-vhost-crypto \
              --enable-seccomp

CC: mjt@tls.msk.ru
CC: qemu-devel@nongnu.org

Ani Sinha (2):
  i386/pc_sysfw: stub out x86_firmware_configure
  i386/hyperv: add stubs for synic enablement

 hw/i386/pc_sysfw_ovmf-stubs.c |  5 +++++
 target/i386/kvm/hyperv-stub.c |  5 +++++
 target/i386/kvm/hyperv.c      |  9 +++++++++
 target/i386/kvm/hyperv.h      |  1 +
 target/i386/kvm/kvm.c         | 12 +++++-------
 5 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.42.0


