Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173A8D26D77
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFjw-0000nR-FY; Fri, 09 Jan 2026 11:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFjj-0000Ar-6g
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:53:19 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFjh-0007cQ-Hq
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:53:18 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so22773805e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977596; x=1768582396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hq3QhcR9ZU55rk1Z2h2O6JUZujdO6pgNZezjX6oFLNI=;
 b=GN/g+xBNzxp2uAMtAE2gRDKxAG+8BFrm00KMnRa5tXovbf7ggCDFU99dYhEzar4WWh
 IIC5t/e55Lv9eRvmvCdsi4/YH/cH4W6Yi53+d3WhA3aj7Bkri4hsvca7rrTJnXlsmISn
 9ZZhgkoSloal7gXeV5oVxFrw1NATMrCnPKp1K4oGk3S6pm1ZG6yeb31VCDvUbOJMCfbm
 R/frpfbgxP3wp3VrXr1VSIHgxdaWR3p7YkkdF9lNZfZnGdUKFx2cVNGJXuCBa+FWDgaG
 lAq+8GUbLzxQj9xsaiNsfblPKniJuZMTb1VH3WA+yCXdm8V3YaI0Twb1geYspLwhbAoC
 D/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977596; x=1768582396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hq3QhcR9ZU55rk1Z2h2O6JUZujdO6pgNZezjX6oFLNI=;
 b=hyGNFqaSGwvkv27fFjfXi1QMhizrgcPZTk2n/sq+LpdAoXKYMvkhPK0EMrGOiPuck+
 sBba9T229eVy1EP3MTL8qFKRdjcUsPztErT8KbTM21QyQlYICAsVQO7d99eylJ91vVS5
 lsSRUf8kKb1PtjYMvRH4iUy8+4oUDb+xnT13iM7B3HbNKtfXTumA9Y5CbfAd3VYUzCvx
 pLHA61IIXTFaPhp0bjp9ZdbDGg7J0OW89rzUbhS05tE2FRr/jFxfumTwHJcC0zrFh9Ey
 6SLYgTHeHUuu3Ym/Rt2xoinuPKpTF8tAIVXNXRUCYndkUyjajP0Fh/XkUov6wdXeSt4t
 5UNQ==
X-Gm-Message-State: AOJu0YyKjFrxGuNzsY/HYjp/5S0iq2M63fmJeWUy5a5pRcE+S3Qoq625
 TcoP4YsFMl52C8M3JEsrcjw18SSgIBczAR4wmSkkUCVaumfgkai4KegYEwSrmITOLYQ6lNKF3Eq
 gjfSiOxM=
X-Gm-Gg: AY/fxX7RJpCpSn8DzotwAwgj+w/fTteQRWTByHyADC1O+1acxcETDqZyldHPTe+IrSp
 IAdYcrdUicOzUX6zKYR7lP3CLYpfGIS6CSRB5JmE8jZ5cqX3RxNS8w65WTeurdhIGIzeg3TPFpG
 W/K9xJebI/0N17bahNK62QJIC1F0hGSq9McZaSjnAPnwUnX/wl0Rx+PN4SkY5xzt2MT6DhvVurw
 0dcdL6OzbRruV2owaHxroC0Xp+vShWFZttBlS01QI9kRpoEtpEtoA/rj33vvqmNBHCSQ/eDst0z
 ul6jNnNLmCJe9zE9V6g+TZTY4G/NLTX4SjDZFg/x2C+u9rH+BlE5ritAcKJJDNZUZYMZbYLvekX
 1gtbG3dU0xV4tsRkk9qKt2BKpH+D/PgQ2k3vLbvhCmb/OEXEF/ot8ePACLLowUFEBiJO9NY4S9H
 PA1qYJmNfiOYXlJ1WCdL5H1SORkOudbYe8gCtSDEY/MegMQuTNVvC3hd1OrbtB
X-Google-Smtp-Source: AGHT+IHBPKB+l4Tne/Qv0Se2fqW2jNnzb82gB5JkbXs8Dh6Y3xNvbUGkaK8et7RhJpA1icIcVTe32Q==
X-Received: by 2002:a05:600c:6308:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-47d8486d60dmr94069575e9.9.1767977595738; 
 Fri, 09 Jan 2026 08:53:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8719d057sm65489135e9.16.2026.01.09.08.53.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:53:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 20/22] system: Allow restricting the legacy
 DEVICE_NATIVE_ENDIAN definition
Date: Fri,  9 Jan 2026 17:50:56 +0100
Message-ID: <20260109165058.59144-21-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Guard the native endian definition we want to remove by surrounding
it with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.
Assign values to the enumerators so they stay unchanged.

Once a target gets cleaned we'll set the definition in the target
config, then the target won't be able to use the legacy API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/memory.h  | 8 +++++---
 system/memory-internal.h | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 92028dc7a4e..8f8725ea2d5 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -27,9 +27,11 @@
 #include "qemu/rcu.h"
 
 enum device_endian {
-    DEVICE_NATIVE_ENDIAN,
-    DEVICE_BIG_ENDIAN,
-    DEVICE_LITTLE_ENDIAN,
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
+    DEVICE_NATIVE_ENDIAN = 0,
+#endif
+    DEVICE_BIG_ENDIAN = 1,
+    DEVICE_LITTLE_ENDIAN = 2,
 };
 
 #define RAM_ADDR_INVALID (~(ram_addr_t)0)
diff --git a/system/memory-internal.h b/system/memory-internal.h
index 46f758fa7e4..5f0524756eb 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -41,9 +41,11 @@ void mtree_print_dispatch(struct AddressSpaceDispatch *d,
 /* returns true if end is big endian. */
 static inline bool devend_big_endian(enum device_endian end)
 {
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
     if (end == DEVICE_NATIVE_ENDIAN) {
         return target_big_endian();
     }
+#endif
     return end == DEVICE_BIG_ENDIAN;
 }
 
-- 
2.52.0


