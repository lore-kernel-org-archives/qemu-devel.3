Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5806C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5j-0005Ux-QF; Fri, 17 Jan 2025 13:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5e-0004xV-3k
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:06 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5b-0000Ez-Iw
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:05 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ee67e9287fso4256736a91.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138542; x=1737743342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aO2r2snLcJ0kLlp5tQSSFnCT2bNr1MNinqvZmmW2keo=;
 b=bo1ksHgSokK/UKNeZvPIPft/mMRX2OlNdn8KFuxlkuCYRyOWKLIeh/e34Z3ObWrvSf
 Ww/0w3MnVw9pH1sqlDY2DMCd+PT+12Hmx5AdTky5YvkPBA7XAGfBCqe2EQXkS/tsn+4y
 1IVpfX3Y7kaSliK43w027I3nQJ44urzzyTzJx+sz0xFWaJxcvi6Iu1T5Xt8XBXbj4lX9
 /4iBHisXEr+HYM5s/hav6yldSlQOnRDdCxU4KrG/JrH1yWdkeAhc29n6rS14l7e1mpsQ
 hf4JhSJrOLyEP9Uyx/9ny92gj4DGNphJjYbl3B0eG+dt94usFybB82EArcGM6NztCPok
 +ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138542; x=1737743342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aO2r2snLcJ0kLlp5tQSSFnCT2bNr1MNinqvZmmW2keo=;
 b=XhMxNkOsgtfjy4vZIle+n+xc+g8Gze00IY/zLAYaQv6UXZ3qcRLvsue47pZEWH2NLq
 LnKp5nixm6EUQkm8HDjCuhQ5guD6fQ1isB9SAq7I7KCPunZZ6rd7yTNp8kSy385fCEVl
 H05ljo3hS+IWsxiPK6as6xsvAHAPbUshGkuUQBYOGNXhKyQch2sm84YLBD1mD9aveLBa
 UzrplQLP0LgPwXZtQH+HTXboe2UDzLBqMSu/5v30wnPbA5J4rgA7ibcQrHwr7hpV8Tl6
 jZe/lr1amHkRbZFZATUVF6AMmnC0td1OPdwZ8l60HAGdIe/egUNPZLOtug8ragxM3GAR
 Qz4g==
X-Gm-Message-State: AOJu0YyFlUlES+EVeHDigEEuwwznGsrxeJOOZrbtov/NikrANCVSSFtF
 mswcjeOdUN9+aWLxZG1rVTwd4xgtpRGYuvFgsHcNHP4OwfnygaCTRRC/PGkGVnHv7bX/OwUKp8K
 z
X-Gm-Gg: ASbGncsIo9Bw68o474PGE41INkdwD77U2Bnf0PirNzrMUIsh3+MU91sgT2nPxrjsooK
 OdQwzwa3iSWLpslrG17RweWCvbeRJrc9UtTU0nPZUf/ASdYTmJIndv+e73c7zoEf2g0xJ6GdAFP
 cRNgyIV0ECBAng8SGy55qyLs3FtUOjzbd8UMlfw8qqd3eOZIerE48jh2TKEr7gRJe6o/5WAW5WZ
 7PEv+tHReXoYuViqy3KOH6+adOIY1r+9gz4XMtf9xGsIU3Bgh1JZjVMtF7K5YoUxR7UfIHscVJ5
 Vw9dEdNT+9QOzjY=
X-Google-Smtp-Source: AGHT+IHOJPKmI7BbmEzOb5tOUd15evvEGCsft4wZ9LoqVRglxc8omPR1CQuriJn8RMEFQxalfUGneA==
X-Received: by 2002:a17:90b:2709:b0:2f6:be57:49d2 with SMTP id
 98e67ed59e1d1-2f782cb58b8mr6020109a91.17.1737138542154; 
 Fri, 17 Jan 2025 10:29:02 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 49/68] tcg/aarch64: Provide TCG_TARGET_{s}extract_valid
Date: Fri, 17 Jan 2025 10:24:37 -0800
Message-ID: <20250117182456.2077110-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Trivially mirrors TCG_TARGET_HAS_{s}extract_*.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-has.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 0e79e01266..26ce65b6a5 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -116,4 +116,7 @@
 #define TCG_TARGET_HAS_cmpsel_vec       0
 #define TCG_TARGET_HAS_tst_vec          1
 
+#define TCG_TARGET_extract_valid(type, ofs, len)   1
+#define TCG_TARGET_sextract_valid(type, ofs, len)  1
+
 #endif
-- 
2.43.0


