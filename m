Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC80C79FAB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WwE-0007r8-7Z; Mon, 07 Sep 2026 06:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3WwB-0007j2-Iq
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3WwA-000831-5g
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZrExPs7bOq8tj4VvBwHFcJsTajfD4s909vC9Z8FOml8=;
 b=ODWB15OZP6tL5CWiHlKAL8vHybv37MzGzfJW/+34bP3jeVXkjx0fHkiE7TaX7WwofRzEKb
 WRh35bzRviepeBMUcdfwYNJEGuhDdXyqPMZgWmloA908W3Ms1WPZ8K7RDOs9txED2wHdPH
 Pr0gAvY47GTb7RUUR748cYvevNW9COY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-55irehISPOafVjcoc2PZzg-1; Mon,
 07 Sep 2026 06:50:52 -0400
X-MC-Unique: 55irehISPOafVjcoc2PZzg-1
X-Mimecast-MFC-AGG-ID: 55irehISPOafVjcoc2PZzg_1788778251
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0343D19541BF; Mon,  7 Sep 2026 10:50:51 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E4F761955F0E; Mon,  7 Sep 2026 10:50:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:50:10 +0400
Subject: [PATCH 12/17] qga/vss-win32: evaluate err_set() macro argument
 only once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-qga-v1-12-86456ad356e2@redhat.com>
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-0-86456ad356e2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1633;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=F+avZ2Kt2HJKvLGVcPhZxW5Nm9d4tEv8XwcL+4zbh8Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpbjruAJ9DkcspTsSbjWX0XH8DdNJwdNVW0Tt
 digUWPigbGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6W4wAKCRDa6OEJdZac
 5cAbD/98Q1J0pzqC3Oj5iT60mL49jh/g+D3SOqJX3/nzAC1SSinPJZhpxdilsk3jaFyCGI7ANKn
 sKL/dCJCj59Y61N51ILStBooEDFUIpPDnJyIAsn0VM57pBnNZeWJfh6W4xClvKzgzvxe59B5Smu
 9jaKt/PErL1kT3sCjbkVXfB3Kx6DF+wSB1vINKLUzdvVs9tqbskBV5nr5YJHKpTuz2ZzzPUUbCM
 f6Zkfv2dT9DTX9U8oKB86ngJqzHAQgDBvu2Bzqn5n6B9H4i01yNA5UUPJNmhLRVsr9fEhXLObQT
 wK7RyshQKpYKw+b43xk9MB55A3/yYA+Qj13Ga0cuZR3NgkApcbG+qi/lZ589IDYShs8LMShgyhp
 Fs165OJv/oA/QOSSVVUCmYEeVNouClASMEWBuhrKTeogXoherVt17pL0JnUDc4eGDBGaHU7+6tH
 LCzjHAmwtZgBcGcEu4gMoysLZctsnDun+O1tKp5oU/qPyoNbu1yH2X0vyyKMxr3XByAXYeZSzQ3
 cAPNxools1VJ/b1QWya9kaio9WaN1rMeCZ3m0hmqIza1ZYtn6zTSJeEMby/QTGXgZkiiUqXTtFO
 vQr/AE0iF604MGbYwQ7aHAJz8Yl5ADCnvcD6UYIaffuHwGKmNDl0Dv4a1vVviV30rUH4CdTObed
 rZLQspHA+sTBuHg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The err_set macro expands its 'err' parameter three times. When
callers pass GetLastError(), the Win32 error code is fetched on
each expansion and may change between evaluations, since the
intervening function calls can reset the thread's last-error value.

Capture the argument in a local DWORD once and reference that
throughout the macro body.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/vss-win32/requester.cpp | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index d7907c230656..e3a15f83bf90 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -27,10 +27,11 @@
 #define DEFAULT_VSS_BACKUP_TYPE VSS_BT_FULL
 
 #define err_set(e, err, fmt, ...) {                                         \
+    DWORD _e = (DWORD)(err);                                                \
     (e)->error_setg_win32_wrapper((e)->errp, __FILE__, __LINE__, __func__,  \
-                                   err, fmt ": Windows error 0x%lx",        \
-                                   ## __VA_ARGS__, err);                    \
-    qga_debug(fmt ": Windows error 0x%lx", ## __VA_ARGS__, err);            \
+                                   _e, fmt ": Windows error 0x%lx",         \
+                                   ## __VA_ARGS__, _e);                     \
+    qga_debug(fmt ": Windows error 0x%lx", ## __VA_ARGS__, _e);             \
 }
 /* Bad idea, works only when (e)->errp != NULL: */
 #define err_is_set(e) ((e)->errp && *(e)->errp)

-- 
2.55.0.543.g5ebe2ebe4ea8


