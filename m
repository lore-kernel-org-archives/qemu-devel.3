Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDE4E7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtxA-0002ZJ-DA; Sun, 15 Dec 2024 14:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwn-0001g5-Am
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:33 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwl-0001Hu-PC
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:33 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5f2d5b3c094so725339eaf.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289590; x=1734894390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ATtwQCefwxDmcYM/q677d/D/wRuo4QtIQ9za2txrGkk=;
 b=EwsCtyh+QraUjogqCkw57795a9Yg9tuPiepYpgMQs3oGl1gdhv9nQwC6/pe2TrPKb7
 RL8ykVxZOSiqB2JT3k+Phh5PMp4lUWhUT7aMB7/SoGu8O9Rv25CGw4XjQ+GbgK5dbFJq
 78fzFQO3o/xDxCC0YZVwiBY9MlHhM7Tt6z0mlQhrfw1gXXSTVqXN1m/akdPwDlLZJS0j
 6Yb+BnZSoJQTyI0iQi6Go5QOWTCOuZ2sQA3r6ljZHJKhMWTKjsK3v151sKgPyTE3SsNi
 QaTpUxE00lBDOx1Knh5e/VbAwZnjIzTTL2o7jOiAoK82azFHqURRb7qnz5CSkLbCPnkx
 tA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289590; x=1734894390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ATtwQCefwxDmcYM/q677d/D/wRuo4QtIQ9za2txrGkk=;
 b=KLhIdy1kinEu01YRr2V+lY0rhslUsASMPBpt2KNtzEDkTJA6DdG6yePw/UTiB6g4BP
 Q9tsBECMUv405+lM5kchjeSGV76iJSqCAY/7xJ6MDUpwZHmmTHZEXctP9BAkusEUco16
 ogyGqpCfTpG3jlBaybfL8HyQfNcqDdu5oKMQT/vZX9n2NQ0IgsShE+45Ss8lHcZBhPDq
 N43BbFUHg53DuQrK5MrGQK1lEU5Pr5NP8UenR8ySNzIiNsgYjWHWqSfG+8Oa6gx+hlOr
 WEWgifRkyhRXHrKjNWMs1pkF474otSHr+elNw3fUhFoXjgJx/OWvrZ1Dp5M1Jn97t58N
 obtw==
X-Gm-Message-State: AOJu0YzefWNwZeBWMmPkEt2/p85cOB0NKLuNUHIy9ojfYReAeQEygyPi
 hhbTzXFERfzKI/IfRzxov2R5hzrO28+OyBQ8vM+p1mJFa4Oql4aONq8W7eZLus0HW4+fU7Ics5C
 hBF8m/RZp
X-Gm-Gg: ASbGnct2n4aBXWXKSEFdYVh/pg0y/D836FM//BohSk7nq6nkULnMIILQQG5yvrzOKaw
 Iq6naL6WEVktGMafp4tyddTdI2++iuIAeQHSr8EFEQNGoP6DtaVaY0LwqGawXS+DtrtEScRpEl+
 aHfu5W9PoxQV2tQUgtaDBXQWp3wej0/6ig7h8mK+0tmWuP8xooOoaDIJTrV8jVM99d/TK9OTn5S
 7ab+OS66PmkCWSTbnxKdwontDsSzkvHiRuTgyydwuEd+NQD9vQUfodJdWAPmY9a9kWFoaYc5NiP
 DPm1hLGS1ypScw1Iz6+TIb16oEe9nu/RJUuG7SWhImU=
X-Google-Smtp-Source: AGHT+IEZ4IlnLMje/ViaSSc2glQE2SRrIF9ytnNa+2KeQEabSQoX4uznGVH3CxXdpkOrIDSsfX7BAw==
X-Received: by 2002:a05:6871:5814:b0:29e:5a4c:4ad8 with SMTP id
 586e51a60fabf-2a3ac8d9e7amr5253466fac.40.1734289590247; 
 Sun, 15 Dec 2024 11:06:30 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 38/67] hw/misc/xlnx-versal-trng: Constify trng_props
Date: Sun, 15 Dec 2024 13:05:04 -0600
Message-ID: <20241215190533.3222854-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

Use DEFINE_PROP_UNSIGNED instead of DEFINE_PROP_UINT64
so that we can set the PropertyInfo during initialization,
instead of updating within trng_class_init.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/misc/xlnx-versal-trng.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index 86905479b8..2f6af4f680 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -660,8 +660,9 @@ static const PropertyInfo trng_prop_fault_events = {
 
 static PropertyInfo trng_prop_uint64; /* to extend qdev_prop_uint64 */
 
-static Property trng_props[] = {
-    DEFINE_PROP_UINT64("forced-prng", XlnxVersalTRng, forced_prng_seed, 0),
+static const Property trng_props[] = {
+    DEFINE_PROP_UNSIGNED("forced-prng", XlnxVersalTRng, forced_prng_seed,
+                         0, trng_prop_uint64, uint64_t),
     DEFINE_PROP_UINT32("hw-version", XlnxVersalTRng, hw_version, 0x0200),
     DEFINE_PROP("fips-fault-events", XlnxVersalTRng, forced_faults,
                 trng_prop_fault_events, uint32_t),
@@ -694,7 +695,6 @@ static void trng_class_init(ObjectClass *klass, void *data)
     /* Clone uint64 property with set allowed after realized */
     trng_prop_uint64 = qdev_prop_uint64;
     trng_prop_uint64.realized_set_allowed = true;
-    trng_props[0].info = &trng_prop_uint64;
 
     device_class_set_props(dc, trng_props);
 }
-- 
2.43.0


