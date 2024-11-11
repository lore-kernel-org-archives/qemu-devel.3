Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088F5D12D78
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 06:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAO6j-0006lV-9n; Mon, 11 Nov 2024 01:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAO6S-0006j5-0U
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 01:40:49 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAO6P-0000eL-Nt
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 01:40:47 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20c693b68f5so42156815ad.1
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 22:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731307243; x=1731912043;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d8EInCBInFT9bMPoGZ81egh/E5CE0qOVnR6CTtbGXQA=;
 b=naO4sDDoA1EOJkLGsmyG8GbMGAzvduSbs2+6oFfCy3a067q7RFLldsc5hAyTpGLpKx
 zL/b9Zhgr4CQ3AfJL4wjP2Em5vFxqKLE8KDrhIWKPfeqhg1/PCdwwvFsTp1RRnFCaDUP
 DV0M+eIpylPOF7qjVdQ9jEa86VCdymGm0T8uTFPvoW7UMDPRrh9AgzOGtC1HhBedCR4C
 Xl0sJECWEVc/lWnNcJewOS+MNB96oAuOr5qKctZSQZcTdhgAJOpLyRMUf4hqyBUV0FOw
 8j6lZqqP+OBPcmmZSoVwm4pUkbwkGbHRZGpnEzpXAm81VefjlcM7ZJdcglhAymuL8GmM
 DsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731307243; x=1731912043;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d8EInCBInFT9bMPoGZ81egh/E5CE0qOVnR6CTtbGXQA=;
 b=gz21bWXAhmNE88Mqomn7+3c7kbLgUMZFLBw7Y8dikLOZwLvOcP3ZRdvUcivGxDQEO9
 NjDyDm3dGR2En24nn/T+OpLwic5oHXpj7r+S3a0yQnw/gzfi0By6IjcybNccv7QTqmpM
 8RIoSonCwldy8dd8vF3ngnV54QTTtTORbr7Z0xNIGUPEnPK3yh/p4NsnuLHEzF+KXhJ7
 ERfKlCthIf+bO0ed1cAYV15lxuRBbuy5YgNiu2KA6Z3GkEIY6P0/sQaPUD8QtpE7f224
 z3QHXKdIjbnfPEuCiB/F+UNjMbcFN+df3CBangOcEWrvEUgNW1JiXRtxvUMRLc4wympO
 9Y+w==
X-Gm-Message-State: AOJu0YzhU1wkt1JrzaDIE2z48NkWyug8lwuOSomVg57HRucfBe1Dtj/9
 UVaoMd1z0vHXKH95BloqgbsZa3L15WIIT7yfYNU7uu473UNqzeCJIA1qSQ28J+s=
X-Google-Smtp-Source: AGHT+IFZqCM70kzWoSmN5/3+XyUY32emKQ8Vlw76RaTRJOYPU6rGuPenp6M9X0HCyCH4PCZBVS/Jdg==
X-Received: by 2002:a17:90b:4d07:b0:2e2:bd10:599d with SMTP id
 98e67ed59e1d1-2e9b16950d9mr15904624a91.11.1731307243289; 
 Sun, 10 Nov 2024 22:40:43 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2e99a541da0sm11103276a91.13.2024.11.10.22.40.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 22:40:42 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/6] virtio-net fixes
Date: Mon, 11 Nov 2024 15:40:17 +0900
Message-Id: <20241111-queue-v2-0-2f7883a1004f@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANGmMWcC/y3MQQ6DIBCF4auYWZcGEEvoqvdoXKgMdRaVCpVoD
 HcvNS5m8U9evh0iBsII92qHgIki+amEvFQwjN30Qka2NEguFTdcs3nBBZlTsjG17nTNHZTtJ6C
 j9XCebemR4teH7WCT+H9PQTSnkATjrFemt+WMvNmH7baJ1uvg39DmnH9D+w7ImwAAAA==
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

Most of this series are fixes for software RSS and hash reporting, which
should have no production user.

However there is one exception; patch "virtio-net: Fix size check in
dhclient workaround" fixes an out-of-bound access that can be triggered
for anyone who don't use vhost. It has Cc: qemu-stable@nongnu.org and
can be applied independently.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Dropped patch "virtio-net: Fix num_buffers for version 1" in favor of
  fixing the spec. See:
  https://lore.kernel.org/r/CACGkMEt0spn59oLyoCwcJDdLeYUEibePF7gppxdVX1YvmAr72Q@mail.gmail.com
- Added a Buglink to patch
  "virtio-net: Fix hash reporting when the queue changes".
- Rebased.
- Link to v1: https://lore.kernel.org/r/20240915-queue-v1-0-b49bd49b926d@daynix.com

---
Akihiko Odaki (6):
      net: checksum: Convert data to void *
      virtio-net: Fix size check in dhclient workaround
      virtio-net: Do not check for the queue before RSS
      virtio-net: Fix hash reporting when the queue changes
      virtio-net: Initialize hash reporting values
      virtio-net: Copy received header to buffer

 include/net/checksum.h |   2 +-
 hw/net/virtio-net.c    | 108 +++++++++++++++++++++++++++----------------------
 net/checksum.c         |   4 +-
 3 files changed, 63 insertions(+), 51 deletions(-)
---
base-commit: 7e3b6d8063f245d27eecce5aabe624b5785f2a77
change-id: 20240907-queue-f425937a730f

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


