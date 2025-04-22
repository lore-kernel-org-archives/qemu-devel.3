Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DFBC369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JQl-0000kG-NF; Tue, 22 Apr 2025 15:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOq-00054G-Ba
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:25 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOm-00071F-Vt
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:19 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22c33ac23edso56359875ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350515; x=1745955315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0+phgtXpTHu4kCbYiaq4DT5v48KX8xhY8CEe+xz2e0=;
 b=covJPhkyoDpFiRqsCLYTREhIpP4pRCl0EnYqi7+3knmQ9kzv38tWY5+ZrlqtJtgjiY
 Wo3J8IkMZE+yzGVAjJH8sZc1hjSlfw9VjAYBIbQSByIHXqKjXusT0N1amGor1PeOWHSa
 UswoPcsoXaADQgURAH7hZWtQ2MzNig/7DDus8/MnnZ0Nb8EYPCTGCrvEcSSS9UvfCL3g
 G8BFm5EavVyIAMvNXdhdcWhGSXTyip9z+94ZwsQNapDberSoJw7BaKvpQGblR+OMv9TD
 XR4N1wAuECmoKHrYPfr9+Pog4nzEHDiLi+aIQVu1AqYHFnO9cEtsFL2SSSusYkdACa9z
 liIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350515; x=1745955315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I0+phgtXpTHu4kCbYiaq4DT5v48KX8xhY8CEe+xz2e0=;
 b=ne/VBEi/L1vOO9lksMfFUTvlC3PAUfjuCtPRxhEtCTlfWRhoqUTzGUsWxMepRi1rsO
 82uof9Z079w8rZJDW5T+fqIENWADPK8iZ1dfUqALdkc8tk4kzFwe0qx625OKqadYI8Lt
 jdTbxMKPUJ9Lfhl/dfQvzVu3ZQyG5N3vOcP1hRvDuUEvsGJf8FRoqDARHl+Xin9irn1T
 qthCZb691hp4hsBfIsrizc8p6gZZDN2yWRSkzKXqPyuTWxxVvhKh4X4WZ2MiCKK+fCFb
 18PDpovmQrjJmwS+ewIbY2DzG46hx44am2Zt5uTZ0j63Quj8S1yoQf3/972DvZAw8SZR
 pmQg==
X-Gm-Message-State: AOJu0Yw+eObi4SpnAWsde+qCwJe06fwa9DhroDFvtuPtOOgLOZFzQX6T
 WhEKLFvHQx/fAAnbFQf6GxIHis7YuOV4npSPcc3dVMXZ3A0j2c0nHG5ISCjbDFvlW3bw1bdXimm
 q
X-Gm-Gg: ASbGnctyscWcD2mfOvP+JlGoaqleqOMJQ1l7pHKvL4JsqMNPB292CI8ms4XXfujMsJX
 hOmB0t3gtTePczEfNhOO3GTsGmz+ig6leN5i7ILcfP93rTywJ7kgGFzjklK4fRcXnZZ8jxg+Kq5
 rQ8YtNsKLnLfAgM1cFzconBcC0bTuKyOoVD0Q8t6pr4+29slGcVlGxGDPD57nG72grFIlPqS9DY
 FevUKKQO8zkSb5mUPzQMh41L0XKbjOWNQFpAxyI1HBeDmyL9eNdjCgio5oepWdsMn79yp8hXX8N
 rDMupzeV+P/+o3dZyhPGpVIlyvy5SVjw7Dbor1a0Hx5LYaC3+/pThOehJGd2HtPMCqxyccLPtUc
 =
X-Google-Smtp-Source: AGHT+IGhMZg7dEFG51gXEjNNR4bXn9Adf48TI1T1e0xUlohm2FX71AGJEDO+c7aJGD484kEBL22/0g==
X-Received: by 2002:a17:902:c943:b0:224:1294:1d26 with SMTP id
 d9443c01a7336-22c53596eefmr193247335ad.13.1745350514702; 
 Tue, 22 Apr 2025 12:35:14 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 082/147] target/m68k: Restrict SoftMMU mmu_index() to TCG
Date: Tue, 22 Apr 2025 12:27:11 -0700
Message-ID: <20250422192819.302784-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
Message-ID: <20250401080938.32278-12-philmd@linaro.org>
---
 target/m68k/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 0065e1c1ca..4409d8941c 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -592,6 +592,7 @@ static const TCGCPUOps m68k_tcg_ops = {
     .initialize = m68k_tcg_init,
     .translate_code = m68k_translate_code,
     .restore_state_to_opc = m68k_restore_state_to_opc,
+    .mmu_index = m68k_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = m68k_cpu_tlb_fill,
@@ -615,7 +616,6 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = m68k_cpu_class_by_name;
-    cc->mmu_index = m68k_cpu_mmu_index;
     cc->dump_state = m68k_cpu_dump_state;
     cc->set_pc = m68k_cpu_set_pc;
     cc->get_pc = m68k_cpu_get_pc;
-- 
2.43.0


