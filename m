Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F73C36002
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOSO-0006oU-RH; Thu, 20 Mar 2025 18:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPN-0002RC-9k
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:42 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOP4-000775-TZ
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:27 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22438c356c8so26171165ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509817; x=1743114617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WS56+yaDx7XPqQTsxGbqAzPgp+EeucvCf5WClfPP9c4=;
 b=ymKubAyexp7E7uNd57rF5CSRbwMSwPaTW2mdKdHs6bB/3OyMMmedVBtOvA0B1X9kzn
 LuAe1qCwzUaUa4V0NUVcH6X77s2R2YDjq2Qvz9FQwgGAVAxe7hcrIrPdgOsGK9xbZBtJ
 8Ly3F3954OY8R+iTiQFXJcSFSWw2Py41UgkTMHrXz/hrMLO2wp7mZR1hTcXXswtoegb2
 3ECzzlOVrR5AWIP3lMiqVLX60jVQrYsYkw2LX6p9iDXwr17bv7ltPHjQVsjV/5yte+/g
 TgIBh+YcyVc0gIOopTfIRI/DAMF/5qqrm6vXmxYkuez/c+bfuEQD7ZNLWCmqNBxtlIAp
 /5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509817; x=1743114617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WS56+yaDx7XPqQTsxGbqAzPgp+EeucvCf5WClfPP9c4=;
 b=CqlgVOgqvmh+V+ThP8czMMiv4lwWSv+NB3QF7NI+ux1SL0KoK4Py0n0syqth9gz9GO
 RrzzoBV4OJs4WJIvGItdDOHI37lL1ePW9bQxTs4S2MHByCDIUJXoSVxcLPM1LgEIwGDk
 UyzvnCF/kQEPMSvyRpor+7VJgi48iiZ/4ycKbyI5H/201XLiwOD16arFne3C6fJzpgZQ
 l/gX/9VYjxEalHbRlq9E/K5SnX97XOgYzf3AcIWNFuHhW/U+gPIUY17Lg6oVcy67rzPi
 DAv9KWeoJ4bNXG5E5mqmy3AQ/PQ02D1KZcW+/WqNozp3f7R73J0pdliMDBlrciu7E6WE
 hr3w==
X-Gm-Message-State: AOJu0Yx8WJRrsWewQr8x4xf4B35JPjwKgG8OfysH4KgqhlwRDHM0lszZ
 r6MnSXgBBV7aMmXv+FOrVcPfO4408oY/1fhucuP9j9vVmYQSUeccc9G16XAxTxjgHEjmb8eQ38t
 l
X-Gm-Gg: ASbGncvBva6jAmUllu9nlSsoTKy0Poy5MdJJT1/1sqAeh1XCGCaxX9JlsTVPUeMzhJW
 MqeiYkKdBa9bv+m0RxpraJQm/oYc53wNC0tZ5H7jVuqkUIS2qxmq8UFavFdVN/UQUr0Ihzwjg7s
 vabRF5fE+tmrV4T24D/41r17N6zvMJQe0wIrXdva2n+lDPgbw7QTbOXiQLOk0XVjjjmzvgT3RgO
 vVwR9YjYFK79nMVxZe9DTKJkeWirXhe0RQpRcMuRZPdyQMLtLVMMEwaw6LNFgL1QYDxmH+4Co/j
 h5KvR7jXN4FX2+RUMSAnoHLS7VPnV2H1KXNsZN1U3M/e
X-Google-Smtp-Source: AGHT+IG0vzDaHZgnC6rKOEx/scdI1YP63Fg9bCy7lK0T8agjJCI/Ay2Ce96All1W1vTYmlDF4RvBEw==
X-Received: by 2002:a17:903:41ce:b0:223:f9a4:3f99 with SMTP id
 d9443c01a7336-22780dacaedmr15783575ad.29.1742509817000; 
 Thu, 20 Mar 2025 15:30:17 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 03/30] exec/cpu-all: move cpu_copy to linux-user/qemu.h
Date: Thu, 20 Mar 2025 15:29:35 -0700
Message-Id: <20250320223002.2915728-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 2 --
 linux-user/qemu.h      | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d2895fb55b1..74017a5ce7c 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -32,8 +32,6 @@
 #include "exec/cpu-defs.h"
 #include "exec/target_page.h"
 
-CPUArchState *cpu_copy(CPUArchState *env);
-
 #include "cpu.h"
 
 /* Validate correct placement of CPUArchState. */
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 5f007501518..948de8431a5 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -362,4 +362,7 @@ void *lock_user_string(abi_ulong guest_addr);
 #define unlock_user_struct(host_ptr, guest_addr, copy)		\
     unlock_user(host_ptr, guest_addr, (copy) ? sizeof(*host_ptr) : 0)
 
+/* Clone cpu state */
+CPUArchState *cpu_copy(CPUArchState *env);
+
 #endif /* QEMU_H */
-- 
2.39.5


