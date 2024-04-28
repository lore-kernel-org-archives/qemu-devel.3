Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6CAC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 07:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0yWv-0002JL-DL; Sun, 28 Apr 2024 03:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yWt-0002J8-TG
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:00:56 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yWr-0005MB-Ne
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:00:55 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f3fde125ccso120471b3a.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 00:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714287652; x=1714892452;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=blwYL7oSLYksahYUvT4MIm0+Dd7aR+c9ZIVfyNqVTOQ=;
 b=WOuC3t8Htp8vgd/6N58nvun24VL+HrmoLfC1L3+CYlsxFD4zbmJ4/2fu33gq1ZksiO
 xa38KC0rytCISXhaFTxNNvMoyzW7cN/uBe6H6wH/yNSOfkmze/hp5u6saW2uKQiSGpLe
 vORm9g+qeSkJYo1wKaxFSA+I7inZu/AR21MXHsvDXaMyrAwtWUX2fTmmgwTauUaaiHSh
 kd37icdl+eRCeRFS/LQoNWzqa5q0mQBPRPiXF3KmLzZUeK4KFvXmANS/Ia8UwJgqptIL
 Dub35+4ZMcFqgtiXPw2KLb8x3rUOAsCnkb05YSbsby2AJcU9SqoCPZuKoiqLUCpY8Q7R
 ee9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714287652; x=1714892452;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=blwYL7oSLYksahYUvT4MIm0+Dd7aR+c9ZIVfyNqVTOQ=;
 b=MzwzwM6oxIadwgh9I2mSmw6vyy4sXblK2V2L9aRiGNlSpylEdG8fBypmfiAQ8C3ene
 pJq6GKbtUKSnIMdNOQ2uUo63UHTz9l12WI6V2v6j7DqmNEw9PuWeuKFFBVfdrUWEsMWM
 tghwgQVTh24sEQHBlPvZDY1jGB8rlKjZq8BdX1jLYypPYwiK/9bhiCO/cvEDg3vXswo0
 qjFjRZX39HJMAaprCVcTJz+w24cmzJOBq7SVFKegu52tkRfBqjCj646c7fYQDJjLEBli
 4OozL7GynoTv5poIyrc3xfzrkiDcCvK50fM6L8dKC8NyJFof6B8xk2mBbf2/8YcjHVXx
 A6YQ==
X-Gm-Message-State: AOJu0YxkZDo5U8kCdyoK/vqukrUJGN7nz82LY3iMPEaDgnY3ssYSV4/5
 eHRCV4XnrhLI1AOcgnBMEA06Qc1+rmTvQt62VSwK0XM9NvnlPu2G2UGPx732HTs=
X-Google-Smtp-Source: AGHT+IFl8USBjdwTWT624+nQJTvj8SEFnCg5PT6q4q3D3XP0rX7sPVZY1VYnk0oFSccXYpjmTBDCfA==
X-Received: by 2002:a05:6a00:170a:b0:6ed:d47e:625d with SMTP id
 h10-20020a056a00170a00b006edd47e625dmr8374619pfc.30.1714287651874; 
 Sun, 28 Apr 2024 00:00:51 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 13-20020a056a00070d00b006e69a142458sm17181252pfl.213.2024.04.28.00.00.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 00:00:51 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v10 00/18] virtio-net RSS/hash report fixes and
 improvements
Date: Sun, 28 Apr 2024 16:00:43 +0900
Message-Id: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABv0LWYC/1XMzQ6CMBAE4Fche7amf9DWk+9hPGC7yh4E0poGQ
 nh3C8YDx5nMNwskjIQJLtUCETMlGvoSBD9V4Lu2fyGjUAqQXCohBWcxJYbGO4tGSlkrKMsx4pO
 m/eZ2L7mj9BnivL9mu7VHny3jzNW1QjRCB2WvoZ17ms5+eMN2kN0faa65+iFXkG+CNdi4Yh4Ht
 K7rF4ENIOXNAAAA
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 "Zhang, Chen" <chen.zhang@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
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
Changes in v10:
- Dropped an obsolete statement of patch "virtio-net: Do not write
  hashes to peer buffer". (Yuri Benditovich)
- Dropped patch "virtio-net: Return an error when vhost cannot enable
  RSS" and "virtio-net: Report RSS warning at device realization".
- Link to v9: https://lore.kernel.org/r/20240403-rss-v9-0-c6d87e69d38b@daynix.com

Changes in v9:
- Added patch "virtio-net: Do not propagate ebpf-rss-fds errors".
- Added patch "virtio-net: Shrink header byte swapping buffer".
- Rebased.
- Link to v8: https://lore.kernel.org/r/20231210-rss-v8-0-9553ee714d38@daynix.com

---
Akihiko Odaki (18):
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
 hw/net/virtio-net.c      |  264 ++++----
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
 18 files changed, 948 insertions(+), 1118 deletions(-)
---
base-commit: e5c6528dce86d7a9ada7ecf02fcb7b8560955131
change-id: 20231210-rss-e7c98e722253

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


