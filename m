Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD303CCA472
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jQA-0004yn-Nr; Fri, 03 Oct 2025 13:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jM1-00082m-DT
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:14:01 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jKH-0007vE-DK
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:58 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-782023ca359so2524903b3a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511525; x=1760116325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3IYbDL7ZzrPeJgVCiHhUdegByQ1ip3ofl4M+Y1UUBtM=;
 b=anz9/6ILHXfabr84ntb4KNC/zf8lBl3Dpat02rPQEIG9AJjht+HQHx8Hhm/cow9rEE
 1Njn4sZNj45EHrSPjjUY7i6qhGSpetdJuQQGKxnttRsjW6S/jiQQG3J6vs3JL6pLiPuy
 xXZnBLsVvU64/jEr8/PamwxNj4cGQl4hGmzBihEogYoTbHRbgW3JArFzHdL3uMkJ3r/m
 ax5x1ltyaWocirtdHgCo1PZgH5coQ0ttjkgISgoyszKIht/+8OSXpnZufOSygXo0W8mf
 Kd77xVznPar9s1QcS+HLh5kllnh7rCJDG5hdT6KFT9lpJpBzLbiS3feTsRL9TNPP8nPt
 Nbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511525; x=1760116325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3IYbDL7ZzrPeJgVCiHhUdegByQ1ip3ofl4M+Y1UUBtM=;
 b=bfuWiZ2WTVU2V5jTw7xuvE+2lCrSlSwgSxlIfEiAhIIlKf025H2Kvj/xRQkgfSe4+G
 qgC6ib4Kx6ggvHBd6YOmC6KlKJ7GPvAJnqAyBFcGYq5DSi4txNOElgUFI2DJZKzKdB1k
 nas13TaxuJEKpC+GqK12Bzy0zqcPPx6z2swCHsEzyvmLBGBsg1sVMysIn4uTV4s0kHTn
 WIulyZA35KX+WbVM+JkitlmgOxjKJ3CQIsLgD36APBWO29/TPQHYPmWNLdywpY4ZKgip
 QVtyFrWRRnaq+DzWVLZOfBzLXZHsA9l49lk2ruo2YcEHqPCWvO4ESjBH5vEcXv+w3ISl
 FEzw==
X-Gm-Message-State: AOJu0YzT8E0Y7w9Pi44VrvCh4d/UnQ4upT4CjHz8Zxm43DbnQbSgozY5
 AvqbYI5TPkeric2a/lJ+6XTBjOWhdM2KeljZJWLyny06Gh8ysNin+NDbiFdEZO5shmpTvRh/2Mo
 iD0PqGVw=
X-Gm-Gg: ASbGncudbIv2P4fa9ZYcnRy1FFEvRo5hQ0nSmt4r5Jm1anDInvLu2D6GDByZVXiesur
 35qkaV3WPDouE8ojFOlAvDvtbBjgcChlt5/6JMlNXqBWXP9Rf+Zgtko8Y8OPat7l8YkO2mUxeTF
 iI6TQHl1yOJ4ORRSadpzTH2Zt0tk+3xFBs0gfTsnRHIStvkIT4qexrSF8biigEI6CkKgKJ1ofJK
 S8+de80Yha859yzltLpaPFbl7SKcxY+ejzr1icEc0wY5NOWprMENjTiQRSPc08v/OS5eBQT2sOh
 HlrLggmORTrhxP2m+VTuH/Mspba5pigL4GhuppWFdXaLNcs+hbfVAxyVYnhlQgsseNti6mfuLMK
 BqVTX/rzYWAM0ihchcHVkKNPc3jxtSCtPfFxaJPCFb/NZpaoczVrz4Jfv
X-Google-Smtp-Source: AGHT+IGWEtCAsyoZ5nrIN5hNzYstdyGEDwY/gYwGMFXRn1G8akRZSZjl/BN9qRqo0XJAWF8RwfCrsg==
X-Received: by 2002:a05:6a20:7493:b0:262:8422:5774 with SMTP id
 adf61e73a8af0-32b62093e50mr5517815637.39.1759511524864; 
 Fri, 03 Oct 2025 10:12:04 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:12:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 70/73] linux-user/aarch64: Enable GCS in HWCAP
Date: Fri,  3 Oct 2025 10:07:57 -0700
Message-ID: <20251003170800.997167-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 77d03b50e1..3af5a37776 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -169,6 +169,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_dcpop, ARM_HWCAP_A64_DCPOP);
     GET_FEATURE_ID(aa64_rcpc_8_3, ARM_HWCAP_A64_LRCPC);
     GET_FEATURE_ID(aa64_rcpc_8_4, ARM_HWCAP_A64_ILRCPC);
+    GET_FEATURE_ID(aa64_gcs, ARM_HWCAP_A64_GCS);
 
     return hwcaps;
 }
-- 
2.43.0


