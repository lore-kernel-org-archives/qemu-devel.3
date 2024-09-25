Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB33CCF9F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 20:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stYwX-0005du-0s; Wed, 25 Sep 2024 16:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1stYwU-0005b2-8T
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 16:48:58 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1stYwS-0006b9-KY
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 16:48:57 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2053616fa36so2576865ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 13:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727297334; x=1727902134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TPgjLd8ThMq5vhcmB5udYg4Vp/dcx2zmQuQ06G4BMHU=;
 b=wNzR6hiRDKhxtoKntOsrbkzcrzVPO+1OttlMGI9EnAk2pMEG2qTquDaqBUxJCef9Yp
 yZKOX+RWP4ZVAAOP59Zqgf1W8zuk4Uo8xuN8C4E4ZY3F35jq/FB3lJ1WVc7cAe9c7tc6
 QRM5cufrNtjEE8dPGKwQo73gBcIF54zKZ4nPniMEyhTPqtSxf3C520P9AxnMA49PsI38
 DhqnokTytO3tByhEAI+lwTe2a7y0OsF3KjUNKTEdMp2ORPYe3P3KNMaFiqa85u9rc0rR
 OZfpE7yUS/774uli+5qcQIh6Lx3mPwGkLPxICVmralptOt7ujg0AaN4gnETJHxNBwjWs
 FWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727297334; x=1727902134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TPgjLd8ThMq5vhcmB5udYg4Vp/dcx2zmQuQ06G4BMHU=;
 b=Nofz8ds4OmNOjftR7G/XJCB6yzF8Rnj3bIyjZalWUKMrSDLfJAO5O9ytcmpxkGxZfV
 deo00XBrGgzeUoLHBYHFjnnXCrdVy1gLmhDrTPLFBgxb4vMH/DlIC7fQDmCGzdXFEwkI
 wheXZjrbaMZRS7+r6i+l8E5DGePxZWsBrnWFny0gqnNjgA6/fB/RhpGf6DiTnrZS7xWc
 MVekdTRmydj4K/bFBU/1azB5p9s9ZnAExu5FptOfBl675AIGEyUvhMnD20PqBbchIBcZ
 YxA2M9kuj9Yxl+jmfThSiTzbFwLZtrSp0JRB871uMRbZLL1l81doISishSiLof4UTVxI
 /zeQ==
X-Gm-Message-State: AOJu0Yz1jptsUmCpOf14c9BvwtAArsEjHu47K7SOzviFGBEZ5LFp6nWj
 KkcLmbMiHQ0ukpz14226FrRGjZxeE/Sgb2/CMputO9kowbcyT/Fa+TbKkd+vvzknAHvn/oHKTmV
 SpneFAtNY
X-Google-Smtp-Source: AGHT+IFb5oiRQ08AlYGbDiOoZBl//a+DKnx1OTr9GASYSL5sdDycJmGHgpVnMryzE/Kjb7STP56p8w==
X-Received: by 2002:a17:903:1c1:b0:207:15f4:2637 with SMTP id
 d9443c01a7336-20afc3f8c67mr73108895ad.12.1727297333920; 
 Wed, 25 Sep 2024 13:48:53 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20af16e6ce6sm27991435ad.19.2024.09.25.13.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 13:48:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v2 0/2] build contrib/plugins using meson
Date: Wed, 25 Sep 2024 13:48:43 -0700
Message-Id: <20240925204845.390689-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Contrib plugins have been built out of tree so far, thanks to a Makefile.
However, it is quite inconvenient for maintenance, as we may break them,
especially for specific architectures.

First patches are fixing warnings for existing plugins, then we add meson
support, and finally, we remove Makefile for contrib/plugins.

Based on the proposal of Anton Kochkov on associated gitlab issue.
Solves: https://gitlab.com/qemu-project/qemu/-/issues/1710

Plugins are now deactivated by default on 32-bits hosts (since cf2a78), so we
can enable with meson without worrying of warnings when building plugins for 32
bits.

v2
--

- removed warnings fix for 32 bits as they were incorrect. They are not needed
  anymore as plugins are deprecated for 32 bits hosts.

Removed patches for individual plugins.

Pierrick Bouvier (2):
  meson: build contrib/plugins with meson
  contrib/plugins: remove Makefile for contrib/plugins

 configure                   | 18 --------
 Makefile                    | 10 -----
 meson.build                 |  4 ++
 contrib/plugins/Makefile    | 87 -------------------------------------
 contrib/plugins/meson.build | 23 ++++++++++
 5 files changed, 27 insertions(+), 115 deletions(-)
 delete mode 100644 contrib/plugins/Makefile
 create mode 100644 contrib/plugins/meson.build

-- 
2.39.5


