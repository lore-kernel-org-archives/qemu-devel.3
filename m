Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858ECC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weVvd-0005fF-6q; Tue, 30 Jun 2026 06:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weVvb-0005el-89
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:42:55 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weVvZ-0004cU-II
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:42:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so3603985e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782816171; x=1783420971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kjnvV1ZLxwG9+vMGEcYHhz0AxISfHrD4tLW/HUNersQ=;
 b=pBj+I3Afb6IuUQsHduti64U2WPHr8jqkJ/vQkcV3qcD92NmX96W6SY8IsMbYs9OPXQ
 qU8rpcgkJKtE/kMM6Uvrr3wkyxF67Ky4W0y2NLopnuOYwcU17NI4EibmoXdrM/MOkQ9D
 cZRApc/L8EXc7Epx8fwTkAjLf28nrkEY5lESFrkSZWZAm6zu/spcHXoKH0sPzWZ5/hKO
 ubXBX0rBhjA8uqKVVOQIChxMkQJMuu2sNK0UdTPTpQGgJ3axFoqeYbpK3OIU/+8azDDx
 nTUeE9qQRRepX/BrpWJ4lXMDclZx2mtEW+4P2XqPN9wSQ6z5zdw/wKHVCz6JQpT2yjUW
 TCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782816171; x=1783420971;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kjnvV1ZLxwG9+vMGEcYHhz0AxISfHrD4tLW/HUNersQ=;
 b=lAIW9lrSl+197hAIU0tm5N7YJG4bpN0tvecH4jrsZsUKPE8cGo0v3F3gOx/mx9WdsK
 kV6zZhe8SylG12eLiLJAnJfzNLv+dQq7aFm/iSE8VmJf/0tmzANImVp423AypZ2w9ooV
 gTF2/o7v12QF/tTKi33+CRRTomonmAJlVU628fR1wRG0lUSDBO0qj2ZMop6cOBykxuGI
 EW8YAy1DSp7X8v+b19jMnjotB5CnBzjWLFzIUGD6+BStE8J6cUG6sysIQspVJ255241x
 4YIO5NwRB9tDRn9RDiAl7K71U4Q7lWXpCKySRVjWMm9jtWqZirKvMGoeuoOAwD/rFaS3
 qihA==
X-Gm-Message-State: AOJu0YwWdDurGZwIgUhQToErBGeHtbdBpGXghzezHscwvfv9oRzhx3zn
 FM08lVNnAp1TJvxMlr3l0xDa0vo+asZ0V5WubHNaTQLmsiRbQul66Xj8riYKLxUimHsOwLE1uvh
 uEqX6
X-Gm-Gg: AfdE7clv0ougOKBbmH/CCxaoay9XVL7uSpmDJCv79o79rFkJK/+byjobhCUVrNuDMx3
 VWAA+Q5gT+LlsH0VzUOXqNQmqs4rVfzb8ql3LHW3nhxcUwvxTz/n1VpsdqA8vtW+gij+Yh1j1a9
 J5Lq6UspmMDHkni2V20O0CnA6iv4ozwCqzYfmmHgpiz5amzenoPodrfosM6Axk5MfxgbXWorewp
 r1gf02wOBgpXBbp5XqJQQqN+Q32B07s6bdLEtjFjhFXMuY4QkCrnJKO+xVnlKCZ1/pCrt9YDaRz
 Cs5ob2FO+YnR+axS+GVDqPL00eYYruE/3rn7yC0ayw6yqmIKZM8Zz3HKW7V4/hmUFaFkPWWuioI
 PLeFslvNZv06cAb2519nvs5syUEfBCeKQpwKU4RQpySkzOJx5jCby8zbC2NGE9X7hjj3QJOvzXK
 YWRRTMsSsU5f3FF5th2J8x3Fak/78ojFb1K7Pl4mBLkxGG+hSFzcEJeAmfoxR33VG90habawwfx
 1KLYJe39kov07Wn7JVtKEBefI9lzHE1
X-Received: by 2002:a05:600c:4fc4:b0:492:4363:e7d6 with SMTP id
 5b1f17b1804b1-493b82c14dbmr45821375e9.37.1782816171242; 
 Tue, 30 Jun 2026 03:42:51 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47563e0eee5sm6543818f8f.5.2026.06.30.03.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 03:42:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	John Snow <jsnow@redhat.com>
Subject: [PATCH] hw/ide: Don't divide by zero if guest specifies 0 sectors
Date: Tue, 30 Jun 2026 11:42:49 +0100
Message-ID: <20260630104249.2533126-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In ide_set_sector() if we're using CHS addressing the way we update
the drive state involves dividing by (s->heads * s->sectors).  These
values can be set by the guest using the INITIALIZE DRIVE PARAMETERS
command, which means that s->sectors can be 0.  (s->heads can't be 0
because the command passes a heads-1 value.) INITIALIZE DRIVE
PARAMETERS is specified to not check the input values for validity;
instead no error is posted until some other command makes an illegal
access. So we have to cope with a 0 divisor here.

Special-case s->sectors being zero.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2399
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
We don't seem to ever actually check that the guest's read/write ops
are within the CHS limits it sets with INITIALIZE DRIVE PARAMETERS --
ide_sect_range_ok() only checks against the underlying block device
geometry.  Maybe we should?  Then a zero-sectors misconfig would
result in our reporting the error on the read/write as the spec
suggests we should.  This patch fixes the division-by-zero, at least,
though.
---
 hw/ide/core.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index f78b00220b..b030531534 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -646,13 +646,27 @@ void ide_set_sector(IDEState *s, int64_t sector_num)
         }
     } else {
         /* CHS */
-        cyl = sector_num / (s->heads * s->sectors);
-        r = sector_num % (s->heads * s->sectors);
-        s->hcyl = cyl >> 8;
-        s->lcyl = cyl;
-        s->select = (s->select & ~(ATA_DEV_HS)) |
-            ((r / s->sectors) & (ATA_DEV_HS));
-        s->sector = (r % s->sectors) + 1;
+        if (s->sectors == 0) {
+            /*
+             * s->sectors is under guest control via INITIALIZE DRIVE
+             * PARAMETERS and can be 0; this is an error but can't
+             * be reported at INITIALIZE DRIVE PARAMETERS time so we
+             * have to cope with the bad value here.
+             * (s->heads is always at least 1.)
+             */
+            s->hcyl = 0;
+            s->lcyl = 0;
+            s->select = s->select & ~(ATA_DEV_HS);
+            s->sector = 1;
+        } else {
+            cyl = sector_num / (s->heads * s->sectors);
+            r = sector_num % (s->heads * s->sectors);
+            s->hcyl = cyl >> 8;
+            s->lcyl = cyl;
+            s->select = (s->select & ~(ATA_DEV_HS)) |
+                ((r / s->sectors) & (ATA_DEV_HS));
+            s->sector = (r % s->sectors) + 1;
+        }
     }
 }
 
-- 
2.43.0


