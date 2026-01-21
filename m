Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09F3C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 21:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vigC7-0003pH-MV; Wed, 21 Jan 2026 16:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vigBq-0003kj-F3
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 16:56:42 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vigBo-0002jt-KJ
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 16:56:38 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so2571495e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 13:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769032593; x=1769637393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjUmEMjjoWbNCSiwKUvl5kVXL6ytJwqVR0CrllmLlis=;
 b=x2jpgOBQWFAL42S/eKSoS+CuA2gsXDNrPNcVYXVTBVTzOAKTNPOtRXmk9fATFUFIbP
 MZmV6EhFpMmES8m6d13pPO/FtMXaedU3R+5kueDdYrcY6rtlpNMPf8DpAzHOzZp+vyCy
 8lDMjCGFX7/3aj/PfvM802iTsmzpDsZTQELKXkggH0F5cqagMUBSr4c6LdO3w8kCm1/C
 CQOAjmGUTCbaYc1LN6m8OZrM464uC6rEq7YMhjTptAlsqE8BFCVt8ozt7zr31GIt5Vu3
 dQXqIYOjQFw1k0a7UqXJQ8K8vM4kmhXKPDbzmggFbEuv83v1WgX4whW80WGssX91zMp1
 JlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769032593; x=1769637393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OjUmEMjjoWbNCSiwKUvl5kVXL6ytJwqVR0CrllmLlis=;
 b=o5AK3YEZjbQbBoDaT6bpKQ9exdx+dWUHZ197YJFj4kGNdtEpk/E49G9GVcZ1dkpOxW
 fzTLGGaYuz1osym1W9vxLB8cV/fMGjrb5Os16K4tck9ekv+dPBzUyQ48b0eMVGQddX//
 V+S91uNuGJvuXTRLOo5magbMZctRk1Vvi+qR+CgwbH4TTlZa1m4y/or6qZp3bLsjTy+J
 cpq9YzeaANHkiOXaz0TJxMi6DEXwtre6VhxpVqvvLXfOLaOy4VM2N9NgIBKBot3Ow3xM
 tOVIB7sZ+fv55AdsTJDsnrg0R74eNRc48rQj/YxYCrogPLZGW0JZ98odK5AZMrH5ri9P
 Yg/Q==
X-Gm-Message-State: AOJu0YyEiwuXIga8SQFzxyVfNs5qrx5uiSwUoJvbq2aGpmmmpFohf73t
 8gtQBp+DrDkwygubP/4Ta9YLIdHjqkeAkO+v+320kQdLecI2SCQF3e/3JDyS5+G5Ka2q3QbRdha
 Jc14xPf0=
X-Gm-Gg: AZuq6aJecAOw+Yhmf2p94MZzVJOatESZW2m9cSAqIZ9VSy9w/gC4MLEKTYdda9uded2
 h0/Rf4bLm6ImS2oJ2KFedaVb1qgv62BfU8MhdsC6iXz6J39Y34aTF35YT7V5Mh7ig3anjCcHyiR
 FrDwkSDqMJRh+rT7rlg/RY8YhiMyEZ9XoZ6T2SLbbVgYSQGxHmLyugwjypRkxmYEWhCRcYcWKMg
 aP5EabwKDm1sGnwsid39nj8mWoO7WMVu9s/4pmtYh4Y6O6qyJZM/CjxEnHMHKFft4Cx6CpT8Ou8
 UzlCoM9o8WrSexzvGSphH/0FxRQ3L4LrbSTedJulGcKTqsH/qVJPTQPoMEsrRZtNtuNcHfkSsRR
 4XMlpxlfcEWrulPENX3WZ563Y4P1UEFQv07Vbwi8FRsfMxKFXLfLBWo/EsCs3MLN1Q7eNF1mUI1
 Jzcwxk6XKcDEgi/KbJHMTShDf47/KVCot/NbJUEnsm3DtJ/V8RlfyQ75cxr+9K
X-Received: by 2002:a05:600c:83c8:b0:47b:e2a9:2bd7 with SMTP id
 5b1f17b1804b1-4803e7e8555mr99020665e9.19.1769032593204; 
 Wed, 21 Jan 2026 13:56:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470472f1sm18370325e9.7.2026.01.21.13.56.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Jan 2026 13:56:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/2] dump: Abort in create_win_dump() on non-x86 guests
Date: Wed, 21 Jan 2026 22:56:21 +0100
Message-ID: <20260121215622.92966-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121215622.92966-1-philmd@linaro.org>
References: <20260121215622.92966-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

qmp_dump_guest_memory() checks win_dump_available()
before calling create_win_dump(). On non-x86 targets
calling it would be a programming error, so abort.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260108161220.15146-4-philmd@linaro.org>
---
 dump/win_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dump/win_dump.c b/dump/win_dump.c
index 3162e8bd487..6e07913dfb4 100644
--- a/dump/win_dump.c
+++ b/dump/win_dump.c
@@ -489,7 +489,7 @@ bool win_dump_available(Error **errp)
 
 void create_win_dump(DumpState *s, Error **errp)
 {
-    win_dump_available(errp);
+    g_assert_not_reached();
 }
 
 #endif
-- 
2.52.0


