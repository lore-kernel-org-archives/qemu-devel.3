Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42658C3ABAC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 15:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8tv-0002JW-59; Wed, 30 Apr 2025 10:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8tp-0002E8-Io
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:59:01 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8tn-0002gU-PP
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:59:01 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-309fac646adso1037590a91.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746025138; x=1746629938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBK8LHWqvAyuwDxFuuTqDb/KWyXEAnnOTejYROwMLow=;
 b=Pw5ug2X6nNhm3mmhdW+ki6XsGgSD2U8T6TqbCs92mr7f/4CW7w0pgemeACWXQmpM6m
 ofUpXQ0QV1KShxkQ/DVsCTrYqKCWFXUwgCrIZGG1ZoFEZFu6LfDaZjh9jGSg1cuoThCI
 W2SZJiXnzDfySq5F4hNgPmfLgqEtIRdBtocIhyqH4U+JLPYvHD/VqqA6JUlYFCMulyOm
 Ososn55irHKI6a7eboojkRQeSsOUErlt8UdbTjpkYfh8W0GqwGOpPk0Lgjzic7RXvv4P
 +j8LQJ5QQE6y7+0WhqRvwDIyqnATgDbBbBRGnvO3aHM+3ac6F1iM0vn3kKjKgUilpdkq
 k9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025138; x=1746629938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QBK8LHWqvAyuwDxFuuTqDb/KWyXEAnnOTejYROwMLow=;
 b=Q+LiJKb3Nj0aifsZv1CBU41Ayx7+PYc4mULzHDE8Jp9jq4Ffx9t/d4tqP0gl2gV7dC
 ahzCDT7FD3ub7qfLreLZvipjI8jtfD91qKlmp+V2iU4Ty0TbpzYd4W64Mff4czjgKsId
 oUY3XZeoUEkO+4Go+N1ASYNvhzSLywv+okH6d6OuupOB++X9jyEIq3p8b2BhuShpdoQr
 aWGUGjBS3xuL33A0ogWIyIX2wtBfVubQQGNWNhih58xukO+Z8ojpjF2wcW2cupraaJBc
 i7nNrTFs+PXT47pV/o+lEF7CrVeeLGe5O2r40zW4o2HbCiRD7hY4jxxKMw+yqykdEdQ7
 s2qQ==
X-Gm-Message-State: AOJu0YwXBBzU6wfL1I6aFsv1jM9rgzLDnq/regzwfqEN3qqJAHSsp0km
 6Bfd3APshDNBNEOxrmqI4DSWSYesg7p0nCswmtmdq4u2/yzbyV2pIZEeChD1OBJ6aXNBeKjqcas
 g
X-Gm-Gg: ASbGnctW6rg6FsX7WUXyU+x51tRCyYsuKauoYXdbjfQ9bSw7K8hDm7lBvI40PSeg5LF
 1qNOT6maYHe8L+IVxVuNlIVleuz8+mvZW+AH6CLel82nKAFrf8Eohii4LoEsNInw9BaS5pKKoFA
 Tw4KyY6WluMCYZR64CCcumSry9FjizmupcpG+ATedqsmwmzbC6zdrJB9NrsejTw8NhJ1S1Kablx
 zulTD9aFyoCZ1HLI2qzzdON6J40BibsG2KgbWoLdYSb7oIcrGNrlnHVVUPB9kYC9gyyXHWdT4Lb
 Goa5zWvsx3iPWtqtkVAMRYOfVAuoqnN2gDuqvLiU
X-Google-Smtp-Source: AGHT+IGbHAOKE7iuPjYSBIxBLMfH8W4TYKvNqESm7rCnzFL3W3NNnV27ZkpuMRRPW9MKndTzkiNmbQ==
X-Received: by 2002:a17:90b:5647:b0:2fa:3174:e344 with SMTP id
 98e67ed59e1d1-30a33d3b0fbmr5073649a91.14.1746025138468; 
 Wed, 30 Apr 2025 07:58:58 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34a5bd78sm1705652a91.42.2025.04.30.07.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:58:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, richard.henderson@linaro.org, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 09/12] target/arm/cpu: remove TARGET_AARCH64 around
 aarch64_cpu_dump_state common
Date: Wed, 30 Apr 2025 07:58:34 -0700
Message-ID: <20250430145838.1790471-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 37b11e8866f..00ae2778058 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1183,8 +1183,6 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 #endif
 }
 
-#ifdef TARGET_AARCH64
-
 static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1342,15 +1340,6 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
-#else
-
-static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
-{
-    g_assert_not_reached();
-}
-
-#endif
-
 static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-- 
2.47.2


