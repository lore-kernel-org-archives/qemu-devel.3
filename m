Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F8FC369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmk-0005Cc-Bt; Wed, 23 Apr 2025 20:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmg-0005AE-1w
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:46 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kme-0004JR-8F
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:45 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso358765b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455783; x=1746060583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XogLtFAmQTWKnFni/PyMhKIavN2RURu41I1WKUUy13M=;
 b=wSVg7Ti+c1Ohe1R9xcVYy8fnczWdVKNY/D49YOwQ2c0ucOO30DcMoCibDbMUsvb1/W
 NTLBxsXDdmPDw0rIJUADXBitzo3snsvMCRp6bwBCUtP47wht8LFG4qX5UlFNO4KEUbov
 SgQe2Aehpu7X86OU1pCO3UuCQUawpmdfFIZUTIUwDPLHswlG/3bV4Q5V1a6CMSvMOQDT
 CDMZjsLLm7xi4RJqlwOO2v20wLmsyWp+F/xBK6LYqklb8V/5stixPhM+vUxldRkNOh4P
 FKsHLB0OnkSZT8O6cNIrWrqa10VkoRiTKiNVU0ELKJoZ+s/OvjE6rNAMYNr6MAXJKPnB
 hgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455783; x=1746060583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XogLtFAmQTWKnFni/PyMhKIavN2RURu41I1WKUUy13M=;
 b=MC7P/uP50jdhMv9SNnDB59CjaBoScRQMH+ceJZkUJJOzm2aflrktRaOaQ7s9if5EEV
 rmcG8qgf3iGk4ofpvsyM096uy2FaXBEE3dCP1vV19g9iD1cWfx4W2KOLcPtgVjUqop5n
 5qtE2tvIPKHfsdfvGbCz+sofWOHnlmB8+3RMnC4PNmP9slDsuvwtYrgkvK0it2lsou3O
 wk8jXiax4FkxtowcBwxh/jW1SjxH7/1BwYMMM1Y95keHIOAln3Bwvcoy7PGCXwPxJ/Ja
 Ci2nt2swLzkcoPLOql0UtjNOfccZ1dRy3ImUaglcsfujfsBu7YQV2/ITLsnxelvBkRyp
 y/cQ==
X-Gm-Message-State: AOJu0YzFyhWgb/GjYqo9ZwtBJqh5jMHsmWSPzPRC4/lzWQeLTOWbFjHE
 jiB6dh0BeXG+eCTBeGbuCUHPFJpTsu5Pr7WWKRupAPzZA7jkP2siMUBY+Z/oqDwSLD2/HtL2gyK
 S
X-Gm-Gg: ASbGncuvjFpTdutXXr2jANPXfq1+VAr357IUl5NVMBPqnK8/mcmoMIagIlgS6bSJekK
 Y05Zndv/n5peL2D+v4ecSjeVo5uJDULEG+rnnN8z0IeAQalqEkp7e5yv0vKzx5Bf8oaOrjl/Eoe
 DhEbzVH2kfCvHfbQUEpvdRvluvhtRHwy9OdP9hd3EDWS/UF43AQ6gDLCn2r72qMbpCusBMsijJ9
 7ycygGc8UBXrix8eQlbfM47446TBl8BcDLzKnC2PgVZAO8SN8lzV0Acp8iBmsjiKoeLalcdCM0Z
 GJUTZs+hgEca8xHdTVmuIvwZ5PbL5Ezeef3cwvd6lUCQqhd92w2MF5X2PpNA4BWt65ItszP4/T4
 =
X-Google-Smtp-Source: AGHT+IEqGYk/MjR08X59nB+SwBCoqqKpJupqCBnZGMaJ8jdag0u//xoel0OS3yUwwDdCflLpmCwQag==
X-Received: by 2002:a05:6a00:6c98:b0:737:cd8:2484 with SMTP id
 d2e1a72fcca58-73e267e25dfmr659723b3a.6.1745455782748; 
 Wed, 23 Apr 2025 17:49:42 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 011/148] exec/ram_addr: call xen_hvm_modified_memory only if
 xen is enabled
Date: Wed, 23 Apr 2025 17:47:16 -0700
Message-ID: <20250424004934.598783-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-12-pierrick.bouvier@linaro.org>
---
 include/exec/ram_addr.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index f5d574261a..92e8708af7 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -339,7 +339,9 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
         }
     }
 
-    xen_hvm_modified_memory(start, length);
+    if (xen_enabled()) {
+        xen_hvm_modified_memory(start, length);
+    }
 }
 
 #if !defined(_WIN32)
@@ -415,7 +417,9 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
             }
         }
 
-        xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+        if (xen_enabled()) {
+            xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+        }
     } else {
         uint8_t clients = tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_CLIENTS_NOCODE;
 
-- 
2.43.0


