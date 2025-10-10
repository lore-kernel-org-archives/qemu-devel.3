Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766F1CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CrL-0001Qw-HF; Fri, 10 Oct 2025 09:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cqp-00088t-8P
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:06 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cph-00043b-Kc
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:02 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso1246616f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101607; x=1760706407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LXs34KJz9YZyMhNNvOy+mAan3oEW4KEdhxsyD9C4Yc4=;
 b=GwndynbkNn73bZ6tyLxKTplt2du7Da/ziN/tZ/tg5xVV8I98H4s0b8sAI4xsLr03kw
 /Fw1yTg8K4hN2R8uiWpgy2JrKyHWctS7ZBQUaOCTh7dOdWp2G8dkJaVaeBgZ2DTXNm1R
 hgZLCUvMLr9zE1r1HKhVkcabxIXPU3u0HLfTJGFSEu+4i/IqGeAp7rNkTkIO2Baa2y+l
 XLC029yzncTgtEa9hC4bttw1mA8tGEqU51x3ip8YftZNEhtnulpE9zLvAByksf2Gh50i
 tdoSeVd+YRAivkCx981Q/wXFa3HsxNus6FfoZVHShYFpyoRISo3UglmgR0nln/O2F3+B
 5nJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101607; x=1760706407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LXs34KJz9YZyMhNNvOy+mAan3oEW4KEdhxsyD9C4Yc4=;
 b=BzVlcoVXl9djoprjm1hII+ehLTMNCvNDPmRlbrhJFKElZoi1p8wZb15fe+v1r7W1BI
 c/eAbI/pMN959abDPLwhD/UZC9yKnzAPelR03v/nu76w6xPVk28CFnqXzHUux2AcY8SL
 ib7QZbVVZG5FyjNCbujmGUufAa3ANANMEuPMYI4IhCQmrXl4VC/bmTV+ZM1MGEUzmsaX
 BL7IWPiRoEptzjVxCKHqium+fVrFCNqpceri2gAGCnnjk5nY1EHJSjKWcCR0Kn8jPIfc
 53xJbheKfdNHjchuJY5uhILPxe94K8MkEM8leTLc/eqG8lHYlfXTz9/x4XIDZy06DNtC
 kQrQ==
X-Gm-Message-State: AOJu0YwlyYMdrrRl3e1jqkQCC606+aq35HQE51M7r66S/NMHfHd+2OxQ
 CZKdYl7CpdFCUKgayyXe2kK9liHrRO8f1tOLObNg9aD7/HDXiQ86LoJ15nhSJimmAM8b/stO593
 S4Cbc
X-Gm-Gg: ASbGnctN2Zzb8wA5MGLtfWRILRGv1oeUBLoxR0zo5TYVZ8G5oLXhHZCBTAuGNogWcNm
 iQc7zUmKgGpWmU8DzYbUTlFQSmTLxBVnnu7TKOtoz0kXDwykyHKLI99In/bjjkUqdahWHWD6HQZ
 mAhDYBvwX4JPxQqscn+wEEh4DVFPy7lOPlSAW7KUKh9HrFOxDcOzMdugcf/TaTcWQ8fgr/hZQq2
 YzMIXs/a8lGhJJpKNc2arhFeQqWkGeeWyTjAfIn3tTuvQtKSKWMM0LeUtsHWEtyg470UthNXy8V
 bp+6GN1J8pDSQDn60QktbFu7skgK3VMFfqMQ5Blu2oExycSbvOMP4rVv3vd0clda0/8wuXAxLd/
 Xi1E61pZNhXhWzR4ZvoJr3dlScaAsZbuU1M7LXhDLPCGN3SvGcmmV2E4tL685VA==
X-Google-Smtp-Source: AGHT+IGODAukz8Akauy5PWiBgnhRNTuG0ygK0ufgpIOPcJxzjMOhFLztp5MekycWr7Ta/s3vLRE6Yw==
X-Received: by 2002:a05:6000:26c9:b0:411:3c14:3aa1 with SMTP id
 ffacd0b85a97d-42666abb42cmr7326719f8f.3.1760101606946; 
 Fri, 10 Oct 2025 06:06:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 70/76] linux-user/aarch64: Enable GCS in HWCAP
Date: Fri, 10 Oct 2025 14:05:21 +0100
Message-ID: <20251010130527.3921602-71-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-71-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 77d03b50e1b..3af5a377761 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -169,6 +169,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_dcpop, ARM_HWCAP_A64_DCPOP);
     GET_FEATURE_ID(aa64_rcpc_8_3, ARM_HWCAP_A64_LRCPC);
     GET_FEATURE_ID(aa64_rcpc_8_4, ARM_HWCAP_A64_ILRCPC);
+    GET_FEATURE_ID(aa64_gcs, ARM_HWCAP_A64_GCS);
 
     return hwcaps;
 }
-- 
2.43.0


