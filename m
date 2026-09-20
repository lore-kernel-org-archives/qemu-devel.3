Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004FDC982E6
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 05:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x89z6-0006Pt-U1; Sun, 20 Sep 2026 01:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89z5-0006Pe-8s
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:03 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89z3-0002Ag-BI
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:03 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-47bc923fe6aso1503794fac.3
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 22:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789881660; x=1790486460;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6V5UnG6RmUulxREI0l7aBT9xjt6N6KygHuyrepAEL2E=;
 b=Jqnd6GdYF/npZEb6/FXv5hFdOcA6DrafjUhzaf1kNW49GQ0zIGdP6PLuudKitxoS/u
 ZeBqlxNxUWicEDR0eupWqvh/3jjWxDQoMTRwkQsAGbcRwAgB5N1jYblIjXhYLDRRcP8i
 PVTpF1M6ztaEufOsT67+/eMLG0ZdTnhoEpuGAHeCI8lRrwmQT8lJavIQ82KBdRrYCqr0
 pvKn+C25ENh4dpAmOEJG2EVdhl6ShoMzOMGYF1pgRp1FO1kAXYDQBcvMVPi4QfQ2afzI
 x1v6MniAX6L10kzeHFf0I8pqvHC4JrB54r5wjXTNoFI+78+yz10XYUPdQxn6QIWTR1WN
 lQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789881660; x=1790486460;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6V5UnG6RmUulxREI0l7aBT9xjt6N6KygHuyrepAEL2E=;
 b=KlE2UGkMqbr7LO7xZIgvdeEEPYnTxHTK/D3tFiHT5nka3VDbydVHmoM2QE7qP+7Ayk
 FENP2+z8Se4o1/zlB/FgB/D92kLoBGBhLiIRiCQrvhZwTzPaARfKiDatY3947osgKSMq
 w0rE4+G1PRok25X2DXBCKKT50Y4HaTn0ZWRLvk+xKa8bpoRPbs9TY7TlCveCpNDSh24U
 eikZrprxl4uMrS3DigSj4FgF/lJ69xSuebSJQP1dzxt++/GbBXG9DkSrXrbrWnbYK7M2
 34RFNkDrdsvAWRsucuBpp3AmkMfcVxUzB0NJdMvEsPFZyAXhkgmOo1xSE+OFYgzrwwVm
 iPCQ==
X-Gm-Message-State: AFuF++l8fvDXAiOziGizV214uEGRBErjYp2EXDrrWuT/byGqRoMn9M8N
 0Tn3SrK3sR/9fUS0STJayVNC54qsJWmjWqBOt24bdJGSDogf+dtMe9YB4bmyS4jGQ0M=
X-Gm-Gg: AYBFou39dckCv36Zzl1An8QKddegaJeI+8Rj4+E8FtK+0p/2B63gX4Zx3JLvYarwEHL
 nwb83UjXMjMp+tYsgMO/51vjkl/27VEfaWT9N3er8OmP3357gPFYr9E+JLFGHKPI/1FtJEMkvBL
 aG6yTz/ZMfYLhgVCL73gMCwtauacGpHCBnkbmvswlnIWOn304Y2N4rto84OddeI5/ewjcOp2j8s
 MimnZgEr+ms4pzNhfI4fAZwveP8uuGBQEdqvTTQJFl+4ReftdJQy8lJelQ5bF023y9DoY9/LvFD
 wWOp+mDcXMkTx/e7swo1wwCVx1tigkxwx7ZnLrkWImtQshR58/iKUPcNrLJA4VqeY5t7YlfqiKo
 YxNdkSEFj2C/ILkVK+orOJzkefZ3m5xhLwWChnC6svCfnl9NgvnPYRuNc3d0OKnZeAyZkYBWQbB
 wRgNii69Uw4xpPIPNFw5Oz7vTA/EXcSWpSZlONbAAQCC5RH3T4EbVf237dvEIQONfEa9nE
X-Received: by 2002:a05:6870:420b:b0:475:e2e9:4f50 with SMTP id
 586e51a60fabf-486e819aaacmr6595955fac.30.1789881659794; 
 Sat, 19 Sep 2026 22:20:59 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48821db3b4bsm3936865fac.17.2026.09.19.22.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 22:20:58 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH 00/14] bsd-user: Upstream a few fixes
Date: Sat, 19 Sep 2026 23:20:36 -0600
Message-Id: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACRtr2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0NL3dzM4mRdIM+00ETXzMLcNMnA2CglMdlcCaijoCg1LbMCbFp0bG0
 tAH9EDzxdAAAA
