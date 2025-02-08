Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD35DC0219D
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 07:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgfcY-0005uO-PP; Sat, 08 Feb 2025 02:51:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tgfcW-0005tw-O8
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 02:51:21 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tgfcU-0007UU-BU
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 02:51:20 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21f6d264221so2711935ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 23:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1739001076; x=1739605876;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E8wtZqclrqM98UWJJiybSsZS11RbxecILtCjIKcLIwM=;
 b=cecuggcLCNAqzwYn8iuL+IDwaEP1xiiLWhOfLNxZnb0ZgyD6FF+gRcp9qrx+eJmo07
 zzVKKSgZX8FP57cIWrHTy2gitQXsCbkPz8X567p6365bGtZ+0fTzpEbgCkwCZest2Ecd
 xZFJVwbMtRo1FtKLr7ANk+ZuI1/UlZevXBMw3fM1Upos7X+ikG7JEfN4Gggj4dQnIA4K
 J8A+Pj7dinVCh5KOrS4HJ9O5v4bIj8qlABZ62QRMaiu8oYXEMElFEllqCZfTLodNoygu
 f0zhNw8ScE4qKTY0oLCAuKnfwm6KOLkwFuEZ2O1tu8bRwr2vrkzbRNXt0XXh4WVIObd0
 RKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739001076; x=1739605876;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E8wtZqclrqM98UWJJiybSsZS11RbxecILtCjIKcLIwM=;
 b=WacFCVh+E7PX1MDENvwn4SjHEUQy8U8xqz7sa6T7RVbXl04prNr39qnLkBKR1g9OoU
 +ZIfIV0LK2Qh/jqrWtVhkRwookyPSZ7IfwSmHR7e0+ASzKXRGrjERvV5o0nbdv97jTR9
 e+tW1Zk+6Clys3rNUWsLMM7WtHWhiU/LAy1fEOf/vTa6zNTBE8nI+JCdJh6IiCx4GwfL
 9HE99H2570CqYejDdVkp855r7wuFftxroVguQqueAdpZTwtRVzEXyqnPvw6BBwEjzJtI
 Xcncv6Cj0Cmqw42JBDBAFHj2r06R6RacqvdrGP9BdcMLUOuWGw59SWFi5PRfP8jsxDYJ
 zy6w==
X-Gm-Message-State: AOJu0YzdrdMv7s7wU5pv/wJjobzdyGVrATR4QbuHkkGsqQZEaV7L+p1G
 Sy9py8aOY2PVgVoDaJ6dAGyO3jdt8jbmQYuDEqVl6+JSAwQ9vkk0uV7Mu/qB+pg=
X-Gm-Gg: ASbGncuVvYQkaidEBCRr4SuWoKJIGdDTnS9XFDcF4xvrVJ33WfBv7bRrD3s7qxWYsJc
 6tD0z5fkw5gX/Y1tZn6UyUiH+2MJIF5f8SOURF+IuKmgVSGwMDJOyqV/GfcmhWDAlLoXgIy/Cxj
 R6mE8WNXYF7ZhgDC/eb3FWU6stnf/sbN71DYxZFOohbj2IZTtULo0KHWVE/zezRMq40FtfnKfcF
 ymxnDJDXf9WyuEH0Sfz69Od6Ro7OJy9npGf0wkr6o+wvN1v/JeLapJu5hvOyftHeK4WEZe94fyb
 A2S8xCmu9xCGOvMw5DE=
X-Google-Smtp-Source: AGHT+IG5NgiJVvjFyA/Dr6T56W9onQBNukzb/Xy3/onvsBLz+j0qsYR/u7rlHs3LaTrXjEheSHRtBw==
X-Received: by 2002:a17:902:f543:b0:21f:573d:4ab2 with SMTP id
 d9443c01a7336-21f573d4b44mr77338475ad.51.1739001076512; 
 Fri, 07 Feb 2025 23:51:16 -0800 (PST)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21f3687c820sm41901985ad.173.2025.02.07.23.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 23:51:16 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 0/4] virtio: Convert feature properties to OnOffAuto
Date: Sat, 08 Feb 2025 16:51:06 +0900
Message-Id: <20250208-virtio-v5-0-4376cb218c0f@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOoMp2cC/2XNTQ7CIBCG4asY1mKGGVqLK+9hXCAddBa2hhqiM
 b272KT+xOVHeN55qIGT8KA2i4dKnGWQviujWi5UOPnuyFrashUCWgOGdJZ0lV6b2rKniK4KpMr
 nS+Iotym025d9kuHap/vUzeb1OifsnMhGg2bXtnHtG9M4s239vZPbKvRn9Wpk/HKIb4fFHZCcR
 aoZKvpzNLsKDHzuUXE1cVzDdPXf2W/XvJ0tLhwieA82uOh+3DiOT+SINFtFAQAA
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
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
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
base-commit: 7433709a147706ad7d1956b15669279933d0f82b
change-id: 20241013-virtio-164ea3f295c3

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


