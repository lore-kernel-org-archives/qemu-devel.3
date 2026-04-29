Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA659FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6CA-0004wp-Tg; Wed, 29 Apr 2026 10:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Bs-0004VI-MC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:07 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Bq-0004Zz-P7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:04 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-42c08cbae4cso7342893fac.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777474021; x=1778078821;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3CPXyrU6scI+xTi1TnD3MNp9VsbfveDSzhlCE0CEV+o=;
 b=DyuKJckGB8ZRjAhva8vGoZEs3wSqcq8tk6uaKVJommSipDyBxXH39yuNvR+O65X8Oy
 Ghkzy4cPAf1rN9ZOKzuEOYWCfQrDzvMKvBZR7q+2zCpt6Abnvoqm4BCe7WnBZNbZkii6
 5vy/qQypnzjg/E4hyYVq9+NWVcEbFg3yAVK6G2GrxgyOYWmYGbPFZGiyQOlkbZGtBlBC
 ow1XbYOfXwwdYhOoGFQDmPgn3HS9iNUKLm/l5E5FcvMhDbN/A+CZ/rRuQwddmBZs9/Ob
 ecCNj+Y1J1PHlNXRFslhCqtib9oTO+cxJVek47k22Wnu6ihbnDLC8et/+haLMw3XPZ0p
 hY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777474021; x=1778078821;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3CPXyrU6scI+xTi1TnD3MNp9VsbfveDSzhlCE0CEV+o=;
 b=P8lEAwdr0rlgZCrn3TF7gvabi5qYS5p4fgnrK+YSLjDW4qjQTYZ6eHwHZIDa/XqQe9
 wzZwb/fwSJWaobb215OV0M4hCAe6SXkkAVsHOepxB5OyIqT8ahaWPnaRAbusMGuLCPb2
 HvPkBlwfsLCCMmctIJE22PWk+bgSOskmQ17miCkz5wnQ5L4ZNilPhLgUlzAusuxC5rt0
 tTFp8sMxCnndh30/IQnRh7xyBNfgYAnMa+/NYPdWWO3ny17QuIASJ13z19oWoBPbMY56
 4n3jk/Xqy/rVO0bjTvboJYvxuiQDjty5pfFgdEYBFrdOWVR1JVzbcFIVjZtkEBt9oT91
 mdkw==
X-Gm-Message-State: AOJu0YwhibHS0Z/B6iKYTY2SbRJQCk0b4GpCij7/Z6Ct4RZWu5hP9tW0
 7HJnenF1AZ27qFXxu7FChRlQ19oackYQqKtADPdDfbDKKzdWb76OciQ51oedMbEHbr9k0l4jEQ7
 nL1/IIdE=
X-Gm-Gg: AeBDievp+JOkeT579wh4LXvY4SxmA7vRsfSPgyVOK4OUcJo3WVZCh7nM8Hte1IctMHB
 Q3k0MC1dnd44aFgnZDPXHpjsuO3rvi4QXhWKMrjAKh39hDPDWpCnb0hsIKxRFXrThvPEhDeIOmT
 88tb8LJaM4wJSvGRF50EjcjWgwG3A5UPdP/8tTbx1hQWN4vlxGxlCTXSMsYG2mtb1V8VqHOF8Nk
 7gINDxo+7/1IKhyJDkt04mC8ypZ8KN1Hqjbr23f7rLakZPzjwt14A3Mb/IzRxcn2MMiFqOC9nOD
 oeDzMpbl5KfpkQUPBG8mEfq95miZCjAB8T65/tZyoCvGIKBa55GoTbLnI49K0TxfLpHTWe8E+6J
 NqBRCpga3jLcdhqjUWFWxdc0CN1q6QHt6swaoPGIPHzUeBCp9hf4ries2ZlSNHo/WgBALzfL7fb
 U2IN5oYctSO3zygydjgMYk
X-Received: by 2002:a05:6820:2d0a:b0:688:7dbe:5ff7 with SMTP id
 006d021491bc7-6966852964fmr2093531eaf.56.1777474020863; 
 Wed, 29 Apr 2026 07:47:00 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966b93d58csm1313984eaf.0.2026.04.29.07.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:47:00 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 08:45:15 -0600
Subject: [PATCH v2 09/17] bsd-user: Add bsd-ioctl.h header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ioctl-v2-9-288639bc2427@bsdimp.com>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
In-Reply-To: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=yeGavK2BMRJ20mAsfFVakCqJnM3dMDajDrM0UbXfJQI=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hl9abMv6l6jkZO0Rtj6FogD0gZTEESPIMM8b
 uAcw+PcwzaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIZfQAKCRBsHNEofbAR
 AEthEACzZvM7X2dooXxssTJplbo+vejJWb2aXrNUVMKBuVGjA4izocQ8B1ItLE/Y9MFGzPok+uM
 IUWIRsZI+tTeNv0kW/K7n7iksPq7woCovAyJS7pZl/EW+xYYdDFBCUt1q6mDoGuvz7pq1lKrpRD
 hehj86OOdh3AowbyCKjQNpDPmQByiJsoURvfT/OTAgn83I2AEhpMFdHusL5Vmm6yFTLgqczHS1N
 jVE11eOMN51rCdJ0p1MWuzP/yfaqzzw6ICcsiKv+UmquFOAHlFXyN1v5svsmjvp53OuKzD8ydiB
 JResj3bGQ0VUUVxso2g9XEC3191xb8vuGEZSKatUu13E8fQW1kAhrCSFTXHAP+DIkZCwk1/7tYI
 K01mIk8hYkbAnu6Ta1YsJoYFmm6FQIRMqiZcFEv3EfkXy+C8fmymutJztuupouTIUv5UfrHYFpn
 9s77iWRYYfyhiiMZs3KwgD5q27eaB4B4Dq0M0eisv9fTPxUmGWLSZIAgD4ch6jqPK5NJD5DahEJ
 mmOnuuc8LYRVN3ryjcNbhLNEEUyMR6ovI8A+e9GV5B4z4kmvC8C3GN4E6toT4GguFYJo0pLcIDp
 f+ccRTVsetuCHl1IASEmol1z/LJ625UMEamRWHXOIHA109EMxi3fmgJLvPWucDDlzZSlSYIqVtv
 vq/Z8oZP5qihz8A==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::33;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: "Stacey D. Son" <sson@freebsd.org>

Add bsd-ioctl.h header declaring the public ioctl emulation API:
do_bsd_ioctl() for processing ioctl system calls and init_bsd_ioctl()
for initialization.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/bsd-ioctl.h b/bsd-user/bsd-ioctl.h
new file mode 100644
index 0000000000..bf9bb72bc9
--- /dev/null
+++ b/bsd-user/bsd-ioctl.h
@@ -0,0 +1,14 @@
+/*
+ * ioctl system call definitions
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_IOCTL_H
+#define BSD_IOCTL_H
+
+abi_long do_bsd_ioctl(int fd, abi_long cmd, abi_long arg);
+void init_bsd_ioctl(void);
+
+#endif /* BSD_IOCTL_H */

-- 
2.52.0


