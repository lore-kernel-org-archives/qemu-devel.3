Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5031EC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr1r8-0005VD-5Z; Sat, 08 Mar 2025 16:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1qn-0005L0-44
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:36:55 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1qk-0003re-CG
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:36:52 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43bcb1a9890so25212345e9.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741469808; x=1742074608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDbWzQ3TRhfqcCdGrWE6Ka+gW+QxOu8dbIYkiLZFWgQ=;
 b=UC18KpIMYVewhQMRLfuFu9ytC+o5y2jG91K7piSEqDd08VVSLkqv2xTt0AmXhAtudp
 JDm6nyFYyXHW75GnxsI/1YrOMO+T/Lgc+M6HygKnYZPceffVf9yIxQV7nFsrWaWNik4y
 OY3FeIGUKT3Ync+K/RhVdda+hzqLrD8W+VMIfJ1AO05A9GrcU64+3Syra+6eUMhxT6wd
 iz6zO9eCsqUFQyHMf0uxxnUth++UuT1WQd+Lgox9VB6XcjlSL6FFFXby1tuwYf7SsZiW
 Jc6DJMOH9V/rLGeSEWlIbI9qroW8clC0IeG/adR8+XsPFoWb1/R7bYPVI1aQI5lzjDKn
 h4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741469808; x=1742074608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDbWzQ3TRhfqcCdGrWE6Ka+gW+QxOu8dbIYkiLZFWgQ=;
 b=O5pJ7U/EA2eKHrhD6rdkxTCMGlvfE09TFWn5qdhxK1H4MUGqjnqweA/zMmUfZ1AbcJ
 rpZ1QAtXxHsDJSa5YBmti5jx571RMoKDpJ15wq+x0B/ywMmygQfjyXbfbuAB7k+xqfxh
 udYzUf6NqQxALA5HzFLa22MLBRoSycKNQXBwjp20LDAaDk1mr+vWWLmaxwrXFjs7AOl4
 oCcl94L5ZZlgKudRMwTILfD+QQKET103G10nS2tmZOjuxRxMCS2SdPHZQkXi+bakCjiJ
 HQG2XOjvp2m6UlyNAlE5V6D+G+NCR6VMW3Nxgp2fasBPk1ADVz7uEDk9NY1r8J2eEsDr
 MwoQ==
X-Gm-Message-State: AOJu0Yyab92xyt1OpbyYKcAnv7+uWTEs3VfRQ96nuTbioO0i/FGlXWZ4
 8vNqkqgBJQW4hgcwXynUwj6S9NJ6SLvFczIA6584Ocb7U/0RqyCcpp7IyHOxlEJZWZNfasxU3SR
 Q4CY=
X-Gm-Gg: ASbGncu6Px5r95RNqPdLi7s9UfwPe/XPrelJdgaRovG9o0ZEEnpOx+05ZaEFO25FNCu
 XDnWIIGpbbARRkrEuA90YZQPEInijyI5W9WdH65Cs1gMdSW+GFST4tsE149FHhjj6G05XNNl1nZ
 1cvEMmEEYYJBXhoyIgGT1HlRJW0alUPYeJ7xeey+9Rh1NlxdPv69oq4tUBtgMSWJSGSFptSRTzm
 rBPgflDj2mTLvj7L7VRmH8knWN2o6eDHP6NbP6QlK8+N5uTPUNrsULKutmxbyeGXVXMxc395Snq
 t/qO6lAXHXzU/dbxTpG8tiRJkpyPwcVbCe6yQ5IXebCI5no56eOUaeroCqkYVhPV9gaDCgvnosS
 M2oF7Devyf2Ehi2Km5ts=
X-Google-Smtp-Source: AGHT+IGnHHKeLWtUVROrKEBh77/wkdwi5mUuQkbzLLLH8kGd6zryfIT/NzmfA19wV1zXQgjuSP/SrQ==
X-Received: by 2002:a05:600c:3b0d:b0:43b:c7f0:6173 with SMTP id
 5b1f17b1804b1-43ce4ac7369mr24625595e9.4.1741469808250; 
 Sat, 08 Mar 2025 13:36:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8c3aa8sm94423005e9.14.2025.03.08.13.36.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 13:36:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH v4 01/14] hw/qdev-properties-system: Include missing
 'qapi/qapi-types-common.h'
Date: Sat,  8 Mar 2025 22:36:27 +0100
Message-ID: <20250308213640.13138-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308213640.13138-1-philmd@linaro.org>
References: <20250308213640.13138-1-philmd@linaro.org>
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

DEFINE_PROP_ENDIAN_NODEFAULT() macro uses ENDIAN_MODE_UNSPECIFIED
which is defined in "qapi/qapi-types-common.h".

Fixes: 4ec96630f93 ("hw/qdev-properties-system: Introduce EndianMode QAPI enum")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/qdev-properties-system.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index b921392c525..49a3825eb46 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -1,6 +1,7 @@
 #ifndef HW_QDEV_PROPERTIES_SYSTEM_H
 #define HW_QDEV_PROPERTIES_SYSTEM_H
 
+#include "qapi/qapi-types-common.h"
 #include "hw/qdev-properties.h"
 
 bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,
-- 
2.47.1


