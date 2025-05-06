Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B850DC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 12:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHrO-0003LY-AS; Tue, 06 May 2025 08:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrM-0003LA-UX
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:20 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrL-0003oy-21
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:20 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac2aeada833so1085759966b.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 05:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746536237; x=1747141037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qji5LRZL3vUhQI65hD0nE6G02ZiXW1fOZnaFdsDm4Mo=;
 b=mVxlHsl0YWFWlvISnqvrjxXsHG7Lj1VGw0UGlwEFMQMBfB7ZB//8Viw7Br4iYUO6m9
 VnpWyfNPJaumRbAx3gVHtgGbnLAawOrb2whJdYGku/+/vOBgWby5qQAWZ2H0FSEoj663
 cOZVziAIqhPtubWUkhwmQLgxPB0+gN0X85oaG7uxEhtYQmLmkfKUz6cZl9YBPY/XoUjD
 CPxsiYn0vmv17LJSmVUgBENCg865s+DnalLk8U/43wAZfS3ytcSv3gsJ/VQfZDsnWuOE
 gZeTgS3wbtVKz2kNoD6POypoKIP4tQ9cInG+iiNJaLEUpWwif5vCEhloIIhsNWvNbo5v
 9myw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536237; x=1747141037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qji5LRZL3vUhQI65hD0nE6G02ZiXW1fOZnaFdsDm4Mo=;
 b=DKs6cMcEOBHSzP0rFeBVGVRrQ0M57OIAfIB7UjpOiSmfA9IEjU7c14bBzYvAtK598R
 7TOS/SRN+WeCx6bsJo3ehi9M+PUlBI6O059EnUg32+yUfSroeyNvG8gscpQI404EHQ6n
 h/wNhvNFDiyK036pE/FNriscagQdntWwoMP9HZ9DRXmE9gr/ov8vSoZTdwmh9YKHYazU
 VtCcwIUFi8cYDR/mxQ/TxoXGWVE6mYb2Oalv9mbq3ZO6EAYLpAV3va7HsF3De8TmcZXO
 LBv/OK+GKUiEmQetK3y1AXWp0viNge3Ra0WLen7k/K199R9tmDrdYeotoPqMnySUhbJ+
 Gjdg==
X-Gm-Message-State: AOJu0YwPMcgvGAR16tLsFqtoMMLRUrse4AIoJHA/qMrxOmcrj0U7e74b
 UurlAWsF+0AF7UVkG4Cj4M9ZWXme7zOs7ZjkXk8iQvdp6zc+CqRU0vhc+c9kbnQ=
X-Gm-Gg: ASbGncvQ8j6oEd6L25sDNFvFfrC3uAbJ6wsKPg2gHAK0dlusAspcxL+IeYVdsMBn3sV
 14MGqi1jVhQMoC757klEZmL+56mtyf28LLIMoyskNFIRIYZAnF1WWTShgpkWmvU73+hflz3yb+Z
 v8h/hoSxmDK1f8JFlZjNVsTlnlWlym3HwxOxhhjAc1qmDldTjzMtl3muLuOQxHxBHnRBrfZlhpP
 CAqADqaKwoBF/mg3qXKhvSDocclS23CMaMS8FliPhoMdaK+AW1D3l76Hcv1OxEB6a6tQfU5HkLh
 denXr7LPU0vTFGglb5NT5rupr3SrrkT5rfB4FtZxEEhrlFljiDIbow==
X-Google-Smtp-Source: AGHT+IGYsRli9bZlTzhv60wWlWAfST7XIqx/Ilvqxxb/0NqJBIAYhAapUKLeQGZCQV+er4nal6WBqg==
X-Received: by 2002:a17:907:3da7:b0:ace:be7c:11df with SMTP id
 a640c23a62f3a-ad1d2e9747dmr343258966b.6.1746536236868; 
 Tue, 06 May 2025 05:57:16 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189146fb4sm708483366b.10.2025.05.06.05.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 05:57:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 761AE5FAAC;
 Tue,  6 May 2025 13:57:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Nabih Estefan <nabihestefan@google.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 04/14] Running with --enable-ubsan leads to a qtest failure
Date: Tue,  6 May 2025 13:57:05 +0100
Message-Id: <20250506125715.232872-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506125715.232872-1-alex.bennee@linaro.org>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

Instead of straight casting the uint8_t array, we use use ldl_le_p and
lduw_l_p to assure alignment is correct against uint32_t and uint16_t.

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Tested-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250429155621.2028198-1-nabihestefan@google.com>
[AJB: fix commit message, remove unneeded casts]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/libqos/igb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
index f40c4ec4cd..7df9272069 100644
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
+                        lduw_le_p((address + 4)));
 
     /* Set supported receive descriptor mode */
     e1000e_macreg_write(&d->e1000e,
-- 
2.39.5


