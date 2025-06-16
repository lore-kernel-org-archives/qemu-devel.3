Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C550EC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 14:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRAUc-0001ID-Td; Mon, 16 Jun 2025 10:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uRAU8-00016j-Ue
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:06:58 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uRAU1-00041S-2I
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:06:51 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45305c280a3so18286455e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750082803; x=1750687603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x7phbzrAcVyuXp2vszvsdZCmriphcffSkgR9/9ccTkE=;
 b=mgqijibzGr5OnC1XmAcUsnKnK7hG5RiAXWEvEZZI1kiRJe0LnkUuf671p1DuWSNeDv
 QG2bEeBl7pDC/qBzvrAEf5qiG8mzDPshhI+y208mwRJ4bojxGUyDtRtDndD9dPFLl3AO
 93G4PjzbZGBLHXIQmK2Czkvn31xbJmrKfIe2CL/qU38Jcx/O+ProFLuTJzx8CwCnvp1v
 /uYuETu1YG+z44Cx/GJSY/DuWHsccjBHohWYIxfsJKQWBFAkKsDe1CXL+wCTTDJl2FI7
 jLYpn502gFoMJcWFSBt7qCWeEzsh/H16D1sJKrUKveol5hDhma1jNlIj2lrN7OnJvZxY
 Je1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750082803; x=1750687603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7phbzrAcVyuXp2vszvsdZCmriphcffSkgR9/9ccTkE=;
 b=I92vGtRIuuTzMp7rdIaOyvyd4BdisjR4xQ7apdb6w4jWQs1rzSWJycRn6a+nOxc6t0
 I5b1raIAjgVxPQlfdbGEFP67VjuMfeONyAk+yDpaLjJmqiwWlb3PMZdGCz8oFLJp3k23
 qsXDXzWBIf69KHgI+KzpWVMb7juiYXW2+YjUqg2ldkoj54r5pjA/bP9/TGqvc5rfMVoG
 toRcU27etdHAyhg+kYgL6X2+SbDt9/Gfvq7UExd9nH7+LFWkaVnT8o077stXi9zMwNrm
 vuLaxNs+LIN+OO6VuEDJBNCxVfgfAV3p1t2Jkdz/JV+2z5L8BRrkWsPHQubiZRbLOSez
 +AJQ==
X-Gm-Message-State: AOJu0Yx7wU3CUJmzYZbILZdQw1OQ2GSPSKj6Qi/34zGovA8O/f4Zkh8r
 Gy3jXeGOsQ09P/BAMgEJzuM+cr6g1C/eeArA6kzvB5KZQXWq6vDTvsalgw7xIl5cVMcpXqaRVXW
 3H4px
X-Gm-Gg: ASbGncsTcSXkdOY5KTsR6SmIcfclJViqPtur4+cOxCzhyOq98eFKZM2WkTwH5gArOaS
 kO66poPy/uK11Tr87ogTgWWPiGYQwtRV+HMH8uacE8KhqELnYbC7SHoI/1Hmv5htZb91pk/ogV6
 e0xybt+nbOhp98WJZcZjwwmZaOHy6rtuKhTZdMQ0g730EOo2Z+jJHn0JTO73kvzylh9F0gSvYkx
 uS5wB/hli1/9yebLBcSmbh16vv+0JRmKtR3QfkngxMQw1aySy5tGslgRiFWDF7GpyWLCMfY12R9
 KbLPAzPFfw4bGEquY32afOjOg021v2oeRlMrI0HCrJFfrdCIurslnwbT9u931SRJiqLS
X-Google-Smtp-Source: AGHT+IEa5xjXpsFFzA3KKMBBUcCPoXdpiN4Jt5ZFICWxO6c4FcvwgHsoHMCPByWmTdgLddatwZUY+w==
X-Received: by 2002:a5d:5c0f:0:b0:3a4:d64a:3df6 with SMTP id
 ffacd0b85a97d-3a57238b99amr6410218f8f.3.1750082802777; 
 Mon, 16 Jun 2025 07:06:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e13c192sm146561975e9.26.2025.06.16.07.06.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 07:06:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 9/9] linux-user/arm: Fix return value of SYS_cacheflush
Date: Mon, 16 Jun 2025 15:06:30 +0100
Message-ID: <20250616140630.2273870-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616140630.2273870-1-peter.maydell@linaro.org>
References: <20250616140630.2273870-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: J. Neuschäfer <j.neuschaefer@gmx.net>

Although the emulated cacheflush syscall does nothing, it still needs to
return zero to indicate success.

Cc: qemu-stable@nongnu.org
Signed-off-by: J. Neuschäfer <j.neuschaefer@gmx.net>
Message-id: 20250613-cache-v1-1-ee9f4a9ba81b@gmx.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/arm/cpu_loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index e8417d04069..33f63951a95 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -363,6 +363,7 @@ void cpu_loop(CPUARMState *env)
                     switch (n) {
                     case ARM_NR_cacheflush:
                         /* nop */
+                        env->regs[0] = 0;
                         break;
                     case ARM_NR_set_tls:
                         cpu_set_tls(env, env->regs[0]);
-- 
2.43.0


