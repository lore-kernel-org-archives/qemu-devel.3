Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B90C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 18:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKq6-0006JF-50; Sun, 09 Mar 2025 13:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKq2-0005zV-H3
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:22 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKq0-0004uf-St
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:22 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39104c1cbbdso1652098f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542799; x=1742147599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kJwfrdswVmk/LMsQRUhZo65LUrcnqQS9NNFjSZtvKz8=;
 b=qUiLJmvnxovEZ2DgAwZhUOucwKsgK25n3AQWIahtXVW3EUM7+Tk1EtzCeMVLdrDJw0
 9Ynab2cyb2yPR5uLI/o0kLwL4oKWPV+0xP+uaGnk0okgo/8XdAgk5hFHQx33HGfFNpEZ
 EYWRizH+n3L42xQS+91WHupP2LLPAFEnW4JuvoJtNZvbTaf5M6V2ukKEdgIru64J0UzU
 ZxP5oiMcTXumiBlOC7h/isA1Gydts+upATOc8Ama9Oi5PAoBaMeOaDz0+6E1kQB1/CXn
 v9wiEu3AxS2/aw5rbmNzswIjMypnToP4g7Zzqxu8y2d4Jh+dlds1GIi77Xv3LwH1pZID
 bzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542799; x=1742147599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kJwfrdswVmk/LMsQRUhZo65LUrcnqQS9NNFjSZtvKz8=;
 b=LtRO+Mpc3VLclvhETIdS6eGCed80rrJUJvNodTc8kuMEQ76yo1LwrRWB6AcW3zXbuF
 /o+dhJdWQzSQwPthz0LSK+Pc5R2juuYtFwRVZASSTNxMzemIO+t8Np8Xoa523fskkrny
 7tIMcn/ZJCAtnQfWTtGWKYKs40XfvPtC0TvubvWUon2faK4+E0ZSF3m/gzADjEFJ2AYc
 H0IW4D+nB2pauX7nB7n3m753Eb2UpIU8MckaKSL5PtL0Vp2BLtkWGAJt+CzwQmPylnBU
 6nSL9tId5so8QRZkEv/im29umpumQJodSQ8VVOJ1hi6RBWCG+ePHJnDOtx53n5bHYUJL
 9//A==
X-Gm-Message-State: AOJu0YxJ9EFbbXvM/t6BlDlkM1Uio69x6zUR3A6OaVt6K1NBTUuLgtEQ
 3pGQVwfrMJYYjNOqvkYomr4/9FqdvF/gWILMEfGkRjw5fIJDAVcN6QZWJ9RksuG6SZB2ghrkfr4
 agj4=
X-Gm-Gg: ASbGnctmKTA23lX2id8VdaNwjDCmXRslVfsPmE4Ar6RpjoxsmnzQu9NxXNJou9eC2iR
 VDTAj1HfsyM16vkfSLPwVOvz8eIX+jZlWvhuouwCiAIRujViVZ/8578/AvAqCQ55eUGUbuQJfwA
 HlTz+LAvekUiG2rvAcerMNEeRcwx/jDM3EPCk3Hk3tPUOhGZfSSuKbJ9BMLfK9eV4aspjOGriW3
 g44fXWpix6/th3x+LPR5nV1wTiv2W6/f00tTfjPQIQ+RHmu6bIBV1yVHRFhH4YpUU+AxOo8uo/R
 cOJYlIhUscBdCCxZ1hUYMQJA/Xcr/6ZQc64C1UA+KiJVFbcx0ks9dxwUuFgw3AMOyKTtyQpm9sx
 mrLvDRYWhWJUsNg+jHXlrJZSrhSbRGw==
X-Google-Smtp-Source: AGHT+IFj7MlJ3IXyXNZyZR/J0GOE21ra2mEaKB+08tr5d3uq/PFrRliq9IE3yeOCgZfddOvBxLyUIA==
X-Received: by 2002:a05:6000:18a3:b0:391:2d8f:dd56 with SMTP id
 ffacd0b85a97d-39132d98ea9mr6501853f8f.29.1741542799089; 
 Sun, 09 Mar 2025 10:53:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e308dsm12701851f8f.67.2025.03.09.10.53.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:53:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/38] cpus: Un-inline cpu_has_work()
Date: Sun,  9 Mar 2025 18:51:44 +0100
Message-ID: <20250309175207.43828-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

In order to expand cpu_has_work(), un-inline it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-3-philmd@linaro.org>
---
 include/hw/core/cpu.h | 6 +-----
 hw/core/cpu-system.c  | 6 ++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 2d4ebb79905..a54dd2cf699 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -758,11 +758,7 @@ bool cpu_virtio_is_big_endian(CPUState *cpu);
  *
  * Returns: %true if the CPU has work, %false otherwise.
  */
-static inline bool cpu_has_work(CPUState *cpu)
-{
-    g_assert(cpu->cc->has_work);
-    return cpu->cc->has_work(cpu);
-}
+bool cpu_has_work(CPUState *cpu);
 
 #endif /* CONFIG_USER_ONLY */
 
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index e29664d39bb..c10e3c9ba64 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -31,6 +31,12 @@
 #include "migration/vmstate.h"
 #include "system/tcg.h"
 
+bool cpu_has_work(CPUState *cpu)
+{
+    g_assert(cpu->cc->has_work);
+    return cpu->cc->has_work(cpu);
+}
+
 bool cpu_paging_enabled(const CPUState *cpu)
 {
     if (cpu->cc->sysemu_ops->get_paging_enabled) {
-- 
2.47.1


