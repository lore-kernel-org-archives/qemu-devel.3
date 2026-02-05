Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3A7ECD993
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo384-0004PY-JN; Thu, 05 Feb 2026 12:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo37t-0004Mz-9F
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:26:45 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo37r-0001NF-0J
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:26:45 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-45ca17ef16eso442591b6e.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312400; x=1770917200;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jIZIxRKPYwm2EGOkw2Z8RDBSbOPUzCX+RtBE8lRq7Po=;
 b=gLEeljtVx2RRljG74/kKT7Hm2d+dro/GLNLWrGrnP/nUlerVhBiTCQW6B2NGiWM0b7
 dm+i4JK50g9mjja6xdFAeaWTsDcy0rFuv6mIyU3JgoJS9k/15xXXulBxKVfgVMJ2uDKQ
 VhvS36Y0+7by7hIfGrXs2xNwaD77ImrotVI9IQuf1tyHdMH/e2+Tigky5McKj4574LQH
 hHbWioHmvrc73x5bsPzgukOv+IZvQGOMgv4Uf2083nVMfhJHL/rKLd/5opsvX8h7q05j
 DpyVS7FfzUkcQ3vXiRbdIFjp9vrUC2Le0k7kn7pmPlQc51u7X9Mf3kmaeEkYIQYbyvGc
 Pm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312400; x=1770917200;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIZIxRKPYwm2EGOkw2Z8RDBSbOPUzCX+RtBE8lRq7Po=;
 b=D1W0824VNjkPVZ5mt5RwIgBZrVujFOCTyACXxgGYjdKjlmqA+2hDIPjCSaCGjE5d91
 FDVmNgj1AttYNVEEW3dLhRVCuiuAEkTnmfHwWmD19D8gdxKZXPGw0C2U8ZgmNAsTNV8L
 QhIgEPKxOuzpo2APZrNPtx/k5prnNEQ67PNgsEUv9MnSRjMTqkrRBWoJz6dTvgdEwmCv
 5l6WGqUFaprJFsFFyhCX46bYjV0kMOprw3RY8o1F7xTp9ORlAbhm9BENVOL2Blgpg0cZ
 EF8pW8qZD2VvKWBW7FAn90oj0iQxANNySRcGCTSwoYcjaGVA3SPMM/I8ufM2c30Mhsmy
 jabw==
X-Gm-Message-State: AOJu0Yy35XkX9gN/WrIOxKb3RL2Z8OV+a8rbyrXyrrpPdmeJJiCKLQBV
 7FV14um/k79dQe4R0hpLqRpaOF8CAM6btSsBVP5tPORg4UG8FtkYFX9tH9zMADbiA9o=
X-Gm-Gg: AZuq6aL0SW4bzleSUvgTpdTipLQYYo/bUfjNC8Y/vNtfwzWL7xxIJ1ZsB/eK62oX1nq
 ai3ERLMSYE8PscLUU/efjYCyHIGf0XWQeMq1+EXF+RiQKYdleNRdulVHXKjvAmOd3Q/QdIITw+U
 8mP6gigKSr93l24ri6l1DAlGqvWHFLP/k1UZYQ5CBDdm2uZGQxvO0IjT/ivx+nK4UKFLAWrHkNO
 4U2TsqzKPgehCresb/zgydweNgKS+nLr44e9CD7RwjnloYgtPwZgcT83IbSYVFLGpAd/RG4PEZM
 aQ6h2E/fYaYTnunw4E8DKwpGg/IcitbFwFoicTf0dWqrcyfPqtUJOeRIJtbruLPMZhdRzCjOj5B
 KHsEXFlEa1FwnMZ9ObVHBJV8p75XKISY3zavAUQtFXIY+lJPgW/oWElcSmCU6+Y1XzRDFNUcn1w
 ==
X-Received: by 2002:a05:6808:6901:b0:462:dae0:1948 with SMTP id
 5614622812f47-462fca1e9a3mr22537b6e.8.1770312399831; 
 Thu, 05 Feb 2026 09:26:39 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:26:39 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH 00/24] bsd-user: Upstream misc system calls (System V IPC,
 reboot, etc)
