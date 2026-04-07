Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8ACBFF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABWD-00080i-Dx; Tue, 07 Apr 2026 14:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wABTn-0002am-DB
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:51 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wA3fv-0003LC-O4
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 06:28:53 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82ce09b61beso2120203b3a.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 03:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775557730; x=1776162530; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EFNCT2kZk19w6xx1kj2vO0kyXw9wNENiAyvg0/Vgj14=;
 b=frIhQEiI9lCLOM3m/ng4AttdfN237LtsbQo8L0clNaNp1Y6RLOzpClqNu6m5leNA1E
 Fktbxur00n3DBk6Ni4iUZARKwFTPZqzOrAmhfU0Rr1BQTEA5VJCQ4H92yiNM9BH/ekqG
 KGXuKoYQuXK9TpApyCKYMkL8BlUXojyKlL6xhvigSoJbz4S4+7Omkp7kxOtYOhbYh8qc
 Li7ormq2JpDLFHNFRRDG8MNFaCQ7gY/CNnvHOzPVUNQd60L6QWG/n/xYCeo8/IiVN0j1
 n+Nt86n6wX1ZSqAWcSe3o7R+vhErmP4hdd1pLAlGwDQNlo4wTUKLOSWoGDahBdEHNVMj
 ASPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775557730; x=1776162530;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EFNCT2kZk19w6xx1kj2vO0kyXw9wNENiAyvg0/Vgj14=;
 b=oL3kTjsh746+dJUZK+mv8WKw+WSgLWG6hSzLQ8OF091o/tK4TxOoaUq+aMQsuYQJWn
 PejcU1XUVZzzKFLr7d1Mi6w2s1y5cESa/0RAs/kX9HTAd02Z0G8+e8Y6+LzTkRkb1l7r
 cKyAvFv6H02o8wvRDGx+UW0thArbhUHgxWhgAUUYCzskMd9EZeq3yAHBKDIkiVFGZ+f2
 P201wLSaFysGgfsb1Ma5cKtC0l0lRkQA7RhBbfBjN7JkQihSVc/9rYd4j/Tlzdj6pUoS
 e/ycSRjGazCMVR4yaFVH+lYjIU3kNYgYBaCY1/mfwhIIMGlpI9u6CVnBIZpWPgj56cAR
 kBog==
X-Gm-Message-State: AOJu0Yzzzlk+6JyalC52wVCwLGQj4OZXjGyMLdbaB4hGMs/x9RLhsfyj
 7L4h7vH5qllfdggVG1j5cwG2hqiFePMpGx84dGpQKRiKuQXqbuPYRl6OcBWO3bU4ubXkfg==
X-Gm-Gg: AeBDiesS+0DUZH50AlaaOFWIJ6d5KwhJT/iQ272P3J7klDloYfpRt9msGARfDuScJQS
 S56GRGRTfnD2alDoP3ecXaLCVwqgV/E3F93BGL0eHC9rYBgk/DtdWhh6hfnnKzF4DQDVomewT4q
 /vlSAsfd1TwIYc2ZEVvKWJ8FVJIl/T92ok4+AoOLaGfxNiPYV818RcjAoVLALt4C5gE/80fKEoS
 tR7IrWCoDJjNJySMTaDIgrjUr5ZaNffwdrd37OaF6qCk5KnguCsRGEuqo1lE8P04VxYascSTKWe
 8dz3RfG8Xen+m9Lr+vttmCVwkV5CqssHV1ToDxus7fmZ8nbC9c6iGCXIpEdgzFfJG/7LKRCqmxF
 sdXgLS6GW6kLEA9FcfH2CdIUR8h6vZ7lesqEf8T/WkfTneuGz+4c6qBvYjqB4JKSKDxOi7yAy5o
 kQ1tqY0ZCbNMp7hwlG3IxQctsdTRuuAw==
X-Received: by 2002:a05:6a00:3316:b0:823:9e5:855e with SMTP id
 d2e1a72fcca58-82d0d74799bmr16441197b3a.0.1775557729804; 
 Tue, 07 Apr 2026 03:28:49 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b2714dsm21217324b3a.1.2026.04.07.03.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 03:28:49 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Subject: [PATCH v2 0/5] hw/ufs: Add Write Booster Support on UFS
Date: Tue, 07 Apr 2026 19:23:38 +0900
Message-Id: <20260407-write_booster-v2-0-dd772bb30194@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACrb1GkC/x3MQQqAIBBA0avErBNEyqyrRITpVLPJGKMC8e5Jy
 7f4P0FEJowwVAkYb4oUjgJVV+B2e2woyBeDkkrLRnbiYbpwXkKIF7IwprdSO+td20NpTsaV3v8
 3Tjl/4SzYeV8AAAA=
X-Change-ID: 20260407-write_booster-889a06cadc59
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775557727; l=1479;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=FtPAjGEMEF8fz+5o76AV8sH73jJgQ7fiMeATq2KDgI4=;
 b=dukeajiUuUxnlmqAS2Xf00CdM8MtYLV+tx9CJhuAcHH97lhW7wAPk7VmCKAeKiRZv7ZZwBdHv
 9RwklrFXAj5A9rx3hpuIftihkRPGMjskXG27P8JbaofDZnMAL4k2JTj
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=ldc.jml@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, the QEMU-UFS emulation is implemented based on the JEDEC UFS
4.0 Specification and does not support the operation related to UFS Extended
Features which is defined with latest UFS Specifications.

This series modifies the UFS core implementation to align with the JEDEC
UFS 4.1 Specification[1], and adds a Write Booster UFS Extended Feature
supportability.

Tested: x86-64 KVM, upstream QEMU with Debian GNU/Linux 10

[1]
https://jedec.org/standards-documents/focus/flash/universal-flash-storage-ufs

Signed-off-by: Jaemyung Lee <jaemyung.lee@samsung.com>
---
Changelog:
v1:
- Rebased to v11.0.0-rc2
v2:
- Fixed MCQ idle check
- Added WRITE_6/WRITE_16 handling
- Fixed WB buffer consume timing
- Added constraint check
- Fixed uint64_t casting for unit calculation

---

---
Jaemyung Lee (5):
      hw/ufs: Apply UFS 4.1 Specification
      hw/ufs: Modify flag handling operation
      hw/ufs: Add idle operation
      hw/ufs: Add UFS Write Booster Support
      tests/qtest: Add UFS Write Booster QTest

 hw/ufs/ufs.c           | 685 ++++++++++++++++++++++++++++++++++++++++++++++---
 hw/ufs/ufs.h           |  49 ++++
 include/block/ufs.h    | 110 +++++++-
 tests/qtest/ufs-test.c | 176 +++++++++++++
 4 files changed, 976 insertions(+), 44 deletions(-)
---
base-commit: b6a7d06213e5d2f7d124d16418bc289c4a8a4b82
change-id: 20260407-write_booster-889a06cadc59

Best regards,
-- 
Jaemyung Lee <jaemyung.lee@samsung.com>


