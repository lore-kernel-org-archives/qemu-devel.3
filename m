Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D6CC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 05:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA0kt-0001NQ-28; Thu, 23 May 2024 01:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <artyomkunakovsky@gmail.com>)
 id 1sA0kl-0001KS-F6
 for qemu-devel@nongnu.org; Thu, 23 May 2024 01:12:36 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <artyomkunakovsky@gmail.com>)
 id 1sA0kj-0000hZ-GU
 for qemu-devel@nongnu.org; Thu, 23 May 2024 01:12:35 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-51fcb7dc722so1486991e87.1
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 22:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716441151; x=1717045951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dRRwsbsmD/CH7MCpG8Hp44VC5MjZt/xy5HPTsFlXgYU=;
 b=Wsfq92lTxYMaGvT0XD+krKw86i6hYAZSONV1AT6/NWlNxiPWrbdXHi1T8IncEX5xk+
 cY+jqr3nNEEOP+j2+4E5q7L34Hgk7SGkWf/RbmOKlhox+4EaqMoHxfrgy8JYvjOrIJM7
 Cu8F712IJrS04Ndw8OGYCSdxNQlbWkftAoAsvAzhL9KcjmZVTDuhUv8E5aCkhmnEZBSm
 G32pI5G+u7AANZwv8arDlWWqdBVDCMcbzMjGyrPhGMis/jgXxXxMZ/nOYzqXuoF9pgt3
 O0ySsWv0Lzt2MNy288Nwr7qIM+ZhmYjWtjwKvmWCVPf5VVofPl8NgUb2hCQ/IlTZHr95
 IF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716441151; x=1717045951;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dRRwsbsmD/CH7MCpG8Hp44VC5MjZt/xy5HPTsFlXgYU=;
 b=RugynePdXZtWID17/X1c21R/m/2x2UrFRZ8iwEiDjMpI6R4LPFmxpDuLuXxA3DdTPN
 lCMPt1m2b6jH3ENW1Fh8TaBt6h9kMfeS2QF5i+xOaVY9o9HBpP4MvAgmAhCwX929RemZ
 Zag3gt2UjiC9VkiH5f3g4Vh2D7ns5pcHJSUTwy/rEhGHu1bCNLqVD9kr6zsLvjDaRhE+
 cvpiNr6gQfornhVV2Ml8EKb2fk+x31kKcwBUrvAjo3Fbrw1IzxBDzzgMsx7APEJHzLEu
 My1v95H2yxMng1mDmvO1wyDSRzC0OFTqvEI8NRdzOE5gJpTpSsvdGpX2IJQ/O0F2T4v3
 8tyw==
X-Gm-Message-State: AOJu0YzqwZQgJybINxwuS6JbVYyUOVaY5uZDzsN8Yv0mTHx7zK6T979P
 6m2KSmmHNaiNGzTBY8O9sMlzwPlJ58WU7/AlBka38f9e+jA0Iz4qgpZonPlf3D4=
X-Google-Smtp-Source: AGHT+IFp+TzBjE1REXuUVauM/lmHfKkMCnikHLM4MOTFiDldPoeZh18MVK37Kny2haFuWfBmTEXDTg==
X-Received: by 2002:ac2:4daf:0:b0:518:9762:500e with SMTP id
 2adb3069b0e04-527ef0255bdmr286080e87.5.1716441150773; 
 Wed, 22 May 2024 22:12:30 -0700 (PDT)
Received: from localhost.localdomain (95-24-211-236.broadband.corbina.ru.
 [95.24.211.236]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-523b7860398sm2554482e87.117.2024.05.22.22.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 22:12:30 -0700 (PDT)
From: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
To: qemu-devel@nongnu.org
Cc: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
Subject: [PATCH v2] meson.build: add -mcx16 flag for x86_64 host
Date: Thu, 23 May 2024 08:11:18 +0300
Message-Id: <20240523051118.29367-1-artyomkunakovsky@gmail.com>
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

Fix linker error if the project was configured by the './configure --cpu=unknown --target-list=riscv64-softmmu' command

Signed-off-by: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
---
 meson.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/meson.build b/meson.build
index a9de71d450..e68fbfc662 100644
--- a/meson.build
+++ b/meson.build
@@ -336,6 +336,12 @@ if host_arch == 'i386' and not cc.links('''
   qemu_common_flags = ['-march=i486'] + qemu_common_flags
 endif
 
+
+if host_arch == 'x86_64'
+  qemu_common_flags = ['-mcx16'] + qemu_common_flags
+endif
+
+
 if get_option('prefer_static')
   qemu_ldflags += get_option('b_pie') ? '-static-pie' : '-static'
 endif
-- 
2.25.1


