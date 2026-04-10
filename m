Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF9EF36BAD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 05:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB4s1-0004pJ-6x; Fri, 10 Apr 2026 01:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wB4rz-0004oY-LW
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 01:57:31 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wB4rx-0007wi-QV
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 01:57:31 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c76d797b180so960925a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 22:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775800648; x=1776405448; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QovyghSOYRD9AZhdeSuzMc9k0KV1dfmKQFXm9VtLZts=;
 b=sp0lpNsfhsr6H0IUF5M+exbzGHbfIcCpZwT66su7HlWGDMFuLhoI80ShNlmBGg5UKX
 itfUUr1vSWUL6ceApTfGxiy4Cy5yo/4DbPL38bOQbx4D1yITk1J+208smpiuk5U+mmpi
 1Ara5wElwyoUGK7MI4dnk+GiC4XXuIT1hzEALeXai4IpTom3Ndiecn0kQ+7XL+ftpKp4
 Kll4gop8pOOKwbCMD8cPy2gmRcCuggWlcvFHpr++Z44B1at5b0kXp9vUHNSiNXNEfDbb
 oHHh+bwPSE6sZMzs6yLdkOa6GezHMcUrWH2ycI9/XEy+8UPacuwQPRKBf2H8akcWYA7r
 L5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775800648; x=1776405448;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QovyghSOYRD9AZhdeSuzMc9k0KV1dfmKQFXm9VtLZts=;
 b=kV47A5e0hVbAdYoUcIFgR8CUl2XjsSZoGQxBuj88EaFEzGVwsYa8/jF7mpCtC1cODh
 yUdLm7nABEdKRVsfhJ8Zhjvg1wFxg8M9orQKoH8T2h8vLCf7UrcEFuvWDuV2ihuu/Sk7
 nUq6WOTxRtjWLx0+NQKOnMR/s4bJ8Xik+wGL6xNmLCAmGLQ16KATndU9dqieUV7vdPMs
 2zddNMSBhiULOsf8ojb6oI9lDZ2YqX6BIyMV7rEKLf8coGBOB8g+7IqYFHpGagzVHytN
 lZixXdWRpTHuBaqveuROScO8tM+gpyNkLK5M2DsKbBzCNZiQ/RPej5LHLcLN9rQg4gbk
 Wd4g==
X-Gm-Message-State: AOJu0YyPh+8PEMJ9YL1wRM6RAz7utNnPOBEVXljSgBliJnCrmS8/q+Rs
 +sB9n0D3uQNMu5Kl83dAD6J0y7MbS54+R4PJZppHNI5E5quv94J/PyCC
X-Gm-Gg: AeBDievrgc7d+KymNrr0Y7ji0Cwq4PlFyg/gofEhSLdNUgpY1KSzgul/rg2XxHHQWvo
 5gautkGqES/mCZdArTKxxX7k5XdvfhzjfYuOlvtgVd+6P1uGzojcFppdKYbygNheRhlnFr/oQN7
 F1+kLsoKFC5LF4by5THzuPm1drn8ZTI0c4HvP9Jhr0oZ21RyJBKqSaQ6uooKQCtVWAwiqst7l/l
 V/ykTm0tXkkzQHkSWdK2x71gDRkPDYW9OHokl8HJ2J5s5nb9TGZE4NgU0XpVz1JyeVb1r2SSdw8
 y6NMjf3Yvew13xeJ+zSfKxr4S7M234LKBXAkONUgFDu4o0Peo/ZGLOT49h9MvPTLo5uUaxFAPbw
 wmvYdjvmLpKKMZZM2Cxk2VSUTqq+aHO5S2FeWPvzLDWYt09ijPF0bJUssheCADF6bmUjFZSEjoe
 jgSoyICjn3Ufi8hMseFlN1tXavJEkVCA==
X-Received: by 2002:a05:6a20:6a13:b0:39f:3efb:e888 with SMTP id
 adf61e73a8af0-39fe3da7148mr2182697637.25.1775800647614; 
 Thu, 09 Apr 2026 22:57:27 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79218fc8d9sm1225965a12.12.2026.04.09.22.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 22:57:27 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Subject: [PATCH v5 0/5] hw/ufs: Add Write Booster Support on UFS
Date: Fri, 10 Apr 2026 14:57:13 +0900
Message-Id: <20260410-write_booster-v5-0-d44e1a0e191c@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADmR2GkC/3XM3w6CIByG4VtxHEf7gX+AjrqP1hoCKgdKA6Oa8
 95Dj8zW4fdtzzuhYLw1AZ2yCXkTbbBuSKM8ZEh1cmgNtjptRIFWUADDT29Hc6udC6PxmHMhoVJ
 Sq1KgZO7eNPa19i7XtDsbRuffaz7S5f1XihQD1poxWtc5EFGcg+zDY2iPyvVoacV868Xe56unD
 VFAiFD81xcbT2Dvi8WXXFYcSs508+3nef4AjGPLASwBAAA=
X-Change-ID: 20260407-write_booster-889a06cadc59
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775800645; l=2185;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=xdFtdciD6N7DPfkOETvATNK2nYRxP6oDNo++PZH5LSg=;
 b=XTW5Kl4piWPkuJFVxZE+k211khc3J+KuiyvHrEq8bFH3o5/RoLB3eSo/hISXygUHSevqXEjbY
 0HjUqkEVCXOAom9zbg50DNYL6EBTy6shF/xJAfOQJ8XrwFBjyFcjSNS
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=ldc.jml@gmail.com; helo=mail-pg1-x529.google.com
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
Changes in v5:
- Fix Pinned Total Written Size Calculation.
- Fix WB related status reset timing
- Link to v4: https://lore.kernel.org/qemu-devel/20260410-write_booster-v4-0-d58a680587df@samsung.com

Changes in v4:
- Fixed MCQ idle check: skip unallocated qid
- Removed unused arguments from WB accounting functions
- Added SCSI command status guard for WB accounting at completion

Changes in v3:
- Fixed constraint check return value
- Fixed WB buffer consume amount with transfered_len
- Fixed MCQ idle check:
 - Added NULL exception check
 - Added CQ pending request check
- Link to v2: https://lore.kernel.org/qemu-devel/20260407-write_booster-v2-0-dd772bb30194@samsung.com

Changes in v2:
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

 hw/ufs/lu.c            |  97 +++++++-
 hw/ufs/ufs.c           | 609 +++++++++++++++++++++++++++++++++++++++++++++----
 hw/ufs/ufs.h           |  49 ++++
 include/block/ufs.h    | 110 ++++++++-
 tests/qtest/ufs-test.c | 176 ++++++++++++++
 5 files changed, 996 insertions(+), 45 deletions(-)
---
base-commit: b6a7d06213e5d2f7d124d16418bc289c4a8a4b82
change-id: 20260407-write_booster-889a06cadc59

Best regards,
-- 
Jaemyung Lee <jaemyung.lee@samsung.com>


