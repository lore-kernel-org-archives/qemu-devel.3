Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6C7EA71BC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 05:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEhCC-0008GD-Vf; Mon, 20 Apr 2026 01:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wEhC1-0008Ed-Q9
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 01:29:09 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wEhBy-0007zE-8h
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 01:29:09 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c79467f11abso1698441a12.2
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 22:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776662942; x=1777267742; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mmVR/X2fwId63LEreV/Wwr4P0lpnCDvpjtHinP3tdhI=;
 b=gI+T1GEkp0d2c0x/KxFAf0nEZ2UQ8e6bwqOZxNmCeUt5d3A4vv40pgp280Jt/ioQKZ
 20v/fv1yPYiL0dypolFHXw+WLfxHeQ/8hZemrB0X3ENlwNToZKXWGpjvzz38BPjXpWQT
 zBfPkougTb/l7pgtxLyXRZm5qqelu19RS08lhjxZRm1O3YFzSyFS/KmgWJd3qg3pUvXI
 PCBpQE0xVJ7+tMVkJiG38rbH1n+6IiuYvOROoMX9XCwG8BstlTxj5LRpOo1DhLZtLOQD
 BAICbJWSb2wI7UIht7ylD7h4veiOhGSLHGgtPTXy1ly6DiYNOFcQlzfgRtZDw7C11Rcr
 yadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776662942; x=1777267742;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmVR/X2fwId63LEreV/Wwr4P0lpnCDvpjtHinP3tdhI=;
 b=VYe4wsPIQtzvyZe/66dcRhYWDgBF8wIqcCzjN4Ma68NJO2l8AjcYP+JNkEunhtc3Mr
 E3QemsV/KeLPnOhIW2Ti7a+LcB6jO33AZQzRKDKKDVY6JwapBX3JiNttcKxvt+136bNa
 TaM8pUf48zzNKoEamNI0Zzh/Mft8xRGhsdNx36e+X8HMfWo2DyydHQEtmBUHa86yY2pt
 ps56JEjAaM6lC/2xgmY+DW42XUhZwuHzhJwG0SnE+0rfvM5z11QV1sKyZC8ovDwI2F4h
 FDAqN60roKUemZPCN7N4p8kYDYqshzilqPe2U8xAjIFlrfTHkvsXsNAOL7rwQ2CgrBk5
 jDgw==
X-Gm-Message-State: AOJu0Yzpl23f/MHMx2STXKXvtTy71xU8zv4kdh2OFM6M7x2wdmtRocgM
 b8I2ATnar716KyImUGrGqAVU7iCpmsO/hmCzs2qRK1CRjZgnjxlfn2nmQVIsgX46AmU=
X-Gm-Gg: AeBDiesek1FZzgO/R+fPsOtmRBz3uqAYQ2G5ZQ95qqwCA2nvIkX61OY70xSFPUYr4AN
 9x+WrbaP5dI50ZMh1G2vlx79JZXtYFdBzwU0SiwMjcmFgHYQxmz7Be4mYlthSnm1AdzyYYADDON
 Z+WCI2gkgDdyeMj9wN/hOiI2c447pKlsHDK9PkAKBu/F8mvE2W8lCrm+EiDG6BisJxj297jvb7b
 9Coobb2JB23uhAEVC0MmRjNikg36QxZY3oBqvgKGY5AzrSM3jInmmTqKlaK19S4xEuVX97BiWl+
 OwLphRr2SdSsVtq0Z+Rdyp3ptQ2DcEud/PQfvz6gJhOyvOj5SDyio36XTgxHc7RIOQg2jlHR+r6
 40fnPJqxLTfv1Qw0xL1nIEe41pYkgp469ZevTaElomJvBU0y5zBAQzOT5KBiOnsSA5SNBOpuKSg
 Epyn66YrlX4sg5aB6z2o0AiRMcmujlAxr96bqpWOnw
X-Received: by 2002:a17:903:17cb:b0:2b2:67cd:9963 with SMTP id
 d9443c01a7336-2b5f9fd5c04mr120182305ad.38.1776662942305; 
 Sun, 19 Apr 2026 22:29:02 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab3ad18sm93099675ad.71.2026.04.19.22.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 22:29:01 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Subject: [PATCH v6 0/5] hw/ufs: Add Write Booster Support on UFS
Date: Mon, 20 Apr 2026 14:28:48 +0900
Message-Id: <20260420-write_booster-v6-0-8c49acba03d4@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJC55WkC/33M0Q6CIBiG4VtpHEf7QVDoqPtorSH8FgdJA7Oa8
 95Tj0xXh9+3PW9HEkaPiew3HYnY+uRDPYx8uyH2auoLUu+GTTjwHAQU9Bl9g+cyhNRgpEppA7k
 1zkpNBnOPWPnX1Duehn31qQnxPeVbPr6/Si2nQJ0rCl6WGTAtDsnc0qO+7Gy4kbHVZnOvlz6bP
 K+YBca0VWsvZp7B0ovRS2VyBVIVrlp7+dfL0QuBzAAyzey37/v+AyC3EzlsAQAA
X-Change-ID: 20260407-write_booster-889a06cadc59
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776662940; l=2348;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=C6SHKYWAHjX7UbM6HXAo6Y88MKHifoIYbPK7PjwHtmk=;
 b=pEWSNRYX3ae5epczCLw91mCbJVVqrO91WeWzn+iYbFrbBmkZOp+MvrEmMnQL/PXDf3Q/WPAzG
 Y5N1hOOv3I3A982EZ9ZFf87U6bTR0qNWiTgA/8IPXtLUcPDxNs5iJWs
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=ldc.jml@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

 hw/ufs/lu.c            |  97 +++++++-
 hw/ufs/ufs.c           | 617 +++++++++++++++++++++++++++++++++++++++++++++----
 hw/ufs/ufs.h           |  49 ++++
 include/block/ufs.h    | 110 ++++++++-
 tests/qtest/ufs-test.c | 176 ++++++++++++++
 5 files changed, 1004 insertions(+), 45 deletions(-)
---
base-commit: b6a7d06213e5d2f7d124d16418bc289c4a8a4b82
change-id: 20260407-write_booster-889a06cadc59

Best regards,
-- 
Jaemyung Lee <jaemyung.lee@samsung.com>


