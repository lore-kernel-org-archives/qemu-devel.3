Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599DCCEFC32
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 16:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syDMi-0003C3-NL; Tue, 08 Oct 2024 12:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syDMh-0003B2-HQ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 12:47:15 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syDMf-000390-Js
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 12:47:15 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37d1eda8c7cso1638444f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728406032; x=1729010832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EY6w9wvwlC/cLOufBH+NAUI4yIvgWqgEs7u9iu6gMAw=;
 b=YNQGE7Zbz67MiS/QVL2ytaCx7GyldhJe9dMQ4s+pcCAokwb4hgUGFzHC4c58bnDn0J
 JZ+vGUfjKr4quuIP7F7QGs0JBliSRSZRhNS4g2KVb2nLLVgt3A2mo+Va1hkgvZREABXU
 TqChSGruzc1mZcGwektoSC7tETQqX8uUVce7Mi33RIhbNnWadEqZVjj1BJoEAAeUWuIS
 VNwjQaWmvBPbimVXtPUDFtgp8sfNGE+RY8JtIkzCwB7AgWncV6dbn/YDuteZSPBBA7i6
 h0gh/PvrUShHuwSBM6blqeQrstS8iH0mXk/grisn0z0QmuFyiJQ5htC5RAW91G4Qelxb
 DSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728406032; x=1729010832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EY6w9wvwlC/cLOufBH+NAUI4yIvgWqgEs7u9iu6gMAw=;
 b=WKiIFgJsAIRA2q2oktAMYkQTSqAOEQKhc5q7GCWMv3oHD+u1b03ujGzvjZAfzMCjrv
 oDZJwQ44tkev9Sd1sd/ICDeFoqAml9Vcvf9c61pzaZs3JpYp/FLEOnHMooM0FFoIv4go
 MAPg2Ki3RAxOM8pQXKZp1kGWCDCjgAkEpf77b0UcdUJQF0W9llOkdYBrt7tzx9xmUAH0
 s1QMW4bnb+Zwu+MtGZJklIlPNHYgDFeYUb5vvXHwP11Zc0woj2AlJkj1rV5lV2hiT+k1
 9nILD7Nxht5buOGym24WyNW15jf33sQ5azmzoV5jHHnWQCruZxKshIxKC7Tff6616Mys
 5LuA==
X-Gm-Message-State: AOJu0YzyF4EBorzAEBPDkz0xnKwmFvxV5SfKxaU+K9aogA9DhCO1Kd/G
 LxcHSJbBdSZY0DAkXDp5Miji7veC2GnmauovZof/JQ4eH0cBgi4xDg2ORC0NZU6QhQcTc/LiEBK
 O
X-Google-Smtp-Source: AGHT+IE/7mGJ0SI9ElRd7nFLqPgrK5XhK1FU/N12bNUDzZnqQ3K/a4bAqEBKzOUN1BqDwtvEVhGjdQ==
X-Received: by 2002:a5d:5c87:0:b0:37d:2e78:8875 with SMTP id
 ffacd0b85a97d-37d2e78a2a4mr1470394f8f.56.1728406032104; 
 Tue, 08 Oct 2024 09:47:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d32ea1d98sm1490936f8f.68.2024.10.08.09.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 09:47:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH v2 4/4] block/vdi.c: Make SECTOR_SIZE constant 64-bits
Date: Tue,  8 Oct 2024 17:47:08 +0100
Message-Id: <20241008164708.2966400-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008164708.2966400-1-peter.maydell@linaro.org>
References: <20241008164708.2966400-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Make the VDI SECTOR_SIZE define be a 64-bit constant; this matches
how we define BDRV_SECTOR_SIZE.  The benefit is that it means that we
don't need to carefully cast to 64-bits when doing operations like
"n_sectors * SECTOR_SIZE" to avoid doing a 32x32->32 multiply, which
might overflow, and which Coverity and other static analysers tend to
warn about.

The specific potential overflow Coverity is highlighting is the one
at the end of vdi_co_pwritev() where we write out n_sectors sectors
to the block map.  This is very unlikely to actually overflow, since
the block map has 4 bytes per block and the maximum number of blocks
in the image must fit into a 32-bit integer.  So this commit is not
fixing a real-world bug.

An inspection of all the places currently using SECTOR_SIZE in the
file shows none which care about the change in its type, except for
one call to error_setg() which needs the format string adjusting.

Resolves: Coverity CID 1508076
Suggested-by: Kevin Wolf <kwolf@redhat.com>
---
v1->v2: v1 just added the (uint64_t) cast for the specific
issue that Coverity was warning about; v2 is entirely different
and takes the approach Kevin suggested in review on v1.
---
 block/vdi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 149e15c8314..26f7638f1fc 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -87,7 +87,7 @@
 /* Command line option for static images. */
 #define BLOCK_OPT_STATIC "static"
 
-#define SECTOR_SIZE 512
+#define SECTOR_SIZE 512ULL
 #define DEFAULT_CLUSTER_SIZE 1048576
 /* Note: can't use 1 * MiB, because it's passed to stringify() */
 
@@ -442,7 +442,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     } else if (header.sector_size != SECTOR_SIZE) {
         error_setg(errp, "unsupported VDI image (sector size %" PRIu32
-                   " is not %u)", header.sector_size, SECTOR_SIZE);
+                   " is not %llu)", header.sector_size, SECTOR_SIZE);
         ret = -ENOTSUP;
         goto fail;
     } else if (header.block_size != DEFAULT_CLUSTER_SIZE) {
-- 
2.34.1


