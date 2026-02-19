Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4168FE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswUr-0002dk-V8; Thu, 19 Feb 2026 00:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUq-0002cc-Dq
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:40 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUn-0001P7-Ck
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:40 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d4bc9e48bbso247291a34.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478554; x=1772083354;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZGJZlHZzHk7Jkbfhmjch5p2xvZoU7le+UBMmK+0WxbY=;
 b=ePtTkOgztvph9goSMRFDnrI1IJ6LDhMQLONEOtKEpkDkGCXKjqIxTDziELTzGSPSL8
 uAUR9dtqq75LggUS6q4AEHMQrsUXr789HJJCrLCYV6d6KZ8pHVriS0512kvlW8uuZJJ4
 R3JW4YLzCYEQx6mgSNmRT2G8sP9HTpk3A2HkcN15HBZzSXpxuZFJZTSsB9WH4fzFf6z+
 etYKs4WL+ZTQ8L40BKEq05K5mlnkxJ1EkndMkrfL7XaDdgAKEJOEVdZ5yKN9XJwJrxjt
 EKtiZs54y/gIG7G4lsfA+Gj+1icpllLPJB+bnTOonW/LI6XpwuAkuP1wiXq1vnJJFIWC
 oElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478554; x=1772083354;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZGJZlHZzHk7Jkbfhmjch5p2xvZoU7le+UBMmK+0WxbY=;
 b=uFfYEBI+lDR6cb0fIt0rTBG77Mfs67KRvxH341+h3kbLPnXiqtWU66fXqrT0CD2i21
 n0KfGCM0/CBk/F0kv1xRX3cvRO3ZwXAtMpFuoxtvHFXjCrGpP1FDcCazFG4fadts4K4e
 QooBqJOi1xSPi273fYyoXW+mHniPAmjnLyUtdmx4f9VnpnXWbeEhwPNXE1McG7hQuQkh
 oFIoBxqClXYhKkfkFW4Uf3/0ko1uLM8YaeyXZbVM6yWMZ5ivnm/1dk3IjUvY0nV+I513
 mTpsAuhVksbOXxPBASK/a35cm5o3mjzFVQR0QGWuBBvdOltPSP8cEM5OwQCrVj+QfMrj
 Qo2w==
X-Gm-Message-State: AOJu0Yw+l/EhYZa0ZjcMaYrcVoFuVO8LeeO1SjdKtnddthlo/FwiJN9O
 IBogy8A6fGqiWijsjCQbaKWytD47LEeWfqa+QJfIcsuUqCzkq2Ov2NTL05MqVro1p4E=
X-Gm-Gg: AZuq6aKEUIaYqvLdhfGgne5gHS3ReX14ylgA9j/ezfYggVeYK5KcCcN0kCqxTGQ/V9v
 cTC1LLLlgnuGUS5o0pc6nlgulEiDgkgfYKiEIncytP5xLlAWXi+uFfMbQk093SNIstiseIfsHFc
 beoj0xEz7c7Yk4Jx1iyouzL5o+U0hs0OyJcCPjngj+YzCuvKyaCI9bkn3Z3SZu6yDqwh9COQ06p
 NlXh7Bw+eGKY+RQ/owcQJopo+8KVx51mv3nZiFEpubjGbRRkMvQv8e6qcjT2g3xZLpWi4PiwMrY
 KNiuqPlPMbS/wVwJkK/MMszZ0BpJvNIw90Zzg3Oqdsf/af1wcYNKN9mL/0W6CqwyQ0SuTqBGmxJ
 RIyVNT3jnsxzg1v1Y4gzrtWz9zaGd9yj1ODRT3riUr/U+aytSWdeKukbKsDSu9/7VMFu+IOZ453
 ycSRmD/QTYZQ==
X-Received: by 2002:a05:6820:824:b0:667:7e1a:204a with SMTP id
 006d021491bc7-6785c03e14emr8545190eaf.71.1771478554121; 
 Wed, 18 Feb 2026 21:22:34 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:22:33 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 00/24] bsd-user: Upstream misc system calls (System V
 IPC, reboot, etc)
