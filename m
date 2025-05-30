Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C69C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 04:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKrWc-0006qc-6U; Fri, 30 May 2025 00:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrWW-0006pg-Cr
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:39:18 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrWU-0006pY-5k
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:39:15 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2353a2bc210so1284825ad.2
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 21:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748579952; x=1749184752;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g93UHfmzGSUi2P4D53EI7wH/bZ+U0fCqCloZPWzqa6k=;
 b=X1wsWfAjv/CHUTIlZBos124BIO10PMluw5h/1ZVbWRgdcNm1kYovCs2luE/6iO+ULU
 zItLVbfKqYw++lR7PglAMHivYtBecCwI/odZvv/t1h8qthmNXnkDEcN9ZszbMN/+QZuu
 g+20Uowa1Qq2UhHaLs52VGDQyFAZzLrBvqGuQE7lxZ64w3O9L4WjmJu9lKZ7fdCEdcKx
 mMHMASysSzHiXUFczlWcq7PvJIfS26mdaJrIz2cHEStYROlPDVp07dgH/LKsu0Kp/ZN0
 3Xrv5VmsOjWEDMfb8+QxqSKQdOPvV2F5dC1KfxawvLeLigVO4X2EBUR15tv7RUIBZuzD
 RkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748579952; x=1749184752;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g93UHfmzGSUi2P4D53EI7wH/bZ+U0fCqCloZPWzqa6k=;
 b=JC9sTNiZP5satehzlSDs5Tnm0rStSCU0X3L+Iei2liiFT9HSPbUOhP1gqaxghZm8U/
 hrMBDJPYCI2YC2S8qpsWeooD5HqAZEutzVaUjPYSNs9/9CsloxWscR6QlDXD6sLX8vqA
 xotxCUUSOF3paZrDvOFz1pmRRoLC0t2Y/PqjGtXbx4wH+ZEvgvUxoW/tta4r9Y008PC7
 jV48s1c0Kt6BYqBfZAxp0245TFVm43ILtvjBie+JNVVDoqhAMQkXfId+ii00hYgp75jT
 qnRfMtC5lGmuAptOjNiq4fzubuypYbEX0t5blDR15FMt04KV4vDvYvuUrA7Ud/csx6RT
 tbLw==
X-Gm-Message-State: AOJu0YwDKljLzv6BFV76KEfMCBMSW2UZoH0kAsNRqLFpVU4oKZlrewGv
 +3WoHRSRPe4G6N4WRZCJThOJSiXkhEZK7HyIm/nxHsDJ2JJtxaxK1xzk7VlEYbzCtYI=
X-Gm-Gg: ASbGncvNEMpMDTVFf7bzUDaG2/kK4YuUE6lpiVpanCO0svYyHfjwjx0akAMrT1meqyB
 dNC0bR0o3lvcqVbTiXdir4wGlHNxrRVfkB6U009qScUaMRKwF7JK8jvKG+V5Oj7wCzhqSUJfOMZ
 F2yGxD0lWwyevRl+mf7di/Jy9S/qRguryx47lDVt4HXx71EgDFAheluSNyBYYyMozxVk5RKeMUg
 CQKouh4JIdASrqu9J60HGeQXk+RXpOp2W4b74I8gVf6p9ruN9bZE89bVPr5lzyxfhp33J11DhVs
 vM4+HiueqDtwflszqMFffOgYPMhqVL1lJFUJGdEisEe8c3V79jsH
X-Google-Smtp-Source: AGHT+IHeimaAZHgA7e2aofEPOtICHS4Jzw6CEOpgSvMBhigtPjQUmWlovEqez0USbmT/lggZNaKFWw==
X-Received: by 2002:a17:902:fc47:b0:234:ed31:fc9b with SMTP id
 d9443c01a7336-2353969465amr13297595ad.36.1748579952426; 
 Thu, 29 May 2025 21:39:12 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23506cf9181sm19903865ad.187.2025.05.29.21.39.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 21:39:12 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RFC v5 0/5] virtio-net: Offload hashing without eBPF
