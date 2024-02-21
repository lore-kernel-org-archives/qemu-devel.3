Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DF0C48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 03:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcdRw-0004pN-To; Tue, 20 Feb 2024 22:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcdRu-0004oE-KX
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 22:39:10 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcdRs-0005TN-B1
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 22:39:10 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6d9f94b9186so153354b3a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 19:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708486624; x=1709091424;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fjJrkKvVJfuQX4JEmI8lkfmp45l6GR6RaT47cBIMv2c=;
 b=TS1BV06UNDiZbPdEGf3llirSnerCIducPk6vAdNJMxZKWBdHJE0hBjqs+yhTaYnmKQ
 ip6+ldQCIfdaHnnNqhIKxqBtw5EYdlYcKBoUEXEsVHT31FJvNqsOBTUxTXabSivAlbC7
 AoAgRiFQIcCubu/4HHRsfzqJTY60SgU/S/d4WysX6fnnwjQUGAYtaoGRF/y1Fc+oMM+6
 XUx7MDXdi0lJP/gbccUCadphEF/fU/LpJ+qXQRR+ShlhKfJSWwX2F4UCkO4fGugX+Wa4
 4NJ1DEjNIBOCmxcvse/NV1Qo52rmAW3infhKosZE7J/x8YJGDhBHPb/Zo2C8DDaPudTB
 AHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708486624; x=1709091424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fjJrkKvVJfuQX4JEmI8lkfmp45l6GR6RaT47cBIMv2c=;
 b=AEUWeVrrXz+EfAbSrowZh3ha+aeikSnNjHd4WMnEFNQB7OQoXl043RgcCsZmxwh4YX
 ONOLwbR88Rqk41INYlKh8oo2C4N3ASvTBKQjnSrVxInBg0Ep6FOwrmdjIrWhjC5O1W1/
 tr+g9AuebE3C82lf5VEmjbfjw0bwAygb8zXs42thyL2VIaPY6WE48VnYjgnk/1DMbzHQ
 YweeYRFIpiqXBvfQhqGlx+tbs0OPOK2ApSNIyUe1x8GOP7bLK1Ywo1ZUQffDkFZ8kfhp
 Yv+1n42a+Dcgk7wOVRxWc3VB9mLMNlTAynd5fSa9dYufGe47WyybYVzc4AsON3rskDkz
 eG+w==
X-Gm-Message-State: AOJu0Yx8HQ7FGzz09IQAuK0D+mJ/2RufD88kxgeImvMayKnMAZuJIyi8
 fcys+GlF9rFeOrKQ3jpr/nl07tzK9Qg2Zc6p4/Wzp4tPW1kN5irDMXrwxJTZ9/kyIA6RQ43ZSWM
 puiU=
X-Google-Smtp-Source: AGHT+IEKO9IPETCbl/6GyGeIsPlMsXqwA1mhV8agoR3/2pS+eF1uy4MUJ46czNclCQkFqtsiWQWs1w==
X-Received: by 2002:a05:6a00:80e2:b0:6e3:dd91:27f with SMTP id
 ei34-20020a056a0080e200b006e3dd91027fmr9341855pfb.14.1708486623290; 
 Tue, 20 Feb 2024 19:37:03 -0800 (PST)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 fb39-20020a056a002da700b006e44bce8318sm5711278pfb.124.2024.02.20.19.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 19:37:02 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH] qapi: Craft the BlockdevCreateOptionsLUKS comment
Date: Wed, 21 Feb 2024 11:36:58 +0800
Message-Id: <91c52e03e46ff0a96559b4e7d66ded582b2ec4e1.1708486450.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add comment in detail for commit 433957bb7f (qapi:
Make parameter 'file' optional for
BlockdevCreateOptionsLUKS).

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 qapi/block-core.json | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ab5a93a966..42b0840d43 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4973,7 +4973,25 @@
 ##
 # @BlockdevCreateOptionsLUKS:
 #
-# Driver specific image creation options for LUKS.
+# Driver specific image creation options for LUKS. Note that
+# @file is required if @preallocation is specified and equals
+# PREALLOC_MODE_ON. The following three scenarios determine how
+# creation logic behaves when @preallocation is either equal to
+# PREALLOC_MODE_OFF or is not given:
+#
+#  1) When @file is given only, format the block device referenced
+#     by @file as the LUKS specification and trunk it to the @size.
+#     In this case, the @size should reflect amount of space made
+#     available to the guest, so the trunk size must take account
+#     of that which will be used by the crypto header.
+#
+#  2) When @header is given only, just format the block device
+#     referenced by @header as the LUKS specification.
+#
+#  3) When both @file and @header are given, block device
+#     referenced by @file should be trunked to @size, and block
+#     device referenced by @header should be formatted as the LUKS
+#     specification.
 #
 # @file: Node to create the image format on, mandatory except when
 #        'preallocation' is not requested
-- 
2.39.3


