Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8C4C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8b8U-0002Mw-DG; Mon, 21 Sep 2026 06:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8S-0002Jv-AG
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:32 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8Q-0002dN-7O
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:32 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-805bf8c2661so1971156a34.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 03:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789986028; x=1790590828;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XB6QO3iT2dDM+TABXrpZTU9Ir+QAQeUqpOotI/em1HA=;
 b=rHrt4pWOnCw8oEw7dim2VMgVl0elW/S+zxeELmrG9AIIskT2DzyCdSb7Bw7Y4O/KgL
 oVF7uim4+jDWLneXMUEiweyOHJHC5T1vBE8IaOVEt0Cwqp8KfBaoZzRMxAGGVO7ASSl8
 wLsP7pAfvqDEorudXUnoxGU38zuyT3zi9GSzxUGcnP+37nBnDSjZ8xkQOIG0W4ABVk/J
 Z6fKvfwCjlbKwnFs5BJ7J4RONe94CwlzuJytXNkI/V/1Izdwwkjf7UwOfEhsw3XfEafQ
 BXzC7Ra5VECjP1Zm/KlKDxEqRl/F4I4KZU3pGvfHosvaOJseL8ekuMuRjfkfGrYxX/7D
 nBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986028; x=1790590828;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XB6QO3iT2dDM+TABXrpZTU9Ir+QAQeUqpOotI/em1HA=;
 b=27GN0A62sioAYdAYATm64TYKTmf+fRbfU+Z0DtruIXekAm3d7iPwOSYzzjCM1gxt+J
 a/Urvl61wKgZwUr/4sRYS3gnZL3iOON913gkb4FKBznVU+MnOsFS7d9kb+57hcKRXYVR
 2DMO45/BXPsLRzKH3Oc219M1FUJbzy65ZuPiWLYOjuj50l3/zNsIjHrz4eaLNUnMzNFQ
 2Fy/x8GlT2HrL6YVnVH7W2pF6xyfI1tGCdaFPRYgEtjfIJ2OdHEzPDPl5tm4sS0red0d
 TfrnslsblplvxumpLc5RuCAICDxuhMg8/wIdQc+nNsxXqKnvZdLh2s1mO/d0S1xNEik5
 EY2g==
X-Gm-Message-State: AFuF++mf+HU351awyQG7VpEqZXX3XuRK/2WMKukndbxNBMAmifPjgpGS
 2UqQ1AD5vuwYvWrzp/GZOUd4K+C7s+Wun4YcwY0IyH8Wkjm6LQ4tZTgf0ubPgNOnT4s=
X-Gm-Gg: AYBFou0ULxeL8EYXNxlCMgCd6Xtf15I2JXvnoEX1rDomMTkfPIVbdRBvsYiPdAlsrMj
 QMky2B0sOVePN/6e9vSQ5lusOKNFsOSb9/Z9WqpQw1O1y/oIIpPoYC/i3j5hSwANU7Qoj+WBi8O
 lxzxOvA5tobUWCXJUCUXBRG2CyC+dH/6mlsQncHM+3yLz/Oe7qVC5JnAimTzTU6OaWk3SVT2/Z5
 BpUUk3MKc//C1qjj5Gy/bY1f9Mgb2bGTzShLuyAjEVpgCWF/zf800HQWcwhWmrplOQEr8PYxSwE
 dxSi6aIsEvQIa3HUatMzTKHPmUp2HqRWI8rxuMtwaO5GYVGqHmKvcCfzJv5EK3MhQyy28ZWK2aJ
 inqPs88PPQSpqRpEY8dRK2nbPG25EHPn5Ahc6ZUxeXHWGNhdMUVLlZW4tO8b+5X7TR1omYgUFtZ
 fyRpaszYkOonvUtUvwEmQB1eLuPlVjtzq+KCvWsXo7zsO5aase8L2LwaM3JA==
X-Received: by 2002:a05:6830:9c1:b0:805:b31f:c7f with SMTP id
 46e09a7af769-80de3be5605mr12540747a34.31.1789986028473; 
 Mon, 21 Sep 2026 03:20:28 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8107dd8f425sm7613601a34.4.2026.09.21.03.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:20:27 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH v2 00/11] bsd-user: Upstream a few fixes
Date: Mon, 21 Sep 2026 04:19:42 -0600
Message-Id: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL4EsWoC/23MSw7CIBSF4a00dywGsAVx5D5MB7xq74DSgiGah
 r2LHTv8TnL+HbJP6DPcuh2SL5gxLg381IGd9fL0BF0zcMoFVUyRgNmSpmHribjKwdALd9pKaI8
 1+QnfR+0xNs+YXzF9jnhhv/V/pzBCiTeTFoz2yjh5N9lhWM82BhhrrV+IexUupwAAAA==
