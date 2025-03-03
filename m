Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FB4C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 22:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpE6J-0002wo-Oc; Mon, 03 Mar 2025 17:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpE6C-0002Q4-8I
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 17:17:21 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpE66-0006qD-Sp
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 17:17:19 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5dee07e51aaso9265473a12.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 14:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741040232; x=1741645032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P2C5bY444RAXFC+JHaxctHOtS2ZX3yTKBDkJ3r0qbTM=;
 b=PvISNvmbFgq0sgEleRjobCS8vCDkIkIvtBwqGS45PqeNdz/4YfjHMSlGAZgUprBnEU
 21gS5piLNb56lYGKnVfYG7Il3GNUz8d30mlY9Fh3vBmcWQ8iZnbco8HSS9DEztQga7Kr
 x6SoVs9Sk7lHyuIua0eCg0WwdoCdk6b5PkrzWK9aqCyMeEqeQwsrUZlcdRSSQrwz/4/X
 X9dEfdwddj2dxIUjzzevXCq7P4He3Pm3A6fWCw6476Zx0RlLKRK/fxxGww2yxfm/KIo1
 HY4kRC7z35oETPa+LHdre5oQ9uumyZTi6NMub5YGYvflTU8qnWlu+n35z+BoeBnXQPAe
 8/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741040232; x=1741645032;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P2C5bY444RAXFC+JHaxctHOtS2ZX3yTKBDkJ3r0qbTM=;
 b=ons/NXUwKPhgr0TaMsNdCkQyIHjjqlReFqobKk6RJVJ0Lmp3RbYeCWXD25oYW1YMtS
 k87BSrmI5nASjNHxVRNmLiYWzBWIHisgn8GyUEOBI5eXmKnhQHHoqHB6U4S3IJVvZrIy
 +afB0HPTW07g5ARWmwSG4xXdLoLk9b64MsVmNCA54+3dqv0Wqz8EjDaQpEWIYWKovfu4
 exmBf3km6VLWK/bGaNaIjIgCWOpEaIwvBnZwnCMSdZSBem4mxRCL3dIiT+/glL2EMSlr
 ecifqC95/1EnWtV0/ZV7UlSt6APM23DutT3lZUPi5+OATxk7ffS6ghqU7LZUZkrKMAfE
 ricg==
X-Gm-Message-State: AOJu0YwCudxQkt1f7/JcPVIZavXTGzd6BIZ4fVqSrh8f2iWXJC2qUm1q
 iYAuVMhVFjZDqkLeyeBNTxFSICC3m+3MAA4sGm/krWUk6SE82EV/2YgF5RDDoRs=
X-Gm-Gg: ASbGncsoPP9UINyhJe2jXzsdxglHlKIw1AJ2rIc0I+Gh3OEUBgBaUgTFCfcUsSd5ujf
 1Ud6Yl/SrzR/UK+GajMJ8DE5zcukflyFhaf4Zcdett5IRF8AoNe4vprirbZfu4kEtkrUl/vUSVq
 yzfgMmB/vT8tr8NcLNij7XjR/G60ei9ocQV5DkGQU+jCD/XANpgsfwPG5BQ0xiWUpv2cIJN6J+o
 ZLryerPJrGopNito+D7wbNo4XX2GypfcOQAWV9NcIId3udr7opyfpS5na5yU8La89mrj7rnOOAf
 tRH0ScIEDlWSwMqCL+kKCTIxhyXuwy3+VJypjNsHgZU8wvw=
X-Google-Smtp-Source: AGHT+IGSxEB8R2yjCqXqGt+Vyfbyjhj5xuRsVTXTpiuboXadwMQScjlqLyYeZkYduTmh6KnlC5a+Cg==
X-Received: by 2002:a05:6402:40c3:b0:5dc:e393:af63 with SMTP id
 4fb4d7f45d1cf-5e4d6afa22dmr16285374a12.16.1741040231801; 
 Mon, 03 Mar 2025 14:17:11 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3bb5abfsm7248556a12.35.2025.03.03.14.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 14:17:10 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E6E995F938;
 Mon,  3 Mar 2025 22:17:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] meson.build: add -gsplit-dwarf to default cflags
Date: Mon,  3 Mar 2025 22:17:03 +0000
Message-Id: <20250303221703.1291078-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

This option is supported by both gcc (since 4.7) and clang (since
7.0). Not only does this make the linkers job easier by reducing the
amount of ELF it needs to parse it also reduces the total build size
quite considerably. In my case a default build went from 5.8G to 3.9G.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
RFC:
  - currently and RFC because it should also apply to test binaries
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 4588bfd864..a936d1b422 100644
--- a/meson.build
+++ b/meson.build
@@ -363,7 +363,7 @@ endforeach
 
 qemu_common_flags = [
   '-D_GNU_SOURCE', '-D_FILE_OFFSET_BITS=64', '-D_LARGEFILE_SOURCE',
-  '-fno-strict-aliasing', '-fno-common', '-fwrapv' ]
+  '-fno-strict-aliasing', '-fno-common', '-fwrapv', '-gsplit-dwarf' ]
 qemu_cflags = []
 qemu_ldflags = []
 
-- 
2.39.5


