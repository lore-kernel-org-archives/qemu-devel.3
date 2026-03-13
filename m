Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CC2106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vug-0003C0-Em; Fri, 13 Mar 2026 02:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vua-0002xm-9C
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:22:16 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vuY-00070V-Me
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:22:15 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439cb5af25bso1906396f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382933; x=1773987733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCSOosEIJPG4aT2xgCbEr4D9kq3QjgY7q5qLLnvfw8w=;
 b=QV37+SZXtmsHSqBW8kwsy3ZMcMyXVqQhSXM5iTdoX5JfWTWeYtSD2/L5VynEW2bpm3
 +ZSCYPiqcyHLctGVGg5jBlNNGT8l6lCFehyEpNz9ETtFAgbyrbJXOuBwI+eJh/1FRW+/
 CzGscbdtwMLYgTaNOMnSvC+wiV1mRaUzooP5OuZ0XcvdhCo7HrH29kW5kgkSEYO6PCao
 nwOXfe1mAJcCo/gWHm9CIoYtuBd0YjNicDf+Whsp/LOjLMDq82EEWPCJ4ouB6SKQBIkZ
 UpOgvAatEaiLdVsafPVNHEUGcbPg/u4WzoMNoeDhiKbi23eGyqK5/mQtIDka32BrUiAw
 piTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382933; x=1773987733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vCSOosEIJPG4aT2xgCbEr4D9kq3QjgY7q5qLLnvfw8w=;
 b=QlvScpSNPBdtjC8+oY0c0LRObtJ4ebhpGxVUtTB3NaPBHTIScFIBTFOiu4wIefCRjO
 DU4S8yzVaO4H2GGiCuAp06urS8r0t6s0b1OhIb042f9j1MZEtEosibh0tnuby5JGOHDP
 qAg2S4F4o45cQQ9a9HHFp1caWFiAyit0tpHMHqBLAjJ74JTfwDb/yPP1B40rHp+B/rnh
 cPCU74wcjcDbBbgBsy9nOJh8hgithIhFZZ/wciYN8IlMuFOAv2r/Okf2L6RdaP1JWj20
 9HesSxdoZ0FSVcUGnpA+ikf3DZr0aBL4ER5KTaapQD3AwqS9ZhOEMVVV9d1QJRhVOACY
 WRGQ==
X-Gm-Message-State: AOJu0Yy8JH+6H/LM6sBO641LuMxBsek43g8pJ204lGJseDspirPg2v75
 qVUX8yXrp/zfmR9AepCwtl3XLrCgPZRjHQ9d52Vh9Qq7DnUsnkrKZgi+SG0UfEoaPTdh+cweFTd
 stMzYft8=
X-Gm-Gg: ATEYQzzcLap0trkoxdNXnPzJzoAZgqJ2U9UijnSaoAxBvVz4OyFzaq7LWGj27/WmPf2
 +mU/zlnByY0/v/WjOpqevdFaf37DafcPjmi0Ar63f1K2A9aPLEvft0MU7Ie45ZWImzk5lu7KaSc
 nvjxo0LBE4foEQpfGKPM494nGWrkKrBlnxly7mp3SQHykZszS6duDs0XckHl9CgG4+i1WLkaxtU
 ZGaLN7w8Odu+SOaaF+bsptCAfAsRod6U4rzo0xwpDK5oLbX5ki2lzIoIguemtEJd8mSL3fqdLPE
 3Jj0ca1GophUDgG+8b9KhDQCx8K8apMzq42d7a5i+nolbfsl+TvFGEOzd9LjVSbAgEUMmC3flnC
 9BFo/Ohsoixc82JzeNyTgNUYsjMgKtQVMaTXeje/iRvQeGaqy3U3aBPG3q9lzx6HEvmNHUghLYb
 FO2DET1W35rVhEaosIhqatWFtmMigQvVn38GX95BBTk4G+hyorjoBLhUL4cyr6lxWTf8ITRFahJ
 Wyesgv+cMMGaIej
X-Received: by 2002:a05:6000:4008:b0:439:c1b7:890d with SMTP id
 ffacd0b85a97d-43a04d8d8f9mr4248837f8f.26.1773382932724; 
 Thu, 12 Mar 2026 23:22:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1affe9sm14442080f8f.15.2026.03.12.23.22.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:22:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 11/38] target/mips: Include missing 'exec/target_long.h'
 header
Date: Fri, 13 Mar 2026 07:20:27 +0100
Message-ID: <20260313062055.2188-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The "exec/target_long.h" header is indirectly included, pulled
via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
when removing the latter:

  target/mips/cpu.h:462:5: error: unknown type name 'target_ulong'
    462 |     target_ulong gpr[32];
        |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index ed662135cb0..3517d2d42cf 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -5,6 +5,7 @@
 #include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
+#include "exec/target_long.h"
 #ifndef CONFIG_USER_ONLY
 #include "system/memory.h"
 #endif
-- 
2.53.0


