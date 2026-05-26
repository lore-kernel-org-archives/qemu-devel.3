Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB976CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsm9-0008Cj-Ho; Tue, 26 May 2026 10:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsm7-0008CB-Ue
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:28:55 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsm6-0001CG-Gp
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:28:55 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-459bf19e87bso6313689f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805733; x=1780410533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/KgAY2h/Yy1zBpIiJ5q5I7MtIjIP6RET+61+dyCLqLM=;
 b=B119jlov/N99DjPXDPBTNzYNcsrnwm/kZnVKU5jv3iwwP6soX3NX7QDc7MAykhkixy
 QEIL0a8XudOHLvNxjeSPlHvo9vaZ/GF8hBXQJK29Hx82SvUWNjJN42hc+ah3rGNYH7zC
 HddDJaS/QlYlATLFTpBTL1XQv5+7fFoYnGPqMZIADlNmUHGPFv7ueUupHsSDt2vLIWDw
 dXztwY8kMjo77nxq2mwdLfFOpZx4XZ2IY3Uu/Dgb3/bmLEjlQgcjq+zOvsPrYIoujsR2
 c9Cjf+zGVFmMCuAgDV845CocwsBLNCzI8tYGo5avD12zBBPCifPfkp3c5KTH49sD0zfs
 meuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805733; x=1780410533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/KgAY2h/Yy1zBpIiJ5q5I7MtIjIP6RET+61+dyCLqLM=;
 b=ZIF8Exq5TfgzBd+rGZawknfaXFVNMpdevLmGT85/aWCulInUiG9NjSo0mbGKPkmMdS
 C3QCzZjBfdrAAApAjwu0VKom2zNrNP4tr5FPIUFgJOQH8teDKERJFkUQCwsOLCFwW09T
 B3KMFbK78ElZ4Q2w4AJbccznuEXzK67Vp9GyL1mQV9p24ovznwlz30VMTgKuXakPjv1+
 Aii4U0KnDrohIzPzIFb/8WPw4hUIwGIYwYY/E5498l3FuDB0HoKME1J5b5ecCuYK0dGl
 pX2k3F74YbqbBTZ0+GKV9QP9IToQgTGYuBJiI+EgCNVcVVVDK/TYOeIql+xSIJiS4pxH
 4HGw==
X-Gm-Message-State: AOJu0YwdYK9B0Q6CJufaB27BCHSZN1TPlQYB/ys8WIB9wga/1HZwU0Uv
 BKswrsDvawLmO+XpaNI12FwtWjbc8prjKqsxSosG1WSJnHBalWGSbjYWGzgI2eCmmnMr8w+aEGI
 ISGfc
X-Gm-Gg: Acq92OEPmjHNag9YW2qYybQlRBahjmdyjQIKrhsCbe10Fvni93DsFPSxqHJkQvgm8At
 CcIFWUTxItFgycbLDDvuqs/uoZGTUc7wJmvlumdEvt2KcjUywSinQdfOaGkUOH5UhhDTXwpx4R8
 A0+benaU6CWdwqp95ZFfXmY8gov8gW7YLv2d21m2KZQga84dUcSBziJ0uMgBjP0ZoHs4FZIZ/4k
 ok8vFd1SF69ZVDhQyQpSvl34XNA8v6UdJ7VjKorGDAUkwsQIlq6GVr2Ee/FBxVul9ki7UxcQ5AT
 CfXr9lQ62Hn7CgXI0ZLTjNj5VOqMx8dD4glT2YUleVTO0qXf9VFt0xgj1LgFkw52WZRvv+QsC8H
 0fNDej54yr5vAO58nIqQpn9/eMDxKMJ9xgsyotLc3aPM7zh6ZevtiQV3qSvWvGBcGKRc4GYqj5d
 L3qhcLKB+/9Wx6E4dgkNpFk7eCDc182+tCT0u0Ma7LSer72XZCi+ShnW4T/ML8HVi+586V5xP3M
 Ktk1fUDjSg45NTecXRrF7uTp/VfMR8=
X-Received: by 2002:a05:6000:26d1:b0:43d:7275:c1eb with SMTP id
 ffacd0b85a97d-45eb38e4a5cmr32654426f8f.39.1779805732965; 
 Tue, 26 May 2026 07:28:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.28.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:28:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/54] hw/timer/mss_timer: Remove dead code in timer_write()
Date: Tue, 26 May 2026 15:27:57 +0100
Message-ID: <20260526142850.2326589-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In timer_write(), we switch() on the address offset to handle
registers that need special-casing, with a default case that handles
both "unsupported (64-bit mode) register" and "can just write value
to st->regs[]".  However, as Coverity points out, every register is
covered by the special-casing, so the "write to st->regs[]" code path
is dead.  (timer_read() has a similar structure but there several
registers do go through the default code path.)

Replace the dead code with an assertion.

CID: 1613905
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260512134750.3543639-1-peter.maydell@linaro.org
---
 hw/timer/mss-timer.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
index bd3f3e845f..25fcf42aa0 100644
--- a/hw/timer/mss-timer.c
+++ b/hw/timer/mss-timer.c
@@ -189,14 +189,11 @@ timer_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        if (addr < R_TIM1_MAX) {
-            st->regs[addr] = value;
-        } else {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                        TYPE_MSS_TIMER": 64-bit mode not supported\n");
-            return;
-        }
-        break;
+        /* All non-64-bit regs covered by the switch cases */
+        assert(addr >= R_TIM1_MAX);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      TYPE_MSS_TIMER": 64-bit mode not supported\n");
+        return;
     }
     timer_update_irq(st);
 }
-- 
2.43.0


