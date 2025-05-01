Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466E7C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbOt-0004wR-0C; Thu, 01 May 2025 17:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOm-0004Rm-UH
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:53 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOk-0002Az-Dt
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:52 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-73bb647eb23so1414919b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134689; x=1746739489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tyYB9tvx9mmC6DxALf3PRadclD426tvlc4evfPNn6MM=;
 b=nb8NrFznu1vILDjye6HIkVeovVNrq/o7PsIlQOfVP0VahG1DCVB12mtFKWWZBHAs1X
 +CQLruBy3C8bbc2JSFo6fqRBsyhmnB4NCtIQLY1zQg7Aa+Bdn1g/ztB2sssRfo9L633S
 p0Q+7ftnl84HBQX2UNBIqPUH+tzj99lkhRjvkOuGtGD37Qx9YX4ocYXvqIRk4O9AxnyF
 xoHRE28+m/SdeUfy8uVamJ8CAvI1H9zs8hXx7BwkmAr8MpOvobeNYxK1z7gdUCEuiDaJ
 2k49IvO4GRE11Lj2nhS/SlZd/lVZS8P04/hsDBSfg+nEdKa3xmo6rVVodzPWegkMrNWS
 Sbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134689; x=1746739489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tyYB9tvx9mmC6DxALf3PRadclD426tvlc4evfPNn6MM=;
 b=DLqHNBXH8GgBf09fiAusDZnAayDpxiiC18dRFNavy24HvLpXGwV+MWGgdg6Q6eSckX
 E6bWo3grKDClHq+7Tu1u5S3rrCqs10hcei2I1NfPPdu8zr8L/7e95636e/yw7rOhDrFS
 wdNbJ3G0wXEQAjumbVp1tcCrVrbvuxOKxCBwkD6FtA+PllLE56SyC5NOhM0HEQpDJJCs
 eeMuyr1t4CI3s54KycNz3n0tH56tqGrk8Klpgp7OLTl1PVVbCY+fAO8NvovXQ5Ti6tWj
 VQoX+1gdssOFF7JbEuxP9M63FxcpZEtFuA42d2rlZieRRJ0AfKbYRpEFc9gb3IP2vKIX
 jG6g==
X-Gm-Message-State: AOJu0YxOYd6jfcl1IXiSSYyBqnbDvbqZgIZu8l1Zhg8anhtvmrWlFide
 LcnBxpepowlVTbzwKEmDeO6Vg9E3zwi0Dg7/KXv+SBxwbp+NxOBE9fNZdr01DQZWQNi6QuTG1/X
 i
X-Gm-Gg: ASbGnctsR1FJLiUGgJ0wCDORu9PxOjKUe9rU/HbVKjChVyJD2OCsfkCwo7zXywCFlRQ
 Ji+p3yx6lRTKcVS2VLO9+l8MNp5LU3uby76MxtB8BshGmXEHqP4oa663vt6/6uHBuM4U5ncO2EL
 7lSEnaFefhpWs2uzqQSoIJEQLuefmoEQpP36ZNS7gnCLsBAdm57RhpizGfNELbzR8BYb7ZWAmtd
 navNRLS3QrRhYWkG3zwm/HDhmkTe8dJt1Shbg13s0iIC89r8mbo+YDhk2EGDKJHca6n2dtNRSs6
 1aTG7asGozec2Ef5W3aK5N6gOKxmzcBSadUanBU17a5S9R2fkHV0Acuhjg+cGWEKrtoqte8XHqM
 =
X-Google-Smtp-Source: AGHT+IHFMe9eyVGfKBsYqoVmwtamEJyIIrYCXzwcojsfxlbZAjEninSgd5w8gMQiqwOyXMApl0ItrA==
X-Received: by 2002:a05:6300:4041:b0:201:8a13:f392 with SMTP id
 adf61e73a8af0-20cded42b11mr623013637.20.1746134688812; 
 Thu, 01 May 2025 14:24:48 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 42/59] qemu: Introduce target_long_bits()
Date: Thu,  1 May 2025 14:20:56 -0700
Message-ID: <20250501212113.2961531-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info-impl.h | 2 ++
 include/qemu/target-info.h      | 7 +++++++
 target-info-stub.c              | 1 +
 target-info.c                   | 5 +++++
 4 files changed, 15 insertions(+)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index 76766eeaae..1b51cbcfe1 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -14,6 +14,8 @@
 typedef struct TargetInfo {
     /* runtime equivalent of TARGET_NAME definition */
     const char *target_name;
+    /* runtime equivalent of TARGET_LONG_BITS definition */
+    unsigned long_bits;
     /* runtime equivalent of CPU_RESOLVING_TYPE definition */
     const char *cpu_type;
     /* QOM typename machines for this binary must implement */
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 2b6ccabb11..850a2958b9 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -16,6 +16,13 @@
  */
 const char *target_name(void);
 
+/**
+ * target_long_bits:
+ *
+ * Returns: number of bits in a long type for this target (i.e. 64).
+ */
+unsigned target_long_bits(void);
+
 /**
  * target_machine_typename:
  *
diff --git a/target-info-stub.c b/target-info-stub.c
index 86da297277..fecc0e7128 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -14,6 +14,7 @@
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
+    .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
     .machine_typename = TYPE_MACHINE,
 };
diff --git a/target-info.c b/target-info.c
index 5f5ef1f932..16fdca7aaa 100644
--- a/target-info.c
+++ b/target-info.c
@@ -15,6 +15,11 @@ const char *target_name(void)
     return target_info()->target_name;
 }
 
+unsigned target_long_bits(void)
+{
+    return target_info()->long_bits;
+}
+
 const char *target_cpu_type(void)
 {
     return target_info()->cpu_type;
-- 
2.43.0


