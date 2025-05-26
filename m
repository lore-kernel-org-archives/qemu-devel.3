Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D252FC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQP8-00070S-W5; Mon, 26 May 2025 01:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQP0-0006zW-NY
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:29:36 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQOy-0001xT-PJ
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:29:34 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-73972a54919so1304385b3a.3
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748237370; x=1748842170;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mxBo8L3NXbm7EbxkgT2admP/cVTk72z8UPC5EzeX5+I=;
 b=msTLa6Omk96FQz+vFfaE0gAcKLK0m0jhBh3JF7SvxXcAB23OOEPbPedUjp7Jtl45qX
 TojULu/PHGpSHdjDOIXioMRvC+FFX9TT156MEdWyyRItOSTxJQhV2QSAwGj7ABT7at+P
 VPAUHMVlC63JvuMQoI67pB95ffa9vVr6jgAUdvv5mnP1LWfBvTVheayEa6UwQqxkMyK1
 0wNknkbgr3RjBZyYGUwa10bJzgYcC0XjUd2VJ0XWPUlFYwAbQDAokgyELjHQ9S/YG7Wx
 dI/QFmi3216zV++lmBh/TW9eMAYp/xUD2Dse9aDIflEZt93E89XiPUTruEW/Y7Qpn7df
 qAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748237370; x=1748842170;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mxBo8L3NXbm7EbxkgT2admP/cVTk72z8UPC5EzeX5+I=;
 b=M5o5NweNfFjS/kjvZ1n9ubg36XY1rA+bd1rxrlKnV/0ARubGjVmHxk0s2EoXcWJR56
 LHs5J+KCTjuy0C0xD1Za5qB4nwOUSaH/heKIu1c0ZV94eK8p4e7YRI2s/AX0AXx0Tqkq
 A6jsgqNwYFhXhoimZF89c0BfkBSbQsHmpVhI4FpAgOC9ssupz/nqxvJoeqI827CXCEbN
 ceRKlpCpWCbWB6y50tIY6uimgXGzQk4Ssw/Nuk/EQShJ0yOFJx+MAAaj37Xd1PZNWynE
 218GYGuHM1LHcdwxAzsVkJKQiqDPfltSwNv2K9sOpEu/mYCrdWfBM8QoqKvN/3hTvmYx
 LlFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpAwFf+kOk2Wkc7hrkITLSyFwqD27aN6lkn06hRcKLeaBOynrn1QGlQCD2n/Z5o9PHSEbw+W7qTLce@nongnu.org
X-Gm-Message-State: AOJu0Ywik6bGJJsf59+0m+aVMFSqUyPTwhOLB9jSa79CvitPZJubu2uu
 q86dTvoX4irvqfMOHqeOHwluisPrhnJvlbASDGsn6ZivmbxIvIUTc57bcbOnvmZp0G9bF1MM6lQ
 Aoh7p
X-Gm-Gg: ASbGncumvTG4ZlroArtV8PkzM6JX5C+QZxXjKiUFX3bjyNHi9/RTTmOvH85H4q6Bvn5
 HZSHDmfCRBcmyeVP4Uj5d0Nb9DeHUvheSl2S5KzhWdkpUgHMq1PbqMQTxx9o21LBD0UK1Nqe8EA
 +VyHLrz8k0P+kRZB2gR7CwWLz5nt1VZA3+n+zhxAFF93BkrQI/iGBSHhACEMuapjAsxM7+gUL3U
 7VSEafctQZxMRk70dT83/yTPvsY+Huvm9sN6aNYrgGbI1fEHWnRLoZUfMKYvWs2oDShLpa31HM8
 1tzX1AVMX2dx8m2Jref5DyHvWP4WCnX5gjD2rrfSioRRNYNEBClHZa3TfCi19x8=
X-Google-Smtp-Source: AGHT+IFCiCnXkD/+u+VbK/twYmO1gTXsoe0kOBCF5EU+t/vqURAxy8cbeE2ysCqAFwQanBS1LCW0rg==
X-Received: by 2002:a05:6a00:2287:b0:73f:f623:55f8 with SMTP id
 d2e1a72fcca58-745fde779e7mr10655890b3a.5.1748237370458; 
 Sun, 25 May 2025 22:29:30 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-742a9709293sm16225456b3a.37.2025.05.25.22.29.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 22:29:30 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 26 May 2025 14:29:13 +0900
Subject: [PATCH v4 03/11] qemu-thread: Remove qatomic_read() in
 qemu_event_set()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-event-v4-3-5b784cc8e1de@daynix.com>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
In-Reply-To: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 devel@daynix.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The pair of smp_mb() and qatomic_read() sometimes allows skipping the
following qatomic_xchg() call, but it is unclear if it improves
performance so remove it.

Commit 374293ca6fb0 ("qemu-thread: use acquire/release to clarify
semantics of QemuEvent") replaced atomic_mb_read() in qemu_event_set()
with a pair of smp_mb() and atomic_read(). atomic_mb_read() was actually
cheaper than atomic_xchg(). include/qemu/atomic.h at that time had the
following comment:
/* atomic_mb_read/set semantics map Java volatile variables. They are
 * less expensive on some platforms (notably POWER & ARMv7) than fully
 * sequentially consistent operations.
 *
 * As long as they are used as paired operations they are safe to
 * use. See docs/atomic.txt for more discussion.
 */

However, smp_mb() enforces full sequential consistency, so we cannot
use the same reasoning to claim that the pair of it and qatomic_read()
is cheaper than qatomic_xchg(). Therefore remove the pair and simplify
the code instead.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 util/qemu-thread-posix.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 4d6f24d705c7..a1b592d358c3 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -386,18 +386,9 @@ void qemu_event_set(QemuEvent *ev)
 {
     assert(ev->initialized);
 
-    /*
-     * Pairs with both qemu_event_reset() and qemu_event_wait().
-     *
-     * qemu_event_set has release semantics, but because it *loads*
-     * ev->value we need a full memory barrier here.
-     */
-    smp_mb();
-    if (qatomic_read(&ev->value) != EV_SET) {
-        if (qatomic_xchg(&ev->value, EV_SET) == EV_BUSY) {
-            /* There were waiters, wake them up.  */
-            qemu_futex_wake_all(ev);
-        }
+    if (qatomic_xchg(&ev->value, EV_SET) == EV_BUSY) {
+        /* There were waiters, wake them up.  */
+        qemu_futex_wake_all(ev);
     }
 }
 
@@ -413,7 +404,7 @@ void qemu_event_reset(QemuEvent *ev)
 
     /*
      * Order reset before checking the condition in the caller.
-     * Pairs with the first memory barrier in qemu_event_set().
+     * Pairs with the store-release in qemu_event_set().
      */
     smp_mb__after_rmw();
 }
@@ -428,7 +419,7 @@ void qemu_event_wait(QemuEvent *ev)
         /*
          * qemu_event_wait must synchronize with qemu_event_set even if it does
          * not go down the slow path, so this load-acquire is needed that
-         * synchronizes with the first memory barrier in qemu_event_set().
+         * synchronizes with the store-release in qemu_event_set().
          */
         value = qatomic_load_acquire(&ev->value);
         if (value == EV_SET) {

-- 
2.49.0


