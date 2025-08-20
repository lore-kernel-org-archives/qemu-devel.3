Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82286CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 20:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uopdQ-0003Fh-Tw; Wed, 20 Aug 2025 16:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uopdL-0003Cv-6r
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 16:42:11 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uopdI-0000CF-Sg
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 16:42:10 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-afcb7a8dd3dso46875766b.3
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755722527; x=1756327327; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eLh9wwCo7gDE5L1QyDe5pZgnNu4fYB65zqPEPfpbezU=;
 b=E3AWogF6hIVIZIV/xd8LrwCizjyL3iSaScZ7/sIsvRuUUaLa7PW3AwastjYeO2r9dg
 rbc+Lluioqaqrnp73NNtlWuv9UvR/gCuB4eHBSWYu17pSpquFa5eoDuYg6C2gsciAJjD
 mmA3spISe9gW9hnoKtix+ALlE4VOUiJTAHUOlwfpMnpy7LIl0H8hnRFlYDmUKNm+w4cL
 hspVzaH6wI2MAAWggkQ29g+RRhj3fonMUB+HoXJBDFUwWdYgTPWciA8qFu2o3HMYgBz8
 cflAuam18RUi0TfgeHB2quWSB8S5xxtiMEFz1kbpIW6ncfVdU7TqL5+F3jV8xucvBeGD
 Cy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755722527; x=1756327327;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eLh9wwCo7gDE5L1QyDe5pZgnNu4fYB65zqPEPfpbezU=;
 b=p7URmw37IpwlQ0yFwDYTFhXbZtnxlvC+ehrHI/uxrLDfL9vuLf9rSq9B5fVM+xXFO/
 3hnhUkNzZe7CYi444toq8s9QDva7RDWSPd52d3YT7xC6krEcTU8jhhQlsrkmdVhqO5ie
 LEww1tBaHEx0zUWcQOuMKoy95U5fjE8NVkmqx0jcUQwPBjOFXQnhl56WWz5jXA1hQCsw
 xiG38+TZOg8mfq/ReAUVwy4qOHJFqRT8oDkmgiB5vsPgbzJ96dZdP2sBWq5FuIPGCUQJ
 ZvWm58ucIChjm59QpiAi4U4xKi61eHsxmeWFCj1Oz2PiJ54gzf/DP8ZgcPYLxOMb0dQ1
 pkdA==
X-Gm-Message-State: AOJu0YxA73+sOsXhFjZZqHoidKeoges7zUTYKgFAkX0fM1Fa1eYIBXVa
 dcPyM3CVKoSn7q6SSDBTGxPe7SeuEb4j23R0RSlaZXIsi+3WSKny628409Ddr97D+/cYxkz/vl2
 ++sVjWQE=
X-Gm-Gg: ASbGncsrvZJ81D4mKAVLCKMl0IlUU+64kTn2IgjhxDmtfgtzzriHJEmHQ3dYqPWilWi
 vR+rn1LOnP81ipWPbfIWF6dq734NU8MANl9JPNaqhHo7650mEWuiAfYMfIU91UAS5GdkvZ5iXt1
 hFLalNu3EM5xzJVDsHicqvoac75LbM6Ym0RmfpB8kYjhvQuHIEV9ww2SfkldLagUq7HPuWhpEt2
 3trQokxRHAMfsPijQlGq70XCO4nuwAKlGX35VmTjzkLvfC0EUad6dE/LyCUuzuf7qPSKfevBgqb
 fdnZYrECQCL3Sru1qVqBPvHUQqgG0iVVg/xMwlCShBvh/GXrmQZcjoCNsU0k05pGErw/CXV0+qE
 cQd+yOoIBR3UaMZ4k3MFcSKtEbKIqpu6jwvTVaeL2PZ7ijzHP9TumLd1OEEGFNWRP+v9I
X-Google-Smtp-Source: AGHT+IHF4H0bF0ByEBMx6Zu3A9wjRJdqEYuMct6GSxIxgeSyq/ZIWVsITiR4Q3soYSJb9ZtirH18Gg==
X-Received: by 2002:a17:907:6096:b0:af9:5a60:3319 with SMTP id
 a640c23a62f3a-afe07b0667amr16120166b.19.1755722527263; 
 Wed, 20 Aug 2025 13:42:07 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4441256.home.otenet.gr. [79.129.180.152])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afded5353cdsm246888166b.106.2025.08.20.13.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 13:42:06 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 20 Aug 2025 23:41:57 +0300
