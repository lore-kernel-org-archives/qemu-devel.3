Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E53E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 00:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJLtS-000586-WA; Thu, 05 Dec 2024 19:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takeshibaconsuzuki@gmail.com>)
 id 1tJLtO-00056t-H4; Thu, 05 Dec 2024 19:08:22 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takeshibaconsuzuki@gmail.com>)
 id 1tJLtM-0000fa-9e; Thu, 05 Dec 2024 19:08:21 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3ea4f9825f6so468411b6e.2; 
 Thu, 05 Dec 2024 16:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733443698; x=1734048498; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jpFDBGvKaWqPHra1Mp+6gNMkQKP06H67VZjifeZ9HBA=;
 b=K4oNbJh2xQTMqksxBM147no1IxleAFAjpRvMVJgfovvQ1wfLrKNlnu+Nu/DqF9xMru
 6E4mXC6POjQ5O+JBTqCwB4VWmNw6ZAZ+HVTKBdJacUd6CwjQoIU3Jxf9F/jiePv7yaGe
 tYJaHOh5Zv3FhXS7clwIC4WVSb9CdYGJu3n3/6Rmp9jadgKOJ4T4kWPHju+VjOrqBkkZ
 YUIkf3whEYrtG1npTxgY54q4mEm196HUSqiEPK3nluPz66bcBUqHAGkoawomTJ9na6Zj
 BaQcEPsiDOskNJp9OV5duJEhI0J4Oiplmr+SWj+s0HMJMiPIvjZCBfWcTJaM3FssHIYs
 Eigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733443698; x=1734048498;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jpFDBGvKaWqPHra1Mp+6gNMkQKP06H67VZjifeZ9HBA=;
 b=tWcz6I1PjNJY8OR/moDvRBGWVgliFatzhSIGSwDtPk9JkvzRpt+CqiT3K2Jgx7WqWf
 tYSQ10ee7OctSs2JrHQpMyylIme+avu9SUd0vokNiYnbpciyduo7P1hDKlNEuwK3kFGz
 pPdYfDg7vvz7DA9P1Q5VuVktQNtjhnckK7HY5XLWJplgXCQNVCpKQ0dl/NoCujeZuA4+
 2mOZHx2zklpn0+gZrx2/A6UZRkpKEPpIMu5v6x6BaeinuBaYT0hB9oJpd9MJaT0fPUyr
 MMZWoK2r1JJ7a2RzYS0BHOoQNil+aANOlu3JcqBF5gLNBmFjfGRcIyhqC1YSHFWq5lPu
 1AFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCt3J9id0BtHKIFH776bzDPJ+5u2nPkFSgpbc2YLq/IIW5HVfjB4xyo91vSJKyxzBaRbWdXKb5DyCK@nongnu.org
X-Gm-Message-State: AOJu0YwMCoGJaMaARgPJDxbuwCEdwb1VU9zmLFlhy7hXZfzrxYcg/gWk
 HTPtObDTqQNuL8biuS1gFoFAK9BcAf0DXPPreoFMLXEfvXZJRL09gMHtCecJ
X-Gm-Gg: ASbGncuYx8d5AbWRvRW+mcmp2Y53h69NiLhXrIMHxVlyu4xabRjmOBby9cqoGEXSu61
 JaMk5EkDWl/7GOasSBSetjyIfSG4fphfRyQc50pShQp/ABiNpjXV+1vJz7/YXOm5S5ei0VMksxx
 EDcnPoFygeDsVbMdUkX1DUkEvyWcNxLdNmvfHcHxKeYtWRRVzbEtvfSJg0tzQL9i6R83hQeeRuq
 JdsKLtLbpxHXNslD4CmUAPeR6Ny72JXatMkcZazV+lRMxspFqDZ5mrhUNWzM5jX1BR3np02Uchj
 56aGG6/zVXyVsxQoN2A=
X-Google-Smtp-Source: AGHT+IGJffJjaGVziJTrrHBcq281iA8MO2TtM7lwgC0YuSPImEMPUetlmk78/xUo642sOlcAMeQ1Aw==
X-Received: by 2002:a05:6830:610d:b0:717:dee5:3876 with SMTP id
 46e09a7af769-71dcf4e7e3cmr555833a34.16.1733443698422; 
 Thu, 05 Dec 2024 16:08:18 -0800 (PST)
