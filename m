Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74309C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 12:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcq5-000844-97; Tue, 02 Apr 2024 08:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcpE-0007Xd-Se
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 08:01:12 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcoI-0003K9-E4
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 08:01:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4161bd0a4ecso3441435e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 05:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712059209; x=1712664009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1kjiUTZUDmebHpHvoroBhRzu2KMQB0AVpaRH7FSxUQ=;
 b=lEFURz30hSXdAdrNmY/1x/8bUf7obHInKB2El28RCfv2NNe1tJJ6qht4PgLzD90gLS
 8KKNMPsEIhTIpq4bZDk5rq7Rp60V4DOeg7/XRTEFwmmvlewvWcE52as1fFjJ9mMkT8Lz
 wD2Qlvp36kfg7k6BwjTcH2+ihge+gHfTkV0X4X5jaBJK3Ov86PdlpgX3tnh8AbJMazh8
 lDQJFwIIBjJ5KOBeRXbgAs6i+/6Y3FHAd+lkUuIh2PH3TFnpARNivwqC/Py4T0T5nFaV
 eIP/WkZGN9MrXkSrBzvtufe4KsiTDPdJ5JICj6+nwXCeB90+aHageYmIMtaun3YDb200
 Yv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712059209; x=1712664009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1kjiUTZUDmebHpHvoroBhRzu2KMQB0AVpaRH7FSxUQ=;
 b=vmf1jCum6QOM6bXzMK8/zUWs8WpMdQPu800XQgvXhp0owisvwxV4Wdz10Ene48pAKr
 bQkKDWs0CAsdt04fTxCk9SWQnyCbQ82+UDqQ82e7I0y00tbDU9+c+J/Nh4p8mgai+c+o
 YQR/DEcz+3O+EjKS6zhh/zMfDOxBNKvbBS37HzD8lcaSoaBAVxc0d/+mgbMYi3BMts+c
 hMvw/sgAJBfoQ6pS7ZF2Mjytzn//2I7VWI7vR/hCT67e0254mz7JJ/9B6jnPIvGHUq2W
 PyMmJZ6Sd6LddZggBPiTuvYJbO5h4Ak/qF5J2fiLiq4PCAbHx/BxmzIr1g+ilX17/gAh
 0mXg==
X-Gm-Message-State: AOJu0Yx7ULWUmGVBVoHZnbMZ7tgaLS0uQjFyFN0x6S02tqdH8DSLSzVL
 hpJ2pOkXFC6HADATT6cSqabg48+BSOQDX3Bm1MOdWlKheXrWZF8WMZm4QVSNOBQhSBV7vQA7F1Z
 jU4g=
X-Google-Smtp-Source: AGHT+IGhs4CvOkK63Lj00QvbIWNPnDa6ZkMHU194Az5nSki+CIQBDwgMVTWPVov8iqczXa4xcQUa0g==
X-Received: by 2002:a05:6000:1449:b0:343:439a:5962 with SMTP id
 v9-20020a056000144900b00343439a5962mr6779612wrx.1.1712059209471; 
 Tue, 02 Apr 2024 05:00:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 ck5-20020a5d5e85000000b0034349225fbcsm6780280wrb.114.2024.04.02.05.00.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 05:00:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] scripts/checkpatch: Avoid author email mangled by
 qemu-*@nongnu.org
Date: Tue,  2 Apr 2024 13:59:57 +0200
Message-ID: <20240402115958.67615-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240402115958.67615-1-philmd@linaro.org>
References: <20240402115958.67615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit f5177798d8 ("scripts: report on author emails
that are mangled by the mailing list") added a check
for qemu-devel@ list, extend the regexp to cover more
such qemu-trivial@, qemu-block@ and qemu-ppc@.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7026895074..12e9028b10 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1573,7 +1573,7 @@ sub process {
 			$is_patch = 1;
 		}
 
-		if ($line =~ /^(Author|From): .* via .*<qemu-devel\@nongnu.org>/) {
+		if ($line =~ /^(Author|From): .* via .*<qemu-\w+\@nongnu\.org>/) {
 		    ERROR("Author email address is mangled by the mailing list\n" . $herecurr);
 		}
 
-- 
2.41.0