X-Change-ID: 20260919-misc-2025q4-6875b032dac7
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 Rick Richard <rick@sloservers.com>, Maksym Sobolyev <sobomax@sippysoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1801; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=5zJ2uc+M3JTD3Z5dS7xnkwUfp7DLmzQjjKMgo79fdZo=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqr20pEtjvT+jg/oMMdz/5JyUf4h1PLaxbjCgVf
 TWK6Dbag3aJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaq9tKRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQC8DA/9EJvoNdXUfFIe60ggkX3HZw7/D6GNXqM
 NTEUG3Zf82cMRgnWK9W/mysPregRyiUSWXPboaMnx4uV48rpo6PX8iUuWvg+FBl78FkNYvlSIpW
 tJIujXyI/SDZAd+L7sWpbKT9jRnNy+vcvftlbEquoiLkUUNAuxiWDu+UEeZnMAjOSFONGeAxkS7
 XSBOKOtYVfWmoFXTh+v6sNM/wKAtaY3nkUPIRwhudlZO/r/RbWKrRER2tjJPvOtG3Aefo9DPtZd
 Qk6iYEqqoTb8c6fFWRtn+ushVFve01Ec28LRfqBqYs0vGVYtWrP65OXTFujy+kM//tux9Mi71Qj
 hwppTT5Dd3eTE9z6LmrAaXvraGt6QcUWWvaFLtAlyrSiouN/EJ1+Ain6tSdAh48Y5cWwBV8Ff6E
 4iY92MFYaR2WnAOWe7jwZ7a0Qax2My7Coez4IeYxjmbqWxz7X9b117qsk86cE3klaq/BH4zJEkz
 UB1e4rL8gVyQMFC/abRcUJLv0pUwlBUCzC4lghkoXoeS6b/FwlcVwbz7rM9f2l6ikc3xT/ajsTl
 z+sq6T7s8V3NcDq4YPbsSdVhWdSE6g07KHhsQOT1elSbhenBCEKGkqYGmBiF/b4Pn+ihYSZhx9V
 4GuLDEfJBc8K5orb5ee+6Gk3B9rlF7nkUGWGHRl8itYyMNlRRzBc=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:30::10;
 envelope-from=imp@bsdimp.com; helo=mail-oa2-x10.google.com
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

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
Maksym Sobolyev (1):
      bsd-user: Fix non-PIE binaries

Rick Richard (1):
      bsd-user: HOST_BIG_ENDIAN and TARGET_BIG_ENDIAN are always

Warner Losh (12):
      bsd-user: Drop support for FreeBSD 12
      bsd-user: Flag shared memory as needing atomics
      bsd-user: Add gdb for system calls
      bsd-user: Initialize per-arch child registers
      bsd-user: Fix crazy bug with mmap
      bsd-user: Move tb_flush stuff to begin_parallel_context
      bsd-user: Fix MAP_TYPE definition.
      bsd-user: Implement exterrctl(2)
      bsd-user: Implement sigfastblock
      bsd-user: Eliminate unused regs arg in load_elf_binary
      bsd-user: #ifdef sockopt that aren't in 14
      bsd-user: Remove host-os.h

 bsd-user/bsd-file.h               |  2 +-
 bsd-user/bsd-mem.h                |  8 ++++++++
 bsd-user/bsdload.c                |  2 +-
 bsd-user/elfload.c                | 11 ++++++-----
 bsd-user/freebsd/host-os.h        | 25 -------------------------
 bsd-user/freebsd/os-misc.h        | 18 +++++++++++++++++-
 bsd-user/freebsd/os-sockopt.h     |  2 ++
 bsd-user/freebsd/os-syscall.c     | 19 ++++++++++++++++++-
 bsd-user/freebsd/os-thread.c      |  9 ++++-----
 bsd-user/freebsd/os-thread.h      | 13 ++++++++++++-
 bsd-user/freebsd/target_os_user.h |  5 -----
 bsd-user/main.c                   |  2 --
 bsd-user/mmap.c                   | 25 +++++++++++++++++++------
 bsd-user/qemu.h                   | 21 +++++++++++++++++++--
 bsd-user/syscall_defs.h           |  9 ++++++++-
 15 files changed, 115 insertions(+), 56 deletions(-)
---
base-commit: f8aef8a9aed7438083c400da10acabdec485dc9b
change-id: 20260919-misc-2025q4-6875b032dac7

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


