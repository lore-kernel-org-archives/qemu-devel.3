Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3715CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 06:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS7nN-0007iy-TN; Wed, 27 May 2026 02:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wS7nK-0007gH-85
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:31:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wS7nI-0000Oz-LD
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:31:09 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so119794905e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 23:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779863464; x=1780468264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ztWCR8R2CnueDbJg4xYm7NXq32HJ5ZGoHPRyI9ej+Y4=;
 b=gbwGPT8YvLwHShLzWZPdGUbyAlWFQ1vUbzgxfMWw95mQZzhBfHyVZUg6PbvlokE2WH
 Fe6j2DQAQpkAMY5EemNKr8J5lJ/SZbXxO13WVdsgbf52oQfoK9tuX5Wdo0DzDAPL/7wz
 zgA+D2Zilfn0bgXNrqr6FDlvpJzKRJIQnnh2xjzb4qzQ59z6v3c9gSsW1EQWipCit3iU
 klPVnQb4lOUblGB34vFwwRrI4OJYTY7/ZvE/VZBQRiyD2Ml85Ib6NMB7qOwrUG6agliO
 Pv0No1u/daEbQArK5fBczKzTBXJRGxoT4Bnf8vlEMX1amqR6MyLx+L/0WzF6/R1Dam5o
 kJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779863464; x=1780468264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ztWCR8R2CnueDbJg4xYm7NXq32HJ5ZGoHPRyI9ej+Y4=;
 b=awmDOyV6VrNiSyKfDv0xrNcjknLIBoViHMt5MRh7lxQeeARq3pnOF8CL5glmgG8DqN
 wJO2oS7cgtCddNoTkqenRrOtl3SXAVVDAH5X76ZUoM8JIQDUsq3wenxYLkdi+zi2C81N
 hz2KNkEKRmdZbztTjYxje++pRzak2Rb3jWIrLrT/zlqvcCxC0igykwKRRd+lu32956Hd
 zN60Z3mP+27WxX8DNUPVu6sW6KZJ5vjUlV0PdosHYQ4n5vA8p/Ng4LclbkhJvXdhXu5B
 CH3lm1W/ryOwYhqyc5M5KEEns3fhYEWUDXbNOKQ54IZ6SGJ87csiqDUjTMfbwHRrqvwd
 vCNQ==
X-Gm-Message-State: AOJu0YzjDG9VaRJb3I7J2rFZYgtFlPFbhmhETayIzbPSQ0KPmzvVoWVE
 cZvaMkBO3zKWeA+xlNW90MOXn/SBJfyendI30KwXFHbT7k+7YRkvdDu4kCjXoYzlC6NB3oI0YjK
 ErUBMBZzWCw==
X-Gm-Gg: Acq92OGAKV8dn8+dlHanitgvuvEoRego7rjgtTBMtV3rth+capwBCRwmKQFjxywQGLB
 AWfk9JlfCTXYTFE5sr6T9+aco8ueJjOtCzBTtDFGGRFCoM9o4hIs4MNcSvjq9k7c1AjF7esJAN4
 202Flf7X5oZrWm3+6P8gMfz6AVEDDs5dG+KOly7q8c313+yeyZwHHslizLTLmy7uwG1xRZwMmnV
 LktcgQXJc/cz2+eb1GXPpwtl78Xppn0MLa+/l1m8FkB8F7Fav8lBwzx0ZJnWLhIeqdysWWXS1WC
 Wbs3NcMa1aP8zppZeQLNCDeCKLTFdzArZiNQmCLPdtqKaL4gd5A5sXuM6PBil/+3NhGZAWLOqgt
 4Rw7aKjGE9hB/XZI7RqY0r1oTIjVgYnmiETiEIPgabIiTFuNJ3+okcRRVZe+DL9wxwnTw4lKuwt
 6T3q2YfqjQM4FcniswyBN/y/LPNHe0HXqn37OSq6G3t3dr+7I+pjecUnq1EErsDnLb4/dzKzk=
X-Received: by 2002:a05:600c:3506:b0:488:d6eb:e63c with SMTP id
 5b1f17b1804b1-490464eae0emr339932795e9.15.1779863464356; 
 Tue, 26 May 2026 23:31:04 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49045620c05sm374315185e9.14.2026.05.26.23.31.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 23:31:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4] MAINTAINERS: Orphanize FW schema specs section
Date: Wed, 27 May 2026 08:31:02 +0200
Message-ID: <20260527063102.91205-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

I'm not paid to support this code. I haven't followed
it neither, so be fair and just remove myself. Demote
the status to 'Orphaned'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a89d6c6ca63..892380a6d51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4003,10 +4003,9 @@ F: docs/specs/fsi.rst
 F: tests/qtest/aspeed_fsi-test.c
 
 Firmware schema specifications
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Daniel P. Berrange <berrange@redhat.com>
 R: Kashyap Chamarthy <kchamart@redhat.com>
-S: Maintained
+S: Orphan
 F: docs/interop/firmware.json
 
 EDK2 Firmware
-- 
2.53.0


