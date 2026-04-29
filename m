Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C12EFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI66z-00019k-Oz; Wed, 29 Apr 2026 10:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI66o-00016c-Fv
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:41:50 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI66j-000395-3f
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:41:46 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7de46b8e432so6488265a34.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777473702; x=1778078502;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x8Jrxlh4pXLnouwzhT5toJOacQtuCOCiBpkk8sjMJOM=;
 b=t5QghDPg4Ev85JDCO8fBe6j7q607DU2LSyrGSYo6NFnvp+uqIdAoPXbGPoqxsS9VRb
 iLRDwpqdVEnfgMX6uoZN7GuE9eYsuQBZUEsEhwQ+TYQwM3XHdeIAbmKSsgIxQuStO28+
 G0p0TJxApLYwJU4Irh7T4OofOMnB591xlq20161EZjT29yRuKeTYPasg/BIrwUaJNxYT
 R1lA/WmbFra03GbwKPYnvXJSfyZP+Qx8DmDXu+gQJwBNVW85T2Yh4U38QsHr9Z/4cWoh
 bxl9errAFLpRv1fqMKmdF9ZXx6Pvc+DJ3Ez6pHzfE9Hu9TMUObILvMldv7XTyjyefiXV
 yQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473702; x=1778078502;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8Jrxlh4pXLnouwzhT5toJOacQtuCOCiBpkk8sjMJOM=;
 b=Aaw3+RPXD75ksLUCWVgt+rz0dEJY6v9M7soB2ALoCmdlE2dTrJHmPKOfErg1/CnqNm
 Jkc/dTcY5kfvrA1Dy8+wRPQcj5bM3bUmrmlG5ILnuYMNBTsyQI65aqxkvwBm6znbI2Oz
 LZj7iV1RrnKx4NMv2yk24YcR5E4nIsVNC9S3BEitEJG47boIliRvr1AxypG0f6rGN1Xb
 2h3BaxiT7fdzRH6qdxKRoeqGT0xlT4Qo2T6jKIl42VhQ2SDL0hxQS+wansNTBRVA+vPf
 obYvIXd4HICDfS0hQOf56EaW10a0U6mtSfqghYqSeCXXLUtka7cQCsGzILnoK1JVVOG8
 9jxQ==
X-Gm-Message-State: AOJu0YysxwzG3zX/zEFVlt2zpzao0TcgaYFWg9303XkIE1y8DCcJDAqD
 3FiOGsL/Dw6FLTYPhVxIGvgcsko69OBvKa7bUz454NuD51o/Hk6sfz0TTAMCh/VTibo=
X-Gm-Gg: AeBDietbWTO7KogMmTFSQnt+A6QuPpjcpXzhOmtlQvUU08ntHq3Kq+b5iRjNk0DEz31
 EHlM3d1ae66xi+v0lj9ikbVjrw8xJgshuWDNQU3bFPraW87Vg6oihlP6j3yegT+fPdoNJq5Cypm
 v8z148tsuvck+CVbqtuthXSFVdtywXxRwap7PX2Sbgc/0VGQopKtA+2mKUnuacAe95MxTn+PbiH
 c9TipR4T6RjgytzDrdVh+E7mf5tZNWAm625q+hAuykfqZ9pynnTITJDQKGn7JujQm6+sLWa2dZG
 k5wzL5A7Mxnr8LQhvh/gncXAJa8CzjY6sEMSoJ2dZ9+eA/GBhrgnyi89Wp0OSFCKwnp3hvwPHzP
 ciw3eU0nA2fnrunjwcNftBOeUO9qNhQ3piPY6rVyiR4tr3bZKJlDdHPpFss/Bsq6ThpVwYqIoMf
 yGypDUcYv3ITqCOiLz5ROA
X-Received: by 2002:a05:6830:4195:b0:7dc:3db6:f02 with SMTP id
 46e09a7af769-7dea65a477fmr2474148a34.9.1777473702145; 
 Wed, 29 Apr 2026 07:41:42 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deab9d6067sm1553377a34.22.2026.04.29.07.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:41:41 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH v2 0/5] bsd-user: Generate system call numbers