X-Change-ID: 20260919-misc-2025q4-6875b032dac7
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 Rick Richard <rick@sloservers.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2344; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=a9cDR1cFFsZ559OdFbatew8MTmGiB1lPfjpc1bp+xO8=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqsQTJQR0SXzmUXYeHSny295/64+oLp4OqlyyAD
 kRuVvm4fwqJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCarEEyRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBTnhAArvmSD0+cReFa7HoHTEpmHwdRPIKjKvV
 v1yo7Qs2z/sTQ4Q1bWlwBdV9tCwZPSFn0v5Gl9E/x5aCn6LPdkN51M54BI1QerGpumn/nIXn0Yg
 vbwXS3gS510eNvHEKRg3RyCxRaatnb+ZvZ9/EOLmBunhBTFi9qK9T+/yBsO5vAbnd2YEJ2xFIi+
 HX3Z/13zy9BKXMSypAe8T31bDu7PyQ1nTl6rCjrFuDR8EaDvltb4EUu696iysOytHn4gv5ZB9lR
 f0/P9ox7gcu+d9eS9ZKeYQYHN/f8zvHrSSVIk/7+chuPwtc9IBEiWTVcQQXvbHW92VynL19LlJB
 mCwnwgUQqL12DnOWQbJ8Lf/z9SFFULZfS4jPUbK6S6r4TLWeNtDqrx8U+37M7dDs5Yn8799k7pL
 eEXppRzWJl+uBHndYCz3cyVnqdmR4/KT03P1H5ZJxdcH9Jx5eLgLNsG4Dd5V9unt6nWLlguNmoI
 2yRRbZiM7zWPjkDysTj0Zozq9XWnXE6bSv6/1eUoRUBaPgwN5ig1Q+HJUj6SJkhsQlgnKlbF6gj
 kV4UROlGXQVXIYbTy/iOag6bMQe7XFZK0LBnX9EoDRg3e3etAizEeedd7TVh8l++95OvF4q6rrz
 irYJI9wKv8C2oHMNZ6V8P79hB5nEbKG5pd6z6TRQ723rT8Wf9cJo=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:32::f; envelope-from=imp@bsdimp.com;
 helo=mail-oi2-x0f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

Upstream several small fixes to reduce diffs and fix minor bugs

- Remove host-os.h
- #ifdef sockopt that aren't in 14
- Eliminate unused regs arg in load_elf_binary
- Implement sigfastblock
- Implement exterrctl(2)
- Move tb_flush stuff to begin_parallel_context
- Fix crazy bug with mmap and mmap flags
- Initialize per-arch child registers
- Flag shared memory as needing atomics
- Drop support for FreeBSD 12
- HOST_BIG_ENDIAN and TARGET_BIG_ENDIAN are always defined

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
Changes in v2:
- Use if instead of #ifdef
- Drop gdb patch, it's not ready and needs work
- Drop mmap patch: it's part of a bigger set of changes
- Link to v1: https://lore.kernel.org/qemu-devel/20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com

---
Rick Richard (1):
      bsd-user: HOST_BIG_ENDIAN and TARGET_BIG_ENDIAN are always

Warner Losh (10):
      bsd-user: Drop support for FreeBSD 12
      bsd-user: Flag shared memory as needing atomics
      bsd-user: Initialize per-arch child registers
      bsd-user: Fix crazy bug with mmap
      bsd-user: Move tb_flush stuff to begin_parallel_context
      bsd-user: Implement exterrctl(2)
      bsd-user: Implement sigfastblock
      bsd-user: Eliminate unused regs arg in load_elf_binary
      bsd-user: #ifdef sockopt that aren't in 14
      bsd-user: Remove host-os.h

 bsd-user/bsd-file.h               |  43 +++++++-------
 bsd-user/bsd-mem.h                |   8 +++
 bsd-user/bsdload.c                |   2 +-
 bsd-user/elfload.c                |   3 +-
 bsd-user/freebsd/host-os.h        |  25 --------
 bsd-user/freebsd/os-misc.h        | 121 +++++++++++++++++++++-----------------
 bsd-user/freebsd/os-sockopt.h     |   2 +
 bsd-user/freebsd/os-syscall.c     |  11 ++++
 bsd-user/freebsd/os-thread.c      |   9 ++-
 bsd-user/freebsd/os-thread.h      |  13 +++-
 bsd-user/freebsd/target_os_user.h |   5 --
 bsd-user/main.c                   |   2 -
 bsd-user/mmap.c                   |  26 ++++++--
 bsd-user/qemu.h                   |  21 ++++++-
 bsd-user/syscall_defs.h           |   9 ++-
 15 files changed, 175 insertions(+), 125 deletions(-)
---
base-commit: f8aef8a9aed7438083c400da10acabdec485dc9b
change-id: 20260919-misc-2025q4-6875b032dac7

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


