Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E057C25B7E
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJln-0008Bs-MG; Sun, 26 May 2024 15:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJll-0008Ap-Ov
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlk-0007d4-7g
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:01 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f44b5b9de6so18160385ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752579; x=1717357379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPN2ZXnJH67ylasvW5ASBChVEwpUinMe7ale/dDDPYY=;
 b=OC2N/L3kh37rbQxVLUd8fGeYrjhCmHpKZ911PeMao5+XwAV+O5pH/mcb6q1gmCzzTr
 veg9WaD8LsG5Mo7bDfsQdu8m4o5t84cEUDGiE8lpH3KJtq/hXHIXX64Cx2yuayXEhocA
 dulAUg0edLqS3YdV70jtK3h9BJlgTm7zqs9/gpFncZQSPnKTlv/HBQw7jGqyKG5EXnTZ
 utklhEajMXISha6Cf6ORweQnTUph+BKmOoYuJ1E2XoYO22JgaPJBNM6Rxc0x1tRG6TBJ
 zVZ7VuDT2j+zb7DzySqHS4qmC9OUmFbvSc3FI4oGkmZYujLLvdFYsByMEXzM+0xWunCB
 GRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752579; x=1717357379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iPN2ZXnJH67ylasvW5ASBChVEwpUinMe7ale/dDDPYY=;
 b=uNE2lkQyLnz51HyROpx28JtIL04uHcobdwd1U//g8EEgN3bMVvvUEfusXyDqwcDBD8
 gEmuk4jB6bkMuYQnb19Rn5x962L/sAz3nOArjxW5MQIpp1WbU4LKhGvq2KymagpPhIdH
 aJoNtdPmJcKbt3vtWV1Gc9momXiaDjOlaUzrLyWggwrVC8IOCeQEPUZP31GPO4Az3pFj
 juWgTQFg+1KdLPsywR6BK7q84sllYzaCDMupssL3j16AQPY8aKHZXvZ72se9clDPJjGI
 iGLlEYykHz2frQFnzbZ9p2Vw8LMvL++jfoKjBvx2LS2BMxqB5fhnB8zKFQM/tNvYQ+j6
 tKdw==
X-Gm-Message-State: AOJu0YyzJf6LNdlaqXHUG6pWfbGcgGTrhcgpM85q/e6Vf5NFOIIvY3Uu
 6A0gCD4afdZPDLvW04yeFdS62n67UyQmdT8hiXNFRXyY2KQhwypJo/yMqjLEAG87iM04LJClrcE
 I
X-Google-Smtp-Source: AGHT+IGvzHlUqqqOxBpKCROMgnuJzwnE89oFomLBBSJ3s6CesbH/Ck/yvHhQb4Eru7CCpgRBSr7KkQ==
X-Received: by 2002:a17:902:c943:b0:1f4:64ba:af9f with SMTP id
 d9443c01a7336-1f464bab2f7mr53644085ad.48.1716752578869; 
 Sun, 26 May 2024 12:42:58 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:42:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 04/37] target/sparc: Fix helper_fmul8ulx16
Date: Sun, 26 May 2024 12:42:21 -0700
Message-Id: <20240526194254.459395-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

This operation returns the high 16 bits of a 24-bit multiply
that has been sign-extended to 32 bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/vis_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index f46fcf1f6a..41312deda4 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -174,10 +174,10 @@ uint64_t helper_fmul8ulx16(uint64_t src1, uint64_t src2)
     s.ll = src1;
     d.ll = src2;
 
-    d.VIS_W64(0) = do_ms16b(s.VIS_B64(0), d.VIS_SW64(0));
-    d.VIS_W64(1) = do_ms16b(s.VIS_B64(2), d.VIS_SW64(1));
-    d.VIS_W64(2) = do_ms16b(s.VIS_B64(4), d.VIS_SW64(2));
-    d.VIS_W64(3) = do_ms16b(s.VIS_B64(6), d.VIS_SW64(3));
+    d.VIS_W64(0) = (s.VIS_B64(0) * d.VIS_SW64(0) + 0x8000) >> 16;
+    d.VIS_W64(1) = (s.VIS_B64(2) * d.VIS_SW64(1) + 0x8000) >> 16;
+    d.VIS_W64(2) = (s.VIS_B64(4) * d.VIS_SW64(2) + 0x8000) >> 16;
+    d.VIS_W64(3) = (s.VIS_B64(6) * d.VIS_SW64(3) + 0x8000) >> 16;
 
     return d.ll;
 }
-- 
2.34.1