Date: Wed, 18 Feb 2026 22:22:23 -0700
Message-Id: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABCelmkC/3XNyw6CMBAF0F8hs3ZMHxSqK//DuIA+pIkIaaXRE
 P7dgZXGuLw3c8/MkFwMLsGxmCG6HFIY7hTkrgDTNferw2Apg2CiYoIpbJPFiUZobs1kHTbVgde
 8NqVkLdBqjM6H5yaeL5S7kB5DfG0PMl/b/1bmyFBb7T1jUslanOgi9OPeDD2sWBafgP4FBAFKO
 +WNt60u/RewLMsbDWD/pvAAAAA=
X-Change-ID: 20260205-bsd-user-claude-a691717c430b
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@FreeBSD.org>, Mikael Urankar <mikael.urankar@gmail.com>, 
 Brooks Davis <brooks@one-eyed-alien.net>, Sean Bruno <sbruno@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6111; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=CbKk7jGa82L9PNpI8NPDpaW1LWSasaMigphCy1pDFJE=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4cz2Jog+kCAESde1nOpYtHvUkI3pc31V6ri
 I6+UCVCVI+JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeHAAKCRBsHNEofbAR
 AAyyD/wJXz3fIhtm7XEABYfFLaPUCq8wRZuLGQOSB5ynBD+Ypn6wt8L698PftkIIOH9AyoBt6gX
 AXlKeHj0IoWpyoMO872FF9J1TKAybSwJWxcnNws5KTOxPI3M6soW0mEJLHpqpIXE1oyudXPvzXU
 MJLggrVRelCB3zjW3e6v+DvwkgSgyY2yilbw6314r96Asp6WrWGRqcFPcw/Jsv2bFkmiVNFlIbx
 pqpsuEWx+5I8PXjZS/j/v8yfKTvL6YGkduukW7BvEBDFhoNtOH1WXj9QlCuOu+cohsgnCII+Ea/
 IpUpSL4v1nU2a5uXKcYr9CJ7wpBEllN1mThaN7c2naOFlT3xc7v8RW9qPMyGoKjLNmBtF8PpZ13
 VanCPIJyQg9VCj+KfPZLX71L3oH/lDpExPBe152DffJfB1sQewczafWy0zA5EnGgh1p7BoxiG+3
 BaiAJTXV5PQmF5m68uz9MXH6iQI1P36x+0kOC9wOMZ/ZeESuyLlHf3Pqvim89J4S+AyAiH6bPaY
 0fVI/Qs5OsUUWC5dlExP/U5Fxw9Nh6b3iCqRn0SVh1LdTxmh4cjRs5XnQ3qRpOSaLMykn9OfM8p
 0YvhLYJtrCsXF1AalJVA/TSXggWSITw6fVxcOEBnE87L30k+iwUWmT7zUmj+abeD2MrrSlOpTpG
 SS6vEGY/08vU23A==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::331;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x331.google.com
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

[ Most of these have been reviewed, except I'm missing reviews on
  bsd-user: Add do_bsd___semctl implementation
  bsd-user: Add do_bsd_uuidgen implementation
]

Update all the system calls that are implemented by bsd-misc.c. These
are the System V msgq and semaphore system calls, reboot, quotactl,
getdtablesize, and uuidgen. This includes all the support routines
needed to convert types and integrates into the build.

So I did this with the help of Claude. However, claude took care of
sequencing the commits, pulling them out one function at a time (more or
less), finding who wrote them in the complicated git history that we
have, adding proto SOBs that I confirmed and edited to real SOB
lines. All the authors have explicitly signed off with me according to
the DCO in email on all their changes and given me their preferred names
and email (just like all other prior upstreaming). It also made sure
they all compiled (though that was mostly easy since it added bsd-misc.c
late in the gagme).

Claude wrote no code. I confirmed this by diffing the files against the
'blitz' upstream branch and confirming no stray code added.

After claude did its work, I rearranged the commits a little: claude
grouped them close, but not quite right.  Claude wrote the initial
commit messages, which I edited most of the time since claude wasn't
great about including the right things often. Many of them are just
'what' and thin ony the why, but that's implicit to anybody reading the
logs (and in line with what prior upstreaming efforts have done).

