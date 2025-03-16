Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B7DC282DE
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Mar 2025 21:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttv8L-0007xN-3x; Sun, 16 Mar 2025 17:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ttv8J-0007wu-LI
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 17:02:55 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ttv8H-0007PR-1B
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 17:02:54 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac2a089fbbdso671570066b.1
 for <qemu-devel@nongnu.org>; Sun, 16 Mar 2025 14:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742158970; x=1742763770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ozTVOAKDNDl6lLKmtNX/2JjRm2Ikwd3IhnwRBCol/Lc=;
 b=aQggqtddAvg9C8mOnkNK97lBAYE3Fpw+GSsr5GGglIqCbsbzAMhL2F0udX+pvNsGdY
 IL9Lm8zrf8Sh9+88Q9gksNeCPrlWs3RBSWFxLoQuMfUIrLYfRJ7nGYo6oGGOfz5LB+5B
 6l3bftq3k3nJGsPHKCrF5Mk+vBagFkw3jTbDia2NZaySp0xAPJpYk3iVlF9pKbAiUK8e
 PTCl5KnRKoOieQ/TSNs1u4d205nYqXUoSwyxEj5ZDS6yPeRZYWQsFy6lv7E7hZF7VpVW
 putQgZKqLdnumReU5dgXrVs47MLI2Wx6aXIBZSmnlsW12vmKzdhpN3PShFHUL9rS+kwH
 TF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742158970; x=1742763770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ozTVOAKDNDl6lLKmtNX/2JjRm2Ikwd3IhnwRBCol/Lc=;
 b=gyGDS+rMqZe4fJRujjRaWsCdli5nzUeA+w6+QY8W2H5rYrKc7RSdWyDzB3GJY6Uwzu
 ny0vQ9mwVHneOb9mIjzlxHFE255JM3OdvqyrT2QifyHyDg++esFTOVZd1Uq/fgfJ3td5
 K+IMk/HbN/RZZjkOlKtcSw9Y3kVzPnotdYVKszepgPvjnli7sibZ2cGq685ytWR9HPOu
 gFu+wMmT7gyGKTom9WDbTmWh010IRvVxo3CWWkFhNfJOHSQGCAZ/qclSu8vnm2B+TJNh
 jP7iy0ug6P6pAmsfmF0yGSC//hSd+4PXglWnwyelpukAPUdBZB6ZgzRGAwFns/CUrbN/
 os0g==
X-Gm-Message-State: AOJu0YwDbRNCO4YReay1SUrfq8DUMjlQPkzk2wdJ87UW2Psbqu7ky3r9
 JP9Whv9ufHe+0XJTw87a5n3QrWPapCpNU3Z64ZwKq/L4TKncL62WkEOoKw==
X-Gm-Gg: ASbGncsRAeF/avNfP82zhw9n0iCLoCuqhqsTSKXowM8ezy4/9OdWgE+quRM3Krcx2FQ
 Qrq3pemRw1OCTpzYZ2T13VSgPVRIfngMd/LgZLxO2wDPAVKElfoUw9dCrh7ysEpUXfFvQg0jtOZ
 WirkmhSUSZweB9LvMwJcfj6L8md03rigH2LVA4b1sjgv+DXgabZHxcWp5QHRhE0Og8Yh1l/G6E1
 LYnGM4Mj92ONlfXTlcpp0MuGSf2nc67T+xByh2P+W2WMabOo7tSYj/26z8BNF0jB5NARd9QmTp7
 KERS4fQXgHLmqg6iJqu9oOSCQ3jAcRhSFqCV4riRx5vd+jQuXz8yqq+rxtzBWe8+PGV0QcuuJhO
 Csml/ZWBRcgqPZQo2l11hdmDjDv1Y3aE=
X-Google-Smtp-Source: AGHT+IGooTcg0Rc8BRMoBfAbD8dyJcgUIDoGg56BKvBARkA/fdgmgGriMK+Bs8vH/+FXcT3fPb0ALw==
X-Received: by 2002:a17:907:c247:b0:abf:6ead:2e57 with SMTP id
 a640c23a62f3a-ac31250719fmr1433328966b.24.1742158969849; 
 Sun, 16 Mar 2025 14:02:49 -0700 (PDT)
Received: from tuf.home (2a02-a456-6be8-0-cb0a-9e69-93b4-ea85.fixed6.kpn.net.
 [2a02:a456:6be8:0:cb0a:9e69:93b4:ea85])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ac3146aeaccsm555599366b.11.2025.03.16.14.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 14:02:49 -0700 (PDT)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, berrange@redhat.com, stefanha@gmail.com,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [PATCH] tests/functional/test_arm_orangepi: rename test class to
 'OrangePiMachine'
Date: Sun, 16 Mar 2025 22:02:31 +0100
Message-ID: <20250316210232.46298-1-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-ej1-x62a.google.com
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

The test class in this file contains all functional test cases
for testing the Orange Pi PC board. It should be given a name
matching the Qemu machine it covers.

This commit sets the test class name to 'OrangePiMachine'.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 tests/functional/test_arm_orangepi.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/test_arm_orangepi.py
index 18ee50216b..28919391e5 100755
--- a/tests/functional/test_arm_orangepi.py
+++ b/tests/functional/test_arm_orangepi.py
@@ -14,7 +14,7 @@
 from qemu_test.utils import image_pow2ceil_expand
 
 
-class BananaPiMachine(LinuxKernelTest):
+class OrangePiMachine(LinuxKernelTest):
 
     ASSET_DEB = Asset(
         ('https://apt.armbian.com/pool/main/l/linux-6.6.16/'
-- 
2.43.0


