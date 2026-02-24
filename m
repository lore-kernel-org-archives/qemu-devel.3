Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C6AF3C985
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutaj-0000HL-BI; Tue, 24 Feb 2026 09:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutag-0000Gu-Vh
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:47 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutae-0001DX-Ky
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:46 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d4bc9e48bbso2192824a34.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944042; x=1772548842;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PPb7yDYZXB+tAaOyAxAamer5xC7wSlNDigVq9Rjy8Aw=;
 b=cqQfeLJHDYGgh4nZZoA4a5hO1dsViUoRe/W9E0MABM04OyGribZV1h61ZX755s6Zdr
 3Eu20AHedP6pRPzJF5tx9kxgZxVK40hoEoZofCCdXniWkE12eH5raz6NZcTsUzL82wWY
 sfH/ut1amjalpIqZ8W2GUuqKw2qfYEx+nEYoGI7XaW4evp/hiULOxdouzQzSFuXYlqFT
 f3E//Lkbl38TIow4hkFfSQw1jil5Wc16Gup8NeM/U6pbdxmHuqUmJXEqPv6Q6vG/+G7J
 wkYgeEAeCYa8+fddHKaz1pUAeCl1xgMrJpLx1ADSUYh7pzy3gRu33kmSQyi2f4h+3Ols
 lmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944042; x=1772548842;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPb7yDYZXB+tAaOyAxAamer5xC7wSlNDigVq9Rjy8Aw=;
 b=hMpd+2xMSEfMqoo0JdS4ES6Mb/LOIIhixQGsT0NtlDNsuXL8fR3QkEm2QNwggJNJ43
 5/zKm4O4K+lygZCl/DGcBrVzxiZY/kwl8cbqFMBJ34QAgumTG7Tdi6VXLNhIe/PFRi0Y
 ks/XKxkHLtzhA4TNpnFxuJUaBz8+09qHImR/VYX22X3zQh8ZQF2xa3vHIQ4ySqLXfx82
 jV4Jbx2+DyHhFRvMuIeVI7jjPGTAoGuws+rgKqOUAxDYLUnN9vbxx5ewQEpWccvocUHy
 mVep3NPCAevJV5gSlQGVL2krE01WzdB2sQJdwgItt687pzIuX4qfwMZKaPNdcAeKGH3g
 /IIg==
X-Gm-Message-State: AOJu0Ywz8yzLYgMzeBiF8LuMeetODiErCqijqcpfxORUVxAkqok7aWd3
 ZoGtsC3BWrJsQWX3zz1G1pedtJ3YfMmAQ0+Q0zm6xiIFX1LJ8RaEU677zljETJjyxCyTt65KQ7f
 Ezq9Ndp4=
X-Gm-Gg: AZuq6aIHItoaIShe7i0LuIP9cUS36AZmutuvC4owcdbS/6H111g27LEkSnnje+QeKsI
 DrH1zDAK2+53CB+HjqpBy2DCBzCLwi32Tuu9ZIdsebEDu8cYEH5NNJyEXKBgX0xQoqzrWf8yPZ0
 KpiZ8xA4RHZuHWS1bplrf4N2FtjR9fGv73DU0TRrkaf+JQXcSIRRdovw74yZ4JOi8FxtBYeBpDC
 vUzKxZBYq7WNNyoqbDwwbzn6OZWfzSB6N/TGfAA45aEPtFAwO6VKC8qFPDoh92ia4YuoICMK38i
 IECqM/rpFJUD/JH2Fv77zpoEfUuxlrLecnS7xedsQjdu0OsGgMSma1Sja0FeiLctLXYTEkRU5iq
 ZW+6ZPPeGrcU00fP2QcNj3cfkA6P0imMcwXQRwJ346PTMtP9pP1spr0KZRAUQKrtBePLmTh24mS
 bbMf0I/T8bMg==
