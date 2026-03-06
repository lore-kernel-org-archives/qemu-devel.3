Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E6CFCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWeu-0004Ct-Do; Fri, 06 Mar 2026 10:00:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWes-0004AQ-3m
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:06 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeq-0002VE-2c
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:05 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so1984085e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809202; x=1773414002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FCcErO1Lc2GPWXlaYX40kIMgUxc5GPWLVNKDekml6yI=;
 b=EBIU9aF38S+gX9zve7vwoFWZMIUbN2OP8fAG0jduVTRyWUagOABnjh9hpoavn6K+mC
 Me7hGTrYdnuE2QTnJTvAuoshGwIo53CTRJ6G5c5UqJN/Cr9FDMjNC4gsbtXxgn9YcTba
 bbmv87/z7qbS/pUNHyvCcxZuN1+2qbaIS0C2dWTseA39auzAyhi2Cj+WGYnLdmHzCfgS
 scq/3kIdt8H8G3DBa2wQcAL3lED+WVApE3dT31kc6ISLUEXopFR86fTqesWI2evH08Jk
 4V8e1F1nkzV+1rpDbcknyWuQVvPxuplDUXN7J2RKCW8iZBt0NMoC96vuPyrcremQs2LI
 5V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809202; x=1773414002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FCcErO1Lc2GPWXlaYX40kIMgUxc5GPWLVNKDekml6yI=;
 b=rWAk5GXj9VjaGZIRpTVivZyfxuaHKtA+CQTNm6ca0fua+teFoRVUrf67IFsdQPT4qZ
 bXkNpOKpjyRuMmCGB8YjQSI19Ap2Oq5YVaNVB52QyTRFiEzoI/jnezWZwavw1nieqhdH
 xgC6oejIVHRw8K+dhrCCEdk5jbQZ6GFWq+eWdJdjKkMsGIeeMrNb2WDIUXNCXER6S9d/
 CFKwqDUuUQb5dua499kUUUEx+PGSW6d2/t7w1aTbEB26ResdA4oJfz7ucVhrA5xuDblM
 3InPxplx1X81gUpmY6yxvFqJfpZHbnoXoXGEFAL0iywLt6/+8OoQlbQB/dNHFLOJ72fH
 /Oug==
X-Gm-Message-State: AOJu0YwqiTt+kwmvQBQCL8cmkl6ZP1t7reJ1ehQraMJtCMBwPchA53bb
 Mzkjamkj094SGaKpss6/BVzHiYE4P7Xp60L2oPKDtEEjd/9coEeM+Ii1OViR036qCeR1DnRsGgN
 jIDYC
X-Gm-Gg: ATEYQzyV2V2a1ANVlUyORka09PekJOJMNGzGWOMxDRFy5ZJT66qkb8VgA3NNLDUNKlF
 DHGEWal/sr5Kjh7lkxnTnsyGqGPk2MZYUlK/A7e/ivpTBF5v5IXGCAgnSKMq0uMj59Cy9jUdn94
 4YY3y1yo+92bX+B3V1arGVsflncSql0w6yMg7tLqyJ/sP/sj8DNBA14Dmlf8gp7PGZ9sESX84WK
 OlnzwHTwNSZTHQoXxlsVaK46obWz31Rq+dWtn69S9LFNo+WG/pjtVnjhstqQV5VYHi9zJnPD24t
 9B/uW0DEQDdfZhUG5FOPBpCelo51/Q7G1K1eyShnQdEkJGSF8jrZ+rl2MbYDWolD4YMaDT8iTMU
 XY1keRHA9VzZAZvMlYEvoOOUG0VGXLbn6fDhtdvnY1+IEOtPnoGLoMECJjAbNRE14j+iRVPMEpV
 o28S66Dj9znidk0H+VYlcG0lU7E1UXPFLu1Zh9mJG8JVLTEsNoaiKOVrtzoqKCoP31y/Zq2ICL8
 npb4c/JExuvVwZ0qTBe0ECWBnI4NGw=
X-Received: by 2002:a05:600c:1d04:b0:477:7af8:c8ad with SMTP id
 5b1f17b1804b1-48526984073mr40690805e9.31.1772809202220; 
 Fri, 06 Mar 2026 07:00:02 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/49] scripts/lsan_suppressions.txt: Add more leaks
Date: Fri,  6 Mar 2026 14:59:12 +0000
Message-ID: <20260306145939.2162189-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Running "make check" with the clang leak sanitizer reveals some
leak reports which are either not our problem or else not
a leak which is worth our time to fix. Add some suppressions
for these.

While we're touching the file, add the usual SPDX header
and a comment explaining how to use it.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260302092225.4088227-3-peter.maydell@linaro.org
---
 scripts/lsan_suppressions.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/scripts/lsan_suppressions.txt b/scripts/lsan_suppressions.txt
index 7d90c280d0..f88bbab18b 100644
--- a/scripts/lsan_suppressions.txt
+++ b/scripts/lsan_suppressions.txt
@@ -1,5 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# This is a set of suppressions for LeakSanitizer; you can use it by setting
+#   LSAN_OPTIONS="suppressions=/path/to/scripts/lsan_suppressions.txt"
+# when running a QEMU built with the leak-sanitizer.
+
 # The tcmalloc on Fedora37 confuses things
 leak:/lib64/libtcmalloc_minimal.so.4
 
 # libxkbcommon also leaks in qemu-keymap
 leak:/lib64/libxkbcommon.so.0
+
+# g_set_user_dirs() deliberately leaks the previous cached g_get_user_*
+# values. This is documented in upstream glib's valgrind-format
+# suppression file:
+# https://github.com/GNOME/glib/blob/main/tools/glib.supp
+# This avoids false positive leak reports for the qga-ssh-test.
+leak:g_set_user_dirs
+
+# qemu_irq_intercept_in is only used by the qtest harness, and
+# its API inherently involves a leak.
+# While we could keep track of the old IRQ data structure
+# in order to free it, it doesn't seem very important to fix
+# since it is only used by the qtest test harness.
+# Just ignore the leak, at least for the moment.
+leak:qemu_irq_intercept_in
-- 
2.43.0


