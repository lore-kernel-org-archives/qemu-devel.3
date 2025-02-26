Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D676CC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI94-00069T-11; Wed, 26 Feb 2025 09:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI8e-0005RY-FY
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:12:01 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI8Z-0007a3-6B
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:11:50 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-390dc0a7605so369010f8f.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740579105; x=1741183905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sxlbdGkJ13G1o6ELtDmgQA5UFhIUKmW1fQAOczDQAMQ=;
 b=HirU0ZBvm0G77HNQpEciENliLb1CKniSccK46oBmA8gPer9TofQzyLm2eEGYtsNYvo
 5WcDzxMDDeHdJJZxlkYvtpq9L0RBHNaT9CDPHLg1RKe+Bf9qPMlzenlVQFmFdFyDmooO
 4POH+a3PuY+NDZhJlfl9IhRaSA08XiIwjL+ezJIdm7sBYBa7ri8yuuFPKJH7bvR2G1w5
 XXkBmD7CwrjW1r9gjaYdl82UHotAedsheBMU8DXOzrEItYKw08iyfIhVTKaexj2F27Ze
 r+0KX2DUmlTHdumb70GeWA6Tq8Eh92oO38BUWoJCuoXYALH3jsmRpzztEjljZO6JTmrB
 x1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740579105; x=1741183905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sxlbdGkJ13G1o6ELtDmgQA5UFhIUKmW1fQAOczDQAMQ=;
 b=VYcw3EZ5eglJhI3xUxX3l0iDBmX1ijYYxuV+k3rb6oBdj884BBlqTPdmX4gJieOkCj
 qRnx2fBd9rwqZsiLx7+sXjPwZsJX7Dr/LJ7YVAkCStjNH2OZC8WqBB/l/TCZ9JchDOy6
 egmAB97XnsEu7wDaD3MZhI43ZbZAxjVjqZMh12Wpu5JwzfpaTQNqlckjxVvBgH6XOiWV
 OGpnJ15K/N9qqaqLo1Y13feRYwkr+tQA8lx1tE22AF40H06qeX6aHpU+dHnQUi0MIi45
 BTyeLUVrAG4spU+6Ed8WtW5ZMSt6pESSb52fkPalOlRemTa4WI+aVRE/hW+bU5M3Vxrj
 vTIg==
X-Gm-Message-State: AOJu0YyC+B2UxJoob+9MFXwlNchMkz9ug0Hi8SPCQHR3xmQ2k2HiPfH/
 RaL059NjX4OEPoI4q0VxxawffPhL1hPw5kzIfwHcuPOMspnyT1eAj8lbRGkC4R4=
X-Gm-Gg: ASbGnct6kQ+2S43fqvSdAEI/p3WqmI72xrwTbh1LPGdeyTmWyrP265JCldm1xoojH9o
 EKL+D3dK17na1aZE8r/mYxasoXOveK7fsAAIGjdNq5sfPYzYL7vYIBdInszuPhkTbCqGMJKqNJn
 twqb1EXweap9P1hh1M9gixFet1K/TQsOBQzPGiHYogSppAUY/N9uu5agIjS374XA+7oAioPuR5Q
 vYaCHVoMJ9mIA5sk8pCVIyRUJduXyqpvU3QvIOy56xO6ED7KMW1hXf6UIWlbm8WMjYltUH70g2D
 bKfOILw5MA7GkbDSoAh57mzyAC6r
X-Google-Smtp-Source: AGHT+IFT0IUg4cpty4YVRdJ4aIpaQ9yNJr0bPVGBNJb7rqWbKpLHerqXFpq5IfNsMy0IiYJlPcRU9Q==
X-Received: by 2002:adf:e912:0:b0:38f:24f9:8bac with SMTP id
 ffacd0b85a97d-390cc60c1f9mr5815480f8f.23.1740579104605; 
 Wed, 26 Feb 2025 06:11:44 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390d6a32299sm2210236f8f.55.2025.02.26.06.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:11:42 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8DF925F924;
 Wed, 26 Feb 2025 14:03:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 17/25] include/qemu: plugin-memory.h doesn't need cpu-defs.h
Date: Wed, 26 Feb 2025 14:03:35 +0000
Message-Id: <20250226140343.3907080-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

hwaddr is a fixed size on all builds.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250225110844.3296991-4-alex.bennee@linaro.org>
---
 include/qemu/plugin-memory.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/qemu/plugin-memory.h b/include/qemu/plugin-memory.h
index 71c1123308..6065ec7aaf 100644
--- a/include/qemu/plugin-memory.h
+++ b/include/qemu/plugin-memory.h
@@ -9,7 +9,6 @@
 #ifndef PLUGIN_MEMORY_H
 #define PLUGIN_MEMORY_H
 
-#include "exec/cpu-defs.h"
 #include "exec/hwaddr.h"
 
 struct qemu_plugin_hwaddr {
-- 
2.39.5


