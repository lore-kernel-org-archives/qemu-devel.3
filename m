Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB42DCD1297
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryWI-0007KD-3o; Wed, 03 Apr 2024 07:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWF-0007IS-9c
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:03 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryW9-0007DL-Vj
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:02 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ea8a0d1a05so562150b3a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 04:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712142655; x=1712747455;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FCvUVgUuHR1mK7AvRlQBqNULNlOSGSq8/bxa1idBWGs=;
 b=e69SZmekKlJq+RCwd8P2+USacuGDcfbCAWZrhVZyFgr8n/XzXq4Wbvzwe1gcx4ECRD
 8q5eXXR5d66KJ1JzMjOjEFI8kug7JF/kMKJy/r7ZJm/fY9++SyAHjI92R2Y/LCfztIFt
 WpCjiYThUayJwrt1ftTNNPMcTAJZHvN/Kw+9YT0LtdN3havO5iQ9IHf/vLA2kk5tLv2A
 1lSaOkuG9UU1vUXXdgI+xNBJ4PmD5YUZZrW79PAWbvp4XbPvzEH/E0fM1+vPS1r9Nozg
 jGJ000ilAZ9WsVv7zesOlDtLdERVEY+KgLu+dW+PoDb/N002oo46dXFIAyf32Rk1fHlO
 d7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712142655; x=1712747455;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FCvUVgUuHR1mK7AvRlQBqNULNlOSGSq8/bxa1idBWGs=;
 b=RagIZvWZVRSYjesqHYn2eJh3j43lArW+G9nxjmwyQ3GvW40Ostzxdxo8wY63xso2TR
 I2cQAewXGdinrIRkccyCYXayvXXJaNI52EDr31Jqy4Opy7owhM8mqCkNE23W/4EHZ+/R
 xOp32AePK04eppYl1CkWLOZbmvX3pfZxpgNHpYya4+83jlqHaOlM6xYuUH/7u24oGGQe
 36mrkUlLgpRNogWpKXtbEYjDq78OfQlqdZH/rtMGG2zSbgpUORieqDWj6S2mqQYEzcsu
 UFixNI39wMdTpHaHXrUnjkCPrpBTdb3Tl9pJiBVaKRp47M3urMreCTE5biqn49uAdEzC
 k+oQ==
X-Gm-Message-State: AOJu0YyhT/CKi8oZwhnX8Mu3cdywQu0SWtEETKAHF4uzin2fWORzh69v
 bI+ENprfATECDUKBVVTAqRbyuO6t6UZYrNHr9/MmqoQe9PAqjUeJNxR9EwBjEFE=
X-Google-Smtp-Source: AGHT+IFzExphSGv6Qmb1/0h9OVc8onD7NrVI09xIkkowP88S76XTJ8ZjikB+v7q4TDRcj6z5GLoPbA==
X-Received: by 2002:a05:6a20:a126:b0:1a5:6d7f:f1e9 with SMTP id
 q38-20020a056a20a12600b001a56d7ff1e9mr2916153pzk.27.1712142654749; 
 Wed, 03 Apr 2024 04:10:54 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 w11-20020a056a0014cb00b006e72c8ece23sm11471586pfu.191.2024.04.03.04.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 04:10:54 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v9 00/20] virtio-net RSS/hash report fixes and improvements
Date: Wed, 03 Apr 2024 20:10:48 +0900
Message-Id: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADg5DWYC/1WMQQ7CIBBFr9LMWgwMEsCV9zBdNDDaWUgNGNKm4
 e5idy7fz39vh0KZqcB12CFT5cJL6uBPA4R5Sk8SHDsDStQKlRS5FEE2eEcWEY2G/nxnevB6VO5
 j55nLZ8nbEa3ut/771QkpvDGayKpL1O4Wpy3xeg7LC8bW2hegN1VGlwAAAA==
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 "Zhang, Chen" <chen.zhang@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

This series contains fixes and improvements for virtio-net RSS and hash
reporting feature.

V7 -> V8:
  Reset author email addresses.
  Rebased.

V6 -> V7:
  Dropped patch "virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT".
  Dropped the changes to remove packet flags.
  Re-introduced tap_receive() and changed it to call tap_receive_iov().
  Removed tap_get_vnet_hdr_len().
  Fixed tap initialization not to call tap_fd_set_vnet_hdr_len() for tap
  without virtio-net header.
  Changed to call error_report() instead of warn_report() for
  programming errors.

