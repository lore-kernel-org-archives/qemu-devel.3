Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEC9CE8E6E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 12:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3x4b-0004Qt-Hv; Thu, 24 Oct 2024 08:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t3x4Z-0004HJ-4E
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:36:15 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t3x4W-0000KI-Rx
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:36:14 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a2209bd7fso102713966b.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 05:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1729773371; x=1730378171;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/SdhQ2IgYyQSnjIq2OIcLl2Zc0Mbl7oG8Hg7S7gy7r8=;
 b=lZDdxwnkK3UlWTEsZRlc6N1YIAq2Z4V9stSu00RoiQnfcImghLc444HuixAt3p2RR3
 8tv3cMlI+b/E1H0KS3b7Kkg5rMfwLPD8B7z64gASkxSP1k/D7BPMiYE1AW14jona6rFB
 W0r4DWdeTpk+z76DVuTvKDzAQbggzdCfC6lWiNTLsmFwzJgZcZYKM/N7owGIbzKJPLpi
 P7DVFVqYYUDk4lgtTa0/LtnQc00UuSooWNbsGPKT7RVMdsttEu3SD57xHuOvOIVsYKtd
 goVN+5YelaW/FTjAlUmDIfTS2ORECD8mARG+jm/pRDtZasXWknszzaGQyW1MuAdhwfHi
 9j8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729773371; x=1730378171;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/SdhQ2IgYyQSnjIq2OIcLl2Zc0Mbl7oG8Hg7S7gy7r8=;
 b=GXaH/6myhrkm4kF6GoyWCZWi7zUCUFoUp09c9bd5BPI4/EHC5Vp3iawZYERR8kZnwR
 2LDH5ZPKUqLX/LCLKH67kec5t3pPJ1u6uS6g0ChRv7lWX6QMcALUWeEjBUN9sGQCdsek
 V4uqV1yeKIFgEXyak2WDszjDI9TgczG9a8GvXOY8DNPu9ZHWKRogP9+cLwGbjsw3jYLa
 C9JowG0RRYGMzYslk7SgWVxZwNxJTUSEBXov4S9mJD6rZ83RwakhjPKK3/ao47W3frnP
 IHXLPVz6PXVOXnjg0TEfD6RMgOGJrO2aUkOZkKDzJRmlp9NtyA/SWDmptWC6DVTGvXXD
 qyIg==
X-Gm-Message-State: AOJu0YzirF8ngd0vgjHz5LyU3fyAn0RyLcd0q/rhJZRyPRNkUJs5bf5R
 xNGrd6Ip5kMZEnNcm8NTgebEzz03Z4NZFZQva8sOSnVLRrWmmyQZXs98L4rt+78O7gxlmFBzJgz
 0Og==
X-Google-Smtp-Source: AGHT+IENfC5wUh65o04QImvz5EN0791efO0q0lcvDE9mfpFXXpZuRqGvRJczo9BriSOUEopgFOiPSw==
X-Received: by 2002:a17:907:7f14:b0:a9a:cee1:3cf3 with SMTP id
 a640c23a62f3a-a9ad285ee91mr180886066b.53.1729773370653; 
 Thu, 24 Oct 2024 05:36:10 -0700 (PDT)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912ee592sm613369866b.79.2024.10.24.05.36.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Oct 2024 05:36:10 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, philmd@linaro.org, thuth@redhat.com,
 pierrick.bouvier@linaro.org, berrange@redhat.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH] scripts/checkpatch.pl: Ignore ObjC #import lines for operator
 spacing
Date: Thu, 24 Oct 2024 14:35:55 +0200
Message-Id: <20241024123555.25861-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::633;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x633.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

checkpatch.pl lints for spaces around operators including / (slash).
Code lines starting with #include are ignored, as slashes in those
represent path separators.

In Objective-C code, #import is often used in preference to #include,
as preprocessor-based multiple-#include defenses are considered
non-idiomatic in that language.

This change extends checkpatch.pl to treat #import lines in the same
way as #include, avoiding false positives for "missing" spaces
around path separators on those lines.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1b21249c91e..06d07e6c225 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2246,7 +2246,7 @@ sub process {
 			}
 		}
 # Check operator spacing.
-		if (!($line=~/\#\s*include/)) {
+		if (!($line=~/\#\s*(include|import)/)) {
 			my $ops = qr{
 				<<=|>>=|<=|>=|==|!=|
 				\+=|-=|\*=|\/=|%=|\^=|\|=|&=|
-- 
2.39.3 (Apple Git-145)


