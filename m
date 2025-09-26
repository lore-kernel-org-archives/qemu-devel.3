Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B80CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 00:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1w4L-0002Lf-6X; Thu, 25 Sep 2025 20:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1w4I-0002LO-1S
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:12:10 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1w3u-0005EE-Nr
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:12:09 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b4755f37c3eso1451221a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 17:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758845499; x=1759450299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AD/PyjULMWNsbOT+qasBe5z9ghqTPjtFk7Z+MdCO/bU=;
 b=zqgp89OFgM1od8I2P1n5itMWLzuylRdW8Wd37Yvw+Idz+TeCv+XMlMNlGytKl7ojf+
 lPHhmKOLNeTAvhwuqVRo6GeSXntBWIWeo8yMZuTcqXzAstE2dngSRJT2PVe09XFCvBKq
 9bN9E8J+c43/dDsi272K0F5Ee4rr+p93OIUa8z4DofsbQtMDY08DXRIFgj22cV9rghIW
 +DyIRiXCKrnA/KX4Rz3jutukUDq4/Gu5t1cV2HakOHOV384hF5E+tWsqqoYXlJ0UlqvN
 H+X+v+8xQAxlnLi1jh2pO8I/VrA8d5rJGkYosN2CRAfkn+itpc3vgT8J2xIS8kIkYu5n
 K/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758845499; x=1759450299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AD/PyjULMWNsbOT+qasBe5z9ghqTPjtFk7Z+MdCO/bU=;
 b=dUj/X0z9h+Oc8gAH3pCC1nKS517fIKe1A+UovPN5U7uM7RZRMyFhCI+xoNYzKMyvhP
 5y+B8vVoUOaho9MrhfvjcygSqZWm6Hz9LBCMnKMM/AgzxGlvaLDSZujC2cknVdo57M2w
 ojDtdufgPMzGUWBHiqRGSUB+Nie1CcBre+E81JnM3tZNEQrWhkbwOyG8nT3htc3K+k29
 zY2I7BbeFUwm5J3zPJHd6GlfyynqhbGXC/GHnT+967i35VRhWaoW7ZyJf+SybbJ9hVOQ
 qTuyJIcIBDJSt98KyYBEOB2DWwV8ExCAVhn0poNIAVPwDXqzWticnoegXSgpEczs+/y2
 MuMg==
X-Gm-Message-State: AOJu0Yz2HXqxZOsBJWgLb81fAU5X7xbpBwI6wzwQ4iamI1HKHS7uvoXx
 wuk2q5GMjnYOXD/zfeQ/rGKNvbMBTTBrWNQt216F1sAdPag8TLBY00uyft0PDgK7U52c30g/A/T
 7L9l7
X-Gm-Gg: ASbGncv+HsMsddW9gK9Ky6V+ODq+j1brj62wOBGL/qLlF4/+qEByUpvlZgsSisH0tBH
 +FksRz123ugioc9njBD1YScJlhJ93SsFxlbPIb4Z2r1zJznH/rZDD2OxWc0AbKNywBl2bbLSvrq
 okOsfP29EwZsY2kMDks7zL+SCpK0h/GSXhZNcnWr9fw2Aq0yDBvFKMjFYxJkVO63ycjEwGzgUNv
 4Err3uayIpaqEmgcJH0zPnDLwpLN06USsKqoZFKp1EsoOpLsmvX5qjYAFk5Sae/04q3D1KbXp1r
 rBwH2l1mHOf54+1/7hN3+TXo1Zql+G3uSkh87kmMZ3M7OMyQT7gLYhioeam1NFLekZylFBH00vv
 fT71Yx2A+u0lD01fFW2v69R4w2m2Jrssen84hN2k=
X-Google-Smtp-Source: AGHT+IEuAXbuB49RPoTl9ezQUyf3MpFC3Hv0Yw2ChE7AR8tfeG2GK00cnGQP6+qCLLUq7154W3mVGQ==
X-Received: by 2002:a17:903:22c3:b0:25c:982e:2b1d with SMTP id
 d9443c01a7336-27ed4a8931cmr62908175ad.59.1758845499267; 
 Thu, 25 Sep 2025 17:11:39 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6ac37efsm35829425ad.137.2025.09.25.17.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 17:11:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 05/10] target/arm: GPT_Secure is reserved without FEAT_SEL2
Date: Thu, 25 Sep 2025 17:11:29 -0700
Message-ID: <20250926001134.295547-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926001134.295547-1-richard.henderson@linaro.org>
References: <20250926001134.295547-1-richard.henderson@linaro.org>
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

For GPT_Secure, if SEL2 is not enabled, raise a GPCF_Walk exception.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 1cafe8f4f7..3df5d4da12 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -478,10 +478,14 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
         break;
     case 0b1111: /* all access */
         return true;
-    case 0b1000:
-    case 0b1001:
-    case 0b1010:
-    case 0b1011:
+    case 0b1000: /* secure */
+        if (!cpu_isar_feature(aa64_sel2, cpu)) {
+            goto fault_walk;
+        }
+        /* fall through */
+    case 0b1001: /* non-secure */
+    case 0b1010: /* root */
+    case 0b1011: /* realm */
         if (pspace == (gpi & 3)) {
             return true;
         }
-- 
2.43.0


