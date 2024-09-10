Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A75CEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snzx6-0007Ui-QD; Tue, 10 Sep 2024 08:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzx4-0007RG-ON
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:26:34 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzx2-0003eg-Ja
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:26:34 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5365aec6fc1so4838377e87.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 05:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725971190; x=1726575990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DwmV2MeWXY+eAh46YLB4XlIS9tILH+3xHMSDQuLSaLg=;
 b=abqN4lI8r2rigxVheCEZIS4a7Kjt4UReF50AXMxXgJIAhSTAb5tZTFJT3d9PVfAemH
 4+SndUicypvIu6x4iazla7kmhYaLq4GpERi1sVcwPSKF9gX0tG31LaaoVLCrXWLDn4+2
 67ZegP3MK6ROWDnvgEVcn3mky8Sb1/cR7LUVbNyiVAt4kJjsEas7qntzBT0dq8ADi7us
 dKuAIv7SJgchX/+Sq+eeWXh/2jwd0lDYfqMWOPPeBzk183IFPsXnfiOL4fqWQIQyVVvG
 bgJPTevPWrykLrrY1uXsk+i9zF/jVkgpngUlQEgwkR5W5Cj8NyrBRbT9k9pmC1LzNz0G
 ot8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725971190; x=1726575990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DwmV2MeWXY+eAh46YLB4XlIS9tILH+3xHMSDQuLSaLg=;
 b=TxwJ3v7+/B+GcKPCrbE+7f+S/i/qycliSH+fw5MESKnSLQf14uqbpAmEXzyNfY60to
 PsIKty5le5vG911Q4ABo9wB/Xofa/rSmDMtGMFb2kM2zP7c0iH3VZkeqIXJaR9j5pktC
 bZQ3WeE8LNtyGgUgaG5VLB6SrlrD9WBt069tpXSYvbrlntQuEab3c5co5xEqoj8akA+Z
 2b2FhRgMZXvGrBYPZeN+OHu4ocOn9lQWbClU1yX+Vva8EuxyuQNg+/d5UUPiRC2Mnewe
 +Ihe4HzDEPuayugcK794UIbNPebu+TJWp5XPWgbajxB5YQlJW5e9Vwkcg35qVVHAgJj+
 F31g==
X-Gm-Message-State: AOJu0Yycg1hFvgS5qFJIHnVuSESfEZMQdXz/EN5Kd6w6qh9023hAnZep
 ta7XNrgJsccmVKEIi/jDW7/tnJSCXGKWl/CO/RHUs9jYebALLg1kwPXOpcyJXcYipJmtob+Rb8d
 l
X-Google-Smtp-Source: AGHT+IF89AkzhBhynHvCYSIF7yZDpCgJkbbFgO5WP8Zvsk+sbPJI8gNBLuuSHLAOGX94mh5kJZFNXQ==
X-Received: by 2002:a05:6512:104b:b0:536:5625:511a with SMTP id
 2adb3069b0e04-536587f82d0mr8388155e87.47.1725971190425; 
 Tue, 10 Sep 2024 05:26:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c82eaesm478295966b.118.2024.09.10.05.26.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Sep 2024 05:26:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/5] NSIS: Simplify license description
Date: Tue, 10 Sep 2024 14:26:14 +0200
Message-ID: <20240910122618.33056-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910122618.33056-1-philmd@linaro.org>
References: <20240910122618.33056-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

Since the "2 | 3+" expression can be simplified as "2+",
it is pointless to mention the GPLv3 license.

Add the corresponding SPDX identifier to remove all doubt.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 qemu.nsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qemu.nsi b/qemu.nsi
index 564d617d11..b186f223e1 100644
--- a/qemu.nsi
+++ b/qemu.nsi
@@ -7,7 +7,7 @@
 ; This program is free software: you can redistribute it and/or modify
 ; it under the terms of the GNU General Public License as published by
 ; the Free Software Foundation, either version 2 of the License, or
-; (at your option) version 3 or any later version.
+; (at your option) any later version.
 ;
 ; This program is distributed in the hope that it will be useful,
 ; but WITHOUT ANY WARRANTY; without even the implied warranty of
@@ -16,6 +16,8 @@
 ;
 ; You should have received a copy of the GNU General Public License
 ; along with this program.  If not, see <http://www.gnu.org/licenses/>.
+;
+; SPDX-License-Identifier: GPL-2.0-or-later
 
 ; NSIS_WIN32_MAKENSIS
 
-- 
2.45.2


