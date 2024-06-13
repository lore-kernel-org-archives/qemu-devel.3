Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AE0C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 08:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHfTw-0000I8-IA; Thu, 13 Jun 2024 04:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHfTs-0000Hq-Ld
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:06:48 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHfTq-0008DU-A4
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:06:48 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-35f188e09a8so612737f8f.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 01:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718266003; x=1718870803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wo1aNRskEU811vF8mjPn+uW0WP5P56W3ZxgFYtWVrgI=;
 b=rOF3F0OWosRfy1kPIjyYzDL7osclTIsiFD2sugHlTor4+vhwaTU4A1KR87f9FZnKRA
 QJYz/PuHCVx2roS8nYtkkQMCkRMCzhe4RRYKjIsj9au2MR2wUWlUMSJpIJez7qJDEkxG
 L5IhoKnwHXvJQyl7X6H3laC0UAfZsdiOjQVe2sfiv9IFPtHIIvLRxEzovjnlnXpucoay
 BLdrAzpBY5IoXcNiRjCnjaSLbInt0/h//wggThN1S2gHNPFYA2j4a2hZNWjYoE2dO1WK
 OaYp66bCi/JJ8mMlkzabcpGAS3sy/kioMrTQFtXEtJy9yuK3P7fVJoA8xzs20NWWZJYG
 BuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718266003; x=1718870803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wo1aNRskEU811vF8mjPn+uW0WP5P56W3ZxgFYtWVrgI=;
 b=TG4vnb2cR1Qph8CDw4ZcK7c7sk99sbn3CZ1sSicCxOoTRzo75dje83jIgNMzNyh39T
 pCd65flFHnxYOkXSx1zUr7lOs2pWRd2g6dRA+orwrfZrA74QH+crOisfXCTKeh+31krw
 aYy0u2XWK3InJGJOpigAZAGozMipzHILrN8l6BvyI3neHZWetGZ4lFKwFNrWq97tl2zW
 FKSSvEa1V7EkmCxzM5WrrVSS2seocerXMWInCgM5wmcf/2+8CaIcQL/ELWpZGPFSBwl9
 ScZgmJFg1FnU+aYt0KGBujVmxgzob3u3ZADrA0X+fpX0VTJ5hOA7XQTkJQwbL+aONybB
 lS4A==
X-Gm-Message-State: AOJu0Yym5UvB40gYHD0C2rVvfyTA0Yu/bl+lXLR6x7xDatQ1xpB1hBAn
 OtpWp2r2Ygr1oEYMBtEdZo7/ziIjwRsQqo/8kzH+48H2Kcd/zu9gXnCT2y1qmfTW/UbvkuRZGuV
 G9t4=
X-Google-Smtp-Source: AGHT+IHjxqayZhfHj5oT3LBqu08Sdst+4DionKRMkB0feQozuXq9cAVmCgZqITDMh/vF2cFPYUCllg==
X-Received: by 2002:a5d:4a8e:0:b0:360:6e97:6f8e with SMTP id
 ffacd0b85a97d-3606e977015mr2363526f8f.0.1718266003416; 
 Thu, 13 Jun 2024 01:06:43 -0700 (PDT)
Received: from localhost.localdomain (adsl-105.37.6.1.tellas.gr. [37.6.1.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104d88sm910811f8f.104.2024.06.13.01.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 01:06:43 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v1 0/3] util/readline.c: Add common but missing shortcuts
Date: Thu, 13 Jun 2024 11:06:10 +0300
Message-ID: <readline-shortcuts-v1.1718265822.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Some commonly used readline shortcuts are missing from our 
implementation. This series adds:

- Control-n next line, same as Down arrow key
- Control-p previous line, same as Up arrow key
- Control-u erase line starting from cursor

Manos Pitsidianakis (3):
  util/readline.c:fix lints for readline_handle_byte
  util/readline.c: add C-n, C-p shortcuts
  util/readline.c: add C-u shortcut

 util/readline.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)


base-commit: f3e8cc47de2bc537d4991e883a85208e4e1c0f98
-- 
γαῖα πυρί μιχθήτω


