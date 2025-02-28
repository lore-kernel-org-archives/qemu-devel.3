Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F3EC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxg4-00071N-Hh; Fri, 28 Feb 2025 05:33:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnxfS-0006gT-1g
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:32:33 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnxfP-0003rE-Om
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:32:29 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-439a4fc2d65so19950095e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740738745; x=1741343545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BVzkFSgjMBDDzRoiVaiSW3Wxe54Mxry7NDIS4okWF2g=;
 b=XSPjy0RDOrZIW3cd7fkkyucFGSHgvt8mTMbCh9UZlXHZGfi0CM+KKOJrPIcw4h+m/r
 3k2L67tEI0EXMP+8tA7hoyqOWF0JT6cZ3CXUymvxLbYILXeaUrLvGpDMYZa8byEHuyO9
 HWMwmUjoJWJw+b/1vP72uJqm35i3nfPuR7giq5s8ccEsIN3bX3SE0VELjNNH6cfqwyiB
 4KEBh8JUNrjH9Bs2Nbx8clUr32TcGAd5wYOimp7GlnvmNJbD8qxJE/uEt3xnuuYAdj8l
 u47h0wSyqjvqv7G2tG6qia474JtXG4XTAUsMLmhPXI+tsTeilPXr8Y1a78vzhS7+OejL
 enag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738745; x=1741343545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BVzkFSgjMBDDzRoiVaiSW3Wxe54Mxry7NDIS4okWF2g=;
 b=aGg3J/TU/e9acAW/ijCs5vJ55fstXOhDEnaNfmI1oKZEykG6XeXnnIoGIcnABCsyS7
 woy42KoIKBL4noy3iUZf7dSttZK1v4t8fYBru/uxEUsNxq8onPXhjCWW4VsIktuhuq00
 uRxaescF7H8InZOd8pt2xbrmS2d0Lbz4a4TjEG8h5FAx0R3IZa6mAvjsOxZCaEUaPjJI
 DdEZhvmRmQLIv/9D4t7Cd0LWvIULkq73K3M08h4fhqpD0bjXPiAnmQHMrBFBfXK4gVRC
 3Va2MkZCv7oauSBLpc8HHbguEq6vOOjNM+JEiAGjvUPczltg1IFhXWOBLReMPN6GZgSS
 GtzQ==
X-Gm-Message-State: AOJu0YzGSiOhq3zuPYSlDzydiGK6AXT4ppPkyVhGp8JR83VjyvjjcYi9
 ItcjH/LAdkZcH3N4sGVmbkrtL0ROuEgyzFWvFF47jRsv+5uS2dj46Cg4Hm/1zeFgLiImQw9Qsbj
 S
X-Gm-Gg: ASbGnctK9QA4aUtAxffOWGiV2T3OQA7ah7NcpCmeiQ5MYChe1SNa8RK4TQ4yoH9v3qz
 uaVDhA1UIySDirX543V75s6vbBBfWGYA3Zrq5pW6tVnRR5dxBSTZsiDLWnN0xdELVutcp9a0sV1
 c5W5WhLYzX4greNN8JyNA5M6JCer4fiD2mCCPg8Q0neVvdYY0++bpMYUyWFegzoVDbscpHbnMt6
 wZLzJ/Y8B+qvGOvg15KK3lWk5p9QAEOiuS0SV+X1UlWE+nb/ctrhoha/PWvkGZVzJXM2Dhzdx77
 I3EKulW9bje6oMy18n0EfwfSwSFNxNvl
X-Google-Smtp-Source: AGHT+IE8yAjUsqAq1BECHtRd05mlAH33ccdInlpaTtEA71fCkeHzzlOChtJFQVudymVWJPt16bdf9g==
X-Received: by 2002:a05:600c:3ca8:b0:439:9424:1b70 with SMTP id
 5b1f17b1804b1-43ba675caafmr27924355e9.30.1740738744709; 
 Fri, 28 Feb 2025 02:32:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba571274sm83514305e9.31.2025.02.28.02.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:32:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] include/exec/memop.h: Expand comment for MO_ATOM_SUBALIGN
Date: Fri, 28 Feb 2025 10:32:22 +0000
Message-ID: <20250228103222.1838913-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Expand the example in the comment documenting MO_ATOM_SUBALIGN,
to be clearer about the atomicity guarantees it represents.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memop.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index acdb40a9b3b..407a47d82c7 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -91,8 +91,12 @@ typedef enum MemOp {
      *    Depending on alignment, one or both will be single-copy atomic.
      *    This is the atomicity e.g. of Arm FEAT_LSE2 LDP.
      * MO_ATOM_SUBALIGN: the operation is single-copy atomic by parts
-     *    by the alignment.  E.g. if the address is 0 mod 4, then each
-     *    4-byte subobject is single-copy atomic.
+     *    by the alignment.  E.g. if an 8-byte value is accessed at an
+     *    address which is 0 mod 8, then the whole 8-byte access is
+     *    single-copy atomic; otherwise, if it is accessed at 0 mod 4
+     *    then each 4-byte subobject is single-copy atomic; otherwise
+     *    if it is accessed at 0 mod 2 then the four 2-byte subobjects
+     *    are single-copy atomic.
      *    This is the atomicity e.g. of IBM Power.
      * MO_ATOM_NONE: the operation has no atomicity requirements.
      *
-- 
2.43.0


