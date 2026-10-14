Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45585CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGx31-0006Lv-RD; Wed, 14 Oct 2026 07:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xGx2t-0006Kv-11
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 07:21:20 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xGx2r-00058Q-5h
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 07:21:18 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c262f1186f0so528844666b.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791976873; x=1792581673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pSWZZiMq2djuRWjwwCBSAvAVnoMyrNtZiIk2DZkcM6w=;
 b=GMzDjbN02+wp80/cl0KelZYxk16kTMRjoG5lQgEnTRkmx+ymxRyxFYBPRvdGKGfUNf
 HDjP60NwCMBld6+g6nEuRAvj5TMlOdXQzwXbQ8C7PYeZRR/yIbiKsaFH299bsJHglZ16
 s6cD6ZfgTHuCu1ljRuBHTtmpm71BpZP5DNEh//6q7XhBqiJvGooXiIBDpSrmRDzrL52x
 p98b/nQmxujwNTf7/XnIuz7ii2x38dsmOtINcN9D9I4YXbS5lK5m4Dp9UJas93IJ6b/s
 Bo+fFJ4ODNcVWYQjK51FsJ4FC22D8TokQpetvoHg4MgeB95TvKUdTiu3UJqqRjMBFY1i
 ndWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791976873; x=1792581673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pSWZZiMq2djuRWjwwCBSAvAVnoMyrNtZiIk2DZkcM6w=;
 b=L/P0d6nPoFoHiI1JXqVznw1p61Dn3kJsGFYPmOIib1MrXUxRZTWnIS6WeVvy5Xcb1x
 QZdwLTIk5KI4YMkOXg7lpSwEB3T6wSrED8Ndk7y/dKSvGKUI0jzuYvgFVk93Hm+MkPkc
 YpJrP7C+YmYrITb0b4soU/VTlDdnklSz3APOu6F4NPWCYfUi5uVzfOHxtf5FQuKFT5v/
 lMGsHiCSmWUsVTv7eL6zMY+JweOjZJ/YXpsVlC18vKuXxEMRN+kLhDJtILpXFCMA0NNG
 mcb7ylPunPg7K8WPUG+ypckUTerEGHq0J01lbmhMF2tQVm59OQc/fBJBcRsagFrz+yM/
 hdCA==
X-Gm-Message-State: AFq9FYJBSK+6nKrfR06MYTRzz/6K2ks7sWzyW0xLzScS7gKXrifzpjKK
 tf6X+SyjyHrPIDpZc7JoQ5ElMjgsbkaCq/RQ8ZQrWkst0eyzm1TCatUWWu7ChxIf
X-Gm-Gg: AYBFou24AYB/rr2IpIz+D3uOYNOa6kTbWs1QT19ccphuWtd89u8tzL9mSQ73YZ9NhdX
 g44xotS6/VRWWm14LBURDe5Qrb2qzo3lBf89Qb4tuv2wStmXk0KlxboE18Z0jPqIEM5Oq720KYQ
 +Z5tOth/HyC4Vd5A8vD+19rRI0SV+qPqiwabuhobT497BedBjpWXKseCZEKBGLpzSg8eJArhRJ9
 VB7KSIVfrF5S55vw7XsQdOxVRttjRPxSXh81C00YsYRS1Eet98PQHecWKr7mVVB84zYoHA9MmsI
 h+2kPihVT4GPl8KS9ssT24u6ZDUH8BXDjrimJskKB3QACVl5xObk8erkkj7nyOI6i1DdqSo1jOF
 XVVFAPxmCu64MbKxM2TGqpnwGGauuNAy0o8mL/TPLLOw/kZvRcJGA9dFqFTWhe4TAEJptq52TLo
 p9ndf/jm/dMLDCCbbrANjt2qO37cFmYR8IYRTRzM/SjrhBsfeCxhTT12uHZS+vFKMTXDMqXoHU5
 Xz/pnIdrlg8vhV+k5c47RqOMh67MA+0oQ9ydk3UxdUgBe+VI2WhRWPCB/JLZ1MMZZkLmfIx3A5d
 JxwLHxCwV5aWk87h7K0=
X-Received: by 2002:a17:906:f58f:b0:c29:f5d5:5a97 with SMTP id
 a640c23a62f3a-c31aa04b413mr1610396666b.33.1791976873038; 
 Wed, 14 Oct 2026 04:21:13 -0700 (PDT)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a3ae6csm693797966b.17.2026.10.14.04.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:21:12 -0700 (PDT)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH] qga: do not attempt running hwclock(8) on BSD
Date: Wed, 14 Oct 2026 13:20:40 +0200
Message-ID: <20261014112040.70284-1-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x633.google.com
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

Currently, qmp_guest_set_time() sets system time using
the settimeofday(2) system call and then runs the hwclock(8)
util to set hardware time.

BSDs do not ship hwclock(8), so current implementation
always fails while trying to run it.

Update the code not to run it on BSD. The settimeofday(2)
call sets both system and hardware time on these systems.
For example, on FreeBSD settimeofday() calls settime()
which calls resettodr() [1] which updates RTC clock [2].
It is similar on OpenBSD and NetBSD, though implementations
differ a bit.

Additional detail: on FreeBSD RTC clock setting can be
disabled with the `machdep.disable_rtc_set` sysctl.
As we cannot do anything about it, do not handle that
case separately.

BSD systems do not provide a common utility equivalent
to hwclock -s, so report an unsupported operation when
no time is supplied.

1: https://cgit.freebsd.org/src/tree/sys/kern/kern_time.c
2: https://cgit.freebsd.org/src/tree/sys/kern/subr_rtc.c

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 qga/commands-posix.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 837e285b6d..f3d18e6dcd 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -322,6 +322,20 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
         }
     }
 
+#if defined(CONFIG_BSD)
+    /*
+     * BSDs (FreeBSD, OpenBSD, NetBSD) do not have the hwclock(8) tool.
+     * These systems update hardware clock when settimeofday() sets
+     * system time, so no additional actions are needed.
+     * Setting system time from RTC is not supported.
+     */
+    if (!has_time) {
+        error_setg(errp, "Setting system time from RTC is not supported");
+    }
+
+    return;
+#endif
+
     /* Now, if user has passed a time to set and the system time is set, we
      * just need to synchronize the hardware clock. However, if no time was
      * passed, user is requesting the opposite: set the system time from the
-- 
2.55.0


