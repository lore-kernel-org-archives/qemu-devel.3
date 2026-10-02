Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214D6CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCb3N-0001VE-5P; Fri, 02 Oct 2026 07:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xCb3K-0001Ts-H7
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:03:46 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xCb3I-0008UQ-K5
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:03:45 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so57160885e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 04:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790939023; x=1791543823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AkIWwe4jZm6YDp2pbP9DnlPuFTMr8x6zTE3n3Ll2UnA=;
 b=BnGDyp8KmZmxE18Aunz11CucttW47mzo4gc/tTBTccdYOTSGBUVLzb8NEJLQ6nar6Z
 UFInBrfi6l9GrMCoQ6N6vmBPC9MjyokfE1nJztRhkxnUm2cce0Jx6Oz4iyMf58goodK8
 pckRrkTCuqhqERtIITIqCErBUs5A40gnM6M88DITpbl12VdxEqMZetJRgdsbl3mt+bPe
 7wzXfqh+0nph+N+eR8BKCJ0pJ0hG7zlsAC0CuzdLaFDYWNXBRbnkB/SwESgprcoYCVns
 sYjPDegeQuCqM/f9Hblg3uYi9PLnZLtV/4AhA1AuaFqBxHATKctIJ8d1AeNhpWwkLRnh
 xXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790939023; x=1791543823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AkIWwe4jZm6YDp2pbP9DnlPuFTMr8x6zTE3n3Ll2UnA=;
 b=Xow4ouUJ8jhuNuSq0lsyhmMvlEfbDZJozWH1vRCDXeCW0euUtR+/IkE5H0Sqjl6RJV
 zWv848rH63xPsgXCCEwbp0+FPDAnCL8CwlYXU4tI0COSEYK0fMZySZVmXbyqClJUDQ5r
 7VDVmbTgGd7QgGWWBx8IzlJwJqOZDuYAr78YqoU4fJ6CKmkb1HcOUmRQFQgU29g7ucGH
 +QJ8Fixij7c3I2ZtF44kI2WBP0e07fe4Mxps0Jp0DlHbXtUXgY8eO2jzgN5yQ6JeSOPu
 4mv0YqbtWn22+spVxLF/qLPc9vxHs4Zm3AuY7/p83egTjGIr5jVdMLWmSgEzQQSkLv4D
 v0RA==
X-Gm-Message-State: AFuF++kMNEVnZvrGirLEIoyM1+cK16YEtAcvQnSN+FUIqzRPj6cqCCdl
 hTRZD6FohbjDmth+Pa2gC6Ph19KoUKLAOZqkrn0HGOQGf52x14tbhrSA7ctxfeX+cxedOUHrv0p
 cX6JQ
X-Gm-Gg: AYBFou2ElTlVzVl0A0XHe0s+jCU3A6xTc8Q6s8zkXw/vZYcU2C5SKCgr6WTybCh01Hp
 Ra+2gF0+g6QUkvqGit7ac4YwBAukjGVAQLKZ0M9ni5WTFgb3XlwAVASGIo0Y55j6wn9USmMyoXz
 1Nj5I5C2pCuHjjUTcCGr++dEsfnHvNx4lXFTJdHSh49isX8wUUvVqJf3KvrQzsy1PmcM/6/VuQY
 foIvG+rnpbhUIAajnVnPwitf5p+XqUWoiCNb0uG4FzylewjmWGJBGfKKky+WB4PuhZbgdcUUdKT
 eo443Ic1c9q0h1IprAnPiAM4+gS7sE99MZ9R/CpPmuSXU8EU5pIkxmu2wpcOq6z/cSYxhi4aeeh
 VYWHDmdOGU9H5HZ49TUMvSRQ4GvFuXo3VFnk5D290cbCjekFGZONHDaAX5O2Ptn/PtmxCgof3oD
 Ecgc2gq3le1N4Ve6Hbdo2vcy4lZlTPtH5i7E85tnuB3uM0nM58e5YVaFWBFE38XLdwg7U=
X-Received: by 2002:a05:600c:3103:b0:49d:1842:f001 with SMTP id
 5b1f17b1804b1-4a027559c92mr43524285e9.14.1790939023073; 
 Fri, 02 Oct 2026 04:03:43 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9f21:a362:21c8:d9a1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03ff3cab2sm24533785e9.2.2026.10.02.04.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 04:03:42 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 2/4] migration/postcopy: set destination postcopy-active in
 the run BH
Date: Fri,  2 Oct 2026 13:02:56 +0200
Message-ID: <20261002110258.1835979-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002110258.1835979-1-den@openvz.org>
References: <20261002110258.1835979-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=den@openvz.org; helo=mail-wm2-x11.google.com
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

From: Denis V. Lunev <den@openvz.org>

Commit 7b842fe354c ("migration: Introduce POSTCOPY_DEVICE state") made
the destination enter POSTCOPY_ACTIVE in loadvm_postcopy_handle_run(),
before it schedules loadvm_postcopy_handle_run_bh(), and only the BH
starts the VM or moves it to RUN_STATE_PAUSED. Management reacting to
the destination's postcopy-active event can therefore still find the
VM in RUN_STATE_INMIGRATE, where blockdev-add creates inactive nodes
and attaching a device to them fails with "Block node is read-only".

Move the transition to the end of the run BH, after vm_start() or
runstate_set(), as process_incoming_migration_bh() does for precopy
COMPLETED. Without a return path the listen thread enters
POSTCOPY_ACTIVE directly, and the fast snapshot load path switches
right after scheduling the BH; in both cases the state is no longer
POSTCOPY_DEVICE when the BH runs and the transition is a no-op.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Juraj Marcin <jmarcin@redhat.com>
---
 migration/savevm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 5ec09d4889..bc1bc98a0e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2263,6 +2263,10 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
     }
 
     trace_vmstate_downtime_checkpoint("dst-postcopy-bh-vm-started");
+
+    /* Already POSTCOPY_ACTIVE without a return path or in fast snapshot load */
+    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
+                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
     qemu_event_set(&mis->postcopy_run_event);
 }
 
@@ -2277,11 +2281,6 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis, Error **errp)
         return -1;
     }
 
-    /* We might be already in POSTCOPY_ACTIVE if there is no return path */
-    if (mis->state == MIGRATION_STATUS_POSTCOPY_DEVICE) {
-        migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
-                          MIGRATION_STATUS_POSTCOPY_ACTIVE);
-    }
     postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
     migration_bh_schedule(loadvm_postcopy_handle_run_bh, mis);
 
-- 
2.53.0


