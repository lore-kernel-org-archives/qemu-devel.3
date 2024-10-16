Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC6ED2A549
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 19:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t19kX-0002qR-Ut; Wed, 16 Oct 2024 15:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kQ-0002jN-HL
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:55 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kO-0003rS-NO
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:54 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20c77459558so1574775ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729107111; x=1729711911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9wtdGS6j59IEw6lp5Sp3jQrC+uEbTCdVdwYMkROoHlk=;
 b=xvGMgC2kl9BwTc+YSZeLMjiJZszcwUdB51kC0VQBzX8Rq6tpXf1gdNMLlu+Jw2Y60E
 xvjTvYkZtd/vQnRCKh6FsFjmW5XD5k/FKeyhy6Kz/cZlgGZZ41JueNI9J3nTlFhWplAB
 v+/fm7Lz1b2c7Njl6Qm1+576WwpES2IuspNyVGV77m32ZBBuNs6tXwU8JHzVNKDb18RC
 +n2g3YaRZ3b0BIfZb5Retwz75dBd7c/PVc1yVRUoIXwLOrQPE5IZb6vVmX7mgP7uPw6U
 RL3aBs7K+eiL9rLM+tQZLWls0/wKNSd2fe6wac9WGRporqQhULzMMmOKIhYmVTBF66RN
 UU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729107111; x=1729711911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9wtdGS6j59IEw6lp5Sp3jQrC+uEbTCdVdwYMkROoHlk=;
 b=iHmGdJBRlQbTyjbyK9rt+rEth0B/VTSTSbCUiy0/DHSdC1b3kUfRpRfsEA3z9KSzAL
 wVuoJES12tB+oWCn/ek9KtLdWe1Xyvz22bZ50V75PLcji2pFcZJ/AlBXBBlBJweg7Cp1
 aawdvCE31VZ2wIUKIaiPkVbi/ioQDMh1SabXzqBaLWD8yqqXXU6WtySlN477isJ9JPW/
 ErK1GAuuaIYwK9rFB8+eenntTOxMHn/Wvo0S9F/tHUtz82PPus+X5P3HN8CFgv98obIN
 LzpDyMENlONsDbFdqeYbxHXassWVQRvtXq1UTtvNc8YqD7DTIlwe6bbshRDU3Qg5kDTr
 5nrw==
X-Gm-Message-State: AOJu0Yy9/9B9gEM47bm4Z2Scsj9FNEwGLqA1X2mDMKL48+a6EHcgTvrs
 /rt/ex9cOrTB81iIIqHi7Kb0+WVXAT7Qjv/RDwKe+F0Q/b9efi02jqrP+om557TCmDN/YgUHVb+
 7
X-Google-Smtp-Source: AGHT+IFa0TJpBbf39nRTVqKfI9sM5GqAtkpVWHaqE7pt7EthqmAptiyTMQSo6ZnlZqMuxWS3qlBdpg==
X-Received: by 2002:a17:903:2311:b0:20c:950f:f45d with SMTP id
 d9443c01a7336-20ca17261e2mr185693895ad.61.1729107111110; 
 Wed, 16 Oct 2024 12:31:51 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1804b6b1sm32323945ad.189.2024.10.16.12.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 12:31:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 zhiwei_liu@linux.alibaba.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v6 14/14] tcg/riscv: Enable native vector support for TCG host
Date: Wed, 16 Oct 2024 12:31:40 -0700
Message-ID: <20241016193140.2206352-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016193140.2206352-1-richard.henderson@linaro.org>
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241007025700.47259-13-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index e6d66cd1b9..334c37cbe6 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -143,9 +143,9 @@ typedef enum {
 #define TCG_TARGET_HAS_tst              0
 
 /* vector instructions */
-#define TCG_TARGET_HAS_v64              0
-#define TCG_TARGET_HAS_v128             0
-#define TCG_TARGET_HAS_v256             0
+#define TCG_TARGET_HAS_v64              (cpuinfo & CPUINFO_ZVE64X)
+#define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_ZVE64X)
+#define TCG_TARGET_HAS_v256             (cpuinfo & CPUINFO_ZVE64X)
 #define TCG_TARGET_HAS_andc_vec         0
 #define TCG_TARGET_HAS_orc_vec          0
 #define TCG_TARGET_HAS_nand_vec         0
-- 
2.43.0


