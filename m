Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD495D24458
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 18:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRDir-0006Ay-Mm; Thu, 04 Dec 2025 13:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRDij-00067K-R9
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:06:27 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRDig-0005Y1-S5
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:06:24 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42e2cf93f7dso887372f8f.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 10:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764871581; x=1765476381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cb5R6GVtT3ngT31J+bLz+2AkcRkLlyFAa9g4z7kxhQ8=;
 b=Rb85RnX+vFYjpLzqtXFXBTA4C8Fn+CmbmxUqMGHqNGRGFxKLbbCd9Up2c5FB0qXKMb
 TUaM1jF3/JurnoSRKtd2EodnSadiM6m9OyaAEtVFiu3jDYEL0+AP6fGiN3TTVYHpTbbR
 LBk6n/+MQcyLe0y2pIjWW30PakeRWAVBU0mcGu3Te05UhcQ0MeSWijS8FkTE+L+Y9CXd
 ruqXJf3jrgS+OmCT/TGcCIFbbJ79JT/XekiieRQ51jZq8nJtvDPMX+Swj0MFU9zmRQfj
 7kbJp04Yzrp+3OZOPRa53rUdXUONnBig5OwAjgkDAfmkGKM9S2141AI032SdWYFqlywZ
 +vVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764871581; x=1765476381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cb5R6GVtT3ngT31J+bLz+2AkcRkLlyFAa9g4z7kxhQ8=;
 b=UpmICfm6xBdad23rO1biNUpDz6Pl/hQX9NzF0+3nZhe5SMwaLVxe1utr8PWXaeVqvK
 SODFf1d8hsnLnze0ztPi28NpHHYePse6DXUSbl9UiLl5JoZmzEGgu7GR9GiNpAmNL/p9
 IALYqkYEOCRds+Gy7gxBblW0Hj9BRJvptcbVLHr5EcMNIlxrcfXobr/cUT5HleM5Hl1I
 pyxLGwW4ZcNMEvkKALnreFKPoIgbMsrfTdVDcZdTzJ/J5Zc8UCVwisjXuPATIfpyRCEk
 9mc2ZXawgzDOMz7xlm/cxBtpvFE64LK7H43vst2w5EMJ14FmsctQy53DyP2rEUqm/015
 XqdQ==
X-Gm-Message-State: AOJu0YwqDREY5prsF1DEoBkmWD2QKZPDUxMrKryDEjepjq7+quRO/KNe
 23U41PhlX4/O/QV7DENovUTzGi764xLzarL8ENxxCxjHBDjKtVai/14a9NnXMLiCGTlhs/6fFxy
 lntEi
X-Gm-Gg: ASbGncsmAf6fVY3Ggh9PlVt6B4KsZ8LnNur0IJtVMphiLlZVvrdtBpvlJ1iNKMf9jJh
 Um97U9OA8EFYsUVLu4fXknrus8dA2et4S7pXtlLr/OY1uRw7WUDlFhhfoo4ZzXuJJgm+5irQk9k
 CKXrV4EDvNf2AtX8rGnZZIEh7nUud6bNba3wwRR+9ody5efVh743D2HuCBSXHfbKkbYtlPCZ/JG
 J+EfaQoUFa7kPtORm5OTUzZ5Ldutp9ewPv8mphz0o3AXpL7EGddRqw0kA9eGGvlWZBYHsHT6q+S
 SUL0E/fEnQShBTYMzdPgvmlZJvrRPUJ2BLcHl4KlUrTTWJXFCDgeOJXTmwcNkzrVBKWzzfxvmiZ
 HCJYEOyMTEKT+bgXfvf2CxXzO9SQHvREI80r9q88oTvV4xIUXInxVjk7eYk04S5QRIfefBjDgEL
 HkvONaDKj3K5PZ
X-Google-Smtp-Source: AGHT+IHEf5tCppG3/fL6Y/N1R4fdiS4nYV50+bAh3hdQ+plEZb2YJYd+W+07S4f7ECz6bxqqH2i3Tw==
X-Received: by 2002:a05:6000:4025:b0:42e:28a4:1fc4 with SMTP id
 ffacd0b85a97d-42f731cf0femr7889380f8f.55.1764871581263; 
 Thu, 04 Dec 2025 10:06:21 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:d817:b2ba:2766:5b2a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331e29sm4589641f8f.32.2025.12.04.10.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 10:06:20 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 3/4] target/arm/tcg/cpu64.c: Enable ASID2 for cpu_max
Date: Thu,  4 Dec 2025 18:04:13 +0000
Message-ID: <20251204180617.1190660-4-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204180617.1190660-1-jim.macarthur@linaro.org>
References: <20251204180617.1190660-1-jim.macarthur@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42a.google.com
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

docs/system/arm/emulation.rst: Add ASID2

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 31a5878a8f..3f30ea5a30 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -24,6 +24,7 @@ the following architecture extensions:
 - FEAT_AIE (Memory Attribute Index Enhancement)
 - FEAT_Armv9_Crypto (Armv9 Cryptographic Extension)
 - FEAT_ASID16 (16 bit ASID)
+- FEAT_ASID2 (Concurrent use of two ASIDs)
 - FEAT_ATS1A (Address Translation operations that ignore stage 1 permissions)
 - FEAT_BBM at level 2 (Translation table break-before-make levels)
 - FEAT_BF16 (AArch64 BFloat16 instructions)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 6871956382..ef4c0c8d73 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1334,6 +1334,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* FEAT_AIE */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
+    t = GET_IDREG(isar, ID_AA64MMFR4);
+    t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* FEAT_ASID2 */
+    SET_IDREG(isar, ID_AA64MMFR4, t);
+
     t = GET_IDREG(isar, ID_AA64ZFR0);
     t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* FEAT_SVE2p1 */
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
-- 
2.43.0


