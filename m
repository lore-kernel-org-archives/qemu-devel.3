Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11119F34C62
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCJIH-0006Oe-Ij; Mon, 13 Apr 2026 11:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wCJHQ-0006Ft-BY
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:32:55 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wCJHO-0002xI-9U
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:32:51 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dc51aa8926so529894a34.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776094367; x=1776699167;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p8flATCTFvJmTNigBz62WZwryf1hbuOJQ5x6dgfM2bI=;
 b=BitGBQrwmpBnySdKGHhNuT+aPhRoDaHV4njo1tBT21zMVF9+CcjoeFEbQJldRIDkVH
 4j8oIRES7bglNI8rYAtpQP06jMT8pHsbGQWqw5kc3i398ZglQjWQrgZX12cS3lB6xP2t
 6z1GXy4sH3Hx02AsSAerBU2uNzWgyqt557SGu8OC4M8F5Pg7aZSBj1tQyv7GQ3mvKO8M
 EBTfevDkbe37nqJdbiw/jwnDqxHzmaO9MQnKj5IpfvVA2hNhAjZfUDzh/c8dNhgPGkzh
 tMa3qVSc9//ca24mC4ZCu8oA+4Xcj7qa1RlJA9IXU3G8G0bAxloxkGfKcFrjSwC3SteP
 JufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776094367; x=1776699167;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p8flATCTFvJmTNigBz62WZwryf1hbuOJQ5x6dgfM2bI=;
 b=H9suQgNnthEMu+MXFzq6ZP6/18c11RMzd4YmMtR0Mn0irg2vQbILCMfwMX7yEvURlZ
 l4jZNa3AbBae7Lw9nDhwK85hpQrsdBen3PEo1REoLPg7QJCF3iBjUJXQyEBJ2PIJiDlh
 ketZQWWc/6aJWF5VVK2F39iam7jrshZf5f5IZXhXIjZvKbzY1VM2T2FytRHMgZ2CGju+
 uD/HcLx2cPHgtwF9qbhGlNgG0CQ6TRdo33dHI70U/bvHGvkVwVM2A6o+KWi4rqvie0cp
 YYWF/92rQvxG3OCTp00R9EePgXLqOK3ei7A5g1dCfp0PjaBz5llE9ECfmdOS37O2M2Rc
 URAg==
X-Gm-Message-State: AOJu0Yy7HWFHqC3urBn3AZN6TQ8mMuaf5dRE2m4iZ9cxcOJ+boJiV/Ti
 CErdvxPXHoqiaGYuU822cvCgkPlYUGA1QkMzDTI/oTu1UVwgksju+u+ebYww82oyt3s=
X-Gm-Gg: AeBDieudf+wfIujX+Ceb+6c9qus6eNm8u7iG9SYA+f0Ds8WsO2LoyAsS3dSk89HYfLD
 pkNfHU6TZHL4a/1WO/J+6krl5N2Qg/B1PMKfvPWYcf9gjNW1JgmV8nnVVGIXmK3BVHB4q5bpUWN
 ko0mYMJlIC4mUq2Q3yg21MKtyYTcFe3E2HfClAll34B2GmALWa7ahUykkn42t9OgC2/Dql788yx
 sQJocx6vkwrL4158v9zWk3QAJv6rLFvujN859Z4UWR9M0W5pBo8BhJJ8gRk9hjezes48JDsQi6G
 8hPx0+CrNaKFKWnqT4ugqLcIWTG9v9D4y83wK1tQa52hgrXuh6X+rM/5U0wftpW/ZTVMJ+JdTB+
 l+3mVOKu7qmzDT4bGv0jZMkDiqBTBjE4Npf+ryYNskfqRZr5VD2XbrBGoPmwfD0E9kc6P+bjAR3
 5057F/j6PRrA==
X-Received: by 2002:a05:6830:3745:b0:7d7:da05:f2d2 with SMTP id
 46e09a7af769-7dc27db657cmr7729529a34.16.1776094367066; 
 Mon, 13 Apr 2026 08:32:47 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2696c463sm8659192a34.23.2026.04.13.08.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 08:32:45 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 13 Apr 2026 09:31:43 -0600
Subject: [PATCH 1/5] bsd-user: Add syscall header generator for FreeBSD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-syscall-nr-v1-1-f70408d042ea@bsdimp.com>
References: <20260413-syscall-nr-v1-0-f70408d042ea@bsdimp.com>
In-Reply-To: <20260413-syscall-nr-v1-0-f70408d042ea@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=857; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=fof4bImZJvo4ztTvD6J1tAomn9HYbUnurdFsWDZ6e30=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp3QxoPAjVEDJO3ceRMmPJV1HkqvzUR0KbW8UuF
 IflzpeBX5KJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCad0MaAAKCRBsHNEofbAR
 AMw5D/0RV2hpaSzM7H86Gn96iuADHwgXsznuBWO5LQ5O7/SDNJFYoh04AO78YN4I/ipR6pvlqPa
 TamyOgvdShifmzzTFot59lhoV3vvsazRbiwRB1aK8qlXTEVZXAw94qp6aq+VQUi0HkPOokKqSA8
 x60yr/W7gm9KBst+JkT9Nx9WEi/k7KGXloFjnM9LBhA+tP8rJch5I8A3vKOsKSJDZDa2A7FliTB
 nhNuHBmW2NDKzB8g8BEPUybwiaclaTnmBbaP8X76f/q9N1A0gVZK5KRvf4TYSABfHITKdaJZ9zt
 VfrwcY5LeTzN0H5Pydver5wzTx8lEjr/FGoSa5St5nJhC4zY2vzMKCnv96UWapwvVqJ1Q/I5PX0
 5/D1VOSm3T1lwiGw0ch7sKazDs7aQPbGI1qICne38zIacBK+IQCwKRuKBM1EH709T4Ie/QFG3AN
 09mFa4bRPnxGojMo3pro9K9zgmGkENFMSbBtF4fHmvA7kl3D8lK/vmP5S11+5M72eZ20PL41PyR
 i1koRVeLAQyMXBlZNY/3SBnmf3jczTt1PqsG95fZ4fSlNRwuA2H9rwgmxCTHeYeBs5O4TnUv/Sp
 QfoHZnV1uJxVVo897Z2VrBkjsjBVzMMMsi5ic7V6str0HW1kO0XVezyKLbv0++ywk1FdUtS9iLE
 2E6u5F0EFQ1Io2w==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x336.google.com
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

Generate the syscall numbers from the installed header that has them.
Ideally, we'd use FreeBSD's lua infra for this, but that requires that
we have those files installed, and they aren't quite the same across
supported versions yet, so use this simple, but effective hack.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/syscallhdr.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bsd-user/freebsd/syscallhdr.sh b/bsd-user/freebsd/syscallhdr.sh
new file mode 100644
index 0000000000..fa38500775
--- /dev/null
+++ b/bsd-user/freebsd/syscallhdr.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+# Copyright (c) 2026 Warner Losh <imp@bsdimp.com>
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+in="$1"
+out="$2"
+bsd="$3"
+
+awk -v bsd="$3" '{sub("SYS_", "TARGET_" bsd "_NR_", $0); print;}' < $in > $out

-- 
2.52.0


