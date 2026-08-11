Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48B2C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtqSE-0005BM-DZ; Tue, 11 Aug 2026 13:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtqRj-0004bd-Ix
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:39:29 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtqRe-0000V4-Tj
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:39:24 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a205b0df35so133861a12.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786469961; x=1787074761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XY//40pvifosH/oC9bhsWlgVBDe/TLGnkSQ+LuR5yDM=;
 b=VJsTcY95xtQaxHWS++Qx7rDzfwmWA0s6tESO0d2VcmvIix2655ZtqNzqDAGAEVmjWQ
 xncMiFEZzC/GMgU8KLHEq6+tSyzLMUYjskUItt5hhdwowsZ7q5/TvXrAVkt/5j2nqrFt
 x64dVsFlrdGLAR10U8dQ7LZmwqfRLz1a2nWhNKyKZQcZpaIiiyIDap0xAwrIxqoe2EdN
 N64ZfM6NU4yu9tqMLoF/pD/5Fuce1kGWbUaLoNTCKg7kRkx7pPw5pzVfZ9tGRsNpnXr2
 y98BKeh+UGxrTv1pe+veagCsW4a91qcTy74IGb7OPppqpyeLE3BkOr8lUmXutyqCDxwG
 rmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786469961; x=1787074761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XY//40pvifosH/oC9bhsWlgVBDe/TLGnkSQ+LuR5yDM=;
 b=pr0UeFsOUvpL4NSKJ7lR+pYkiCPWbe0j3qRZRucF+/DdHSRiZ1A72FSBRKhWRK/VuU
 /chdJAa8ErgH5JxBOP9jflv3lTHAoXlVcoFwBcXPXxTE94ssSswYVYp/J9mjVgeEfhzs
 iXw5T5olpdiiM8JV5RUx0u3VizQ2MdSS7IwU8CqadXsARo4vQu62Q6iFwMC0SaUbtXij
 0/hedo9o3sAGOVm4in4FYu0xnadHmjfuHo8mdCj/RhhA2TqsADLzQTeMRTgs6GePa327
 /nDgnOBZBEzGMydcCldskhwHB7vPumyZWSaGmqQLggV4wBnu/hOLWbobzRkMHX/vw71+
 LAJQ==
X-Gm-Message-State: AOJu0YwIgiskGFBkdoyqQDGEudrQCffH1ba28DqXmRUY2kG6yrEqfZhW
 r7cxUpl/LQRKOdtKYkkL7WqRIAqQ0kGdRPLa6uilEu6NhFJwxSlPRv4qk85y2zYrsAWIo+JbBaT
 8dDhN
X-Gm-Gg: AR+sD13dCsl4CC7R8W6g2h5v9YYCTbJ8yBFKgVzkUAYp79sQIfJx5pYWjcmqHRM+37+
 UsB36j8oQhMTnGLLmJ/qFIeDiwL11iKbJE0jSKuP4FZ17+HWSYVCuesfAhiP3vWmL7K17V7bV/E
 QhVAca/JL8yVoMSKWKYkbgJmtTfYR9MpDIf2owc/G9otDLeV7H9ToI6653ReSG7Ru+rPJ9iIZnb
 EOjfMWTyO92ZwdKyiOPeNDLpB3Mz8SwyqWqrZpZ8NNJMgZZtDjoECI2ifrtGOz7Tb02oU1WVQ/k
 LUEIUowKLARHN4bMQnE9Ot7jV85MmqY5MeJllbxBTDoGC5DkMDc4WvmhmSvagTpJOZmHqRw+BbL
 HQdNRDwTIMsMdV3J2gyhi+RgVtN1WsBFmZBxLHzGA3pqQ3mp22I+MihcRQUILg5LBleX6QYNtMm
 RQvcTUFsekkNwLrKtwxUnpbtGsRlvdVR+SGPEVkzsUZ2vU0L0krFZaCMZf
X-Received: by 2002:a05:6402:5d2:b0:6a1:fd14:8835 with SMTP id
 4fb4d7f45d1cf-6a36ba70ea4mr1378808a12.0.1786469961517; 
 Tue, 11 Aug 2026 10:39:21 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c43:d230:7bbc:68d4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a362ef7525sm880945a12.29.2026.08.11.10.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 10:39:20 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 7/8] parallels: fix GSList leak on the format extension
 success path
Date: Tue, 11 Aug 2026 19:38:56 +0200
Message-ID: <20260811173857.396571-8-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811173857.396571-1-den@openvz.org>
References: <20260811173857.396571-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=den@openvz.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

parallels_parse_format_extension() returns directly on the end of
features marker, leaking the list which tracks the loaded bitmaps. The
bitmaps themselves belong to the block driver state, only the list
nodes are lost.

Fixes: baefd977002e ("parallels: support bitmap extension for read-only mode")
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 89fab36039..21f54e4e3e 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -290,6 +290,7 @@ parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
 
         switch (fh.magic) {
         case PARALLELS_END_OF_FEATURES_MAGIC:
+            g_slist_free(bitmaps);
             return 0;
 
         case PARALLELS_DIRTY_BITMAP_FEATURE_MAGIC:
-- 
2.53.0


