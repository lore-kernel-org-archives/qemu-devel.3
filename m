Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A09C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ksu-0002SN-4Y; Wed, 23 Apr 2025 20:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqT-00011h-C9
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:42 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kq3-0004hU-QT
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:18 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso453992b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455994; x=1746060794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRqDXJHX2zGNybTG6x2KjIY6H1Iy34YPBBK1EJX6qfI=;
 b=Q+owHrbKGIyzISFHkoSxG8+bumjiE+ClEH0UvfKYBjIYaKqeB/vNp1/WLu16ifG+UH
 tbgg+zNEXsYvnFMy3ParRrKK9nIyVmAk+InwkjNrTfB9DnO5LeOM6qK8L+U/vIjyW4gI
 55kMVBstMMsHAsx5ZX5kNaz2gCyVDdq7U+a48QX4jDUXuKGMHBasvCofHrKC2TLL4FMU
 gzhbhJ1+7Epn7e+/4ilOwvzT6tii3xsjHI8k31t64KyuW/W3VAo5vX2OvGxfi4oIWWik
 xrXKSM7NBbdi5fNRG8U0bp7zzE/dQ42Yocj5acMxNOa2Duob+WNNgmuGVeOMiVAjGBGv
 nc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455994; x=1746060794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRqDXJHX2zGNybTG6x2KjIY6H1Iy34YPBBK1EJX6qfI=;
 b=PLSDJxd0YhyC9nXtehrEC7XPnJ76U3NBXrH8gBGqSUvhmRdlzkMeYNgQtU55qsupgD
 hZkzQy/DLr5eK2vD0FW2k76b72flwVXe0seF4crkP5BCNCRkV4A1c9JiL4m38abwrZXh
 vZ7KSgnEMd0vEq8lZC6d7hWZas/9N3bOdXUkG0EOBopEpQ42gd5qyTcv9sAzvouMx2RX
 z/yEtvFpE3vmgIND7XlWcR0S077Aro+PBnObZbiuV4ZL+nstEu4dme3zEJ5795fTYuq6
 UetFBIUWpXdUBz2CIBAEzpCSJs7hmSBhy5qDbm+lH6SVxh+KcrnQ4Pdb0CAynRdSSG1V
 cg6g==
X-Gm-Message-State: AOJu0YwWZ0gcPn4OppuvKZPf2k36mbtTBnDMVE0ZPltspsDuAaseYEum
 tPLuX+iVqGLAJXPgwCFXy/5RK017SIpuWeaBD9HxLNAapUx9+sFx8mCcWNtJK0D7RLYNS22qDu5
 B
X-Gm-Gg: ASbGncvE7Wh8cvFqle7mKtYov8nqDfmdt2IPuDkdxkAx9+5Pn1IeCFL3ILsAb3z6FWY
 Z9oAzmilbUfa2a6+du5RlQK+uEr+MVA9jlpZrgpD19RTsv1tIYXMpNIrbHJh8bg7K72OKrndQGd
 3Tk8Rfw45uAPec0cFI3KQQ1XJ0ba6yjB/3DrOwgQznX+iMQ18jbvlZGy4tOPet97HSodV/1UX/P
 gJ9emfN13kvHeQDCiXlWWxl1nBsUxtLEyfFQ5O95R4S4sZ1m08mdIec6xnDPrXQFqXko4JzXGNA
 yw2g/N8zYEjWk9aWMFYxdJhdnpr+91Qp7UXWVhLI0XgM3P7WKGNMhbKhPqX3s4Gn/xPHt2DjAqI
 =
X-Google-Smtp-Source: AGHT+IGs9zwuqE0sB0MQItZUhHxhwDcAGENwgm5yjdwLplx3yRDdigYkAl1sTvXT6pNNBqMPP2Q+Yw==
X-Received: by 2002:a05:6a00:3cc2:b0:73e:23bd:fb9c with SMTP id
 d2e1a72fcca58-73e24e0dc67mr1030916b3a.23.1745455994432; 
 Wed, 23 Apr 2025 17:53:14 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 049/148] hw/core: Move unconditional files to libsystem_ss,
 libuser_ss
Date: Wed, 23 Apr 2025 17:47:54 -0700
Message-ID: <20250424004934.598783-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Many of the headers used by these require CONFIG_USER_ONLY.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/core/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/meson.build b/hw/core/meson.build
index b5a545a0ed..547de6527c 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -26,7 +26,7 @@ system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
 system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib, libcbor, gnutls])
 
-system_ss.add(files(
+libsystem_ss.add(files(
   'cpu-system.c',
   'fw-path-provider.c',
   'gpio.c',
@@ -46,7 +46,7 @@ system_ss.add(files(
   'vm-change-state-handler.c',
   'clock-vmstate.c',
 ))
-user_ss.add(files(
+libuser_ss.add(files(
   'cpu-user.c',
   'qdev-user.c',
 ))
-- 
2.43.0


