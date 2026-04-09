Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CF8E98FA8
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 05:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAi5s-00052p-E3; Thu, 09 Apr 2026 01:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wAi5p-00052F-MZ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 01:38:17 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ldc.jml@gmail.com>) id 1wAi5n-0002oq-PS
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 01:38:17 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so2790865ad.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 22:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775713093; x=1776317893; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L5oc/VKls3VmWxljsWA0voTl6h+N0SDSJPakOVzGhlQ=;
 b=qoKn2KUI7bDR/Vs3jHI5qfQu/KDt0dX74eQ/NogSkGQTrv9kt/jA3DFNjho7y7vzOp
 UvD1rdtDan7nBbPemFbMVvA5u20VxbR1eBjU6R5s/OU/uPChQfGAKb7ZBRdofXy5JGjh
 PK7+xrBvfw9HL9ybJNa4/AJBK8miCI/Tatcv4UnjwPM8duK09/X39ezxe2B9BzM9Jnkt
 frUJjFlym5kF9smHzFgvk/+KjI1LAkh+Y5QLsrGtu//WZodADyNW3BXJ7hLlMmgESYKP
 YQayUQEJZ0skyJj23ka4n03hgZOXu+u1dkREB2f46IFrNYQBe0imFHaAvro+2EPi2Lut
 Pa9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775713093; x=1776317893;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5oc/VKls3VmWxljsWA0voTl6h+N0SDSJPakOVzGhlQ=;
 b=Uz2uXGIafJ09TrdVbs2KfAm0sv4ne214Aq3zvECK87qxPN7M/SKpHXHTrFK92WelMh
 jgwYAkjkPTTAOP0sHwdpz5FU50JgmVnUiMbbcZHU9uwmbzAOST0pQ474yjRztFOqTGNm
 6hgkihcHw/abY/YdzDxJHxvG13BGrhSMZX1isbk0fN1Yl3wTegtiQZ9JBh97NigYUY5N
 TtX+608piS7MDFfjdlPYAyoehWCY7LuG59woF+N1ncUff0TqcWf4QyeP7ZG3FsCZqWtF
 x68fT5mgOqT4hSKW7CqKPapNNDwWV7U8pjDgOhmtFGEnr91wO9WXMVRhe2+MPRnYQmA2
 xEaw==
X-Gm-Message-State: AOJu0Ywd3K9zitLDGtKW+GVZSIHlOGLBYgoR/6fY/Ern3PmpolBfbSfV
 aOLcsk3c3xKha6NR8JAB2qYeH1BMm82z9Ni03CJizHwyYU0B8NlhrGFYn+P5kHPFHH8=
X-Gm-Gg: AeBDies6WZEE6BN8UuAf1F/3VZfVTe6MRkWL+h3jGZF5Fv9Jcb97utD7X8mFAh6s0LV
 yYwVyCdmaAG7mc6kvZw3BQkB1plKouT3Ueh0Uy8lDq6lyP7bIP6T/PMM1vx2tg+hbZfatFpJUH4
 igTzikbIFfCgEQd5U8JG9qalTJdAHr6zuHkJ4mOCNtlUwxe04EyA5OjIknyMuorPQzUaTlL+2ss
 CTIzOvKqwrGSXMKT6PRWDujYaSX1afOqL2SFWXFDXiX5GZMxaE6/FQwe5C+MT8Lr1cjWo+ONPQW
 wzf1YhjsTlQ1pKYYi55MJP9m/pvICPc1xFzHZLAZoPz5q/bGAUz5d3QHWsxjVK74aHMuT3ZICbf
 J29vMW4QrRRL3J4xq0ixpxvVNLwFhWstXjb9tStqclwp8evqd2IGUvQmOO9+avmnkFg6763ooLv
 GepJ3zdsLkGwx/JDrLrvJ45NNt81tE7Q==
X-Received: by 2002:a17:903:1ab0:b0:2b2:5857:583e with SMTP id
 d9443c01a7336-2b281832ea4mr259908625ad.31.1775713093404; 
 Wed, 08 Apr 2026 22:38:13 -0700 (PDT)
Received: from [172.17.0.5] ([168.126.243.22])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2747a7115sm211108905ad.36.2026.04.08.22.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 22:38:12 -0700 (PDT)
From: Jaemyung Lee <ldc.jml@gmail.com>
X-Google-Original-From: Jaemyung Lee <jaemyung.lee@samsung.com>
Subject: [PATCH v3 0/5] hw/ufs: Add Write Booster Support on UFS
Date: Thu, 09 Apr 2026 14:37:44 +0900
Message-Id: <20260409-write_booster-v3-0-dd2f1c0119c8@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACg712kC/3XMQQ6CMBCF4auQWVtTC1Jw5T0MMaUdYRZQ0qlVQ
 7i7lb3L/yXvW4ExEDJcihUCJmLyc47yUIAdzTygIJcblFS1rKQWr0AR7733HDGIpmmNrK1x9tx
 C/iwBH/TevVuXeySOPnx2Pqnf+k9KSkjhnNaq70t5aqsrm4mf83C0foJu27Yvn4YutKwAAAA=
X-Change-ID: 20260407-write_booster-889a06cadc59
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775713090; l=1796;
 i=jaemyung.lee@samsung.com; s=20260402; h=from:subject:message-id;
 bh=mjY7/lSHigj6dDK6bqBiBvCSpL1fIp9X6JW1sbVSpK0=;
 b=hP++j+j02YBSjAT4T2RHfxx9Ot33IQPSUR7XiRDWKXjs+DOK7VHRszyD33u2750HYEb/t2Pjl
 rs0WZXSwgwpBeNR91OsHbE8omnNbTA/EhfcU+uxMettS4CowWZpiog2
X-Developer-Key: i=jaemyung.lee@samsung.com; a=ed25519;
 pk=bZPd7A/kteUO62FfUM6IrI1LuBPe5QrcqfvsitM1ZjE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=ldc.jml@gmail.com; helo=mail-pl1-x631.google.com
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
Changes in v2:
- Fixed MCQ idle check
- Added WRITE_6/WRITE_16 handling
- Fixed WB buffer consume timing
- Added constraint check
- Fixed uint64_t casting for unit calculation
---
Changes in v3:
- Fixed constraint check return value
- Fixed WB buffer consume amount with transfered_len
- Fixed MCQ idle check:
 - Added NULL exception check
 - Added CQ pending request check
---
- Link to v2: https://lore.kernel.org/qemu-devel/20260407-write_booster-v2-0-dd772bb30194@samsung.com

---
Jaemyung Lee (5):
      hw/ufs: Apply UFS 4.1 Specification
      hw/ufs: Modify flag handling operation
      hw/ufs: Add idle operation
      hw/ufs: Add UFS Write Booster Support
      tests/qtest: Add UFS Write Booster QTest

 hw/ufs/lu.c            |  94 ++++++++
 hw/ufs/ufs.c           | 597 +++++++++++++++++++++++++++++++++++++++++++++----
 hw/ufs/ufs.h           |  49 ++++
 include/block/ufs.h    | 110 ++++++++-
 tests/qtest/ufs-test.c | 176 +++++++++++++++
 5 files changed, 982 insertions(+), 44 deletions(-)
---
base-commit: b6a7d06213e5d2f7d124d16418bc289c4a8a4b82
change-id: 20260407-write_booster-889a06cadc59

Best regards,
-- 
Jaemyung Lee <jaemyung.lee@samsung.com>


