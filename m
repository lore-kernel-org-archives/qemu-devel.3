Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9633DCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNu3-0000aD-QU; Sat, 30 Aug 2025 11:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELn-0005tb-Tt
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:09 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELm-000478-1c
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:07 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so2909015b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532524; x=1757137324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LrpEbuupTDGPoF+9xpEpdSwm7VuWd0B4c9SgIZ+YWys=;
 b=LJRF4KyU9n/MawfX1isa1ADVuocxTE02V60mF2mJ++wZ8/IGHenWrbpENBxiRBSt2/
 VPPkktd65boWsvwqxKNDGVeAwBh4oocR2W3sV6apmf9mI4lGvvydoNfZIeNvzMWxmUgJ
 soiv9KmQWDdVL6aoy+bCW86RfGC6cmwBS7CIVV4Nft/X7UULZzu1TwMkoUDtVo9NWOzb
 ttD+oKflGXs6EtUbAiEGIzgMTrzW0KNLR4g8GBqeqpeZYroQ/BTsuvT+g499YM0pDGyB
 0/MWv+OXmv0F6IeR+89AOHEEYLqvGNEv12vsvsgUGjvDUrgy5alKcXEsLkFDjxU5rovC
 Ghrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532524; x=1757137324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LrpEbuupTDGPoF+9xpEpdSwm7VuWd0B4c9SgIZ+YWys=;
 b=wiYekvsQK+HX1RITWBtjp+usegEK3uxu32wwUVv80/JeZrWQrN2VCp1ZJLgvbEP8+a
 4SobsmB0kMMvVr/3nkKvIWEiBn34/rW1lOy75M6VhOChMNXkxG+w0oBG8Z80g1+OcucZ
 7+DWvVpCqUg5GnVakrBD71wcHR15MIVUsqsCa3GyZphd0m3mzoynoPrjuVCs4olXMxr7
 mUQcqG7/YmcfRtdIBbW4JSlaLq366uFsB5d2hg94/E82Cavzd7nGoh3ueNvpPeoWAqRG
 J+STWS2dYd0fZE+No3f3tKL3J9GXsIkGb4WFn2lLSvprgPkD/91AVh/4t1HCz8nCvUWv
 ppxA==
X-Gm-Message-State: AOJu0YzrwmP4+THNpv4KH3G2DT4bd78+vbuGztqjeuGCCADlQto7ULc3
 4J7WouC3vfpKVBvxdZAVplqeFKFgQduf+rLaQZE6NaRRSIWAiQi+mr97K48JwajFpAXEkgETAWC
 56zv46Ho=
X-Gm-Gg: ASbGnctjeuyUyWcxvT3pUwQRbRGFQnZUGBBtJD9k+SrF+1S+qKHbsDfLPEWV+YAV3Ak
 8NkE7Ulj0nbao01etlfejNe1UCW/4xur1d+sOX/ajT2LJGZBi5goC+n0he+OXITfXtTWvQ+DRKa
 XpWpO/JhAIar/BBZnLHbvZNptOWJUieMl0uVi7LoayfcXvk+m7ZXCz4VRhMoVviSajw7Jjv0oRe
 47duDvF5xJ7hdZV0SJT7JQu202YvDswNBd8S9W2AmBPafcb7r8X1mJiDcJmG5vFsYmYno86nJPs
 2k4wxWo6CUI2I9ntMZw5t9otGeKDTyY55KKaBBAdiJuU4jtq1trvnCwfB8BLajl9gVbty5DvOBQ
 vWTNkdVS16+cUygABk+xreDc8j0EcFB++HRqWFYQRpdAxU0kXLbgtGE8pevnJBqOjDya27fU=
X-Google-Smtp-Source: AGHT+IHpdXZmyMUkWaTfqEEtPerDgTDkW0FSrovCVlJ4lrOJoYSNB+/7ShR3lje9DJpc0axVBM0cTw==
X-Received: by 2002:a05:6a20:6a25:b0:240:1327:ab3e with SMTP id
 adf61e73a8af0-243d6dcec6dmr1381147637.9.1756532524151; 
 Fri, 29 Aug 2025 22:42:04 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:42:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 11/84] target/arm: Remove outdated comment for ZCR_EL12
Date: Sat, 30 Aug 2025 15:40:15 +1000
Message-ID: <20250830054128.448363-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

The comment about not being included in the summary table
has been out of date for quite a while.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5a219703ae..11e1c52b70 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4563,11 +4563,6 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
         { K(3, 0, 14, 1, 0), K(3, 4, 14, 1, 0), K(3, 5, 14, 1, 0),
           "CNTKCTL", "CNTHCTL_EL2", "CNTKCTL_EL12" },
 
-        /*
-         * Note that redirection of ZCR is mentioned in the description
-         * of ZCR_EL2, and aliasing in the description of ZCR_EL1, but
-         * not in the summary table.
-         */
         { K(3, 0,  1, 2, 0), K(3, 4,  1, 2, 0), K(3, 5, 1, 2, 0),
           "ZCR_EL1", "ZCR_EL2", "ZCR_EL12", isar_feature_aa64_sve },
         { K(3, 0,  1, 2, 6), K(3, 4,  1, 2, 6), K(3, 5, 1, 2, 6),
-- 
2.43.0


