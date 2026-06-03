Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4CACD6E72
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 22:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUuMa-0002Mg-Au; Wed, 03 Jun 2026 18:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wUuAp-0000Dw-6u
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 18:34:55 -0400
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wUuAn-00076T-K0
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 18:34:54 -0400
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-137f27712fdso163199c88.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 15:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780526092; x=1781130892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NT5ISx0OJZ4QZioJHUQSAXiJTtn6plUf2GAQuBMTKsU=;
 b=ShKEgYhyJvjH8TVumATE6Y1t0cljRmDmcUljcQU9M+09YWNhD84yGkUGfiuQT3IvXL
 W/8VXlMOZr8RrdTm/I/pK9ucZLEV5zxHkCEaOuEGPGBOVFjCWwgOLcXf4EEh80v+rF/3
 OJY/6sI08cj6j+eEhs+sSyY2qz9FU+E1gBvXnISRC2krcZ1dSnPXoooPY8pDnEmB0LTT
 7smtSVZMLC9cQVmKj6a77kcGAKw3SkLKYPBWdczW10yeCwVjbfRjM0HjZB4NkeGFHZtx
 KXjMpdsvEFra6yv1FmGBpor+lcHhigB82hdNZ2eeEapi/zaJDnwcfNkoJTZHWsBJQFUd
 /nEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780526092; x=1781130892;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NT5ISx0OJZ4QZioJHUQSAXiJTtn6plUf2GAQuBMTKsU=;
 b=RigpYoE7IwhqhCV07vEAAC3iD7PLT9NhTjdHMLBOmETt1tTmEDNw/fQ6QJWLJp/of1
 l6UX8QvsNUc03MnHPHTSLCCeHrca/pcfjzq+8janT3qA8B8BwOrPJi0N2j7UDDZUKk1U
 noqqgrfVswMTfEYiJkDHAjujolcnv/l5FP0FMux4Za/FBrh07gTbW4OcS5S6WKIusXJ6
 DRq1d4gawTM+bTTCRkB2+umZi5aRThsekwDV7IpC73TYgS35bkBA0OVMhRQJIQC0HXxR
 XVuoA5dHGEy0Xifv7EVcb2OO0lBWKjo3NtnJBWmacASfFQjAPd6puAWLlSZju+j4KWt8
 f0VA==
X-Gm-Message-State: AOJu0YxMVo3YoNS1zVqFwhvpkjBn8eB/VyAh18BB3zOINyfaAW1UhdTP
 5Pz/h6zuKJ7JXsWouAqmASZeADB55r/R72axyUmfHIQIC5I0BJ1PHRnODRoCU1Yg
X-Gm-Gg: Acq92OF1pMzhzLdiHUUHiiHeFLjOfrXjanuTmn7id6qeWRcG33lDT1LWHHdngK5Gfl6
 jUHATB9G8m/ljNROM05SY7obxavI5hyt65HWC3D6NKzJtj9zh29dBTtB5SrGhTV+gw1EPVsO6c6
 YHHMNT30IaDXnMDpuaykiVfXjPdty2gI5u0KS9zs6ebwUkiaiIXRW5cZ76NDCjsWtpDohrRgcoj
 p4uAAGDFzWpj5mmApxyHNen7YJAuPXyZd1aWGXV/1v4yEq5l3/yq/EPUV+EGq/6FF3lhD4Eb4Fs
 f88X6bBl/W0frgYCVvSpKw27q+D37+TgTTQoDJr0Qw2KWzMrgVUyIkEPQOYrgVLGls8P1nbo91E
 Y14wVHsIMNrlD4D9nPWgr0vMlhXFzeL4JAJbw/AuTBklRxfx9dCQ5vba5TMmp15ec0rsdS/+acq
 b9sJXk5CKXcG05MvsZFZTFO84q+uTLewUehXc99trZ7ojUeEz4
X-Received: by 2002:a05:7300:7483:b0:304:eaa8:11ea with SMTP id
 5a478bee46e88-3074fcaa2bcmr3133043eec.34.1780526091889; 
 Wed, 03 Jun 2026 15:34:51 -0700 (PDT)
Received: from MacLin.attlocal.net ([2600:1700:e140:14d0:fad:648b:d3db:b403])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df349d8sm3492027eec.22.2026.06.03.15.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 15:34:51 -0700 (PDT)
From: ConKite <connorkite@gmail.com>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	hreitz@redhat.com,
	ConKite <connorkite@gmail.com>
Subject: [PATCH 0/2] vhost-user: Add and consolidate qdev properties
Date: Wed,  3 Jun 2026 15:33:53 -0700
Message-ID: <20260603223430.3311916-1-connorkite@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1232;
 envelope-from=connorkite@gmail.com; helo=mail-dl1-x1232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 03 Jun 2026 18:47:00 -0400
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

[1/2] Consolidate chardev qdev property definitions in the
VHostUserBase family of devices.  Now, the definition only takes place
within VHostUserBase initialization and is inherited by children.

[2/2] In support of future work to add a memory isolation mode to vhost-user
devices, a qdev property, "memory-isolation", is added to all vhost-user
devices.  This is simply a bool representing whether the mode is active
or not.

These patches are grouped together as they both touch on qdev properties
held in common by all vhost-user devices.  Taken together, these patches
ensure that commmon properties are defined in the same location and way.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
ConKite (2):
  vhost-user: Consolidate chardev property definitions
  vhost-user: Add memory-isolation qdev property to vhost-user devices

 hw/block/vhost-user-blk.c            |  1 +
 hw/display/vhost-user-gpu.c          |  1 +
 hw/scsi/vhost-user-scsi.c            |  1 +
 hw/virtio/vhost-user-base.c          | 10 ++++++++++
 hw/virtio/vhost-user-fs.c            |  1 +
 hw/virtio/vhost-user-gpio.c          |  4 ----
 hw/virtio/vhost-user-i2c.c           |  5 -----
 hw/virtio/vhost-user-input.c         |  5 -----
 hw/virtio/vhost-user-rng.c           |  5 -----
 hw/virtio/vhost-user-rtc.c           |  4 ----
 hw/virtio/vhost-user-scmi.c          |  1 +
 hw/virtio/vhost-user-snd.c           |  1 -
 hw/virtio/vhost-user-spi.c           |  5 -----
 hw/virtio/vhost-user-test-device.c   |  1 -
 hw/virtio/vhost-user-vsock.c         |  1 +
 include/hw/virtio/vhost-user-base.h  |  1 +
 include/hw/virtio/vhost-user-blk.h   |  1 +
 include/hw/virtio/vhost-user-fs.h    |  1 +
 include/hw/virtio/vhost-user-scmi.h  |  1 +
 include/hw/virtio/vhost-user-vsock.h |  1 +
 include/hw/virtio/virtio-gpu.h       |  1 +
 include/hw/virtio/virtio-scsi.h      |  1 +
 22 files changed, 23 insertions(+), 30 deletions(-)

-- 
2.43.0


