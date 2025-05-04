Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F283DC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvR-0002WN-JY; Sun, 04 May 2025 01:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvB-0002FU-9F
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:49 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv9-0004QF-IO
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:48 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2264aefc45dso53637575ad.0
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336586; x=1746941386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SeLT1f95/cGbe62bYfKMrzmzjdSaQ72IuCLuyv7ztwQ=;
 b=tc5cjHYQksB5ocLVJKmWdIJc2TaaUPPv4sXdcTGCjdUF6Escs+nM8e8pl8N2Je8cIt
 dOHelrB6qtoOCG+a2jV2NibRQ28KRhetKIJZdeLWUVULPsK6CWL53jZp3RiQWsznXST5
 UzXwDrqFzEx5UAyRxKE0TM+jHS4TDanWcrd0TiWub2iOtgGezAFl9D2nNYIZt2JrxtxR
 EMieqU+UbBNfe9zCmVbSsvG9eUGLZf7KmBEsrHycSyo9kbexSLe4IiJGZhhCXx+4UK7p
 Fvbx8q/FUaWg7OmFszE1L8Aosmv3A4ryKzUKJUrQokOm7i3WuG4uNaycCwDgIVmIGGMI
 +gmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336586; x=1746941386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SeLT1f95/cGbe62bYfKMrzmzjdSaQ72IuCLuyv7ztwQ=;
 b=WjFXUK8qXw0ZltmTmpX7wW6Q9DZroF/kW51G1KmXQ2Z4K014UkntO1sGMhRKC+/BWR
 8sb1KCkdw9Mxjwmp5kreGqdDfULd4+2GZSDwkgSdBEOFslaFPzdZwzorKAA3oe/HZxy7
 x/xSloXTnjI9vgGzZBnKcPMOJ0IiR7kNdwn+ucyEKqE1ygZUdpoBVFS67Us3X/FkHPRP
 3oAwgHlJr7AhTdFyXI8hfev88CocPhk+3pWUifaHQ+ceMjELZQZ/dH+DpVVTa4odS2za
 vOAB+UR02hAbUKU/fKUcYTl1bqEVdyULc7ha/3xXIHeJU0Oyw560vXoh+xzF4snW9MZ0
 VVkw==
X-Gm-Message-State: AOJu0YzpxuqxPOXjtBDeaoudPXYj0UizxZoR8sgrqe7hUwrOKManyDfo
 AXps13r6A3RTCYkZKE6WKdcOOe4dke1qBOgB7fyRwGXw1NWyl+aMVzQnS80u9XXom60HL1hjDxH
 Mp28=
X-Gm-Gg: ASbGnctZAPXTNvLNzAtR1uSKpnp7/c+C73RBLIdyXDzNYwD8AxZgwF+DBdyou7gbKRX
 1rbk4yEQ8ZBuMsavXOHLzfJagY2owuAVzpHA3Jo3RLfLN8J5e2WQxrQbicGvm/l0Is5Mh5ZxPne
 +D3kR26IbtoDI7IP3++xGJFP8+9VXWcmM7/EJj1ay/1uOd9Pml/VNtJ8mMAjeGjFltTsA7xC08D
 Arkidf8m+FVVy61wY97E3uSPooUzAfXMKyrE8/XdmhKX/C56TSQvWaNce5iQc4qUaOiDIDvR7Bg
 srqMx+IAMVXNpcWND1LCpCP1w9JfnncbxtAYfWR7
X-Google-Smtp-Source: AGHT+IG3YwhSYkIrQWb9joOE66utyaPWKSvpqKpUrI0Qe6pFy1DfaUaoK33eaJpaAdCqsfCzd4IiYQ==
X-Received: by 2002:a17:902:c947:b0:225:ac99:ae0f with SMTP id
 d9443c01a7336-22e1e8ebb30mr45072365ad.1.1746336585772; 
 Sat, 03 May 2025 22:29:45 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 29/40] target/arm/arm-powerctl: compile file once (system)
Date: Sat,  3 May 2025 22:29:03 -0700
Message-ID: <20250504052914.3525365-30-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 95a2b077dd6..7db573f4a97 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
-  'arm-powerctl.c',
   'arm-qmp-cmds.c',
   'cortex-regs.c',
   'machine.c',
@@ -38,6 +37,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(files(
   'arch_dump.c',
+  'arm-powerctl.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.47.2


