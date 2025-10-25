Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1719CCCF9E9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 20:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCkqv-0004uL-AQ; Sat, 25 Oct 2025 16:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vCkqt-0004t9-Cu
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 16:27:03 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vCkqp-0004XG-Py
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 16:27:03 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 47E3B808B7;
 Sat, 25 Oct 2025 23:26:55 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:538::1:38])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id pQh1fa1bDqM0-1nBaao80; Sat, 25 Oct 2025 23:26:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761424014;
 bh=BNvSwyaRHN7VmEP0n/ZLbmkke10ix+maxXmnT9gEJCs=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=CffV2sN78XN/2W2cgw5m1zVPGGmCiSr3VBcHgDqBGosWTVgd0CJPki2PLYU7lCCES
 Fyo3CDJZEusDU9X6AETcnGOMvqbOoAI05uuGpmFrvIjnDs0Dl6Tm1lbzBdXPUHpYPa
 M+FHNTcFOR+Y/wTxlKHytBF9y0TOOwBHc0Od/B2U=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 armbru@redhat.com, berrange@redhat.com, vsementsov@yandex-team.ru
Subject: [PATCH v3 2/4] tmp_emulator: fix unset errp on error path
Date: Sat, 25 Oct 2025 23:26:47 +0300
Message-ID: <20251025202649.1122420-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251025202649.1122420-1-vsementsov@yandex-team.ru>
References: <20251025202649.1122420-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

Note, that called tpm_emulator_startup_tpm_resume() does error_report()
failure paths, which could be turned into error_setg() to passthough an
error. But, not on all error paths. Not saying about
tpm_emulator_startup_tpm_resume() return -1 on failure and we mix it
with -errno from tpm_emulator_set_state_blobs(). So, it all needs deeper
refactoring, which is out of scope of this small fix.

Fixes: 42e556fa3f7ac
    "backends/tpm: Propagate vTPM error on migration failure"
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 backends/tpm/tpm_emulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index dacfca5ab7..aa69eb606f 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -961,6 +961,7 @@ static int tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
     }
 
     if (tpm_emulator_startup_tpm_resume(tb, 0, true) < 0) {
+        error_setg(errp, "Failed to resume tpm");
         return -EIO;
     }
 
-- 
2.48.1


