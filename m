Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49932C5DF7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2ar-00018o-Fe; Mon, 17 Aug 2026 15:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2ZB-0006I0-Hr
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Z7-0006TD-UX
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4954dff6536so27776715e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 12:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993208; x=1787598008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nDL9CAOnygcQr6TXGuqu4JiUlKl3duwzZkyPxwmpAVE=;
 b=k+6UNobgedDTRaW7t6LSBltypDzRGoo/VjrLD6eXUkP9W24ika0Xk+suXm/eNzrZNr
 zSNK7Ss5y5VXCNLbgwfhqNKkuxNGO+2zsOGotHeU2Um3DeNlrODx/MfDecUG0Z6c+oxz
 nSaWLUTVxE6dAHJRPqcEkpM6FfvZJjMP7ePCDu/FfSqqbapuN+K7dbAWyOBSyTFYkz77
 29BM0bQEcjG8/eEIOwg7XQPwe76Y/8D69LvXqb1wW3dUL4FYB/5B07UGwJ3R4wcny6Wn
 vZ5qwvwYWn9F+ROoxeIbCEid5PA1hkB2Q9RYykiHhqdM2nJZy8IEttvtn3kaerid9g+y
 5bvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993208; x=1787598008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nDL9CAOnygcQr6TXGuqu4JiUlKl3duwzZkyPxwmpAVE=;
 b=EW+IZpicc7yI0cWfsbP6LmfeUdp+NE4epASVIpCMH7bHqD/0NUts/qjEC9oWKDNqDj
 TEUD5FiVaUdiVS8HsxK9f/uTqBZI6ABZRzQlz67cEof+Qz2kIc6SXwPOKGzlo/AiHYnu
 KuauVupFY8eolZlyj+HJg7wx2bgGFBLOw7yYMPf0MohDWcDpElAGTyefGfRklweru+Xd
 itQ6f5U0sfPFhcBlOvWwvNsfJg5s0Z7sqp+8jwajiPseilK95q2/ETiMA81K9i65Ntba
 CGw+zd2cKXQi8T9aIF7LfX3purx9BEfuhqhiSjw7kiMfQnccaN5eTpgN5yawuxqCSuy7
 MT5w==
X-Gm-Message-State: AOJu0Yz8x5Jfd/UR7RwocUQQAI0UcFdP8DkJK1bZCkZAvmpo7RwVEas7
 bh94UODHBo30DMaUGaKSwTTPp1ALCGSpjzjZxrOelRM34F7gVbix//sAGzztbAggAIlg1tc8B4f
 bdDOu
X-Gm-Gg: AR+sD12YTkL9CjYSda7MgKv1Gxk8GzeM6W9BgydUGn2e52vXJUs86EE5GjTj3sDhE1Z
 AV3jx8O0x3zpyfdqI+WYXewCH6JGZww+cFIg4Pu8o5zjZ7HCGJgvL50aHW4dpXtOlYTVD6jnpbB
 Uvy/SdAFJXQMvAjXJxicZbnbQOVYSeBN5vACkHvU00FW76jGfd5f50hTWpUtBMqTOnzQ0wGcQBn
 nI0Ta5nYmNMgHz4WCXiK/NiwH9aDPbvewhFEczBVo5ianebXtcRW8GpPOrRZHsTvI512LZ91mXo
 mHNeSpNIo5ZzJIC42zEy0wUgX/pK/TREJTVSHdMvy6IdzYGV+Jq3WU9pMRYygAchwGqOWCKqSXb
 7jSwU/i/7gK+yxw9sybqi1qb/Y4ehE18C/65LrC9Mz0qSlg1H/R1Ec+PYEXVp6Rwd9QvhlbNoKz
 Ao1Jvu8ov9W2zKQyAkCB0V4z7R80CUXe7ZbNegVoYvPmcq/ddTig==
X-Received: by 2002:a05:600c:5392:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-4998795d6bemr432495255e9.11.1786993208089; 
 Mon, 17 Aug 2026 12:00:08 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.12.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 12:00:07 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v6 20/25] iotests: rename parallels-read-bitmap to
 parallels-bitmap
Date: Mon, 17 Aug 2026 20:59:37 +0200
Message-ID: <20260817185942.1065143-21-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=den@openvz.org; helo=mail-wm1-x32b.google.com
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

From: Denis V. Lunev <den@openvz.org>

The test is about to cover storing a bitmap as well, so its name stops
being accurate. Rename it on its own, as the patch which changes what a
test does should not be the one which moves it.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 .../tests/{parallels-read-bitmap => parallels-bitmap}           | 2 +-
 .../tests/{parallels-read-bitmap.out => parallels-bitmap.out}   | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/qemu-iotests/tests/{parallels-read-bitmap => parallels-bitmap} (99%)
 rename tests/qemu-iotests/tests/{parallels-read-bitmap.out => parallels-bitmap.out} (100%)

diff --git a/tests/qemu-iotests/tests/parallels-read-bitmap b/tests/qemu-iotests/tests/parallels-bitmap
similarity index 99%
rename from tests/qemu-iotests/tests/parallels-read-bitmap
rename to tests/qemu-iotests/tests/parallels-bitmap
index ee071714a5..601bfc5228 100755
--- a/tests/qemu-iotests/tests/parallels-read-bitmap
+++ b/tests/qemu-iotests/tests/parallels-bitmap
@@ -1,6 +1,6 @@
 #!/usr/bin/env python3
 #
-# Test parallels load bitmap
+# Test parallels dirty bitmaps
 #
 # Copyright (c) 2021 Virtuozzo International GmbH.
 #
diff --git a/tests/qemu-iotests/tests/parallels-read-bitmap.out b/tests/qemu-iotests/tests/parallels-bitmap.out
similarity index 100%
rename from tests/qemu-iotests/tests/parallels-read-bitmap.out
rename to tests/qemu-iotests/tests/parallels-bitmap.out
-- 
2.53.0