Date: Thu, 05 Feb 2026 10:26:33 -0700
Message-Id: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMnShGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIwNT3aTiFN1SoCbd5JzE0pRU3UQzS0NzQ/NkE2ODJCWgroKi1LTMCrC
 J0bG1tQDumoXTYQAAAA==
X-Change-ID: 20260205-bsd-user-claude-a691717c430b
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, Mikael Urankar <mikael.urankar@gmail.com>, 
 Brooks Davis <brooks@one-eyed-alien.net>, Sean Bruno <sbruno@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5714; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=9GKjOvbiojOWcKRa6Mk2DHrUSzqOL854/5FQaKcyyRw=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLQsuxLoYWitBClXo3yYKZ91l/2e6tyW76fJ
 DYNh0h6sOmJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS0AAKCRBsHNEofbAR
 AKU/D/oCAEPrsunpRQtwcuoLGXUZNLJSpS4RVBQ8tbkGDZjsZc39xZBGV8UZlrjmPHwqmcIPj6V
 UnzKqntPeyH0PoiXcnR1tsDCjLqfIXxhyBDuvXF7Hg+0jY8RE7zHdHKjekgBeb/yhJR0U4syC6C
 HdvsEGqDXA+z5332FK7IWsGwxVPYT7l8KGzqyB/ZdB3tCBuMhlSsr5wy/P/RcIZRoMUG7qRzizw
 ZaynWYx0lkScbZbSv7F6E1/ZuyRPpBAdNds6otv77okIXjLdLp1tGCJ83IACqYLtWv/iDAmF6bN
 c0s3ur2AybSiaSQuo2WDd5NdkoLAQUqVf0pU3G8e8K/JPMQKxHGGnwVM0nSpWt67puuC0Vz4kB2
 9Y/LROh9lShXtbKS06lnANvXpNEGcuC2TQYCoWDEkWcXSDuSMUxRQYm+d7sdGQMKQqYFYaR+bY5
 sinXmuit66ig2/ediKj7wDXdGB4ZSZEWwCO0Y0MUKvw+zn9z1ARkRerSAxikxvXAFUbBbZiV7bT
 QjPjw15k5O7ZHt7dJB4LHpme3KRprx1H3rAIBRArnhwXkkO0c9EedYTZ8LlW3lt8WPi8K68qOT0
 HTFoQGrOhhV2W2vT6J5OEWnKJNPAnIZk244344KBHBgKMbbSI2Bk044hEAfxPPtVYNIgseNWosU
 mKVUI6GceaToC9Q==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22f;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22f.google.com
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
are the System msgqueue and semaphore system calls, reboot, quotactl,
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
fixed pending email to get permission.  Specifically, the following
errors are still there, and i'll fix them in v2 if I get the email
back (I plead 'pre-existing code' exception for the moment):
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

It's also my first time using b4 to submit.

Signed-off-by: Warner Losh <imp@bsdimp.com>
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
      bsd-user: super-ugly hack : current doesn't have inotify
      bsd-user: FreeBSD needs this too, so drop linux ifdef
      bsd-user: Add target_semid_ds and target_msqid_ds structures
      bsd-user: Add target_uuid structure for uuidgen syscall
      bsd-user: Add function declarations for bsd-misc.c conversions
      bsd-user: Add semaphore operation constants and structures
      bsd-user: Add bsd-misc.c to build

 bsd-user/bsd-misc.c           | 222 ++++++++++++++++++++++++
 bsd-user/bsd-misc.h           | 385 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  59 +++++++
 bsd-user/meson.build          |   1 +
 bsd-user/qemu-bsd.h           |  15 ++
 bsd-user/syscall_defs.h       |  67 ++++++++
 common-user/safe-syscall.S    |   2 +-
 meson.build                   |  20 +--
 8 files changed, 760 insertions(+), 11 deletions(-)
---
base-commit: 65fb9de4888f9bf32bc4f60c880da3dff04c4fd9
change-id: 20260205-bsd-user-claude-a691717c430b

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


