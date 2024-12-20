Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3BAE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfi2-0000rR-7J; Fri, 20 Dec 2024 11:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhA-0007nc-Oy
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:47 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfh6-00083i-Iw
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:43 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436637e8c8dso16512555e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711459; x=1735316259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgIsGldpmH/X/xAz278dVdYV2sNQ+kekRqlb3m012kE=;
 b=frbd7KxUlgHT6FtKTa0xfB8P+8ZOPslwt24ZXQWTqjPN101vwtHb+tDNplo+IezyNe
 ebFZzOIhllPW430ippGMUOviDk1KoM7m8Pkoq9yv6BACAz/Irkqz+qmUd3uc7sTi1IBM
 vTHJV7GCdiFHRA7sXdoiak7WARSLDUz930YNpN6v6KEybmv9KXD4N/K9r2Mb5cQ+84YD
 LafKDDiRq+Q8xHXQi6fvGFDyZV0QM2CLlGEBI3tr5PGlQAQ0BPtSALSQbejYH9CANT/8
 v6mtSjLU/PPoW3f9ETYBovTIV/hO2x+QooAF9ptxymERaBfajZKCo5UKC0rQ1A8bW6NM
 7oXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711459; x=1735316259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgIsGldpmH/X/xAz278dVdYV2sNQ+kekRqlb3m012kE=;
 b=O5D2s+4golm+RVsA+Tl8ZHACX0EqgJ2zYwCyL/jYDVlqMGvddO7XfOGqEwNu3H7D2z
 1lVs2LnJBIzBCWzQAswoe9vEfNeMS/pbyUk61HtuFBNW2L7T3wZnlXz7I2mhBAMrPF+M
 fkJHdllT/sDSHffgk08P+s9lcTmumCbszn18S36dNVpLlHeQ5eJNbVAnxn75DQip+rNz
 ud5R583mfgHZjemV7K/fPzBZv00efkLC/BrfrSgdTOCGXHCMEgGGef2avWlnjyNARBeh
 4NEaO4jmxFIlQBvQbiuR/bQyUjmcUidDO1zBy06xBkUvNITsKgCQyVOO9zmvwblniGxa
 TutA==
X-Gm-Message-State: AOJu0YzesurcKCNTtIoALttm4STUdeddJlXK5IWvJ/v0blo8E3TJMBt+
 59TmfGoVO90FHL9vAXnsPjX2OGG5XNQpsbJAgxwfTi00cB0dE48IxaAbwLr+DcEyFnJHuxDpQrb
 O
X-Gm-Gg: ASbGnctUnsvMEmuh+NR/mXKjV9E687PZNlWhaQVwhBia3cAknvXcn9QzfK5fHZKj7PS
 jGr5BGu7crBQFTjbywVHzLrqyrdlouvumqPldU6wHRS0yi8pJxf5KWnvISL9otm8hS1TLjt/0tg
 VOKASzm7Vd5zkeM16hGRFQWYL9twsRasL3+6b3CgX2edOmyR31+gAV+Eot/Ren1uaqjnV6Gzr4V
 k23FaTHN9gmETDmZvyObX29lhCNzSK4GvFJAWNd5KE7L7oX0UwglK/eiiVKXYbhqflH+2IyYGc=
X-Google-Smtp-Source: AGHT+IFec18UXpcxHLCil9HlQaDzMULGibl9zCcE67ncCk75Pzl94EFgPUtKfvss4xBzp4fN4gUuwQ==
X-Received: by 2002:a05:600c:154b:b0:432:7c08:d0ff with SMTP id
 5b1f17b1804b1-43668b5e079mr29485405e9.23.1734711458904; 
 Fri, 20 Dec 2024 08:17:38 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b11aecsm83210755e9.23.2024.12.20.08.17.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:17:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 23/59] exec/ram_addr: Include missing 'exec/hwaddr.h' and
 'exec/cpu-common.h'
Date: Fri, 20 Dec 2024 17:15:14 +0100
Message-ID: <20241220161551.89317-24-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

'hwaddr' is defined in "exec/hwaddr.h", 'ram_addr_t' in
"exec/cpu-common.h". Include these headers in order to
avoid when refactoring unrelated headers:

  In file included from ../../hw/s390x/s390-virtio-ccw.c:17:
  include/sysemu/physmem-target.h:37:24: error: unknown type name 'hwaddr'
     37 |     (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client);
        |                        ^
  In file included from ../../hw/s390x/s390-virtio-ccw.c:16:
  include/exec/ram_addr.h:52:36: error: unknown type name 'ram_addr_t'
     52 | RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
        |                                    ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241218155202.71931-4-philmd@linaro.org>
---
 include/exec/ram_addr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 53785cdb87c..ff157c1f42a 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -28,6 +28,9 @@
 #include "exec/exec-all.h"
 #include "qemu/rcu.h"
 
+#include "exec/hwaddr.h"
+#include "exec/cpu-common.h"
+
 extern uint64_t total_dirty_pages;
 
 /**
-- 
2.47.1


