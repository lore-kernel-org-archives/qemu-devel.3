Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0BFCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNmb-0008EA-Jj; Sat, 30 Aug 2025 11:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7cI-00051W-Tk
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:47 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7cG-000434-Tm
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:42 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-77201f3d389so2808021b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506639; x=1757111439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=opS1/MQaTNLhtHvSC8J3as0oJFPKDsl0TAly/SBB3gk=;
 b=Z+PJBcTJPOLmjmA2RHy7KcBVV9nesJftV7R34njAYjwTJppdNPD4kGR4hJ7BPsia1H
 t8FBUpGjg+IZkeW9D3h7OAuSUVpNFzovwEtdShM56J7KcZTcYLR9opvpuk371YC8DcGu
 z+hK2pvJHLXxoro4Q6XjSPf0l30frtoY4Otah6hwxI7g2iuJnqylQMJqNyj+X90mq1Ex
 UUyygDMI7uRVYcpLoRxpRnCnuzNNMqj4G084TK1+a2lty8GrSWa+9oBrN9uMLn0F3UxZ
 GuJ48z44w7tHP1pinOmqX9fD7pk4ZtxKOZ52ae6/5cVUZ2Dv7s9rvD3CMcyXKbCR5x35
 VGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506639; x=1757111439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=opS1/MQaTNLhtHvSC8J3as0oJFPKDsl0TAly/SBB3gk=;
 b=iAjVc2vGbACmzPaRDvnbFtjqeyHtdrhINVd/egbDVftb2xjdka43kScqPQiTj6YKJM
 dkPIfVzcR60wl4JXWzUwKsZKh+oPNa2KaLT2irmXWD7WGeatg3LswP21b7qp/45Hslpu
 NuWKWlT9xZJjnDm/RNZZ4/MD/ewkuz93gARSkZOIUeA0NxVFQ0mLAMV3cTFFRNRuJvHP
 6SJtLqBqLUFOSPzBqaDx+BVLHFXf0n39sN2k55Lw5y2yag22hNYRHdVTB68uDmRHsUlc
 BAKcc86AiOiKkXZFCmxRdfzlIIV211rZDDNzmKYvyfPXA/6M7Spccn4YWfT6rlaJ7XGC
 evMQ==
X-Gm-Message-State: AOJu0YwnZ1cPvnHCF/57czvUPjS9ViJ16rSLTWjZV8gaoG40MrTd1t20
 4Qe2k/GehkszJAmJgzAx8gOhC1jWaqHyiCAnyEFw1v1eGxrEvQBsE4xX0hM67h1p6orin6h66fD
 LU/A2p1U=
X-Gm-Gg: ASbGncuSkly3+LZG5Z+xXw1hrxijFgjQJF/9NjDqEdYE76el9/GOzalqLDoGyrU2CIg
 tdIpd1DHxb7r1/XW/ssgBHReTJVgMDe9/oDy8bWlZu1h9USqYq5hK3XN+IK/8PnN3nv5sUvP5Rv
 DRHRsrbeVpu0erGlFs2XwVA0crkvdiyGNlR2/8mcQeEsFj5U3E8SFOnzcmcZm9AwQpP8/FQ6aYh
 EtNKB8JTJL+kE+s8LpibErUjT06M6FLbVNd2YRGPBNJUqocR3qNaB5WZCcEICkAtpx3U37Sh0V/
 o54/90bb0nTGBGY0gy3crVnVN+626zegbdzLxGCZ76LQAqLaqiTC1nH85IQfzm8CBzXlOi1otGz
 VJivbCVSJADDxckAgIhECA+1I1wDi+lKL9z+yLcwUSxNlPtDLALrGnwGrRjLJe2/p4HG/F94N5w
 ==
X-Google-Smtp-Source: AGHT+IGj5p8VWfnI7VTFWkeDM5p3xFzLej1t3JuCIYmrSN33XgXmdlOyFs0esai0tvRtQizh8TDWHw==
X-Received: by 2002:a05:6a00:2381:b0:771:f69a:c426 with SMTP id
 d2e1a72fcca58-7723e276e5dmr329053b3a.14.1756506639233; 
 Fri, 29 Aug 2025 15:30:39 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 77/91] linux-user: Move elf parameters to m68k/target_elf.h
Date: Sat, 30 Aug 2025 08:24:13 +1000
Message-ID: <20250829222427.289668-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/m68k/target_elf.h | 3 +++
 linux-user/elfload.c         | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/m68k/target_elf.h b/linux-user/m68k/target_elf.h
index 0737412cee..073c85becc 100644
--- a/linux-user/m68k/target_elf.h
+++ b/linux-user/m68k/target_elf.h
@@ -8,6 +8,9 @@
 #ifndef M68K_TARGET_ELF_H
 #define M68K_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_68K
+
 #define HAVE_ELF_CORE_DUMP      1
 
 /*
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 1a6e81394c..a3757c595e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,13 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_M68K
-
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_68K
-
-#endif
-
 #ifdef TARGET_ALPHA
 
 #define ELF_CLASS      ELFCLASS64
-- 
2.43.0


