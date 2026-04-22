Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBD1F9B609
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUYj-0007M2-Vr; Wed, 22 Apr 2026 06:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXt-0006vh-PH
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:11:01 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXq-0000nX-L6
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:11:01 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488d2079582so61485865e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776852656; x=1777457456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLzSB9spY+gJhXJ81HA2xrXzxJ07lupyVRDFchBeQ6c=;
 b=d4gM5khCmHpu9D91ZCld3JFzYwrwylTKMx0kFeS8V5IUiyELHVX5MWS3NIcG8HGlMO
 +X/Lflq1VIIBiZE8MqwZ3uqDAAatz+RQU+aeMDlac4SspoaG/pZUpHoN00UZE4sNLE4K
 AWh78cdnuDcpviJcpI1pmuQIzW/Wfqdv55KRUnXsABHSXpAN21SAU7MU47NNQ/zQk3fv
 j+gnhMy/niHsBaYCb4mUn3hmNNpKCvBtqGkp0w5OuH6+jIMvTVukqjqNl99PwZkqRRVL
 6xMKkN2xZti1LYDkzxYkI1xgnIo1A3IIgbtoVWquWAkjJDFyS8u858I7w0lxXKrX7drN
 j/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776852656; x=1777457456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SLzSB9spY+gJhXJ81HA2xrXzxJ07lupyVRDFchBeQ6c=;
 b=ZFtJOe0rb9mu3ZQFnwKOic+bPjZIlapxfICI6Z9EtcGtL2/n/0L9vm43g4DCzxpRl+
 ghnWXwEGjk/ySDoWsXCAG1gX+MJK1Dkg95/mYsrQcaq8tekmWZhi36VR0CxwUgQ/gePc
 htHsF+HLHoBZDwwgFaApvHL3pIuPArHetLMZhtp2/iR9x0BWl2iZw60anMwzEWQW09Zg
 N5cmxP5gysganQ4Vqp7pfcQf/D8PUYU/jS8SPejQoj8f1EettXEE63O9b/1JsVZvMgOe
 rS8Sq1IfDJD6PKEQd4Ww69ui9Z1D16aFG6sCWl/PsE71i3g3C6YL7RUiRouOpa1f8sss
 jBLA==
X-Gm-Message-State: AOJu0YwbjD/I99o/+WtwotLDrQpAmRvsKe5VR3QzL1ZklurOkFj3OHYC
 Dgos/qPs8DdBn5cQQLe0GfK3vpnm5l4LvBKanu3pz4SWeKitD7UcHG4435Htlr3VfDw=
X-Gm-Gg: AeBDiet+xIZV6z5aqzYheCOScqfGjcSA/cTUXePHD7ObWZ0BHK0HWT4Nz6UouldHMky
 nIWssQdQGjsS20UqzIRKAxMJqCKDhGZ1sU2dxfhkwlC0eCDlSVtAlQ0LE7U+dgP6mWCamFYTj5u
 Pr6HKmRcFov5MKOIieNjMPrELDrZV03YbUqD+ypWrHxfyEQwK5ul0EVAglaBzdYl0EfWas2j2r9
 cLePkbLLRehXE+fisqXGESLOCc+UqWCFQVDgIuDTVzon5/68UMZSVaJoyjTMol2EIn9+m2+rdWH
 IqEUGpNfJjF0miPRmB5PleWnUaT71odK9GXa4BVWVLfvF4cfYwpogqMNxoXzGv531zToVtw0k8C
 LQyvUjsGoIjz4xEa/xSKgCHuwXZnvF+AO6uLpoODvrjhI3Dp7Fm/sJYV4BAZ7viNWTbOKg/Zrng
 Wrv3T8TabedHGVOeFsMz9v6W3zRstrU+YM2A==
X-Received: by 2002:a05:600c:1993:b0:489:e696:836f with SMTP id
 5b1f17b1804b1-489e69686a7mr153151745e9.10.1776852656556; 
 Wed, 22 Apr 2026 03:10:56 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5c24d82asm10781745e9.7.2026.04.22.03.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:10:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C499F611A5;
 Wed, 22 Apr 2026 11:10:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 17/31] target/arm: use syndrome helpers to set SAME_EL EC
 bit
Date: Wed, 22 Apr 2026 11:10:28 +0100
Message-ID: <20260422101043.1234229-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

This removes the last use of ARM_EL_EC_SHIFT.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - drop ARM_EL_EC_SHIFT at this point
---
 target/arm/syndrome.h  | 1 -
 target/arm/tcg/debug.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 53137394e28..d4dfab8cd15 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -107,7 +107,6 @@ typedef enum {
 } GCSInstructionType;
 
 #define ARM_EL_EC_LENGTH 6
-#define ARM_EL_EC_SHIFT 26
 #define ARM_EL_IL_SHIFT 25
 #define ARM_EL_ISV_SHIFT 24
 #define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 5214e3c08a8..07a52643e71 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -56,7 +56,7 @@ raise_exception_debug(CPUARMState *env, uint32_t excp, uint32_t syndrome)
      * Similarly for watchpoint and breakpoint matches.
      */
     assert(debug_el >= cur_el);
-    syndrome |= (debug_el == cur_el) << ARM_EL_EC_SHIFT;
+    syndrome |= (debug_el == cur_el) << R_SYNDROME_EC_SHIFT;
     raise_exception(env, excp, syndrome, debug_el);
 }
 
-- 
2.47.3


