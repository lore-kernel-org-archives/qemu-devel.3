Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D25C36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWhS-0006nF-6g; Tue, 01 Apr 2025 04:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhM-0006mJ-BO
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:17 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWhI-0005vp-7Q
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:10:15 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso33699545e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495010; x=1744099810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PkCoYIb7m4pc+ERBu4up+WFfgiLqv22+MYfn749jHu4=;
 b=z4r3JOH6GR6Nt0jDS+FOtg5AgnMGuiHYLecnJpeJH49ryezpyWpO2/RVd5WRs61JAb
 5RHWD2l0Z/DjEOmvLcnrpWnGxZFIMETVwVmrwOLbKQdUbv3kN8JYlHSo+9gf/Vpi/jaS
 D2m+LAHk4Rb79rSLjEodWLXVR4baHvnTdmEVFBrZ+dVyi1RFbdOE1c6sUO7zHvJ+bKvw
 iKGSwWuzkEPu9yS/MKNvwhVEppwO0FizbnJmRRRqulhD5tXav3bD1EHjG3KXoTMtpdid
 qsegeo3AH5l1vlsYwpZKQPEL5GN1jiS2yFhVm7hMbfYTnBhDDGj8icTl7KimJd86T0nl
 Dz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495010; x=1744099810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PkCoYIb7m4pc+ERBu4up+WFfgiLqv22+MYfn749jHu4=;
 b=ONzP2JZkl+PuBilkRML2oXZIWV14kOlok1iSp0ISJtlNnReljg14/UTbWWjM1OAXbi
 VdxkXaIaoFsxDgXs1Wbmtd1MvZrVA9QC28Xrdbm9vHkXu5AcFkKuCiH4eW15PXIn5GQh
 ZxXQuw1Q5PD1n7GLzkVLJyZ0g+HuPjhUfYm5xmh907E8nKYi1mzBrAj8X86WxqqgWmTj
 RsMAiBXuSEioyiO6Lgcefq6IHBzvLGSeq+AmVTAtZhcee6q3kLjNqcw2zBUCDmO4UKV6
 TV8ld+8Q6rSZ59HdQa5MzfeAN7siDa8XpuxnIRDIRVIvehHFRCtst22SXRFQzuw0h2YV
 SxYQ==
X-Gm-Message-State: AOJu0YyS3Zlevt4FroK9fDmeDp8glvF1QVCPROFE7PoUeYKNe9BBDSEI
 5HuG9uQ/YkJZvgyC9romV2g+MsnEcnmsuHRrFawHVy9IdKOMrGku0OdZi+ttPIq/0R86CWqgQKF
 R
X-Gm-Gg: ASbGncvjwemUbut3+9WDed9v5Wwx3JKhmvA6v+1Qiq00CiU0iZku00PJJR3dcQ0/gen
 OE1GLA0VVTaBWBxcmPKZ0rJMPh/KWBs9wU3a5CQTNNgHeZpgTCt3Pz4FnzjgLjaK6fdOj73423h
 dtvfkb30c4oextfgKbwpkOe1aGljmBBTWn83oPNMd5GpKKMIueS5ymOeFEPP4gZcHJ+qPfLKlQ7
 HHwtWlcsjxn9XVp7KvFucjX8ckxoLRaurr9PN6A++vzliwsF7MAZ+d7lZR9aI96BHyYhIRCvgKW
 gczVincRMDgy2ZwQseIhVA3oMx7izQOp95B0s0qUZASqoWY3vHWcmzSohRRYLRoCH+S8fFwCvqq
 n7zr1kNLI9ac7u48Dqew=
X-Google-Smtp-Source: AGHT+IFgWb5b+Usf6fqbgmjVF84LAXSZlVNqv0uCsDDKENPxC+kO6PY2w/u6+iYWnNv9GvwTej2rdg==
X-Received: by 2002:a05:600c:34ce:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-43dabe235b5mr125439145e9.0.1743495009665; 
 Tue, 01 Apr 2025 01:10:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fcceaaasm147949435e9.18.2025.04.01.01.10.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:10:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 06/24] target/hppa: Restrict SoftMMU mmu_index() to
 TCG
Date: Tue,  1 Apr 2025 10:09:19 +0200
Message-ID: <20250401080938.32278-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
 target/hppa/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 0da8cdf41f5..51bff0c5d62 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -257,6 +257,7 @@ static const TCGCPUOps hppa_tcg_ops = {
     .translate_code = hppa_translate_code,
     .synchronize_from_tb = hppa_cpu_synchronize_from_tb,
     .restore_state_to_opc = hppa_restore_state_to_opc,
+    .mmu_index = hppa_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill_align = hppa_cpu_tlb_fill_align,
@@ -282,7 +283,6 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = hppa_cpu_class_by_name;
-    cc->mmu_index = hppa_cpu_mmu_index;
     cc->dump_state = hppa_cpu_dump_state;
     cc->set_pc = hppa_cpu_set_pc;
     cc->get_pc = hppa_cpu_get_pc;
-- 
2.47.1


