Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078FFC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR42-000101-CF; Thu, 18 Jul 2024 09:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3n-00085N-13
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:40 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3i-0004TN-Q2
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-367963ea053so635843f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308833; x=1721913633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7RaBXCOatE5DqPcmVv9n/BxPiIh3u0gJg6RupfAUz/Y=;
 b=Kk43L181VuZsiZo8pvVkUChCn6cNWdSvy7CgBhw6lgNcJQ9VXBik3JKgdhlpdOV4LH
 1bK8rdbg7A+A79LfJDrvRIjzfO79AB1rfqaK+1U8AwUHCmrxH/bzBMHNJmpRIb+DYFEg
 4zROykzcTCcDVNR0l8pGyCKrmj2X4LaU0UxJ6AjwM6yugjZyOluGJGefQNmcX5u9Atti
 fMJgHCz88PwuUHB9vGv8RtUEISeExuaLxNJve0A108R500MwD77w8o5z4okZgTDNyZYw
 Xe65kt/LDTI8Ckfrg6bYM1zS0v0Rpjc6Zd6BvxwEBGg5WxdO/Y3Y4rC0nZWyXE/fGm6A
 j0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308833; x=1721913633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7RaBXCOatE5DqPcmVv9n/BxPiIh3u0gJg6RupfAUz/Y=;
 b=A46EYN4pwV2pHeEcugItIEpfXDIS6mzGTJBgf31bbzA7plzNbvQxuCwD587bJOU/eJ
 wYDhw6a16Di95CifMJBOgD+y6kVCFeyoLvjQyD2rNXQQ/Yzy3ytAQaSLqli+R6u+SzFn
 F7Eu+ZNlbnFet1SFvQYd7JeA7sCnPZvJ4zW+jUS6s4hNPt0+veFEFPBxLCvOivp16lpf
 ME7aukv0XdXVfsJL7MEJ5KIyuAO0XQuXxc+xQpVnKF6AvIp5DjKQQ231/pRclhyIcfwl
 ZqGxXn0S2rzQA8h4SMGiknYm3CkNw52ZZ446JKXl7rbK4ligG5nxggDdAfLs1ECHISPQ
 GM1w==
X-Gm-Message-State: AOJu0YznSyX5ZyYZxACiCn/MuGbyNxYmeqyQ93Aqf+KSUPhOUPj8Wuac
 Z/kQwvnW3RRc+7tayWZ9NHwloGN/3xhX8r5S+p5qjiyBNb5iUbebpkb8CTgYJvxdXA5EHhhDNfO
 d
X-Google-Smtp-Source: AGHT+IF095s4kL8Xk0D/LvYekwMlrugXWXpfrQRz9NQ4DLrk92WvMzfrt22TW6intW8K3ETk6/yd/g==
X-Received: by 2002:adf:e9cb:0:b0:368:4489:8efb with SMTP id
 ffacd0b85a97d-368448990bamr2837952f8f.40.1721308833041; 
 Thu, 18 Jul 2024 06:20:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/26] hw/arm/smmuv3: Fix encoding of CLASS in events
Date: Thu, 18 Jul 2024 14:20:08 +0100
Message-Id: <20240718132028.697927-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Mostafa Saleh <smostafa@google.com>

The SMMUv3 spec (ARM IHI 0070 F.b - 7.3 Event records) defines the
class of events faults as:

CLASS: The class of the operation that caused the fault:
- 0b00: CD, CD fetch.
- 0b01: TTD, Stage 1 translation table fetch.
- 0b10: IN, Input address

However, this value was not set and left as 0 which means CD and not
IN (0b10).

Another problem was that stage-2 class is considered IN not TT for
EABT, according to the spec:
    Translation of an IPA after successful stage 1 translation (or,
    in stage 2-only configuration, an input IPA)
    - S2 == 1 (stage 2), CLASS == IN (Input to stage)

This would change soon when nested translations are supported.

While at it, add an enum for class as it would be used for nesting.
However, at the moment stage-1 and stage-2 use the same class values,
except for EABT.

Fixes: 9bde7f0674 “hw/arm/smmuv3: Implement translate callback”
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20240715084519.1189624-4-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-internal.h | 6 ++++++
 hw/arm/smmuv3.c          | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index e4dd11e1e62..0f3ecec804d 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -32,6 +32,12 @@ typedef enum SMMUTranslationStatus {
     SMMU_TRANS_SUCCESS,
 } SMMUTranslationStatus;
 
+typedef enum SMMUTranslationClass {
+    SMMU_CLASS_CD,
+    SMMU_CLASS_TT,
+    SMMU_CLASS_IN,
+} SMMUTranslationClass;
+
 /* MMIO Registers */
 
 REG32(IDR0,                0x0)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index cab545a0b46..472fdf2e5fd 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -942,7 +942,9 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
             event.type = SMMU_EVT_F_WALK_EABT;
             event.u.f_walk_eabt.addr = addr;
             event.u.f_walk_eabt.rnw = flag & 0x1;
-            event.u.f_walk_eabt.class = 0x1;
+            /* Stage-2 (only) is class IN while stage-1 is class TT */
+            event.u.f_walk_eabt.class = (ptw_info.stage == 2) ?
+                                         SMMU_CLASS_IN : SMMU_CLASS_TT;
             event.u.f_walk_eabt.addr2 = ptw_info.addr;
             break;
         case SMMU_PTW_ERR_TRANSLATION:
@@ -950,6 +952,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                 event.type = SMMU_EVT_F_TRANSLATION;
                 event.u.f_translation.addr = addr;
                 event.u.f_translation.addr2 = ptw_info.addr;
+                event.u.f_translation.class = SMMU_CLASS_IN;
                 event.u.f_translation.rnw = flag & 0x1;
             }
             break;
@@ -958,6 +961,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                 event.type = SMMU_EVT_F_ADDR_SIZE;
                 event.u.f_addr_size.addr = addr;
                 event.u.f_addr_size.addr2 = ptw_info.addr;
+                event.u.f_translation.class = SMMU_CLASS_IN;
                 event.u.f_addr_size.rnw = flag & 0x1;
             }
             break;
@@ -966,6 +970,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                 event.type = SMMU_EVT_F_ACCESS;
                 event.u.f_access.addr = addr;
                 event.u.f_access.addr2 = ptw_info.addr;
+                event.u.f_translation.class = SMMU_CLASS_IN;
                 event.u.f_access.rnw = flag & 0x1;
             }
             break;
@@ -974,6 +979,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                 event.type = SMMU_EVT_F_PERMISSION;
                 event.u.f_permission.addr = addr;
                 event.u.f_permission.addr2 = ptw_info.addr;
+                event.u.f_translation.class = SMMU_CLASS_IN;
                 event.u.f_permission.rnw = flag & 0x1;
             }
             break;
-- 
2.34.1


