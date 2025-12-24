Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD5EE77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQk3-00065T-66; Wed, 24 Dec 2025 10:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQjy-0005eO-3G
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:25:30 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQjw-0005Ax-It
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:25:29 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b7a72874af1so1037432266b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589925; x=1767194725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7tE0kUMhdBqFLhbKfrJibgQATMsXG5ZR21KHojJdYE=;
 b=N801J7LyrW+IVMe0ehUcSpQbRHGlVVisSRKe4gkKZrPKddfRggHRzs2Ss103R4+UEI
 2DWXb8/siXml87nLGNHiI2Re8ASoDeaNn7icLVGDNGVeSxq+nuyjm8E3jJWmXVpcTjCu
 gz5HIRQc1vD4dgdmPijhjVIOAh8rlybLNWE85zTw8paH0PjXjKXRW7gTO9ECIfXJDaOj
 tIb0wKkCXPimLZMnHwQUr0KLyYtGQBp38wpLfhynGCcY3eneOieVkP6AlaZ5niuNQVeV
 eP/5EDitRwqT1J5jCB7Ekfzgjaal4CjcRq7v7KP9QjltIRNvJu3r3NqEZUMbBa+3XK8T
 GOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589925; x=1767194725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D7tE0kUMhdBqFLhbKfrJibgQATMsXG5ZR21KHojJdYE=;
 b=PMzcB7Cwjng4QVkUxjnBSZp/09XtCwtG0ZSCkVsLIWlHqULk1BfWv6BtdgL58rslsJ
 0N5PqgWQHgQC0Mqj9d8YsEzX/6roNKrMhbYMbueQvk4oS/GmrnHgmn6fj19Mm80HY/I9
 YpCjt1lgireC13t+TksQgt436UaNj/hPOGN9ZBSnKMDLTBgRm353MkoJOsjMhCKBxC3N
 k3Rj997uLPAADBsJrLCIX9bt4pmXUO6GQwR5RKNrFjIWA7LisS6Rg1PM1FqMrAdl9kHx
 81SsN/+Wq3efTXaan45d9L3eN4RddaFuWrnx97Tfm6+s1gU7DSFDI/6WI9jYEG66qxRR
 vGFw==
X-Gm-Message-State: AOJu0YzeetL0m1rleD6ziiYa+xCgBWYF2iKLIDA2QVwk3siulXjveq8+
 ZLQVXss3vMyLTlDadvfeLpWOdTdBXY3BY4RNLaHTwS8zP0NGJijv6uMnLPD/r23KjS43UooYmqY
 r0n+ekO0=
X-Gm-Gg: AY/fxX5SgfEA1hKglxWb++3qQ91O+QD0QXZYTrNsz1UbqEtBouQjr6XwISgNPSbhc87
 Ze2W5Saj+IRbZXvwM8EJCEHnZ93WHVl5Er+cespPtkUvZ2ywAgClkyXtAA4yA1LPSHHcClsiw0W
 AaX+UE6tAtXxh9Ho6vPDWs5HOk+b+VID/8D64o/v26I+yggPr2L6ZzQXHaClu8OKkBELclaQMwE
 kZlBu0U6lruzO1rhutzXPu0iwiVygVeP6YfO2P3VOQ0+6l8E/KdwLtR4XRd1jK/3pQaPqMqE9xT
 IAHvvfgl2mraqQV4cEmGJhjrfQXIrDs2AreuqD5u3j9U/CfLT12BbQNHt3ROXxGdUhTrejNKHcS
 mb63fgdJICXpvI44OqjO5cGQvZjSXk9HbSIdLGCifMUxRIBvHn6547Vh/hnYBWeGqvllPqCIKOw
 jWsAuMEjjnlJwV8as05G9mAez5sSxoVT7XF4BP2bEPIXRbbuehMyL+KhWcBSSHHdBuEA==
X-Google-Smtp-Source: AGHT+IH/YZO/ZzZMHSLASKGHQF/sn5WdX5DbbnGdufWHLO3HjhOifNymbSwLRJY44D1XZN9Sid2B/A==
X-Received: by 2002:a17:907:6094:b0:b73:9368:ad5e with SMTP id
 a640c23a62f3a-b8037051288mr1893766666b.34.1766589924977; 
 Wed, 24 Dec 2025 07:25:24 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f51a74sm1824118766b.63.2025.12.24.07.25.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:25:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 20/25] system: Allow restricting the legacy tswap()
 'native-endian' API
Date: Wed, 24 Dec 2025 16:22:03 +0100
Message-ID: <20251224152210.87880-21-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

Guard the native endian APIs we want to remove by surrounding
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/tswap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 72219e2c431..9e94fa0021c 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -21,6 +21,8 @@
 #define target_needs_bswap()  (HOST_BIG_ENDIAN != target_big_endian())
 #endif /* COMPILING_PER_TARGET */
 
+#if defined(CONFIG_USER_ONLY) \
+    || !defined(TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API)
 static inline uint16_t tswap16(uint16_t s)
 {
     if (target_needs_bswap()) {
@@ -68,5 +70,6 @@ static inline void tswap64s(uint64_t *s)
         *s = bswap64(*s);
     }
 }
+#endif
 
 #endif  /* TSWAP_H */
-- 
2.52.0