V5 -> V6:
  Corrected the message for patch "virtio-net: Return an error when vhost
  cannot enable RSS".
  Removed changes to introduce asserts from "virtio-net: Return an error
  when vhost cannot enable RSS".
  Reorganized patches "virtio-net: Return an error when vhost cannot
  enable RSS" and "virtio-net: Do not clear VIRTIO_NET_F_RSS". This
  version now contains patches "virtio-net: Return an error when vhost
  cannot enable RSS" and "virtio-net: Enable software RSS".
  Rebased.

V4 -> V5:
  Added patch "virtio-net: Do not write hashes to peer buffer".

V3 -> V4:
  Extract patches "tap: Remove tap_receive()" and  "net: Remove flag
  propagation" from "net: Remove receive_raw()".
  Added patch "virtio-net: Always set populate_hash".
  Added patch "virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT".
  Added patch "ebpf: Use standard section name".
  Added patch "ebpf: Simplify error handling".
  Added patch "ebpf: Return 0 when configuration fails".
  Added patch "ebpf: Refactor tun_rss_steering_prog()".
  Added patch "ebpf: Add a separate target for skeleton".

V2 -> V3:
  Added patch "tap: Remove tap_probe_vnet_hdr_len()".
  Added patch "tap: Remove qemu_using_vnet_hdr()".
  Added patch "net: Move virtio-net header length assertion".
  Added patch "net: Remove receive_raw()".
  Added patch "tap: Shrink zeroed virtio-net header".
  Dropped patch "tap: Fix virtio-net header buffer size".

V1 -> V2:
  Added patch "ebpf: Fix RSS error handling".

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v9:
- Added patch "virtio-net: Do not propagate ebpf-rss-fds errors".
- Added patch "virtio-net: Shrink header byte swapping buffer".
- Rebased.
- Link to v8: https://lore.kernel.org/r/20231210-rss-v8-0-9553ee714d38@daynix.com

---
Akihiko Odaki (20):
      tap: Remove tap_probe_vnet_hdr_len()
      tap: Remove qemu_using_vnet_hdr()
      net: Move virtio-net header length assertion
      net: Remove receive_raw()
      tap: Call tap_receive_iov() from tap_receive()
      tap: Shrink zeroed virtio-net header
      virtio-net: Do not propagate ebpf-rss-fds errors
      virtio-net: Add only one queue pair when realizing
      virtio-net: Copy header only when necessary
      virtio-net: Shrink header byte swapping buffer
      virtio-net: Disable RSS on reset
      virtio-net: Unify the logic to update NIC state for RSS
      virtio-net: Return an error when vhost cannot enable RSS
      virtio-net: Report RSS warning at device realization
      virtio-net: Always set populate_hash
      virtio-net: Do not write hashes to peer buffer
      ebpf: Fix RSS error handling
      ebpf: Return 0 when configuration fails
      ebpf: Refactor tun_rss_steering_prog()
      ebpf: Add a separate target for skeleton

 ebpf/rss.bpf.skeleton.h  | 1558 +++++++++++++++++++++++-----------------------
 include/net/net.h        |    8 -
 net/tap_int.h            |    1 -
 hw/net/e1000e.c          |    1 -
 hw/net/igb.c             |    1 -
 hw/net/net_tx_pkt.c      |    4 +-
 hw/net/virtio-net.c      |  344 +++++-----
 hw/net/vmxnet3.c         |    2 -
 net/dump.c               |    4 +-
 net/net.c                |   47 +-
 net/netmap.c             |    5 -
 net/tap-bsd.c            |    5 -
 net/tap-linux.c          |   20 -
 net/tap-solaris.c        |    5 -
 net/tap-stub.c           |    5 -
 net/tap.c                |   77 +--
 tools/ebpf/rss.bpf.c     |   44 +-
 tools/ebpf/Makefile.ebpf |   15 +-
 18 files changed, 988 insertions(+), 1158 deletions(-)
---
base-commit: e5c6528dce86d7a9ada7ecf02fcb7b8560955131
change-id: 20231210-rss-e7c98e722253

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


