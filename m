Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E56C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPPN-00080H-24; Tue, 03 Jun 2025 07:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPK-0007xD-No
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:15 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPH-0002Ao-Kz
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:14 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ad69e4f2100so814618866b.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748948530; x=1749553330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHjlw3RJVi6RLH6QmbsZL6K4pJM81iE3Xqr5dcHcjDQ=;
 b=Ou4/uhG6tDMLPDNavJ6Raiq5f+Sxl1zvbCb2FWZ8kKrEmi11gryHMPKICuxhzth6Fr
 UnaYT/miSwstuNb0090J9RHB/Za3qofHKHZlmI0PZ8qt9oRvEPL4AO4u5I7u/zsBbkfr
 oVHUVCHrYtCBvgCrh02Hdyavn0dLv+DM16/qoKodFZkCRjOu2C7VtDN6l9Z3I5q2bdtb
 jJVrhHF5TExj0CSTOt6azk7BlFT3jYbopIwRcIrFuDnYWTDHoBzL4YIGsm8+tUdmn+2S
 MzsXJic2Raur6+YfsHLtfaIEd1GFylBgthL08HX/GVsvLU0JZh0irZQ3Iy/blU4sR4dx
 F4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748948530; x=1749553330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHjlw3RJVi6RLH6QmbsZL6K4pJM81iE3Xqr5dcHcjDQ=;
 b=pHucJCBpexQK3PC+BeBM99h7tYiJWG3lI53kt05HuotV5fqMKNo4K6XF7StFmGzP1S
 bvEnkmM5TR9jhrDJ6zGYUS/ELKwh787wnBDtbUdz5DLSE4u+iXXagU5OEtZp3PEaAd7u
 1BVs6xauN24CoEwL5S83CM+E0EDlG7C7Wk8jMVHQ+sXACN2If98MYgcM7xLBhwTWcWKD
 VbWUGk8nyr0VvWSLReQavNgNKALuvHAo+HLnJjUQUW56dlWEjMz2IfLRz4JA4OAwvRoL
 HCIW4urYXum8dbQ3/oY/ZKYsWb7s1aolT2oFEOmXVz497fulW8d0ipKcD0cqyeZybAvp
 g2+g==
X-Gm-Message-State: AOJu0YyY4fBtvUuPyQezP53Q5MhEBOThkBx5PUU+05l+hrwT5U1/lF7R
 AMgoNtm81YaFkyYSIsFsAmL0m3KcVGVr/qeUn7erJogLZ9b/HnO+MlbwS5LfhbTedBg=
X-Gm-Gg: ASbGncvpYkzpPW493m5hjt8DL7q83kBmjhqaWDUwcKeQlbgKZmE97BVUUvEyCjm/pvV
 zhOeTJOgFP0YGRXAwi98Gnltwcw6MabetYPdoTAwji9UC/BJhu05KXiDG0PBfr+KIVO4oIRZzvh
 tKR/kcL+8TMrOplpBtZMXuMueoobepaPxbBfcLDcy0nwnxSjq39za0RqWnJ2OQ5eIA2DkqBLpzR
 NceJZYDB8MXPesccrUkvFXQnPF4XubB5DK//axbWn9zgJTaMTPBG6A0gClSFS/C+/pxV1Nzx6BO
 EjC5OCLQvLdm8VD/5Jc5j/kTcgE+JPw/tIrWr+6F27QvTuN4RC69CImH2ZeyIp8=
X-Google-Smtp-Source: AGHT+IGwQ7bXeXnW9VeEGX0NTPLsK5XyWsuocW1giy69sYqWPQYvTtmF7v3uM0ysqqcMqNPEfFBq4w==
X-Received: by 2002:a17:907:724f:b0:ad5:27f5:7183 with SMTP id
 a640c23a62f3a-adb36bf19dcmr1330424166b.39.1748948529797; 
 Tue, 03 Jun 2025 04:02:09 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d84e76csm926436966b.86.2025.06.03.04.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 04:02:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 895C15F9DD;
 Tue, 03 Jun 2025 12:02:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v4 07/17] MAINTAINERS: add myself to virtio-gpu for Odd Fixes
Date: Tue,  3 Jun 2025 12:01:54 +0100
Message-ID: <20250603110204.838117-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603110204.838117-1-alex.bennee@linaro.org>
References: <20250603110204.838117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Seeing as I've taken a few patches to here now I might as well put
myself forward to maintain virtio-gpu. I've marked it as Odd Fixes as
it is not my core focus. If someone with more GPU experience comes
forward we can always update again.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - s/M:/S:/ for the maintainer entry
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 16af37986a..7718199979 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2668,7 +2668,8 @@ F: hw/display/ramfb*.c
 F: include/hw/display/ramfb.h
 
 virtio-gpu
-S: Orphan
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Odd Fixes
 F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
 F: include/hw/virtio/virtio-gpu.h
-- 
2.47.2


