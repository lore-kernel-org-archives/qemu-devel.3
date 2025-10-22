Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E7FCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 14:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBZPd-0007OX-GR; Wed, 22 Oct 2025 10:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBZPR-0007ML-QN
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:01:57 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBZPP-0001f3-UW
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:01:49 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-426f1574a14so4609767f8f.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761141705; x=1761746505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qLHVl30GjqbT2sNGUrp6u7XODjWGOXYBV9cF9vJVcc4=;
 b=NMHF4BuiBuBPkZfoumVDAzK00gRsf+IyZ3CJdxeIDXFpgVFz+CtyUl2tdaXTCYlmmZ
 TsoLL2L2auW75Q5h4PcRjKysu2Ah/MJOyFf0HpACc+iInx/aPkKevb+TOIoxkIAwMDF8
 qLi7PmGkcY/PY5ODJRvMLYWf/MIrvyJOS7hbZ1DlFmbEkzggmR9mwL8mjZnQwSNaw/0U
 dy0kSjiLxcNyyFR3a5Plg5ysaErzgm8sL6cGbNaCeDCJVcxzQOrsgoVJLV2+KL2L1PEw
 WdYV+2hH8q5J/pZMQ8txB7boAdHmLUdDNvMNtrq0FwHs7O7FKy2ZPyjf0aLbEhbct31l
 +h+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761141705; x=1761746505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qLHVl30GjqbT2sNGUrp6u7XODjWGOXYBV9cF9vJVcc4=;
 b=VtRxX1TIq9Rav2wDK+pDyadJu+mIJ2ndczYhXuF7O3NeznlZuCkm6C0jmY7VpvCuEJ
 p+3ox3frSNPG844oun+mo41ii7bJb/LT9a7fTUP6g7I29XGgNKpHiSTUoSooXPgKW/Wj
 KcPs78DGWQHQoNBx2vaHvzQ238/VD+pSkzWhZrULdJZvLIHJjoghrI7Bj7e/TK8n3rcn
 lRn9e3cn1okUAyd4WtQ6Zv+ApkToD40iSICYGiQ9xk7hXLHW/wi+aLBwDlMjKoRGUQJe
 aF2iaiBjDLxigf7AgDIjViJ60OoFQPB87cGtqaDTkyR9YVjwuvlTNIOK4tPNaR6uREQ8
 hXwQ==
X-Gm-Message-State: AOJu0YwY1uD6KJ2HxghlCnZcXLv6cXn/BR8VrKCSI31qZ1qH77Cy0nAr
 jiCcXe0UbnB3E8msoAaTh7ttlyBeq0TIziWhVaG7P29EiLOLsMz+7Q1kj5QnCLJmNW0wVM0RTye
 tfMyILVU=
X-Gm-Gg: ASbGncvL5bgIrTYYVCWQm2nq94OwMjGjofmyA4RzHu9MMArPkUqy1URZFnRPD0f4Y2X
 9YSRfy1bN939oJwSzRcDNQNoT58a1+X/UAZtQ4/KQ6Azjb7yn6fLO3uOsB5OxQWLA1MEflDF7V4
 CKqoY0MaiVd/OWrwMWu8VxH7aLJwX+tOdpNtHtZNCt/XWCG79wdRaj/EMMUY6GODeSUG/nbNBIU
 tM/aN+/Pbdhj3ekxO/tilz7nXC43s3JgyiGbECxbZRa+DxWM2axvxPFYPqhVl+CIRbLVVuGDUmt
 kxmKg9EhQlcOLlXBCllCJzvVpRgAFJgRfrdy44EPXrCHozrNoLw04HfbeWc6hAFGafJ4ag/9c1o
 IpZM+CggS4gUDZ1Q9lfUPdB1KFEuFWd6ALGEv+Bt+3EP5KblnTPZyJQHibaDctUkU5k8iUhyzNi
 fSao0ps1oEMqWIjogfzev3f5E2dbcgzkBdzNkjEYQT7ERIIMFHkN/ALmTnDaPEK3c7vES4Y7Y=
X-Google-Smtp-Source: AGHT+IGHHb6FmERd2aST6drwPR4rAF24ZKe8dRavWtQqwCKBMgkph9S4iRBPtxPC9PIdkKTi8zgAlA==
X-Received: by 2002:a05:6000:420f:b0:428:51b2:18b4 with SMTP id
 ffacd0b85a97d-42851b22910mr3947461f8f.29.1761141705142; 
 Wed, 22 Oct 2025 07:01:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce3e2sm25403441f8f.47.2025.10.22.07.01.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 07:01:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paul Durrant <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anton Johansson <anjo@rev.ng>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] hw/xen: Replace target_ulong by agnostic
 target_long_bits()
Date: Wed, 22 Oct 2025 16:01:12 +0200
Message-ID: <20251022140114.72372-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022140114.72372-1-philmd@linaro.org>
References: <20251022140114.72372-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Both are equivalent:

  target_long_bits()

  sizeof(target_u?long) * BITS_PER_BYTE

Prefer the former which is target-agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen-hvm-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 258014370e1..b40ae0b3af0 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -2,8 +2,8 @@
 #include "qemu/units.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
-#include "exec/target_long.h"
 #include "exec/target_page.h"
 #include "trace.h"
 
@@ -455,7 +455,7 @@ static void handle_ioreq(XenIOState *state, ioreq_t *req)
                        req->addr, req->data, req->count, req->size);
 
     if (!req->data_is_ptr && (req->dir == IOREQ_WRITE) &&
-            (req->size < sizeof (target_ulong))) {
+            (req_size_bits < target_long_bits())) {
         req->data &= MAKE_64BIT_MASK(0, req_size_bits);
     }
 
-- 
2.51.0


