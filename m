Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA95BC369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JOB-0003OG-Dy; Tue, 22 Apr 2025 15:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLr-00015e-2x
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLp-0006gB-4x
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:14 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so85205455ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350331; x=1745955131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7RZ/Hau3mC5xnOAVQuPQInWzHanN+gAbUrq5Du1Mv5w=;
 b=c+oKa68uZbwxCWxl3hGsokxEHzn6RkdHKahXKMKWyLabPqPYHDkJ/il9Sk29DUECb5
 BMq5YvE8tDkW1prgIHBg0h2oqGBuM5ucW5dBJwsXoH3GGCpUSe6o6ks0WWupcFb0iV1n
 OI5qxqkSLy0rsQ2V5HRdL8fd2jFCzof24JTDLeVQyvX2HVlDRWjWgHUbRN3w9VimLnLM
 /Mr9HSHLj1OZUX3P1vfSs8nbEtgUkY9nxPfHU/A7rd7GymXeSw5Ohtqd9PzftOue2y99
 NHQg2Ygt2j/VWmrMdmSjdKeebq6lcH0TvlapPbZZbzq62ZpUnY2beYd+CmtAY5aUsNyr
 tOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350331; x=1745955131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7RZ/Hau3mC5xnOAVQuPQInWzHanN+gAbUrq5Du1Mv5w=;
 b=KsJvXXhtmB3D2BneRRlvzbPNsRSiIs8v6QwbDdF9XuysZKceuPu7FXtFZF74Of4QSU
 nomwPGpICmrs6n8BsUTRYEeeaEMrW8uMHIqFhmdQ4Mf6XexrZ5HxHPzqG5xGN1bW5L0h
 uKweI0K4VekB9N7dV61nWEEVI+ZpEjAAiGfF0Xho0ZWKtp9Mb5JmM6Tm37ekOi++nuF4
 QIo0oeUeOTLIptK7WWJmc5ho9Vz5Po52LsfXGgjjPgdzCXih6b0T7x9sN0E1S2228rb0
 1La8wBOgNAFIpcGtyyA6UtBUY7p7gC+h2AAO7ByRKTYm3mtHlwuLJYyi1QqOWnaqY0tU
 XprA==
X-Gm-Message-State: AOJu0YxeC3Ux7F1ggOlJkyJ+a9WsWUa6ZFhXjwElSbbGelJsz+3/2jbL
 fPeRaiadrHeDdLG/3LaU7KKIQ0jCdlpIT+WvnhoF+wa/1JajH+2v2X8hE7E4X1ge5+wkRwe8JY8
 k
X-Gm-Gg: ASbGncsymMgnFR8ubWDOgKXz4NjoRWB/dylQHPe4antH4k70T0drfwieqGpQVtnGd0q
 yydzwA3NslfLEphW/SU4JkcOpF2LbvcxZK8GcJP1FclUDFeIaqtqO4vyVDI+S7voRegawxM+squ
 dWjgqoagoWskkjHto9/kM/Dlh7VIDGeXz6Faq1NEa9ODrCUuSqvT82vFTHEnxKb77m+FvVpl2dc
 2rDM5GF0KnhqV2bnakPfWz+HnQ2Ybi+YEh3fdy1T6bWmBnFZS6F+HmV2VNtWEG5pI1Jgkg+1UBd
 YT0fh0hZwlzyEszeqYNIZZVipZmQkXoEZyQfjMR0ZdV96OrlJRhsh1rbswufcK4fF3xoGkDORCV
 r0vA8/cQAZA==
X-Google-Smtp-Source: AGHT+IGBKt3UR5395dY6Bh19CT4qjjQHB9qNpHU9xI8CtmCaEDJ8wvepiBfpuNotFA94IuKSc53zug==
X-Received: by 2002:a17:903:40cc:b0:223:5c33:56b4 with SMTP id
 d9443c01a7336-22c53583807mr215610825ad.20.1745350331225; 
 Tue, 22 Apr 2025 12:32:11 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:32:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 077/147] target/hppa: Restrict SoftMMU mmu_index() to TCG
Date: Tue, 22 Apr 2025 12:27:06 -0700
Message-ID: <20250422192819.302784-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-7-philmd@linaro.org>
---
 target/hppa/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 2a85495d02..09a6aaa3dd 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -256,6 +256,7 @@ static const TCGCPUOps hppa_tcg_ops = {
     .translate_code = hppa_translate_code,
     .synchronize_from_tb = hppa_cpu_synchronize_from_tb,
     .restore_state_to_opc = hppa_restore_state_to_opc,
+    .mmu_index = hppa_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill_align = hppa_cpu_tlb_fill_align,
@@ -281,7 +282,6 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = hppa_cpu_class_by_name;
-    cc->mmu_index = hppa_cpu_mmu_index;
     cc->dump_state = hppa_cpu_dump_state;
     cc->set_pc = hppa_cpu_set_pc;
     cc->get_pc = hppa_cpu_get_pc;
-- 
2.43.0


