Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE1ACA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkW-0002l0-7I; Sat, 30 Aug 2025 11:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7cM-00052N-N7
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:47 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7cJ-000440-9k
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:45 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7723bf02181so239188b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506642; x=1757111442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLhobKMRxEo0CbtdUR911qjNXLbwZnrIInwr1urPJ3M=;
 b=dswB6ha7mX1FusRJ+p7CLWegTAhEXjyKRMqoQbglhayMNUSMTyJ6Xiu6Ylcho0r4cO
 UMEpKMkcwpeeoJ63cSfGJdxMG1kbQTKR8vlwou/xJlEVhU5LQiK0UNot94tY7NQ4eewP
 vjqfeC7cK0B1iGJxZAmzeJdeR7NnOhsN8TrInPckRIoiRRe1q01vEGprmD3xOwvzVr3S
 rkTDlpeOIBtVasrSkc1T+rWAHpSRx5F+kLSA11uTFxYMV1WMRINQ59LIHSj9y87kU9nQ
 9PVMhAbJB4pT2zm0+gNhHT/0R23qG2L72dqaJJP7pCn0ES9fjzWHWFxrdOovJqTOYCpv
 prsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506642; x=1757111442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KLhobKMRxEo0CbtdUR911qjNXLbwZnrIInwr1urPJ3M=;
 b=gidHCE2xaCZdMJUnYdLpYePpEifIfwpnvfAlcD7r+bkAdUVKsyQi7NQAF/1Ez/Tsbl
 tjLA7lQKo3DN0wCkf9EF0UfzplnovDfBMtV07qhsj8dan+ikwvRbMCgIxCco/eFPL7/C
 EuHTquATEEmejczcgMkuiA9q0B69DW6XDCiCgJZPDqnAHiuP+m81ZxN9s+pL9CLThj3o
 hWHqcNmhpVK9UeE28G+0a7o5r1Kw2P8sxoeAxgWxGZKrv146ybBG04ezuzz2wj59AuNL
 zZr+iK0U2nMUItkAPZyzBLGB2ugBO6djs4hwFnCr/Y0LSzSWvZ+UnTlcp3oKELSudmCG
 ZlIQ==
X-Gm-Message-State: AOJu0YwxEH0F/H35qWkkeb+wcbkoTJlhG5KfsZtncJP8rcOoEc4v46jd
 INr4HSb1CF2rs6iIOO0fNnl8Xf89zF0FVvqLjaT3SH1k8iVl5eoeHnp+e2o1xz8/IB4/oLk1f+w
 W/ErRiUk=
X-Gm-Gg: ASbGnctULSlY6SGSn4EXZn6oij5h2tsIIEZyvcgHw0SgX2sdaqiyQo5jOr7GwZ+Y2uc
 0zjzQuT9J3/DTFvallYA+tqYNxVfevcGryqAjjvQubmybbDQKloCk6F0ukiaaWdhN9VxHGoEz/6
 gECq1gIHM0AVaxJT4S4aD+/hFfc6vZGXQzoUGNO7wK82FC+EGPzALNv1GhCDZt8ooskTk/TAxDv
 4CPLyYnBf28pAwGKNFtfHXh4SVyKoOhze31qANSfr29PG07MCH4BlKKCDDReStUiadOYtLgpEnR
 argxnKwIGA7KRmiAIoeTppfkmlL52wYQ8G3EgRlgvGKbluSz1ThZCTCwxvcDd10xEos5/cNoOL1
 gxLvipE4vSfYXXJjJW+Xrr+HCvDxv7qJWHVo4NsKox3GraQcCvn6iC2O+WlmfeKg=
X-Google-Smtp-Source: AGHT+IHe1tVkgqI/kaM7X09veNursxaJ8EbfVYQDXGNCuOBQkg2NdEu4iuTHR5HSDnWdjAHjk1rFXQ==
X-Received: by 2002:a05:6a00:1404:b0:770:556d:32e8 with SMTP id
 d2e1a72fcca58-7723e3502d7mr329538b3a.24.1756506641637; 
 Fri, 29 Aug 2025 15:30:41 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 78/91] linux-user: Move elf parameters to alpha/target_elf.h
Date: Sat, 30 Aug 2025 08:24:14 +1000
Message-ID: <20250829222427.289668-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 linux-user/alpha/target_elf.h | 3 +++
 linux-user/elfload.c          | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/alpha/target_elf.h b/linux-user/alpha/target_elf.h
index 52b68680ad..f9d6372c9f 100644
--- a/linux-user/alpha/target_elf.h
+++ b/linux-user/alpha/target_elf.h
@@ -8,4 +8,7 @@
 #ifndef ALPHA_TARGET_ELF_H
 #define ALPHA_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS64
+#define ELF_ARCH                EM_ALPHA
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a3757c595e..aff800baff 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,13 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_ALPHA
-
-#define ELF_CLASS      ELFCLASS64
-#define ELF_ARCH       EM_ALPHA
-
-#endif /* TARGET_ALPHA */
-
 #ifdef TARGET_S390X
 
 #define ELF_CLASS	ELFCLASS64
-- 
2.43.0


