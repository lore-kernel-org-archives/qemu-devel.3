Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751B1C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 12:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9MGf-0007r2-7P; Wed, 23 Sep 2026 08:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mankku@gmail.com>) id 1x9Lxu-0004Eo-76
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 08:20:49 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mankku@gmail.com>) id 1x9Lxp-00079c-GQ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 08:20:44 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-3a20f06cce6so8676411fa.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 05:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790166030; x=1790770830; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Farp/KiQchtSct+0mXXG8B0fmCxMnmZOWmNE6EWIh0o=;
 b=syXh/ikBCGlpwdlQ9PpGQhRgYq1Wes8YGbkO7jtngybXqdpMFQNqAohvglpZNbHSOM
 UkA0I2piksKbVAb7xHCw6aHxQ+rUtQFNam2ecI3pc8Hnr7Mu0IVwNBw8IiwuFifDgyeu
 1HZxi5MQV7xz13FGFtgWvYNO6ohZs2ahgTKStSyY/prD5VpVSasJfP12TK/uRItXqi8D
 Oyyqdd7F0skSWMLOxZYDJKvQP4auvA9NtGmSK+qV5+AHF9opwBtoauaLldd9TdJRjPim
 FY7n8P5Paz+MoV696sIJYlQR3KQY07Rt0Dx5kSCb31qwcqlNMqmt86F28Q7tGI82ALJI
 ll2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790166030; x=1790770830;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Farp/KiQchtSct+0mXXG8B0fmCxMnmZOWmNE6EWIh0o=;
 b=bzwpsiPfP+fjHlPrQ2pCVcfDBB8aKScaVQr0N3Gja6hDFzyJbccfOcoHE8BCG+Nm3W
 FD2Of8ebybY6T29jmoouzbdys6glsj8eHx7KDUhg2e2PcXuen3YlcjcL78372KZ3M9SS
 NNCouNnvi4JEEBLjzU3bOiWN2RwzEAKdr4xc09dnrMmdqKKybMesdy093O2GqRDvkV1w
 /+Ib3cEp2AW+qtzX7nv6QNl3Bl34ylGK1iEQtYtQBjgSYx79iitYXY5n65eG9THr07Zs
 xS74BIm277xPT9OakTtrrmu24D1TzA2iPfo0mxPVlLha+fpIrYN7ZeQ79cVUFda0vOda
 WTqw==
X-Gm-Message-State: AFuF++mzu8k0IB20vQnmS+xL95Yf6nyhKdxk8zmM0+YErgknLCYlAhuU
 o+ehG/lilOS+1ImZTXRn1ifpmK5PmG+d4sZavATcxQnQ7/c8EAPVtUnb
X-Gm-Gg: AYBFou0YFiUGFocfZVJtPf5cenXr7rPchfWq85jQjkEAUk/zScWTfIwXycWPPouJK/s
 EQOJS17Tg/Q1vFOfocyej3Caf0ITS/12pj11gZJVX480B281/s0xlLAyHsX2JcFgVlRqLp6mvT8
 lhbJGwzfUIwB8kb+EXYOQqpFVYL74yCr41avGU1ZHBxON6LIsZheI2aXLuGZX/AuKDw3qzFA+TM
 wkE1YeWJ7FKzFJ6TWqzIFKyBI9t9slcf1nnE6+0vEzXTz2f04Ajuj+0a8kraMAC9bDkBU+UuBa4
 kI1rAJNd9Bz1sy9ep7aKk5WksfgFuO+dD7xJX0cENSWNwgjNfl/f/Bw1cz6U5aydNqUTw9FSVZa
 Y7YBrV6JZ9P9i91v0DEdoaSNIAiaPM8w1NJdYmyAewPS61P4kFX9Z2AgS+pqlFamprusnHX0Z0m
 BAWTS64A7tsN9IeljurSpTk4YbkGFdUKC/V9YVRvYC80jggyhtn/Z6h09/zVarivqNWa1xVINkR
 JV3zDHizALym3K1ZZ6Oj7FQs8PtYWQ=
X-Received: by 2002:a2e:b8d6:0:b0:3a3:61ec:43c7 with SMTP id
 38308e7fff4ca-3a624dd9052mr13695211fa.24.1790166029595; 
 Wed, 23 Sep 2026 05:20:29 -0700 (PDT)
