Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF93C3601A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWiS-0008Sx-4x; Tue, 01 Apr 2025 04:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWiP-0008I7-6S
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:11:21 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWiN-00061s-6n
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:11:20 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso3788684f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495077; x=1744099877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdg2DA89NBw+OvEyUtqbsHb6LnvnVL3Tl7petd+Rj5I=;
 b=XNEjoWk101ePOJBWsWZJsUIu2fTc3l7JXsvK9jd5auerE5RC9rldpIv3K8mIvfgSWt
 9mtQNVNrcscrgmLq+OPFQj/ZP21a/eVAzGcp24GD1bP1wu5T4BcOG28VklQ7JjpZMm6V
 3VnpGBy1+6SNnCXULliSmcglaUyatEMmgyJEjaausbYNMJRy/2B77qJ1IG+3Anh8h5og
 qV20Zh3f1RXQ0IE35dNsqeiFzJ9VJ6J467pdmjt0v3+a5QbHq9ufMEJFs5GEw41Ib/Lu
 MtNYa3deAcn8pltzHlQuKTz2mhkxrjr+ReQ414MdzF7DvL+Shyx1QvVDWy+hNMGtvZR+
 tSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495077; x=1744099877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cdg2DA89NBw+OvEyUtqbsHb6LnvnVL3Tl7petd+Rj5I=;
 b=iAMCCOn+uDfc12+rTdvFY+iZWzkfAEm+b5gRAg/Ut+pd5PALpJ7y9YUi2AUnpINCTK
 qQg/go7FK18Nib1qiEbCAXFQ92PS6V9GFk7e0Ya6riB8nMwQofX+wkNEJqEUZFYlKSxh
 CzMPIaX0gPXzNM+oR3Xo7Np8e48qmPPa/yAJOxF6ty/mf8yomhWwi+8HJPf+S+LP5SCG
 qKOZmxkvB/0/eB9joEzEOWYvhsVQTKpwWOoki2poBTKBehrPi/19zRNhobos58VTEste
 7OnAd8Yu+0ae0oIE3wRTT3IdcGc7592bn8lVQ8RlachYJ+4aSJ0JdGLsXjWCLsEQpTLR
 xXTg==
X-Gm-Message-State: AOJu0YxcLq17qg/8IkNitkZcHLUIFlWE+4QFTX24NCRcv8bizDzaH3L2
 K5TUwRoRTwImJRxkmF1yyqIBhX8TrSZoFbEYbjbRij1rUtRm9S5uzetdkscr5QSEdASBU8X/iNm
 a
X-Gm-Gg: ASbGncsKybfmI3vxtRe47Bqoa/soqDBOZlSwcITUMJL8Z3+gIScG4+qZMLakrBHMaB2
 222drM815R0k9i3aFapXbwFKIrEMVHWQf0NKkUYl9wcuMwUsxjszKsCeAG/nJgOYKx+r4q0SBHI
 zA2RqmT/J2LfP7VTl/KQtscg3MQnaFTEltc2GSt0ayM1tyWJHcgvXIzrX1nyxRC4Ex7Cu7rVun+
 q/3jHkvwDVPuWZCiImVdQlXfaFyN/KzR+FFnNfxUqZavx0nBQjsw2iDF4dJaPxRKR+38AJHkk9v
 W6UxzgjUSnLeAGh7qC8vqOAfqwvAvawp08b++fI+RWaVtvPbw9BrPxuV8WT2pnlAbfFY+R5mwxw
 bCIlm8vO/8HrAetiCnHM=
X-Google-Smtp-Source: AGHT+IHk7QT61ExFG9wtwvB6Duq1Dy3wTZ1sH6BrjbW3lbBi6doxq4btlolbkipA5BgCzpKS+9V+2A==
X-Received: by 2002:a5d:6a0b:0:b0:39c:e0e:b6d1 with SMTP id
 ffacd0b85a97d-39c0e0eb723mr10159289f8f.12.1743495077038; 
 Tue, 01 Apr 2025 01:11:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea8d1673dsm13126475e9.0.2025.04.01.01.11.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:11:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 20/24] target/sparc: Restrict SoftMMU mmu_index() to
 TCG
Date: Tue,  1 Apr 2025 10:09:33 +0200
Message-ID: <20250401080938.32278-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
 target/sparc/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 1bf00407af7..072d5da5736 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1005,6 +1005,7 @@ static const TCGCPUOps sparc_tcg_ops = {
     .translate_code = sparc_translate_code,
     .synchronize_from_tb = sparc_cpu_synchronize_from_tb,
     .restore_state_to_opc = sparc_restore_state_to_opc,
+    .mmu_index = sparc_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = sparc_cpu_tlb_fill,
@@ -1033,7 +1034,6 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = sparc_cpu_class_by_name;
     cc->parse_features = sparc_cpu_parse_features;
-    cc->mmu_index = sparc_cpu_mmu_index;
     cc->dump_state = sparc_cpu_dump_state;
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
     cc->memory_rw_debug = sparc_cpu_memory_rw_debug;
-- 
2.47.1


