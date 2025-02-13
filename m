Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5268EC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaAc-0004VK-Nw; Thu, 13 Feb 2025 09:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tiaAb-0004Tx-9N
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:26:25 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tiaAZ-0006nt-Hs
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:26:25 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4395f66a639so6292095e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739456782; x=1740061582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZQiHA1qvCBztocbqsFOi1IRya4/wKDmhY8pdA7/x98=;
 b=iHdQUdgXxxLSPLU0CkMaOttxmD1GDx0FTFzPPHY60sweJLOvJDjVVHP5j3HD2q1QQm
 ob0oRa4l2V6IcRkyryK+NAB3S4WjOUN52lYkVvrRLb2ISnfEIKqysnDsM2zFUr/dzmfp
 spQpvxW7xEWa/uCgF5wH2G8kMmo6Uh5PShBk7rG9p4h0lOJyHWd3alZaa9Qhtg9Jt6g/
 p/F6Pl/8VDN2mz6V0wWBeITSVxy0TWzogWdQb+v8Ntb536LllNdMxPDMP96vh9WN7R74
 2sTrEpfC3f0RO77K5FOqZgvfkGCBuDHhYUUMzqOt1kZxeJZBzSmi3bwwpbr/BS0yek8J
 eV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739456782; x=1740061582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KZQiHA1qvCBztocbqsFOi1IRya4/wKDmhY8pdA7/x98=;
 b=JBFy47AV1+1kLnGb5EINDWAW2G3SD8F7e/Ftx+adC1s8IvNEedl1CUpXbk6vaDgSix
 eb62N0nIyClTZY1ItmQFo95tlcqcTxqGB4kRBJKYibc5jYt98kXlhKZOjXVk1mysVEHa
 zSGeoHSOkps6sFJ+ppm5pjVIdSEX8jHJtSnOEEksGjBs/wN4tCW/xpISuE2rKMzAo8d1
 eECzaoNllihsQ41EPhMpyWf+e67QJqpfo6c3AYKIjMAQSVRnK7SPux8aIAgtVDIByH3A
 b+P6sJXqSQR0syY6uXt3zhpKBPvX2iRGDHf55gp8HKfE+xwKLkr4SesXJDrUQG1UJOWA
 iNBw==
X-Gm-Message-State: AOJu0YyobC3etEZg0V5YtONvkT7YrcAuAi/ZZP4UIWUqoAWw/D3C1Jc0
 rbAoPjwcixZfJ6I3xANvuwYYrd6NELDdfej8AK0H14tv+fBEluw4em+Np90Iel45aeCQIxkOfT8
 Q
X-Gm-Gg: ASbGnctPVd6GhXbfZOoqoJwoRcxxL/3IVm3mLl9TdXkdqWq0spfoumLdksINMLy3m0G
 hqseoLs1PHKsIupZeS8dewfSgAKFFo7O/PPZfmUl+i8vn75shkNF/4pQKVdHkVKgoBCQAi/EWBc
 oP4YfOUf5w0E+SNS6iY83ShtUzDGY9BHomJWb1pIpecZi0Kc1cYNgNqjL58FM0XTrL/smFTe0su
 4UUkCE/Olhhw84zAkGzA3qmCS4gk7ya4w/uy5y1hJ3bDRszdkMDEHi+xipSouNrSs8scDPZzlU+
 ISuT5yMbm/y2cYCCdlrmvA==
X-Google-Smtp-Source: AGHT+IEiIHaKXMp1uRiwpCTU8HbJNkJPa7CNhcg2LxXG+pN5CaRDlygGdboo7tSSPBWi6oZzT0FFTw==
X-Received: by 2002:a05:600c:450c:b0:434:f3d8:62d0 with SMTP id
 5b1f17b1804b1-4395815f428mr76899535e9.3.1739456782015; 
 Thu, 13 Feb 2025 06:26:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4335sm2093604f8f.15.2025.02.13.06.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 06:26:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 4/4] tests/tcg/x86_64/fma: add test for exact-denormal output
Date: Thu, 13 Feb 2025 14:26:13 +0000
Message-ID: <20250213142613.151308-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213142613.151308-1-peter.maydell@linaro.org>
References: <20250213142613.151308-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Add some fma test cases that check for correct handling of FTZ and
for the flag that indicates that the input denormal was consumed.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/x86_64/fma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/tcg/x86_64/fma.c b/tests/tcg/x86_64/fma.c
index 46f863005ed..34219614c0a 100644
--- a/tests/tcg/x86_64/fma.c
+++ b/tests/tcg/x86_64/fma.c
@@ -82,6 +82,18 @@ static testdata tests[] = {
      */
     { 0x3fdfffffffffffff, 0x001fffffffffffff, 0x801fffffffffffff, true,
       0x8010000000000000, 0x20 }, /* Enabling FTZ shouldn't change flags */
+    /*
+     * normal * 0 + a denormal. With FTZ disabled this gives an exact
+     * result (equal to the input denormal) that has consumed the denormal.
+     */
+    { 0x3cc8000000000000, 0x0000000000000000, 0x8008000000000000, false,
+      0x8008000000000000, 0x2 }, /* Denormal */
+    /*
+     * With FTZ enabled, this consumes the denormal, returns zero (because
+     * flushed) and indicates also Underflow and Precision.
+     */
+    { 0x3cc8000000000000, 0x0000000000000000, 0x8008000000000000, true,
+      0x8000000000000000, 0x32 }, /* Precision, Underflow, Denormal */
 };
 
 int main(void)
-- 
2.43.0


