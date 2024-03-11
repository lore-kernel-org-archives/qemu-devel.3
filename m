Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E1EC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl9o-0006rf-9x; Mon, 11 Mar 2024 15:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl50-0003OV-6x
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:13:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4u-0000ND-QH
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:54 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41312232c7aso24406005e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184369; x=1710789169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1PPP7DyUJzXO4PyrnSnzaFZyN1tK2CNOu4AL56ymsAo=;
 b=HDTqPu9ovDVjIGpoeSYbnvY6g98dg07KWVRKs/iaLxEB7yCOYHfzjyCmAhDFW33J/b
 FXC7ZnofxnsBtQ+PbbQHDvfZS+OY1abhZwIzPlgamYI6P6o+cqJsg38FHZbuOXFWqnGM
 3tZZFORt/0f50zyssS2VxT5dzJQUixSk1STuKGIYdTLBrXOvniQ1VX/hqLUQaYbBZzGj
 1OqSVsugZEeGPjvmNaEdVArVmMQNU/0AKZFjWFdWZ0AkXdELOakxy25UCSAjXpi0/491
 zg8oTgASWTSXFU8pKlLfSqkuE1FSNQeN9DbidRmiAY+1OPlgesD1+jG/T/vWvJzobeyc
 zIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184369; x=1710789169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1PPP7DyUJzXO4PyrnSnzaFZyN1tK2CNOu4AL56ymsAo=;
 b=bNIM+VkJ52+Base+AvKuZjWV9RMO56r418xanu3/Q11AtUjDozeoWFipGa+Cd/maIk
 cEEap2sHOcKSAwWKPSHgHyectTstQcHQNOPk84nMGRHP12whbiZkf+IIw+RH0nXh45RY
 Tl+kKwgL5U47maxcVCI9X67rkMAbCdoU103JWd2KMhcouonJBjz2wDBfjxoy9iY8F3Xn
 ZSV0Nxg2hnRYQCtNLNZfxnEm0hSQ7ut2O3fsVaVzIBClEgJ1jJWVSzmjJIGlJ4KXjv6e
 ZPdEWO4SyHjFNdEpTG+h/ExGuui1b8htdH6jhA6rsu3f/Kw4wnqICf9bnmNtjqZIeQpK
 /m1g==
X-Gm-Message-State: AOJu0YzYBr5yEEfYy0SkYFwrIpbwK48SJc0U5KkGoGmn0XrzDaxwzqRZ
 XSITPna5dWN+6pgzriUgSQ9QMiifU03F2IznFVD46zN0Lclgn+Y14ba8S+YFeQfNlQEmMOn1P9t
 4
X-Google-Smtp-Source: AGHT+IEqZKuaN+EBpFn6p2fgLKgxTkSY69YLZoueHFq0L85GqqNQmluik66f3Gc8FplzR+whl4mBwg==
X-Received: by 2002:a05:600c:4f50:b0:412:ee33:db93 with SMTP id
 m16-20020a05600c4f5000b00412ee33db93mr7013109wmq.3.1710184369331; 
 Mon, 11 Mar 2024 12:12:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/20] contrib/elf2dmp: Use lduw_le_p() to read PDB
Date: Mon, 11 Mar 2024 19:12:35 +0000
Message-Id: <20240311191241.4177990-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The relevant value may be unaligned and is little-endian.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240307-elf2dmp-v4-13-4f324ad4d99d@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/pdb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index 1c505142518..492aca4434c 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 
 #include "pdb.h"
 #include "err.h"
@@ -186,7 +187,7 @@ static bool pdb_init_symbols(struct pdb_reader *r)
 
     r->symbols = symbols;
 
-    r->segments = *(uint16_t *)((const char *)symbols + sizeof(PDB_SYMBOLS) +
+    r->segments = lduw_le_p((const char *)symbols + sizeof(PDB_SYMBOLS) +
             symbols->module_size + symbols->offset_size +
             symbols->hash_size + symbols->srcmodule_size +
             symbols->pdbimport_size + symbols->unknown2_size +
-- 
2.34.1


