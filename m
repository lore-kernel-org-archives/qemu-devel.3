Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E00C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 20:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9saO-0002T5-Se; Wed, 22 May 2024 16:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <artyomkunakovsky@gmail.com>)
 id 1s9rgw-0003Mq-D7
 for qemu-devel@nongnu.org; Wed, 22 May 2024 15:32:02 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <artyomkunakovsky@gmail.com>)
 id 1s9rgu-0007zE-RY
 for qemu-devel@nongnu.org; Wed, 22 May 2024 15:32:02 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5238b7d0494so7232308e87.3
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 12:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716406318; x=1717011118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TABqV5T2t3RKORy2VS7Usom+N/dlnNihPEJCE5uOdAw=;
 b=GSURl/EaEue/veCXSgWdXQ5SfsdcealQ05EhmsQdx/rFkuqPTMjgX0Jk3yY8YRGQDk
 YO+pIebferl15MjHU3x9Lu/1dlMWo54aypZwbz/eOo1qYosfAvMm9BA4jCVen4IunIz8
 IY9tUbuJvM+/CLgX+B/2+ElXpJ5brjyq04eJQHTaH5uhYBMA0Upg9D+RmqHIfoVIsfgi
 90DpnT3RD+jfzkVbk5um1iwQz/uh8OrSflHhWoet79NGzAonbTZrj+qNQkFFljCojRe1
 v5IfN1LPPMXd95OG00qAtZ5/uJfmS/3kNoUJECg/Ms4YQMUCyIa8It2C2P82pf1olsWr
 oyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716406318; x=1717011118;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TABqV5T2t3RKORy2VS7Usom+N/dlnNihPEJCE5uOdAw=;
 b=F/yzOuXj3hSphTjW+/qcQ4XMcbkYOqXmT1mPFQF8TrNBTHa+wWGpZktbdYIH8g8mFf
 eeV3DdZ9bTb9oK7T3WnaPZwvJgYyiny00om2+Ey3SPkyrgbuY/XfOj0o+yB2fqzfSGRA
 WDSxbT3hxeZvEtcppmYmmVAXx8jEiY2Zjg+8RH2ko2+fH3Ii3R3CXpYIIVSfV3CbwNFb
 iJe5XRgiNdiXy35SuFQ3B4t/5CTBMaV3Eo3TkUOpJY06NP5G1kApM8d8xiMuSQqS66OG
 pvQsBhj8MD6B0rzR53o+GilYS8wPSFXGTS+Xjo4rkwypHadEB4Y8enaU5JAQJaXbKepW
 fHyA==
X-Gm-Message-State: AOJu0YwoXzY4nN58ELPzsIsHHOpCwpGdobj/9DEeMjVGq3iDXiDYjoF9
 YIl01mlFE2OY7E93s0o4EeH+vbiSXNDznGfUZbzCOp2o8oqhhu8fTiedBSZyv7M=
X-Google-Smtp-Source: AGHT+IEHNCy10WkiBH7pXxn3r97kOILgJLKe6oQU07c+hgaTk1A/YFU3n4jTD7Koq1Nvxw1h6ecpbw==
X-Received: by 2002:a19:9119:0:b0:519:611f:df49 with SMTP id
 2adb3069b0e04-526c1215307mr2406836e87.69.1716406318348; 
 Wed, 22 May 2024 12:31:58 -0700 (PDT)
Received: from localhost.localdomain (95-24-207-69.broadband.corbina.ru.
 [95.24.207.69]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-523939e636csm2786360e87.93.2024.05.22.12.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 12:31:58 -0700 (PDT)
From: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
To: qemu-devel@nongnu.org
Cc: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
Subject: [PATCH] meson.build: add -mcx16 flag
Date: Wed, 22 May 2024 22:30:16 +0300
Message-Id: <20240522193016.136866-1-artyomkunakovsky@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=artyomkunakovsky@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 22 May 2024 16:29:14 -0400
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

fix linker error if the project was configured by the './configure --cpu=unknown --target-list=riscv64-softmmu' command

Signed-off-by: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index a9de71d450..0c24878c86 100644
--- a/meson.build
+++ b/meson.build
@@ -298,7 +298,7 @@ endforeach
 
 qemu_common_flags = [
   '-D_GNU_SOURCE', '-D_FILE_OFFSET_BITS=64', '-D_LARGEFILE_SOURCE',
-  '-fno-strict-aliasing', '-fno-common', '-fwrapv' ]
+  '-fno-strict-aliasing', '-fno-common', '-fwrapv', '-mcx16' ]
 qemu_cflags = []
 qemu_ldflags = []
 
-- 
2.25.1


