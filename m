Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80075C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 06:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscTy-0006NJ-CZ; Thu, 13 Mar 2025 02:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscTu-0006KG-1A
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:55:50 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscTq-00062G-Io
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:55:49 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2fef5c978ccso1090189a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 23:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741848944; x=1742453744;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QZZQhH6ivk3JyijidPGyvWcmUVWmHyz0FvYly6OOQJE=;
 b=AC7SVrXqalhrbPURZawvSVNrXvOEV6C/oow9o3MEo5/qT7jrPztCxPycDW3yNZEYjk
 ngsOf6lMu9MV/ffnwhX4RHnrbtj3UpPjI6J0t47R2I2x569Yl3P58BfOkf6w8oXrFp96
 K8LsRKxZchenZWF1GaMmdsqQ44bbK0QiqRTJErSg0GNousdLtw2cTYHQVCCeIyYC8eMs
 GTwimr7FrpuBt9dV7dpRBACRf+OFJRsnDgIUm8/gFgTz9uysClyPg+k374mfBRJNAAMa
 1XaELysf/4+5U5ew6d32AOjh/0iFg6cuumMDWuLe+7U4a18p6U3U6RPGBg3mHIRPQcsA
 mtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741848944; x=1742453744;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QZZQhH6ivk3JyijidPGyvWcmUVWmHyz0FvYly6OOQJE=;
 b=D2pHCPTNG1Eh3vXFVflVk3eYWAZeinr3jp4ThQicUVtoyvRaHvb8wjBXzZ9bU+s4NE
 O+oeh77seqPQTRIR/euP7igcld99HMUScyB+dOaTxrYRGVizDDcOyzguIO9+wSsS8Wew
 VDLAV8d4E2BwT5de/Uq2iP4ym1ph2UYx2lmlA4IO410NN/cv+u/zrEx4mb+bVV4Pi/nG
 uiDcu8lRHKDeKst1zVm6/KeXDd4j5m8l2dfNyBjCpNbdcsEmd5QODp9Do9hsdb35Ns8P
 cv2RbbiDI+9Q1sVZhdhQdJu/HP/x7r6lC6zw4S2VlvLkQS/C226eb9bRzV2p2FV8fqLJ
 nkjA==
X-Gm-Message-State: AOJu0YzNiDFEHRrIvePmD7QF6wKgJRhCjXQRQcs0+YJS+TZFX0ycuVQ+
 a0H4EvwJsoHqtIi/4fHSawQ93YYQDASn08f9DsLq52xTLGgLCCzjx5F30xx6ZKg=
X-Gm-Gg: ASbGncsMmSBzVlSur4m5MT7ix/BwmZm6BsJpmiPi4G2hRKfqFgET1OIqdFjqfhItCKt
 pGOi1ct5TW8bsUN9A8mqj4el5LVCa3TMJcliYbr8FCOzGk6FBqG/D34I2K71cJA+XSE1XmSgaZ0
 V8BswGGU/48EhCwWGRqyzI+oL+d63kMtBOA1FUxEIvQt+Xe47m4aftL7GN98CTfIhRF5evGfw+q
 ur6gn0MvIYhfz7lbR7GiKZhLVl6R/Mp6cahjOyb426JRj4jEinRRCOrAQSOfMawwhPyfyNWqhbT
 BSEGNJr0lXU+TDSfr+h6pfi3Ybw+r6grR5MgFnKHzWyLqkNv
X-Google-Smtp-Source: AGHT+IGSzpGAQjmdpgpVGLgF+dX9jHAAGvGhejcbXzPoHEcwzweVkQTtaMjggj5/dzpL2mhP6Z8aCg==
X-Received: by 2002:a17:90b:224a:b0:2ff:79ca:24b7 with SMTP id
 98e67ed59e1d1-2ff7ce89d64mr31828486a91.21.1741848943997; 
 Wed, 12 Mar 2025 23:55:43 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-30118235051sm3081980a91.11.2025.03.12.23.55.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 23:55:43 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RFC v4 00/11] virtio-net: Offload hashing without eBPF
Date: Thu, 13 Mar 2025 15:55:26 +0900
Message-Id: <20250313-hash-v4-0-c75c494b495e@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF+B0mcC/yXMuw7CIBQG4FdpziwGgbbUycTEB3A1HRBQzlAwY
 EibhneX4Phf8u2QbESb4NztEG3GhMHXIA4daKf82xI0NQOjTFDJJHEqOTIwydmkRG+EgXr9RPv
 CtTEPuN+uMNfSYfqGuDU68zY1ZTr1fyVzQsk46SeVhslBjBejNo/rUYcF5lLKD4E8lG+eAAAA
X-Change-ID: 20240828-hash-628329a45d4d
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 devel@daynix.com
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I'm proposing to add a feature to offload virtio-net RSS/hash report to
Linux. This series contain patches to utilize the proposed Linux feature.
The patches for Linux are available at:
https://lore.kernel.org/r/20250307-rss-v9-0-df76624025eb@daynix.com/

This work was presented at LPC 2024:
https://lpc.events/event/18/contributions/1963/

Patch "docs/devel/ebpf_rss.rst: Update for peer RSS" provides comparion
of existing RSS mechanism and the new one (called "peer RSS") and
explains how QEMU selects one.

---
Changes in v4:
- Rebased.
- Added a reference to the documentation to the cover letter.
- Link to v3: https://lore.kernel.org/r/20240915-hash-v3-0-79cb08d28647@daynix.com

---
Akihiko Odaki (11):
      qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
      net/vhost-vdpa: Report hashing capability
      virtio-net: Move virtio_net_get_features() down
      virtio-net: Retrieve peer hashing capability
      net/vhost-vdpa: Remove dummy SetSteeringEBPF
      virtio-net: Add hash type options
      net: Allow configuring virtio hashing
      virtio-net: Use qemu_set_vnet_hash()
      virtio-net: Offload hashing without vhost
      tap: Report virtio-net hashing support on Linux
      docs/devel/ebpf_rss.rst: Update for peer RSS

 docs/devel/ebpf_rss.rst        |  23 ++-
 include/hw/qdev-properties.h   |  18 +++
 include/hw/virtio/virtio-net.h |   6 +-
 include/net/net.h              |  20 +++
 net/tap-linux.h                |   2 +
 net/tap_int.h                  |   3 +
 hw/core/qdev-properties.c      |  67 ++++++++-
 hw/net/virtio-net.c            | 331 +++++++++++++++++++++++++++++------------
 net/net.c                      |  14 ++
 net/tap-bsd.c                  |  10 ++
 net/tap-linux.c                |  18 +++
 net/tap-solaris.c              |  10 ++
 net/tap-stub.c                 |  10 ++
 net/tap.c                      |  15 ++
 net/vhost-vdpa.c               |  41 ++++-
 15 files changed, 478 insertions(+), 110 deletions(-)
---
base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
change-id: 20240828-hash-628329a45d4d

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


