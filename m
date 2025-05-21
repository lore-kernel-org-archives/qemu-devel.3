Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F83C54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmX9-0000VZ-4G; Wed, 21 May 2025 12:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmX3-0000S8-Cf
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:05 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmWx-00068z-5j
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:05 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ad54e5389cdso684430066b.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747845775; x=1748450575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NmqDsIQ60Ty23DxSPxeo+hGIPXJEhGzvguIi1HmtE4I=;
 b=FYvsQBGqqBRlIL6rgHMwfo46iWHr699aQOkiv4ow56a0nShNEMbYCd0nD9A7Tf9rdq
 npow9D/Zu0+3JUwj52DfEjQy0BHHqZP5butNSDw6AT4DCXa1k89h5YGnuecPAmFUcL4Z
 DCekOEytqvl3h3H3cqAYDmNkVqfhmUlW2MuJiaqv/ASar3zod8JailkpmoQBGYd75jFy
 toBs2DulYVlnrVkUfiRbsqioq6CWR+Oi7Ns4fd4aBGahcpefZmszA84uRrz4TanjGzOn
 b5mOoSMVB8imGa/Y1+uPVlezmuqk9bHbui1aE2QqWl9/wNg7xvBl7Cuw5t+/m65Bm6on
 zAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747845775; x=1748450575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NmqDsIQ60Ty23DxSPxeo+hGIPXJEhGzvguIi1HmtE4I=;
 b=gNUR4BjO0SgzKXgM1rrKn53ee/LJojPW6y3tbOlaWXey67vsSDUXdRpC07PPHaEd2H
 dCWk4K9ygC2ask30IcpnB99kgXen21tvDBTfqHZtVP0yKoc14wBLGQMzeVmpNbZz1p4T
 D9hkNOvVdbQ6Ea3TNChgsb/AjezAdqML4/pFSTyyOBuX2tHTZ14kx8o90KuQ267CEZnt
 W5EO3TWskLrsz5bzkfw8bStm5MXFA/uXWrHnVmaPTlyU7PKLbpQQPse079xQy4tF3Zr4
 T4AbdOfHTA6o/h72tCoX9uEpdnzQDhBn628OqOhipPidUiMkH54ugIeo2X8TJjg97dZI
 4CCg==
X-Gm-Message-State: AOJu0YxbMlKCbF37hLL5Fh3jzUjnkNEHC55XUsET1cYdcJIV7/kjNM4v
 z8w6k0VPKLSxxDQTg5+fNCEUIsp3OpV0+uoiSFFImTpbAGX0cmGWekBBGa8MuMWk5S8=
X-Gm-Gg: ASbGnctaHn7pabDhTxWQHpqNXNS75cQxXXLZoJ4QG5X05xIghN3Df4zu6wdFhjhxGAx
 IFN4M6u6Qpqeculipl6fddhHZSp3aepKIAEfwGs4AqcoqS/Aso8zYuPAeT51g/sHwFdNFize0xC
 ZKzyKPyXA9uuSrsP4TAPQgsKx01+yzwUqrb+DLrxCyv+8VPunlWvBpNjn7/DB/xi9tvWH1sXaqa
 sj3IFdmoqGfwkeQx6QRPPdIyQyYdoazmDLZXa0romQh/9W0lXG8wPAqrIjINNwbxoIEnbINrehg
 xVwKfWJQqI50yG+ygvPc+qY+8E57XuMdbZHMe0ST67LToGjpjtHOQT0b2O2UdVs=
X-Google-Smtp-Source: AGHT+IFC/WweuYUnLxpxTu1O1RDHCw/OHrIYiInocgfeMCJ14qDTrKXxUMrvpEoR8D2+LnFbenQL4A==
X-Received: by 2002:a17:907:7f21:b0:ac3:17bb:34fc with SMTP id
 a640c23a62f3a-ad52d5e1a9dmr1611527266b.52.1747845775415; 
 Wed, 21 May 2025 09:42:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d04b08bsm935707866b.13.2025.05.21.09.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:42:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7DCDD5F9EB;
 Wed, 21 May 2025 17:42:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Nabih Estefan <nabihestefan@google.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 04/20] tests/qtest: fix igb test failure under
 --enable-ubsan
Date: Wed, 21 May 2025 17:42:34 +0100
Message-Id: <20250521164250.135776-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521164250.135776-1-alex.bennee@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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
lduw_l_p to assure the unaligned access working properly against
uint32_t and uint16_t.

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Tested-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250429155621.2028198-1-nabihestefan@google.com>
[AJB: fix commit message, remove unneeded casts]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
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
2.39.5


