Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921AFCD13DA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 03:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIeFt-0004Bk-9p; Thu, 30 Apr 2026 23:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wIeFr-0004BL-LI
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:09:27 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wIeFp-0008Tv-Lw
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:09:27 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso1392358a34.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777604964; x=1778209764;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jZXwfeBdLypbadPXB3c+WtpTKadrsmPRbHbPNLwnnfU=;
 b=basLSntL8ph8sjs44Cb9LTCCxcI8tCPT5n6XQyI6ZB/eJx5jTEfH5hKOlMWqQHJ+aS
 sdlpwP0vvoAwYhnzZfZUL0ugkedreXQJpjzElGdVtW5SmX6AFFubZtaDJriDDfUHfwaK
 h/dqZW/0ucBv8e3owdLNXNCbUX4JUIbaJyi+z7svI8/MD6zduqjeCHjyReOdjn6afdpY
 lM0aJoI8TakVeInUcpN4K8VNDWHDKHPVnSSuqcaLYcLT1xltaIPQNdQ3W+7MavfaU7r7
 KWoAY6De4+uxeP5VVYfb8GMBZ4OM60XVK6/fA01Y6CtdfKJ0qQy3+RFmqifLQvEDl/0z
 wPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777604964; x=1778209764;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZXwfeBdLypbadPXB3c+WtpTKadrsmPRbHbPNLwnnfU=;
 b=cu+wJdHaLF6ae3n6lPBjorIwZpy9IIjlQJsmSM2pwLjNwXH7i9FN4AF9MMyBRspdPo
 zNKFSQy6LABaAB/W2RuklZvXthZC/qH1R0QrfEYOtTpU+W6zFRJNh8TOp8t1p9n9lv+c
 d4qI0VlVa5YHl+Xedc4SBupdlp4fC7It390sLCcF3ucFaauVmmpb2EOw+N4D0Io+xTxv
 ZO5Dt1b16vrwuJTK6x5hiQES2LJzaN0ZpINs5/zOTcN3T8NRJQa13+W87LQTZjgZkaLi
 wlf+/705+zKWSQ3aFqCUs4QpkbWZtLT+sjvwuSJy4Q1zoJOrI+wQnFuAhK0EGr8/j7wl
 PEhg==
X-Gm-Message-State: AOJu0YxHCS9Mw70HzV8FIdEsm3MxpsjK1dHonTGdVbzsVZRSgAZdpqGv
 th4IMXyRZDkflVC1VegsJ8X35cGKBTcBxJR5MVgLiWZRu0mUOZ7P/KFHziu7T3javIM=
X-Gm-Gg: AeBDietDZP+BSnfeg2xPYapJ7IRnd7WNFtBcV976OHgOLWL/MtjflCvw1Lj79fPeDhY
 aGkGJrqRsMGACJCMy1cIxgXP3nBvD1YQJG0gKNwBigttpootW2O+xgIRPxN1lYhwfbiMAZe2z3j
 7lUjATEXAW4V4wZMkb8HynGtPuUYZO/xtMyPYqroibNsEE55HukmBfuYsbBuDKhwZtPM8jtAvlo
 MnH5fjmx8iQveCqjxj73MFpTSfyw30p6dZGa8DfWKczmnK+httD0Eev6L4Hyn1PGhzGdqQ4h3+t
 yhqp+aKZHpuN97lVoRgkwe+RyVAGfqkL9HMiYMXk2SeQkOM6ckfkpV96GWwJ4Xx1pJXhKr0rVUE
 gW7S3TF2h813gYhaLOjtTTclCwdHSN9/R0k5mr/3WE9/XPTCaUOD9PsKzAA91UPxjWTXWKUq4m9
 15QezYfHTanQO8W9sa3khR
X-Received: by 2002:a05:6830:368c:b0:7d7:d60e:650a with SMTP id
 46e09a7af769-7debdf163efmr3531119a34.23.1777604963963; 
 Thu, 30 Apr 2026 20:09:23 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca278d0bsm1238476a34.0.2026.04.30.20.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 20:09:22 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH v4 0/4] bsd-user: Generate system call numbers
Date: Thu, 30 Apr 2026 21:07:35 -0600
Message-Id: <20260430-syscall-nr-v4-0-80f512079a16@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPgY9GkC/2XMSwqDMBSF4a1Ixk25uUl9dNR9lA5icq0Bq5KUU
 BH33igUlA7Pge+fWSDvKLBrNjNP0QU39GmoU8ZMq/sncWfTZgiYgxLIwxSM7jree65Bl1I0hio
 NLIHRU+M+W+z+SLt14T34aWtHsb6/jNxnouDAmwIUlBYUkr7VwbrXeDbDi62diDuL1cFisnmhk
 6ysEZL+rNxZCQcrk1W1qFGpC2HZHOyyLF8X+4FlHQEAAA==
