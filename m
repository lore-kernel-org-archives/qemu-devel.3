Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2812C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWC-0007pa-Co; Sat, 22 Jun 2024 08:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW7-0007kG-0D
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:51 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW4-0000JD-9y
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:50 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-363bbd51050so2084493f8f.0
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058006; x=1719662806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QdEbEVs429MCQSS+xvirVRecsUYVa5N98xC7KwBFFig=;
 b=IvheSQufPLTb94SbDF7bQHG/Di8UxMHjDXvg6yhS0oHlqPFqabr/aK+W83kuYJ0rO3
 Z/W7tqTGPvk9H7esxVJzNOP5M/XJBS+vvc5/o4VTuHL+cS2Smc53Ahtuo0k4YshZG+xV
 ohdpLFGno9t1wv0Dn4HLZvayZP3zhtceGo1NLfXs8CDz4hyA1i72OnCJSucC8o1bfXMG
 uOVRH45UFEiJGDjntFAqPVXpqmXKLeEF4q3MHwg7ifdaJ2K3sbAtfX/w8/tD6AYmpofZ
 wr9pFr3nnOjO6QHpkju3nk2mUSsPbfHdlkMPOFrDY7K4nj5wbveZ2RpqzeYQtlHF5VrC
 HW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058006; x=1719662806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QdEbEVs429MCQSS+xvirVRecsUYVa5N98xC7KwBFFig=;
 b=clWL39PI9qdIFaDAl0y4RGDdviO6S0BfT3PtrkwoHV1HRB1IFO74Ub1s4JIezoYrxd
 pJ2Imm6m8p5NaMbf4z+QB7RGM1Zi8XUh0PK3ja2+P0ZYWBC3Dv8y/70ODhb7e9xore6Q
 41Vi5UC4uwS3DbNx+9gVpJZmLL/w8FRkdG8LiWZlj2yBxuSz0SmExlNRcN+ce2mM0fo6
 z8gzrEzDeXs3tGXOouNCspO9k6bajxpN8Cy7PeOz0us3b52emNL5YQzrjfiwHOwC8DOZ
 oLSpk7+oUROaYZqhbESVWE7C2Jal9JgW4IT4fQ91lVDCh+HLBFvqtXOkMfr2SS0gfq/Q
 tnwg==
X-Gm-Message-State: AOJu0YwYz4VSQx9qn37DPwxJjT0roU4GkOlMLtnkzK4Rn9aTzOcITnRA
 rzGzWSyOxzSd0lyWpZfyEeKR/vyUfit4pflNoHy5m3aOxqzAkgvGheci6PLKXKM9SZErh//W38w
 +/Ng=
X-Google-Smtp-Source: AGHT+IHGQ2ILAHvekV1Vy5WQyxgetM5qhgQAeCyqsfxJWWfWd2XbK6dlufc2q+/1i1vSZOISKoDcSg==
X-Received: by 2002:a5d:6a48:0:b0:362:8ea3:a3a3 with SMTP id
 ffacd0b85a97d-366e4ed2deamr603128f8f.17.1719058006259; 
 Sat, 22 Jun 2024 05:06:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/18] hw/arm/sbsa-ref: switch to 1GHz timer frequency
Date: Sat, 22 Jun 2024 13:06:27 +0100
Message-Id: <20240622120643.3797539-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Updated firmware for QEMU CI is already in merge queue so we can move
platform to be future proof.

All supported cpus work fine with 1GHz timer frequency when firmware is
fresh enough.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>
Message-id: 20240531093729.220758-2-marcin.juszkiewicz@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e884692f07f..87884400e30 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -62,16 +62,12 @@
 
 /*
  * Generic timer frequency in Hz (which drives both the CPU generic timers
- * and the SBSA watchdog-timer). Older versions of the TF-A firmware
- * typically used with sbsa-ref (including the binaries in our Avocado test
- * Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_impdef
- * assume it is this value.
+ * and the SBSA watchdog-timer). Older (<2.11) versions of the TF-A firmware
+ * assumed 62.5MHz here.
  *
- * TODO: this value is not architecturally correct for an Armv8.6 or
- * better CPU, so we should move to 1GHz once the TF-A fix above has
- * made it into a release and into our Avocado test.
+ * Starting with Armv8.6 CPU 1GHz timer frequency is mandated.
  */
-#define SBSA_GTIMER_HZ 62500000
+#define SBSA_GTIMER_HZ 1000000000
 
 enum {
     SBSA_FLASH,
-- 
2.34.1


