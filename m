Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0106C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tprMw-0003BZ-Nr; Wed, 05 Mar 2025 11:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tprMv-0003B7-1J
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:13:13 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tprMt-0007bk-Iw
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:13:12 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3911748893aso1624874f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741191189; x=1741795989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIhGGd0/1q+JIY0hi7j9g+a5nqH/JO9F2rnfsDDPgP4=;
 b=jLcB8MJn6aiLDED7LOigsfWfMo/umHTsbG/+hunMpAbgD7NQ5H4ibH6GfZRuIgw6lZ
 HQ6Eb7ZgoqRb139QDl88wvDQ7jGVrORFIk1lbZWCy5xwJt4dhZJfOzgx9zoiamPxDOfk
 vYbD/ct6QYRlJ/VmvCRpBo4pFpb9Q6poxjc8jfoC0qdMQQ4z2BAlZlbr6en6e8IZVY2A
 ZehGII3lihnzARqAI7rhsqdlie7ZAX0GcdUTSM1zmr2Pg9tzelZNtYBwF6dPjqKypmV6
 5OLFHghqRc0WxB13IL22osxJbZfmJT2maATUbaRVqpQTCOQilu7nqBHArIOGnzKAcHIZ
 dzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741191189; x=1741795989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gIhGGd0/1q+JIY0hi7j9g+a5nqH/JO9F2rnfsDDPgP4=;
 b=le8E3qiE0ObbAJG4smV2eDDeiaJc7+pkDFMZIz0onFhwaLPdlyW6/TxSg5gj0QxTho
 YpbBCKoFpOZ+T74ecKKX6jv6lEcstP3Jbuje0AqBm/rBalEO6aSRKb2JigLH3GGXbmUU
 XazBrsZueFX4zRie8OqLs2/BMDjoYNAviGZb3AlbXk03+kNkdwDdw0yMag04H2G88tiG
 RwN0RswKwpd0psGzc7joIrhOXi3AghvLy+4ruRjKEXwbVRMtugL94Wp/ZaHhBtKUKmpP
 8QahdaiV8DRnC8d12nLVv3gebSiKcdHVnHeghFZSmhjuNpnHFbLl9WeMWSiISlH1WceA
 WYdw==
X-Gm-Message-State: AOJu0YwRHrbBnkH/xfMnqSGbYlNGXLDhzSN14txrxcc8RtvldK9uRuwj
 PMAiO2NrdUVJeZeOAgsFsFEzz1Dm4Y+IXeivdthCoqly0wUSQXVGuiFlho2xPXyrpoPRwOEawoo
 Ezfw=
X-Gm-Gg: ASbGncvM5T+H5eyp0/DSIZtUCfIbe1JbbWu5VdaeTCuWBFqgPmrLjWsjwP3a6aQamGM
 CgVeJv4ZlqdC5Q2y5xibu5EaL7krUoGAwb3toNnicsiJ0T3ZIcTNuwGStnmYKJTJ9l/36VuqsYE
 eQHNsS8iO8Qn4Gc374Ln4pyM3ZnN5WWWSuioekOhHwZs7arVBpUTW4db84R4g6nqKKQd/pDvXop
 CoJFJ6s7gDHTHvFvNP5C2nTZ4f/9axodQ98A7WuFmwKKjcbjqCmWIh+sWOAw8bNPR/w6iAE8tVX
 rIsSRc5D1a1FgTH/ZcoOuAnEyl/Zyc0MbDoKbApqor5sZWY4noFULTRN16U60thiMbBzbyyCqpO
 TLQ6dtWkPjoGnqaHGGyc=
X-Google-Smtp-Source: AGHT+IHG44iYgP80iqa7aBVAlp2+znWXEwDSeRUMjjw21rd3eIQVyHabxI8YmCSES1ldC4HgNL+bTQ==
X-Received: by 2002:a05:6000:1562:b0:38d:e6f4:5a88 with SMTP id
 ffacd0b85a97d-3911f749c86mr2983958f8f.12.1741191188770; 
 Wed, 05 Mar 2025 08:13:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b6f22sm21116273f8f.47.2025.03.05.08.13.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 08:13:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 4/4] hw/ppc: Remove TARGET_PPC64 use in
 ppc_create_page_sizes_prop()
Date: Wed,  5 Mar 2025 17:12:48 +0100
Message-ID: <20250305161248.54901-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305161248.54901-1-philmd@linaro.org>
References: <20250305161248.54901-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Check the binary is built for 64-bit PPC at runtime,
removing the need for TARGET_PPC64 #ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/fdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/fdt.c b/hw/ppc/fdt.c
index 0828ad72548..bae269c72ac 100644
--- a/hw/ppc/fdt.c
+++ b/hw/ppc/fdt.c
@@ -8,12 +8,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/legacy_binary_info.h"
 #include "target/ppc/cpu.h"
 #include "target/ppc/mmu-hash64.h"
 
 #include "hw/ppc/fdt.h"
 
-#if defined(TARGET_PPC64)
 size_t ppc_create_page_sizes_prop(PowerPCCPU *cpu, uint32_t *prop,
                                   size_t maxsize)
 {
@@ -21,6 +21,8 @@ size_t ppc_create_page_sizes_prop(PowerPCCPU *cpu, uint32_t *prop,
     int i, j, count;
     uint32_t *p = prop;
 
+    assert(legacy_binary_is_64bit());
+
     for (i = 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
         PPCHash64SegmentPageSizes *sps = &cpu->hash64_opts->sps[i];
 
@@ -46,4 +48,3 @@ size_t ppc_create_page_sizes_prop(PowerPCCPU *cpu, uint32_t *prop,
 
     return (p - prop) * sizeof(uint32_t);
 }
-#endif
-- 
2.47.1


