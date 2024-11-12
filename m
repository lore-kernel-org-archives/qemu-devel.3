Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1E7D597A4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 20:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAxea-0001IS-E9; Tue, 12 Nov 2024 15:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAxeV-0001HO-8l
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 15:38:23 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAxeK-0008T5-8j
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 15:38:13 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e9b4a4182dso36950a91.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 12:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731443886; x=1732048686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yaKvdcW0NY8dMapEj6tw4tU32C5h1WMT1O6sfRI1f24=;
 b=uABqF/gm1d3oKtz0sIjbvRTww04he3eYgTivUPEI/LBwY2XR7xw6TCM7Q1PldqWilO
 47giKxw9I5dfPQS1zj+4PHWBLlS/+snzMgVqRq94M4pNc61C606WyKFh2VBcv3K6kzh/
 6IxO0TSl0uc1HLHFsewtfxjs7bBaf1GQCuELVlh3wHdkm/wV8qojYW+n0GBup1c4w6YB
 J3IjPDWPLZ2OVnnnzAj4ax0I+G4hdRwacuYaTZrtUXzfi6tZIKNU9WACZt7p6i4vClB7
 Hn3XFL3+SRy2cvfKBGnQiodjQoywIU/X2uFseSydYMHWSnnPVePPebOifQ3YyXMERglv
 M4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731443886; x=1732048686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yaKvdcW0NY8dMapEj6tw4tU32C5h1WMT1O6sfRI1f24=;
 b=jDMU9gYNWKfGMi7HFTfVvnmj8r7Pz/WNC8Iulm3VmEcW6kaXgK4hjpgdqwUrSpzY3T
 hxvPyu7mdeLybU8OWV3lYkgDBWOcUG9gJlhXDtAaDnaic27P4VkRrSRbjwhidZn817Ww
 D6IvX80JBDzpR9ToyA20wCPMKpyBRm7jXfADLVP8J/eFyihhHSWhdymFbAkudOA2teK2
 2bU/wDkkO2KsDP3wnYE/gtMiXN/2dTlMYraZ3g9n0jOoS8EvjBudLzmDDgupdqNJP5vx
 KGbT9cpjWq3u41nZ2LSoWNXLjQ9fij2O9DTxOSflBZexjwG0dpYlm8zhuIAjMMUtNa9Z
 Z8Fw==
X-Gm-Message-State: AOJu0YzEWA1y5hU3BsZqdDPzShmvVeehFH5fVpEjpgkcBweYgnoRAbVg
 TqUnR9aqHcmhT+rli3uQWQME0ReOb3rxZ0+zsYMQybO13X8+bYNV5LCo9TsOALDqn8GifPLc/bX
 x
X-Google-Smtp-Source: AGHT+IFVR7FvqKM0XxZbKEtilnOCzvswuLVBNF7Rdy32QhHvuyYpGS1hT7j1xFjdeP1CLd0ZO29gsg==
X-Received: by 2002:a17:90a:e7c5:b0:2d8:9fbe:6727 with SMTP id
 98e67ed59e1d1-2e9b1ec1443mr27786808a91.4.1731443885653; 
 Tue, 12 Nov 2024 12:38:05 -0800 (PST)
Received: from stoup.. (wsip-24-120-228-34.lv.lv.cox.net. [24.120.228.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9f3894192sm9860a91.21.2024.11.12.12.38.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 12:38:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] linux-user/arm: Reduce vdso alignment to 4k
Date: Tue, 12 Nov 2024 12:37:55 -0800
Message-ID: <20241112203757.804320-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112203757.804320-1-richard.henderson@linaro.org>
References: <20241112203757.804320-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/Makefile.vdso |   2 +-
 linux-user/arm/vdso-be.so    | Bin 2648 -> 2648 bytes
 linux-user/arm/vdso-le.so    | Bin 2648 -> 2648 bytes
 3 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/arm/Makefile.vdso b/linux-user/arm/Makefile.vdso
index 2d098a5748..8a24b0e534 100644
--- a/linux-user/arm/Makefile.vdso
+++ b/linux-user/arm/Makefile.vdso
@@ -6,7 +6,7 @@ VPATH += $(SUBDIR)
 all: $(SUBDIR)/vdso-be.so $(SUBDIR)/vdso-le.so
 
 # Adding -use-blx disables unneeded interworking without actually using blx.
-LDFLAGS = -nostdlib -shared -Wl,-use-blx \
+LDFLAGS = -nostdlib -shared -Wl,-use-blx -Wl,-z,max-page-size=4096 \
 	  -Wl,-h,linux-vdso.so.1 -Wl,--build-id=sha1 \
 	  -Wl,--hash-style=both -Wl,-T,$(SUBDIR)/vdso.ld
 
diff --git a/linux-user/arm/vdso-be.so b/linux-user/arm/vdso-be.so
index 69cafbb956e283e2975bac59a10491c0cbafca57..bed02804a4bd367eb9fd8ca54d0c980103c02245 100755
GIT binary patch
delta 49
zcmV-10M7r|6xbAyaRLAkk#lhrGQ`BrU>NUTo0WUr&~YvSTwestvG{WZ25D?qS41(h
HaR%oD3DgvN

delta 49
zcmV-10M7r|6xbAyaRLDVk#lhrweyTc_Z*p@&&2@VLR1?$m|vtIvG{WZ23l}Oc}8xt
HaR%oD4;B=<

diff --git a/linux-user/arm/vdso-le.so b/linux-user/arm/vdso-le.so
index ad05a1251875ac0c76685e1f9190a7307a8444d1..38d3d51047372391b3125c3f9f6ea5401f04bba1 100755
GIT binary patch
delta 49
zcmV-10M7r|6xbAyaRLwkk#lhr8{q*880U1i=t7z4dQ|b*DDU}VvG{WZ25CxDZDwh+
HaR%oD5d#(3

delta 49
zcmV-10M7r|6xbAyaRLAVk#lhrkUMV7Jk`NO!6O#urC$6IB@6+uvG{WZ26R_8MpaO=
HaR%oD?$r}}

-- 
2.43.0