Date: Wed, 29 Apr 2026 08:38:50 -0600
Message-Id: <20260429-syscall-nr-v2-0-67a8d09dc13e@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPoX8mkC/03MywrCMBCF4VcpszYySYNWV76HdDGmUzvQGxkpl
 pJ3NxYEl/+B822gHIUVrsUGkRdRmcYc7lBA6Gh8spEmNzh0J/TWGV01UN+bMRpCqkrbBr4QQj7
 MkVt579i9zt2Jvqa47vZiv+uPKf+ZxRo07Rk9Vg16x3R7aCPDfAzTAHVK6QNMiPn3pQAAAA==
X-Change-ID: 20260412-syscall-nr-a0a831fce9a0
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2142; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=DXrOQPMUU2p/wwQdzajEiLAJbbZlLhu7bipARnvROSQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hhDKl+Wd4sewgBlSN0jVbtzLL8gY5hmcXQDc
 Lq7F3xdWO2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIYQwAKCRBsHNEofbAR
 ADxFEADqd9UBuR3rvNvHPtaNkob/EQb+7lmqjBMfL7XmCcWru0eAnEyuV4wORWPLo8EeHXVE1YY
 7znnQglFyj11scWdD9djRUk+agWmaqxk2Hs0iJEE9gy3itTv2540yVVEnIOU6/W2nTLFmYXfdZ9
 gc3Gr53LXfsLkGZxTnUcxM34wNsYxYHWxky84dQ/3f/icQvO1AhtoAeoIK4v23JR/n/jnhiTMEE
 4yMgYlh2Yx0ICrRQ9InDU2lYFB3BLFt/T/gRCglOWOhdqTHmtpBO8ubvoEa/MMtQ5TlrrmLxX+K
 unsKRW5BpZM2ZJs6iVV0yGRR5i2Lzidf01Nl+MnYc+Ab+X70ajhzkmau6pZZpJnS8dFvzCBFCV/
 IictSmAk2wcPZNpgdEgc1mff/us1nVW23NpiuqkIj/skkQdT/5xLaAjdvmgTTEYPmjFe8OkjU1I
 zF+QlGIRo5HF36Bnn6VtLPmKgNCvffALEBAieMsd9g6e+DwOLOVNc+8JodtHvvXFZN04pJUM5s6
 lwbxXxzINKu2oPkzxTiFoPIKBu/KEaz1MlXPUmljg5LI7GmDZEuoEnc+THBn3OkC9hIKzjrShAH
 HlGqrrH9aT3h8Jq+19iib91NNbZXfv+ySCw491XWCcuE3K15fb9RTgt5TYaXZHpHdZ6sOlmop6P
 vdWZkIim+zRCSnw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x335.google.com
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
Changes in v2:
- Rebase to tip of master after 11.0 release
- Regenerate strace.list, can't do this at runtime just yet so include script
- Simplified syscall generator meson integration.
- Link to v1: https://lore.kernel.org/qemu-devel/20260413-syscall-nr-v1-0-f70408d042ea@bsdimp.com

---
Warner Losh (5):
      bsd-user: Add syscall header generator for FreeBSD
      bsd-user: Delete sbrk and sstk system calls.
      bsd-user: Create os-syscall.h
      bsd-user: Switch to generated syscall_nr.h
      bsd-user: Regnerate strace.list

 bsd-user/bsd-mem.h                     |   2 +
 bsd-user/freebsd/meson.build           |  11 +-
 bsd-user/freebsd/os-syscall.c          |   8 -
 bsd-user/freebsd/os-syscall.h          |  21 +
 bsd-user/freebsd/scripts/strace.lua    | 117 ++++++
 bsd-user/freebsd/scripts/syscallhdr.sh |   9 +
 bsd-user/freebsd/strace.list           | 704 ++++++++++++++++++++-------------
 bsd-user/freebsd/syscall_nr.h          | 515 ------------------------
 bsd-user/syscall_defs.h                |  18 +-
 9 files changed, 599 insertions(+), 806 deletions(-)
---
base-commit: 759c456b1d22fe4083c8b384da27d3f56fd53f82
change-id: 20260412-syscall-nr-a0a831fce9a0

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


