Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466C6FDEE39
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 00:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG4cs-0004S2-MS; Thu, 23 Apr 2026 20:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wG1ji-0002ZS-A2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:37:26 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wG1jg-00016w-K9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:37:26 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4411e2dfe9fso495230f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 14:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776980243; x=1777585043; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wifM03kiFnCpvy+7KtBRkQy52FL5WTOKv2h6PJOPvlk=;
 b=AIdOphpZVjjSpGAorgMe8QF+srDaEnlx3VAn79bZGeYKo1apx24MTkJbPmWTJ8tcjp
 9/fMAKP0N52vVtfIkCAAkyoq8SeY1+oqWoeUBSzxK5f+fy9bM7QmMp+/3ckgX+bVjxpi
 KY6lOgwOWM97fgS0FpHzH9qsy0+JVu6kBC0lseORgO1uB3Qe/E+O7YSRs1u7KbkQT1aI
 e09YlLrW2w37uif/11zoco3TAEYrVaK25FSBvu2zSDRqRUGa72Ix1oscRtEIz2s1hY4+
 XNVZNlof7aAALt5zEw4G126Uf6Y3YPVCTW7PifzmrdDJsBB4VuM8v7FMAZMn5ku5XAD1
 uhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776980243; x=1777585043;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wifM03kiFnCpvy+7KtBRkQy52FL5WTOKv2h6PJOPvlk=;
 b=J9ovXtPA9OtGV80u7DEbDNKsOZ1FH1n8c4hDvy1GCO+xj8L5xitgeR1VfzrDvWyQyY
 QrhAGhfGi979JJqoxxjuJN2PCOfzrg30tXQkLtRZmq4sEmchrwo8j+y2ca3k5TpjxXo7
 LVSTuh4ec7CIHeUJboOouGaeL8B1pojkW3M0iFDS3K73I95XR9pWMOL0qJVCRrD7fY6C
 iAvB8+ZW4LBkVdsrem/tmyiWIf9rW+U/ilbyt82UqvW/YyMzXfMmM35KSDPobNRG27+U
 TSq7k/u+txqCaI+bUwSsjOn7JXES7cQA8O7Gpd2QbF++lmF/zlc/uNI4en7idFMeNBzc
 i5Ew==
X-Gm-Message-State: AOJu0YwZKB4lR4QnJdvsCGDj903HWI9mOGGPoDIKol//pjibGPlG3Ois
 8BF47SXcGxxoiU0wi9cyWQdbl/ogzIcd5uHsarvKOTcUPvVReQMnghg5
X-Gm-Gg: AeBDievHIAg9TelChX5K6jq4MyTTSqdxJvhhqcCrgOXWrq0GMo+vAOnyBzWGVa+Pz2O
 Nx4zaIahPjvwmFN+pQJgjTF2oXDfLAkqekzSTSTWVNs4RIQ+4KMLdLSHmzMm3vV/bjJBKSoBB5K
 LarF76K6uCTYdX8GfL0/+fabIk5MmSqmRROaGtx92ASXrQV0Sp7ilaNmhjOrs6k4qF/Z3IfjBtK
 nnhQCkyMxRPCPjzSAJCHucuUoCzEdwQsU5nyRmq7uB5Vo9Jb59gKfAK1sFdHgGVe0kuudhhJc8F
 5vzY/JLmVMmGpjPHP2K+EgNzYlzlwkursla7+zMfbaIRtNXoU9wHUbywgskeGiHj/468d7x7K2f
 /Iw6blZxuSxOCClusf5zkedI4FOg65KyOm+s5t96u5G2PNE43PiuelXoURlU08mBVemDhyPzRK3
 wLg3v48mnwMdrkXXGRKzZyBier3QmtaH1lsdVfIFPIvA==
X-Received: by 2002:a05:600c:4686:b0:489:6c28:dbb4 with SMTP id
 5b1f17b1804b1-4896c28dccbmr137164725e9.5.1776980242410; 
 Thu, 23 Apr 2026 14:37:22 -0700 (PDT)
