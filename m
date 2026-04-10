Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD314F36BA0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 01:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB11F-0004Mo-45; Thu, 09 Apr 2026 21:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wB11D-0004M6-Lu
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:50:47 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wB11B-0006Og-ST
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:50:47 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c76af79f029so611642a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 18:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775785843; x=1776390643; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8UgzEvC7Qzlm0WmAtQuOk8elkhene5DgayZwpRXzL0Q=;
 b=MnSCXmr42O884EjxjKRuYWjVaVwVEZoO7ji/cjWezur4RueoVtSQM5D6KzBKqYa1Az
 Io0y9U0JWw6uIV1fa+wjbqIBjUJJ/4U5NMCIL9fHPjFFokMb6ns0kU0wYvJHU0OvNvJ+
 rPWK+VM1Q8zSTamoVviGfyhyce7baiZkxOstJ2cOpbEdDqWGjMcnAjvb23ft+TTyAvoL
 CFF0lYY/r8KgNxFsCAldK8WM/+WzHeAxuMmiIK1JJyqu87zuCIJPTxBuOBDdnsNld2zj
 2z3sSWswKSRNy9C+1oxY/8eIrEpUiFMQwMxg5FCGIli/La5yQvZyXKXrKQmmWllZqUty
 Je3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775785843; x=1776390643;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8UgzEvC7Qzlm0WmAtQuOk8elkhene5DgayZwpRXzL0Q=;
 b=DTpHBWPcsgLPrwUcSWGMAUI3lIaUTtiltSR56cTjmNmvt6Kr3diBc/SCJ4CHUN+MRN
 6p/9p9ow0Y7N3WckhUA/LCk1zT31Y4+pZ93dVbMJSJlNgwUzUvrwpvQbYCil0FqevbPe
 zQh5zH7hZ/I/qZQpiGqVjZe1mKY509q146GhcMvYcbSehBOt2DMqXfXt2Qg6NsngDVAf
 OVu5QpU+a66cJuf2wWR2P016hSC2hYGW17qU6dEUuPa/A96cCqMKu3202gmOEPoYWwl/
 6cw36I9ZFSe2RDU5eLO7XhkJ6dZVadHEg96BcvC2rC1zy2NvD81KeSnoTFnloFv5x4OS
 2WYw==
X-Gm-Message-State: AOJu0Yzt8GDpho8h4eThbWWwEgrkQBzIye91El4z0YDWP/sExqC+yhXT
 z8HJhlGV9OUkQGYS9MqLa+uMrzbIWW7BjIhai/hAnk52BU4lwk0PlkPL
X-Gm-Gg: AeBDieuYEnVZRubQbmQJMulu0m+I5mjpXPMlb0xBafZjim4TBb8rpd+Hgm3PaSF0IYw
 R5hSs7vyf457CUg9f/9yIPOjer9C/jRLy5FZzuq0ZesYnOeUv5+M3gt/erZOZJDmq/bxW8zkk1W
 YK2g4QUmI+ToPtECiXAPtB1KxWffQetypXZjln1qRbhcwz8OM3Jpl0nKVXEXjPTeR8G5ngWaE2o
 3hUWgR8iqZZvnhfivFWN1xeE6XqiSK8InaZ8r25QCLfN9fXxI2ROaXtMa2deDWKcT5z4sJB4n94
 Sn9tbSHHPxpRB50EB2RE0a6mrHP+sBi0rSwfj4nCUCaAvosNnKTzb8GA4NY7193qb2nYKr08ZHf
 A6QUJ9i8RsbZr0Pc1nqrqEIynqa8tRUs+7UaHcuur5ilxKvFwON63au2sinLpu1eGPewqf9oDA+
 Xyv0vwHMDNhBRKaAHwvuCFPWfenGm9ow==
X-Received: by 2002:a17:903:1ce:b0:2b0:4b3a:9b4d with SMTP id
 d9443c01a7336-2b2d5a14bbbmr12163645ad.20.1775785843346; 
 Thu, 09 Apr 2026 18:50:43 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f0b284sm8832245ad.52.2026.04.09.18.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 18:50:42 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Subject: [PATCH v4 0/5] hw/ufs: Add Write Booster Support on UFS
Date: Fri, 10 Apr 2026 10:50:02 +0900
Message-Id: <20260410-write_booster-v4-0-d58a680587df@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEpX2GkC/3XMQQ6CMBCF4auQrq2ZFgTqynsYY0o7QBdQ08GqI
 dzdwkpNXL6XfP/MCINDYsdsZgGjI+fHNIpdxkyvxw65s2kzCbKEAir+CG7Ca+M9TRh4XSsNpdH
 WHBRL5hawdc+td76k3TuafHht+SjX918pSg7c2qqSTZODUMWJ9ED3sdsbP7C1FfNPr359vnnZC
 gNCKFN/+2VZ3oSQ/5fsAAAA
X-Change-ID: 20260407-write_booster-889a06cadc59
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775785840; l=1980;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=rnd5Nyp+VQVcTpDZQYQdk1toG+vCPRXlBsV2/rg99S8=;
 b=uqrLYI10JaB18IuJoqb0NcR27wUEgxEamR7tGTQp5AlbVu/ve8FXZOD6GUM5JL3UkTnxtw6pJ
 d4HtU5OQusOBx435SEfnGanwrXqMKbB2/1+4gZReuXskrmao9jUBnBB
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=ldc.jml@gmail.com; helo=mail-pg1-x52a.google.com
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
 hw/ufs/ufs.c           | 605 +++++++++++++++++++++++++++++++++++++++++++++----
 hw/ufs/ufs.h           |  49 ++++
 include/block/ufs.h    | 110 ++++++++-
 tests/qtest/ufs-test.c | 176 ++++++++++++++
 5 files changed, 992 insertions(+), 45 deletions(-)
---
base-commit: b6a7d06213e5d2f7d124d16418bc289c4a8a4b82
change-id: 20260407-write_booster-889a06cadc59

Best regards,
-- 
Jaemyung Lee <jaemyung.lee@samsung.com>


