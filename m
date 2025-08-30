Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591FBCA1001
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNxe-0004bA-8j; Sat, 30 Aug 2025 11:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQe-0007G2-Ig
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:09 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQb-0004rM-LK
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:08 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b4c29d2ea05so2718631a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532821; x=1757137621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QDW+HxP2J6pK8IxGshUeq+u65rBy5XdnKzmGA8gxmkE=;
 b=imRO1LXr6Y+voYxwy/qTtemfQv+9IZjerxH/mMHXhQAKE88mesL9SGyaLceopR8niT
 zMGbAuzmy2k8dHcexsa9LVTpz0VAqBspS0U1JMxuPh13FWQVvfAhWcSXUIqtlWdlFBmh
 ZN5hyDS8DM/3YUcOJ4hVckdvOCJ7DkDz7UX1xfN7Uvmng8qxxVGy/hs9eZni6enaZDXh
 DmqfQuW4afrnkV6T/1grtKhRSBjfrizlCyd0rXft47Dh0qB+IorMMLVChwnNyh1zWxzb
 j0o6+KXiCcmjmCNQ7UNLotswVjijSSvUYXs2n/tIYn2rfRMvhMzgGajWGoU4ZphcfbhN
 O5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532821; x=1757137621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QDW+HxP2J6pK8IxGshUeq+u65rBy5XdnKzmGA8gxmkE=;
 b=uCbuRan+HgSOzDnczHr+n2dq6IOX+k/gweOPHa3kjO/ywNiH5fl/2oJKH+qrSBKgeX
 wg5SoO7iDT8DA379R8qjxdnYgkyl5i1PRagl7DRihxpD/p1+EFQdomQhQg92bsJcoDP3
 j1pSXoL6azgmrQ3PEYOJxjjehWsHo7Iz5P8hoCCFf2sLKWxPC+cvdzFwa3j/Y2MDDzc0
 4JcTBdGyaUpnWlWvMYRNIEQ2GK+Dbqvl+B9QP6qh0Wo+jS+kkw8GUKB0NfbnIct6dLLN
 ABv2GLiSWksqTGA5i0RDnf/24dbc2Ml9GU6pntxStcR/WpiiOkDILU0TXDR2lD5ED6fx
 uz+Q==
X-Gm-Message-State: AOJu0YyKHMEby1M/crUwdAjiTSGjXoJGN+1sdkhVGtYuZODKC894BMNq
 Cz4SjRfmUsW8LPyQUbV/o8XOAKT6mPh0s65Onxs0oC0iLRjUpTLWbcApz5qzUOYOZpY9NMtNdhk
 fRbUfKeo=
X-Gm-Gg: ASbGncuy0zD56wjNJEpBxnZxLcwWXCMfMvC+tweHHyXHFzS/QcOGQE8S5QVyMvG2FMo
 VnQQsvoamQHspoYyjaARJGTgeuKSD/cvkgcM58+shV34SxXxo1VwuGNbNMqgjTIZV0azjzQP1Rf
 w/peqv2g4x0G9tec3cBHXIvS2VrQCdFEl0Smtwo6xhmOG+/YZsMFwyQvWM/dr/ICwnazI/YTg3l
 VJQujKIXcsAG2qo2r1k7WEkKAfJHrsPOx5aK+bft2lGP2KV4SAvLExt2J+wOQh8P5GwstaHPeI3
 1jtGQDXMVKIYPg1wUUrNLQJehYVveTA68Xmdr4O9LEPkMg3BPgUl755COCa0YjzUdZBRHzfqki2
 wkjlAp6EBnkXbeWrMtCES0xLgwE9u6Uqf7G9ZXYD1aCLwuz509fSi1g97iIhMW+UV1aWZxzqi1A
 ==
X-Google-Smtp-Source: AGHT+IEW3oVXusA5f6MMdBbRRwQPFXvbKAoiAk4rSlo+maP56Bn/W/RmJs9L5oDAVnGhmaSIo5QTFA==
X-Received: by 2002:a17:903:1d2:b0:246:1d7a:99a5 with SMTP id
 d9443c01a7336-2494486ee1emr14314825ad.4.1756532820945; 
 Fri, 29 Aug 2025 22:47:00 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:47:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 51/84] target/arm: Add syndrome data for EC_GCS
Date: Sat, 30 Aug 2025 15:40:55 +1000
Message-ID: <20250830054128.448363-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


