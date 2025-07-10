Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E866C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZsVr-0003x2-Rm; Thu, 10 Jul 2025 10:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZsVb-0003uj-Ts
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:44:24 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZsVZ-0007mn-RP
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:44:23 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so702911f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752158660; x=1752763460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IwL1dqDOrIKJZCfzkxOD5rZXt7mV2IMgDmRaq3qIHsU=;
 b=UAvS4UVMg2ZQyPSpT01Y8aJGI38+GSmrgtklDvGwyoQryxVHPc0WQ1sby+L0VfRD7b
 Vcyd90gWHByFRF39GbFJJgShlePut5AkMxE9hLCQhoI+uhzuaGT98LQfd9VO08XczjMd
 puPJGqEPgxfPy6U0pFikohfZK/osc5LXbVlxx5jNYZnkNsViFXh96e+pS/xI1ZS/VCj6
 AbXZ25J5fns5OtLrEQ7M6YvE/lE2VuZHxabREvYXVRfV8LtCCbrWWh/r3Dqye4w/7Xbc
 OT6O4orzdxuz6SINvUOfA2IYIsb+XR0wn+C13Hl5wz7OtUGbqNndwqTD+Uv2zu0THJXh
 j1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752158660; x=1752763460;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IwL1dqDOrIKJZCfzkxOD5rZXt7mV2IMgDmRaq3qIHsU=;
 b=HO53oJkU37xVfknx6fMm4GE2/jakGq78Gzvw8M4QcdzoFP28E+m00NNMh86dJTXeCr
 XvgdZ+QLq1HUqN+gI9TUGFxxD+1yNnBIRe8kBbW79GNDGzSIyR7aU4lilcxwAhfeBr0r
 QmVFX3rVwEmMszAq5oXL1ZPNVsejS/hzPeAhFVphiQ1diPf3qpSRnsWP4sHrRwLGzHbP
 rWGpBsHtX3zv/anHBRUrItEMNXmcuZXOv2hz2IgaK2AJu8ivhJtL8MQABLPyiSI4yzMz
 QTAwhV9L7wV8DrciTf3PztlMGA6OouBRczUsfu3KOoeFjsE+gWxkN0rhW6MVfNWPCQHL
 rXAQ==
X-Gm-Message-State: AOJu0YxjU154AeD+efheK4gkXrczhTq/3DaOX+SgmD8rxi2nHFHl9wXK
 CVo4JNedWTHYQ66eLg8+i8SlYFPTo5WK+tGYEUWQcKLKbGN8l9RJH3VZUEKW+9paNnFG+Gqx2gi
 89NCX
X-Gm-Gg: ASbGncusd0welP2ubLL5rOjkhD3c3b90A4fN9Ct1OTT+9p8biT7+wwV+U2fHCWzOjwy
 XDM/o7+AT552KfWc8tMjap31avvyuHSp8KIQuQzfHLSa9oBXgO6v5YJIqRsQHAm1MOJV8b8bEE5
 kBu8gzNbxdqgz40CwqOocZLrqPlqCr1HHy3FVcQgfRsR2xYMg5WXWRxWygP9oOBQLdBd1V3O5pZ
 ff7mOm1zlnoYogQxBEdMTrEJrYlNmcTanjzrXAndyiFglYogurYYfZRqx6Ast1nEDel1FjXrm8O
 OSf3W+1vOsAsHfkXWzunZRqHzSD/JxjQN30+5uXDZvCBRD4ZKXr1DG5IpFRjr9cWwzdZ
X-Google-Smtp-Source: AGHT+IGDZ2h6+RMKjEKd4y9rA9JQ479kJx7z7p/4v6g0i8r5OObhRTJ/GhM2W8v5jwOJWzmdwld7vA==
X-Received: by 2002:a05:6000:41ce:b0:3a4:f7db:6ff7 with SMTP id
 ffacd0b85a97d-3b5e86e038cmr2890280f8f.52.1752158659796; 
 Thu, 10 Jul 2025 07:44:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1833sm2010834f8f.8.2025.07.10.07.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 07:44:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] crypto/x509-utils: Check for error from gnutls_x509_crt_init()
Date: Thu, 10 Jul 2025 15:44:17 +0100
Message-ID: <20250710144417.1187478-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Coverity notes that in qcrypto_get_x509_cert_fingerprint() we
call gnutls_x509_crt_init() but don't check for an error return.
Add the missing check.

Coverity: CID 1593155
Fixes: 10a1d34fc0d ("crypto: Introduce x509 utils")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 crypto/x509-utils.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index 8bad00a51b8..39bb6d4d8c3 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -46,7 +46,11 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
         return -1;
     }
 
-    gnutls_x509_crt_init(&crt);
+    if (gnutls_x509_crt_init(&crt) < 0) {
+        error_setg(errp, "Unable to initialize certificate: %s",
+                   gnutls_strerror(ret));
+        return -1;
+    }
 
     if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) != 0) {
         error_setg(errp, "Failed to import certificate");
-- 
2.43.0