X-Change-ID: 20260412-syscall-nr-a0a831fce9a0
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2454; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=CMtij0Ti6MeRQieDSnmXrYj0LNguUNO5C9lyGf4rPuQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9BkDr8/6g2+Bmui0JfzWAi3WhAjNXCMAn+mxT
 bJ/Yxf35lGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafQZAwAKCRBsHNEofbAR
 AEUVD/9oOS1E/JBEt4NpbCQMlb6dO2BqFbBEArPjFWdAobCfXKWV388AR0QTGyzyQIEE/qFV+IP
 wfvHO0RmDap7mjSnD13cfpu5NGz7ysVx0H5IF36XEqqDZTtuY44icehJgdFh8eb5RCUBzrE5s4T
 4jc5mjEdSoN1DypkPDPKNl708yPXCtlPJ36D5dPd9WnM50SwLQ/s6i62NBVpEXCxbZpwXorIvsB
 vn74ur2OzDSa6lIRBLeAMhbgKHi7u1/7EU30K73SeXQvC4jqquyIvxsog9P+4cnS1oNIrT0hrxG
 3G/6MwHpIbzVMH01UmG1mTdA35zj6dzAOGkWEiyOgzWyKpIPW1gW4dCstCgBQEl/iCZM6EDZBD8
 AlYsnceKX9cFo0PpERRHXIUJw9Y8/KAGZlQXglYvm70V4NxS65SOeVaaItSiTp7m0KvOVHWhBd0
 IVq7iNppmL1Abv3wo7BdG75OhTPZewFbhqsJRmnZ3gwPfntVs699P5E8NaG2z5Yh0nJ523fvg7E
 sdAoAoqpDMVG9+Fw9kTY5+i4oLgYHSDTknzCwYwqre6TzC6nDLjw0uY4CPWkkT+sS4XdOBfLMKQ
 BgZ+U+1m5QkaEF2a4r5UzXZWFDOeUMvG23SkfkzrRUJQO8Zv4YtfEq5/univvOMpWOZ+qFmgQwp
 sPA+6kqvWhSOTNg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x334.google.com
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

FreeBSD has a system call number header, sys/syscall.h, that's installed
on every system that can compile qemu. Generate the system call numbers
from that table rather than re-regenerating it yet again.

To do this, I have to clean up a few stragglers for system calls we've
removed. But these returned not supported anyway, so there's no net
change.

I also tried to do this in a way that the other bsds can coexist with
should they show up again in the future. To that end, I moved the
definition of time_t into os-syscall.h, where I noticed it was wrong for
amd64 targets (which is little used and missing features, so it went
unnoticed for a long time).

More will be generated in the future, but this is the first steps.

Finally, while this does add files, no adjustment to MAINTAINERS is
needed.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
Changes in v4:
- Uggg... Fix last-second error in last commit
- Link to v3: https://lore.kernel.org/qemu-devel/20260430-syscall-nr-v3-0-4b1b2445e28f@bsdimp.com

Changes in v3:
- Drop the strace stuff, since I thought it was ready, but not quite.
- Drop extra files included in bsd-user/freebsd/meson.build (soon though)
- Link to v2: https://lore.kernel.org/qemu-devel/20260429-syscall-nr-v2-0-67a8d09dc13e@bsdimp.com

Changes in v2:
- Rebase to tip of master after 11.0 release
- Regenerate strace.list, can't do this at runtime just yet so include script
- Simplified syscall generator meson integration.
- Link to v1: https://lore.kernel.org/qemu-devel/20260413-syscall-nr-v1-0-f70408d042ea@bsdimp.com

---
Warner Losh (4):
      bsd-user: Add syscall header generator for FreeBSD
      bsd-user: Delete sbrk and sstk system calls.
      bsd-user: Create os-syscall.h
      bsd-user: Switch to generated syscall_nr.h

 bsd-user/bsd-mem.h                     |   2 +
 bsd-user/freebsd/meson.build           |  10 +-
 bsd-user/freebsd/os-syscall.c          |   8 -
 bsd-user/freebsd/os-syscall.h          |  21 ++
 bsd-user/freebsd/scripts/syscallhdr.sh |   9 +
 bsd-user/freebsd/strace.list           |   4 +
 bsd-user/freebsd/syscall_nr.h          | 515 ---------------------------------
 bsd-user/syscall_defs.h                |  18 +-
 8 files changed, 45 insertions(+), 542 deletions(-)
---
base-commit: 759c456b1d22fe4083c8b384da27d3f56fd53f82
change-id: 20260412-syscall-nr-a0a831fce9a0

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


