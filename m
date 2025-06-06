Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4880C61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaBs-0004pV-1S; Fri, 06 Jun 2025 12:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaBq-0004p5-2n
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:45:10 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaBo-0003NA-Ib
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:45:09 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so29892305e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228306; x=1749833106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o7y7S/WReThht8x9oOE0nYIkVcJDi5oe728aOgkzFNA=;
 b=YB1kiLwhwUQBz5ezGN/UKSyzbf/qY1MIOSvyngk0hSsLqQO75ReXWFk7XRmvZKNLQK
 nd22KMlKtvbLIjo6Vok8Xpdc020j/ahfZcHAb/iB5AjDXvFe9LemS66AhzE1a7f7mlVj
 jc08mwisiAc4mLG7dv3dpqVp+RdYeu0v8EDtgyK6/c6oG3Kp1l7v2aPXPHBBrjU8DewL
 SwHr3VACR2ouO2yKvIyL9sDrxxj9mWgKKXWAPyGdPc6rJ4Q6Fqn4ia7xUCO/kD1vhtax
 TpKT64ieHlJtNVoCjWrBg+86NQ4WDjpi70hkK6+RJ9hijPrZnP00ZU4UAQfVO44GbT5y
 QroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228306; x=1749833106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o7y7S/WReThht8x9oOE0nYIkVcJDi5oe728aOgkzFNA=;
 b=KKAeTUKSRUbiiJoHetTreSb/n046wlmLjOrtPDrIN7yyey7mEhLkufAMc272bOmOvI
 4PTgG36CmI4DjQPdXZ40Y+V7OFclOH8nC++T/zQ0mZmXfSazE9v8671F5Jtkeu8YyfdG
 vgjIvq/ClyghNX98IosOAbxMQSXnySVasdhbOEdiJBDwp6J8fWHNYS393Gt1JoIFAK9n
 Kcl3D7nl+G4f8eghZ9Pc0MA5dw8jipvgU4ru0LQSEYhZ4KMP0weMK3wTNVbM9wbuSNw7
 WVZoOaUOzgH6O4aYGL2BcaKPW2cNNSdXoN6qKbJI8ZGedyuTgU+IN/c4P4gKyEQEw1/w
 +S+Q==
X-Gm-Message-State: AOJu0YwBUI98KETgV5yZKirnbd62+AUZngbn0vC+rU4H0041X+F5iqna
 fHaNT0kB9wRu46HvvFmbU676grV1mdome7H8M+fgWC032jIS5VtNreuIJEBDBSOfsGIuoCKW6Du
 h9tbxbZKgRA==
X-Gm-Gg: ASbGnctMwXcNiV/2D2PY0boadqR2cMH4PMzRikA1YiN0qHYUWuc49Tip+nmtpB4QZaV
 49gDRa+W1m6OMXzJvjQ8ZOi66VzdFbr8/VBvyKTA7bnIArlCbNewBH48w2IBleVcdsXrXDwFyqL
 XlFJBfcM5BTIaQJtHn9apt3pNvbHCxX/ZeR6PZNV4xHQXTfTVNhIKOtdL9x8nodbQQ+1KixXMNy
 DnaXb549fgkI/O9tGsPP9GtaVS5C1AuxM4vI4InRSVMb5ujpAUlcZiLMLKFh3ZbVYq/AkM91EDu
 tDJslB18U9SHBRc52+L0RHmkxYMjgRnEnQiGjsdb/Bj8TBELU+71tfKhK95B5of4cLj2KI/Qj0D
 lInkKXFF/XUOAUuEnaZi+9oyEBN1u+F0qPsy+cg==
X-Google-Smtp-Source: AGHT+IFD/vFGIhtbLTFZGOwNSjbgw2uHXMwoYPW2JP5oR2ndiyg/Xqnj8sXjw6qI/td9t3/+vfw2Uw==
X-Received: by 2002:adf:b304:0:b0:3a5:39a8:199c with SMTP id
 ffacd0b85a97d-3a539a819d3mr628116f8f.53.1749228306563; 
 Fri, 06 Jun 2025 09:45:06 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4526e05636dsm28158215e9.4.2025.06.06.09.45.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:45:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 06/19] accel/hvf: Fix TYPE_HVF_ACCEL instance size
Date: Fri,  6 Jun 2025 18:44:05 +0200
Message-ID: <20250606164418.98655-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hvf_int.h  | 1 +
 accel/hvf/hvf-accel-ops.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 8c8b84012d9..d774e58df91 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -44,6 +44,7 @@ typedef struct hvf_vcpu_caps {
 
 struct HVFState {
     AccelState parent;
+
     hvf_slot slots[32];
     int num_slots;
 
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 3dd9de26dbb..808ecea3816 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -366,6 +366,7 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
 static const TypeInfo hvf_accel_type = {
     .name = TYPE_HVF_ACCEL,
     .parent = TYPE_ACCEL,
+    .instance_size = sizeof(HVFState),
     .class_init = hvf_accel_class_init,
 };
 
-- 
2.49.0


