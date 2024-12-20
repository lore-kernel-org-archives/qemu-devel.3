Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE731E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaUQ-0006jF-C2; Fri, 20 Dec 2024 05:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaUN-0006Ua-Gf; Fri, 20 Dec 2024 05:44:11 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaUM-0005QP-5C; Fri, 20 Dec 2024 05:44:11 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21654fdd5daso16183195ad.1; 
 Fri, 20 Dec 2024 02:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734691447; x=1735296247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6iYuLZgbonS1IR/x+IP4SM/fqY76/CEG9s7cHCYyGpU=;
 b=A9J3o0jVwZN8Ch2KrnAq5ukWGssEAru3VnCLLGlxR4a0rdfi2Ew9fWrYLicFmvVCG5
 qBCazDK7jghAc1zfhkcxy36/NycMCFJMLOGhm6HRnTs/gyKhUO0TZIxTPLtXhsnYnVMt
 Jy/xU5yWx8WTxeEb0DsTuOBxm5Gumw2xHbLS8sQ4TUWDntuDT2YIEBbMgt1yLa1Eejiv
 zn8Bu5dkIXc//DOHQ9n9VSQQwfBLXJ6QGwYvCzobArJYA2Xc6G/zkrQJnNZ9thQg5Kid
 UnFCtWvLAiPluD6DGXZDKR1T6l+jR2TTqTI0aFO8XtrvrpaJDwEIOe6AD8JmtTaV+o5o
 0+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691447; x=1735296247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6iYuLZgbonS1IR/x+IP4SM/fqY76/CEG9s7cHCYyGpU=;
 b=OAzhTuotXekheJZDDI7GIR3K6pIQsacafYOB52pdMhAxHhZk8l29wvVhBFo1AgxTfJ
 3x6PFdzbGapijmvNs36AgvHFUwsZ3wqawv/b0fFOAt6MA9LhfYzxgGG1iu+28g6+r5xA
 omc3/dNA6DSpq+TvifWQN3F66jjQ1RPXK5R4/kMzpDp+Hxr4osjSAMs4omtdFna8R+sQ
 B7vK76LPwfFL6c8NB0wr7bpaBzCl0veP5b8rD2fLlYOMm+DxMFvddBEAG0EJ8i6yohYo
 O2Y0fHiDC6K5wAEYiLArMEOvJi80xPFPwZTQw6w96pBrZfzn469Sf+lP8zPh1cTPtOJo
 nm5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD3KwIlJSxAEUkUuG5oAjuNU77fGkWdldUNINeyxvTc+X/4xTee1l7odlx+2+o/z7hpPtjVXn34dS1@nongnu.org
X-Gm-Message-State: AOJu0YzSRqgFjwSA7HeWEWOz/OyH/0i2UF+ZpmMSSb8J4W5QpWU2F/Yw
 vciAb+mVi8mXVhQxYQnw9trJ2n7lnI24nLJB8lf6ciEhkNH4o/HHWRcGrg==
X-Gm-Gg: ASbGncsKh85AAoKmbHM1V55lPgZsTcO1qZ+9BVSvn+kDgUD7i3OeBd+LgSLyMHPlerO
 p9hxAoxVF9+SzHhu2Vi0ujvSMJreWkq0NE1B8JKsZ/TEpIPaTcgcwMz87dDx4QK+dW4YaUH6mCh
 XDrWUL4pox01nBBmY5Y2S6os9nEfQN/yP3p6eDdzf00/hqEnnSgB62+6P6uHbJjoaDWfXa1HcVV
 ymcR4AYjgkoiETctfyK8Y53P29i2ts5XCM8oio35N6tck8WgOH/rTlCPNV1xiijl5CizoefMUCU
 cT/yjsNfrg==
X-Google-Smtp-Source: AGHT+IG3aaxYwAaHxmCsiQXVE89K6qWiw4Q2poUWePsa42NqcKFrbxoScOGi5DQ8TIshqinb/y/L0g==
X-Received: by 2002:a17:90b:2652:b0:2f2:ab09:c256 with SMTP id
 98e67ed59e1d1-2f452f01cd4mr3873285a91.33.1734691447161; 
 Fri, 20 Dec 2024 02:44:07 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dfd3sm5376942a91.32.2024.12.20.02.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 02:44:06 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 12/17] hw/ide: Fix record-replay and convert to new bh API
Date: Fri, 20 Dec 2024 20:42:14 +1000
Message-ID: <20241220104220.2007786-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220104220.2007786-1-npiggin@gmail.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Convert qemu_bh_schedule() to qemu_bh_schedule_event(), which can
specify the clock type, making it compatible with record-replay.

Restarting the IDE device does affect target machine state, so it should
use QEMU_CLOCK_VIRTUAL to recorded and replay the bh.

This fixes hangs in record/replay when using IDE devices.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ide/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index c527caf3d69..500ea73c8be 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2780,7 +2780,7 @@ static void ide_restart_cb(void *opaque, bool running, RunState state)
 
     if (!bus->bh) {
         bus->bh = qemu_bh_new(ide_restart_bh, bus);
-        qemu_bh_schedule(bus->bh);
+        qemu_bh_schedule_event(bus->bh, QEMU_CLOCK_VIRTUAL);
     }
 }
 
-- 
2.45.2