Received: from [10.94.10.196] ([223.123.19.204])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48919f54572sm138755225e9.26.2026.04.23.14.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 14:37:21 -0700 (PDT)
From: Ali Raza <elirazamumtaz@gmail.com>
Subject: [PATCH v2 0/3] linux-user: Filter /proc/*/task/ and validate tkill
 targets
Date: Fri, 24 Apr 2026 02:36:37 +0500
Message-Id: <20260424-master-v2-0-8b50b5c063ed@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOWQ6mkC/2WNwQ7CIBAFf6XZsxhAa4wn/8P0QGFp10gxgETT8
 O9CPXqcZN68FSIGwgiXboWAmSL5pYLcdaBntUzIyFQGyeWJH0XPnIoJAzsobpXE0UrTQ5WfAS2
 9t9Bt+HF8jXfUqa2bMVNMPny2pyya9xfNgnF2NkaiFUIg4nVyih577R0MpZQv+dJ/Wq4AAAA=
X-Change-ID: 20260415-master-3a0fa2ebf2d5
To: qemu-devel@nongnu.org
Cc: Ali Raza <elirazamumtaz@gmail.com>, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, deller@gmx.de
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=elirazamumtaz@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Apr 2026 20:42:33 -0400
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

This series fixes a problem where QEMU user-mode exposes internal
host threads (RCU, TCG workers) to guest processes via /proc/*/task/
and allows the guest to signal them via tkill/tgkill.

Patch 1: Filters getdents/getdents64 on /proc/<pid>/task/
Patch 2: Validates tkill/tgkill targets against guest CPU list
Patch 3: Adds a multiarch test exercising both fixes

Signed-off-by: Ali Raza <elirazamumtaz@gmail.com>
---
Changes in v2:
- linux-user/syscall.c: use pid_t instead of long for the tid variable
  in do_getdents() and do_getdents64() (suggested by Helge Deller).
- linux-user/syscall.c: replace ad-hoc readlink-at-getdents check with
  fd_trans-based tagging at open time, eliminating a TOCTOU race and
  a broad-prefix match that also matched /proc/<pid>/task/<tid>/fd.
- linux-user/syscall.c (do_getdents, do_getdents64): retry sys_getdents
  when an entire host batch is filtered out, so the guest does not see
  a false EOF.
- linux-user/syscall.c (do_getdents, do_getdents64): parse the dirent
  TID with qemu_strtoi() instead of strtol() so out-of-range values
  cannot wrap silently into pid_t.
- linux-user/syscall.c (do_tkill): validate the guest tid range against
  pid_t and only reject signals whose target lives in our own host
  process and is not a guest thread (allow cross-process tkill to fall
  through to the kernel).
- linux-user/syscall.c (do_tgkill): drop the previous tgid==getpid()
  blanket rejection and apply the same in-our-process-only filter, so
  legitimate cross-process tgkill keeps working.
- tests/tcg/multiarch/linux-proc-task.c: hard-assert ESRCH on tkill to
  a non-guest tid, and add tgkill coverage (success on guest tids,
  ESRCH on a wrong tgid).
- Link to v1: https://lore.kernel.org/qemu-devel/20260415-master-v1-0-8dd2ef111eee@gmail.com

To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Alex Bennée <alex.bennee@linaro.org>

---
Ali Raza (3):
      linux-user: Filter /proc/*/task/ to hide QEMU-internal threads
      linux-user: Validate tkill/tgkill targets are guest threads
      tests/tcg: Add test for /proc/self/task/ filtering and tkill validation

 linux-user/fd-trans.c                       |   6 +
 linux-user/fd-trans.h                       |  18 ++
 linux-user/syscall.c                        | 353 +++++++++++++++++++++-------
 tests/tcg/multiarch/Makefile.target         |   2 +
 tests/tcg/multiarch/linux/linux-proc-task.c | 193 +++++++++++++++
 5 files changed, 492 insertions(+), 80 deletions(-)
---
base-commit: da6c4fe60fee30dd77267764d55b38af9cb89d4b
change-id: 20260415-master-3a0fa2ebf2d5

Best regards,
--  
Ali Raza <elirazamumtaz@gmail.com>


