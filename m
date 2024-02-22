Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD21C54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8cc-0006Zq-6l; Thu, 22 Feb 2024 07:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8cY-0006Wr-Bl
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:56:14 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8cW-0005AK-Im
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:56:13 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41282f05409so4658555e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 04:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708606567; x=1709211367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7XkfKPxz7eBX4abxuH9t9ZpbmlF01x5HTkfTXvGamo=;
 b=vXtxlrb8bhPU0SKRELbiri0A2XAfrAIi2rThuuhUBl0Urvq1I+Jv0rbULbW88fYNnk
 xfokphEGRlHVU2igZmjmSW8IDtqb16c5BBNicgoT8GnkrkQR10Ms+RlQg0plhxeW6s9c
 YIO0M2mpYarmGCOSht19B5aTi0Xds6hwrmOgR9Erm6DIOKd01vd3tqpiprQ7BYaZKHl+
 v5taCDjlvzhZxoPGWz7WqHCLo7KeWmASQvsuTyGpmpYn61GNiZpZeYW3+K+cr6kHmJ5p
 7L48sEXO6V3ufMxfERrb3EHkJRXh+tAGe8w2Wc5wHL0BbI5XhjmRiQWJE0Qd7xln2NJR
 jPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708606567; x=1709211367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7XkfKPxz7eBX4abxuH9t9ZpbmlF01x5HTkfTXvGamo=;
 b=TUaoUzVW1Daai0h5WlMYE5TbAqkr4HF0suP3jVlYrebTD7oDe+v6katD0uiVsk13N1
 vJMJLv8OagYE1K3oZhIyl1ASyZaCKGS953MfInNwKrgt/2yBli47Z5hMz+x8fUCTL+mB
 +Vkh2kQv6XDV3oiC/rON7J/0C1WGwc1ajpgUndxzKzaPhh9vCD9H7dUUcTsW+Ryf7XC2
 XZF+Of2BLQKHq5dCEsPzx3bMPWvoxEaCCQ85awFdfR3BPFA2LR4ndsR3HizrefPN+Skj
 VyfDoY20+EgvWrs5Ox+8sY+TAqDGoQSFfk11/FBofToXeT5i5FTtbygLWbcXMX5zAF2J
 c3NQ==
X-Gm-Message-State: AOJu0YxZ8OEMVI5kjmx8lbnLEu14WkpOG6LRki7aRxOtRiwYmLu+ng9B
 9Kq7VEMZgMwNLcEDlL9Lm0ah2LCBgQUEJCSwu8hWg1VEGB6kI56Bo8pcT4RcK/cwhwXSaafIvRe
 5iCc=
X-Google-Smtp-Source: AGHT+IEijIWXV7Q+slmM+fPSZSIDrDDYtHHmgpC8hhG0K4kqtO/pk5tyqILU0HPEn9GEUs8S/xrG+w==
X-Received: by 2002:a05:600c:3581:b0:412:6a78:d4db with SMTP id
 p1-20020a05600c358100b004126a78d4dbmr7395532wmq.14.1708606567589; 
 Thu, 22 Feb 2024 04:56:07 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a7bc387000000b004107dfa6aebsm5938919wmj.28.2024.02.22.04.56.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Feb 2024 04:56:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 32/32] hw/sparc/leon3: Fix wrong usage of DO_UPCAST macro
Date: Thu, 22 Feb 2024 13:55:16 +0100
Message-ID: <20240222125517.67131-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240222125517.67131-1-philmd@linaro.org>
References: <20240222125517.67131-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

leon3.c currently fails to compile with some compilers when the -Wvla
option has been enabled:

 ../hw/sparc/leon3.c: In function ‘leon3_cpu_reset’:
 ../hw/sparc/leon3.c:153:5: error: ISO C90 forbids variable length array
  ‘offset_must_be_zero’ [-Werror=vla]
   153 |     ResetData *s = (ResetData *)DO_UPCAST(ResetData, info[id], info);
       |     ^~~~~~~~~
 cc1: all warnings being treated as errors

Looking at this code, the DO_UPCAST macro is indeed used in a wrong way
here: DO_UPCAST is supposed to check that the second parameter is the
first entry of the struct that the first parameter indicates, but since
we use and index into the info[] array, this of course cannot work.

The intention here was likely rather to use the container_of() macro
instead, so switch the code accordingly.

Fixes: d65aba8286 ("hw/sparc/leon3: implement multiprocessor")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240221180751.190489-1-thuth@redhat.com>
Tested-by: Clément Chigot <chigot@adacore.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/leon3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 4873b59b6c..6aaa04cb19 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -150,7 +150,7 @@ static void leon3_cpu_reset(void *opaque)
 {
     struct CPUResetData *info = (struct CPUResetData *) opaque;
     int id = info->id;
-    ResetData *s = (ResetData *)DO_UPCAST(ResetData, info[id], info);
+    ResetData *s = container_of(info, ResetData, info[id]);
     CPUState *cpu = CPU(s->info[id].cpu);
     CPUSPARCState *env = cpu_env(cpu);
 
-- 
2.41.0


