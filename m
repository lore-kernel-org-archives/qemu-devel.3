Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2315C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNUb-0002RQ-6i; Tue, 18 Aug 2026 13:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUT-0002Nh-Ak
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUQ-0001k6-4b
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787073631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hPq37S3/5f+UALRBnG2Nvpry3l28FypcVUsfe2ts+E0=;
 b=CKCowzrZLxH0Xj3yDBFwvEO4KwVQEUzHm8H9fIFnwTglqOLslP0cik0fC2eF9YmWkCXRCb
 Sw+5qAFdnPvY2DrCiHIXnKj5/O+MjJv+J8lfzM65LT26M5P7G53uXYmHthHuGQMBf5CDhX
 PNJdDgkzeHdvwkf4sOT8sWW92hUNEFI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-ywdZnzToMGGdtnOirZIObA-1; Tue, 18 Aug 2026 13:20:28 -0400
X-MC-Unique: ywdZnzToMGGdtnOirZIObA-1
X-Mimecast-MFC-AGG-ID: ywdZnzToMGGdtnOirZIObA_1787073628
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52d7b3adda4so327701cf.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787073628; x=1787678428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hPq37S3/5f+UALRBnG2Nvpry3l28FypcVUsfe2ts+E0=;
 b=Hrsa1V5EUivmN8l0+/19JeVziz8gztfsdPD69GKtRa64EwTntfBJw0vme+uOZMmczE
 fm3DcTYHPdBa7wD6IFeWQZQYRyf7L1w89SSyb9PA1bhytdfT4LmNS+Vj3sy6yT8X5ivw
 FFYmCZUZEGw71Q3IrlBfGyBEt0HTIicmETM0NrtNFjAGpRBqDTKe5Y3lwh7GzNYAkr5L
 3XqsnSoinzfRRp7JV+NqI0FHOKnduH8DomyOzUzSdG+0twm0zz+W2WIgKfiXmN5tntm7
 n5wazULvFCGy0+EZ3Ml8JbI/LiXdZMZF/2hUYOuyZP62YTm9105yRLZ+VbJLqlPdhWCt
 yzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787073628; x=1787678428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hPq37S3/5f+UALRBnG2Nvpry3l28FypcVUsfe2ts+E0=;
 b=UIempVwCr5222S/P6wY6phD5C/y8HBMmK75EEFqzYEztcLBXrqyxpKqG/u6g7m2Mh3
 xYda68fLGURCZbPUDhmRAMcH4svIevjJa/L6l+ETQhnYD7g4xR8PYBqmLPNOxvlaggLX
 qn0fyA7x60Wh1rTVCXU7i/+VxW7uawgCh1Jq8oBPgbGUa3PeTFNq2YAf490eGSM5IRYB
 guWIEvUZfbIkp4ODcYJjaSCjsuofgiJaPe8Hr+vwriqJao0jq2dXmyyh4e82PqZOHUKo
 fgTYqsvkowSsYPM2c/x5Px1XuiRiSK+jQoMpISBhdVREKHEi6dpDBEsjeT1C5HZKgrnq
 u+ew==
X-Gm-Message-State: AOJu0Yxe6JuWHddaspB5NFadyFZbHSbUE2Lwoqmnu2xVkf9szxPI0WnW
 OfWfoNbQgSro47uoGSDsjg1ZhAtDPk2t7g+Xl2xBKurxYmdK8X4n6h0m4PJSxClC/Pk0hiwqAzf
 iXUev8wlwiD6UixliU6Wj23Bz4IfJlx+/bh08lR2gWcy74i0t12VS2tMxfXCB8EA/7vMkaTNXP3
 Bed516RrYCtZSs1OfqR5jjHQKEbEmP6eyGAYGbfg==
X-Gm-Gg: AR+sD13/oSmEVTnQ4wjhRCdhL9/VPFey08Z5TxRBfmb1CIYJLPCQiEYFM3vaOngxYuV
 HHKID4on+eNwJWyNwnr7iRSXkzhrhLykSFNzsaZrtYj+cYPlDEbtCGM8nuc0g1ERXg3DvRIJSnB
 7cMAHbJseMcebcM73WsIzyn+gxNedIIPZ9e+M3h8sGTFQ3D/MY+oS2t/zh95Llh0dt075N8md7u
 Lt09iVCYWn2EmaE8Dyo1AW03+Ze4ZBkclzQwVgnUCAcI7ubsl3V360JADT0k8vUGO0N15CUm0mx
 5mGS+zn6FcwkNM7Hv8xvHg1iZPfQ2CYI+318LoRG7H49KCnvpyCDbCM6n8l0fL8zhsgixb67dcQ
 EJsOFKVGCN1aLn4NfW8iKdCcSHL9OmlRSwuP8QEy0j4+MjeUl3HG6jSZ0
X-Received: by 2002:a05:622a:2587:b0:51c:73f:e3a7 with SMTP id
 d75a77b69052e-52dbd6ec93emr111686431cf.26.1787073627658; 
 Tue, 18 Aug 2026 10:20:27 -0700 (PDT)
X-Received: by 2002:a05:622a:2587:b0:51c:73f:e3a7 with SMTP id
 d75a77b69052e-52dbd6ec93emr111685451cf.26.1787073626997; 
 Tue, 18 Aug 2026 10:20:26 -0700 (PDT)
Received: from x1.com
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c4584418bsm36560896d6.17.2026.08.18.10.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:20:26 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 3/9] arm/mps: Remove 32bit define for MPS3_DDR_SIZE
Date: Tue, 18 Aug 2026 13:20:06 -0400
Message-ID: <20260818172012.3052821-4-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818172012.3052821-1-peterx@redhat.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QEMU has switched to 64bit-only hosts for all system emulations.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/arm/mps2-tz.c | 9 ---------
 hw/arm/mps3r.c   | 8 --------
 2 files changed, 17 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index d6d178642b..f47b0cacb8 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -178,16 +178,7 @@ OBJECT_DECLARE_TYPE(MPS2TZMachineState, MPS2TZMachineClass, MPS2TZ_MACHINE)
 
 /* Slow 32Khz S32KCLK frequency in Hz */
 #define S32KCLK_FRQ (32 * 1000)
-
-/*
- * The MPS3 DDR is 2GiB, but on a 32-bit host QEMU doesn't permit
- * emulation of that much guest RAM, so artificially make it smaller.
- */
-#if HOST_LONG_BITS == 32
-#define MPS3_DDR_SIZE (1 * GiB)
-#else
 #define MPS3_DDR_SIZE (2 * GiB)
-#endif
 
 /* For cpu{0,1}_mpu_{ns,s}, means "leave at SSE's default value" */
 #define MPU_REGION_DEFAULT UINT32_MAX
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index caad820d3b..82a354e958 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -59,15 +59,7 @@ typedef struct RAMInfo {
     int flags;
 } RAMInfo;
 
-/*
- * The MPS3 DDR is 3GiB, but on a 32-bit host QEMU doesn't permit
- * emulation of that much guest RAM, so artificially make it smaller.
- */
-#if HOST_LONG_BITS == 32
-#define MPS3_DDR_SIZE (1 * GiB)
-#else
 #define MPS3_DDR_SIZE (3 * GiB)
-#endif
 
 /*
  * Flag values:
-- 
2.54.0


