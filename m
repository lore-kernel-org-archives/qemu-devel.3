Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA97AFA1FEF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdn0-0007af-NA; Wed, 22 Apr 2026 16:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdmy-0007SJ-Aw
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:03:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdmw-0003ls-HE
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:03:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso38747705e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888188; x=1777492988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RqGuZm40gpRuNcITr7yRuBCMokzBxoXaMXGlnzCKi4E=;
 b=BE7Z5+qVlEKBpBvnWuRZkU8ek5+obhDDqXaXfEhu+nGn8S/nU7+DmhpgO9ytQ9dM8F
 yAKemdwoLxmN6LohFiuSroJKSzcF3p1m4mzVv89vU1oMOx3ahOpE5nUoRRQ/tJC5jABc
 XY55OgeDfUY+AI+2weux5oLJQNHHSngV3gkYWZbsiD/UV51gKHxfxEmNnPOwgZ/i/Euc
 Md2P+vWxIpgjLm0aIM3q3qR1pKudoSvKMDN9qKieHaUeC8wOpwY6P8jHMrvEj6LafDSn
 5yBHKoibQqkYTNNQyZ94tOSBmylehaDSEjPo/FRvWn4wLmOIArsEu1dX3YLsURk5EzhU
 Cx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888188; x=1777492988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RqGuZm40gpRuNcITr7yRuBCMokzBxoXaMXGlnzCKi4E=;
 b=CgvWmqWLy+gDkIcSO5dYaBEx+QvxdihUM555+qWxHwViNmoW2vz1/udZNCH1xuFG1i
 SbUPRbQbU/rCVvxCv1XHwYBKwI1UrCD1xBjq1nv07gPsWXvWOzCM2GdNlN7XLFCgXEzL
 Rekbny+hNJp1NwEU2RkZeg3HKdFXD665f6ZAhDrNre2PzF7U86mL1GRSuEsWTHCXguFF
 Jm1vFYQI/QbHo2DNC1oOuqK9d4aFwh9Z8ABoo8E6SwEaYCjguyD4s3Dr4IUy1/3JNzt8
 DwyoAU355GEiCpVA50Fnn+3vW9fZD/esnCE23KlbDS2WL1eU3i+Un/f9wSUi0VQTpW1G
 FyxA==
X-Gm-Message-State: AOJu0YwZzVLdrHvRKfTVZiLc1GO6v7dPxoxPkZkcpP8E+M3FMqH3EvE5
 75quO9ftzK4cVOuDMSTusbsgo5W9fN5Q3g5aYiexBmLCobCpzuAPjmDMKrKVJcRRoLve1U9Za9k
 bW9lUlZE=
X-Gm-Gg: AeBDievMrRThG4tVxCC8OxwCNqfvR7xWaHPyeE1qp4WOB9gFz3FZ5ACdgv8vC974B0w
 9bfS9m0IS+nM5hULgo/Up3v0y7TZkWEghYj3SfK3X8rTnPrtOvakRXh+8eGX8SMZ8IxPvmnGYEv
 cIhTUyAGyFc8u0rAyRXAJzYVBtNmch3l4cEw7LqvH9ouXpplswCsTJalaHMSFbv4doPNTr5HlnV
 P4OJUTlUmSICz/NOXdlJ9sQzPTSU6sKAHoez1rC6UZj8a1mIYju2821uJ/LdGY+69BQBCo51SyJ
 gd7WBPKj95Cyh4lXLZWtIhI1SLVFMONrEROkQhLrqeUp2JDLD7bh+LH/DRQwzPTDTTAoYVQg50L
 XjFloWcmmViYBZTH1FFH9arfbxWyz1N2sp/k0dhbeR8gwqt5U+0ml5FAfSUCLp2hMmENXi2/jVW
 B1vnVQ0EwbFmFvdKwMbzKi6/4LXoiRSbNLmFKfzkhpv6wPF/TnC4xm4R8wJAybPbhJX+oelvpoz
 nCTSwErWVI=
X-Received: by 2002:a05:600c:5254:b0:488:8bdd:cfcc with SMTP id
 5b1f17b1804b1-488fb6e62a8mr365491235e9.0.1776888188504; 
 Wed, 22 Apr 2026 13:03:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c01cfsm487776975e9.10.2026.04.22.13.03.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:03:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/48] MAINTAINERS: Remove my unused git tree locations
Date: Wed, 22 Apr 2026 21:57:43 +0200
Message-ID: <20260422195746.88865-46-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

I haven't used these for years. And as explained in [*]
QEMU development workflow doesn't leverage subsystem's
git trees. Remove them.

[*] https://lore.kernel.org/qemu-devel/CAFEAcA9xCN6XMUFmZ_QAn617W14FAzi4D_H1mgSER10otTtQMQ@mail.gmail.com/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260422080406.62638-2-philmd@linaro.org>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 54e15c04e59..ed8aeab421b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2270,7 +2270,6 @@ T: git https://github.com/jasowang/qemu.git net
 
 Parallel NOR Flash devices
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
-T: git https://gitlab.com/philmd/qemu.git pflash-next
 S: Maintained
 F: hw/block/pflash_cfi*.c
 F: include/hw/block/flash.h
@@ -2870,7 +2869,6 @@ F: include/hw/nvram/fw_cfg.h
 F: include/standard-headers/linux/qemu_fw_cfg.h
 F: tests/qtest/libqos/fw_cfg.c
 F: tests/qtest/fw_cfg-test.c
-T: git https://github.com/philmd/qemu.git fw_cfg-next
 
 XIVE
 R: Gautam Menghani <gautam@linux.ibm.com>
-- 
2.53.0