Received: from [127.0.0.2] (109-204-139-9.dhcp.ossk.fi. [109.204.139.9])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d85897aesm552138e87.50.2026.09.23.05.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 05:20:29 -0700 (PDT)
From: =?utf-8?q?Markku_Ahvenj=C3=A4rvi?= <mankku@gmail.com>
Subject: [PATCH 0/3] hw/nvme: fix legacy INTx handling
Date: Wed, 23 Sep 2026 15:20:01 +0300
Message-Id: <20260923-nvme-intx-fixes-v1-0-fbf0e4e567a5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqEQAwEvyI5OxADKu5XZA+ORo3grExUBPHvx
 vVY1VSfoByFFT7JCZF3UfkFgyxNoB2bMLCTzhgIqcCKyIV9NhfWw/VysLoMfYm+yAl9A1Ytkf+
 DRfX3Zd38xO363MB13STiS9xzAAAA
X-Change-ID: 20260922-nvme-intx-fixes-10b70b6520ba
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 =?utf-8?q?Markku_Ahvenj=C3=A4rvi?= <mankku@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790166028; l=2270;
 i=mankku@gmail.com; s=20260923; h=from:subject:message-id;
 bh=jxyV5GCuzii0iT+sIZ2o8def3Ci0GjIag7pW+j+FVaY=;
 b=MAPJCyElTDSmQZvMI0YnUVjm8h7tpmQobvBvEXDba6zOFanmuTEPYzg0TNtWhwMyVvBQPU4DZ
 Qh3ymGjWepeDbA6rz6ePZFhp4HgpQLM4CW76pXHg5rDBLhGY33IDB0g
X-Developer-Key: i=mankku@gmail.com; a=ed25519;
 pk=vdAiS3IZFixKCwRmc+wfwUSPQWpEMkFYPH8m9evJZPc=
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=mankku@gmail.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 23 Sep 2026 08:40:05 -0400
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

This series fixes three cases where an NVMe legacy INTx interrupt may
remain asserted, causing an interrupt storm in the guest:

* cq_pending can underflow when a doorbell notification is processed for
  a completion queue that is already empty.

* A stale CQ event index can cause the guest to suppress a subsequent
  MMIO CQ doorbell write, preventing QEMU from observing the updated CQ
  head.

* Controller reset does not clear pending CQ interrupt state.

Without these fixes, a Linux guest using legacy PCI interrupts may see
the following:

[    2.058360] irq 23: nobody cared (try booting with the "irqpoll" option)
[    2.058724] handlers:
[    2.058820] [<000000006a09281a>] nvme_irq
[    2.058966] [<000000006a09281a>] nvme_irq
[    2.059113] Disabling IRQ #23

I reproduced the interrupt storm with Linux 6.12, 6.18, and 7.2 by
booting the guest with pci=nomsi. The cq_pending underflow occurred with
ioeventfd=on, but its fix covers both ioeventfd=on and ioeventfd=off
configurations. The stale event-index issue occurred with both
ioeventfd=on and ioeventfd=off.

The following command was used to reproduce the interrupt storm with
ioeventfd=on:

qemu-system-x86_64 \
      -machine q35,accel=kvm \
      -m 2G -smp 2 \
      -kernel ./linux-7.2/arch/x86/boot/bzImage \
      -append 'console=ttyS0 root=/dev/nvme0n1p1 rw pci=nomsi' \
      -drive if=none,file=./guest-image.qcow2,id=disk0,format=qcow2 \
      -device nvme,drive=disk0,serial=testserial0,ioeventfd=on \
      -nographic

The controller-reset fix addresses QEMU issue 4142:
https://gitlab.com/qemu-project/qemu/-/work_items/4142

I was unable to reproduce this issue with a Linux guest, but a
controller reset must clear the CQ interrupt state and deassert the
interrupt line.

Kind regards,
Markku Ahvenjärvi

---
Markku Ahvenjärvi (3):
      hw/nvme: prevent cq_pending underflow
      hw/nvme: fix missed CQ updates
      hw/nvme: clear interrupts on controller reset

 hw/nvme/ctrl.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)
---
base-commit: 7074591d7954876951f84c15b994a43251d5a3c1
change-id: 20260922-nvme-intx-fixes-10b70b6520ba

Best regards,
--  
Markku Ahvenjärvi <mankku@gmail.com>


