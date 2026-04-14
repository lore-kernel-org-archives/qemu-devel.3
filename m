Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31245F9D0D1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCeA3-0002EW-JM; Tue, 14 Apr 2026 09:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCeA2-0002Dt-Nj
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:50:38 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCeA1-0000iO-3H
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:50:38 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d43e09de5so3351521f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776174634; x=1776779434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qGQ0vQZjSWVGg2TxoOsKEknF4O3F9luiW3rRVb2C2/o=;
 b=IJZ5Jv1XkHFSJBiGYNuWv6xPPYTKOPIMZyiNCI37BT3lTDsODqQcCMSkTablMKo/W/
 JjTqCh09dJ7VGkxm7z08mSNKPlmjygYLMQsyGuqOhmXOoUqVM4YeskH+LUK7GDIBrhg+
 K5jrRx4mfHF6hoe7zPZxD4JZzScIJdxg8LvbZVPb+mqshtrr6Qzkn84f2IdWJ5ULoMUn
 yoW6KPUXeqe6WSJbFyOZ78otKVNlTWZPDaUspwxt1j72FRTgoyE/Neej4PDJhoxx0wig
 8N/LAQtiqGFVQpkP2JNYd8XRXSIO5CsZe3pq3xVypaV7+xQdNKTrOHDFQ1f340O0NroE
 YNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776174634; x=1776779434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qGQ0vQZjSWVGg2TxoOsKEknF4O3F9luiW3rRVb2C2/o=;
 b=Yl4IqMmCpHTdvAWISAiLvsS689EPLLdBSoytOv4Olr0Zdo4vbI8/kjFfcuyEeBa6wO
 plsIAc+0PKOdUw5/X8JAFYeBUZupGdevtg+GrBPuN6hkUTXpUomzhoOxvDcnhnAR537n
 vBtOzEdm0rYE5iwpcuA9/sNrFXkbgcikzFCh2AmQidE5e8i18/21TbZ/E/kAgbIcsvHN
 IIFu1m517I4HoVs4E0uqOaT3hj7UFvKKyMWe4uIflm9ZmGcIb+dxJCbcbHWh+FqtJk82
 XQPZxWvkjdJbhDEPut7FyzwL1++jLs49ptb3CGnxQqZ8g4D4x0z12dc4tI2E4vbh8BNz
 AgeA==
X-Gm-Message-State: AOJu0YztljY+wHuibFP8VhhwUvK19lv8MEN1iu1zKh1xANUjD0gK7qAk
 Or5ZPtyGAAMXwJKBIerzGD35NLy5G9/uteS5965pcQeMwwvjH8SJYqZLZXJTpg==
X-Gm-Gg: AeBDievUSCQlSHM8j76s87Fh3/PhRKg2Vlbha9isdGyQTmVWvaj5YlBK/wMCBSzK8Uz
 pFzfuH3UbqMHvzxpQ+fIqlsai9kKfKtVfj4+vcVdX9hhKthFxPbSLpVfdP5ZQEhFpplWTZXBT95
 ak4WzIQd/WoN/h9Smqn4NhHhkyLkWz249SDudfFteZMUi6FoNVyggeELe5ANkGvQ8dnbRV8OWI1
 XkX54Wg7XDg810r4H4PbmSukZB4OUJwlweNYxUQeq9nSw7bcta06X+In+Im6o7Xbf1X0MGCnIUx
 vD6GU+qynIKChTchibY6QYBWxTqmlORT9WQFDLQxChSkykdlVpmxaD9DMkSx0zNiCKi91NrfHqP
 0WyzAik7a3Ywl2YTRB1XX10aO/IhtkZeqUr5wMu9zBbzjhPQ0WghcOgvfWOTV9PEgT+DScBcsU8
 E8ctVoytpMzcmWnYeRTOOdeWK2GSInRJr89b6vKhBashsm4qIkrcAMSFLYyUMFRpw=
X-Received: by 2002:a5d:5d83:0:b0:43d:30af:a173 with SMTP id
 ffacd0b85a97d-43d64259b7emr25902355f8f.5.1776174634040; 
 Tue, 14 Apr 2026 06:50:34 -0700 (PDT)
Received: from archlinux (pd9ed75d7.dip0.t-ipconnect.de. [217.237.117.215])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d7ba57e72sm14397646f8f.0.2026.04.14.06.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 06:50:33 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] scripts/checkpatch: Reject another license boilerplate pattern
Date: Tue, 14 Apr 2026 15:50:18 +0200
Message-ID: <20260414135018.13585-1-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The pattern us used 56 times in QEMU.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b77bd69328..b2ef0a8528 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -368,6 +368,7 @@ our @typeList = (
 # Match text found in common license boilerplate comments:
 # for new files the SPDX-License-Identifier line is sufficient.
 our @LICENSE_BOILERPLATE = (
+	"licensed under the GPL version 2",
 	"licensed under the terms of the GNU GPL",
 	"under the terms of the GNU General Public License",
 	"under the terms of the GNU Lesser General Public",
-- 
2.53.0


