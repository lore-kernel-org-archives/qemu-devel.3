Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9C3C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 07:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0yqj-0001A0-SK; Sun, 28 Apr 2024 03:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yqi-00019m-0Z
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:21:24 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yqf-0001Cm-BW
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:21:23 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f2f6142d64so3321734b3a.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 00:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714288880; x=1714893680;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jNIT7gtsr29GM2REpXWWVAlBuCapXxxd/84JtZZGwBA=;
 b=P9toNoIKbB5p+2cgLzWOvM/GYqn6stxS2k5X3k6uFPs5F00lKBKLhGyJdDeGYtWMfa
 QpJjQLlBuVH6SV2ykJ4Xjq9CKhkS6YBe7XWrBTk/J87zZSElEMShXhUdPlS1Ju1yI06l
 l4Q10ypJ7+JYlgMb5xpR9+8FjoeoUsTfry7itOegmWyuffQZvTdJuWKkwcR1pf9ydTKC
 VUuJ4Zsp/4kfyGoOSJJSLIjkIj3mmzmJg2LS0pPjgnboinXkh471BPK22pSYtMKN2OIO
 1EcsvvRiwyQLfh+IKzuvSnFqJVZVjJ19uB+94BuHHujAOW9FyYlnx3duCVIHtGl8qXUK
 4qSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714288880; x=1714893680;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jNIT7gtsr29GM2REpXWWVAlBuCapXxxd/84JtZZGwBA=;
 b=U5SSpwP6t8NCx27sMZdpBcbQDU0gsWTnVzyWQ1kKoIDiD7j74xoJ5RTzUoUUpe5bVE
 mjzqSujmPNQ2USs1ivYQ5zWBhdCxeXvc2e5SRGWhLCPm7k5AaoYZFS3hz+suZE0sqbVp
 2haefzezFXvgxtqY5tizWXktmvLsk2jzHIY0b8MFvbkGTDSzzJlrmu97oUDv8wKPYfEs
 FlEC5IBe7EX2psxinmA0O1BDqwbhJ3U+CKJBB3fSv5BB6vOp5Vc5HpcldnE4zF9bnMOH
 YtbkOM3V300XDcRPonne0C8hPUVUUDFgWWMwEmlvu2fyQYNRaapbiTc/xxegUoX5gqZB
 q1Fg==
X-Gm-Message-State: AOJu0Yw+A5YpYJr30CQE6wVV8XeJgY8OaSmsV+WK8fqKE98uKDSlNEWP
 CWSIZ6mPsGCP88UxkUULVsi0GHAA7mUYTZhmdUzQwmt94ae/V9o4BmTrg/EmQi8=
X-Google-Smtp-Source: AGHT+IGmhR1ZNI84dQ0/Algl+Qj+ov0/kvOYn+o+Bz4uvnhEj04WGbgIPp7pgm40S+yq+e4HV2oAOg==
X-Received: by 2002:a05:6a00:a8c:b0:6ea:c2a2:5648 with SMTP id
 b12-20020a056a000a8c00b006eac2a25648mr9293745pfl.3.1714288879823; 
 Sun, 28 Apr 2024 00:21:19 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 ey14-20020a056a0038ce00b006f27e986e84sm12962239pfb.158.2024.04.28.00.21.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 00:21:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/3] virtio-net: Convert feature properties to OnOffAuto
Date: Sun, 28 Apr 2024 16:21:06 +0900
Message-Id: <20240428-auto-v1-0-7b012216a120@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOL4LWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEyML3cTSknzdpFSDlGQDQ4OUlERTJaDSgqLUtMwKsDHRsbW1AOSaXa1
 WAAAA
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
Cc: qemu-devel@nongnu.org, 20240428-rss-v10-0-73cbaa91aeb6@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
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

Based-on: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
("[PATCH v10 00/18] virtio-net RSS/hash report fixes and improvements")

Some features are not always available, and virtio-net used to disable
them when not available even if the corresponding properties were
explicitly set to "on".

Convert feature properties to OnOffAuto so that the user can explicitly
tell QEMU to automatically select the value by setting them "auto".
QEMU will give an error if they are set "on".

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (3):
      qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
      virtio-net: Convert feature properties to OnOffAuto
      virtio-net: Report RSS warning at device realization

 include/hw/qdev-properties.h   |  18 +++
 include/hw/virtio/virtio-net.h |   2 +-
 hw/core/qdev-properties.c      |  65 ++++++++++-
 hw/net/virtio-net.c            | 259 +++++++++++++++++++++++++----------------
 4 files changed, 239 insertions(+), 105 deletions(-)
---
base-commit: ec6325eec995018983a3f88f0e78ebf733a47b7e
change-id: 20240428-auto-be0dc010dda5

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


