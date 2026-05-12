Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957B0CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuBS-0002BR-Qa; Tue, 12 May 2026 16:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuBI-0001sO-FD; Tue, 12 May 2026 16:58:23 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuBF-0004hQ-IG; Tue, 12 May 2026 16:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619275; bh=daRR+ZdyOfAs2F8KSecB4P2oiYBqmmSKFfl/fLUoENg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bPtTowLFRYzAwW0lJ1KaEe7t6uIm2ilvKzcQfULTo2RJ68krw41GCKdbvIe114WvH
 vR+cVq1Kel7DhoPyQdu1ioqr+FLNCxUbXnjiL8JuxRphouY/kxFGQIS2z1e1vx0DNr
 VPZDG0E8BtFwEio9t14DG7H4stI7P7jzb8/wtUw41ArYUuHzTnLtlDsTI34q8B2H9Y
 r/R1QwKQVH2omQJFx6n0nLXcgOEQ7B8+4nfTFrUOuGugoO5VXb44TX9kWcDPClsIyz
 Uzif9XzFS03R3y1gMV+1NNg4ox5WOYYkpCKXrbaRgm57yy7rPQTlZInRWADWkvbJzx
 fIvvgVBjR12Hw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CAFE01AA2F3;
 Tue, 12 May 2026 23:54:35 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D79103ABC64;
 Tue, 12 May 2026 23:54:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 039/107] hw/net/rocker: Avoid double-free of
 l2_flood.group_ids
Date: Tue, 12 May 2026 23:53:26 +0300
Message-ID: <20260512205437.360850-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

In of_dpa_cmd_add_l2_flood(), we allocate memory for the
group->l2_flood.group_ids array, freeing any previous array.
However, in the error-exit path we free the group_ids memory but do
not clear the pointer to NULL.  This means that if the guest causes
us to take the error-exit path and then later call the function
again, we will try again to free the memory we already freed.

Fix this by clearing the group_ids pointer in the error exit
path, so we maintain the invariant of "either it points at
allocated memory, or it is NULL" (both being valid to g_free()).

Cc: qemu-stable@nongnu.org
Fixes: dc488f88806 ("rocker: add new rocker switch device")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3253
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260324193530.375628-1-peter.maydell@linaro.org
(cherry picked from commit a0721c099b71f7bdfafa2675daee331d884163d2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 3378f63110..b4da3cc0ec 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -2063,6 +2063,7 @@ static int of_dpa_cmd_add_l2_flood(OfDpa *of_dpa, OfDpaGroup *group,
 err_out:
     group->l2_flood.group_count = 0;
     g_free(group->l2_flood.group_ids);
+    group->l2_flood.group_ids = NULL;
     g_free(tlvs);
 
     return err;
-- 
2.47.3


