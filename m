Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B74C47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmWt-0007UX-3R; Fri, 02 Feb 2024 00:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWr-0007Kv-32
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:57 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWk-0003YB-9h
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:56 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d751bc0c15so15093005ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853348; x=1707458148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oSDPCFSlupjS1LwiiY/IHM0gph76gQ4U11W6UuPY57o=;
 b=EiSvrjChgEw66HKwtucflOnIFKnZvaqkI7BGxUqbbKkRBwez3KMCgDAgi8bvpdPwbX
 iLtZ/x/YxRT6dk44mASsFc1R3B8vBgUmOxABV+hZ/yoSG5vKEOeW9krZk/NNm6By+7II
 4iqY21z1KEtd9nuVm7M7oZ0PUKijo+ylLiIYkY3HviwftDr1O2grUg6RmKW9HqZ/v07I
 4PgVj7l09zPLQHzlidWAQfDxWnv6KOD3kGClvXAuJEiAUpVQp8ENwOxbPa7Ci1lWNQID
 RtLUn2+snAwmBbVRlJZb3bD+tDhXwoI98iBEcAWwjC7WF7ufxMmmQjg814VfOui030qc
 Yr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853348; x=1707458148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oSDPCFSlupjS1LwiiY/IHM0gph76gQ4U11W6UuPY57o=;
 b=by83GW3LOnISXLLSD3ODO936amOATn6CbWCEBhGiYqHKM4QHKlsdsjixE1s/b9gzjV
 wjDAQv7lDS/wUiRu/HWT6Rc1ahsBtl9klsGZaXEYE0/vpcmxhtlEDDiWzsI6fl6V3oHL
 1by3SHqaMdWtP2hoHLkoMd9QGMcm94v5hUETLLrD68pSliYY5aLTrGqMn/zGrIUX63YU
 VdPNBmt1AeB44AYfMRKkWsBOjsjEJxbdU3AzMe3cTaMQQPAXMBN9o4m1fpVfMHiYifuL
 mbcFZ0jjnbybZYimBt570ndBTfSIGWcHMApdrcP8DuRoXl1OC935eYmEtpG0s3VBxoS9
 683Q==
X-Gm-Message-State: AOJu0Yw8GvRrdAe6GHNi2i5rpCPBpWaE5/9AaCh39zHBpWf1fayP0Y7v
 m88oDeJY5ptcw2k4/17vT+8p41MyPuq82fhUXBV4x+7eqXuBa3TRGbqAmY6PZmJ8K9xfzffNe5T
 1lac=
X-Google-Smtp-Source: AGHT+IG6soDpuiO/GvCVxZ7Kz2Ff+edkprRRBUfnm/6VuhO1MPmP7zeJGhyrZMgdxQ/YjMoLh4c8pQ==
X-Received: by 2002:a17:903:120d:b0:1d7:587f:3748 with SMTP id
 l13-20020a170903120d00b001d7587f3748mr8137875plh.63.1706853348069; 
 Thu, 01 Feb 2024 21:55:48 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001d8a80cbb15sm752059plb.238.2024.02.01.21.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:55:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 57/57] target/sparc: Remove FSR_FTT_NMASK, FSR_FTT_CEXC_NMASK
Date: Fri,  2 Feb 2024 15:50:36 +1000
Message-Id: <20240202055036.684176-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

These macros are no longer used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231103173841.33651-23-richard.henderson@linaro.org>
---
 target/sparc/cpu.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 986c7217ed..edf46b387e 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -202,13 +202,6 @@ enum {
 #define FSR_FTT1   (1ULL << 15)
 #define FSR_FTT0   (1ULL << 14)
 #define FSR_FTT_MASK (FSR_FTT2 | FSR_FTT1 | FSR_FTT0)
-#ifdef TARGET_SPARC64
-#define FSR_FTT_NMASK      0xfffffffffffe3fffULL
-#define FSR_FTT_CEXC_NMASK 0xfffffffffffe3fe0ULL
-#else
-#define FSR_FTT_NMASK      0xfffe3fffULL
-#define FSR_FTT_CEXC_NMASK 0xfffe3fe0ULL
-#endif
 #define FSR_FTT_IEEE_EXCP (1ULL << 14)
 #define FSR_FTT_UNIMPFPOP (3ULL << 14)
 #define FSR_FTT_SEQ_ERROR (4ULL << 14)
-- 
2.34.1


