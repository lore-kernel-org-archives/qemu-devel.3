Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFD5E9D834
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 05:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9c9F-0002Mi-LL; Mon, 06 Apr 2026 01:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1w9c9E-0002MO-Aa
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 01:05:16 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1w9c9C-0001nx-P2
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 01:05:16 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82a7ebc729dso1411262b3a.3
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 22:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775451913; x=1776056713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oxxjox1gJ+tGqFRrxpajMy1uEJ4ChHv4Ckz6L2imF0Q=;
 b=CijviWn1FcCFd0x+eJYVxJ/vU/SomF9vOwC2P4U/UnJmMmG0/h1VmJIoNDhaTbwzFb
 TzCt/CrYcgFNaVr5m1TJTgwmkD0E+hxXGu8/jOgDsWJYbODJpALiG8LAqvlZyTbd8cYz
 0tq0xOLGdKrzUlteVbpfo3T04b2vWC7ReAJSkToQv2pPz2lixnWNOf8v5P3W+67PBQk/
 KDI/lxhCYRaVSnDfz0BrClJCp/DZTLNxuk8mOgfKVGL4iOXkc5XPCYdwrib3kChhP7Nd
 fU1Y8g19PWCM5mLLHFk+f+Z5yCCw1HcLyz6Jht8WK8ZehkzGHhS4rZHkIGnDp2lfRw/t
 ttrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775451913; x=1776056713;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oxxjox1gJ+tGqFRrxpajMy1uEJ4ChHv4Ckz6L2imF0Q=;
 b=qtH/17Sa/sguCwEKMYclGGJUwa0gI1LzwsBXRGS+jiqoxMwjEchQoV8tb/BHP9mKtW
 RwpqNLChl82ODQH3gaxZ+orx/Wp08E58FmsdwKPeeEZLQeBSwnK85ySrRNiZJ9v7ast0
 dmqsQkpVWGSAEUy9pmVsMmorTjDTFGTL6JblIufBeWTLDSDwyaGUn+c9R0wE/sD5BNqW
 idk1j93s3awbnZ83xi6QX6dup89//Rr6zf30Mu7wX+Mqf/uUyEkbhaigkY9goJ5Vft0M
 GH3/2hz5dAJtU8fHtmhSU4WJlK8Srg/VUq0GP0xe51hkSM/Bh/w4kfwJol5nsnMdY6sp
 fEgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLPNcD0FZPVfCfAikksyeVohiveyOsgJD0LZQXMGpgRF//e9Upwoa3UxW9jTiSYzBJ08zB8wYMLGXa@nongnu.org
X-Gm-Message-State: AOJu0YyuJnZiLga6yO+S8oKzosh4b1LCYzIhYm39/Nb3UAQ6Hqb5tkgp
 tE0v5Dwp/1yn3uvi6cAY0vp0eMOJ707vD3DJ4x/2UEXpaKa8DxwoMeSG+JMnCQ==
X-Gm-Gg: AeBDiesXsNvQp4mpkeBS5V5Lbl6SAHPmEpmT9HkfXSl4HJgjnjhH0kj/j3XgsmCU8Mc
 2Tq0fhXZSjJY0xNkHfVU99vqNm/nbATTWI5om6grmFgx/fqlXlwRrRpo7+968YwNHhck+7pChrW
 CrbVVCjnbkZ4v2j6tnrwtOcNWPml67YhSYR3sOnXtstNBb9S/TgdzwbQ8pn7anXF2V0O9HNqWGu
 6cYf4GxSo+aoceCSwp1n1eaUqvIhWuOGQ0F8quLBgIpSiPEfNpWHKLVUD/PMS4UR6Ij3qkK4Y8K
 mAuWrc+Wsj5E2gs5pL2eHL8MhjmHypko3eyAFq+JGQqblTVlWLwtMg5C+ZwpvcgzFoK9zca9Y36
 pv5DMYojr7hss/sBYNR4Pr6xrQpAXOsAbmQKDGxBMGHGPGGU4NF+QRexv8slhYkqENBNCvuL18X
 lvC6ktQC/Y9lwG7LcNLe6BHD/Kmr8B4/FhtnE=
X-Received: by 2002:a05:6a00:1d9e:b0:82c:e19d:cabd with SMTP id
 d2e1a72fcca58-82d0da2afbcmr10637317b3a.10.1775451912555; 
 Sun, 05 Apr 2026 22:05:12 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.2])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c9cbdfsm16036202b3a.53.2026.04.05.22.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 22:05:11 -0700 (PDT)
From: phind.uet@gmail.com
To: marcandre.lureau@gmail.com
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2] util/readline: Fix out-of-bounds access in
 readline_insert_char().
Date: Mon,  6 Apr 2026 13:04:54 +0800
Message-ID: <20260406050454.284873-2-phind.uet@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=phind.uet@gmail.com; helo=mail-pf1-x429.google.com
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

Currently, the readline_insert_char() function is guarded by the cursor
position (cmd_buf_index) rather than the actual buffer fill level(cmd_buf_size).
The current check is:
	if (rs->cmd_buf_index < READLINE_CMD_BUF_SIZE)

This logic is flawed because if the command buffer is full and a user moves the
cursor backward (e.g. by sending left arrow key), cmd_buf_index can be
decreased without descreasing of buffer size.
This allow subsequent insertions to increase cmd_buf_size past its maximum
limit of rs->cmd_buf.

Because in the ReadLineState struct, cmd_buf[READLINE_CMD_BUF_SIZE + 1] is
immediately followed by the cmd_buf_index integer, once the buffer size is
sufficiently inflated, the memmove() operation inside readline_insert_char()
can write past the end of cmd_buf[] and overwrites cmd_buf_index itself.

The subsequent line:
	rs->cmd_buf[rs->cmd_buf_index] = ch;

then writes the input character to an address determined by the now-corrupted
index.

By providing a specifically crafted input sequence via HMP, this flaw can be
used to redirect the write operation to overwrite any field within the
ReadLineState structure, which can lead to unpredictable behavior or
application crashes.

Fix this by adding the guard to check for buffer fullness.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 util/readline.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
---
V2:
  use assert() to check the value of  cmd_buf_index before the
  insertion.

diff --git a/util/readline.c b/util/readline.c
index 0f19674f52..e2664e48ca 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -84,7 +84,9 @@ static void readline_update(ReadLineState *rs)
 
 static void readline_insert_char(ReadLineState *rs, int ch)
 {
-    if (rs->cmd_buf_index < READLINE_CMD_BUF_SIZE) {
+    assert(rs->cmd_buf_index <= rs->cmd_buf_size);
+
+    if (rs->cmd_buf_size < READLINE_CMD_BUF_SIZE) {
         memmove(rs->cmd_buf + rs->cmd_buf_index + 1,
                 rs->cmd_buf + rs->cmd_buf_index,
                 rs->cmd_buf_size - rs->cmd_buf_index);
-- 
2.43.0


