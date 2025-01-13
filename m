Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B20C02184
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQYY-0007Gj-TQ; Mon, 13 Jan 2025 14:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQYS-0006k9-F0
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:57 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQYQ-0007X7-Vr
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:56 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so33280145e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798213; x=1737403013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T91VVeNWf9GIIc/CEXCMK78y9ZI5LIeof3gskqolzuI=;
 b=axpLU6q3x+PfMme4zMyF0Q2llIV9frZ4TrJSzQ4eNDXhv4XxGa+xlu0qf0U19TFtjN
 G+rZQ1lxmtyfCyeCnjlAb2fvilCY092FiGRJHUe7Gg4dx5XuGXmKmMnrJSs2BcrRTXHb
 QSQ7F1PFkU2sn/FGUturF9HQLOt6EiKNGvPznotATsglbRyPngIdzfSvu5nbyBKIj4xR
 ok44DOcepJnUN/p+ERwgpFV+ZkOcXHc+g30c62edAGCXt5bh2iZzVyjAbdSDUoHzTve/
 wHdGPejye17QR/fUDo1r3w81gue+HV92oj8ZOFrRCx4iKBOrvwHKEfjpl/pQscBjS7wh
 sQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798213; x=1737403013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T91VVeNWf9GIIc/CEXCMK78y9ZI5LIeof3gskqolzuI=;
 b=kk/py9p8VUZf6JPQmfOrV7a2SZqMfPEKj9n7jS/XAvboM2ebId+/JpTeNKqmOvljUO
 Hw3S2eSfSm/HCVV4d8dzwQrroiH24UsI/oBgLtDQOuq1RdbO8ZB0OKPZKifr+XGbv2V3
 CB4+uZLKngUSEyabB8zRNEzZXgjlM8LK+5JUttyc58+zzoEGfHFE0x7uibH5jvK7KguQ
 iCZ7AkBDQL3yqTZRvEXZ+fmgfSpQsksGjktC3JtpC1hjH142qfjiC+WbTLiviKf5/izh
 s9APirT0zvhtUV+theLEB9iP+7Avg9TLGor58o22cEmMRxuidmsY15tdMu0CXih4Kmu/
 Tw3g==
X-Gm-Message-State: AOJu0YxeMY6B+/sHbPiurUu8FAvUXDSsxofHXvav4cBu7WPqXfhotMQk
 dYakfJ5VL5+ixen6vLXWtALxI5BMlvhNbAU987jGkDQPfIWO22z0FCCr/qwYSoZGXN679KUHD2R
 UHcE=
X-Gm-Gg: ASbGncsbw6KrNpdq4Z7MlMtBT6oA4UztxJLPmJj9FDpVGCY3J3SOtYAvMFPvIcNNTCB
 TIpPRoR/RbUQM/9Re6T2jT1bX8Vc9jqAn6lwdNiB2NIJd+RrcqSvOPvGSTX1BYiojeGIigkne2N
 UEeRfMzSBbvbd1mBrhn2MksfW/rq5w5hJubJ20SRxkSxox8zfXeb1MmW8g8WyAfd3utAcSMHxI4
 WvwpSbiex2ETODd3SJHS58TzOr3HiQqnwB4NoY3Wq2Xd1ks5unc1vSpO6q69XlEHmxoF9KqTs8U
 cM7Cg11MVtCu5yKbvV5QHgBctgO9Ed4=
X-Google-Smtp-Source: AGHT+IE4CXdJIt6U24I21jZJnOP2WE3Xdoxw0/qWRq8SFwZOnTzEpaIN/GiAopOCsJS/zHK+xFcxqg==
X-Received: by 2002:a05:600c:1ca7:b0:434:ff9d:a370 with SMTP id
 5b1f17b1804b1-436e255e2cbmr215662885e9.0.1736798212922; 
 Mon, 13 Jan 2025 11:56:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e92dc4sm185927245e9.39.2025.01.13.11.56.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:56:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 17/19] hw/mips/bootloader: Propagate CPU env to bl_gen_nop()
Date: Mon, 13 Jan 2025 20:55:23 +0100
Message-ID: <20250113195525.57150-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
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

Propagate the target specific CPU env to the locally
declared bl_gen_nop() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/bootloader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index e57d5c3278f..a54af8160ef 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -67,7 +67,7 @@ static void st_nm32_p(void **ptr, uint32_t insn)
 }
 
 /* Base types */
-static void bl_gen_nop(void **ptr)
+static void bl_gen_nop(const CPUMIPSState *env, void **ptr)
 {
     if (bootcpu_supports_isa(ISA_NANOMIPS32)) {
         st_nm32_p(ptr, 0x8000c000);
@@ -255,7 +255,7 @@ void bl_gen_jump_to(const MIPSCPU *cpu, void **p, target_ulong jump_addr)
 
     bl_gen_load_ulong(env, p, BL_REG_T9, jump_addr);
     bl_gen_jalr(env, p, BL_REG_T9);
-    bl_gen_nop(p); /* delay slot */
+    bl_gen_nop(env, p); /* delay slot */
 }
 
 void bl_gen_jump_kernel(const MIPSCPU *cpu, void **p,
-- 
2.47.1


