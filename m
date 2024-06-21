Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBEDC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 07:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKYKJ-0003nm-4q; Fri, 21 Jun 2024 03:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKYKI-0003nE-1i
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 03:04:50 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKYKG-0005ES-Cp
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 03:04:49 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ec408c6d94so19968361fa.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 00:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718953486; x=1719558286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G147CzmBVRTe44+2guDyikKNInZHpzZll0uolwq//h8=;
 b=KHlF20oUsOlFG6SsUmduhO5Mi2ZNaqdMltumpo0F18W2VE8t9oD877LcJLY4decogl
 8W7BE1F1x+N/CDCXsXZPVrO6fkypMgXwNmcVveizCDH9xqDLDCOAneALAzJUmHKHpxPV
 fPu7dD4FbsycKnvUm25BP34/kP40kW1+HFdW5nMnKef4QKspUark41piZ9yYhFO0Gd7k
 FVpMAxMyN+vKtjR2pn+wEmZ6yryRbcVCXkQkYildPQfNFlTwtc8gIwMSSugLOLg5Nkdr
 Wr3aNhyPZXhGf4j5qhKowx7NsFHKxz2VRJxQ8hIAhCmeRtw5hFnCeijzDIi+pJX1OODj
 t9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718953486; x=1719558286;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G147CzmBVRTe44+2guDyikKNInZHpzZll0uolwq//h8=;
 b=m/FRFStfEUcak+rzFsaP5oRZ8n8+QmtqMhmSqybBTyucpiB0rjwGRTF63ujv9Mli27
 ZNy2dHKHcwLPhHjQDgYzfURrqLupQT7t8MWgI7arUYsSYeAobEWh4D8aCSPHnXxmh6SN
 tlF+FJ+kPElZKw+bZcl1ucCSfXtZ6OwP1ECXCdu+oOwgM8u518SefKjeQVyPmMUCSZBO
 zOJiNiJj70oc0Vy3Qmb6aF6HV7Xp0SmWN0EmBntuNIgLrI63E0YYVL9yj8z/WxuvJ+K9
 EvwOnWqPFkvqXruJnGvlu5/2y+PIcKLdcHNyyNBna+c4m1YuRzRK0agTZO218WpLtpSS
 krMQ==
X-Gm-Message-State: AOJu0Yw/g4oMmsYPwVbK/PEnQ4NiuAvMPRSGPl8SaU4Gj+N1AVONAmol
 6EVy4aiesudsRoWmHAZimMT3DhWTPfLjWsAIhXXFsZRNi7DaAXLKoZeJKsdAkKLlJdAMB7VZ4jP
 k
X-Google-Smtp-Source: AGHT+IEkE3YsMJo99CVLZ8DLCCcoEsQh/oMZuXOMZ/c+RlqGyb5Aw9cJOq1LT1v0DKDqY+5ll3NkrA==
X-Received: by 2002:a2e:2c1a:0:b0:2ec:1a1c:75f with SMTP id
 38308e7fff4ca-2ec3cffc87emr45736111fa.51.1718953485871; 
 Fri, 21 Jun 2024 00:04:45 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42481921f16sm15084975e9.41.2024.06.21.00.04.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 00:04:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] migration: Remove unused VMSTATE_ARRAY_TEST() macro
Date: Fri, 21 Jun 2024 09:03:17 +0200
Message-ID: <20240621070317.9670-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Last use of VMSTATE_ARRAY_TEST() was removed in commit 46baa9007f
("migration/i386: Remove old non-softfloat 64bit FP support"), we
can safely get rid of it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/migration/vmstate.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 294d2d8486..f313f2f408 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -388,16 +388,6 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
 
-#define VMSTATE_ARRAY_TEST(_field, _state, _num, _test, _info, _type) {\
-    .name         = (stringify(_field)),                              \
-    .field_exists = (_test),                                          \
-    .num          = (_num),                                           \
-    .info         = &(_info),                                         \
-    .size         = sizeof(_type),                                    \
-    .flags        = VMS_ARRAY,                                        \
-    .offset       = vmstate_offset_array(_state, _field, _type, _num),\
-}
-
 #define VMSTATE_SUB_ARRAY(_field, _state, _start, _num, _version, _info, _type) { \
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
-- 
2.41.0


