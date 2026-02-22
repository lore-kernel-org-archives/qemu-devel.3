Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CD2E68179
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIWo-0001Qx-CO; Sun, 22 Feb 2026 18:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIWj-0001Qp-NV
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:06:13 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIWi-0005vM-5N
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:06:13 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48374014a77so38711345e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801570; x=1772406370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G8n54m4QbMI8GF9i4s0xEOtozUsr7KAZ+nvUeoqm+sI=;
 b=b6KuEhjxS2mZMDReC1kaqAO6U3vAh1W6434cQQRQO2bd/NmUCmJFpYNDvUyyJJVFeq
 kuwlnuaYpBbz2YA1rtVoCNyyKYUKCYrEdhsEQi+7bpKtiVjusfhjnyelKArntx3lbTWE
 X6TZHtdDVMPm45SlQdgmHlp6djDXse/j3FU6Z91zNgVcTT2uWwN/njfLM51az3gdThJK
 m2gmVVsVCQiudoxGWjY/b4jTLJaQl1aLNM2ABNY+HOdqSkpvmYabtFGTp9feYgEzti5E
 RwW4vbpBLUYy2Yt7p/kSAG/1XkJazf3uOUpY+8ahpTTd3fQPJ0bR5aLWjodT64dQ9OiG
 pyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801570; x=1772406370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G8n54m4QbMI8GF9i4s0xEOtozUsr7KAZ+nvUeoqm+sI=;
 b=cVfjoIprh9g9YzDUjXWb7g5KQHTXPWKhtqQeasVfhWXfA1t3BLanfgpKGlj7giNq6j
 fd22QXH/ZYxkou5eA6FzhLwq7bOSzaMhtHmirRJqCVx6ETbx2PjSfvCaxC6HpnY4fhOA
 gNH6MPI0izeQpzL2vPr7G4ldECqsaOYNR62AaB/4sjTvAGDVH4F6Zg3tI08qHN5gj2sD
 2pKdkan/7jKQJbLYLHBzaPk5ya++xMcr1V8pUx1bouosrM63QnbemzzEngxjOQNu5Tp6
 lsxKGngWFKL4WZYKijH5usnwK5hxfCRRWqqg/5haRmDKNyPwwM8Z8FyWDssSQD/R1hIM
 frPg==
X-Gm-Message-State: AOJu0YyQnCqDntWihMUhxyeHguGP0yv8zZFrrtWlPnGFbM9WE5Ay/06x
 eAkVzFopMNfXptBnX6BBAsYPj1Hxijmzm11cSazVYFFIQlAyKXEJMF7B/8jmwg9SL9zpqalUnnJ
 oQVRPiUw=
X-Gm-Gg: AZuq6aK1L4McD61jhJ5iT4X+x8Q0U0OERhGpiEGmkePBtfDtT39hCG2yoE22BiSIzp7
 LJVOQufJyU8SqQg750b89/ih9SdeJUVyJUILXlOQvnJ/aHRO3KAsD0b63c/gN/nONDuTIQLZ+Kf
 W7PgAsCruyKkmEjWDpTh3EsQa7TWkt14//dRmS7cKm1bQsz54B9QHVWlz3ooqBpYWrESn8/1qi5
 3rPewmgH+4jJp+vLrhslmRBNHbXyknLFrYlq4OJVSHVWsohXIPMU9AKndKb65/MjDlG3Iyw5MkP
 NwPJjRMfjJBhpReXFT+IkY8Lx5jz19szDT0v4RVY6JKlc9YnyskYboPQjauuyqZCziv2d22MYdw
 A3w1Fr/BtWojmsy7h+ILv1G/7pfoAX0nr7SXWazBpzIsIdHALOC4xKF6qcR6pitdPpGyeKJhmRr
 lRof8auSqBFPrLeHZNMcn079T9VuxHPAEi7/P2+DPyhX2shK4UuDdvY9tmdkdCtfQgsN61320P
X-Received: by 2002:a05:600c:4f8a:b0:480:1d0b:2d32 with SMTP id
 5b1f17b1804b1-483a95beb5bmr122248265e9.12.1771801570219; 
 Sun, 22 Feb 2026 15:06:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4c626sm16426705f8f.28.2026.02.22.15.06.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:06:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/20] hw/misc/virt_ctrl: Fix incorrect trace event in read
 operation
Date: Mon, 23 Feb 2026 00:05:42 +0100
Message-ID: <20260222230602.5756-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

The virt_ctrl_read() function currently invokes trace_virt_ctrl_write()
instead of trace_virt_ctrl_read(). This results in read operations
appearing as write operations in the trace output, which is misleading
during debugging and analysis.

Replace the incorrect trace call with the proper read-specific trace
event to accurately reflect the hardware behavior.

Fixes: 0791bc02b8fb ("m68k: add a system controller")
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260111184915.1363318-1-visitorckw@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/virt_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/virt_ctrl.c b/hw/misc/virt_ctrl.c
index 40747925a29..9b82e97ffde 100644
--- a/hw/misc/virt_ctrl.c
+++ b/hw/misc/virt_ctrl.c
@@ -43,7 +43,7 @@ static uint64_t virt_ctrl_read(void *opaque, hwaddr addr, unsigned size)
         break;
     }
 
-    trace_virt_ctrl_write(s, addr, size, value);
+    trace_virt_ctrl_read(s, addr, size, value);
 
     return value;
 }
-- 
2.52.0


