Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940E9C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb64-0005aT-41; Mon, 29 Jan 2024 18:31:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5d-0005Qh-UK
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:30:57 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5c-00050j-Aj
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:30:57 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ddd19552e6so1586018b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571055; x=1707175855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rY4TKU6Y4tdsleFZysMCIHaTnyMqTWQ/l8+rNabU+ew=;
 b=IwLV4zBz4H2//2udtKcwdrNdrBxQK22U+ZEJcqF6Mg6tc49xDTsW6yOcouTcLYR4ON
 tObBRAZY6ehsHk7F+5baPb2oAsNpjQjGVL0b0qh/y/yDRbBpPVHVLKOrL7930slQlYyX
 4OadKOXCS22u6RFMYDzHLHjUiLut4CwZFw2ftSL1aRkA4oa7Ld0vyyo3AsnZ/srxMZMr
 BnYJCNqTjOH2FuVqgSzqPn77mWwV+TLm5RMe3pF8e9LKW6x1aBeli0vq/DdfopaozJ6I
 +fPL8VGqqZJazvXcYOG9k1uWk5rf+A15YdhMpR2kZd5Y0p8zyqAoWEksPA7RVjBWDI3a
 vKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571055; x=1707175855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rY4TKU6Y4tdsleFZysMCIHaTnyMqTWQ/l8+rNabU+ew=;
 b=XWEtOqaaaypIkpXLgmCiEWA++MYvJD7UDKSYaCixnAQlc5pdDb5r6NzPpnQZywhnCw
 zMCUq3rd1k9FmzsCnz3D1eCcF65SahtEDsfviPFnDo3uRki4JU7C4d4k/yvdHx+WS0+c
 L5C+eetpRtbTJJZ7YJzUxMJDETOwCJmr4zjNCt3jgN1zLJaDvxBKms+2Z/pXCjl/0fl4
 4Zi4Mgq6vdCDLJMteM79HqtfShmkBKjKcZWtiseUtFdM9wBqt+TcgaMdl5B8v7JGMzC1
 AvRh+XeOVaIMmi6muLggFaz/nvrRcU1FgRLQGxfK/1vc+Q9dLmAtEEK97hBKCoQPVFSs
 n4Dg==
X-Gm-Message-State: AOJu0Yx9axRX6dvtbAnomqVRCmo9R9AIqfuL45nzK3+fybwmVacp59fZ
 SYVyaW68sPTaO/a08cet3gJ2CaICKDxjwqKHHwe/cj3PH/b0iqit8Z7S43D1zRGgn3LpXeJUWo3
 yP3c=
X-Google-Smtp-Source: AGHT+IFpjlox4aJ857gXV0gbqg1nNAMaVFyGKuKc6PGxXnHKKiTMuXks7/hOyBQXx7VYlSYI2PqTJw==
X-Received: by 2002:a17:903:110d:b0:1d7:6c77:a6e7 with SMTP id
 n13-20020a170903110d00b001d76c77a6e7mr5432405plh.109.1706571054861; 
 Mon, 29 Jan 2024 15:30:54 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:30:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 03/33] target/alpha: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:13 +1000
Message-Id: <20240129233043.34558-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index de705c3703..bf70173a25 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -64,6 +64,11 @@ static bool alpha_cpu_has_work(CPUState *cs)
                                     | CPU_INTERRUPT_MCHK);
 }
 
+static int alpha_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return alpha_env_mmu_index(cpu_env(cs));
+}
+
 static void alpha_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_mach_alpha_ev6;
@@ -230,6 +235,7 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = alpha_cpu_class_by_name;
     cc->has_work = alpha_cpu_has_work;
+    cc->mmu_index = alpha_cpu_mmu_index;
     cc->dump_state = alpha_cpu_dump_state;
     cc->set_pc = alpha_cpu_set_pc;
     cc->get_pc = alpha_cpu_get_pc;
-- 
2.34.1


