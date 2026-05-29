Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12987CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvgb-0001SD-Mb; Fri, 29 May 2026 07:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvga-0001RZ-6N
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:32 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgY-00089h-Go
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:31 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45eeea039ebso594201f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055248; x=1780660048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pqgjLk9hcZcvEqOGVxmXXRLNzaRiqJwhnX8AJK1bTZE=;
 b=ONdftkilZuDms6H3uN2fuHBSblKjjkteWgcV2K3vcZQz3rhaNFLEkzxwZ6PxkvWTei
 jFR7OpoigHA0nzBLCi/smnKwF+SPB3UOljlffRCiJoxHrOb7IRaM3qi6GaJ9+QRJOWM9
 tXSmDv6pK+lg7VCIZo2i/QJjzPPUKiD0YYcl5Y7Z5E1ElcTIZBVfof31zqqCpkdFTbFg
 sTx1colW2XGHSHxYGgoN1D0LsY2LZyVrXufnikCPqvdWdoEn3p5I6wTB3ngaiUrDP8bO
 6B6wW71Hmc/rA378sw1y+GWnDtBK1+ujVuzETd8VEq9Zl9Qn7fjY5Gj5gPDmJxfs6Xwp
 1OSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055248; x=1780660048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pqgjLk9hcZcvEqOGVxmXXRLNzaRiqJwhnX8AJK1bTZE=;
 b=rZpZaWtpjhL/A8wMMaQaWJ1AZqrXpUEOZ2f1TN4HUizRNGXa5PQamiPcvVc4T8MI0k
 5svGdJR+CT+hRYBmD4PZujg/Vbal4yJw5OJimFXmMvvtfvyPtzHfDEf6zqnys/TJjVKg
 kJ8zsgKRsOMDvrQA9EbidpPEV/q4YboEuCSQli45XXsTVQ7TBuC3QxV+pncWeFPjuer/
 AXHEqMBkxeZZxg+bssJ9MfD7fgq5p6s1s3xGFbhcpUtlxnkVGlXDrbRlYP0BwlQW29KW
 AimPUZqSbVCXIwP9nfAxl7UzX7jnlvhKkZgNwEcLCYgXbbbOppM4VvmdRiVXiYRy0S8v
 AbRQ==
X-Gm-Message-State: AOJu0YzFHjTPDCOh7+41+gxVwQG7ph3zfQMK2LhGg/6O6dMw7Dze01OA
 oMr1oIQxSXtuRgCXzxJ+Q0Xjff4uEjRJ3rOzjDHr0kO/AYuLDYlvSptvzTjIz0TKd3VYxGICIoM
 0McXw
X-Gm-Gg: Acq92OHvB941p8huL9mv5UuECZO5CWIJotYe1+lQftbHbfqVjB6xNqy/7oB5zHOWzTM
 SH8DSvlpm7mn9ttdrp5R2+JYDQ1AxJXPHgfWgb7FA48BGsRSZydYjgnTHvLVsLYISyQFmoeQcJ+
 Yeu0f7qA8SsA52Ta31T6M9FzBarVxe3zeMTEfU1KgTdIgvjyFwkRZQLHkWYx0Haa37k6oQ14igD
 b53iNNS+aQVPJZJ4zgeDpsM/ePGLwYWUlxp4WAe23iigSDv2PaMlCrYJLL82JctZd9ItbIN4Ijl
 eaUOGz0CKr/wx0IPlyOwmPW1SVZTYspvnokHJUrilOAcLSMjnwrqsYtWoDmCu7dWp5jHLoky5ok
 ZEj6pzfqHJDo4lkezynhi/YzL23Qf4wWlMds07Vxim4RAGh2U+9yxy2D5Nti9zbt3DItLmE8F9d
 bJxLWkZg0EOGQxeMvNIIUmTgrbGFK4zAdWcV65J60/JXKZgIEoygLnKJGNyek+odAP6GTy34k2M
 FtCr1MkAY73YpwHyY8zwsFZpSh1/WHkfOja+L+sjA==
X-Received: by 2002:a05:6000:1889:b0:451:4d47:c9d9 with SMTP id
 ffacd0b85a97d-45ef140f185mr5017759f8f.14.1780055248503; 
 Fri, 29 May 2026 04:47:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/21] hw/arm/zynq-devcfg: Prevent unintended unlock during
 initialization
Date: Fri, 29 May 2026 12:47:04 +0100
Message-ID: <20260529114723.42040-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: YannickV <Y.Vossen@beckhoff.com>

During the emulation startup, all registers are reset, which triggers the
`r_unlock_post_write` function with a value of 0. This led to an
unintended memory access disable, making the devcfg unusable.

During startup, the memory space no longer gets locked.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-id: 20260518073401.11279-3-corvin.koehne@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xlnx-zynq-devcfg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 9708200760..afe6ffd326 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -221,7 +221,9 @@ static void r_unlock_post_write(RegisterInfo *reg, uint64_t val)
 {
     XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(reg->opaque);
     const char *device_prefix = object_get_typename(OBJECT(s));
-
+    if (device_is_in_reset(DEVICE(s))) {
+        return;
+    }
     if (val == R_UNLOCK_MAGIC) {
         DB_PRINT("successful unlock\n");
         s->regs[R_CTRL] |= R_CTRL_PCAP_PR_MASK;
-- 
2.43.0


