Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F6EC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 21:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9tV6-0004iP-1o; Wed, 22 May 2024 17:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9tV1-0004gX-GQ
 for qemu-devel@nongnu.org; Wed, 22 May 2024 17:27:51 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9tUx-0002eF-SC
 for qemu-devel@nongnu.org; Wed, 22 May 2024 17:27:51 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f338ebe621so1958335ad.0
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 14:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716413266; x=1717018066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xp2tqJpP1VGOVmvGLLfhZ7JUgsbCC6mxTTS1hPt+7hc=;
 b=TSaxndple381iskLluOsd3ZTGK/UdTxBp1Yt3kFxQf4vFSKebDBxnHYE5fFDU0mebU
 mv4w7Iz9qp2swhz5zGl6/p1imRcwxrmxml9cDA8X8NGYFtDfxAGPci+6MqO6irFDp+c3
 rc5yHhLmPsCOz95PPxt3zy+XpeAqIend9imZ4gLpbSvxLu+J+ua98WADRW4+exWjBXXf
 4POWZwWWTcXnCE6AjNPluTsuERO0YbjaclZn6P2LhJ/YkEGmMH5ky5dwt4HLR2SZO453
 8W2RJTUMP22bcjmt9IK0LOYR3QWTXk72CP8tCG9F3wx/K0Ho7NasY+V21DGsLgo7egpa
 uXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716413266; x=1717018066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xp2tqJpP1VGOVmvGLLfhZ7JUgsbCC6mxTTS1hPt+7hc=;
 b=ATQF7LAS9ivSCeF+DFTP9gsMNk3pzyj6GssMqOzGw7/5rbtsxyr55mxu6kLj1NXT+2
 EV4LvWeclzNVVNjK5NTDBkRNmeu0h+XE5n8XBySwz4izi12voj4Vj6bsDLXOeSEdUEcB
 sYC6ps3xo0xAKB0GLQKpP9zggOLzwhMcLYLF6dFJZFy77fq0bVscBV7befZVgPPDxt5W
 gPVtu4bfMFkMD84fvcOh1bvTt6kSgTsien2KsVG2DLgcXJNTCsiGP0yHBwIRf5I70Uaq
 7owC4oqoc6PWTWKV3lNkFq36Mvev/zztpXXlf/WgMjc8xV1fkaM7oXW3lMFuVwWb3rtZ
 MbYA==
X-Gm-Message-State: AOJu0Yw5yev2faSgjMtFMuez4IrEu7Dv2sY+N4Kqos7ONHTZh99gdUu9
 xtDDq94KqwdsmkrM9VcGDLzIMcb+UqePpS89eYZYkFYxcdrNpTNRfcME3vRDy/qqe3aN2sK1RBe
 B
X-Google-Smtp-Source: AGHT+IFy7XHOcEm2JZKYS3ftECiw18Kh1iLak+it3jBmxrblY+0UFrDAljo6rx8HuapUAFc26dklxA==
X-Received: by 2002:a17:902:e5c2:b0:1e2:45f3:2d57 with SMTP id
 d9443c01a7336-1f339edde45mr7289185ad.6.1716413266531; 
 Wed, 22 May 2024 14:27:46 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f2fc06586asm64621705ad.201.2024.05.22.14.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 14:27:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH RISU 4/4] contrib/generate_all: Do not rely on ag
Date: Wed, 22 May 2024 14:27:41 -0700
Message-Id: <20240522212741.297734-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522212741.297734-1-richard.henderson@linaro.org>
References: <20240522212741.297734-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Use plain grep instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 contrib/generate_all.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/generate_all.sh b/contrib/generate_all.sh
index 651cb23..5ff0b3e 100755
--- a/contrib/generate_all.sh
+++ b/contrib/generate_all.sh
@@ -78,8 +78,8 @@ fi
 
 mkdir -p ${TARGET_DIR}
 
-ALL_INSNS=$(cat ${RISU_FILE} | ag "^\w" | cut -f 1 -d " " | sort)
-COUNT=$(cat ${RISU_FILE=} | ag "^\w" | cut -f 1 -d " " | wc -l)
+ALL_INSNS=$(cat ${RISU_FILE} | grep "^[A-Za-z]" | cut -f 1 -d " " | sort)
+COUNT=$(cat ${RISU_FILE=} | grep "^[A-Za-z]" | cut -f 1 -d " " | wc -l)
 set -- $ALL_INSNS
 
 GROUP=$((COUNT / ${SPLIT}))
-- 
2.34.1