X-Received: by 2002:a05:6830:6aa3:b0:7bc:31fe:57a9 with SMTP id
 46e09a7af769-7d52bf9c5f3mr7569321a34.31.1771944042241; 
 Tue, 24 Feb 2026 06:40:42 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:40:41 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH v4 00/24] bsd-user: Upstream misc system calls (System V
 IPC, reboot, etc)
Date: Tue, 24 Feb 2026 07:40:24 -0700
Message-Id: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFm4nWkC/3XNyw6CMBAF0F8hXVvTB6XVlf9hXNCXNJFHWmk0h
 H93YIVBk9ncydwzE0ouBpfQuZhQdDmk0HcQykOBTFN3d4eDhYwYYRVhRGCdLB6hhM2jHq3DdXW
 ikkpTcqIRtIbofHit4vUGuQnp2cf3+iDTZfvfyhQTrKzynhAuuGQXuAjtcDR9ixYssy2g9gADQ
 CgnvPFWq9LvAL4B6A+AA0AolxqGMeq+gHmePzrLhxMxAQAA
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
 Brooks Davis <brooks@one-eyed-alien.net>, Sean Bruno <sbruno@FreeBSD.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6234; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=NBAYuwP0Kl6BcdVCA9DKfPu5oPVK9Q2sJCnbezZiTkg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbheQvhN8vwPkdI+4fhgUf2wkYzLtJnSfN9/e
 zylPA2/0JGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24XgAKCRBsHNEofbAR
 AF7BD/wJgni9XfCTF/3ZJEkQvyU9a94pn37LJWcVF7jSNHyeD51ZucwO1IW+1ww7oLmgjCMjViv
 EQzUBU/aF3H0ZNTi0njEbYjdPhJ/uMDM9UKsH3d0I8qGwGKKZ/yszyDROI/Gg5U832WUsbrlxsJ
 hT+E1WyT/KTs/yOqHvQmQQfO4KGGRzZTI2OzwS0mw+dgpjOy/Wlkk0wIrJbQVB4cWtf1+WIHEiT
 F3nJUtQ9iC8umJJBQYD9YLxCPHDO491zXWAahozzcKuKo7XqVCyXPkyOfh6q549+kapc7rNKAIg
 FOzm9ZBIQMp1ypgxCEmuiS+m3xpdFySzi8jH/cK2aCEsD8HVw0SKKi5vWm2S68YnHE1VyvevZqo
 dUQeN7bWgTDcTh1qWgrwUFZD+oinCR8kJkBykcJAjPUb21MsKIx0BAmFPiPGkXHIzae+n9zTrOe
 KZGMx7FHwEq3h+16GfCF0h+pwtbKryBMhKwNT4jyilbndozLPyTGrptLC8a5QxwSjpUGRnpNTXy
 sTZ3+ursar/EY+Mr4dOBcyeePEuRYCQaAOi1h95kdJzyf6aq80CMDFwXmKMN5MaptNJ/QqZhd8v
 4Zur8HytLuLgWU3gSyfDxqbDZkCboI0e1olU/zE8PBOISphP2Hq3n1RHgA3RNH4Xn2xM5FRVU57
 bsRaAV//Rv5F9TQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32e.google.com
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
Changes in v4:
- Fix an lock_user leak in the case of errors.
- Link to v3: https://lore.kernel.org/qemu-devel/20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com

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
 bsd-user/bsd-misc.h           | 363 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  52 ++++++
 bsd-user/meson.build          |   1 +
 bsd-user/qemu-bsd.h           |  15 ++
 bsd-user/syscall_defs.h       |  67 ++++++++
 common-user/safe-syscall.S    |   2 +-
 meson.build                   |  14 +-
 util/meson.build              |   6 +-
 9 files changed, 697 insertions(+), 15 deletions(-)
---
base-commit: ece408818d27f745ef1b05fb3cc99a1e7a5bf580
change-id: 20260205-bsd-user-claude-a691717c430b

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