Received: from takeshi-suzuki-dev01.colo.rubrik.com ([104.171.196.13])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2793046d9sm486212eaf.30.2024.12.05.16.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 16:08:18 -0800 (PST)
From: Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
To: qemu-devel@nongnu.org
Cc: codyprime@gmail.com, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
Subject: [PATCH v2 2/3] Add iotest for 4k sector size vhdx
Date: Thu,  5 Dec 2024 16:07:50 -0800
Message-Id: <20241206000751.34694-3-takeshibaconsuzuki@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241206000751.34694-1-takeshibaconsuzuki@gmail.com>
References: <20241206000751.34694-1-takeshibaconsuzuki@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=takeshibaconsuzuki@gmail.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

See
https://github.com/takeshibaconsuzuki/qemu/blob/vhdx_4k_rw/tests/qemu-iotests/sample_images/4k.vhdx.bz2
for binary file.

Signed-off-by: Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
---
 tests/qemu-iotests/315                       |  65 +++++++++++++++++++
 tests/qemu-iotests/315.out                   |  20 ++++++
 tests/qemu-iotests/sample_images/4k.vhdx.bz2 | Bin 0 -> 37834 bytes
 3 files changed, 85 insertions(+)
 create mode 100644 tests/qemu-iotests/315
 create mode 100644 tests/qemu-iotests/315.out
 create mode 100644 tests/qemu-iotests/sample_images/4k.vhdx.bz2

diff --git a/tests/qemu-iotests/315 b/tests/qemu-iotests/315
new file mode 100644
index 0000000000..e5c4978c8c
--- /dev/null
+++ b/tests/qemu-iotests/315
@@ -0,0 +1,65 @@
+#!/usr/bin/env bash
+# group: rw quick
+#
+# Test VHDX read/write from a 4k sector size sample image created with Hyper-V
+#
+# Copyright (C) 2013 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner=takeshibaconsuzuki@gmail.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt vhdx
+_supported_proto generic
+_supported_os Linux
+
+_use_sample_img 4k.vhdx.bz2
+
+echo
+echo "=== Verify pattern 0xaa, 1024MB - 1088MB ==="
+$QEMU_IO -r -c "read -pP 0xaa 1024M 64M" "$TEST_IMG" | _filter_qemu_io
+echo
+echo "=== Verify pattern 0x00, 1088MB - 1152MB ==="
+$QEMU_IO -r -c "read -pP 0x00 1088M 64M" "$TEST_IMG" | _filter_qemu_io
+
+echo
+echo "=== Verify pattern write, 0xbb 1072MB - 1104MB ==="
+$QEMU_IO -c "write -pP 0xbb 1072M 32M" "$TEST_IMG" | _filter_qemu_io
+# first verify we didn't write where we should not have
+$QEMU_IO -r -c "read -pP 0xaa 1024M 48M" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -r -c "read -pP 0x00 1104M 48M" "$TEST_IMG" | _filter_qemu_io
+# now verify what we should have actually written
+$QEMU_IO -r -c "read -pP 0xbb 1072M 32M" "$TEST_IMG" | _filter_qemu_io
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/315.out b/tests/qemu-iotests/315.out
new file mode 100644
index 0000000000..31dd48b223
--- /dev/null
+++ b/tests/qemu-iotests/315.out
@@ -0,0 +1,20 @@
+QA output created by 315
+
+=== Verify pattern 0xaa, 1024MB - 1088MB ===
+read 67108864/67108864 bytes at offset 1073741824
+64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Verify pattern 0x00, 1088MB - 1152MB ===
+read 67108864/67108864 bytes at offset 1140850688
+64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Verify pattern write, 0xbb 1072MB - 1104MB ===
+wrote 33554432/33554432 bytes at offset 1124073472
+32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 50331648/50331648 bytes at offset 1073741824
+48 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 50331648/50331648 bytes at offset 1157627904
+48 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 33554432/33554432 bytes at offset 1124073472
+32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+*** done
diff --git a/tests/qemu-iotests/sample_images/4k.vhdx.bz2 b/tests/qemu-iotests/sample_images/4k.vhdx.bz2
new file mode 100644
index 0000000000..6cc10919ab
Binary files /dev/null and b/tests/qemu-iotests/sample_images/4k.vhdx.bz2 differ
-- 
2.17.1


