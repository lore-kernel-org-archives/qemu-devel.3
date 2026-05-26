Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6568DCD5BD2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRoXp-0008Cj-U9; Tue, 26 May 2026 05:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRoXn-0008C9-Fh
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:57:52 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRoXl-0000UR-WB
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:57:51 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so6142425f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779789468; x=1780394268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OmNdtbel2T0kr4Q2hd3pLMx1YxIFCLHhOF4vcHalKkM=;
 b=ibaTaqmZOkK6j8cOdjAdSnES8qNovkxhjOkDtl2U105m+p4+52jgTwJja86PhHBXc6
 2a4X4vU7dYOO0Sg4DgFFBmlH6hJQEbnokGG6fzL0CJodNuX0WpqBFpFTOyD8hvvgnxNL
 wbPq9iyswm0s4NW39SRbINoQbpP6+PPCrvuF/5yz6UltSxD1nkMF9mDOVM8F5s8xFbz5
 ESeLV9XmTEgR3K3ydeVECneyFsojqx9tJwPozgSLhcieZFXoZbw83s2SDNHE/BbCaSWS
 mvYfqAh0fRLncKy9sUO9VlBG8HYLlhwqyQ1yLiMumJ3b/2mNIioE76M2J73t494c/Oe9
 8aZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779789468; x=1780394268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OmNdtbel2T0kr4Q2hd3pLMx1YxIFCLHhOF4vcHalKkM=;
 b=qs1n3Umhicl19GN015PqtOL/85GwFSZTiBrcQPXZWQyq6zl5SKTo6ezqjAeZBnPmQ6
 tQ32CVR5dQGkm1jNmsAxkYiN9oXirMIlfGA/TlDxBmxqr3Ct5kThknozvDgo3X7RCKr/
 l8n1wxgZcTrSM2eP/1pqsBnu1F0XR9rhWRlt/s0z5lUPRRXaV01K+W4u26wZlcQZwAJL
 qCcaEoXFgkru/SDkBsJzT6WJT3t40+LuyOP769qml0QqrlY/9hGLWokIkgIm25uJkwsE
 z3C9RVi/Q4IeOpI2N3wZgIuGKiY0w1owJVLqpCNZebC7nFNo51d6X0yoF4LSEZSU8/z1
 2dNg==
X-Gm-Message-State: AOJu0YyqZpmyV6kEK78rAiGBaQeTRTQINfitxlQC0PK0lRiFAv6If9Xq
 QWaF47QbNNWD20Erygb65t234aZ1Su6dcQFrQ2uQz5bzJ0P/gTYasIotisJ8CfbEkvqMhY8iKIp
 TgP1COU2BKQ==
X-Gm-Gg: Acq92OG3Uc3upivoqrGN443OWzB2MsHXdo+aEAkt/4WTXDHD3tog6ShvcnQ202/NWy6
 7dY4JB0bBpM2dLrIMMAKnXsNoKZrCfIiBVCKZVWprZyQqRJWvioUND9AzvSf9T8ZCmvU92E+yvJ
 VqRR09LS7yNos7pQYtmjpPyFaGvsu5f6gVPEwPyGrqF61ZPUGHQm0h+KuIVngWLuA72IKu0g/0B
 LL2WGmChJxWJ+5J4wlmMguS2yrLi/Hzop6I640u6iF8VLnOrJlMvAeAgEg3lI0wmLc0gWOfu4GX
 6kxWm1BRKXPjUM4gYQVqUeSWjAkoiv5nv0LUrSG9fFv3/v8pUuuhD+3cpOCSWnIE6LzVD2V6j8/
 0ZgCT2sWDLvLX3IYaVpXeb4yKzkT0SPwE/HTWNepMdvbr2CoCGNXjG7XANqHfbr2vorwbnmQHJm
 oxFzn8lD55ycYvgu79Sl/UT0vHYYZ3XV1EZmadqOzInzBc1D7BTE3a0Dw=
X-Received: by 2002:a05:6000:26d1:b0:43f:dfc3:555f with SMTP id
 ffacd0b85a97d-45eb38e2b12mr30821313f8f.43.1779789468202; 
 Tue, 26 May 2026 02:57:48 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9f598sm34878290f8f.6.2026.05.26.02.57.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 02:57:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 2/4] target-info: Add target_riscv64()
Date: Tue, 26 May 2026 11:57:29 +0200
Message-ID: <20260526095731.63525-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526095731.63525-1-philmd@linaro.org>
References: <20260526095731.63525-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Anton Johansson <anjo@rev.ng>

Adds a helper function to tell if the binary is targeting riscv64 or
not.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260520-hw-riscv-cpu-int-v3-6-d1123ea63d9c@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 23c997de541..6c5b714288e 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -99,4 +99,11 @@ bool target_ppc64(void);
  */
 bool target_s390x(void);
 
+/**
+ * target_riscv64:
+ *
+ * Returns whether the target architecture is riscv64
+ */
+bool target_riscv64(void);
+
 #endif
diff --git a/target-info.c b/target-info.c
index 28c458fc7a7..04c69c41f8a 100644
--- a/target-info.c
+++ b/target-info.c
@@ -93,3 +93,8 @@ bool target_s390x(void)
 {
     return target_arch() == SYS_EMU_TARGET_S390X;
 }
+
+bool target_riscv64(void)
+{
+    return target_arch() == SYS_EMU_TARGET_RISCV64;
+}
-- 
2.53.0


