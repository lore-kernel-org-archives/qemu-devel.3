Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EFACD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuAd-0007qa-7z; Tue, 12 May 2026 16:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuAH-0007ZC-0n; Tue, 12 May 2026 16:57:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuAE-0003Uq-LB; Tue, 12 May 2026 16:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619275; bh=MgrtVQ+DnS21RLJtCeuK+0fjNw0mPHM7Tdlmx0gQ5Us=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HIkujitWIh59tn/PAiYU2CKpLz9738QlIt/E+y8mTjjp6D7Bh6BBRNG2uKc1pNMpV
 0KreA1LSEIiAle7zEC6DpdLc6MqNBh1zkMF4w4KS6F519OsGKeT4sfQG+xcU/HnySi
 HUciYaIVsmyW4fk23vCOb4i5arygY5cgGnV+MwtWu+7l8r8NxuGsx/YmtdRlxlTpR7
 A6agGXFG5rdqyhu9pPJGwgjBQgPuB2DpLhJXVOQBnJsogZakhcz4H42HC6ikDlC1za
 En+evoxS/cv17uVUhn5z+2pKuXj0RhxIakBXyUGgVCBTMuWRYmZyWO/Ox2Q/okQJO7
 bTimjOOumszGA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 106961AA2E7;
 Tue, 12 May 2026 23:54:35 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1C7EE3ABC58;
 Tue, 12 May 2026 23:54:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jenny Guanni Qu <qguanni@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 027/107] hw/audio/sb16: validate VMState fields in
 post_load
Date: Tue, 12 May 2026 23:53:14 +0300
Message-ID: <20260512205437.360850-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Jenny Guanni Qu <qguanni@gmail.com>

The SB16 VMState loads in_index and out_data_len as raw INT32
values with no bounds validation. A crafted migration stream or
VM snapshot can set these to values exceeding their respective
buffer sizes (in2_data[10] and out_data[50]), causing heap OOB
write in dsp_write() and heap OOB read in dsp_read().

Add bounds checks in sb16_post_load() to reject invalid values
before they can be used as array indices.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3326
Reported-by: Jenny Guanni Qu <qguanni@gmail.com>
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
Link: https://lore.kernel.org/r/20260318192918.65481-1-qguanni@gmail.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit cb1e8c18df625dc9aed7f5fd5c8b961e8e4d1023)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 0c661b4947..85b869a50a 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1287,6 +1287,13 @@ static int sb16_post_load (void *opaque, int version_id)
 {
     SB16State *s = opaque;
 
+
+    if (s->in_index < 0 || s->in_index > (int)sizeof(s->in2_data)) {
+        return -1;
+    }
+    if (s->out_data_len < 0 || s->out_data_len > (int)sizeof(s->out_data)) {
+        return -1;
+    }
     if (s->voice) {
         AUD_close_out (&s->card, s->voice);
         s->voice = NULL;
-- 
2.47.3


