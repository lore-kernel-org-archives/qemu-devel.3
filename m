Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62823C3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Fu-0004NP-0F; Wed, 02 Apr 2025 17:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Fr-0004N5-5F
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:12 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Fp-00069q-JP
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:10 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so210340f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627848; x=1744232648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6HkXkfw0iIfv2WCNg01SZgaty9FpGvIO9amMY/YPI4E=;
 b=A3NCUWCPyiq+KG8AJPiBBI9RpS3H34btXKILuyeAjQTD7Abi/rjuxDMIKnQERWZBzz
 SvvYZVL1i5mEeyx5/PKot2/tmctHXllC2LSxAgeNAtkGfvIxzSewlx1wUsIHnfDXPx0g
 n+jbV572VcI/l7b/QqCtUDaRKlrk70ZEvpYHoQsHdznoD1/K2+ufALPEXBD4M8Sft6iS
 Euw+CbJikL+ff09ZpBsNbdTa2Xc6BO07UFHkKUQJmywxcgEgmLeoIJVXDTG4hehEnLNi
 I0h/kL7K2cBwyxadJzKqdp2asHk94QNNWkXJzBDJ7gApJnCe7419hI5ZiONiG9tN6SOD
 j6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627848; x=1744232648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HkXkfw0iIfv2WCNg01SZgaty9FpGvIO9amMY/YPI4E=;
 b=rlHX3I17+jfy/ZfZJGIGXcYe0Fa/yLbaMq8bC+WLqdmKsp6ESEvUp04QoVxtl8NlsC
 PpaJx72v7qVzXwbXjCP0NzD6gNqZ/QZ1zprwQsX3DwGYlokSkygcWawGZeYyZ77BVSgK
 xtyjcTyZqgSgmHDZn/pjsSoZfEOMVjV5rZWz/nUZokikpYlrL82kPzYgQMZoNM2JDegA
 cSUQwaiWa6MqoxiyHe46vhPmXgX5RJZkENdWubgu3MIR7LGeWjAEk03ystQoPRhgzgXG
 WkxMSh62c+M3PZzci6bWcYrSQLksmNgNxs8YiapoTEX5OzrJFMSJJC6eFNpyw/jNRHc5
 8Aww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr48nzgg/EYCu59NgU/z9lS0IatBMF7aTMWgkGJiMWyMw1Dh/voYf8v1Ur70x38JAsXK4ANx8CDFTe@nongnu.org
X-Gm-Message-State: AOJu0YxKTmY4a9BQq9RgHKkW12aPu3tPWp6R4vJ1RILyYhPZRArlThlL
 suKLlnLGGglZ3oGSMsKd+8pJ/hWgypXjdBB63p1paGk8dCj8hq1oMmaYP2iQL8+EiV7oSOIKdke
 b
X-Gm-Gg: ASbGnctm6J6BWyeAW6BXinhdaPYHyNvGWywqrKx03LEvsYhABX/36k+J414JKIMi8VM
 VdZxa7esbr3c9fdpDCcyJESfVqiS3HmPy/RvFRvc8x39gBXShbncv7Cj2257m8DGFFq65Fd/PkF
 GxG8M9O6/RwpHN8toBV93IRt6DIkl4MgvbuFqC7Yuu9qPy7BgRm56PE6uUjM+joufaYJ0bj9CQv
 8nLzHBCR8Wf+F9ToYZgF6BRWx2Lh6ouKq2GMm/INVOHyu2IAaSyxDlQltw1m82hgoBSNnna6LDT
 SdB8DIf50X7RdT0Am0jIuWih+MqLAA8xvoRNvqn/QAtBpl9mpicIP9SwOTQOjV0tgu7xBbDxDwk
 eCzq4MEP+Y5OTQsb0BGjHcM8DOlRPlQ==
X-Google-Smtp-Source: AGHT+IGhoby4UT+SDv1gGCdWfkfUliF+MM/MauHnbNjzrfDmGH78RruLKVq26HUcxVd7MkB1uI4OHg==
X-Received: by 2002:a5d:64c3:0:b0:39c:dfa:ca71 with SMTP id
 ffacd0b85a97d-39c1211b677mr12600417f8f.49.1743627848030; 
 Wed, 02 Apr 2025 14:04:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b663470sm17858505f8f.27.2025.04.02.14.04.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:04:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 08/43] target/hppa: Restrict SoftMMU mmu_index() to
 TCG
Date: Wed,  2 Apr 2025 23:02:53 +0200
Message-ID: <20250402210328.52897-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


