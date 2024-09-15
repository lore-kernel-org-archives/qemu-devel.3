Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B622DC35FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spe04-0002Vy-6Y; Sat, 14 Sep 2024 21:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe01-0002VO-O2
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:24:25 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spdzz-0005Qi-MJ
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:24:25 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71923d87be4so1527144b3a.0
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363461; x=1726968261;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mUoXegguz70cN78pSn5Nu/1+Slky6PRyeNuaO5Bjsrk=;
 b=Rig9dcdlIE7WbglAwd35OB7qPdoSGFBDuzhx687eQXHlRWRVtBQd7ilo7AbsHeTCCi
 3sdIEaLmDMOBv4tXa6OB/5/SmXkyAM5tJ4loyfNUCRZbJ4yTVfXRtVCHbejdcop9S5GB
 iVLbaI1XnnFVUBEX/lA9QPny3aD1KFa1QmZiCOPrUQKU9ZNTZvduGhv/1N3S5k1EONOS
 Doo4CDgGtISTpzY/5QE3J7mDK0+If9DbK/J8bdqj1mzXn/yj8XosCdp3RMZ/vVUszUNl
 XiGfFbnycZmL59ngHJTohvmOLP40zvdx1hhxiCPNIECKcE91l4D6Kn/FD0YdTQco6xLI
 ClCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726363461; x=1726968261;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mUoXegguz70cN78pSn5Nu/1+Slky6PRyeNuaO5Bjsrk=;
 b=VH95bbCuXeyQT+xWPhmcSHRzHBxJBJVECcpczqpxyXomG9ivXboF6Vthg+ImcLJJJ9
 LAXZgTZB34O1xcedUjbRlzdgd7IRnujIx6LH0cp8dBFjIogWOObFL/HivfPZtd9Y8tx3
 1dS7fcki/7d69KTqRhrvgrXmFrhN4AdNIh7cbPgK37UKvXxN5IBoYOAAAweUxNhe6w0l
 uwVrP33CIz9i5MqcK17TogpgxAu171Zzs7PTCShu7r7NIm/ZgDmryjfxP2Hu73JXb9O5
 +0x3LNkfTlaEYR3Z6u/Z8hNh0WZ05sCgnvMotCCrrhnTT9LNGqkYEP5RgGBYqryqJS2t
 aYrw==
X-Gm-Message-State: AOJu0YzfiI10z2Z/AxLJ4Itq7Kn+FFYAR5O4DMCnTy4X4Z6y2f91+MpM
 Fwau/gu5+hNWdCpmKN+3T6IDjxoneFDlH54U7KLB0nZlugo38fzspSX0BgBFxeeJRS8Nj32b/tW
 NXQY=
X-Google-Smtp-Source: AGHT+IFnQu39Y8AR3vluVy08+1nLZIh4vnlMvjRktX5D6qqv1xOc5oy4+4BWRELfKtgIo8BNVbugMg==
X-Received: by 2002:a05:6a00:1799:b0:714:1bd8:35f7 with SMTP id
 d2e1a72fcca58-71936a60297mr10353064b3a.15.1726363461195; 
 Sat, 14 Sep 2024 18:24:21 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-71944bc7bcbsm1517670b3a.205.2024.09.14.18.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:24:20 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RFC v3 00/11] virtio-net: Offload hashing without eBPF
Date: Sun, 15 Sep 2024 10:23:41 +0900
Message-Id: <20240915-hash-v3-0-79cb08d28647@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB035mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyML3YzE4gxdMyMLYyPLRBPTFJMUJaDSgqLUtMwKsDHRSkFuzkqxtbU
 AGvYp0lsAAAA=
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
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

Based-on: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
("[PATCH 0/7] virtio-net fixes")

I'm proposing to add a feature to offload virtio-net RSS/hash report to
Linux. This series contain patches to utilize the proposed Linux feature.
The patches for Linux are available at:
https://lore.kernel.org/r/20240915-rss-v3-0-c630015db082@daynix.com/

This work will be presented at LPC 2024:
https://lpc.events/event/18/contributions/1963/

---
Akihiko Odaki (11):
      qdev-properties: DEFINE_PROP_ON_OFF_AUTO_BIT()
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
 hw/core/qdev-properties.c      |  66 ++++++++-
 hw/net/virtio-net.c            | 327 +++++++++++++++++++++++++++++------------
 net/net.c                      |  14 ++
 net/tap-bsd.c                  |  10 ++
 net/tap-linux.c                |  18 +++
 net/tap-solaris.c              |  10 ++
 net/tap-stub.c                 |  10 ++
 net/tap.c                      |  15 ++
 net/vhost-vdpa.c               |  41 +++++-
 15 files changed, 473 insertions(+), 110 deletions(-)
---
base-commit: decf357a35b1201b34cc37c47b4b027f9601855e
change-id: 20240828-hash-628329a45d4d

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


