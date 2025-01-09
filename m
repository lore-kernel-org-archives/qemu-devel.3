Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EDCE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvzg-0004lZ-AP; Thu, 09 Jan 2025 12:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzY-0004jG-UL
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:46 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzW-00070V-SE
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:44 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ab2b29dfc65so189233966b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442400; x=1737047200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YoVYHxIQ6FzVx9Ejwb1qRhaSC8vYXzudlK+d3/Xo6Gs=;
 b=LS5sJYGxgl0bHdUEUNXEUY1wdMJjAHXIHyfLpsI3LRpL35z10ap8+KUOGxqxvl/Dtx
 C+GlJPjFTcpZaUHMGBcLyRr3s2e010cab8R0iQ/MmdTyPQKCS0R/0kaexXG70p7DXucf
 4B+tvWTXsCtRKyiFU6M1C3XWhpokqj6rsV/zfZbJHDDgUMwK8EZFKsgUa7xnNqaBXesi
 qvNLevkthpIH8vItIRjGxEOKUbj7dgAPRZ5XfMtRgjYyq9pKXSxxG1Q6psG6BL4+LN14
 /Hp++BmmnMoZV7VMmHP4b6HPTbieD0vZw44rjmkhqcHBzFikkKeJob39oGSE2J85qAst
 ao9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442400; x=1737047200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YoVYHxIQ6FzVx9Ejwb1qRhaSC8vYXzudlK+d3/Xo6Gs=;
 b=rakxKqftRXd69JEzkHFlQRAsAtZkn5j17ywhXzz50sXv2g6dYtvxXgvFIHNfoBdlvw
 OZEQCyPFjsksAXu/1VEmhENwf5cV/jJ/fqrz754uepmPiBoHKash3AjJL3DG4o9ZAuaF
 jSJUpWySVjg8wia6/cW/VRWFhHbfPYiNIsZt1duoJIn6uHwsNGxFp5GDgWfk26jvYGkb
 /NMbw8vkKhSb0K7CSjcbEXQU5F6ZWdmwdsKMFEQykkZZ4tFo4NYkIRs9hOcyj2Uy1C0+
 EEASDh2DpiYfegEL8D79TxSlzqFmO7+9XiHHUUVI+M6CkyjEQL4f4aXlBEQiCvSGBmLa
 Dr9A==
X-Gm-Message-State: AOJu0YycAd+WH0mVU3pcKO0ViauneXWCaXlXlhfmD98W+ZByq649I0WX
 xfybk1hpAzMiOhAgOjQhgpwmzz2INgh2c962O3M61IpbNmdJAgsVCFsxEoTNvw3azTyYpYeILKp
 TGrQ=
X-Gm-Gg: ASbGncvOrrMrNmuVDj4lzwxWSSdavcCUIA0JhHstpqPCXFY6qbh3XqmIr9Eix1QtyXu
 yzHZKvEyeecFHiql+aYp6EOEoAhxipQE/ecJRgAjzha1pWh4HJt789PBDtyMduav5WODeDYkHYl
 gZEj66LuQDO06gAWuLgcFJO+Wox/zhGg/FydZKOUO0vZ7JFsl/3By1v/Oc6oBV8aVHhWyIY6b48
 PPS3jLv36WkjeGS0bFkZvcMTXn/Lr6IumTrMgFsSSYDdfm9eDWGr8A=
X-Google-Smtp-Source: AGHT+IEQL8mWewsJ6Yk5T/+hGPd0lLKOT6JRgNzRdID0uqMKqUrF/Xsq9EQRyKbEb6Ql4AOj4uqFWQ==
X-Received: by 2002:a17:907:72cb:b0:aab:daf0:3198 with SMTP id
 a640c23a62f3a-ab2abca7800mr620002166b.40.1736442400418; 
 Thu, 09 Jan 2025 09:06:40 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9060f9asm88891966b.1.2025.01.09.09.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D57BB5FC85;
 Thu,  9 Jan 2025 17:06:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 11/22] tests/tcg/plugins/insn: remove unused callback parameter
Date: Thu,  9 Jan 2025 17:06:08 +0000
Message-Id: <20250109170619.2271193-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-2-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/plugins/insn.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index baf2d07205..0c723cb9ed 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -150,10 +150,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
             qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
                 insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
         } else {
-            uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
             qemu_plugin_register_vcpu_insn_exec_cb(
-                insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS,
-                GUINT_TO_POINTER(vaddr));
+                insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS, NULL);
         }
 
         if (do_size) {
-- 
2.39.5


