Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2737C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1ou6-0002vb-P4; Tue, 30 Apr 2024 10:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1ou4-0002v7-Io
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:56:20 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1ou3-0006bp-33
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:56:20 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34d8f6cfe5bso450515f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714488977; x=1715093777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CULYJvYm82GTRYuuP5o23sVkVHkMsAV2mUU3SOLa208=;
 b=dJsKObDjHYruxy0VPQga6YE3mXtmhu/06SUdEkYovZdgikyD7l4Axg22X9vI46Ur0A
 xrse/llIMMKtFn78To4guALh7KpXgN3cRFkYXh/7nUqr58I/1W3lSXMq8iydLceS9N8t
 F41SQBztnpkX/NF4JwAYHpCRHjRJedlO7Y7gYAdEJvVI8J1ejFsVz1E1Mte+3zbZyhkB
 PO5Z20ICeISG5lA41sJEaBb7AbjUS3t95v/v3Hxn75Mw0KjTfy+U+uFQnsNwWh9m4mj8
 AERk5BDQKenhAks7Y3wLHz8tEEATT5Ona3ga43rX2wFjQypcYCMC/YF8sbFVLY+yO40v
 bkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714488977; x=1715093777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CULYJvYm82GTRYuuP5o23sVkVHkMsAV2mUU3SOLa208=;
 b=i54OeIxJ/1z0Lg4jtS3DXbZ/4nHediqkmtUhpOlxqurYnVBWwqiQYO2pqtzarAcRBe
 QhgtKtp40+yXeNQ18T6tAaMTR47LgGrXh0JMFu7KhiXOeLP2iJHl8Xr2ltkyeggVuhKs
 Ax4z8INmfYF3eeeddBpGh8GMOCE0vTHWXk3jYkRGMvz0o64bwAx2NEV54EEtCcrBxP3H
 cwzPFWRBJvBJpI0I5rJiV2YY69R8wTJxX3tQdHqvzgNlBTi3Owb8+SUPt+oEQknjEVCD
 7wESO8e3V82Aid27alos5VCx54r7F85uil7hsS13xuKiAMi338voizmkRmqWN+S/DPp7
 wdrA==
X-Gm-Message-State: AOJu0YzvXFLoVJQkGQDn6NHR/sDELkqz3x1ZpAx/k/4sWgejUSRhJxsw
 Q0ICHJv3sEKOcXv3iVmbrud3r1pNYddKyhrKKir4c9bUg8nvCdoRyLr6MwfgUUiB6xmp2k5L3cZ
 J
X-Google-Smtp-Source: AGHT+IE9TYdVShN4Yo4YjgWoF4UACQ9uzBnltovDNM/fuzneOigy7s9x4K72ZL4qPWhMwKcO0upx7w==
X-Received: by 2002:adf:e111:0:b0:345:ca71:5ddb with SMTP id
 t17-20020adfe111000000b00345ca715ddbmr7041951wrz.66.1714488976923; 
 Tue, 30 Apr 2024 07:56:16 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 y18-20020adff152000000b0034d7a555047sm1954429wro.96.2024.04.30.07.56.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 07:56:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Cercueil <paul@crapouillou.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/4] target/sh4: Fix ADDV/SUBV opcodes
Date: Tue, 30 Apr 2024 16:56:10 +0200
Message-ID: <20240430145614.76475-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Since v2:
- Add tests (Paul)
- Rename TCGv variables as in manual

Philippe Mathieu-Daudé (4):
  target/sh4: Fix ADDV opcode
  target/sh4: Fix SUBV opcode
  target/sh4: Rename TCGv variables as manual for ADDV opcode
  target/sh4: Rename TCGv variables as manual for SUBV opcode

 target/sh4/translate.c        | 32 ++++++++++++++++++++------------
 tests/tcg/sh4/test-addv.c     | 23 +++++++++++++++++++++++
 tests/tcg/sh4/test-subv.c     | 26 ++++++++++++++++++++++++++
 tests/tcg/sh4/Makefile.target |  6 ++++++
 4 files changed, 75 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/sh4/test-addv.c
 create mode 100644 tests/tcg/sh4/test-subv.c

-- 
2.41.0


