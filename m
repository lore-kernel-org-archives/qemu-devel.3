Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAECD116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 12:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQP5w-0006c7-U6; Tue, 02 Dec 2025 07:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vQP5v-0006ay-2r
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:02:59 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vQP5t-0006UQ-5b
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:02:58 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so39999935e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 04:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764676974; x=1765281774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cb5R6GVtT3ngT31J+bLz+2AkcRkLlyFAa9g4z7kxhQ8=;
 b=IHktu8e+lbSZLAb+x6Ai9JR6pbXZ0pPq+Lw9BLHwxc359WTBOP9nVOEvHK3yhvSOTi
 K911r6B/ChF31Lf3hbXSkTT7ECcIEch2AdABTCSyHXA6OnSR/9A2GNYDFgyD+zDESUBq
 ZYjr6NAgjIq/ZvRU7kADfyUI3i3uUdk29jnNr0rfS08r9Ev4r6FsMEyQjRfirrq9VZy1
 fvwoFVlc90PhM6r98DLwj0ZetizGTbwdebG5ApYjTsz1H2h8Xf59T7Nn1cuymSZ73mxz
 OpYJ4dIgZJNTwyCfjXTLWYvWY4f4si4cKTZV+AEtCpzCifpCpc6DrkNxENWiw3/mPH0Y
 PIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764676974; x=1765281774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cb5R6GVtT3ngT31J+bLz+2AkcRkLlyFAa9g4z7kxhQ8=;
 b=RiH1Mli9UQSVkcnD3QcFkQOLi0TzVUt3XGfIhKpgOmGx3addIE/opcFCnxdWFdqFEP
 gUj2Haa5QPycWj6rGf3l/whtNsnZ2bIHyQjhYUD7VuRwrdf0+heocV061kFyjXKqU/HQ
 QXjSN5waIKnTJV3kV3c1zqlXaNFHMu5gJLg2+7hVu4o5ChlhxeUS56eA4KT+WfPwnm9p
 19HfYG84ooR9ASgxlyo87AeVaJ3kydGzdOsQV7V8vcM521g0av9f7bbkYkuD/+OHqj7/
 YUvPnOBDHe+1dHt264I68WR0j/gWSo0Y0L6Q2uto5ElZe4Bgf6WTjzzhFYLlRcY/6p5A
 Wyvg==
X-Gm-Message-State: AOJu0YzwF5zvfWWwq23Q6pVSJdxn0FhV9kIpHQotuK5A2PdnmQQfvhcO
 Fq97bBPUJMjDZ4+XNW8eSKfMH3zzW13ISb/+PgFZ0e8tZ1VmzmnI/YjHdC1rExl+Vw8Wh5T+Bon
 VMy37
X-Gm-Gg: ASbGnctjo3Rqne3byySiFQ9ezDOhc6P54dFTZ5ZXsyJ3t13RxUVdyZwdjpOQUPYivTi
 0T/qHjOZ+ymR7CtZg4sP6hk1HJsoZku6zt4N8tIrXvU3hMk14fOMMtzDsFabCl77DQaYSRxQXpb
 u4VpGmJw/GL+BIZiw5GJU7KKCSmt/mlX5m+Sg3pUbfypgf0uRflXKNBYS58oRxXjL8duzijwXev
 6D2KFrR5bktCYCFtf/vImf3Hcbx2ntL5Bnrd/srgWxzNT40/HDhnN7bHryTgyLCufuQvFrP/wU7
 U0zb9WaKnlgwLnRshsPtMlDa7S5GdmlTFmVVrkZpc+poac0Rq0e5QGWkmfuukig5Ew/srrutZH1
 rozTfLhO4qi+HKwJcUHGSmS4oyBYrLXNcAXpy1nHH7y1i6S4LUJXzlKE+OO3hXnpPSyW+7vvpbc
 XsSW+E4xt3PD9y
X-Google-Smtp-Source: AGHT+IGMG7vmd27FhrdSY7EruxuV1NgzIkA8GboB15uU7WP946fG1DCJ9SNJM/i9ZuqwsFdKdTMIgQ==
X-Received: by 2002:a05:600c:1382:b0:475:de68:3c30 with SMTP id
 5b1f17b1804b1-47904b103edmr328935225e9.16.1764676973778; 
 Tue, 02 Dec 2025 04:02:53 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:d0df:e484:1145:883f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790b0e21e8sm381169835e9.15.2025.12.02.04.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 04:02:53 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH V4 3/4] target/arm/tcg/cpu64.c: Enable ASID2 for cpu_max
Date: Tue,  2 Dec 2025 12:00:40 +0000
Message-ID: <20251202120250.763150-4-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202120250.763150-1-jim.macarthur@linaro.org>
References: <20251202120250.763150-1-jim.macarthur@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x335.google.com
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


