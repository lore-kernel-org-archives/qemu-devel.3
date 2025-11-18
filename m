Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE75CEE34B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQyc-0002kL-69; Tue, 18 Nov 2025 14:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQyS-0002V7-48
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:02:45 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQyQ-00068k-H2
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:02:43 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso1218975e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492560; x=1764097360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YIawoGnZ3yGM9VFzmHJj1+WDGKpqR5JZoplCF0M4Vjs=;
 b=zVLUNJogoheJGK/6SqmfbfcdQCumwdhx6g/b4xMQQaoD+PptSSxUv8ulJp84f0fMtw
 BC0H5tgCJj8aKqiNkq/wtVV3wsrCHrSnrw0EUwShCmTAJm/7yR+9kEt2IPFCr1sRxKug
 8bX/XGZwq8V2uX0/ydlLlqsMFIyz1z7wAnGy0Rp1N6qSNU+rNseSlizCRm8AXEjTfb27
 dqztVcBubUA8RNfgddoyOlAxFPwIMmYHz6U23R2isYJjtIORba+upo/rYd12f9i0aqvY
 wW3r0lnrTXTLpT19AhwO8+/awZnFo6BoRCaozQa8UPOC4ZElyHbNkISQCW1ielztH8cJ
 AdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492560; x=1764097360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YIawoGnZ3yGM9VFzmHJj1+WDGKpqR5JZoplCF0M4Vjs=;
 b=GJ4DMsPPNUiKB8DmOc2OIoC7mcolME9V+LyfMhJ1asqIKA7tNvvDOkL+iiBTh0Be9K
 FvaiAtB/NNWaMavCRykUARuBi/iTvhGFwrsLfPMECHVZ3BvcmYQ1IG5B6535iYDpuXQ1
 EXBCPKws8cc9clKvmrqjpVzC0sScsUoRXFP74CF+UhmjGILuqvUtdKX3v4YeKQdZI3Je
 GksJA7p5RNyUHOVgOzgLzdFouszi/57MbZB+vOsDPAXRDHekTRDsxojWQcdlGBZX23yc
 CJPkssQDcJ6aaVVMyFdbHMF3LvdHzdUPKNvJPFiDLgJLXiHgZA/+Hzp01aHYDB1+xeBP
 PQgw==
X-Gm-Message-State: AOJu0Yy0/CvNtvrwE0kH0i+G0yqQeMve47IGg2DdM/FZLOhuM+PP0FcR
 o0ZKyfLmR1i6DIOR8t1hrzy4GrQ9xXWDxI4VpBsVLllgeMCja/uuOYip37/vhe/bJQfTIO2Jcx+
 CWzjbzCc0ww==
X-Gm-Gg: ASbGnctYp7yH1wMY//ma5K58o1c15cHy0bVdtUFE8rqUUIAJax0S40HmMJJPR/8O+aW
 laUCSrMLufp5BgO5cP789bsxkSKvhO9nrL7VQarQoLNt5ADgQGSbvaeR6Gljw0mRhqTzYWbkpmq
 ewJUHAamTspOEjktZzFTMtwg9CjsZg7HGd4JoUMudG1FN9culN23R4RxNdqiz9s1+wJOZlZ3rvj
 CXaao3Vy4ZbWkFMqrQn7NtWZkbccVdGRFsLDgYblf4Z0rdoEsiIt+1ZVjEBH+HC8iMC7/pK7eyT
 Iop3XI6BOzo+i631kubUOXyE2fQvIEqsyTRnwNm3E2i/vw6m9Lli9dnhf2+YwC07Yno3KLy6/ZD
 X0xNLhzuycGzK5J6TFY5zcnOvqTWBtntv0TH3owz+7it5r3uj9+zEC+HuFAsNVnq0w1T11bbvZq
 B8dSkesZxV5/xCD8fkWGQPkSIzI0krTBbFwZrQ1Y5/9eAOc336kzNvYwM9gDCuCgNHk/9le3c=
X-Google-Smtp-Source: AGHT+IEO3fBH4p9plNxTUbrpE3OkU2/Dy8bpuJqhldmc/e0dNydoPJO5JfBGCl3QqVpsScHwurEO2g==
X-Received: by 2002:a05:600c:2e0c:b0:477:a53c:8ca1 with SMTP id
 5b1f17b1804b1-477b0cd1130mr3593295e9.14.1763492560485; 
 Tue, 18 Nov 2025 11:02:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b0faf295sm6170185e9.0.2025.11.18.11.02.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:02:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/18] docs: Mention 32-bit PPC host as removed
Date: Tue, 18 Nov 2025 20:00:49 +0100
Message-ID: <20251118190053.39015-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
References: <20251118190053.39015-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

We removed support for 32-bit PPC hosts in commit 5c1ec5a1ee0
("tcg/ppc: Remove support for 32-bit hosts").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251117171236.80472-3-philmd@linaro.org>
---
 docs/about/removed-features.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index a72df26dd24..422b9c98d35 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -902,6 +902,11 @@ From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
 Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
 maintain our cross-compilation CI tests of the architecture.
 
+32-bit PPC (since 10.2)
+'''''''''''''''''''''''
+
+The QEMU project no longer supports 32-bit host builds.
+
 Guest Emulator ISAs
 -------------------
 
-- 
2.51.0


