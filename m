Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC409CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 13:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGdq0-0005pk-4m; Wed, 05 Nov 2025 08:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGdpm-0005ot-4u
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 08:45:59 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGdpk-0003Hv-H5
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 08:45:57 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b7277324054so69757466b.0
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 05:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762350355; x=1762955155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hOWY8zcxAbuKabgDxLPO4hMnLQ6i4N9rNRsLp0x8CNw=;
 b=s/lz1HkPmc8LRoXLNMy8XVoKYlD/7hPnrbp1mTvT3j/Vm/Hj5f9YgNj2EkTiAo/zEi
 5vFzCZMPHy9vEKTMinqQhMs0bX+A7nzlR8h6289jJz/GKWmXeqgfyZomJ79m5f/FPhRb
 5BVkN5e1xKDrfZFXVlSsXVOFf8YhuRvp10919lZvlGiDWGhUDJXCiRctO55MKJm7U4hl
 4oN+VE42pzkz7nMNCmEIr7czjKE4fcIWsMX9Wz3xNWcxD4JsICMUhB0FlrY1zVlp5a1K
 YF83ADNNGJTDYVtvu1+d+R+puO0aVr7mhXfj6vEG2edQUxyfvm8fZ4RnpJyLFTdur54Q
 2oOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762350355; x=1762955155;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hOWY8zcxAbuKabgDxLPO4hMnLQ6i4N9rNRsLp0x8CNw=;
 b=hSlRnLhkoBY0cYdN1mb+uGgmyhofYCFrYcqU07AsH3LJB4DXGyry0Fo0ds+8iYnkTn
 vz4mVchD0icDJMB0Qwj6U3AYYWclNuxIZxriD5NIWGwYkQXD2oylqBJnr0kUopOMUK3o
 PdPciIFLZOp84G93CV9FyWDUEoHUB0h7FTJbNo6wQm5135BxGrsdKZt/gksvKKULV//z
 QIYO2Tt2mfrzlSOxAbWukrJ8GPXTvbr4AwvDIaZVdvrsFNNdtrcKEKhflv8+qv8PDaKb
 HgC0Rtp8QP9cwqkK/o5tVgyqSUfhmRuwzqGa9rToF/psuXuUPyo7E9YtdPrtvuR8k5Z9
 Hx5g==
X-Gm-Message-State: AOJu0YwncYEkp7iQtWXgSspcQyQBvWKRX2etAV7n3wukvvTkLa5JRg4a
 q7SClI4jogNzqAh+KpDj05cJzPObP0EjEodiviYCAdhviRTVCkypZpKYvTLqpQ5xflC3cHvVJxt
 2L2c95K4=
X-Gm-Gg: ASbGncuThWJ3sFOE+CGPSDNsBOom14sw3W5MDrXB7MnWZ81r1sBJRRNM4fmcr97BRET
 olSuIR05fLFNKOGTBYrYKl3NhsbWgBmIWoOjq0rYkqnjeESo0NzJ6rKjz/eCQzLPdqj2qFxGGut
 Cyff20jf7XM2lSj0CxiBuPOlqcjPUJrogSL8NhuZs+XQnzRm4mS/N6DuWVHvQ3FjHYcP7yUNwNP
 kZVb4hd/+L7DsM6DRX9xNypWonvI2pOhV9rbpaHjJ8r44W9HdCQDNYBUMDm6rGtVRroXTH4Sxjs
 eDB5vSd4Jpxe9PxyO+kU5sUpnokn5SaXSJhPwNv4P+UmqxliF40rpgUnO6hPVacwOUldFq+n6wK
 VpYEs+Nc3P7trjoxSOv/0WtpkkdRqx2/zyx8eLKI5Hrea+XLzJgPI4ac1n/oLaCUvEbDHsRHZe4
 PTzigU2pSwRm1mSVw=
X-Google-Smtp-Source: AGHT+IF053uVFsgyy+rQ/FgjesWWxAYnS2UEbnF52c0F/DitvsuO9CFbuv1wkpAYpHf4+oAR2yp3pQ==
X-Received: by 2002:a17:906:dc95:b0:b3f:ccac:af47 with SMTP id
 a640c23a62f3a-b72654d3d65mr337495966b.31.1762350354840; 
 Wed, 05 Nov 2025 05:45:54 -0800 (PST)
Received: from stoup.. ([87.213.113.147]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723d3a3496sm506764566b.8.2025.11.05.05.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 05:45:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	armbru@redhat.com
Subject: [PATCH] qapi/migration: Rewrap to 70 columns
Date: Wed,  5 Nov 2025 14:45:53 +0100
Message-ID: <20251105134553.354886-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62a.google.com
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

Avoid

In file included from ../publish/qapi/qapi-schema.json:53:
.../qapi/migration.json:1750:1: documentation line longer than 70 characters

Fixes: ae00f0088ff ("migration/qmp: Update "resume" flag doc in "migrate" command")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Applied directly to master as a build fix.

---
 qapi/migration.json | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 6acd9e4b16..cf023bd29d 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1747,10 +1747,11 @@
 # @detach: this argument exists only for compatibility reasons and is
 #     ignored by QEMU
 #
-# @resume: when set, use the new uri/channels specified to resume paused
-#     postcopy migration.  This flag should only be used if the previous
-#     postcopy migration was interrupted.  The command will fail unless
-#     migration is in "postcopy-paused" state.  (default: false, since 3.0)
+# @resume: when set, use the new uri/channels specified to resume
+#     paused postcopy migration.  This flag should only be used if
+#     the previous postcopy migration was interrupted.  The command
+#     will fail unless migration is in "postcopy-paused" state.
+#     (default: false, since 3.0)
 #
 # Features:
 #
-- 
2.43.0


