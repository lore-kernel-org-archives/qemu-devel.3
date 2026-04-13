Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDB4F34C63
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCJIF-0006K9-Jf; Mon, 13 Apr 2026 11:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wCJHQ-0006Fu-Bj
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:32:55 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wCJHL-0002x0-6O
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:32:50 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d86eb7c854so2224989a34.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 08:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776094365; x=1776699165;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6HIYnL74G9vWKIG7UY01i+b0GPOrTKuUyV9x38ekQzQ=;
 b=02E6RK03p++3S84XwJSqv+xYuNpkRlFt2mB6Tb1GiN9TdwyqjaWawWEImLok+iahvE
 G6J0SFs2i0WFPBIEGXjxddBs4f62VidyaY5I9RHABJdRdCxKXIj1A61oWCWD9lizYjeA
 RGIug59yX8nIXaSztNskyLNRCbP2lMGEDyMAUwFK2/LdboIRxY/uFX6KEmsDM24CUY8W
 Xs9QyoTw3kWYniNBwDQchHaKhRxnYpnMUPjmij4RuMmbTlkhPh4ZTilGpai/XPl/awnx
 25RFcVezs90PYZl1x64MeLgfgWmyugC3h0AimX+XIugjPyAxaZTPu9QhXqlBkt6jEKmE
 FjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776094365; x=1776699165;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HIYnL74G9vWKIG7UY01i+b0GPOrTKuUyV9x38ekQzQ=;
 b=Zd4wToiTX/L5udQLDPP6tUziLYvQhHmKkJjyok7Q3v/0gMAN0jt3g/iF7+hKUABjCn
 X7GoYRw9r9svn0yZmMcbOBUuMJZ4DJ/IwY24tLu8wqVoy6MbQWU4H9jP8xW9eaCeM3Am
 chdjquWZT59zx+e6oRIIx+51waiX0oorfxhNFdVxtPVOe09eZgrlQwksMff6gXNumNBA
 3ybDHGd/sB2nyHJ3y1fVfZAiR8v8w1xeHw3IVhvWes6Qikg3B+2dCEkNDvXdmIs5ynkx
 CzuInhbV67KOjWRmMhtYONB8JSODV4FrkfYRBUId/0R/ybUfhAQxtGIVtPAQHbgNUlri
 SvrA==
X-Gm-Message-State: AOJu0Yx+ZFRJuIZNEpIBwhZGxGUlpBf27njK4hm+T8EvkoJ/6bKNIJ4A
 ar5lE8EA7E+W1tUNvWSBmeze9LNQjz1PSmfSKtQl7iVdShrmpQirjHjd2EglTqan4jE=
X-Gm-Gg: AeBDietjMPmB4m8RExF5pw+E0vb2JFUD+Zv7YhQgz9sLDnM2/fX4zRaNIC1/fMMPVRD
 E2+6YXNcJ3cxOiSUMTEIrHUaLK4ehe6FziKoIUYfeSV3aRLAtUV/ASu3rnIK3hIAjuL9Rm0uO53
 1yxF2TcKtG1vJXHXISoOUv2/LO3li6rKTm+496kiVwV783l7lHOrDVbomkMcnJF+74Ex8HZKMrH
 eRHVbcOIY8FHKaz+z70GltYEaAIWlh9kQdZuaU2i2/RkPX5M5ofGm+s7tdVa5eNvUCGqkzVSZMd
 Tpf0Gh057few2NWwAdQVrmW/TmN7uqgVkyMPz5b5CNfX07rKo/xuIcWwlo5U6NRn2Fp45OPVQwy
 6+yMqZWjT1WlQVgjvfiodAq/mxVXzzKTA38QqaYI9dQsGeIhOZqWugaLNtDEo+9dh8i3raJWtVP
 EuCcGrY1nI3DbddJe2Llsi
X-Received: by 2002:a05:6830:6d54:b0:7d7:ea9f:c0f9 with SMTP id
 46e09a7af769-7dc27a236f3mr7911178a34.0.1776094365383; 
 Mon, 13 Apr 2026 08:32:45 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2696c463sm8659192a34.23.2026.04.13.08.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 08:32:44 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH 0/5] bsd-user: Generate system call numbers
Date: Mon, 13 Apr 2026 09:31:42 -0600
Message-Id: <20260413-syscall-nr-v1-0-f70408d042ea@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF4M3WkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Mj3eLK4uTEnBzdvCLdRINEC2PDtORUy0QDJaCGgqLUtMwKsGHRsbW
 1AIRL4atcAAAA
X-Change-ID: 20260412-syscall-nr-a0a831fce9a0
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1698; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=vtDT9NtU71NG/2MazN8rwck6GlVgWWz7UFUcQjK2czQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp3Qxib9AajzRyGuia1/rZp77i/OWIwVi8iY+4f
 59oIj5Vx7qJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCad0MYgAKCRBsHNEofbAR
 ABvFEADMmneTEHKHz03rFfN+/GfVvqOHxMvka6DVI26aalZHddvfqf7JpIJSRf0rEsiq8d0vCxO
 jea2YbuZC21WcNA1Yxu7RmjSFwqJjWl/YpqEuIOgv+tkt0rjjDsrXly/7zYzzrAwJneczyWLFo0
 /zo8AAmR5HYgZLaXB3dHJQYuHninE7M/Jto3uxsSmmNgLHlvVjws91oA+MZGkHosg5FHcg7s+7O
 RDCIXkYLYPsxIDLmzz6k+eSfcFrR7TfOo9Axf+ytCCM4AM8z/m7omYwgqLOg+jP5CFT7mzYty0t
 i6pMFHuIRrFn714NOCRJ/oQCN6AjKznrVS5Ou2Cg41LrKSyA77opo0ly9GvLMND5U+/6uhim3OC
 9PpnXJ5fHHKZgeNqZ1JWmp3KjSq2o9K7NkoVR11HdksaEbCtqHTjvL75nDa4kbYFygiQPZYAjnB
 c/yv67eey+1/IJJU6DFD/u0JWq3T4euSgsOM7/SEmWoOdMaXRcBL145w9mlhtk9vHN1sca8a7e8
 gePeqA5wGOhkWu0Ua/Kq5nT0fPjETEm8WLMZnDuIJ8bZgZzlul53JFjO3xYazO9eU/PPmXcxJJV
 A/pciVHGXEAeYlh08PzfDEdPx6cq6TJD+duSwP4oc502eIwbut7J3b8/v/vUYblBmVh9A2vyne+
 tIT1rKtSgV4ikIA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32c.google.com
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

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
Warner Losh (5):
      bsd-user: Add syscall header generator for FreeBSD
      bsd-user: Generate the system call numbers in meson build.
      bsd-user: Conditionally use old system calls
      bsd-user: Create os-syscall.h
      bsd-user: Switch to generated syscall_nr.h

 bsd-user/bsd-mem.h             |   2 +
 bsd-user/freebsd/meson.build   |   4 +
 bsd-user/freebsd/os-syscall.c  |   4 +
 bsd-user/freebsd/os-syscall.h  |  21 ++
 bsd-user/freebsd/strace.list   |   4 +
 bsd-user/freebsd/syscall_nr.h  | 515 -----------------------------------------
 bsd-user/freebsd/syscallhdr.sh |   9 +
 bsd-user/syscall_defs.h        |  18 +-
 meson.build                    |   2 +
 9 files changed, 47 insertions(+), 532 deletions(-)
---
base-commit: becd22fdc2a071783d9e04421526633772b3b98c
change-id: 20260412-syscall-nr-a0a831fce9a0

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


