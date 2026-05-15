Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2DCCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzy6-0003mC-DD; Fri, 15 May 2026 17:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxr-0002z0-P7
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:01 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxq-0003Ay-8Z
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:59 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dea1272943so204332a34.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880057; x=1779484857;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gFqYuCOagyvuZh2S2MgIc7F7ETVXOjL3dAQdh4ur94g=;
 b=zmU2k7YKHZEAMVVrb8g0cSQZk1cR66CovpLa8lxNODqBtA3k33EyO2A8P8gJXvhg61
 vhA+JCk48k8sx+GC68RumsB6cqMzVngpF1oMX17Yt/yI79tSPFaI31OroOc823XSLUaM
 acsFHkoNPLDTTxfgHPFEiaphmBMGGqd0irLB1/nEC0ICRDmS4a5Gp2PCSNb9iZoJ5rHp
 aGBcksSpbfpyN4d1bMZ570OqiaRNV9TURAnxTEhhTWBtk8QYq/RRwybpBSeFcrSkTGEP
 f58AAPO4B7pr1xyyI1fBC8EtKDZoOeYI1BvpiSCCU0KH7Uyca5lYFWALsn/1jPp+7Xwz
 Nqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880057; x=1779484857;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gFqYuCOagyvuZh2S2MgIc7F7ETVXOjL3dAQdh4ur94g=;
 b=CSK3o4lmcy6At0qAEmCVG7z0i8heONAGvIWJWUeLO/TyWwH3QjAbFciRSeDqLx1RA8
 6BzaIbe50MvIz/d8TbLRT4QKqHrPr5LLs3hN5MRzd+Rclwpb3KttNhdWKq/0GdEEbHFT
 NiD58FPHHbEaaZWij0mz22X9xDNpHYOh06SqqfebZqBRjBDwWnNvPkWt+IUkR6xJE3GQ
 pK93zjF1LAePoHtCtfiECr5pdc4QmctEH5Up9aNRaewFwV56Xlo9HMGWSihjeRIb/fBd
 tBP7ePzXO5nK9qg9WLd8pD1kqOyNIPezEqSMEa5X04IQIoyfwMAHJU8ziZjQZS9FaPPu
 v4gQ==
X-Gm-Message-State: AOJu0Yzu7Zzsfo0cxvG/O08lMRpnE39zNM0zLfpttWXg/QLDSlHJhPVe
 aDApy/KUZjDysabz93n0SwySx5xXXYdRibWa575qHdh/l/MSFOZvdTEebLt1frse7gd4FQJTnSE
 DBYD1Ehs=
X-Gm-Gg: Acq92OEyWTmUhwXgjnCIEdkIOiOxCJIW2btIGNi2Zre5TbDofRoQIC8+JKbyqIzJaOv
 Q9Z9KQwF80O3VSUsP7/ubibYRzl248btKY3kLmH2LoeyQI4CTL0J5rHsdK1l2rsc57uPKfOO1WI
 FJHj8oIo0OoDi3V3CtCWIJ20IjP2TuawPH7MkwW+o7TwFL57621it7YXcfWE0bD20sxDdJCOfut
 HCO9TWghwAr7n0m9Cm4AqJpRVNF5BpJUpdQ4qaPovqnl9jEK6hKoGDva/WAGmX3G8pHHb/tB96K
 YXMq0TvPk3fcIUEmCeDkTMBcwpkxWtHBZLLLYnRhtfj2rkF7fE9APpz7zCfYpwCloRMgQsgkLv8
 GJLJuN6xUE3uMrgzC9OW/Js3XXmfaclGm8M/OyTwmzVoPCh4RRgLC+GLvzZnDKghXazI8L4SFYz
 M9v9tMdevXow==
X-Received: by 2002:a05:6830:6119:b0:7db:a8b7:c565 with SMTP id
 46e09a7af769-7e4f2ba838fmr3518293a34.20.1778880057040; 
 Fri, 15 May 2026 14:20:57 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:56 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:52 -0600
Subject: [PATCH 53/66] bsd-user: t2h_freebsd_cmsg use host not target
 values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-53-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=SpBKG0tv+Wg5C/eSskf9s7B8l9J2QHCroTQkYqI7CPo=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43nW4OyvH5ai85fVB6a46/BrDMTj6kvapFNx
 8MrO3z7v4CJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5wAKCRBsHNEofbAR
 AGUQD/9U+AM+CtF2R1apArL1HcvG37DhtZdJpKUr6PFlEUzEUdrLB4BgRoRtFRoJsfXJ+IHEEuw
 S7315FUDPFuRbdJWNYcG/NLDWe4HExaeY0ImJgYC4r4Ywo6q8lmagD5D2pAiNwW3uZIj/QWdc1m
 FJqF8gGLRMfk9endqi7l4hZZE8yMXUtyYfIrf+i1I0xMFkMICrlFcrd19JjczKHs7fY/xCrd+9Q
 Sz5btjhf3K7wGpeDKOHwO4+on3r4J1SAzqVijSE+V7qd9IXCVOh6DpOMaN2Na+TtSRCtalWrJu+
 0weVXWVTzwhyZL0Tm6PtVpLIhCN5NAVkEESS6eW7RRwDq8VjMWcR9nu8C0TsT+xyB67pgkvy3yK
 lkcX+Ebv66OBY1j8ov/MI6BTffake6QUoSZaDjuQGZ0tUpC9MUeGC+mH/SIRBh2ZvP+H32t9gys
 bzhbEOAJWl3tVskmXQvcvn08F/AQGM1lqPjkF1a6oNCgue45ZiuwLOsKLULM5BxhuG1wQXBJ+mx
 im+R08lJy5vgYkKSyoCmS0Fjpl2nkib5o/3xS9E2KbS9AotmxGy44nkf0NLM9fYksbOyW0cf5jc
 Mr6G1XrUCDakHgbBbqBnzkpvTl1PxtTlmlC6VxBA9w77svta7zwgE1mGxliSq4gMxtGv/pApugl
 YbZOFjooEtqdZVA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

At this point, we've converted to host values, so use SOL_SOCKET
instead.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/freebsd/os-socket.c b/bsd-user/freebsd/os-socket.c
index 41e40d2913..968929c2fd 100644
--- a/bsd-user/freebsd/os-socket.c
+++ b/bsd-user/freebsd/os-socket.c
@@ -72,7 +72,7 @@ abi_long t2h_freebsd_cmsg(struct msghdr *msgh,
             for (i = 0; i < numfds; i++) {
                 __get_user(fd[i], target_fd + i);
             }
-        } else if ((cmsg->cmsg_level == TARGET_SOL_SOCKET) &&
+        } else if ((cmsg->cmsg_level == SOL_SOCKET) &&
             (cmsg->cmsg_type == SCM_TIMESTAMP) &&
             (len == sizeof(struct target_freebsd_timeval)))  {
             /* copy struct timeval to host */

-- 
2.52.0


