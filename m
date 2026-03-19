Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F962108E1FE
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3COP-0005Gd-T4; Thu, 19 Mar 2026 08:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3COG-0005Eh-Aa
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:22:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3COD-0007fw-BK
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773922931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HGKbDnCCKDFd5QLh4RqmgYHjPGItoAxzhCVSPB5ZKXs=;
 b=XPyRDCT+n2jYCcbyGWIKa2i8GYGDHZe9WCzdBdNmh1pmx7CoD+aYLna2vtlX85iU8gJro5
 vZDR6iQbSFVAHBu/f1dZvg+8b6aDUPIsDxB+OMraoFafg48X9ocCfuOS0Io1+1Cg25eAXh
 qs+IKHbgPgDXKD8yHFCKzJW0HBnZY4k=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-ECFD4mgJNru_wvDjVvJRnw-1; Thu, 19 Mar 2026 08:22:10 -0400
X-MC-Unique: ECFD4mgJNru_wvDjVvJRnw-1
X-Mimecast-MFC-AGG-ID: ECFD4mgJNru_wvDjVvJRnw_1773922929
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-829ad972df6so814168b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 05:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773922927; x=1774527727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HGKbDnCCKDFd5QLh4RqmgYHjPGItoAxzhCVSPB5ZKXs=;
 b=qEfB1ndIJJyRgJ8tDtdB3aO7YkeGgTsgTZjGrSc4dKqqldPl+yN4uh2xifZPMyyx1D
 fn6vdemIfS1I5gtkX2Dy1rKQU6ROlfTYox+CIiZUG9a5xvogIs7ouIIRKHxMCoCu6l/k
 lB2aHWKrfInvpJhfO2VxtbPb00xq7+cCPEnIQEXCp7dczs+i96hhr2IOi9N36XfuaQt2
 DeZ4x9FIcQU2S+hbutd1xUmkznYmMoDArq264ydPz9IlEVXuEVPk5l8TjxREt4KyfemH
 T9wAUi0WieohPEKHaQwzT2ea6GDpu9uQf2DRRX/sf3EJRM3Yn7tjAVWlANHMZOdsXeKD
 ShtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773922927; x=1774527727;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HGKbDnCCKDFd5QLh4RqmgYHjPGItoAxzhCVSPB5ZKXs=;
 b=Zj9m3m/aMjooM9ynGvpNkzcJXd/XckFUCtDRntxWeLQ7uAs4BJv7GNe/frTTBNbYSE
 jdknpT4dPlvtSzirzuXLepUwziYkBEoWxmtd49BwtbyLzviObgwzJWv4BDe5w41U2GjN
 Q7IbGQ5HCQmaPCZ8hM5XIkjand5Jgg7C7EJO9vr8NUbkMtDFvNs+rkIq8UNKI3fgnkP4
 jty45aHDyntHl+/k1zgdxtjZKU1JY3PsdTB4JAER5O29v0GJirTBhHzpesAlw2H0rzZH
 Qwka2shhTH1Wujb5yFT42LQFA7kgLJ/jXlyAX5nnR78MIc2Ycb/vONqi+a7ddUMrK0Rv
 stwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcyqsY83LRF0QRdbdTAsDwj+/IzZxjLXof8ENjUlYK+ItuPH+bfvKgZaB0+F424N3ZdJB1DIuneBV0@nongnu.org
X-Gm-Message-State: AOJu0YylMqMyRPfmppFz9KF/VvgjnAhMoZAer11jVgsSrFghdr8TCTzS
 iMx4UD64SAMHfwduVJyA7O4ZDtE6B1kMPsSP4F0qvd6/dQen4e9PD3gJz/yIejSmwh9h/7yV+lw
 Qbq+LjRWkxSgo4Qj4gboL797O4IIzVudxW51F3qt7PsszNWVmUuQrsTjg
X-Gm-Gg: ATEYQzywVMCZMvyXPysJW4RQosNgU/D0meKJ9ADfoFQo3i7SKRU56cUjYaqXsn8LNuz
 546ycjCXtQv0yU75fw50u6x4QvdpFVeYpWxJJhWLT+Bs+7KaPEM0VVakyKtpAwhhgxH5OT3IEqt
 QC9n4qzomj/tjkwgdGzYziiLZ4lHiZSBY1Rd99Gf7y70JBKE4y/yWSgTYioEaepAvayjxqPWqyE
 kSK/uqCAnLRzHieTCEg610RnjHlX/FIztHELFhCRfaN9pgGuftyoJIhG7TxW4w+agxArwfcHH2B
 RdpQ32NxsNRMTJag7wvavhvU44l0IubN5jpNH4QxkvjmU7llikkPJoKpdzBgce0DljH97J7DcRG
 4NY3U780x06yC1DktRLGZqy2x738gTSuWiBIyR9wqN2DdHkgRj6NAGAw=
X-Received: by 2002:a05:6a00:2ea8:b0:81f:9c54:65df with SMTP id
 d2e1a72fcca58-82a6af1855emr6489669b3a.50.1773922926704; 
 Thu, 19 Mar 2026 05:22:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:2ea8:b0:81f:9c54:65df with SMTP id
 d2e1a72fcca58-82a6af1855emr6489655b3a.50.1773922926259; 
 Thu, 19 Mar 2026 05:22:06 -0700 (PDT)
Received: from rhel9-box.lan ([122.163.114.34])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-82a6bbe1ffbsm7876649b3a.43.2026.03.19.05.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 05:22:05 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, philmd@linaro.org, pbonzini@redhat.com,
 mjt@tls.msk.ru, qemu-devel@nongnu.org
Subject: [PATCH for-11.0 v2 0/2] Build fixes for minimal microvm
Date: Thu, 19 Mar 2026 17:51:34 +0530
Message-ID: <20260319122137.142178-1-anisinha@redhat.com>
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

CI works: https://gitlab.com/anisinha/qemu/-/pipelines/2395426997

CC: mjt@tls.msk.ru
CC: qemu-devel@nongnu.org

Ani Sinha (2):
  i386/pc_sysfw: stub out x86_firmware_configure
  i386/hyperv: add stubs for synic enablement

 hw/i386/pc_sysfw.c            | 31 -------------------------------
 hw/i386/pc_sysfw_ovmf-stubs.c |  5 +++++
 hw/i386/pc_sysfw_ovmf.c       | 33 +++++++++++++++++++++++++++++++++
 target/i386/kvm/hyperv-stub.c |  5 +++++
 target/i386/kvm/hyperv.c      |  9 +++++++++
 target/i386/kvm/hyperv.h      |  1 +
 target/i386/kvm/kvm.c         | 12 +++++-------
 7 files changed, 58 insertions(+), 38 deletions(-)

-- 
2.42.0


