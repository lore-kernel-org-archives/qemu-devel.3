Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9BEF8A14B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrt-0006un-Ku; Thu, 16 Apr 2026 05:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqT-0005BK-BE
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqP-0007kW-Hy
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:08 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-483487335c2so85083285e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331023; x=1776935823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+5YJ2CDFZhqWZIyvMTCLEMbVOyzHyPvAztdrmAPNbAk=;
 b=Y8qFypLa8ZXXaWyU9x17De/aDMya36z50sUzZKLgP23iUMbIX7gONsxI84YMU1R+Wo
 4cXc1mbgbHBwwV3NGF9M+KqMIUIIdhDMRcE2/y/psen4CNI9bOsUSNq1EkOmDVwFvPz0
 9z015wjLyI6oBslq3Cn3aMILnqF3eDpU5iJPs3TT9qyfxoP9hQr4Mrs0wVz3F8L6uCT+
 Is7vcvZL/6uHavBO5szSBeHNvTd5UpqI6rliUDWgIt9At8oDhyD5TwNtiI62HNx43tlb
 4Uhq3LaC7cBYvrNmhjjuYYhwdYeB1zGP6kp1JS6R499DVnh80YEPlWyh/aprXEbtMQQz
 MLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331023; x=1776935823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+5YJ2CDFZhqWZIyvMTCLEMbVOyzHyPvAztdrmAPNbAk=;
 b=MCCcguwda38JxralIiTNqDTU+0+xlju5/j/Bmnj6hxC5ggaxQmdhAcZ/z9fGGtdO1s
 QdsJBBBP+VunURvlHQVMKgV/ey36U0Uh6o+qRNzU/a+5tdMnBC0EOdOcTwFiwwP4Ptkx
 fUdiirIoaN0hvZpyq8RgC0BP07Mci53hwXL/+N0hd2OTTxk8529eSsp06mcrsc6HBC2h
 bkABCdTdI6SteFhSZ20Rh0XEQhslM8Uf8d/oolAmTZy79my5nsjhuAc1jDFe8rUnIJ6b
 1iZ0JBWKdQV/T8k7FfnQxw8SKfVUTeHa9lfBxnbaHWkiI0uYW/oFe5bi6wkhMmntCPLS
 RUmg==
X-Gm-Message-State: AOJu0YxaBxan2CtbskECAs0eSJEaKmll958B0Zdc+20SErk3ifMO5E9b
 0f+pcoyNBuq5JlGfZBveIEbUdPt5AgjKMgvmeRTdDZtYb9lgp+b2S+xJPyYH4VI080/a/xI3PH+
 lBSyDkzY=
X-Gm-Gg: AeBDiesBaiXcKt3U/Svv1DNIQknDYTlsIS7sBfWdZoUR0jhWD1SLUzTTx5qmkCvP+ay
 zRUrV5c11FICvMK570dYp320dFUZvpPPJRGUml1bBn3mVY+vtz+gdtHbO4WDZ8Oj/B85mnzxyDc
 B0aEbpUoZ1dWXsAMEg6h0FMA65RNbkYMLt9YfHJGtZt7ukM50hMfgC5maZpkXtf3jl77P1R29m+
 4mEL0MEPVKrcjXYm3QwSfvkPwMXwE+wfPQSEER01NULn7/uvmLIgGSRneANHpv9ImI5yuMpUYze
 enXMyjuObb67s+LMupjzVKDce4D9wujFk5xH5QPajpRG1h4vsqTOxp0I5O+kUFcC87zbgFgV0U5
 rJ0SbNDa0bbPmFyP2w1rPZU/xaMj94glJ+xPRar5lwNfPxY0t9gp46bna4vfR4NOgTcKSk1Punz
 c8j3/lY5fBaq98qQJfg9Bqscucf3KIyy3bPkN4FQXIz/M2fgELV39/+m9L4zP+/Hkv1e7nfAtEG
 0G0ytPsMn4xcZ8cyL4VTs1K6UzrnGdpBNQ+TiVFOvoImEZDzKOK
X-Received: by 2002:a05:600c:8883:b0:488:b87b:3052 with SMTP id
 5b1f17b1804b1-488d689b400mr257634825e9.29.1776331022959; 
 Thu, 16 Apr 2026 02:17:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/28] MAINTAINERS: Remove Ed Maste
Date: Thu, 16 Apr 2026 10:16:33 +0100
Message-ID: <20260416091654.316158-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Ed Maste has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 885a11710a..90837d0316 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4494,7 +4494,6 @@ W: https://gitlab.com/qemu-project/qemu/pipelines
 W: https://travis-ci.org/qemu/qemu
 
 FreeBSD Hosted Continuous Integration
-M: Ed Maste <emaste@freebsd.org>
 M: Li-Wen Hsu <lwhsu@freebsd.org>
 S: Maintained
 F: .gitlab-ci.d/cirrus/freebsd*
-- 
2.43.0


