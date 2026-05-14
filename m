Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504D4CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 08:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNRA9-0004c7-RI; Thu, 14 May 2026 04:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wNR9x-0004aE-Ov
 for qemu-devel@nongnu.org; Thu, 14 May 2026 04:11:09 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wNR9v-0001bT-I8
 for qemu-devel@nongnu.org; Thu, 14 May 2026 04:11:09 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-367d88b9940so3969883a91.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 01:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778746265; x=1779351065; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DvQeMqraqCo3ctwgd/pZSUQXO0skjKcGUgMfPkwuMto=;
 b=AsHcbOXXyMiC+Q0mX2jtZ103bFe1FcU+edOUoURNg/L9xOd8lCA0S5IJXnEY+iRpNX
 Ky5cA9rH6e27GGI35/t5TCn/ikvp+aE/DW0EJgCHWYv7T5KZ+g7Vhc0P5CQXUe9bxzL9
 YVZBaTzfqoTm9usb5e670I2QdDh/zhTArLbnSolHequh64Z85qChXKQwrl649tbm1dKD
 hyXvYmowz75JLvV3TsevaaARsduMjpZnnkAemRL79aFI7y5K8B792VFR0pCHcJJRuGFf
 +XKTCJimL+qC1YHF3yBbrP4sT1AUzAXBaR0PYtGH2ETQfo4rK72MxdYtoXQesiYNN//b
 CZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778746265; x=1779351065;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DvQeMqraqCo3ctwgd/pZSUQXO0skjKcGUgMfPkwuMto=;
 b=JkBnLJNJqA3O8eKkxH1EMjegaUVt0xNPDE/+6yrWM7JdtnHwxPt+2WbXqKjuRHOFop
 0R7BDgWg8YrOhODA3H0/zgxI796nF15U0J8znVBBadYM4eaiK21kncMJXoMQwC8ODDID
 npdL8wfWqXReq1txaycuw+JuvEkyhXWTm1Xie2+WGa3IDjTvEqMW9DKcYeMgBqbyuQ1S
 F/i8xzZbbI0nPzK6aTXVODLdydIbsIFRkRa+IIm1pCWtEMEz/LC6vZVYw7rE//b8ofmZ
 VGdIWUn/pDZLNoHbeWaKMcurcpSDkW+5va3/gQrCrcpIKay7grXOW/Zdw7Wo8tXFtgRK
 u6pg==
X-Gm-Message-State: AOJu0YymkrqraJYc6RmzeDzwFYa2c26VPhCu5kJCrAE49w6syeyr2oOi
 opZ5xocM6kPkM4Sm0hyLx5lo9/gUxN+RipM3s+9UFSTvvji2tpSbRab2
X-Gm-Gg: Acq92OGw8HFKnTeeMO12fyY/fsWtfPBOdJ5rHiZPRuRvRgPDUfYIABlh8GVltv/PeUZ
 RYUrEEf2Pr6OxnmFa4Xvz8GKWSbYHKnBs/A0vkF3qH9tFtYGHAfNXmc8Dld2io0574hsePaDQ/z
 zK8ejaamEKQHwWchfsYOd7lg56vpN72gNkgsIdYoDVGvJwzZf2XlRkp1GF5GfrELrFPBp1PtPkq
 c7Ru6clljyt93uammWCCpB8yVuVoCPrU7xm45lWVD/i6aZUF78s0dVzcbh+Qad1DWwUVsgILPNj
 PsIbu5nzCAQ/uZaKhNaQu3smFPf37+cX0hoxLqd3o1TVyz2Q5k2dUsr2oezF0x2CoA6xK+PjOjB
 NMOv60Eh0hscI0wPE3UFsZjEfUFVDU+VicW5YD5zFr1Ko3bqe/KSToE/nHnl/FAWQYXP4YTtErY
 JHtPvEtgRKEXHddb/SbOKxElQUwPuz6Q==
X-Received: by 2002:a17:90a:fc44:b0:368:4cb2:17b8 with SMTP id
 98e67ed59e1d1-368f40835b7mr7542232a91.21.1778746264749; 
 Thu, 14 May 2026 01:11:04 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c2631basm14480165ad.34.2026.05.14.01.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 01:11:04 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Subject: [PATCH v7 0/5] hw/ufs: Add Write Booster Support on UFS
Date: Thu, 14 May 2026 17:10:43 +0900
Message-Id: <20260514-write_booster-v7-0-c3ae3452980f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIODBWoC/33PTWrDMBCG4asEraswkvXbVe9RQpClcaJFrCC5T
 kvw3SN7ZWzS5TfwvDBPUjBHLOTz8CQZx1hi6uvQHwfir66/II2hbsKBKxCg6SPHAc9tSmXATI2
 xDpR3wUtLqrln7OLv0vs+1X2NZUj5b8mPfL6+K42cAg1Ba962DTArvoq7lZ/+cvTpRubW2Ky93
 fpm8bxjHhiz3uy9WHkGWy9mL41TBqTRodt7+a+XsxcCmQNklvm9VyvPd15Vb7ywzrcOmrD5f5q
 mF51X/pqsAQAA
X-Change-ID: 20260407-write_booster-889a06cadc59
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778746262; l=2799;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=MD+iYTeaJi2vxaNQHaL7wWk5OHYtGqU0LLgiy6GnJyI=;
 b=vU1aZJc3pxpeCgbvOSv03BnvdxRHIJmKYLPdl+am4MhX3tct/WjwGO6kO0YIOZJj63bwdipRz
 BtV56Py2hcBDYgvfGfFedpK0YGOPj+D4y8iSRaIAfMLqqGyf5EDxDIp
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=ldc.jml@gmail.com; helo=mail-pj1-x1036.google.com
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
Changes in v7:
- Added range check for dPinnedWriteBoosterBufferNumAllocUnits
- Added range check for dNonPinnedWriteBoosterBufferMinNumAllocUnits
- Added exception event status operation
- Fixed minimum buffer size set in WB initialization
- Fixed resize operation
- Fixed Pinned WB buffer consumption
- Fixed user_space_reduction related value
- Fixed buffer size sync timing
- Fixed flush operation
- Removed unused DEFINE_PROP varialbles

Changes in v6:
- Fix Pinned Total Written Size Calculation(2).
- Added range check for dMaxFIFOSizeForWriteBoosterPartialFlushMode
- Fix flush status check

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

 hw/ufs/lu.c            | 102 ++++++-
 hw/ufs/ufs.c           | 714 ++++++++++++++++++++++++++++++++++++++++++++++---
 hw/ufs/ufs.h           |  49 ++++
 include/block/ufs.h    | 114 +++++++-
 tests/qtest/ufs-test.c | 172 ++++++++++++
 5 files changed, 1105 insertions(+), 46 deletions(-)
---
base-commit: 5e61afe211e82a9af15a8794a0bd29bb574e953b
change-id: 20260407-write_booster-889a06cadc59

Best regards,
-- 
Jaemyung Lee <jaemyung.lee@samsung.com>


