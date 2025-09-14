Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDF3CA0EE8
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Sep 2025 18:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxrtB-0001LT-AE; Sun, 14 Sep 2025 14:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uxrt7-0001L9-IQ
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 14:55:50 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uxrt0-0004AB-JJ
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 14:55:48 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-62ecd3c21d3so4512171a12.0
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 11:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757876136; x=1758480936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=irzZInxGwtwWlxZTOg1+YRX58wsJ94sMIdxHBgBYNKY=;
 b=C+Rn7RJzQXVRQNbW/pmId/IRcW71XJ5/Zkyp5pzwMxFp5nSMAyycdkaOtZlFJruiLk
 5ggjI21qkQCsKjc3sSi18v0u9xXpgpmfgt9PRq8GiHW6gZ2GukGLbOQgPb2vL9x8qJ3i
 UaS1wq1xVNbxM8kUaXua53dnxIPtroglV22AXscnbCpT4DUcfbD6s0YDCXK33wYPf5tV
 o7S+3/cyK9OAdfc9XPPYn3ZnujnpXuJQTe1v/Cn4VdHzuF2xi3scGDuVI7YR5E0JwaXO
 /tGEJlfZwNYCV0Xoj7tkBDnOn6+AlDudpsrLUhZXsd1vRhy4Sft/OCbKcKeol7+dmZ78
 Zn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757876136; x=1758480936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=irzZInxGwtwWlxZTOg1+YRX58wsJ94sMIdxHBgBYNKY=;
 b=frc15SQL3JC0WlrT+dsi5CYYSNGF/QN8FPklFlTQZKONoGcPZ2jm7TMQnn9FDEl4mc
 7nkLC7ZiD0ch3CKPvBryftz6bg/jXHsubrb2c6yDzbZo/8K+QKWDowFkzXOlOKOB8Ud0
 G7nNOKbZooiW3E64QmptZzYPmjhpgk7/d3iyr1Ydj7CQExzY4oFH+X39khQkEKotCQOb
 u/wcmuQabF6+XJoJXqMf4RqHAmJNtKvvIUJ6nFJv8SQRcx7qMnwHMRagPCoOwCqfiDmQ
 xasREnJpU79Nf3eQ8CzDYshyzIMdANBN+obsYO+xRm7qZ4yVk5SSXmJWDeCt+ASicKwk
 AInQ==
X-Gm-Message-State: AOJu0YxxaJIZV3goFZ8ZSAQDAUo6K29cQkfWrWFaIdvjXPpysq+fhN3G
 wIp3KH9W6O/g8Y20iBnw7fDELTI67ec0I7fP6dBfaS5IDD/0sOy/g9u1kcWyEA==
X-Gm-Gg: ASbGncvzyElrU9fPiu68JzPeQu7DiQxmQmiR7zL3HLEAjB8OOmY8zZd7XL30cGT+hjz
 L4ScHIgSCo9j4SM3wXdiESExfAgD2/xsIUlNjm+AeY3SqxXR13W9HzN1DBIbPvBpv5whJaOwXlQ
 hnBzhKX/YoXqiw9ZZXLrUBpJJEYwu49MdKNyT317/p3A0QxMJRFiX2jyyCpw38fsy5uOqhOLity
 gANm8ZjWatktGmVOTu9y28J72+WUbNw4MN5AJDaMij3DvVb9J5MdR6h+fmeJfsYvpfQX6KN0xMo
 zDp+ply+UWnmyPA8cY3YW5Tkxqn8nbYE51C5yzftzZzmqKBYQJH6aQSmeTPaNy5OAUr9c+QxCEr
 KmWMPYyP5AA7yf1Gix4K1RyuNV1sXRlswnAQgbKq3kOjzVMo3601ZTZpwBPZMklNohN16RYIjdI
 XW3oWWd3lbYb8jzqmxf14nUP+UWi1BPpFyas3Lu5t6TaBXna4+hf7Nyw==
X-Google-Smtp-Source: AGHT+IHjWrKP2h3UAYC7zEZIs3syztWZ2UmO+Kl5219hVC1TDUo4CbU+QtmQ3Bysk0+xFiK7D3Cgag==
X-Received: by 2002:a17:907:1b1d:b0:b04:2edd:280b with SMTP id
 a640c23a62f3a-b07c37e1907mr920106866b.39.1757876135430; 
 Sun, 14 Sep 2025 11:55:35 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2d8d-1600-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2d8d:1600:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07b30da58asm812963866b.5.2025.09.14.11.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Sep 2025 11:55:34 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] hw/mips/fuloong2e: Fix vt82c686b idsel
Date: Sun, 14 Sep 2025 20:55:26 +0200
Message-ID: <20250914185526.3622-1-shentey@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

PMON 2000 accesses the vt82c686b southbridge under device 17, not 5.
Fix the FULOONG2E_VIA_SLOT define to reflect this.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>

--

Makes PMON 2000 work in combination with
https://lore.kernel.org/qemu-devel/20250508-bonito-v1-0-4f9f27733028@flygoat.com/
`qemu-system-mips64el -M fuloong2e -bios pmon-2edev.bin`.
---
 hw/mips/fuloong2e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 2a8507b8b0..a6bf524b56 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -59,7 +59,7 @@
 #define FULOONG_BIOSNAME "pmon_2e.bin"
 
 /* PCI SLOT in Fuloong 2e */
-#define FULOONG2E_VIA_SLOT        5
+#define FULOONG2E_VIA_SLOT        17
 #define FULOONG2E_ATI_SLOT        6
 #define FULOONG2E_RTL8139_SLOT    7
 
-- 
2.51.0


