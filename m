Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82985C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkXE-0006ud-Eg; Wed, 06 Mar 2024 01:13:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWk-0005TQ-Sl
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:13:24 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWV-0006IS-PS
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:13:18 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d7232dcb3eso48111725ad.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705582; x=1710310382;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5x59V7N2Snccc4Fu7ozWsaURAyB+hFzG8uxYs6vkbiI=;
 b=EZymIPUZ6B9CN35WktRTniw2euQInpVvwOLaKoymtDZ4q/S0+fHyF0FKRi9ijPW55O
 7mPGdfFyozlW61LlBtwszka6KWhLzPkQZmoDfB5omnRYAY7sKqr+4GZQDuxLeI+wmXx/
 sLfIbvvHjMkgVWfUTg2WqbBcKmAPnpgnoGmL3w3ARIk70dN5V+6J6CFhoPdAZAbEhonp
 c+J+X8m4cARZ1pvhu4II418L91pgCt808QiMj7U476HA3TskD8WXs7gQDCoKPfduZiJz
 Vv+sRdKoQFXZeW/LlXdP4HzCV6IWb0qwiayoO5w9Gj4B7S+bor+4l8SKzz5QAikfMQT0
 PbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705582; x=1710310382;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5x59V7N2Snccc4Fu7ozWsaURAyB+hFzG8uxYs6vkbiI=;
 b=WYwuoOj7/g3xUNtaqGqnuJxGPVrTKTg/EiAIVjtVdyu/zYQ3/20MIWaGYZXHKQGKph
 ne9I+7RYGEQQXy06uVpaNCUZBLKjrJuJXmWMDJh3N95Bf2Uzbv2M1idbbC67HW9Wq4C0
 IXFfJUJNP8Nv/plNyRvC9uj3szDgXvjUsWcJnyv2AbPMuSw1N9RuO56L+jZuB77IDAo8
 E3dxU/6CX+ViO+UT2Wd+DGX1dLuJUnpCJwWl+BsW/dMPoOdCSW+Sq9zZQ++T02VAXjwJ
 8KblsWRV0vlaiwUqWTNe5rbVV8520IejqakjmPESIhuyilQz0v8a6bDjtrWZxhWkpe4Q
 2I5Q==
X-Gm-Message-State: AOJu0YyLXT1FJni4dja8POw6ffAK/qfahU/ttkb7/4Y7VhF0N5pUOs+A
 7elP0GfzOD2B9yI+WeQLfSCLMKJZIMB5n33e1L6CgKOJzQjzTe7IaEnvK2qnQfg=
X-Google-Smtp-Source: AGHT+IFeyWe0XVm+dq5BTaZLncjWER7BX46F6Lw0ouHAnCAlp3Otus6gcTxJkh8SG0tBW9hWqBbuKA==
X-Received: by 2002:a17:902:7c92:b0:1dc:cc09:ebad with SMTP id
 y18-20020a1709027c9200b001dccc09ebadmr3294534pll.28.1709705582485; 
 Tue, 05 Mar 2024 22:13:02 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 z17-20020a170903019100b001db4433ef95sm11634125plg.152.2024.03.05.22.13.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:13:02 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 06 Mar 2024 15:12:22 +0900
Subject: [PATCH v3 16/19] contrib/elf2dmp: Build only for little endian
 host
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-elf2dmp-v3-16-d74e6c3da49c@daynix.com>
References: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
In-Reply-To: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

elf2dmp assumes little endian host in many places. Build it only for
little endian hosts until they are fixed.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/elf2dmp/meson.build b/contrib/elf2dmp/meson.build
index 6707d43c4fa5..046569861f7a 100644
--- a/contrib/elf2dmp/meson.build
+++ b/contrib/elf2dmp/meson.build
@@ -1,4 +1,4 @@
-if curl.found()
+if curl.found() and host_machine.endian() == 'little'
   executable('elf2dmp', files('main.c', 'addrspace.c', 'download.c', 'pdb.c', 'qemu_elf.c'), genh,
              dependencies: [glib, curl],
              install: true)

-- 
2.44.0


