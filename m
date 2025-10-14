Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B56CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gMM-0001yz-5e; Tue, 14 Oct 2025 10:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8gML-0001yp-HB
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:50:41 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8gMJ-0002m6-7O
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:50:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 5101B808B6;
 Tue, 14 Oct 2025 17:50:35 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8a::1:35])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id XoQnFO3Fpa60-5LQqAeDt; Tue, 14 Oct 2025 17:50:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760453434;
 bh=IbmNQFvxIVZDFrun6qXUc+sIe+TxdINRiVwPIrkN7NQ=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=0VR8S+UUiGlwsV/gOE1YZqS6FqYiVO9mWNDOzQCqFFBoDO2umzbsKTh8iuMqNhdDG
 ycAmCi9ZA58aPqWknk/Q+2AU4fKjYnFU5GfDAp9X8uNYpg5TB9f7WDuTOSHTcg1MgU
 116d1dsTwOGeXQ6oSIh39bSswY4d9XOJkzenEBtE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH] chardev/char-file: fix failure path
Date: Tue, 14 Oct 2025 17:50:28 +0300
Message-ID: <20251014145029.949285-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

'in' will be -1 when file->in is unset. Let's not try to close
invalid fd.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Coverity: CID 1630444
Fixes: 69620c091d62f "chardev: qemu_chr_open_fd(): add errp"
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

I was going to send it inside v3 of "chardev: postpone connect", but it
seems the discussion may continue there, so, decided to send this small
fix in separate.

 chardev/char-file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/chardev/char-file.c b/chardev/char-file.c
index 89e9cb849c..1f7adf592f 100644
--- a/chardev/char-file.c
+++ b/chardev/char-file.c
@@ -94,7 +94,9 @@ static void qmp_chardev_open_file(Chardev *chr,
 
     if (!qemu_chr_open_fd(chr, in, out, errp)) {
         qemu_close(out);
-        qemu_close(in);
+        if (in >= 0) {
+            qemu_close(in);
+        }
         return;
     }
 #endif
-- 
2.48.1


