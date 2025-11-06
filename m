Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28595CCFA19
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 19:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH5rU-0003kM-Nw; Thu, 06 Nov 2025 14:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vH5rT-0003k4-NX
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 14:41:35 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vH5rR-0005b0-6i
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 14:41:35 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 8B6CC80940;
 Thu, 06 Nov 2025 22:41:29 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:95c::1:2])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id RfspdL0FKeA0-DjWY94PE; Thu, 06 Nov 2025 22:41:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762458089;
 bh=aIRM3K7hrDbUqO+by7P6KHpZ+7hD8y8j3fymeYTlzFA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=1uAw1mO12CwllDuoCmhB+9yizzCgaXtys0uE5Y1AtFBVRhBiHkb+hhl6ZNZ6U7i05
 1rav9Qk9HsglDrBQf4qvzdJQydV9TjqfkWw/mQUW0iFLbg1e52IbaHYwnGxjMF4jE6
 3sz0J7kq4b1aEiUHUao3CwaN4pCLJYMgedLOSRso=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: stefanb@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 1/3] tpm_emulator: print error on error-ignore path
Date: Thu,  6 Nov 2025 22:41:24 +0300
Message-ID: <20251106194126.569037-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106194126.569037-1-vsementsov@yandex-team.ru>
References: <20251106194126.569037-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Commit 3469a56fa3dc985 introduced errp passthrough for many
errors in the file. But in this specific case in
tpm_emulator_get_buffer_size(), it simply used errp=NULL, so we lose
printed error. Let's bring it back

Note also, that 3469a56fa3dc985 was fixing another commit,
42e556fa3f7a "backends/tpm: Propagate vTPM error on migration failure"
and didn't mention it.

Fixes: 3469a56fa3dc985 "tmp_emulator: improve and fix use of errp"
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 backends/tpm/tpm_emulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index f10b9074fb..24aa18302e 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -560,8 +560,10 @@ static TPMVersion tpm_emulator_get_tpm_version(TPMBackend *tb)
 static size_t tpm_emulator_get_buffer_size(TPMBackend *tb)
 {
     size_t actual_size;
+    Error *local_err = NULL;
 
-    if (tpm_emulator_set_buffer_size(tb, 0, &actual_size, NULL) < 0) {
+    if (tpm_emulator_set_buffer_size(tb, 0, &actual_size, &local_err) < 0) {
+        error_report_err(local_err);
         return 4096;
     }
 
-- 
2.48.1


