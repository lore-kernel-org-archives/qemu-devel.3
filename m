Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588FCC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA21-000184-H3; Wed, 17 Apr 2024 14:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA1z-0000x3-NG
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:16 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA1x-0003U0-U1
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:15 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d8863d8a6eso910581fa.3
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378551; x=1713983351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqXKfsFzG8GoX3EjCJAOwlqA9OuB4aRKiAFifCWZKos=;
 b=zTVXbrXfC7Tq/z6t08jKTwC+JbuSfKihN4QbXDp/qxdlMnRqbAgbyFpJUe5OIJSVBj
 APCecbDQkkdVB5JkB8fKDr2k426wRVM4flj1Ww0Df2uUcPDpN/OJJgeOjau/8+B93Hlt
 L/KknP55XV48eI8wC5RDbvuc0E3hTN3hw66zdfMcFBX8HJ00by/OkeJBxqgm5SX4zPDq
 tGKORfrCn7vxaVOhvxs3G/+I03PcwKV1M520dpClKI/AoLj9oBfKeOuk1y16Qhb5+3qJ
 DFOMPwAJ+5G4T1mgtBNb5KE9RCLXRs13CD5t1GtCigsb9YfOVgJ2AhYysC5mgmHxfBuB
 rujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378551; x=1713983351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QqXKfsFzG8GoX3EjCJAOwlqA9OuB4aRKiAFifCWZKos=;
 b=iEtwoHHQx8PiXj25l58A7fQ594MulqMEYiy8kFk7FovujVNxs7u7/uxvTke1dR6CQP
 hbTl/8wNOFSHtEZJL9chUj7vZ5kto3/NmhRvDpMmtGqQ4cdRgT6SEtnxJJG5DR9FCppX
 5QimkcGf1qxoURoyoOpZqoCEBOpX70Mb1LIMjHnz9kAc3gqeE4xKiE5vuMyLB0OoZUO9
 hJqhdVWTs1Arm4etdGdb7rms/Gjfg0oXiYaQB3i6ySyC+mHPd1TR9obtLhFZbpvcX/Ho
 T0Kn+pdgPZ/5YMj+U/mJn8cMIj8HddTg1+MV3ueHOy99MTV6eyoFR6oNjrI8sNXttHOX
 C72Q==
X-Gm-Message-State: AOJu0Yz2iRZOqYcFzkgaioNWiAnXzlWXyrCuPYTabKEQX+gRq3U3kbxh
 upuuECQScR2zPXs6e8eK6T3BJxz924Epn5FGeEX1FxzkJfYQ/KSucNOKHXfvdvUOoCpABRADO+v
 g
X-Google-Smtp-Source: AGHT+IHYpNrLWSILufQmAMMDd75KgDtBEEouJSWnUGphvB0OwmgOExPmQTzSdWzRFGFlGEZQ5VMEYQ==
X-Received: by 2002:a05:651c:607:b0:2da:a3ff:5254 with SMTP id
 k7-20020a05651c060700b002daa3ff5254mr88382lje.1.1713378551636; 
 Wed, 17 Apr 2024 11:29:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 u24-20020a05600c00d800b004185be4baefsm4533274wmm.0.2024.04.17.11.29.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:29:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/21] exec/cpu-all: Reduce 'qemu/rcu.h' header inclusion
Date: Wed, 17 Apr 2024 20:27:56 +0200
Message-ID: <20240417182806.69446-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

"exec/cpu-all.h" doesn't need definitions from "qemu/rcu.h",
however "exec/ram_addr.h" does.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231211212003.21686-17-philmd@linaro.org>
---
 include/exec/cpu-all.h  | 1 -
 include/exec/ram_addr.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index b86209fc49..586dc56d9e 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -24,7 +24,6 @@
 #include "exec/tswap.h"
 #include "qemu/thread.h"
 #include "hw/core/cpu.h"
-#include "qemu/rcu.h"
 
 /* some important defines:
  *
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index de45ba7bc9..3fc83587c0 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -26,6 +26,7 @@
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
 #include "exec/exec-all.h"
+#include "qemu/rcu.h"
 
 extern uint64_t total_dirty_pages;
 
-- 
2.41.0


