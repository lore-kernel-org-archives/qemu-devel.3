Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89C6C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4XF-00028c-ER; Thu, 06 Mar 2025 01:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tq4XC-00028M-Ri
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:16:42 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tq4XA-0003Ut-AF
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:16:42 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22355618fd9so3813065ad.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741241797; x=1741846597;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vKVPkK6RGouYGT6PzP93MOS62t8/ijRTB8K4FZLswIs=;
 b=ghoSeY16mTu+uGlmQH4auRmgQBB5iV5Mlpg5ejUQcwIDoP6LGX3xHQ3NEDZhZYY50R
 mMI9igqEcCYuG68oqWuKNLAM8n7aTC8vFYWhyHr4SCg8ADSwXp6KW2g+pmcA1EtiwQvV
 94V3eqHSennelj/bYbjwGMl6xOzJ27olrV0r8+7vQgErHyJVxc/SlMUsxGTq4kJBzH+g
 xqQVvispTQT7nu8ec+jgKicq/ku0dvnYbf+kVXc9o4ETiFCYFEu+3JKXemLM6mPbvFD6
 07eU5k+6P0pe+3IeeAfYWdye9cXJiaTZqVNx9HONYS/vh2Vn/QVU1peT/4pb5ZbSGkW9
 YcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741241797; x=1741846597;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vKVPkK6RGouYGT6PzP93MOS62t8/ijRTB8K4FZLswIs=;
 b=Y4eJsz8tBqiZv0gN9+q6QYWKJdV7985b3sRInyzvXyTKRc4mWs3B9oCf+0lSW4bZAU
 8L4xRPvxD/Ih5t4df7gJPAzGDy81/W1tlsT5bWsrrvjlBXJxqY8/6u6FYCUpfd8eodgU
 h1eF77kxQouRGo208Qd6/zwMvFH+TaaPCdt7RQ3faEQkuxX5YMfEATrmaFMqLxqlNkQ6
 DASFPH5jwvkgOHQBhT8ZUhSOBKYBwjKp6aRkOcZGXB2ownQ6sOYy6X99sLgCl1Q3t1zX
 Vmy1Kd8O63H3wt0yIqzd9VpLWKvbtKGmtjghMbXBhHu3mou+d3JD1vrp2P/2T+ijs2sf
 jc7Q==
X-Gm-Message-State: AOJu0YzEQOMFE9nBDX2G87lp4omizpQH+h7jzzwkkFIyQViKsP8Ch79i
 JjP7pO/xcdSNE6lddJMciqtwXui8RlQ6x7/fFN+Y3t7uucyU8Q/UkU31Gf+Nc6g=
X-Gm-Gg: ASbGncs1BHyO4E/M4WNd4QT5/4DH8NO6YmNo7hF8tqYRXO6hcZbW6ugBZdh49ira/fa
 VcOXb4mnAnnqgnkzi94fMFCHl6qCjDc73N4czymXsO3m8A9DD5hp8jSjQ4DODmTHC3dOU9kF0Gx
 U+VE9sanVcMl6ExxZlqoy67pHIKqyFvdxX2k+WoUSFNBPQLpG/A5fKpNhb/UpUWUNAFkf+WMaND
 WoX1aULNMUBlySlkfqaMVTVeU1UTNLPd+BdBGb9aK7yM4ARxAURY8fKeozmtnEIjcPITpYvQjN5
 u2IwlFJKbf9TlFDwStcKAQ5wdai4qAm3QgIqREvWNBqtsPeQ
X-Google-Smtp-Source: AGHT+IFSuzeHw70UQjZcVDmOeSWpzqywpYEMjS+YtPR0cwHee4Oe32K0Gmk/7s7XQbSgM/902TFQ6A==
X-Received: by 2002:a17:903:41cb:b0:216:3466:7414 with SMTP id
 d9443c01a7336-223f1d397ecmr116303965ad.44.1741241797039; 
 Wed, 05 Mar 2025 22:16:37 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7369844cfd8sm498323b3a.83.2025.03.05.22.16.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 22:16:36 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 0/4] virtio: Convert feature properties to OnOffAuto
Date: Thu, 06 Mar 2025 15:16:26 +0900
Message-Id: <20250306-virtio-v6-0-1235eab776d9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALo9yWcC/2XNQW7DIBCF4atErEs0zAA2XfUeVRcYDw2L2hGOU
 KLIdw+x5MSVlw/x/XMXE+fEk/g83EXmkqY0DnXYj4MIJz/8skx93QIBtQJFsqR8SaNUVrOniM4
 EEvXzOXNM1yX0/VP3KU2XMd+WblHP1zWh10RREiS7vo+Nb1Xr1Ffvb0O6HsP4J56NghuH+HJYX
 YfkNJJlMLRztDoDCt73qDpLHBtYru6d3rr25XR1oYvgPejgots583a4caY6TY0NHao2QPzn5nl
 +AGENRPF9AQAA
X-Change-ID: 20241013-virtio-164ea3f295c3
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
 Eduardo Habkost <eduardo@habkost.net>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Lei Yang <leiyang@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
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
Changes in v6:
- Rebased.
- Link to v5: https://lore.kernel.org/qemu-devel/20250208-virtio-v5-0-4376cb218c0f@daynix.com

Changes in v5:
- Covered QAPI more than just qdev.
- Expanded the description of patch
  "qapi: Accept bool for OnOffAuto and OnOffSplit".
- Rebased.
- Link to v4: https://lore.kernel.org/r/20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com

Changes in v4:
- Added patch "qapi: Do not consume a value if failed".
- Link to v3: https://lore.kernel.org/r/20250104-virtio-v3-0-63ef70e9ddf3@daynix.com

Changes in v3:
- Rebased.
- Link to v2: https://lore.kernel.org/r/20241022-virtio-v2-0-b2394236e053@daynix.com

Changes in v2:
- Expanded the message of patch "qdev-properties: Accept bool for
  OnOffAuto".
- Link to v1: https://lore.kernel.org/r/20241014-virtio-v1-0-e9ddf7a81891@daynix.com

---
Akihiko Odaki (4):
      qapi: Do not consume a value if failed
      qapi: Accept bool for OnOffAuto and OnOffSplit
      qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
      virtio: Convert feature properties to OnOffAuto

 include/hw/qdev-properties.h |  18 ++++++++
 include/hw/virtio/virtio.h   |  38 +++++++++-------
 hw/core/machine.c            |   1 +
 hw/core/qdev-properties.c    |  83 +++++++++++++++++++++++++++++++++-
 hw/virtio/virtio-bus.c       |  14 +++++-
 hw/virtio/virtio.c           |   4 +-
 qapi/qobject-input-visitor.c | 103 +++++++++++++++++++++++++++++--------------
 scripts/qapi/visit.py        |  24 ++++++++++
 8 files changed, 229 insertions(+), 56 deletions(-)
---
base-commit: b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124
change-id: 20241013-virtio-164ea3f295c3

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


