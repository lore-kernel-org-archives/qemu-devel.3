Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2CBC36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwPh-0005YZ-S7; Tue, 25 Mar 2025 01:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO6-0003zA-Sd
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:42 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO4-0005wL-Vb
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:42 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3014cb646ecso6658798a91.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878780; x=1743483580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+5iQ3rOTBSPEFMTgcjt+dky/l4beaGAM9ptuF8lc/c=;
 b=ZcbGS3KlZYKbFu5SaBibthPHcGKG936Io77BbwYUpn947lQ9vOFGnXHiAzWs3JP88K
 A83KXfnMqWWZhD79INMrrnFxbkA6si6tRUAcZGtebk783JuW1ZmUp3Dssbu1/Tmcm+9/
 x0adJ6FJqhZJqfHqOvUJBZk6dyE3qZuTpG9DEBebb+A5vuQJS9wd4byzPCABPX6xwQ/I
 6bkxN+GudkIQWlSa1ciVogTc1An1rV8Q8QGPw8mCNONTyN2H8GTs6zxRbPMEdns49V5/
 tH1SMWLmQ+DkigC72AbuoAaNJE1Z7v1kHQrfPLGV18nP8I+AzOYm3gAlfwQ1yusU9MME
 iMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878780; x=1743483580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+5iQ3rOTBSPEFMTgcjt+dky/l4beaGAM9ptuF8lc/c=;
 b=BKfEEsN+W7IoAKDtuRqCk8nEHjn9qrd0YTpqrshhz7UMNJp2IG7ngKHFDXn3z9GlDk
 T+VAJLcbsJEMRFJ6DpwDK4vaV6azVHLE1We+QFksDdmx7SV5/MhgVfEoXeU7LOsKwODd
 pd9YOEJHwGqn8HE4b66ueGDlye7O8i7fgMJv3dqEV9nRhEZt6mez6ws6EcaJxE9m3Hra
 cC/23H+HhYAsOqHKWtjfq9MtgmoX13rlsjOSUHjUeMnm1omsyhSDLahnsyRh0LFgoNog
 7+x4Co3qq1GlU/RNQzMsTOXr0vDKU5Cm+OnfplFFgUu+QPLQGXxINM68ld4AWLL0z5yf
 5QJA==
X-Gm-Message-State: AOJu0Yzqr2ibarGOI3AUuWX7cydVnJ+cM1FFNqJyIBEOesf8+//21BtN
 g/Z3vRVkZvnZ5I5uWiEfRWXLVRX/VneiH14mCQZ2ytaSFbvOTPek0bKK75DneNayfSDkK0V75FY
 C
X-Gm-Gg: ASbGncsn8PELQQp3LBD6vVjdzG4PxWW8uvsHtNa18bAE7cSGuYWcwFXtJD0Cdrr0zEO
 8iQLZ30xYH0yINCfnCdGW1eCItxBKv7LI6yvvl67FlmpkYkSgDLpK4S85lgjiclx7GuxsDdjX1g
 AIon/CCzu78hfkP3oFkxjy28Wj97uumrcmfBoS3C379pDgqKzHwEMV8loXpGNKrkJU6ubILaQmQ
 1cSojzUUpVKu7L/91AMBKw5hQcROz2KEAEybTNrAeq0HenQjPdSICNmCOUgETLJpqDRmA5YIjl1
 AnzaTjYXZsrbsBqHUOHkEGCygiyaxX79iAiSmiCrPJ43A6r51r7vXBc=
X-Google-Smtp-Source: AGHT+IF9WVopZDKCf5Wmew5zTPELxpFqytptelvRItKxrWFJ/xOYMD7CXHGJsHww4nAXXVInApX4MA==
X-Received: by 2002:a17:90b:2647:b0:301:c5cb:7b13 with SMTP id
 98e67ed59e1d1-3030fe552f1mr22108739a91.3.1742878779554; 
 Mon, 24 Mar 2025 21:59:39 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 19/29] target/arm/cpu: always define kvm related registers
Date: Mon, 24 Mar 2025 21:59:04 -0700
Message-Id: <20250325045915.994760-20-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

This does not hurt, even if they are not used.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a8a1a8faf6b..ab7412772bc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -971,7 +971,6 @@ struct ArchCPU {
      */
     uint32_t kvm_target;
 
-#ifdef CONFIG_KVM
     /* KVM init features for this CPU */
     uint32_t kvm_init_features[7];
 
@@ -984,7 +983,6 @@ struct ArchCPU {
 
     /* KVM steal time */
     OnOffAuto kvm_steal_time;
-#endif /* CONFIG_KVM */
 
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
-- 
2.39.5


