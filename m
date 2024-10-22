Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6370D0E6FC
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 04:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t36rE-00023k-Fd; Tue, 22 Oct 2024 00:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t36r6-000225-Rc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:50:54 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t36r4-0008Qc-Jb
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:50:52 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e56750bb0dso2416281a91.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 21:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729572648; x=1730177448;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MNDW8yiqAscawhCTmbCo2knYfHE5DA/+LQDnHrnS/T0=;
 b=cODEhHAS/3Yhv0S7aBNxuyyivyxyo2JfXKiWhO6T9Sl5RhLyWqRMtehLQmr3cYQ1u2
 0mJnfrGIWhm5kIaHL0i/zHkCqn4BY99/JWqs+68ioI67R0Yz3bU3Pxd2qoW45MTUXKyN
 i+YQyjuK4iV+NIhaI3HLTpGFYNFq+I/IBzP3jbGsaAyI5jl9iuPbBChb+OweW80FhbF+
 kFgE4chcZ7X1o0v9j7axFe0LP4xscnaX7SO4c5/LcgSfG7zNjIgk1/SKy4THfaEA/8yp
 VwOZ79BG6sGOV+dglPD+3HwiKEptaate8pMwph+FlNr60vmkdBFNiaE8rjSmlYeFYXXA
 vmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729572648; x=1730177448;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MNDW8yiqAscawhCTmbCo2knYfHE5DA/+LQDnHrnS/T0=;
 b=q+YV6+ZujqkPT5+OFEz+OaxMAXE81Q/lpGMIPRmgyJgzYV/8OiljDC3UrOVSsYPfje
 xu/DYhwMa5nMNqYAsWZE0iMcauiKd5xs/rRxJ9fvcEfmeF5MaWuTtlkgg7ZF4e8qEBie
 UXYrjdohc6sHgnv9GUZ7kA1R6RqZuvXLtci4TwMDbn6IAWl/1Epg81FOwx5xiIQsbyUE
 s/hsES5J60JkXOLYndBklxeg2oLCUtsJPV7EEiqI5HWmePL2H5Wd5xT7Jd4vWe52XHJp
 kez8VK27I2JsqbDuKoXk65YbkAw2GpiAFDMs6qeVl+/dtVMVEMNMxUSNv6bUaG/elTSW
 69OQ==
X-Gm-Message-State: AOJu0Yw5h+TvkuezgGIBLdMTOUrI/QbZl8JNxkKtuzcc+slpJD4tqEIE
 vl8R1vwbUvZ3mWeGReA3a9Oz2Y6gqaFo5Ih1YFRz9lYRjoDzIGjvzVg27x7uwKo=
X-Google-Smtp-Source: AGHT+IE6XTrohNfS/CTn0AtKLymRb6l2fCrI6nkl+PsgEWl3Yzevgs7+yFM9wzIPI9aNxHga3Gr88g==
X-Received: by 2002:a17:90a:17ef:b0:2e2:991c:d7a6 with SMTP id
 98e67ed59e1d1-2e56172abc7mr15434719a91.19.1729572647720; 
 Mon, 21 Oct 2024 21:50:47 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-20e7f106c01sm34028605ad.300.2024.10.21.21.50.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 21:50:47 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/3] virtio: Convert feature properties to OnOffAuto
Date: Tue, 22 Oct 2024 13:50:37 +0900
Message-Id: <20241022-virtio-v2-0-b2394236e053@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB0vF2cC/zXMQQ6DIBCF4auYWZfGQdqqq96jcUFgqLMoNGCIx
 nD3UhOX/8vLt0OiyJRgbHaIlDlx8DXkpQEza/8mwbY2yFYqbLETmePCQeBdke6cHG6mg3r+RnK
 8HtBrqj1zWkLcDjfjfz0JdRIZRStosNY9dI/9gE+rN8/r1YQPTKWUHxRboR+dAAAA
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This series was spun off from:
"[PATCH 0/3] virtio-net: Convert feature properties to OnOffAuto"
(https://patchew.org/QEMU/20240714-auto-v3-0-e27401aabab3@daynix.com/)

Some features are not always available with vhost. Legacy features are
not available with vp_vdpa in particular. virtio devices used to disable
them when not available even if the corresponding properties were
explicitly set to "on".

QEMU already has OnOffAuto type, which includes the "auto" value to let
it automatically decide the effective value. Convert feature properties
to OnOffAuto and set them "auto" by default to utilize it. This allows
QEMU to report an error if they are set "on" and the corresponding
features are not available.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Expanded the message of patch "qdev-properties: Accept bool for
  OnOffAuto".
- Link to v1: https://lore.kernel.org/r/20241014-virtio-v1-0-e9ddf7a81891@daynix.com

---
Akihiko Odaki (3):
      qdev-properties: Accept bool for OnOffAuto
      qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
      virtio: Convert feature properties to OnOffAuto

 include/hw/qdev-properties.h | 18 ++++++++++
 include/hw/virtio/virtio.h   | 38 +++++++++++---------
 hw/core/machine.c            |  4 ++-
 hw/core/qdev-properties.c    | 83 ++++++++++++++++++++++++++++++++++++++++++--
 hw/virtio/virtio-bus.c       | 14 ++++++--
 hw/virtio/virtio.c           |  4 ++-
 6 files changed, 138 insertions(+), 23 deletions(-)
---
base-commit: 7e3b6d8063f245d27eecce5aabe624b5785f2a77
change-id: 20241013-virtio-164ea3f295c3

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


