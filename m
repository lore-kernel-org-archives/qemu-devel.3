Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40027C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 11:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbf2c-0006LA-2Q; Wed, 07 Aug 2024 07:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbf2X-00063R-8t
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:41:13 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbf2Q-0003An-I0
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:41:12 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a7aa4ca9d72so189183966b.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 04:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723030865; x=1723635665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QFpgURZ0tkwI1FPuzUY5cjRfiXp0qn3pznL4h57wlAk=;
 b=jfVovyU17gBnHr3DAzRJDSkvT44yWpxiybi7+relJlgBm+ccRTWvyv/K4q8aMcdxnQ
 VBBgPWqGJvyiv/khknzLFxxl+xz8lrv+q4P/cQdp3XMOqdhIuNSyBkJFym+FkGiqAN9r
 sHDXPnc6TRstga/oYWTVuW92cUc0KSeVqskzi3kD/lFXiy1oi5Mswu5DFdSFoYYLmHqU
 DQxxEJxr474kGXLR6MxR0Tvo0lHyrXdiGJLHvcTKzlVAcYUnvBAaKphX3k9RAYOXYWEJ
 +qF5wmZJ3r5FeJ2IvEN4T8mVpyBJSZtsf14AmktRD7+DljgxP1tJRJv5wwAE4115CkGA
 wvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723030865; x=1723635665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QFpgURZ0tkwI1FPuzUY5cjRfiXp0qn3pznL4h57wlAk=;
 b=JHpiBWpa/oXG0OPyxiaCug/r7tCiL7CsKFuDDj0/yZqqZC4nIPBkI+mEpXCzOzGXTp
 KtWg2NPIBeu1q/tj4WHf7A9lsxkCWNUorWsUk8tgLlwiuVky0ph9A1Bi2vheCoLmpCm8
 Bvo8yKyAOKEwYVCWBYVqECVHSfcUNQlupdi1PZ+1fN5Ni8LZASwLjknXHZ0JruXPS25X
 rPaCTz0izdim4mSePjAayNrJhMi3NpNoydkmcZpCTzALfEp4/J8I0O4+AJAq3sqLtqjG
 qp6ObxoOhR+4z8rofZj0yzIQOPq8R5PqEl0yFVRoIsyBfXxXXxOGkx3bzf+CRC2RDmx1
 dNUg==
X-Gm-Message-State: AOJu0YzNnNMpIqSOTifWethKoAjGGcWkWa2KDZZM9mXoTzHaH8mef5js
 nGlI4KwWwVDV9KklSuW+D41ZeNdm3aT4Y2xLl0VEZ9OSRXNgEhQC7/cBq7I+JCg=
X-Google-Smtp-Source: AGHT+IFWqnwelxxACwgKZF2ZT/65/pd51ZJPSK3RkMviz0QtOpErPBAoOM0WbSKuwYrxTF6zru4xoA==
X-Received: by 2002:a17:907:847:b0:a7a:9f78:fee with SMTP id
 a640c23a62f3a-a7dc4e282e9mr1437551166b.17.1723030863985; 
 Wed, 07 Aug 2024 04:41:03 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec7173sm628254266b.204.2024.08.07.04.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 04:41:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E2E6F5F713;
 Wed,  7 Aug 2024 12:40:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 0/6] A few more fixes for 9.1
Date: Wed,  7 Aug 2024 12:40:53 +0100
Message-Id: <20240807114059.2339021-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Nothing major here.

We have a tweak to the Makefile to properly trigger re-configure with
new python dependencies. A number of tweaks to the GDB version
detection for MTE and an update to checkpatch.

I'll collect any other misc patches if they are pointed out to me.

Alex Bennée (1):
  Makefile: trigger re-configure on updated pythondeps

Gustavo Romero (3):
  configure: Fix arch detection for GDB_HAS_MTE
  configure: Avoid use of param. expansion when using gdb_version
  configure: Fix GDB version detection for GDB_HAS_MTE

Philippe Mathieu-Daudé (1):
  tests/avocado: Re-enable gdbsim-r5f562n8 testing U-Boot

Stefano Garzarella (1):
  scripts/checkpatch: more checks on files imported from Linux

 configure                          |  8 +++++---
 Makefile                           |  3 ++-
 scripts/checkpatch.pl              | 24 ++++++++++++++++++++++++
 tests/avocado/machine_rx_gdbsim.py |  2 --
 4 files changed, 31 insertions(+), 6 deletions(-)

-- 
2.39.2


