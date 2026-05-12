Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BC3CD4F39
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuM8-0006yJ-Ch; Tue, 12 May 2026 17:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuLk-0004Dw-0r; Tue, 12 May 2026 17:09:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuLh-00038t-UL; Tue, 12 May 2026 17:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619301; bh=TYqtFzFabJENrHsmAPzLhe5tF+1dCXgY2mipskF3GIA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fdNF451R9L+mzs33xEFmeghcjI/miymIFl4KnAhmaV1Vq3nm4xt1HJRkENtHV5VMI
 KDkGq09fGKpyUL19EmYz4NMF65lYxH/juYfz7yXfF72YIqlo4/chg2FpfyBdcLFbfd
 Xd58aEJzZx+hj3uS2F+ozwpz//RHcRQSVveGF++d/jkTNQo2kiahTDh1kkBPrOXFNG
 yM5ij815M0ngEj+mcpBmXdygGBp9y/n6Sn3/FdgSjUUj2hD51k83VEznmsdzs2OD/L
 TczDsX+yJWOnTekglRNBYUvq3eiFpkDe8MZN2qJygpCJVwIkpFl6wnGMqWx7Ra5s0W
 iZVs0U21L2zlw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C53C01AA35C;
 Tue, 12 May 2026 23:55:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D19303ABCCC;
 Tue, 12 May 2026 23:55:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jenny Guanni Qu <qguanni@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 031/117] hw/audio/sb16: validate VMState fields in
 post_load
Date: Tue, 12 May 2026 23:53:33 +0300
Message-ID: <20260512205503.361097-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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
index 1e3c4caf5e..d248407876 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -1286,6 +1286,13 @@ static int sb16_post_load (void *opaque, int version_id)
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
         AUD_close_out(s->audio_be, s->voice);
         s->voice = NULL;
-- 
2.47.3


