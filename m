Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22624CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 14:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrf4x-0001NU-DF; Tue, 02 Apr 2024 10:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf4w-0001KO-HE
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:25:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf4t-0008HN-CX
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:25:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4156e5c1c7eso7198995e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712067927; x=1712672727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfL4IVrnZ8RPkVaq+CH9l8CB4XL0LMP837JbxMa4yMw=;
 b=tt5YIe7O5QhcEoB0HhnIUL3Zbj90ghdC3I278gCLtvlQMEUGovQBI+prKUBE7KVbrS
 uDe2SC3WWvvhLANdXP0qyVSfKssI2HXFi5YJa6xPFc4MgAOJDq1hR1+n+PU8GoCDrQAb
 13C7HqlJ1ydtjRlux+g1h7QyR2OWsQZVOlNeUEa3i74TMLwYmGkFDgSok9UxqAuWoTcl
 zylSZELVxNeNEHKdclGLGk7V12hWppc2mPGMcrCHDpvG6gQzFa83sGUsu/C/iU2081Tf
 pZwqB+3wEcCll+qSgCdLNn1RurR5bg+0cWC3Hpo6tDMZ4h4GNXrVbsZMkLo4NldscqCS
 REyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712067927; x=1712672727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xfL4IVrnZ8RPkVaq+CH9l8CB4XL0LMP837JbxMa4yMw=;
 b=FjrT/9l3VAGStWFd1fnYOREVidR7YWCPJ6vtPDeOahcuio8QbF/Ax4ZlP9ubD5XM1d
 h904Je4FEOkUH6Wg4s2FulzZmzkfM8CLBUp0rMGoIScvOG26c9F5aa3wCMeVBNPM/Seg
 OE1N0xf8SfDJpk2+tS8HwbFXui0uVzHTCy7oqvIPzsKhYR+5Uh2iNze0mYEmJssfFLRB
 pnHMVDRyexSaXU3VoSbfKvqZ2lbJ5dcsyoSsMgAxucOpbojjig0V6CDStmPgHU8uRTZf
 bEF0GOccfldjk2XY87kn6CAU3mik7K+AT6jMyKDkSZ6gIDyX7qG5JRNfg8BWlAWag/GT
 v1ow==
X-Gm-Message-State: AOJu0YxDD79WH31Ux1yANIY4Imco9hAYP1iGMwiJ2nrzwtCSLtfQYtBY
 1mpsKnDrKNb0FgUAriZ3aCMEJCyX9YGR9FJUw+CRQeeQReZI0xBveLz1yhNZKWsFHq0PVXXDOM7
 2uXY=
X-Google-Smtp-Source: AGHT+IGkFlLjYk2qN+++uoZbdByHhMiVj5ebWT6xzhb8ow571hGQV8IJrcnq7rZ6SZnY0q4i954BRw==
X-Received: by 2002:a05:600c:4592:b0:415:611c:aa05 with SMTP id
 r18-20020a05600c459200b00415611caa05mr5674235wmo.18.1712067927761; 
 Tue, 02 Apr 2024 07:25:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a05600c4e0300b004156da408b1sm3916554wmq.22.2024.04.02.07.25.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 07:25:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/15] MAINTAINERS: Fix error-report.c entry
Date: Tue,  2 Apr 2024 16:24:23 +0200
Message-ID: <20240402142431.70700-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240402142431.70700-1-philmd@linaro.org>
References: <20240402142431.70700-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Zhao Liu <zhao1.liu@intel.com>

The commit 15002f60f792 ("util: rename qemu-error.c to match its header
name") renamed util/qemu-error.c to util/error-report.c but missed to
change the corresponding entry.

To avoid get_maintainer.pl failing, update the error-report.c entry.

Fixes: 15002f60f7 ("util: rename qemu-error.c to match its header name")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240327115539.3860270-1-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a07af6b9d4..197a06b42f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3013,7 +3013,7 @@ F: include/qapi/error.h
 F: include/qemu/error-report.h
 F: qapi/error.json
 F: util/error.c
-F: util/qemu-error.c
+F: util/error-report.c
 F: scripts/coccinelle/err-bad-newline.cocci
 F: scripts/coccinelle/error-use-after-free.cocci
 F: scripts/coccinelle/error_propagate_null.cocci
-- 
2.41.0


