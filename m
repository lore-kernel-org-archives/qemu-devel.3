Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F01EC369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4xvX-0000vd-Oh; Wed, 16 Apr 2025 04:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xvS-0000to-Fk; Wed, 16 Apr 2025 04:15:19 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xvQ-0005YT-AC; Wed, 16 Apr 2025 04:15:18 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso5934088b3a.1; 
 Wed, 16 Apr 2025 01:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744791311; x=1745396111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SwF/zcvg5LcbyTBGVajfiTYVcj76iSNgPiX/V8HAlI=;
 b=PqSq4ZhD8aIb6cLvTxCT3dML3M6hAvh8uKlX995idnyTrlQiOerYFQQ4YPh1jXSAvY
 dZ676wfmq3IKHyjYOnovoH6Icbbutr2l0VknLm7NZ8jANNdyzhFV/OfKH3o1aSrcqYsm
 6KHjiT4+z/otxOdz/irc/SvzVZrFIKURehhHHvMkkuAR5v6bc5hhs7hnymhXqs1r8FNk
 DmWeHo4aHQZrt3h2oQCXLB3SVLLXxOs8GCGCCn+dCSmy5qRTmSuC/h3h9G/kSMbVhAFh
 QIwyQ8+l7PENSerLKFyjkSP+MV2cb72uQLquBSYyVBllp1zzqgubbH9z5H6JyDv3n7XX
 JWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791311; x=1745396111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+SwF/zcvg5LcbyTBGVajfiTYVcj76iSNgPiX/V8HAlI=;
 b=sA8WfZLfUBlPaMQkAbHSH24FfsnYIwKnpHGVNLseKjBtUHs02ttQHFUEXEa+YuECu+
 PoJ8tkO4iLtDY3+/MkhIzh7sLgpWDehaxb9Dg7/GHhTeGf3IzpXbc6u2cWxqj6qRnv06
 IAbS8V23/Jk2AXDOF4h079PV3YmiolhXWRS4pzs7xt9WMi4JDBBn1NauBmSj6+j3PG9F
 PkLpoSSIHSjn2YR/4JfMOzzxe73138K0PwOQMK3kY+kMp98KvgdM/EyQ7M3RCC8WsMA9
 S2hcUoTf0SkH/SJc1VApAlztpjZxsMrhFeEHDf4IXaJ5MXo8BOvVLIgE1DYpAMxRXhD8
 L4zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ+8pIOwiBxkiZG2ujBB/ScSpMkDwRTA4rYRn6G6NVYDTt0YMlkZAd/XjkWdCiSj3ZHXIb+WR3Bf0hFg==@nongnu.org,
 AJvYcCVT0yw2eEUje4WJkd4Be6Q2L7poFnFmWpDIRV8OWWDNpA+GaaE2LBHVKPDTLf//bLxGshejITz1M2apuA==@nongnu.org,
 AJvYcCVWZyk2Uw/i9pjMYbJXAKh9Em8RhpL8U2PA8akQ0WdUoZFEetmNASKh1L56kMh8ozWKB/e1PxmBrYY=@nongnu.org,
 AJvYcCW+CgqY95kAwLlOliwpheXJaV+/+H5NRtHX7OMXVCT/e70ruSpvXB8pDioYdID3rA4a9pgNListEA==@nongnu.org
X-Gm-Message-State: AOJu0Ywb9cpWaQi89bAybtUXnnFDHtrfY8DcNBo/bYI0o9m65X+IFpQC
 5QwWOsUByY2jrA0F8H+ixwWhYs0mJCbGmgVY+jquEi4GiBJznALaaA16gsCa
X-Gm-Gg: ASbGncs5HNLWGj1V1pfqLhuHCRwuyudDatRfB+mtKI/ezrHMSdIjZyKIuWiLfKpvQ4t
 Tym5aWe7J0pwoX3BYFHQ1PYc4UouwcvfqD6Z3R8me0cPNmokUZ+nZP7GgZK0KarhOWcDd87bJsB
 xeyn/lteVFygJHUFuhtV9KcvZQwmIawmEqKR0XowIbqLt/qoLpgMkhOWjvsjdDz2+xrScOP6XsF
 U/orsBjjtFxr1YoF9iTJ8cWc40cHHxJfS4pjteN/gltDyDyDAJIxq3eV1FZU4qvZKK0E/t3/yKW
 ZG5qdRA5IxFZOqt+/+e+ObKoqBYlR+i+H9DKb64b4BCbPHpnubHTdLsIQw==
X-Google-Smtp-Source: AGHT+IFcRXS74eGqHFoObLFx38Z2SJtnXeKU/q+O9awZgeadeFbL75vkrelwK4pBvPI7MLCNBkk4gg==
X-Received: by 2002:aa7:9a84:0:b0:736:46b4:beef with SMTP id
 d2e1a72fcca58-73c266b9c4amr1660367b3a.3.1744791311267; 
 Wed, 16 Apr 2025 01:15:11 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:ee5a:e672:7d4c:d43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3263sm9839445b3a.38.2025.04.16.01.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 01:15:10 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 01/19] hw/core/loader.c: Fix type conflict of GLib function
 pointers
Date: Wed, 16 Apr 2025 17:14:06 +0900
Message-Id: <44e9ef95ea6e8aa33560ca8580db0033623f0e91.1744787186.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744787186.git.ktokunaga.mail@gmail.com>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42d.google.com
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

On emscripten, function pointer casts can cause function call failure.
This commit fixes the function definition to match to the type of the
function call using g_list_sort_with_data.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 hw/core/loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 2e35f0aa90..93a8b45d28 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1410,7 +1410,7 @@ typedef struct RomSec {
  * work, but this way saves a little work later by avoiding
  * dealing with "gaps" of 0 length.
  */
-static gint sort_secs(gconstpointer a, gconstpointer b)
+static gint sort_secs(gconstpointer a, gconstpointer b, gpointer d)
 {
     RomSec *ra = (RomSec *) a;
     RomSec *rb = (RomSec *) b;
@@ -1463,7 +1463,7 @@ RomGap rom_find_largest_gap_between(hwaddr base, size_t size)
     /* sentinel */
     secs = add_romsec_to_list(secs, base + size, 1);
 
-    secs = g_list_sort(secs, sort_secs);
+    secs = g_list_sort_with_data(secs, sort_secs, NULL);
 
     for (it = g_list_first(secs); it; it = g_list_next(it)) {
         cand = (RomSec *) it->data;
-- 
2.25.1


