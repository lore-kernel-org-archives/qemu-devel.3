Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4051FCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jKv-0006Fw-9e; Fri, 03 Oct 2025 13:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jIu-0002zD-Qk
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:11:02 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGw-0006Ky-3Q
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:10:47 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-781997d195aso1820726b3a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511314; x=1760116114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QDW+HxP2J6pK8IxGshUeq+u65rBy5XdnKzmGA8gxmkE=;
 b=zqhee6a4Jy/y835uPWE3T++7tqtaXqaAu4n0XXfESygQJV7LKa/Z2lAbf7+XL6ACQo
 qjmRmbGmnvjxljpnAzC4kbS5XdoatqM5h6PqV51IV3nJyr/rAWgnILg8HvJ386yekEss
 UZCW94D4flXxJJvNYoWYxwYGea0X40ov783dN/TAwWPI0be+FU+Ju8sfw/V6nc4eErVU
 r45dqR1cO7SfF3vUaPgrCoeRHWmv8gD20KuQs2Xxv/6ry17d4PhPXLEhXZTfigHfqcQc
 h1RBBnqb4vQgc+YlpzOE6b+43UYr2h7uCqLKkdUGJ/vCb/2EzfZDj/NuYr0+uAX+hSHP
 kjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511314; x=1760116114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QDW+HxP2J6pK8IxGshUeq+u65rBy5XdnKzmGA8gxmkE=;
 b=TUfwnwK21PPMt1UPw2+6GJ3gQeNwz3DiCMgGUDF8IFpkjQkEUmCdvX6VZrKixuN7WW
 SdeUvOgi8HJghtbuq40QjEIWfaPZom9OWWMcIiiCE6oikj4UlBOc9RXn6EjLrGnotK+X
 Pzp6l5+rRwgnESVNAltgRbUengSztPe3zl3vz3mWBb+Iqh4PLt88YlC1AIzFfw6kWsez
 0naxpzLuiXA1t+Q5xRgaDQqthmnXpQ6SSzU7yWXKrUZKZvPOWrOoh4gaYJruAEUJ9ju9
 cBfisoDmN8hDjrLoqVBPvOUKFJ1dki5qXgp9PFCfcbHoPoXXHBYkDcd7DhsEC9X1Qx3q
 k9nw==
X-Gm-Message-State: AOJu0YyT7OnbpYbri1zCpsEbJGFHjAWUzXwHePi8ZAse7qWclmFkoEA9
 ISBAke3TPFF8RgF3udvJp9/6J13yRGU4VEAqQIhD/YxBD7lmjCYCgn83WdWd+ruFPjnX8a+FCKm
 4DUC+HWw=
X-Gm-Gg: ASbGnct33JypNjwaxrgbk2CFKiK+akg9/k+MvEiEjwaCdYZgQU6/nznPZ3iZcdgKw2v
 7/9c5FqR1jWQ1MIAMSfpNV2MMsZe34L83juOZUSHKzQ5iKMRzvMApyg+RB7khz/EPRzW67gbt0c
 c3me6QiYHxS0GRzqYn2GEfZwt8KCi3TOHx6Ub2fev8IFBRyODaE8LOwsItRBKl5yHlVVkzIbLyG
 sSrxcboycWONU7FLaDs+UI+2iRmcb+PdTYqfA6lD1jTWojPCx4/Pbg37ypom7dhKvJpywqnaPfJ
 b9alaVIm4MaLqSH6wCMk7LIo+rDO02s3TI0fL+G8dIfxAqF+03z3tnA5Fxz9G8Ge88u+96byVTm
 npxzzptAvO40bAesSql63o9q60NwEmciwjjQ6aYbnegvzbGsEhkMnHUdf
X-Google-Smtp-Source: AGHT+IHHPH2eo+gn8HuZaXgjtZoE8TLzvEvIqr2eYVvLr1/WDAKMrqZAAjhXqKiEC/W1xyXyd/LAug==
X-Received: by 2002:a17:902:cf0b:b0:275:f156:965c with SMTP id
 d9443c01a7336-28e9a67c6f2mr43261225ad.52.1759511314077; 
 Fri, 03 Oct 2025 10:08:34 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 37/73] target/arm: Add syndrome data for EC_GCS
Date: Fri,  3 Oct 2025 10:07:24 -0700
Message-ID: <20251003170800.997167-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 target/arm/syndrome.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index c48d3b8587..bff61f052c 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -63,6 +63,7 @@ enum arm_exception_class {
     EC_MOP                    = 0x27,
     EC_AA32_FPTRAP            = 0x28,
     EC_AA64_FPTRAP            = 0x2c,
+    EC_GCS                    = 0x2d,
     EC_SERROR                 = 0x2f,
     EC_BREAKPOINT             = 0x30,
     EC_BREAKPOINT_SAME_EL     = 0x31,
@@ -83,6 +84,23 @@ typedef enum {
     SME_ET_InaccessibleZT0,
 } SMEExceptionType;
 
+typedef enum {
+    GCS_ET_DataCheck,
+    GCS_ET_EXLOCK,
+    GCS_ET_GCSSTR_GCSSTTR,
+} GCSExceptionType;
+
+typedef enum {
+    GCS_IT_RET_nPauth = 0,
+    GCS_IT_GCSPOPM = 1,
+    GCS_IT_RET_PauthA = 2,
+    GCS_IT_RET_PauthB = 3,
+    GCS_IT_GCSSS1 = 4,
+    GCS_IT_GCSSS2 = 5,
+    GCS_IT_GCSPOPCX = 8,
+    GCS_IT_GCSPOPX = 9,
+} GCSInstructionType;
+
 #define ARM_EL_EC_LENGTH 6
 #define ARM_EL_EC_SHIFT 26
 #define ARM_EL_IL_SHIFT 25
@@ -351,6 +369,23 @@ static inline uint32_t syn_pcalignment(void)
     return (EC_PCALIGNMENT << ARM_EL_EC_SHIFT) | ARM_EL_IL;
 }
 
+static inline uint32_t syn_gcs_data_check(GCSInstructionType it, int rn)
+{
+    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
+            (GCS_ET_DataCheck << 20) | (rn << 5) | it);
+}
+
+static inline uint32_t syn_gcs_exlock(void)
+{
+    return (EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL | (GCS_ET_EXLOCK << 20);
+}
+
+static inline uint32_t syn_gcs_gcsstr(int ra, int rn)
+{
+    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
+            (GCS_ET_GCSSTR_GCSSTTR << 20) | (ra << 10) | (rn << 5));
+}
+
 static inline uint32_t syn_serror(uint32_t extra)
 {
     return (EC_SERROR << ARM_EL_EC_SHIFT) | ARM_EL_IL | extra;
-- 
2.43.0


