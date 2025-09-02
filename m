Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23B7CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQnb-0000xQ-5A; Tue, 02 Sep 2025 09:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnK-0000rg-2O
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQn2-0004Uc-Se
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:29 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45b8b1a104cso21161745e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818669; x=1757423469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZO8GkHAjAS9SCd/410xii2goyI4MjiXciEMBan796CQ=;
 b=mWrLD0Dc5/2Rcx8FOPStxW3sAg0irDs0E0EO5H8t1y1HKLSTO5/3spUUF0cGdRzE6l
 V3OHgj0wSbBNVagpSvpWikTNZRqg2xJEvZu3Xj6d28gn0OI8O1ss6xEE4nF+NRsRnDPB
 XEG2znT3eReN4S0QihMdw9iQz5bmzbBLNPaxcShb0zJBBIP+gnPyVlTD5QvY7qrj/zRJ
 JzpNSpqxoBfaxmPspJA+qHu7zDX2UXKzJqnrn8i91HYhdy8g59G7SHV7xdpd7t5FF9dk
 jso+y3DLk+JZVRLzDHhtKPkPkUjhdgfk5kicdZsCQr+hAcoH+v+taidNBGZyKCMVhhon
 g6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818669; x=1757423469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZO8GkHAjAS9SCd/410xii2goyI4MjiXciEMBan796CQ=;
 b=QTT0QylusVKCYcsVImVLjsyh1F0dIGOFF+kxInaXtQ5DhgXGJj5mDeN0OnnTLjeuEH
 zfE3wPRM4CvGED38NWcPwUsda6xioTCE3ajVn5PtyM39rmhJ9HBcZja0/5VWusPwd7Js
 O4N+NNLu4mixNaomdVcGJxGGJShUZh/MSau435jlaiwlLczO7xIfeZClQSevWCD/sZD6
 whJZl+4t5Tj/bzq1dy6WjSA9K+Doc03iCyv8ZWQVL1H7tJ+ZC8MtGwC/nbc2gYdcXJdc
 ZQgVRLLMtuS844/a2iWpsqVwdYFBREnX3KxfRlAJHK/LpjMPxyDFIeGYBwsIrzrcYdOV
 RfBg==
X-Gm-Message-State: AOJu0Yw7A+1bN9vNQx9Y9zmF8eyAYBuR6zHck/0/MY7l62IiIsj4gvUX
 LKTP71vGuH0TjNzdirdeWPQetPL80gg7dK6UclJoME9O1D5Tjw80JxP/tWOUJJynFX5aNsMBMKZ
 49jBs
X-Gm-Gg: ASbGncvHDGpGT1XHxOu36Kime9TURpGhsuo51yFluPn4HoWpDApVSVyclOClmlUd61K
 pgXpE282VoVJh3jH7WrIs9e89b9WtvRlwpj7kh7AeI97vEIVM8PTc327FW+3cZMdzczwnEsJKX4
 5dj8CotrwfnAyglQJvnbFrUvrHu+wCK6k6dNQU7xkYfXMGnrgspu09+OKuBwmANrObTXbTX+pnh
 HEykZoEEzubIhzZAJWQg+AnGjVYxeCG385gumkwLn2yKaQwzNVUKIv6Am2NYrPT5M5eQ6NOl/1T
 d+kIgyjh27LzQOjdjLgFGbEZ5gt9ZPfGSyCCm1fpKnVyUDO6uUtZJ5wsamZsu+taQCTN26Z0Qv8
 Y+3ETpnlQsntyco12W+wXI7lGtfLO3I8FxSM2miJzGdhf8xDSyUdGn+gkZOuyxas11WYwiCanUJ
 LFiRkdsPY=
X-Google-Smtp-Source: AGHT+IH8JY8CCrI4uIi4M+ZyCNFpGD+mDcK0OQeXubBdonC8cQv2Ja2TbLQkYu3JpiLMhVX1LpnGbQ==
X-Received: by 2002:a05:600c:3596:b0:45b:8a45:b540 with SMTP id
 5b1f17b1804b1-45b8a45b97amr62463075e9.19.1756818668831; 
 Tue, 02 Sep 2025 06:11:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0d32a2sm303454045e9.9.2025.09.02.06.11.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:11:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/39] e1000e: Prevent crash from legacy interrupt firing after
 MSI-X enable
Date: Tue,  2 Sep 2025 15:09:48 +0200
Message-ID: <20250902131016.84968-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Laurent Vivier <lvivier@redhat.com>

A race condition between guest driver actions and QEMU timers can lead
to an assertion failure when the guest switches the e1000e from legacy
interrupt mode to MSI-X. If a legacy interrupt delay timer (TIDV or
RDTR) is active, but the guest enables MSI-X before the timer fires,
the pending interrupt cause can trigger an assert in
e1000e_intmgr_collect_delayed_causes().

This patch removes the assertion and executes the code that clears the
pending legacy causes. This change is safe and introduces no unintended
behavioral side effects, as it only alters a state that previously led
to termination.

- when core->delayed_causes == 0 the function was already a no-op and
  remains so.

- when core->delayed_causes != 0 the function would previously
  crash due to the assertion failure. The patch now defines a safe
  outcome by clearing the cause and returning. Since behavior after
  the assertion never existed, this simply corrects the crash.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1863
Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20250807110806.409065-1-lvivier@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/e1000e_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 24138587905..06657bb3ac5 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -341,11 +341,6 @@ e1000e_intmgr_collect_delayed_causes(E1000ECore *core)
 {
     uint32_t res;
 
-    if (msix_enabled(core->owner)) {
-        assert(core->delayed_causes == 0);
-        return 0;
-    }
-
     res = core->delayed_causes;
     core->delayed_causes = 0;
 
-- 
2.51.0


