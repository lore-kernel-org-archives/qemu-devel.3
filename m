Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669D5EF06E1
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpAR0-0000ci-2I; Sun, 08 Feb 2026 14:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAQP-0000ZW-FH
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:26:46 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAQL-0008T9-SK
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:26:29 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-45f10d7eb81so752119b6e.3
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578783; x=1771183583;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0EiTyfA11yc1joSGIeh2NQitT/kQrlrtrb1eCEwbbI=;
 b=yNMjpl87HmgtcCLJEhM+TDrJe5AEoEpbroMZKNM2OgvJXSm2M/ZDenATSK37yruOcX
 3BU8GxwR/4yi2EzZLBKedvhX5fAut0ilJ7Hs0et4PuQEJhGmGZh4C1Wj3wBbfqZ9gk7l
 xGruD9ihQIfaf3HxmOm1pfVEARBmzPfj44EBk0Ia2fxWoJhjMjesgOauULlwH8180KJU
 aaLzTCjREGRPipTHBlcfziLMCnKYOuhkWRi1LWKUpezKuFTGPhenTXk7g90M5A8S8+Tf
 tqerAgofa4YudLyVaG2uUoLnweZxiLOdaIskQlPBk7xmLhtEYmVwXSWkTfD8KnYI1ssM
 EIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578783; x=1771183583;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q0EiTyfA11yc1joSGIeh2NQitT/kQrlrtrb1eCEwbbI=;
 b=LDxzG5M7l5O8j3UCG6J4Y704ynJHYAfUHvmfG9tqSz1wWqk7DUQxqbbqNsxBI7tKpV
 sPgBivw6aDKWKNZUjc/WxiLIs6mTaO5KXW8mMA+6y2AJMl3eL7KT2rPFeMXOu1HlHwDs
 RoX7YA+Yc54yuXle46ZBPnH2A0z648qJxJpppi/EC+7f/ewj96vKNUxJfgbmnaqr123I
 7dr4iqohuZpfX+DoIFw4IqRjM8Yby12l9n8DL26Wh9fv+RVgkkCPqZuANefiDh4uGh8s
 Xp7ueYRB3INNLqeq0ieDgWkIZjtV6OBFg2CpMQWabR1sgbmwL/5CPkKDaavsu+gQVjtj
 COjQ==
X-Gm-Message-State: AOJu0YzUEFcYdK4EPQINfye4QZ6RQhBZMuakWoaBKfbv9i20O3yUiMGB
 AvPzoodQ1tWnH+3hdssyx3ZVg35yd85osM6XXa/jLe5sncMFEfGNidupUv0Lqwr1PZg=
X-Gm-Gg: AZuq6aIziU0vCuUZ8zcGl1RYipzqBDqM0edJVhjGvrPvC93ETY7V/clNkNwLqMNaCp3
 96U9OxSS8u6ZTC5hYMD3ulWkBoy4V/lRb1P2UoazxIljdXy2dX0lohkvLnqQZKVzybDui4D/5bi
 4XQYNEPVGdDUh9F1KIMeXJSTTfpC8g9B8Xz0mSJRWRAFqWS3aeFUss/UQG3X5f6YkiljPMLzzR0
 Y/Afrx9A/TsfzMpXTNIoYZ5ANGpKHs0E3uom03Y25n5dc+ARM3ODMFC3MKAFTnyJWfqAn+vdSuY
 LOu/QW9v4wsTd79h+xVUiMxtSk0/NjMINqBj/m71XF5tk8XJdpUlBvVi8iMKaKhtANh4ngTHHim
 Er59Rnx4enllb4e4s2XEYz9GUU+gi/SidoXoyUm0F5SjEesYA8OwOYqJYkVE7CQcPfNsR24sbag
 ==
X-Received: by 2002:a05:6820:2203:b0:662:f543:5d4b with SMTP id
 006d021491bc7-66d0d2f9ca0mr4215150eaf.75.1770578782908; 
 Sun, 08 Feb 2026 11:26:22 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:22 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH v2 00/24] bsd-user: Upstream misc system calls (System V
 IPC, reboot, etc)
