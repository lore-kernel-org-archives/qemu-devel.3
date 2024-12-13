Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6FBE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBNE-0006q4-Iw; Fri, 13 Dec 2024 14:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBMe-0006bk-Kk
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:30:23 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBMa-0004CG-Lc
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:30:15 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-30225b2586cso32382321fa.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734118210; x=1734723010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUREKfOZFFX0Cik+qgjY7NL4liaNpXwK6Nn2DyaSOoI=;
 b=CH2PKthsQ1vfgJKV+SQgXGzAnIfh2hwaei89vQymw7KTrzbjEyIiUwMAXlRyqfKghd
 3tY5KdO3LyJw98lt1CPsXjs7W9YXvuBT4+vxcqQmqdU6NiOB21ZyBimz+T6mBrTlsWbC
 NBXmFQ2S7OhtctZ+andRRfXjOkWpJGDHvr0lfEFd0SCxzT70/1GghrSw6kKdEemasRdU
 ieBmoDwsWfDhU9581GarYm8bMIkjbmIQFS+a62tYkv6dzN+XRhC5w6EeCfgXhXOTL4ol
 eVSTlh/G9bxwMyj9VyfHMWOOo1Aw/3voKSYiDwNZy9kF8/dzz0eDxRkM8TYUiqO0FBpx
 AmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734118210; x=1734723010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LUREKfOZFFX0Cik+qgjY7NL4liaNpXwK6Nn2DyaSOoI=;
 b=C/WxqUpiSnH62O6xu0FYMmuM6OSjyF00EePGoSHAcNULNtNlgEata7RgIxQSvOEUpQ
 HODY9aHnZo2DmgvUQPr84eCJd/Ig5AtiSvFrUgea/iGZXyVDR+hVKwlRHLwxoevYDA3x
 Iv2FGBqnn77SfP0bsijEvUK22Tibx3a2XuhK0cwi6faIlmNE0zm+Vt4YttOgSDnyMSib
 cZk4ik/QC99gC+g42Ln2sIlOlTA1ORZUl/91ASKVdQxwvH16/IUICqEH+Tgxvs03Au9W
 LOcSkvacCDgXnmjhcjqd0bdMeL2rWflukgQ5XJJayFaW2Dj1TxiE3NGSnGzTzuSQ6EOt
 oazw==
X-Gm-Message-State: AOJu0YyFJos8dlGiMFPF+wfkSLkfbp5gc6km2JwhihU4Fz0sQ0+4blX7
 TPrsWLFhUWTpvsGu3rNZkE+Q4XUK3LrvwMj7awcZr4tlkhbQiUKPTFVI3bJrI4zZYapD5FLSqOX
 EW/GCWvsw
X-Gm-Gg: ASbGnctHujdU0BFZSbjH0OzPjogbDGpxo1PON5Nz9VxBwKNgu1vI3isqNtZqA+nOMsm
 WMOw8kCTzcVgpncMXGzJuuaFVTxWJvnlx1+s2QsCgAqbBeQwv7WNuZWkULDGCg0GklnnZ1Sqpwi
 Yv5sPxySXlIdBmiBb116SSqjJSntPVHBzdrlpUa2cQWGBb3p3FBzadS+LsrTFSLGvjazBuNz46S
 n3FVwfk04GwonRiE2LFjnZbt0E/jm8NkpBtnBZKMOSVNMmaLqaVzYdtG8CVdg==
X-Google-Smtp-Source: AGHT+IGvedJ1r5iXHmazvbfucc/Jar+Al5IFFU3P1KUFrj7kPEuNVG9ZTcngIfXa+xiKYp500zGZBw==
X-Received: by 2002:a05:6512:3e2a:b0:540:2fe6:6b75 with SMTP id
 2adb3069b0e04-5408ad762e2mr1167072e87.19.1734118210572; 
 Fri, 13 Dec 2024 11:30:10 -0800 (PST)
Received: from stoup.. ([91.209.212.67]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c01051sm6972e87.156.2024.12.13.11.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:30:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>
Subject: [PATCH 63/71] hw/ufs: Constify all Property
Date: Fri, 13 Dec 2024 13:29:57 -0600
Message-ID: <20241213193004.2515684-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 hw/ufs/lu.c  | 2 +-
 hw/ufs/ufs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 81bfff9b4e..74ff52ad09 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -274,7 +274,7 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
     return UFS_REQUEST_NO_COMPLETE;
 }
 
-static Property ufs_lu_props[] = {
+static const Property ufs_lu_props[] = {
     DEFINE_PROP_DRIVE("drive", UfsLu, conf.blk),
     DEFINE_PROP_UINT8("lun", UfsLu, lun, 0),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 79f786ed4e..fe77158439 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1752,7 +1752,7 @@ static void ufs_exit(PCIDevice *pci_dev)
     }
 }
 
-static Property ufs_props[] = {
+static const Property ufs_props[] = {
     DEFINE_PROP_STRING("serial", UfsHc, params.serial),
     DEFINE_PROP_UINT8("nutrs", UfsHc, params.nutrs, 32),
     DEFINE_PROP_UINT8("nutmrs", UfsHc, params.nutmrs, 8),
-- 
2.43.0


