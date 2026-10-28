Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D80606A322
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EP/84Nmj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Nz-000523-Sf; Wed, 28 Oct 2026 13:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM7NX-0004lZ-Da
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:24:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM7NV-0004zL-JI
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793208233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPGvaIEGY9937KE7Q0ZokV9FarrUDshyAGcLN2e4QFk=;
 b=EP/84NmjU+vb66w0kKDG6XMWAjsIqj3sRz3EUXbqZuvcdEjEKUDK/2HkQRgu2lrfGZKEl0
 TlE3qBFZSWw3on6T156A9IEK91DocgMquidClICPMpqFVFMHwbTQJBQwfWsZmIsV+UCErk
 vrqk4wLOWxW+TQl2SGh4TmlXh3kBBr8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-a4Bp7nscMeqMMNvLSp6C8w-1; Wed,
 28 Oct 2026 13:23:50 -0400
X-MC-Unique: a4Bp7nscMeqMMNvLSp6C8w-1
X-Mimecast-MFC-AGG-ID: a4Bp7nscMeqMMNvLSp6C8w_1793208228
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 613FF18005BA; Wed, 28 Oct 2026 17:23:48 +0000 (UTC)
Received: from Kostiantyns-MacBook-Pro.redhat.com (unknown [10.44.32.20])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31465195608D; Wed, 28 Oct 2026 17:23:46 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/2] qga: do not run hwclock(8) on non-Linux POSIX OSes
Date: Wed, 28 Oct 2026 19:23:41 +0200
Message-ID: <20261028172342.96036-2-kkostiuk@redhat.com>
In-Reply-To: <20261028172342.96036-1-kkostiuk@redhat.com>
References: <20261028172342.96036-1-kkostiuk@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Roman Bogorodskiy <bogorodskiy@gmail.com>

Currently, qmp_guest_set_time() sets system time using
the settimeofday(2) system call and then runs the hwclock(8)
util to set hardware time.

hwclock(8) is Linux only, so current implementation
always fails while trying to run it on non-Linux POSIX OSes,
such as BSDs (FreeBSD, OpenBSD, NetBSD) and illumos.

Update the code not to run it on non-Linux. The settimeofday(2)
call sets both system and hardware time on these systems.
For example, on FreeBSD settimeofday() calls settime()
which calls resettodr() [1] which updates RTC clock [2].
It is similar on OpenBSD and NetBSD, though implementations
differ a bit.

Additional detail: on FreeBSD RTC clock setting can be
disabled with the `machdep.disable_rtc_set` sysctl.
As we cannot do anything about it, do not handle that
case separately.

Non-Linux POSIX OSes do not provide a common utility
equivalent to hwclock -s, so report an unsupported operation
when no time is supplied.

1: https://cgit.freebsd.org/src/tree/sys/kern/kern_time.c
2: https://cgit.freebsd.org/src/tree/sys/kern/subr_rtc.c

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261015142342.50436-1-bogorodskiy@gmail.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-posix.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index dcc683f6c9..cfa5627a61 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -322,6 +322,20 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
         }
     }
 
+#if !defined(CONFIG_LINUX)
+    /*
+     * BSDs (FreeBSD, OpenBSD, NetBSD) and illumos do not have the
+     * hwclock(8) tool. These systems update hardware clock when
+     * settimeofday() sets system time, so no additional actions
+     * are needed. Setting system time from RTC is not supported.
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
2.54.0 (Apple Git-157)


