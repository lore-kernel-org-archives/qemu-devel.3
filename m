Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37B9E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyuJ-0006wV-9D; Sat, 04 Jan 2025 02:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyuI-0006wL-9A
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:49:14 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyuG-0001MG-9a
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:49:14 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2165cb60719so184077865ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735976950; x=1736581750;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=loVcwL0xwPRCwS8gDr5EvUsy7nrJiER9u2owigP/9Ug=;
 b=MJVOpT3rX+9wJMvSHqF3jfdipfJEc/j8UUCyKahbvkBh5bE+JatfZVZcM2HzlQmyEz
 7Tv5VIizROQQ/W7PezxQz8AbnCEzn6zncWnl3Ul95L5S6D6UyLT7KldIKvVrEdu2/qmX
 Fe6e61fw2tWDAbZ1gm0GF4V6KF4c2uUCoOrGG03OoIOadMPZ0KaxspyvKRmAnjfQgXZb
 TCXZUrKEXd7IR89vnEGGsP2GE1o7l2S3kjFZc794gQ8eGu6D4SD75GVEMWtn9fza/ggJ
 Gy9+Mepr4ctmgKuRao8c/W/5TWA16XRV0tbkEwC20dpfHGZB1tVcajTKCM8SrNIqgdHA
 AP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735976950; x=1736581750;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=loVcwL0xwPRCwS8gDr5EvUsy7nrJiER9u2owigP/9Ug=;
 b=i28UfqkbGFBDm+D9A6fPxKYgRSC0N7bfnVKRhuPCq/WoPM+iWCv7iMkF5IaW8T/5VB
 Ycc+JbHp+YYkyuB3hEInA9m2rTW/8B+e8BcNXhmoIku+fvtniY5x0iz0KLIQKzdsSPmz
 yf/s9l23kxmJnWol2sVDjscCUCBqSecpOr99ddZIl7HN8eEg1FIUVUokFkTuO5ymRP9U
 BnlP0BlpF1gHOQvB8/FzJj6ssU5ZvWp+L3rPTBIyHKpANzGJCHg7iFw52bocu0O+RU9r
 CoPyz7NiXt51EVX8dGWs8MHE3dNrmQN461ogLDpUa4puuXlPSW8JqrNHuqc6YllAyCDw
 3K2w==
X-Gm-Message-State: AOJu0Yx/P4I5B6s6Ru8x/UPAAGAdQi9n9ZAYP72T8q7TVxEmWugD9Q0K
 tOlEAlTJrGNrkFXIKwgFFU1xdwOJVHpC7X3L7mKqaIo58lnJjV92clTLISkcU9o=
X-Gm-Gg: ASbGnctDmn8MmZ7bRkUsuuiJIFwSwToAeuq88wpt01TlPtNA/uwmv6+aExPbO5cf0QU
 nlzMAWVWddaUqo0B5W3rVFh4AuF8Qme1OSz098JlYtea48DmT9Ft7DMlTKWKDLR1WXdN5SRjP4T
 ndtf7L4BgqpiNdn62gs81cHZDD6KRn5Zn3fGVs+gsBRlpzZNT8WH1EoS9hkWZjlK+DJMo7lbUnX
 TFMH3POJjDd2US88p6wthvWdBx1yAb0nENw5zKCtHG0WWKNmbcFTXWa8xwg
X-Google-Smtp-Source: AGHT+IG/1WR0DuS2WNtu5sbPU8y5gKs5fwDXtF9MD7RMkM1ez+eNgPw7KWaui48+1FWHkaMNmMLtpg==
X-Received: by 2002:a17:903:234f:b0:216:4b6f:ddda with SMTP id
 d9443c01a7336-219e6f0e6c3mr744445995ad.35.1735976949734; 
 Fri, 03 Jan 2025 23:49:09 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dc96eac6sm257230785ad.80.2025.01.03.23.49.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:49:09 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 0/2] virtio-net: Convert feature properties to OnOffAuto
Date: Sat, 04 Jan 2025 16:48:52 +0900
Message-Id: <20250104-auto-v4-0-972461ee87fd@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOTneGcC/2XMTQ6CMBCG4auYrq2ZmRYBV97DuGhpkS4E02IDI
 dzdQjT+Lb/JPO/EgvXOBnbYTMzb6ILr2jTkdsOqRrUXy51JmxGQBEkFV/e+49qCqQDBGJWx9Hr
 ztnbDmjmd025c6Ds/rtWIy/UnEJEDzzUgEe4VEhyNGls37KruypZCpLfK4aUoqVqWUOgyEzVkf
 0p8KJRPJZKylEtApbTS4kvN8/wAorXl9gUBAAA=
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
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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

Based-on: <20250104-virtio-v3-0-63ef70e9ddf3@daynix.com>
("[PATCH v3 0/3] virtio: Convert feature properties to OnOffAuto")

Some features are not always available, and virtio-net used to disable
them when not available even if the corresponding properties were
explicitly set to "on".

Convert feature properties to OnOffAuto so that the user can explicitly
tell QEMU to automatically select the value by setting them "auto".
QEMU will give an error if they are set "on".

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v4:
- Rebased.
- Link to v3: https://lore.kernel.org/r/20240714-auto-v3-0-e27401aabab3@daynix.com

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
Akihiko Odaki (2):
      virtio-net: Convert feature properties to OnOffAuto
      virtio-net: Report RSS warning at device realization

 include/hw/virtio/virtio-net.h |   3 +-
 hw/core/machine.c              |   1 +
 hw/net/virtio-net.c            | 273 +++++++++++++++++++++++++----------------
 3 files changed, 173 insertions(+), 104 deletions(-)
---
base-commit: d4ce41e114a1f079b0994b1e6aa7f01e20ba490d
change-id: 20240428-auto-be0dc010dda5

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


