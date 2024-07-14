Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06C4C41513
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 05:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSrVw-0006yR-Hd; Sun, 14 Jul 2024 01:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSrVu-0006xL-Rb
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 01:11:10 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSrVs-00051C-Jq
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 01:11:10 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70b2a0542c2so3169123b3a.3
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2024 22:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720933867; x=1721538667;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RSPrhxEhQKA/0w6BTEQ/Sy6w8AkhZv2My8X9gMc1XN4=;
 b=aaq001Zvs9H1mH/eE8R/PjfSMmBywjZ6BWsja2bU/ZobkE/UoTpvi6w6j+pKRYRROt
 A1zRyYO2ef0txBxiv7dORaEYjQF1gc/cMZxA+tZsgAiaeGcoIh54UJDMmBc8PceXEAzt
 Zj8T8Myw+ZjDEkUTYjZ1CYIZW+RHPbA3OJ9YEDNM+iHEz0fODv5tcSdvf/pMROZldZwN
 v8fJqgyyBXHpXs7EPtyXp4skNdkHYghyqNaKTun0WI9jVa9Tr77IxOyXwbztmjZKN5BV
 0q16PihgkNSzviZK1dCooq0c2tl4OwDBt2L0SN90k7eqs1NMSmn2SEMHmE9Q0hhngSyw
 5uKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720933867; x=1721538667;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RSPrhxEhQKA/0w6BTEQ/Sy6w8AkhZv2My8X9gMc1XN4=;
 b=TnBvkfAycnvUcI3RsB60jMmEOdsdquCp8e8B9O2AqWMWtuKlXmlRXFSd/1GzZqC+lx
 dfC+U20iHqZBKHmmmlw7J8HXIQNZTpkCdZ4zFAjo5+M/hYW/lEDUEvYb8bLo22APZ60c
 N+4S4brcCkhmu31fBqljlxvf0tzkv3NgYYT/nMkLrRlWO230AiVVCRtUSgwKXMEmxW/c
 I85iDn9sgMlql6rHssq2Gt8l/8BQFQIdRGEJ5T26umkFpZiyi1DSTPx+0nyc8ALLT9x1
 QMpoyZPa38nPq65dzJQc7VC0cyk1xnxrNHg7jPFNEibApoCVeDCrSsATxV/7SPmamQ4c
 DSEQ==
X-Gm-Message-State: AOJu0YyKfohhAES21S9a7hVwdN49/ZOekK6jGzvRSP4xrILUJvWZSHBe
 BC9PCEAOcdVP2XB1nGlb8Avh0cMpIKNtsrrj7fS9nb3k8mPKPi/Ia7NxO9rwbwA=
X-Google-Smtp-Source: AGHT+IFV1S0qIAIT+mgyCMaTpTsiSwKNkD0Y5eW9lRYOtcNiaAbnY/qwdsuaFW3E8wzG4nm6rZJimQ==
X-Received: by 2002:a05:6a00:3392:b0:70a:efd7:ad9b with SMTP id
 d2e1a72fcca58-70b4356bf0dmr19213407b3a.17.1720933866923; 
 Sat, 13 Jul 2024 22:11:06 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70b7eca7941sm1986376b3a.157.2024.07.13.22.11.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Jul 2024 22:11:06 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/5] virtio-net: Convert feature properties to OnOffAuto
Date: Sun, 14 Jul 2024 14:11:00 +0900
Message-Id: <20240714-auto-v3-0-e27401aabab3@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAORdk2YC/12MQQ6CMBBFr0Jmbc10AAFX3sO4KG2RWUhNiw2Ec
 HcLiTG6fD//vQWC9WwDnLMFvI0c2A0J8kMGulfD3Qo2iYGQCiyoFuo1OtFaNBolGqNKSNentx1
 Pe+Z6S9xzGJ2f92qU2/oXiFKgqFqURPKkJOHFqHng6ajdA7ZCpK9V4ceiZHVFg3XblHmH5Y+1r
 usbgTbsus8AAAA=
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

Some features are not always available, and virtio-net used to disable
them when not available even if the corresponding properties were
explicitly set to "on".

Convert feature properties to OnOffAuto so that the user can explicitly
tell QEMU to automatically select the value by setting them "auto".
QEMU will give an error if they are set "on".

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v3:
- Added patch "qdev-properties: Accept bool for OnOffAuto".
  (Michael S. Tsirkin and Daniel P. Berrangé)
- Changed to report errors with ebpf-rss-fds (Daniel P. Berrangé)
- Link to v2: https://lore.kernel.org/r/20240708-auto-v2-0-f4908b953f05@daynix.com

Changes in v2:
- Added patch "virtio-net: Remove fallback from ebpf-rss-fds".
- Added a compatibility property.
- Corrected property type name.
- Link to v1: https://lore.kernel.org/r/20240428-auto-v1-0-7b012216a120@daynix.com

---
Akihiko Odaki (5):
      qdev-properties: Accept bool for OnOffAuto
      qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
      virtio-net: Convert feature properties to OnOffAuto
      virtio-net: Report RSS warning at device realization
      virtio-net: Remove fallback from ebpf-rss-fds

 include/hw/qdev-properties.h   |  18 +++
 include/hw/virtio/virtio-net.h |   3 +-
 hw/core/machine.c              |   1 +
 hw/core/qdev-properties.c      |  83 +++++++++++-
 hw/net/virtio-net.c            | 290 ++++++++++++++++++++++++-----------------
 5 files changed, 274 insertions(+), 121 deletions(-)
---
base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
change-id: 20240428-auto-be0dc010dda5

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


