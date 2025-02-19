Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7DCC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 09:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkg2E-0006iw-4z; Wed, 19 Feb 2025 04:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tkg2B-0006iL-W9
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 04:06:24 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tkg2A-0008Sn-6q
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 04:06:23 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-abbc38adeb1so232159766b.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 01:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739955979; x=1740560779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sXd50VFtO0uVAoaFRh+NIMNZHl0INBngOiyrGUkb0Hw=;
 b=Y9ILJc+St652xqrAyjmPj77w4pWcntp+6LObGSgG2oiWmD5KWQQcCg5lKOtepfh9oe
 OolqYpKfRT9ydrFEgROI77C+i5cms+ja86YbEaVFzCUcy4nB8EctEzFeZg/SjPc3zUHK
 SW9LZWl28fGqtp6ww9heTmzVpdLc1+T3I9dCPhNApizjylBK21NoSfJNuZjRHUw5k0/A
 AJrrzUulDuYZsHt/0YH0rYx+Ur3LP+XakOhDWYqF04m14k0rPJXoeupKsqtyFxcrhU9/
 6YvA3cYHiANwR/ZqSXXR7N2uOJXA5RGdXAxBMIAJsrreUOrQBmWxK68NPMG2uPgsOpQw
 O+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739955979; x=1740560779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sXd50VFtO0uVAoaFRh+NIMNZHl0INBngOiyrGUkb0Hw=;
 b=FegqCvjNEuGNjtW7dgOgAD1K3PhAWHyEOe8PHwCRE9PbgJcs5xQQoVmDcMF2SnezUW
 xenjaSdYzp6E8256p8Kxcnh2fb9uVpzSZrNxVxkCueL4Eu3XOrOyjc++gNOgS76deKyA
 3FsBf41oQksuMJK+5G8AYbD0CQsq5eE7eq17MQK/a2y9OcC6npIqr9dgBVA9XV56w7o4
 z73+kAMxAcBRSnoxhnhRI1tfp8pY7HBiwl+tA/1ciWdt4dEXXzI6zNAtARyG3TYs7RZq
 mij46xbvqJ/w3Oauzn7zhogT3JN4xtMoh/80spj7xBq0vqn3thIE74NyO4uOUGnsnJ3Z
 j6lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRgn2quXif1X3pF8YNZjiIBP9sKFb52CESDOhQULbAncW/OzKqqc66s/4EHHkke10DEvixksd+wxsa@nongnu.org
X-Gm-Message-State: AOJu0YwQxdZkVAgqGkuYlO3d1XGua3ece6CBt34YVKyE0P+8Paxg1c5o
 IH2t1ZswHznZGWDv+hj1m3UbITWLd1edPzMihVQZ23OaB0tXYVmm
X-Gm-Gg: ASbGncuetN/eZ5jiYLjqLPd5vxrZAg2RGSQN9fzkabI2+hZkISCU/aFJ1eDP+/yl1/m
 Ek16q8tH/X/Hdg7AAM+9yCtqNpSiRIGyvQ2CZbHMz7Jsv6frbrHHlPEq7BQADyP9eaqqIkJL6Sm
 sGwUKIWZwqBI1zVbvqx4o96QF5PfEEpoOmbvrwpFJEXv7jJqJNDPJyKgLk+myJ0dMgTmhapZ6Ye
 +O2Kh8/Qlnbgkfwa3DPPr2adDZwM2/ujbezHuIDruNuCD7Qtx+SJACZUVslFtk2A51s4nbi07gK
 6lbGH1EcBFh4FhnIfMtzgmY=
X-Google-Smtp-Source: AGHT+IHHTz3QbHXoc+h1A3QyHVtx2q2ZpaXqZqjR+HDmtSuaGT+UUd07cZS285AXqhHj7wDcXEgHUQ==
X-Received: by 2002:a17:907:96a1:b0:ab6:fd1d:ef6b with SMTP id
 a640c23a62f3a-abbccebec04mr286233566b.27.1739955979217; 
 Wed, 19 Feb 2025 01:06:19 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:8a23:a57:e776:3169])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb9faab9f1sm495084166b.49.2025.02.19.01.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 01:06:18 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 1/1] qapi/char.json: minor doc rewording for `hub` device
Date: Wed, 19 Feb 2025 10:06:03 +0100
Message-ID: <20250219090607.559887-1-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x62e.google.com
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

Refine documentation for the hub device, specify the maximum.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
---
 qapi/char.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/char.json b/qapi/char.json
index f02b66c06b3e..dde2f9538f81 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -337,7 +337,7 @@
 #
 # Configuration info for hub chardevs.
 #
-# @chardevs: List of chardev IDs, which should be added to this hub
+# @chardevs: IDs to be added to this hub (maximum 4 devices).
 #
 # Since: 10.0
 ##
-- 
2.43.0


