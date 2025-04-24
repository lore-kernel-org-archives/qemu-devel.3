Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E92C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kwM-0003kY-SN; Wed, 23 Apr 2025 20:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktY-0005uj-JE
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:56 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktW-00056x-M8
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:52 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-af579e46b5dso231357a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456209; x=1746061009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uk2ZrawXZYiOMoISYC3G3yGzQ++x7vjYflwSfXkzRVo=;
 b=wKoynpgvcpGEf32CLHu+wdD19/MNDk75eTJyzoNPjo2bGeieoioqH9/t47UKxDVDO4
 Oy9/Gopq5VrCEP+HhbnPncylTDS49FtfcIVWcBukhMtalESX2e0KvkSf+dczIuPhepoL
 iOTCxj/daLl5Sj44UbD2oJw0SekJPuOSrTQaArfolQO3YdlTQQ7HwxQx23fYjrPlA1Pt
 ZVpVMH1uuaCeNfJUQnwujyhfFn6ih1Lgf+VhGSPYCbyMPR4xF6um9bK+RLw2edKo4ETU
 dPYOrJmtn2RDpBjMIof0QyOSeRBPdj6vO8XMD7rXNm15CL/Im2Wb+CWFK1Goqu6tcaZM
 o4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456209; x=1746061009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uk2ZrawXZYiOMoISYC3G3yGzQ++x7vjYflwSfXkzRVo=;
 b=iQzEY+lThnduzYKiJTpCipgqXL7B+jHldlIRotjIMOcFNrWoZS9ocFRsCi7NLXPSig
 SAw1Grr9AzMvNeEuNu/TpEpBWKWi+Yud80TTF5NScD8sUNW/E+pNGLzGVT90RA5VauY5
 jv/jRgMoZeaeI7aElARs6wWazLiqnFsfb6nzUJKckBao24NlZZUdKaSQkkF4MORTxphA
 qRPdjIEGSOewp2QlMjHyQfsTffYOHiQFSHnUX5A0H2tmNeGzyfb5FxNiPcdploN158ha
 bLNCMtHs57MDIpgN2H8DIHjTkH2vSiZ8U19AQUYqgsyG93W85Bys/F6aQlYT2836TY4P
 gptA==
X-Gm-Message-State: AOJu0YzrBWexP9a8F+5Esi6NSY52HLqM2wzs2QIatHQX5u+ufi+18JJT
 IoSPOyIb66vMVHjbt0Y8DqiHxhOzNsiqLVzN5HggoTmDQoMFj8R259nds4RZzN4OxUEIpEMJQQD
 Y
X-Gm-Gg: ASbGncvzg7AO3hEvFvRSnbzqteYR0rrhiGSCHlyPMnu81j5Mcr68sK5dVLdhKxamm3n
 8h7MsE3gKOkZF747OKhvqbKhnIWSwtOvDiAqr29qJ5vbOjrVDHOABSAQDLyMrlVc4fgMiDShYaC
 lWboOjCziPhJ4pHngnPtw0x3vPQEpqy0Di9I3ZfNg4WKYATFD8WBH2JqvYIKswG7DzrjIo1E7ja
 ijOTfTr+aY5vfpxtgK0Shl0GQRNCr9Xs/BrFkOvvkjlbVTiUlaNKvQ6btkGlxv+8Kbg9iJ+c+C3
 7O9+sLyTVvR/G+J/TojZKbq/DubHeaDLFAiGrj9UaITfBETHEMnNup/XsWL4Ny3rFa71nRcxbK8
 yM65yeiYR1A==
X-Google-Smtp-Source: AGHT+IFBQvZndJ6ElYlfNRmIH1shOe5ELPnKCduHCbpwtP8myIV6PILrIpcoaSEcMb29HEN0tx4D/Q==
X-Received: by 2002:a17:902:ce0c:b0:224:1ec0:8a16 with SMTP id
 d9443c01a7336-22db3bf21e5mr9483785ad.21.1745456209053; 
 Wed, 23 Apr 2025 17:56:49 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 101/148] exec/cpu-all: move cpu_copy to linux-user/qemu.h
Date: Wed, 23 Apr 2025 17:48:46 -0700
Message-ID: <20250424004934.598783-102-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
Message-ID: <20250325045915.994760-3-pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 2 --
 linux-user/qemu.h      | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 5c4379f0d0..2aaaf0548d 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -31,8 +31,6 @@
 #endif
 
 
-CPUArchState *cpu_copy(CPUArchState *env);
-
 #include "cpu.h"
 
 /* Validate correct placement of CPUArchState. */
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 5f00750151..948de8431a 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -362,4 +362,7 @@ void *lock_user_string(abi_ulong guest_addr);
 #define unlock_user_struct(host_ptr, guest_addr, copy)		\
     unlock_user(host_ptr, guest_addr, (copy) ? sizeof(*host_ptr) : 0)
 
+/* Clone cpu state */
+CPUArchState *cpu_copy(CPUArchState *env);
+
 #endif /* QEMU_H */
-- 
2.43.0