Subject: [PATCH 2/2] scripts/minikconf.py: s/Error/KconfigParserError
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-scripts-minikconf-fixes-v1-2-252041a9125e@linaro.org>
References: <20250820-scripts-minikconf-fixes-v1-0-252041a9125e@linaro.org>
In-Reply-To: <20250820-scripts-minikconf-fixes-v1-0-252041a9125e@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=966;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=yphRVw1Go9B4J30Undf6o7YQ+oa9+w4fsSjGrOvBOnY=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9wak1iY3NWY3Bmb3FtM2JML0RSOGd5L1dyckorCnJadDQ2a21Ib2REemxZWTRx
 Z1NKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUtZekd3QUt
 DUkIzS2Nkd2YzNEowR1VxRC80c2pmdzNVUWQ0Qm9kdExiMWtPMG9aZy9oNS9TREY1TDVaTFNMZg
 prYXRBNCtsdHpSOU1aOGlZaU1NY2xtWlBrUjgvUDRnaGpXRDNGaklYKzJoQ3Jka3RSZ0c1QWdub
 TY5YWpJbGZ1CkNGTVh3eEkvMHBna3BnRC9QeFZoa1UrTzJRdkNNUjAvWnlHbUd1cGUrZmZHTnM2
 a0xOdVhhYWU4a0Vscm5tOVAKN2p2WU5pcEVQelFFcnl6ZVBnVTJ4VHArYWhHTlpRYmRZUVFVM3R
 YdXhILzZtcHhQN1hTeWpCZm0xdzl0SzNCVwovSnVyTys2OGxyN3NCaU5uamt6ZFJKQVN1VlZnMm
 5WVElHZEwzNS9BdThPUkdNczNYTUIyWStYdlVkY05qNEhhCk5RcXA2ZEZJbFIwZ1VmSUhtQWt5Y
 VZ2YnFYa0QxZTAybVpMblBaZHloV3QrcysxZm52bHdDakVBWkhNZDdUcGwKamRZTnhzTTVGTmFM
 ZDZlWDQzVGl0MFhzTzdLQXNyaEh2aTdsU21aTXUyS01ZY1BDQytETU9qaTdST3VzVmpHZAoyM01
 BWjFLaGpaUWYxMm5aWUowNTZ5VTVCWHk1R3hqR3gyVUVJTkErak51NUdkcXR5cUlGWWRLcE1nRG
 hvWExBClpxZnFhZTkxRVA4VjVYVnQrYmxzOUlyVDR2S05yNkVHeWRYaURZK1hqbFdQNmlqVStSM
 0dCNWRKM0Uxb05WVXQKTVJNYXFXZFM5c0NOc3ZZS0x0ZElwMWtZeEoveXAyWnRhYjFhVm9HOHJk
 VTZyTDNZekhtQ0tVVGZLOExiNnRhRApNV05nRzNQR1JDZzFDWUlMM0k4NTd3Z3VMaVJna3JLaU5
 TYmJKSEZmZjZsM3FUcktCdG1lSWM1dWtKMDlpMjNpCmJtR0Z6dz09Cj11SEZTCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
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

Error is not defined in this script, raise KconfigParserError instead.

Fixes: 82f5181777ebe04b550fd94a1d04c49dd3f012dc ("kconfig: introduce kconfig files")
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 scripts/minikconf.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 2a4694fb6a3891e152342d29b37661fe964cea37..4de5aeed11a226d4df094b9b3a44837f2f4fe003 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -363,7 +363,9 @@ def parse_file(self, fp):
 
     def do_assignment(self, var, val):
         if not var.startswith("CONFIG_"):
-            raise Error('assigned variable should start with CONFIG_')
+            raise KconfigParserError(
+                self, "assigned variable should start with CONFIG_"
+            )
         var = self.data.do_var(var[7:])
         self.data.do_assignment(var, val)
 

-- 
2.47.2


