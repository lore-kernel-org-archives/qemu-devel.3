Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB5DC98312
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 02:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Z4k-00025m-Ao; Wed, 23 Sep 2026 22:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x9Z4Y-000227-05
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 22:20:30 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x9Z4W-0003S3-8J
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 22:20:29 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d43da99easo22240367b3.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 19:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790216426; x=1790821226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AeRTNlYoFQKj0WyuA5nvHcdNS/8lp3g2uXsLNvswZPo=;
 b=b0XqyDfQ0Y/vmITbO4r0CWBnViCLAWLOUSnOt96GK1t4TJ1TlGmub1qGAXKynJ+kPv
 8BOkgdOo6L9ExDojQIflWeALOiSrvd9bl48k26X5Chs+TWaPbYCeoYD+vy+HniX+VfUo
 YIl7i213e3nNoTq0BiO82taPnYk1nfpjIaIqHywCyww611q4MnD9JBnMlnl6lrfR9nfw
 7RcjIKJst+6b/a9mAfAdrqUJ3cajc2A7j/+/p0/tyZOVNJ2cGTCYZLYkYloN4cTyDsnT
 C3H3rQPKosYaIpq8acU5JD5Z/kK7yVYa44yZEF7M/U0+xN/4E/H1s9Y+berNZEEcBeFW
 11qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790216426; x=1790821226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AeRTNlYoFQKj0WyuA5nvHcdNS/8lp3g2uXsLNvswZPo=;
 b=I2U0PBR2A8/x0TodXc++G6lcrjYKV+mgQjBjnIHhSCwgWJcQ7HXCv3tBXehIYJSOsR
 Z3YKJujlX+n/4g+r1FXvw+qj8z2BI2Jz4kvjFCkTFBydrU9JhU3m1IG+gKzvcWCr8ePO
 t8KC/Wopz1XbiHTFJc7D5Rvp2Dx9gdcWUsaDzeyBnBPybH4DU95rwG/DjC2zEvtayNN5
 VsBKWaVbIoguqOEEk8A6uE9wxYME/tevyIEDooen5kHKPRpIsLgg0hqqtwvuiMQUKIoN
 4On1UiIuKolECI+32TWbBzg5dhraaqpPZmSK+Wfwyb+Tlm9goR5sfoWlrJh7vj4pKgEt
 LXIw==
X-Gm-Message-State: AFuF++nLobHULoXl/N7iAYoufjH6oWtd3eH4ubT7lgBbFWJK4oSriaqf
 AGR/HRr6VYUZJfdlPIR6Jrr4MB3kc6v/+TIgPbJs792zS1epC7QcwRkNE/4ggA==
X-Gm-Gg: AYBFou2BLeItVHeCeqyrHPP1i5RQEp2inmIPJXQmYCMhP2pfchBbvGHYPvIesr4MSpG
 LjdQccMedsNyPt3UiqxEP9MaIC8K3e+fRTZFbHqP3iNk+h727nJGzAZH4JxezKJZoWDuCYPxFjP
 mx7FpjarMcEGwuPOBLVD85EJmW758tQ2oe16EuWWhRJ/xeCCu04PALlcxajtvRu0/3fXJAR8qbp
 rm/oyeKMIXZOmXt7oZFI4NtmDPD3F0XAWpZWvNaXXXCBUHKFeJnkyeU7J8jqkGHQz7qeml1kh1M
 dxBksPkP4OJ1s+snMAjGvQwUX31ILSZ4YTFBHvmDnNCeKLcq9//icjPXT+K3AsTFOWGC8tliJSj
 cMJV9iKYdy77/p2003vcUETtD1AYwh4u231wHvERoyp/4+eBetveS6MwG2lKme7D+G0E6RSKMpa
 fYlPqQ52u3EnAdbIlNkt08wHUbdUfmRuVqdalFrhVk2GGEX4saNB+3cv4WFxahdpSsnbvCAAI=
X-Received: by 2002:a05:690c:e686:10b0:8a4:a988:3e9f with SMTP id
 00721157ae682-8a64c93aba1mr4066637b3.21.1790216426366; 
 Wed, 23 Sep 2026 19:20:26 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a6516163fasm3446247b3.14.2026.09.23.19.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 19:20:24 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: Iain Nicol <git@iainnicol.com>,
	Matt Turner <mattst88@gmail.com>
Subject: [PATCH qemu-palcode 1/3] console-low: Fix off-by-one stack corruption
 in entInt
Date: Wed, 23 Sep 2026 22:20:20 -0400
Message-ID: <20260924022022.2414514-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=mattst88@gmail.com; helo=mail-yx2-x10.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Iain Nicol <git@iainnicol.com>

entInt stores nineteen registers, not eighteen.

The corruption would sometimes manifest as a memory fault. The
STACK_FRAME macro saves the internal PS register to 0($sp). The same
location would later be overwritten by entInt storing $at. Later, the
wrong PS register value would be restored. This would sometimes cause
a switch from kernel to user mode, which can cause memory permission
checks to fail.

Closes: https://github.com/rth7680/qemu-palcode/pull/1
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 console-low.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/console-low.S b/console-low.S
index a03f4ed..1f61cbc 100644
--- a/console-low.S
+++ b/console-low.S
@@ -23,7 +23,7 @@
 	.text
 	.cfi_sections .debug_frame
 
-#define SAVE_ALL_SIZE	(18*8)
+#define SAVE_ALL_SIZE	((18+1)*8)
 
 	.globl	entInt
 	.type	entInt, @function
-- 
2.54.0


