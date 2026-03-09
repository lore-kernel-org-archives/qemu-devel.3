Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48D1F41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcvI-0005Er-Hd; Mon, 09 Mar 2026 11:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcv9-0004vq-2c
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:27 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcv7-0008DH-G5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:26 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439cb5af25bso2178474f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071602; x=1773676402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pfrbHFhAv8bhscS2w7kB7DC3fNMKySB4UiY5tzkGzOE=;
 b=iJE3wbTSmP2cKoWlGJQ4ow40W8RlkLqncgIuz/HbGQNbPGBFy5vrvYO0aigwqgSlyU
 0MF3KjV7ctuXhsdrpTzYxht2ABY+PgJXwTZJh2Gi1RaSM9+dOfZCNrHMeSsm9RjuzSHf
 mvxUUvE59KT6/CQV/z2vQFeEsOTTd5IY00/tZtPIrtCGmQkwafP/ODMVteA8+vHx/G4B
 prRtyyDpnBiJR9KQmsk3JSCAc7FCdWINAaSKj0VDX+BYqbR23kWxNKfssB0eEB1Ru9iK
 xeF42QN6Hf1nE53IK74G630/duwFxuVVfFz3e0n09CRjbkaCzWXv13SDmbLNcyPi8ejR
 pXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071602; x=1773676402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pfrbHFhAv8bhscS2w7kB7DC3fNMKySB4UiY5tzkGzOE=;
 b=s5euGLmIUvNdMb6c2p0Im8CrI4QAW98Sumw4/HElu0eMKsOslD8fSImmN5NN6OlVdc
 8GlCM18MGlhTU3DVw45i9VjqtUzufkDvuvk23A/imoo4mRBg6fCs8o4/SODpfNMp0BP9
 MqgXChyBqCs6hRgh+O6vs2uWxhLVYOD234uhoKcxxdOLGgGXaUQci1twRdGjLzsoIMrh
 TqeVd6jxGuFZvdxLifzJntWAGBFKvITSLBFTUBga588tfekwDAin4fKzhCmeUQ3VMr1k
 fTk5yXlKsfO9rp3tdm//ZCz+0Vt4Wo3otEgpL5Wpic99+RVVRyj21aYAzsgW7IfLPaN0
 mWeA==
X-Gm-Message-State: AOJu0YwgL+KgVlxfrQrUEbQ8wt3OgDqoAsLZqNkKrQOEuS7u89+Et/kW
 1SwoNf0UlyDAuKxHRsRXRv1GClyg8WO0V3mIaqlerrWSxZ1mHxMR7g3qrCOi+yIM1mYhgQPWXrj
 wznzUv1U=
X-Gm-Gg: ATEYQzw/RgjI1zNI0RAJbzHCATPUJmvpEGvKkFjxlGi7laYF2ltcpUwX9AFiX5YkFPs
 YbZHgAYmzbIVp6y0NIstjEupOEdd8p95uvdE32Gz0Ms/3PRLCPLH8z4fuUslSTKTllEPUMmIMBV
 PPlN4AewF6btv6VyHhEyGct0lhl78JNMIL6nRDlILoGV9HZ0n0kbrMv0Sjn+ZDbDf/lwEhL/jpI
 odBw95WBE+8JQrqDIzXg9XoMtOClzEN3GdxVF3NQ8vd37E0A3CB8K6Ow5tiqpR125zcQAkaTjsb
 f1r7SkbjKgukD1PsgbXdGF/vl147hRaEBld/f4nHp4SCOVk0aYSetquxaEh/IGFkqRfejjmHl7L
 0qPMjxc6fwaFIxTM8VTvByhijiASmpnAPGNXLMaDe+yCt46UFo+sbOyMpAFxATnsiQ8l1CjLbyT
 HnwacIfRSEWFIKiS6BsgGSKE0o8RqY5oM/f0G1MNMp/u1hOoaEpvI29RDckOVLV7vrlUHXge+L
X-Received: by 2002:a05:6000:3107:b0:439:b3c5:ea1f with SMTP id
 ffacd0b85a97d-439da35f8d7mr22194715f8f.16.1773071602043; 
 Mon, 09 Mar 2026 08:53:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae3f267sm26232109f8f.31.2026.03.09.08.53.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:53:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/49] hw/core/machine: Remove the hw_compat_3_1[] array
Date: Mon,  9 Mar 2026 16:51:39 +0100
Message-ID: <20260309155219.62400-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

The hw_compat_3_1[] array was only used by the pc-q35-3.1
and pc-i440fx-3.1 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307152635.83893-9-philmd@linaro.org>
---
 include/hw/core/boards.h |  3 ---
 hw/core/machine.c        | 17 -----------------
 2 files changed, 20 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index e15dbcea83b..9155e0cc9ed 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -867,7 +867,4 @@ extern const size_t hw_compat_4_1_len;
 extern GlobalProperty hw_compat_4_0[];
 extern const size_t hw_compat_4_0_len;
 
-extern GlobalProperty hw_compat_3_1[];
-extern const size_t hw_compat_3_1_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 162600425b0..9a3d826c3cb 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -221,23 +221,6 @@ GlobalProperty hw_compat_4_0[] = {
 };
 const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
 
-GlobalProperty hw_compat_3_1[] = {
-    { "pcie-root-port", "x-speed", "2_5" },
-    { "pcie-root-port", "x-width", "1" },
-    { "memory-backend-file", "x-use-canonical-path-for-ramblock-id", "true" },
-    { "memory-backend-memfd", "x-use-canonical-path-for-ramblock-id", "true" },
-    { "tpm-crb", "ppi", "false" },
-    { "tpm-tis", "ppi", "false" },
-    { "usb-kbd", "serial", "42" },
-    { "usb-mouse", "serial", "42" },
-    { "usb-tablet", "serial", "42" },
-    { "virtio-blk-device", "discard", "false" },
-    { "virtio-blk-device", "write-zeroes", "false" },
-    { "virtio-balloon-device", "qemu-4-0-config-size", "false" },
-    { "pcie-root-port-base", "disable-acs", "true" }, /* Added in 4.1 */
-};
-const size_t hw_compat_3_1_len = G_N_ELEMENTS(hw_compat_3_1);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.53.0


