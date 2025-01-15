Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67740C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCqP-0006hU-Pc; Wed, 15 Jan 2025 18:30:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCqK-0006gS-Pz
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:37 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCq6-00053o-Qh
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:36 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso1439415e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983821; x=1737588621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YgJvGryqr3TkhFMqWrnYlBHew87iojgecT5lYXi9GM4=;
 b=djwMv1LIRlf7QNERrWm2SeoWBEWsigMGeox1R48QQVRzzLYydGNNM+9z1P7ZU/btFk
 VaJ9fYG5PUTyq0mU19aYX6qgSW/5d0OuYUcFloOsR9eKdnI/IOZOc43rMVW/bRRyAqwz
 u8gqlBN+KZoXfVWbxgo0LzPwWL20toa8jkiM1pjqFg1wKXvbi9BUB3SE/0XBYbB+QMU6
 9hUozVlQlNiY2B6kawYHOkSv2bhgYUFyctCeCb51Q57rQECt5pDJjmk4eJjlayyX6jTO
 Ns1z1Vi3M1e4CQQby9rdA7AYETpq+XIeZRaUa8ZLujrZGOUXizkiPssKZvRCuVUjJHoU
 OGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983821; x=1737588621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgJvGryqr3TkhFMqWrnYlBHew87iojgecT5lYXi9GM4=;
 b=tV1vALRMGiSmTshRT3As3YB3wBIjUxqh2IJTrGY6J1gCpfIIdvfygYskaDGZwSLHbR
 gj6jXbXC8vc1g3VDLQk1e66up+0wRUdmzXiZHwQns7A/q646th1Wv3739HOeZUdVDgmd
 Etw8LYniOQTyB4LsNfP90mDs8wZsLMuvalqtLnDH7s1CsmoxK+b0g/COVwLpucih3sqg
 Z4vWobjwRKcq2w3oVybYm6NQIoqIAZeNROoK3bOLOw4vvW6KM3bC1tFc1ws1vn77wzEX
 RihO8CWru9MGJpAZ1s/3MB4EUrCzLjK+UmoWq9YQ/DtB12luyG3XrCuDtS4OK3WCrPez
 Pa0g==
X-Gm-Message-State: AOJu0YxM7OkfmA22MRLotZwJjj/QQGEIqElbYsyJE6dZlK62MpYfjkvi
 4ynN0vnf5oAJZV2CtdhH5RMo2xRFbWf1LssNUrD3XGPbmw8MxNdvHYEYZWlgz/igu75Nd+eq6FB
 WZUI=
X-Gm-Gg: ASbGnculw7PQiykLcN4h4i4vWjRM/PYdudnWxAWORkVC3PZaqGPvMTmVeZltEES1Two
 ELlz2dhcLRR864QdJg3Yp3whThBbdp23lbwHmg9Z8AkRu1FWrilCC43t/achWQqIkHkxumZrzPJ
 hAW1TZzMCFAHi7MYpkOEv9nxeB1Y19nIcr80IoPkO8ueP7KFW1fZvXSggdaaqagfdw0GM7lcBbz
 W97I01uDVWa25eIFutPVWEdwwOXBTFzK+f6ytXgDCNRzbe29sO93jQQVPEgFWCy06/UPwHcbFAp
 UmyOkBjW6Tg3gVxVx0/eHeWTmJ9CoG4=
X-Google-Smtp-Source: AGHT+IFaL3Ly6JWCEejEEl8fQLFuRbcc+IgJeiSblgNLC+gpl6eZe9dfD6XQDLZ6jGMtfevNB7/tzQ==
X-Received: by 2002:a05:6000:1566:b0:385:f1f2:13f1 with SMTP id
 ffacd0b85a97d-38a87303e63mr4962500f8f.22.1736983820818; 
 Wed, 15 Jan 2025 15:30:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d0b1sm18999137f8f.12.2025.01.15.15.30.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:30:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 05/11] hw/mips/loongson3_bootp: Include missing headers
Date: Thu, 16 Jan 2025 00:29:45 +0100
Message-ID: <20250115232952.31166-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232952.31166-1-philmd@linaro.org>
References: <20250115232952.31166-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

MemMapEntry is declared in "exec/hwaddr.h", cpu_to_le32() in
"qemu/bswap.h". These headers are indirectly included via "cpu.h".
Include them explicitly in order to avoid when removing "cpu.h":

  In file included from ../../hw/mips/loongson3_bootp.c:27:
  hw/mips/loongson3_bootp.h:234:14: error: unknown type name 'MemMapEntry'
    234 | extern const MemMapEntry virt_memmap[];
        |              ^
  hw/mips/loongson3_bootp.c:33:18: error: call to undeclared function 'cpu_to_le32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     33 |     c->cputype = cpu_to_le32(Loongson_3A);
        |                  ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/mips/loongson3_bootp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/mips/loongson3_bootp.c b/hw/mips/loongson3_bootp.c
index b97b81903b7..712439c2575 100644
--- a/hw/mips/loongson3_bootp.c
+++ b/hw/mips/loongson3_bootp.c
@@ -21,6 +21,8 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
+#include "qemu/bswap.h"
+#include "exec/hwaddr.h"
 #include "cpu.h"
 #include "hw/boards.h"
 #include "hw/mips/loongson3_bootp.h"
-- 
2.47.1


