Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DC1E77197
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSilm-0002Rm-K0; Tue, 31 Dec 2024 15:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSill-0002Mp-5S
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:13 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSilj-0000r3-Jz
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:12 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43618283dedso102591515e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676590; x=1736281390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGNPsqtn6WrBcmWHUQltDVOOi9FS/uGzmcny5x2XTrE=;
 b=nvHoZ4uSutqa9yDJfSBV0lFIacSJoQz5NKtDFt5Sgt1f8VBYBz0EeiiMKcarN3orwd
 Hnl63TTZ2wM0jZAvQpC0gD9VeOK1SeHzK3ElLafqMNx+oJN2ae5IoaHKqX6TsRH6kbEk
 lQD0rg2+kfZkonbihJR0tWVZcz+tXICnV86IMcA125hmcJmtDg0gzIHywqX232ePoeCh
 e2wo3wsiW3f19YQin/Be6hex3+fVUIcTGHuv9oMBV9vxAzY0e9ExddPuBJDfdOQNDFpM
 iafPc682QYTbtaaIfnSoCRyliXJwe9yhCIVpWviO8gjpcZlcRRFdIRXPlj308kGzDRKB
 zacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676590; x=1736281390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dGNPsqtn6WrBcmWHUQltDVOOi9FS/uGzmcny5x2XTrE=;
 b=SmZs0rWKv640fZCNfYOr3MOPnZS3XM6Hh6z6HCYFuNzA69FGOH/213mT+Tr11okb+c
 fQ0b0K4kek12kl3JP43E6P4O5z6PGsqSXBAcrq8BXRE5xodBCeqzXJZ6RpOFhIeAF1H/
 YTcumEPsl7ApX93K1b0ibF+qictAUPDqui2miMN29ljiH1CVRibpaHALtraDXWhuihc/
 k3VUyWe8MhC2nG2um2uqbD6g0KrQvRtLewgs+UyZhYHlhUse/zPZQSRpnJaSFzMpp9FY
 QWDzBIhEMhO0iK0z5wIL+lCfN8+XxlO1dDSmvd7Mdr7LYzFlxWONmtRg6wXmuB1uj8B+
 TzFA==
X-Gm-Message-State: AOJu0YyVetL3R6lgp4ScgH+XOc6KgUSZrFV9GvNYE15WtD2HEZVpueRU
 VVhPWvLABKouHSDATxe3M8r/k4sgv3N+6ho8T+xvMu7e/huAtaA5CKx6wdPum5zhnNL8DhHrZl0
 1vc8=
X-Gm-Gg: ASbGncsC2VRmQyJHbwwTukQoOBZ9vF1os3AKIBbHUqGxGIvLhKPh/HWKT6y73fluUj+
 SwQ04hy5NwBoZMfQz1w7JoLH0Rn8KQkQvwCQ4H1sn/2lIzQ97rtz/NdPszMtC3vyjNEUQGVpATR
 /OWbxr30m3BKCcfDwkhfi/FYePY8YsyhY6D/ahHs/2kYXSeKIcKOlqnfcBkS6Uzx+F6hU/Limm0
 1h9IhtuFAK1F12n807RZ1eFmHgXl0k8tumlOy/qY0wPvQQDlLqhJLYcaOdSRBRJ5TX/xNd4aWgG
 rbHDvqMLPt6Y+OS2imo8y4NEWkqGjbw=
X-Google-Smtp-Source: AGHT+IGEJ/cuOD4fYvLba4TV4gcoL4CYUHt2CM4M1Ro32+wkEZxv8+j9fE0vsv90XamhyleknVNehQ==
X-Received: by 2002:a05:600c:45cf:b0:434:a781:f5e2 with SMTP id
 5b1f17b1804b1-43668642289mr322212115e9.8.1735676589468; 
 Tue, 31 Dec 2024 12:23:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a636asm34466725f8f.88.2024.12.31.12.23.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:23:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
Subject: [PULL 08/29] hw/tricore: Mark devices as little-endian
Date: Tue, 31 Dec 2024 21:22:07 +0100
Message-ID: <20241231202228.28819-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

These devices are only used by the TriCore target, which is
only built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_LITTLE_ENDIAN (besides, the
DEVICE_BIG_ENDIAN case isn't tested). Simplify directly using
DEVICE_LITTLE_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20241106184612.71897-3-philmd@linaro.org>
---
 hw/tricore/tricore_testdevice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tricore/tricore_testdevice.c b/hw/tricore/tricore_testdevice.c
index e60866d76fa..d2da74e3846 100644
--- a/hw/tricore/tricore_testdevice.c
+++ b/hw/tricore/tricore_testdevice.c
@@ -47,7 +47,7 @@ static const MemoryRegionOps tricore_testdevice_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void tricore_testdevice_init(Object *obj)
-- 
2.47.1