Date: Fri, 30 May 2025 13:39:08 +0900
Message-Id: <20250530-hash-v5-0-343d7d7a8200@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGw2OWgC/1WPzU7DMBCEXyXyGSP/7MabnJCQeACuiIP/QnxoU
 uJgtar67hi3IHGc3Z1vZy4sxy3FzMbuwrZYUk7rUgU+dMzPdvmIPIWqmRIKBCnis80z7xVpNVj
 AAIHV0+MWp3RqmDf2+vLM3utwTnlft3NDF91WjTJIvFGK5oKbwTtBQVEP5inY85JOj349NEKBX
 xcKLfXdBdXlDXoYwMGA8Z/rekuzxc+v2mW/R/qrMnYNhlrwEo6WKw8kfQ8+Ao5F/nRxNkdeWYe
 0j90kjDYSyQHpaKJXTqFUEtBG64jIEXovJ1MfX78Bb6EiikwBAAA=
X-Change-ID: 20240828-hash-628329a45d4d
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>, devel@daynix.com
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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
Linux. This series contain patches to utilize the proposed Linux
feature. The patches for Linux are available at:
https://lore.kernel.org/r/20250307-rss-v9-0-df76624025eb@daynix.com/

Note that the referenced patches for Linux implement UAPIs that are
compatible with older versions of this series but not compatible with
this version. Compatible patches for Linux will be posted shortly.

This work was presented at LPC 2024:
https://lpc.events/event/18/contributions/1963/

Patch "docs/devel/ebpf_rss.rst: Update for peer RSS" provides comparion
of existing RSS mechanism and the new one (called "peer RSS") and
explains how QEMU selects one.

---
Changes in v5:
- Changed UAPIs.
- Rebased.
- Link to v4: https://lore.kernel.org/qemu-devel/20250313-hash-v4-0-c75c494b495e@daynix.com

Changes in v4:
- Rebased.
- Added a reference to the documentation to the cover letter.
- Link to v3: https://lore.kernel.org/r/20240915-hash-v3-0-79cb08d28647@daynix.com

---
Akihiko Odaki (5):
      net: Allow configuring virtio hashing
      virtio-net: Offload hashing to peer
      virtio-net: Offload hashing without vhost
      tap: Report virtio-net hashing support on Linux
      docs/devel/ebpf_rss.rst: Update for peer RSS

 docs/devel/ebpf_rss.rst | 22 ++++++++-----
 include/net/net.h       | 13 ++++++++
 net/tap-linux.h         |  4 +++
 net/tap_int.h           |  4 +++
 hw/net/virtio-net.c     | 84 ++++++++++++++++++++++++++++++++++++++-----------
 net/net.c               | 11 +++++++
 net/tap-bsd.c           | 15 +++++++++
 net/tap-linux.c         | 16 ++++++++++
 net/tap-solaris.c       | 15 +++++++++
 net/tap-stub.c          | 15 +++++++++
 net/tap.c               | 23 ++++++++++++++
 net/vhost-vdpa.c        | 13 ++++++++
 12 files changed, 209 insertions(+), 26 deletions(-)
---
base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
change-id: 20240828-hash-628329a45d4d
prerequisite-change-id: 20250530-vdpa-2c481c64ce45:v1
prerequisite-patch-id: a8c36f25d07b2b1a658ec3189bdf8bf12ef5ce8d
prerequisite-patch-id: 414474fbb325338338f2d84f7065be241c27df2b
prerequisite-patch-id: 6db7f777008d6d1fae86df2a1fffcd2ddb394e05
prerequisite-patch-id: 762aad5a811163b3d9326870bb751fbe7853c21c
prerequisite-patch-id: 9dfcea59addbdebfc1cc8fda26c91ebf21482d21
prerequisite-patch-id: 3d391c14efe64541a881421735cf9ff04bb69713

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


