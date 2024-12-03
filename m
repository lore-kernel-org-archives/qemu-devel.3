Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274D7E64A9E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIT8Z-0006KF-6W; Tue, 03 Dec 2024 08:40:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tIT8W-0006Jc-J2
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:40:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tIT8V-0001zg-4T
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733233218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jHr9cJGY/ijRGteW+inaktRfgMyPYsPeEycO3v4GR60=;
 b=G08oyW9GylcUqg1Q7bRZlH2x3fchvrb6vHgxIr7JKtgdZzC6hNMwml61Va4DpC88y0WiVp
 rd0YN+TE1J4SW/inMien/yKb4dl35WATqxe7UD52+hE9ec2p3WeZJ00d4IwZKB60CaLyAH
 8rka1BEMt596laXiGxIfxS8p1QYT4+s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-vZixn3tUPBSjUMysRInwSA-1; Tue,
 03 Dec 2024 08:40:13 -0500
X-MC-Unique: vZixn3tUPBSjUMysRInwSA-1
X-Mimecast-MFC-AGG-ID: vZixn3tUPBSjUMysRInwSA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D491A1955D4A; Tue,  3 Dec 2024 13:40:12 +0000 (UTC)
Received: from localhost (unknown [10.39.208.11])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B4ED30000DF; Tue,  3 Dec 2024 13:40:11 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 1/2] chardev: Fix record/replay error path NULL deref in device
 creation
Date: Tue,  3 Dec 2024 17:40:00 +0400
Message-ID: <20241203134001.750958-2-marcandre.lureau@redhat.com>
In-Reply-To: <20241203134001.750958-1-marcandre.lureau@redhat.com>
References: <20241203134001.750958-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

qemu_chardev_set_replay() was being called in chardev creation to
set up replay parameters even if the chardev is NULL.

A segfault can be reproduced by specifying '-serial chardev:bad' with
an rr=record mode.

Fix this with a NULL pointer check.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Resolves: Coverity CID 1559470
Fixes: 4c193bb129dae ("chardev: set record/replay on the base device of a muxed device")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240828043337.14587-2-npiggin@gmail.com>
---
 chardev/char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index a1722aa076..1c7f6c711a 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -726,7 +726,7 @@ static Chardev *__qemu_chr_new(const char *label, const char *filename,
 
     if (strstart(filename, "chardev:", &p)) {
         chr = qemu_chr_find(p);
-        if (replay) {
+        if (replay && chr) {
             qemu_chardev_set_replay(chr, &err);
             if (err) {
                 error_report_err(err);
-- 
2.47.0


