Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CE4C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKqf-0007P4-3Q; Sun, 09 Mar 2025 13:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqR-0007A9-He
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:49 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqP-0004wg-Gs
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:46 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39130ee05b0so1998351f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542822; x=1742147622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v0JL6xKSZRRMov2/FW1YHJ8xf2AEoMD2E5RBViKaSyM=;
 b=F2D0S441sSzRjeCZmD6mzCvyIGLoU8Uat6KXfQkMAEdNlsoB9mCcz/i1lTjI436MtH
 MkQN/CyBq9Nx6TAD+HstuMRdTZHjptRTEmdkYtHA0qDkxlJVCNwYDsUANnwGLuG2UY3v
 yjRcc0IN2Jw0FzwlY5MwHouQ7XFFNVLXR98WZTkYkbfzY/60bzpSBBh38pUNkp0I4IXb
 bkOgb3Wkz4MSdX3IFp5Wesmwa8mf23e3glZhKz5v3/85cke8koEmXMXaV/D0OMpoczHj
 u8jHJO0p6VcHk40qxeJvBSiG61CCleoYWl77J9LYYQ9dzM6bkYvH2lVMNfo1C83YZQCI
 yDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542822; x=1742147622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v0JL6xKSZRRMov2/FW1YHJ8xf2AEoMD2E5RBViKaSyM=;
 b=rqZNIcxkFga9NMJJYijDzP4Y93T9KwEimKoJqOGtEy4ZedGrDDxp38IB+v9JSoqibX
 ubpjVkG8UdUkT6hnCV10aWp9XvdZ83fD4zMkWgnvWDSkz3MhJjapRPTya6ZE8gajP1EX
 kK+ZCxo+/z/FfDLgHP3FvRxoHNSBk9CHL+7a3b7G+sVFdE/2j50BDvvQY4C3R907OywZ
 H4mVqIvboMyj7yPrw5Nf0qVpMdtVem2AnGTbq4cZTARbh31z4D9gjEbTFGJjADe7lKcE
 gWOrxMY3sBQhjNNph/2Ojddn9NZf6isLZrLM/cEbP/mmtDRrKOYIEJkYxXValZirMueD
 Mtug==
X-Gm-Message-State: AOJu0Yxt29FfRzJbRVOSHIc/H7Biu65uwjSoNpgCZPe6zVBrg4Ty17fG
 +IMJgWAV3yqY41IzUMEoRnNmvVqhhoCr5vSeUkK/p92dzsdvkkBcsW60MKKz0qbQ0fA6iI/qQs2
 fCc8=
X-Gm-Gg: ASbGncvHrjR3SueXuBonlCrA82oG6cxuS1gvp7xHFgq1yUN8lg4wo82AGi0CBmhhxGo
 cTSvltdTt32rnb4XcSFO1ihtY0t9x6ULR3et/Xc+IOhvw1iQy7UMxqQ3FTU19MRkPOyAs00NH0T
 X2IkkV+9QRaIrDIZ4G8B66H6zXwi65TGcBQmyyUhD41JAqgsv7fttMSwQc8/mfPQ824lC383Jg4
 XYvraROeBBJvHcHVuFuK0cGOPMR6RnbDMJnTSRFTexLgVvQijGQHVR+661KH4TmDZAuViPtvL7U
 KoBR0k2V7dXHYviyU9ujzqroj3VBK5NMVQsswFHVmjswpJerkBUCaYVKnGVgEa9XnOKjB6U1ec6
 gDz3l/6gpl+3Yoa4MjvE=
X-Google-Smtp-Source: AGHT+IHFY+NGmp5seaou8YLoLmlIrVutDXB9tIvo/ouCy+aR27vJMhUJXUR6gbyNmJoyJK4rCAgqwA==
X-Received: by 2002:a05:6000:1f8d:b0:391:4559:876a with SMTP id
 ffacd0b85a97d-391455989bamr1119073f8f.46.1741542822639; 
 Sun, 09 Mar 2025 10:53:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ceaac390bsm53506465e9.35.2025.03.09.10.53.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:53:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/38] target/hexagon: Remove CPUClass:has_work() handler
Date: Sun,  9 Mar 2025 18:51:49 +0100
Message-ID: <20250309175207.43828-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Remove as unreachable code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Message-Id: <20250125170125.32855-8-philmd@linaro.org>
---
 target/hexagon/cpu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index a9beb9a1757..766b6786511 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -262,11 +262,6 @@ static void hexagon_cpu_synchronize_from_tb(CPUState *cs,
     cpu_env(cs)->gpr[HEX_REG_PC] = tb->pc;
 }
 
-static bool hexagon_cpu_has_work(CPUState *cs)
-{
-    return true;
-}
-
 static void hexagon_restore_state_to_opc(CPUState *cs,
                                          const TranslationBlock *tb,
                                          const uint64_t *data)
@@ -346,7 +341,6 @@ static void hexagon_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = hexagon_cpu_class_by_name;
-    cc->has_work = hexagon_cpu_has_work;
     cc->dump_state = hexagon_dump_state;
     cc->set_pc = hexagon_cpu_set_pc;
     cc->get_pc = hexagon_cpu_get_pc;
-- 
2.47.1