Date: Sun, 08 Feb 2026 12:26:09 -0700
Message-Id: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFLjiGkC/3WNzQ6CMBCEX4Xs2TXbIj9y8j0MB2iLbCKUtEI0p
 O/uyt3jN5lvZofoArsITbZDcBtH9rOAPmVgxm5+OGQrDJp0SZoK7KPFVSQ0z261DrvyqipVmUt
 OPYi1BDfw+1i8t8Ijx5cPn+NgU7/0/9amkLC29TAQ5UVe6Zs0eFrOxk/QppS+zVfZu68AAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6174; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=1DpqsWqMeGpoWqBdIRNumFgzELGgV6koJlAG6/NpO1s=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONXvgbEFvDhZebv1JJ6cHVFyf0Hu09QQPEml
 XUH4L9dhguJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjVwAKCRBsHNEofbAR
 AF0dD/936YTRXDrPk5ft/VuKT2o3UFysIZuTIxEoHr14baTxAm+Po5XrAecsQwT6n3bQ/mi3zjg
 85gTDD/fZqDV706StFFZ20kxcAJu6E1wBGJPlydmL3AkWfgvJSt+LDr1jYswb+q+WChM2O/HzOQ
 T6VxHUYt4w02MIRxAtlOglmYi9CegUWQYNYhq6FQRY2G4SynYpl3fCWc6f1wiBObF/VPJA7+rPz
 6+lRoE7RGldhKiZexlegRDjFFIPl/XyIa54LR7IkCGY/js72++XHYZ5PFZQShOBZj+RwnJZShJa
 1PEesAWuhZeAGcP81t32npXx3vh9HKNSo+lHr/rPeG+GMINF1TdyevqY4W9JbWezurMfyEYYimQ
 1BsmD36lYKKs+bx+RSYB+vWixDwCYFOIRJ0O1KMUOX2Xg1RRPP+u0PMFQRON7kw3g7/47GYD/Pc
 XqzTsdz/RfmCG1Sh/vQUeMKCVonZTWLkq42vkV3au2MU/SZcNGWRyVyb4I///U40y3NSU6zxjNZ
 RW0kIyKw0jO/RxGjs4JuSO1FVANG1IV1fetoR6dr3r/eS8lu4IYWYyvXyMfsKzaRz7W5B5Fvm11
 SP/iw1jg9vLoGjlbanqHG4EqitQp0lN7nOx7OZX4KCFomJYFjXr8wbYSTdWrWCsNLQ3MsjF3pO3
 dhMlf8Do0JK/D5w==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::235;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x235.google.com
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
in the blitz branch. There's a copyright marking issue that I've not
fixed pending email to get permission from Stacey.  Specifically, the
following errors are still there, and i'll fix them in v3 if I get the
email back (I plead 'pre-existing code' exception for the moment):
  ● checkpatch.pl: 77: ERROR: New file 'bsd-user/bsd-misc.c' requires 'SPDX-License-Identifier'
  ● checkpatch.pl: 77: ERROR: New file 'bsd-user/bsd-misc.c' must not have license boilerplate header text, only the SPDX-License-Identifier, unless this file was copied from existing code already having such text.
  ● checkpatch.pl: 85: ERROR: New file 'bsd-user/bsd-misc.h' requires 'SPDX-License-Identifier'
  ● checkpatch.pl: 85: ERROR: New file 'bsd-user/bsd-misc.h' must not have license boilerplate header text, only the SPDX-License-Identifier, unless this file was copied from existing code already having such text.

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

 bsd-user/bsd-misc.c           | 206 +++++++++++++++++++++++
 bsd-user/bsd-misc.h           | 374 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  52 ++++++
 bsd-user/meson.build          |   1 +
 bsd-user/qemu-bsd.h           |  15 ++
 bsd-user/syscall_defs.h       |  67 ++++++++
 common-user/safe-syscall.S    |   2 +-
 meson.build                   |  16 +-
 8 files changed, 725 insertions(+), 8 deletions(-)
---
base-commit: 65fb9de4888f9bf32bc4f60c880da3dff04c4fd9
change-id: 20260205-bsd-user-claude-a691717c430b

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


