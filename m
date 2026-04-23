Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FBDF9936A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqua-0007VN-PG; Thu, 23 Apr 2026 06:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqty-0006VF-Tf
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:24 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtv-0002IZ-9G
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:16 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4411e1eba51so3072279f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938594; x=1777543394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bchUhgwLeQIINEy1KyvzDnGKmRD5dxdy42UfwhsWORo=;
 b=O/UL/WqtgquxTJPtmVlODCMoEGRv1ntgtFfRUOi/cmgaf98IVoj6PNqe5wWpNjz+mh
 nxJx4lfcl5Xl4sKKzug1QqPwoYF9ZNunC6mG6E5jjQ5VyJ9h1gb16w87dX2V1IRZxp+K
 opaH9AYnF3uQTvIBwtghJDRo6f/S1zwsJ2he2K1UlXTDv90+0XplilVTKZ24u0qsSnny
 plwMupsTStsHDy7XGCDwbx0+0OpqIIUk0f7K+BUN6jQwetvs18A6HYNjbDlVmu286Y4J
 JxLYGUhqavjA1H7BZfEWy6/9QX8p3+9EqAu/TjuypGo1D6yHxlMB0I0GABy7lP29u/Qx
 yECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938594; x=1777543394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bchUhgwLeQIINEy1KyvzDnGKmRD5dxdy42UfwhsWORo=;
 b=ELPMuU1RzbENpjDDCcB18NB7m66NuYUw0j8JTpQzqasgejXSgLFeYN2+ZpQC4qT//q
 q2hcM8IjpWWmHyb5OeP0TrJoYY3W8SutaQJGLKh7TxuiOZsLdHlAQxXFn4BDJpUYFxOi
 YQu89O89ZDmhSu7JouPJ3MHl3xuwqvFX3M7QmwbcrDNhH+LF+185VYEADEwZP8ilWrBk
 U6q4NGbZCiHlpRvW91fR4d5GjWfkJCgTaZ299k9fIHnQ0FfGxR8A3+EKPp+uLeyL8i6N
 hrGQFr0u6jNuolRE8FpwemW0XZ9Gz1kGN1DV+X8gT07D16jRiQxEggOx3fFEL/g8E7CJ
 /VdQ==
X-Gm-Message-State: AOJu0YzQhxBLTOK3d/oS/XgcwRi4HdcSvDI5i+cltfxqAkRP/4SuQNkb
 UgZ88PakTRxsrHGroLPrxvHgfCFHnxIEaJiYEE9U/LhoH//WTxmxWcSQBYXXvR/sbMz1sfKfYs6
 OELpg
X-Gm-Gg: AeBDiesYAVn91ZbzOdn0whJYIDb4r6OhcisHsW/F01PuwKwc4LTdqqahi+RovGUWWfN
 w1/QEoGjaPU+gBmHUmroM/DzkkXh+bJ4FJ05ZpeM0j5QmGU9PLMWJ13ASmu/trBb+WPMnnYVdLo
 HqaRpEgJY41ZWisatGjehYyTd0vta2LZNSEvaiO0Dtlo4orhdWeZjXRdTgHk32LVuCEr2zkc9Wl
 RY5xenhsxJMRDPp66uuwUzNoiEL9WEP5MaiBAJM5H0ZL8hxAjxVhb8ZqLevnrV0QW2nBDjtOYVC
 tfd/oT1hOSYzbuNhW/Ej+Rz58/OcvcUut4wDzWIOjjiigUcQWZja5j2+1Mu4ANMPfh9ehcezLDb
 WRiWI0Z+4r+Az57EEIhkTVvpcYEWlUTRN8ud8CMjLVG5Ci0VRIuL+3QEdTNGtmCNaXdEpXbsFqr
 XCK6dxdiOXbma4dtd6K9Dmby2RI6TKEnoPPj333BrO88Ro7YkhyhU/CSvFdFfgnavHRCXJ5OwJc
 vlIQFtJZFANZux8TGpLo+TWOn3TsXswSkyELlt8Ag==
X-Received: by 2002:a05:6000:1acf:b0:43d:7946:bae6 with SMTP id
 ffacd0b85a97d-43fe3e236c2mr39772425f8f.43.1776938593877; 
 Thu, 23 Apr 2026 03:03:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/59] MAINTAINERS: Remove Ed Maste
Date: Thu, 23 Apr 2026 11:02:09 +0100
Message-ID: <20260423100229.2941820-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
Message-id: 20260416091654.316158-8-peter.maydell@linaro.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 855b6dee70..34944c3948 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4495,7 +4495,6 @@ W: https://gitlab.com/qemu-project/qemu/pipelines
 W: https://travis-ci.org/qemu/qemu
 
 FreeBSD Hosted Continuous Integration
-M: Ed Maste <emaste@freebsd.org>
 M: Li-Wen Hsu <lwhsu@freebsd.org>
 S: Maintained
 F: .gitlab-ci.d/cirrus/freebsd*
-- 
2.43.0


