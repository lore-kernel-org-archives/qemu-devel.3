Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C58C54E68
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 00:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmjsm-00006h-79; Tue, 19 Mar 2024 20:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsk-00006F-F6
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:38 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsi-0005Xu-WF
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:38 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso3987028a12.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 17:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710894756; x=1711499556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mTE2FKSZqlvO2R4dKYXHZtvyEeZnXSdobAEuMGCaYVg=;
 b=RyAZXhS59DKberbZor594y5tpuFrc5vkgRh7drDtREM9KiRjUrvflxk/hGyAnbStm+
 o6gIK4KxsNsgVNVLdGgoPVIcWUiZxp99CXzRzQwyl3+NVhDTw/zqRBQZUju6iaahR+nG
 1wCsRusLdMF1uZfrf3tLQRx+A/E4bLYqXTMo73tuIiRxUAD4AhPFrCcxyKPfi3+g/xjR
 mbL1WcTHoAfbKv4qEgWf4Nv3ZfvKeGiHbr0XOtNIFt5XAnKLbdycZoYzTSIIx063ICSi
 7dPNGTtxShn+qn9f/rVdTIjRvvuuDZ4dX+dTOKTc7A2nNrsmpiCBieAuFj429lTusQeP
 qTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710894756; x=1711499556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mTE2FKSZqlvO2R4dKYXHZtvyEeZnXSdobAEuMGCaYVg=;
 b=gtJJkLAVcWbgJb+tvu4hZpVFAvZseGbhXZsrDtOnNHVnf1yFeHuwwZX2d9QRnBrMId
 Yusp84jmp2OLbFYiS5PzWPFaoihNqoIGsFznJoXUfSYDP6I4LzPkdwtPrpanV1gVR/rb
 cvWFG1M/Efs+f7l/1pS6G8uqClWUA4LRGXT6ghLl5PhrndLvPsipDuzxJjQe2TSPL8Is
 qgA7PBS3Egc6MiDP+eCzzGgcq9YypkuEnlAivyXuoQqDdJhTvSWH7OVruMSXH1IxLZzo
 ebFshsYZN/C+N8BOmPZhgd8sRVZxApTNbh/y9ox7sHlkeeDDcfzU6IJUL+M3LbXV4Zt7
 lYgA==
X-Gm-Message-State: AOJu0YydOMWsin+K3aB5nTmPy6NvNeTQKhoxPH/YbD61iWJZw4NnVoZ8
 4yJoakbmvFFgDncT8BRKrpjotySQyESdlwL0C0elmFQB3voxEJjyZP9wu09QV3swQ0mXubXGKxe
 n
X-Google-Smtp-Source: AGHT+IFmc4sI5vnUkuwowkiBDjET2BPUpeauOlzzX1g9SDYPr8U63ERyJnbbhQfcT381954Fx38HcQ==
X-Received: by 2002:a05:6a20:748f:b0:1a3:6397:e253 with SMTP id
 p15-20020a056a20748f00b001a36397e253mr666510pzd.28.1710894755679; 
 Tue, 19 Mar 2024 17:32:35 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d19-20020a63d653000000b005d553239b16sm8475645pgj.20.2024.03.19.17.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 17:32:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>
Subject: [PULL 7/9] target/hppa: exit tb on flush cache instructions
Date: Tue, 19 Mar 2024 14:32:21 -1000
Message-Id: <20240320003223.554145-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320003223.554145-1-richard.henderson@linaro.org>
References: <20240320003223.554145-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

From: Sven Schnelle <svens@stackframe.org>

When the guest modifies the tb it is currently executing from,
it executes a fic instruction. Exit the tb on such instruction,
otherwise we might execute stale code.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Message-Id: <20240319161921.487080-5-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode | 6 +++---
 target/hppa/translate.c  | 7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 5412ff9836..f58455dfdb 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -144,9 +144,9 @@ getshadowregs   1111 1111 1111 1101 1110 1010 1101 0010
 nop             000001 ----- ----- -- 11001010 0 -----         # fdc, disp
 nop_addrx       000001 ..... ..... -- 01001010 . -----  @addrx # fdc, index
 nop_addrx       000001 ..... ..... -- 01001011 . -----  @addrx # fdce
-nop_addrx       000001 ..... ..... --- 0001010 . -----  @addrx # fic 0x0a
-nop_addrx       000001 ..... ..... -- 01001111 . 00000  @addrx # fic 0x4f
-nop_addrx       000001 ..... ..... --- 0001011 . -----  @addrx # fice
+fic             000001 ..... ..... --- 0001010 . -----  @addrx # fic 0x0a
+fic             000001 ..... ..... -- 01001111 . 00000  @addrx # fic 0x4f
+fic             000001 ..... ..... --- 0001011 . -----  @addrx # fice
 nop_addrx       000001 ..... ..... -- 01001110 . 00000  @addrx # pdc
 
 probe           000001 b:5 ri:5 sp:2 imm:1 100011 write:1 0 t:5
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 29ef061baf..107d7f1a85 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2343,6 +2343,13 @@ static bool trans_nop_addrx(DisasContext *ctx, arg_ldst *a)
     return true;
 }
 
+static bool trans_fic(DisasContext *ctx, arg_ldst *a)
+{
+    /* End TB for flush instruction cache, so we pick up new insns. */
+    ctx->base.is_jmp = DISAS_IAQ_N_STALE;
+    return trans_nop_addrx(ctx, a);
+}
+
 static bool trans_probe(DisasContext *ctx, arg_probe *a)
 {
     TCGv_i64 dest, ofs;
-- 
2.34.1


