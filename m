Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8839C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtqSW-0005KJ-QP; Tue, 11 Aug 2026 13:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtqRe-0004b2-Gg
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:39:24 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtqRd-0000Ua-1a
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:39:22 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so173109a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786469959; x=1787074759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R9y7K0aZagJqn9tiJ5p7mtx/+U3iEqfq8CYJsxjyfoc=;
 b=KEiXASI5EmmGSu5+EoHj/ER/JYCFqBUQdveIwCO6MBZd2CRTtTpFfRz/Asn+IRJ/zB
 +r69jwrercOB3TLw1K4eLOAonrsii5yVGH1MDjO8zOwtav7yPnt1UGMgZBcqpjUqBxg9
 vbeZkh4wh5ZIo8UHSaBeWBf3AHSNsZ+Mgynh2V1M1rSOpeaymk62NIriHnOhH50rsdAB
 liRoJTOaShUTg9NZMMEV+5TePOwvdKfGsuxcZkwI+atxdMEO/F3wg/f3w0S39MitL7L3
 jtd5KGkG/xt16CotQ4A16V7rSRdsldNo4rITR1+T9oEtg3miCR/mm6IZMqo5mJuuDqYN
 c/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786469959; x=1787074759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R9y7K0aZagJqn9tiJ5p7mtx/+U3iEqfq8CYJsxjyfoc=;
 b=oPJJ5ZUavYkk28eFSm/N4qHdbwyiQwnbjemGHQCanBRE/lHWI6aKeCXPK9oLucLMlQ
 gun85n0WERRiSUzFR4+6HuCT1dLtq/dvpErywDXH+dU6ms6TtBegrwB8uE+X7qPWueD8
 JBYCpW7qWnnhEL8FadssA/rho8yXAjt+V82eTQePf80bdJ1NRU7wMdvhOr3lCgjh9cPB
 FYiys5+yjnnNlsCsXmhLFARdesZXDiZ/QSWErKRdJR3OjnItGaV5hkrFT9BokkOjs0n0
 vrO2dxYFijdKugXw6SEGbZMpxbTqxHDuyYOEbYpsMO1y1R6aPaAQmBg7Y1We2pO/GqNa
 WJGg==
X-Gm-Message-State: AOJu0Yyq/DE/LaHedEgGmGbLX1NzdKBdpw99qa3oDRqHv4i9NEI+lvir
 Ay+BnOIkAw9MI6vzjVSLoJ/TQgExb8CbLJ8zg83smYqyhvXboyBcMNEILOiUIpz/5jCsg14DbzT
 02mhg
X-Gm-Gg: AR+sD12eQLGltgJlUo7o9XK6+zivBoYj5zVu6BVNOTnXEdP4280Xg55O6oWLpw2MIRN
 WKiHDoIEvNGN0/dR3yb4Zlljws2kDMZNWrvi/AwGSpRizHBItT1lxeXUjBH1P/MeI1rO+xC8kJ3
 QaOrNGoLaEcsG0QYvNHlUEtgzKVA3yU49YOJhIiLCE/ym1WOgp5VfGZPZ6x9Bq1tJQ5sw62sQzP
 geZs1a24bplBDPCNv8wFCAA4y+4T4ktUiWRKYXGXlJn31SUiFcXsVR9gWFef/GH5EREgLxTWhlp
 kr7cAfqfOu9TBOlf2qJ0jzNLNTLZqlRVVrEofqGRLi8MrZ7iGf00Ogak1w5Hcud7JPUZpLkwOcJ
 VkoeagG6/MXp34Av59+cW320KUyiDBqL6dDDdHMLQowHhD9ycO9NrNHQRB1/CCZtnmn9kFZLoxx
 58MhQMB2it3oCwW4bpoEhebMdW3eqddvvdgxaZPL/Go+dxUsYcxnYioIH9tTZdQA==
X-Received: by 2002:a05:6402:4609:b0:6a2:77f:b857 with SMTP id
 4fb4d7f45d1cf-6a364542276mr2758297a12.21.1786469958880; 
 Tue, 11 Aug 2026 10:39:18 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c43:d230:7bbc:68d4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a362ef7525sm880945a12.29.2026.08.11.10.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 10:39:17 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 6/8] parallels: allocate the Format Extension cluster
 gracefully
Date: Tue, 11 Aug 2026 19:38:55 +0200
Message-ID: <20260811173857.396571-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811173857.396571-1-den@openvz.org>
References: <20260811173857.396571-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=den@openvz.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

s->cluster_size comes from the image and qemu_blockalign() aborts when
the allocation cannot be satisfied, so use the try variant and report
the failure instead.

The two are not interchangeable: qemu_try_blockalign() asserts that the
alignment is non zero, while qemu_blockalign() reaches
qemu_try_memalign(), which quietly raises a zero alignment to
sizeof(void *). bs->bl is only filled in once .bdrv_open() returns, so
the alignment has to come from bs->file, which is the node the cluster
is read through anyway and what parallels_open() uses for the header.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 63fe4d5b1e..89fab36039 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -323,10 +323,16 @@ int parallels_read_format_extension(BlockDriverState *bs,
 {
     BDRVParallelsState *s = bs->opaque;
     int ret;
-    uint8_t *ext_cluster = qemu_blockalign(bs, s->cluster_size);
+    uint8_t *ext_cluster;
 
     assert(ext_off > 0);
 
+    ext_cluster = qemu_try_blockalign(bs->file->bs, s->cluster_size);
+    if (!ext_cluster) {
+        error_setg(errp, "Failed to allocate the Format Extension cluster");
+        return -ENOMEM;
+    }
+
     ret = bdrv_pread(bs->file, ext_off, s->cluster_size, ext_cluster, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to read Format Extension cluster");
-- 
2.53.0


