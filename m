Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FC0C61DD7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x052J-0002sD-Q5; Fri, 28 Aug 2026 18:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x052H-0002pu-Ta
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:57 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x052F-0002Ko-2c
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2d71ae3455aso21850465ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787956011; x=1788560811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H7anQ+nZ6nEMZWsgrQz0HJu50fb8m+vAd3J9mjoNV9E=;
 b=m/LIY+sqUdCY3vLx4ta8Yjztw5YVhYUaj/jfXUkoLz/WvJBVJGtT6KFe2uq9hdgTlO
 9aX8tmnMbPzWuWnnAoOnO406MKFw3swlvt3v7+nZ5WKrH6VtxcUqTfeCef3649vIx8/P
 N6gQWipHzZ4pADks0v0KolOcdwdmamZVW9z0km+nCJZtGaEhxxU30jmV6UOHSOBp5NFo
 wwZ98F0Y2LQj9z+JfqF47wdXMfReNysrP9OgOTrUdktPB17iykUh166hrG0EN4DYSukz
 AO7J2uCMMS4wh5szddx44DqSIviCImapaoueVtmrlFCj0ij4lrtMR/82zZ0uqbCND3hJ
 Wftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787956011; x=1788560811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H7anQ+nZ6nEMZWsgrQz0HJu50fb8m+vAd3J9mjoNV9E=;
 b=BRt14BYzteXs0GDv1AY8y9SF0JZYo1j9BPBa/D7uGo/SXaiMHLoR1Z1hFvp/0VtZfm
 zp0Wb/TxvVesxK9EpfPd9Tz8oSPhN13fx8CzGTOLK7vlUzBezbbmZeGjrTlje2Tf8jCY
 rg6+t0n8UQHrRD+BFSZ/hcVQxUTKoV4QNJ9Ad8+ArPT/eyNDLbo3LHhEdYRJjJ/erdKv
 cL9zzhGX5wXAMr1Mt3cAFs5Lb3XGB/azoYhT3BO8HfDmYo7XStrnuL5/9XAyKwKxW2Bv
 0a0YhMFI4xIeAvUWsb+5XZF0pfPOvBMIpV5X1rjauA246AXEbhYmQFjIFp/1T3pVqLya
 sFxg==
X-Gm-Message-State: AFuF++mXDxg5XOTWjx0WRaECos0Wlf3EAN4DLLsTzxnt+00H42o6/Vs0
 EcIL5F88lyXpMeSXONRukK5BpAFIC8BfbJU1K4JOkfWcN7fbqrEZmpN5Hh2km4tscsoVffHFJoi
 41kH1EsM=
X-Gm-Gg: AYBFou354a9w2f2BwKFwzjADo1JkgGQ/HrmmbWRp5V/vbEZcmm696BSdXuNTRro1vtm
 yt6rKcu0Ouh3jxQUF3b6Pb7FUN4Q49yTl1ejZWkVLox9hNfuGexFgkiWE8ckVZQzpR0UmfKpeZp
 6+BHe28Pgtf/4nKePDUiG8XZYuft0N/rlrOoIuORt7LADhVJvD+Wzd5gbtMnLEwA4XAZTL+jeIp
 rCezhAkPdY8EJUJCXBG4hG8ptV/Hu0KisyVVWbimn5qNHH87we349aa+zbOJ6AptaAjI0DndWdE
 ZuRWIcqh2C9p31XRDsptMm7nN3sp83ojU+5DoWgT9Jfolgsb9JM3s8EgF0gXUQLdef98wLXiP3H
 qP9TLGZSNMp9rhJ8vr8iKzOmAE/QHJjkgpBIJhKELpouMQG+DCLlStNyozfWnj2MHeM6m9E2YSe
 wgu0uf/A3s6UL2MctiBTBqkYfkVgc/uMGz57hOto5Ifx1KnMAbFqAZhzhIoByLtSDXKDyZBdsEE
 2n762q7+0Ur1yMfX14a9Q==
X-Received: by 2002:a17:903:2a8b:b0:2d7:1cee:3682 with SMTP id
 d9443c01a7336-2d74dc21e53mr184210425ad.5.1787956010902; 
 Fri, 28 Aug 2026 15:26:50 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d759640270sm9178355ad.34.2026.08.28.15.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:26:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 13/13] target/arm: Enable FEAT_UINJ for -cpu max-v9
Date: Fri, 28 Aug 2026 15:26:39 -0700
Message-ID: <20260828222639.1432046-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828222639.1432046-1-richard.henderson@linaro.org>
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 4ef412a6575..3b745b5a85a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1457,6 +1457,7 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR1, t);
 
     t = GET_IDREG(isar, ID_AA64PFR2);
+    t = FIELD_DP64(t, ID_AA64PFR2, UINJ, 1);      /* v9.0: FEAT_UINJ */
     t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* v9.2: FEAT_FPMR */
     SET_IDREG(isar, ID_AA64PFR2, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index ff02435975b..59114abe6e9 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -217,6 +217,7 @@ the following architecture extensions:
 - FEAT_TTL (Translation Table Level)
 - FEAT_TTST (Small translation tables)
 - FEAT_UAO (Unprivileged Access Override control)
+- FEAT_UINJ (Injection of Undefined Instruction exceptions)
 - FEAT_VHE (Virtualization Host Extensions)
 - FEAT_VMID16 (16-bit VMID)
 - FEAT_WFxT (WFE and WFI instructions with timeout)
-- 
2.53.0


