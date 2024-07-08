Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E334FC38150
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 01:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQdEv-0003IX-Qm; Sun, 07 Jul 2024 21:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sQdEr-0003E5-Q0; Sun, 07 Jul 2024 21:32:22 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sQdEq-0001an-A2; Sun, 07 Jul 2024 21:32:21 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2c9baecc80fso1087562a91.1; 
 Sun, 07 Jul 2024 18:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720402337; x=1721007137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGWic2psjPhblcVbvDyhK2I28rJI4ynyRXnbyzTr1n0=;
 b=hKU6jMqUbITYXc+sz/RRdVROvyVYgrRItphO4a3D1F7GfhBSwvCWFYQP3WZDemtcEk
 8mitqtZlemsTKJcIktl8UBlkZHkQWxDenJZAPl1hw8S5L06u0TSXymd3Ri10UmpHCGVs
 B/gsga+a1yhMdrwKAbRThhhet0NYc0U1YvsdbRSvAQkqSi2AOzJkCJcp/vxU/a7sfF+Y
 9kSoGnFrFxLpubRG3bUaCy6hykU/sEJ65UWupiCBFxkpCL2kApbTpqOaOkoYIjWKs496
 bWFbrpPY2uPbJa0AKWQajnidgLH00D1x1NJ2pAQSpIyW4WGfMpVx+V4+Z/0VXZtVZRaK
 84UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720402337; x=1721007137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dGWic2psjPhblcVbvDyhK2I28rJI4ynyRXnbyzTr1n0=;
 b=St2FWUR2WOmQ8KdDNEAfo0Q05wCn1oEq9uBVpXHNhJOP+uLTC8iyGQGIEqNNaRBEm7
 1w5ce8QfbkDtzrzvw+vknTiaFUXh4r3B0DzvjbAv4Wn4gPg12vig0td/CvsFY10/8A5s
 1iecxck8OefatesMjo/FoRxPeRG6j8PYiyhEZv57oXFRDgIGMVqk82eSKQMTjrp59S6R
 T/ZjwIsK84ydVyCkLSRfsefj/k27LyxsI2sRRyMjsVWajpiZ5Gl4dL3mmjJ3okbIm/q2
 /Fj3CU7cPo6k9NUUoIa9Eqt/9ymkUBQukuJhUNsO035wF9nvqb0GcyJTbTq90Bl96dVs
 lT2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7HGkiZQUy1bxcnv9mSXybRA5li24OyAOhDsPKLPKCXeWsPJ9nX33ixuU8t7SVaPsVy1hPQqZvAqeE6SUq5Mj6bZSpt9Y=
X-Gm-Message-State: AOJu0Ywj8htzgYr3dMigotgSw3lMjgaGvwKRneC4nVFkVclmYHnWDkNX
 VDYl1YraLs8wIyGvIZojySZrHbsg08OM6zqcj6ZLE35ZqMSe6avcHKq06qbG
X-Google-Smtp-Source: AGHT+IG8x05yo0lwJYk7xvWjT3hc3rWomjE7qSKcSHh7vrJnztM74SaHSuO3PobJ5kzSMry2eHnO+Q==
X-Received: by 2002:a17:90a:bf8c:b0:2c9:679d:78a7 with SMTP id
 98e67ed59e1d1-2c99c7f7c71mr5371620a91.25.1720402337183; 
 Sun, 07 Jul 2024 18:32:17 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a98ac94sm6963729a91.33.2024.07.07.18.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jul 2024 18:32:16 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com,
 Minwoo Im <minwoo.im@samsung.com>
Subject: [PULL 1/1] hw/ufs: Fix mcq register range determination logic
Date: Mon,  8 Jul 2024 10:31:45 +0900
Message-Id: <6db492596dd9204e8fe341b2396472271cf15023.1720402238.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720402238.git.jeuk20.kim@samsung.com>
References: <cover.1720402238.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The function ufs_is_mcq_reg() only evaluated the range of the
mcq_op_reg offset, which is defined as a constant.
Therefore, it was possible for ufs_is_mcq_reg() to return true
despite ufs device is configured to not support the mcq.
This could cause ufs_mmio_read()/ufs_mmio_write() to result in
a segmentation fault due to accessing an invalid address.
So fix it.

Fixes: 5c079578d2e4 ("hw/ufs: Add support MCQ of UFSHCI 4.0")
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
Message-Id: <6dcb63036f3b35c833de752d1472d08bf4a9c289.1719996804.git.jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 683fff5840..cf0edd281c 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -57,7 +57,13 @@ static inline uint64_t ufs_reg_size(UfsHc *u)
 
 static inline bool ufs_is_mcq_reg(UfsHc *u, uint64_t addr, unsigned size)
 {
-    uint64_t mcq_reg_addr = ufs_mcq_reg_addr(u, 0);
+    uint64_t mcq_reg_addr;
+
+    if (!u->params.mcq) {
+        return false;
+    }
+
+    mcq_reg_addr = ufs_mcq_reg_addr(u, 0);
     return (addr >= mcq_reg_addr &&
             addr + size <= mcq_reg_addr + sizeof(u->mcq_reg));
 }
-- 
2.34.1


