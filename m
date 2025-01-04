Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ED6E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyiG-00038Z-Jo; Sat, 04 Jan 2025 02:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyi9-000387-Gx
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:36:41 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyi7-0004vW-Qq
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:36:41 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-216634dd574so120140095ad.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735976198; x=1736580998;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1hHRlyLKBmZEY402t1u0c+rlikNZcKkBPd55b5IeoYU=;
 b=p6xEMGN+Pp+daJB3daUku9QHWdVrcLBYsFYhiYUU6rUQdAt7LVJmQ5Dhg1kiBHwHVr
 WMfBOYuz3hEOJdmxdvELMxJGRWr9coIGQW3Sypx5bBner3khIASTMAlvjXBXhwHF+VXY
 6Yda0I0c4zWvz3+jNKo6U+y+smU7YOoKp1EXMiuYXNmE3fCDVe0VEQtpB2TfVv7mmdpj
 M2j7rcnYBhl79FMWTaUu0ibrOMB5Z/D76UHGi1Mo07YwkSX8A/hlVpFbjIh5z5dzWE5v
 M6B289C+cmPodz1lHzt6ViFxHBiEg/UOc8EerQBxXh6I6FQQet+CQKNKLZz5RPzXSizk
 kSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735976198; x=1736580998;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1hHRlyLKBmZEY402t1u0c+rlikNZcKkBPd55b5IeoYU=;
 b=Rqz46+LQoz2pfksXUw3pTVoGmJxbY4kI+0ijtCrNwKpSFPbDA75yK3YDYW5oE2JdRk
 2IeXPGCkqCJk7A+mzUMDZwzjv4Xkhyw1IFhH3I9iYI6methRB72bc2QS1DjiwUAbXinA
 4D+vUk+NjuUt48vmqiHnHg3o6wig6CPP0mkvrRipM7MqzA4o1hYs1J7k0/hK1HcVNged
 FZM6suku+KZg1dw7iIHjjSvkkT0v6K3+b8IymCKWYdIrAz19bC/TX93gzXG3Fa0TEge0
 07sfHFoDq5x8J3sP5oIjaigeV2oumoui6sRqMSDVlNbA145Yxj0l+/dv1GK68Fut3wiW
 jOxA==
X-Gm-Message-State: AOJu0YzC+RV4MkYj13oM/Cd8e0dMRHVGhzRi4BUcdhnYljTaUvxzQ02m
 0SKc6pkAUVHOeXOvmXwt2eZtbO21A0Xtg1nOFWRzppWQ9ABNojEqetEBfUGrla5uQMHp+V7MSEU
 k0eo=
X-Gm-Gg: ASbGncvznfuPIqFBgIF0UCwOfMUFytCrfnYhUKM62BQ/VmmRcqhk9vV64pQNcvoFUcC
 66NFI3GXUIZgmOwxbeP/PLZPEFgRiARBNzMNkSKDR0nAc7E5q+B/803auvxcl40nliwuqHr4tHM
 3pBJ23jpnC6GSAnLTtuG2r6AUBWS+B9g51RNcxNzC5/wM/Dwowycf7/CT+99yPcbrNcJAiXucgh
 lzLXOBhw8mKRVhxgKG4K6i0gLsp6LSJCS25P91Mz0rn2Cu0SgZ7aqY7AURM
X-Google-Smtp-Source: AGHT+IH606EoXkeA3wFuGj9AglIa5CMmNdCeXDl4UKQFYkTSJDSQmH8ti1yf2D+6xAY8h8WfvvXO3g==
X-Received: by 2002:a05:6a20:841e:b0:1e0:d73b:15e4 with SMTP id
 adf61e73a8af0-1e5e07ffc48mr84567190637.29.1735976197746; 
 Fri, 03 Jan 2025 23:36:37 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72aad8db637sm27407110b3a.119.2025.01.03.23.36.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:36:37 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/3] virtio: Convert feature properties to OnOffAuto
Date: Sat, 04 Jan 2025 16:36:04 +0900
Message-Id: <20250104-virtio-v3-0-63ef70e9ddf3@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOTkeGcC/1WMwQ6CMBAFf4X0bE27LUg9+R/GQ6WL7EFKWtJAC
 P9uIcHocV7ezMIiBsLIrsXCAiaK5PsM6lSwprP9Czm5zAwEaCmk4onCSJ7LSqNVLZiyUSyfh4A
 tTXvo/sjcURx9mPduktt6JPSRSJILjsa59mJrWRt5c3buaTo3/s22RoIfD+DrQfaeoIwGVaEo1
 Z+3rusH1yg729UAAAA=
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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
Changes in v3:
- Rebased.
- Link to v2: https://lore.kernel.org/r/20241022-virtio-v2-0-b2394236e053@daynix.com

Changes in v2:
- Expanded the message of patch "qdev-properties: Accept bool for
  OnOffAuto".
- Link to v1: https://lore.kernel.org/r/20241014-virtio-v1-0-e9ddf7a81891@daynix.com

---
Akihiko Odaki (3):
      qdev-properties: Accept bool for OnOffAuto
      qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
      virtio: Convert feature properties to OnOffAuto

 include/hw/qdev-properties.h | 18 ++++++++++
 include/hw/virtio/virtio.h   | 38 +++++++++++---------
 hw/core/machine.c            |  4 ++-
 hw/core/qdev-properties.c    | 83 ++++++++++++++++++++++++++++++++++++++++++--
 hw/virtio/virtio-bus.c       | 14 ++++++--
 hw/virtio/virtio.c           |  4 ++-
 6 files changed, 138 insertions(+), 23 deletions(-)
---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20241013-virtio-164ea3f295c3

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


