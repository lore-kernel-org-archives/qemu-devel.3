Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13142C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPPR-000851-Dz; Tue, 03 Jun 2025 07:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPJ-0007vc-7c
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:13 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPG-0002AO-BL
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:12 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-60477f1a044so9281247a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748948529; x=1749553329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9w35SL38CEz4mwyf3n+L8B+bqiImcbrsN6OkNuFmyxY=;
 b=Heh5sHAsFcalKjNZHPZrLqNMeiV7YqLqLvI034ne+rwP6i5Jek7gwN+XZ4O+FrcGuJ
 FMnD4hBkoK89y5NUF3Ile6UPpJSXlfvX+dBtUBz9TXJ/X7SHYa4XfKtmtvqbbeUBYIdj
 s+0WtHn9QLSwvo+ANpsy8EAP+cTcfytjY0I/GnajgbXOjRuObJNwkO2y+4GYS0yp9p0Q
 Ncjn4luTyUdRAQ1RJR8+hUGDVecy0BfX7LqnbebXReE1OcKyzlgQEzZhRXH4Z8WXHXfe
 zAsRkn4h/svNclA0BJ7AoS/SZ6o166HfBBIzaWftNzJnVhGfGlYoA6aAupxZAYlDGxGO
 oTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748948529; x=1749553329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9w35SL38CEz4mwyf3n+L8B+bqiImcbrsN6OkNuFmyxY=;
 b=nU3BOZIJSxcFh0rPcxD19JUYyjUB1rVz/qXXSjil32JEC/XEef9LYWQzZI8kzwYRYp
 wNnvg5brAE2hSQnpVdjzzx230DVAOjdCSeYrPyZz1iKD1GgzXEIc2glYoA4zvqEMgDar
 BnTMzpQN+RZQT2tUg0h/7TcCVITw+KNMUkkBkd35f/nkyIULV4JHqEhY8fmEApvd2smM
 02nKXR/gBB+9IurKT1wxvPg9y+DkYSt3kDCNlAlHq3GDdvYf6GbuSgbSfHo1cTYE0WKo
 W6+zpmpkNQY05LZABUDn6q/2ZJD9Y6o20B/YrhfYWCEqqWX1ZOYGA7bVRCFKU9HTFbAK
 XbPQ==
X-Gm-Message-State: AOJu0YxOzwJiXGZGo6C7Lw9rBBEwJtFqry0fDgXxuA3bK5j218jzDo7l
 +FDbHlsn5wOGczLBwAED69LFJzj/zZRo0Ggr3ehAuBanqzz3TIBSDy3nkm8EqyfRTzE=
X-Gm-Gg: ASbGncth3i5PWN7t/448+FcBmQhUjgTu+CdQk0Rn8KKFPh/A8ciFQzvraBdpf7ygtZc
 QgC4mfdgQNviPRCqTBJHy9v+M3w5kqNYe7Ei0hvVdsiTJdLl5Oe8abpzoOYX/3RywWcb19LJ7Fc
 etCtTlJf8R9OV4DU0YkE2HQ87HwZcJeXSlF/puT11ZNDyb+RNOHW/Vkqb2blBcRT5gyypQ+7Bkp
 AVKfx+cYKBd1ytEM+FjVHaBcK0/7jj6NmhFCFw/0PcgU42NJjQd5IdUtt6GrntHuRsfr5HS5YsV
 FGpXJdw+9E0g8L7E+jrXSV3SjtEoU003T1VzB6BgNtLwAc2zRwBS
X-Google-Smtp-Source: AGHT+IEeT5NP9L3kpAuRmr8lXK0vvXuW7oWLDsRy91ErQM0McBRnol4TdIdZqZSJHG+QBPl3bxuDUw==
X-Received: by 2002:a17:907:6092:b0:ad9:982f:9206 with SMTP id
 a640c23a62f3a-adb49606242mr1105047766b.61.1748948528529; 
 Tue, 03 Jun 2025 04:02:08 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d84f389sm925857166b.82.2025.06.03.04.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 04:02:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 419AF5F9D1;
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
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Nabih Estefan <nabihestefan@google.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 04/17] tests/qtest: Avoid unaligned access in IGB test
Date: Tue,  3 Jun 2025 12:01:51 +0100
Message-ID: <20250603110204.838117-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603110204.838117-1-alex.bennee@linaro.org>
References: <20250603110204.838117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

From: Nabih Estefan <nabihestefan@google.com>

  ../tests/qtest/libqos/igb.c:106:5: runtime error: load of misaligned address 0x562040be8e33 for type 'uint32_t', which requires 4 byte alignment

Instead of straight casting the uint8_t array, we can use ldl_le_p and
lduw_l_p to assure the unaligned access works properly against
uint32_t and uint16_t.

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Tested-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250429155621.2028198-1-nabihestefan@google.com>
[AJB: fix commit message, remove unneeded casts]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

---
v3
  - update commit title to Philippe's suggestion
v2
  - change title to reflect test that failed
  - re-phrase ldl functions to assure unaligned works
  - remove excess ()'s
---
 tests/qtest/libqos/igb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
index f40c4ec4cd..ab3ef6f0c3 100644
--- a/tests/qtest/libqos/igb.c
+++ b/tests/qtest/libqos/igb.c
@@ -104,10 +104,10 @@ static void igb_pci_start_hw(QOSGraphObject *obj)
     e1000e_macreg_write(&d->e1000e, E1000_RDT(0), 0);
     e1000e_macreg_write(&d->e1000e, E1000_RDH(0), 0);
     e1000e_macreg_write(&d->e1000e, E1000_RA,
-                        le32_to_cpu(*(uint32_t *)address));
+                        ldl_le_p(address));
     e1000e_macreg_write(&d->e1000e, E1000_RA + 4,
                         E1000_RAH_AV | E1000_RAH_POOL_1 |
-                        le16_to_cpu(*(uint16_t *)(address + 4)));
+                        lduw_le_p(address + 4));
 
     /* Set supported receive descriptor mode */
     e1000e_macreg_write(&d->e1000e,
-- 
2.47.2


