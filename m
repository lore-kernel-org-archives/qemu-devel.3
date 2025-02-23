Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0956CC021B8
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 14:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmDN9-0007oz-8W; Sun, 23 Feb 2025 09:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tmDN6-0007oE-Be
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 09:54:20 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tmDN4-0007db-Fg
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 09:54:20 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e04f87584dso5194046a12.3
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 06:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740322455; x=1740927255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DGvHnZ3WEbefMGw1c4k0Qs3t64lR1aiH3ElukCs1rMs=;
 b=Xj6cn/wrwkQDBHzlBxfKG8k+bklBvJBTDhpYEfYRAXYjTi5rj9C4tffgVMTSW874G0
 vxW3hJPZMJBR/HqpVF7YoxVVmVyAWtOkmJ/rbFqyxD6JZFLDMBt04yHDMEANMK9CqW5v
 qWHcXsdS+cm0+6FTCP4scl+ZEu+6NPvMkqbfw8xIXYs+keH9RrLMoVDsUeGKbkt14HVC
 PEin3VkhSotwZo/19RVgEQpCsXXEl64Mx+w82DoAorwzL9hEkT+ap9bGqEEiSlAihs3O
 dfKgWiV142SD9aED9i5tV1AZBvyS33KQYZxiy6lgaetJGyA++XfUCMC1vujgZ8xNozNY
 wfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740322455; x=1740927255;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DGvHnZ3WEbefMGw1c4k0Qs3t64lR1aiH3ElukCs1rMs=;
 b=JsxhG0sRvqD8GMXFEcTcfTCDoxaWg0BkuWZ0NjhgXQ0gu0FYYqZksY0ZC8OgYeJH6S
 0ninYTvDNnV/S0NkY29UCproaMn842GQYy8hRdmiAGkmUgwDv6YQfTZtAy0T1pIfIGug
 at34hKXXvad5pAATyfogTOGYBZ9lFUoI27vgWegC9fQRMYybZUCXaDmvhm8yHBUGZcsn
 sOGfUFS20MRXhee6FT87ZkFpH33WftYZRsD4cZqyuN5vL56ddi5RVBtr/PDLNRG/V7p0
 vMuFpR4yfGpl1JM8yCsY/V+jS/HgT5UgjC23Sc0vrd6kmvf4nwYGUzNSYu0bGBM+slDF
 cbCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi12iibYqs3Sbo0SuKu/mhejbrcZQB+Z0gCLmmJhz2iMhNsDpsgjaNQER5rszVVs4BV2G/964PnwSY@nongnu.org
X-Gm-Message-State: AOJu0YyI8ffDhugSJ+/72D6KzWI27j7+vB3wqNe3CH023Daeq3QqWgWq
 XehmaIjq3CK+wukkc8xZyiEzWVcSN8fIXvOHx2zjlua64ZtopGRM
X-Gm-Gg: ASbGncuc6qyp2rx19Lnyphr6kJMuVCeNhY0OQqHBHLFDfzej/f4Jq/Ftrlt9PhQhuO3
 1ZzkBBkt4XY0oENXo9BEa8q0DbJtZGDzPphe3ailohtYV/jXNF3QjV8cY8EfYuqnUBCm58ASesG
 CHljQfOV7uQJIr6WWGlT0peabkjobRs7dRh3pCs6TSVxY5NuWR56ovlTgAZ/r8gMeDjzU8DzNHh
 z5DogxDl1Bwxo0Rb20+o7qoHBC6vYYzYA1fhZkdmkA82TeKDko9HMmbi8ZWrn9lleedJ+KcayWz
 eoECyntJYRhTJ4It9RnChEePxe9tB3x2s5w=
X-Google-Smtp-Source: AGHT+IGCnSDAyImxqaW3G6UJ5kujaSx540WZPoi9UoMBrd1f+hlI8WHTllY+g5oALRpyp7hAY2+HPQ==
X-Received: by 2002:a05:6402:5251:b0:5dc:584e:853d with SMTP id
 4fb4d7f45d1cf-5e0b72265e7mr10295342a12.25.1740322454716; 
 Sun, 23 Feb 2025 06:54:14 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:1283:abda:b08f:72e4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e0a0310f66sm6431580a12.81.2025.02.23.06.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 06:54:14 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 0/5] ui/console-vc: various fixes and improvements
Date: Sun, 23 Feb 2025 15:53:57 +0100
Message-ID: <20250223145407.259924-1-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x52c.google.com
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

This patch series brings several fixes and improvements to the QEMU
virtual console (VC), making it more usable and aligning it better
with VT100 spec. The updates include support for inserting and
deleting characters, better cursor handling and correct position
reporting. Without these changes, the console is hardly usable.

1. Support for DCH (delete) and ICH (insert) commands

  * Properly handles character deletion and insertion as per VT100
    specs.

2. Add support for cursor save/restore (ESC 7 and ESC 8)

  * Implements legacy DEC sequences for compatibility.
  * Ensures cursor attributes are also saved and restored.

3. Fix cursor position reporting

  * Reports cursor position relative to the screen instead of the
    scroll buffer.
  * Fixes issues with tools that rely on accurate cursor placement.

4. Ensure DSR (Device Status Report) responses go to applications

  * Stops terminal from rendering responses to the screen but instead
    send reports back to applications.

5. Handle `ESC ( <ch>` character set sequences

  * Makes `top` output look clean by handling the character set
    commands.

These changes improve the virtual console's compatibility with
terminal-based apps. Without them, the console is quite frustrating to
use.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

Roman Penyaev (5):
  ui/console-vc: introduce parsing of the 'ESC ( <ch>' sequence
  ui/console-vc: report to the application instead of screen rendering
  ui/console-vc: report cursor position in the screen not in the scroll
    buffer
  ui/console-vc: add support for cursor DECSC and DECRC commands
  ui/console-vc: implement DCH (delete) and ICH (insert) commands

 ui/console-vc.c | 174 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 156 insertions(+), 18 deletions(-)

-- 
2.43.0


