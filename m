Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07D7D462A5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 14:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBE0i-0000hm-2V; Wed, 13 Nov 2024 09:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tBE0e-0000hF-U4
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 09:06:16 -0500
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tBE0d-00069H-0I
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 09:06:16 -0500
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1731506770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=D1VGmC4kNCTMic69SsXbK60IEhgle0DOxLVcgyXMKac=;
 b=N4YivBUQNA/ailRzqc0s6Y6EvG3J/YYRhliiRYSOCbfmhU/ETNcveGrQrJ3dt3ZoJ4vKx3
 wR6M47HJBrep9szyojz06rdmjfXqhE4R3X5FA/ezNxfK38v+ioQf5HVpmNUCpxhgAkNdE2
 wdike9iJLTUz2L1Ce+t9iVKlUTnaY+U=
To: peterx@redhat.com,
	farosas@suse.de
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] migration: fix-possible-int-overflow
Date: Wed, 13 Nov 2024 17:05:01 +0300
Message-ID: <20241113140509.325732-2-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

stat64_add() takes uint64_t as 2nd argument, but both
"p->next_packet_size" and "p->packet_len" are uint32_t.
Thus, theyr sum may overflow uint32_t.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 migration/multifd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 4374e14a96..498e71fd10 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -623,7 +623,7 @@ static void *multifd_send_thread(void *opaque)
             }
 
             stat64_add(&mig_stats.multifd_bytes,
-                       p->next_packet_size + p->packet_len);
+                       (uint64_t)p->next_packet_size + p->packet_len);
 
             p->next_packet_size = 0;
             multifd_set_payload_type(p->data, MULTIFD_PAYLOAD_NONE);
-- 
2.43.0