The first two patches in this series were not generated by claude, or
using claude. One removes a needless linux #ifdef to avoid warnings in
common-user. The other is the uglies hack possible to meson.build and
can't go in as is. FreeBSD has grown inotify (I think it's even in
15.0), so the extenral inotify emulation library isn't needed. I just
hacked out the FreeBSD special case, but need help with how to do it
properly (eg, check for it only if inotify isn't in libc).

I also verified by hand that the final version compiles, but haven't yet
re-verified that every single commit still builds (though I believe they
will). I tweaked a few style things and then commited mirroring tweaks
in the blitz branch.

Claude didn't help me with this letter. I believe that this use of
claude is OK and falls outside the project's general prohibitions
against AI because those are aimed at preventing contamination of the
code of the project, and the code is 100% written by humans, just not
yet upstreamed. If this is successful, expect a lot more of it. If there
are legitimate issues arising from this, I'll correct and modify my
approach in the future. Initial polling of qemu-devel, though suggests
I've covered all the bases.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
Changes in v3:
- Prefer g_new over g_malloc with cast
- At this point, the only warning is about added files.
- Replaced the inotify hack with the real fix in meson.build
- Fixed the copyrights with Stacey Son's blessing
- Fix missing unlock in bsd_do___semctl, and make sure we copy it
  in/out
- Fix g_autofree problem, add comment about 2048 being a kenrel limit
  for genuuid, and simplify code a little.
- Fix g_autofree mistake in host_to_target_semarray, remove free()s.
- Rebase forward on master
- Link to v2: https://lore.kernel.org/qemu-devel/20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com

Changes in v2:
- Fixes to __semctl implementation since it differs between Linux and
  FreeBSD
- Use abi_* more frequently (especially abi_ptr)
- generally use __get_user / __put_user
- Fix meson build for inotify for FreeBSD
- Update types for target_semid_ds and target_msqid_ds to be
  more logically correct (though physically the same type)
- Reword commit description of dropping .note.GNU-stack
- Link to v1: https://lore.kernel.org/qemu-devel/20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com

---
Stacey Son (17):
      bsd-user: Add host_to_target_uuid for uuidgen(2)
      bsd-user: Add target_to_host_semarray for semaphore operations
      bsd-user: Add host_to_target_semarray for semaphore operations
      bsd-user: Add target_to_host_semid_ds for semctl(2)
      bsd-user: Add host_to_target_semid_ds for semctl(2)
      bsd-user: Add target_to_host_msqid_ds for msgctl(2)
      bsd-user: Add host_to_target_msqid_ds for msgctl(2)
      bsd-user: Add do_bsd_quotactl, do_bsd_reboot and do_bsd_getdtablesize
      bsd-user: Add do_bsd_uuidgen implementation
      bsd-user: Add do_bsd_semget implementation
      bsd-user: Add do_bsd_semop implementation
      bsd-user: Add do_bsd___semctl implementation
      bsd-user: Add do_bsd_msgctl implementation
      bsd-user: Add message queue implementations
      bsd-user: Implement System V semaphore calls
      bsd-user: Add System V message queue syscalls
      bsd-user: Add miscellaneous BSD syscall implementations

Warner Losh (7):
      freebsd: FreeBSD 15 has native inotify
      common-user: Drop __linux__ around .note.GNU-stack
      bsd-user: Add target_semid_ds and target_msqid_ds structures
      bsd-user: Add target_uuid structure for uuidgen syscall
      bsd-user: Add function declarations for bsd-misc.c conversions
      bsd-user: Add semaphore operation constants and structures
      bsd-user: Add bsd-misc.c to build

 bsd-user/bsd-misc.c           | 192 ++++++++++++++++++++++
 bsd-user/bsd-misc.h           | 368 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  52 ++++++
 bsd-user/meson.build          |   1 +
 bsd-user/qemu-bsd.h           |  15 ++
 bsd-user/syscall_defs.h       |  67 ++++++++
 common-user/safe-syscall.S    |   2 +-
 meson.build                   |  14 +-
 util/meson.build              |   6 +-
 9 files changed, 702 insertions(+), 15 deletions(-)
---
base-commit: ece408818d27f745ef1b05fb3cc99a1e7a5bf580
change-id: 20260205-bsd-user-claude-a691717c430b

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


