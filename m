Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB11C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 21:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4RNp-0006D4-K3; Mon, 14 Apr 2025 17:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1u4RNm-0006CV-FR
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 17:30:22 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1u4RNk-0001x3-Tf
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 17:30:22 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-727388e8f6cso2776240a34.0
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 14:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1744666218; x=1745271018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rSotBaFUmmKWr89h4uQGHoagPTJq+4FsRSbwdeSTqUo=;
 b=WVy2Q03j93QHzMKt+HPYP03TQRkjB+UOxhgxFvpCnOstqNecNGCYFGKMFWn5/hDDZm
 Ti5JNUCifgZQyjWSSLNf7uPJPjSLCXCeV/YhbzscE6RYAyiRDacXQ+8k8UC3wplqzsL8
 9212qG4RzXvhXAAi06Jdc41uqL0bylqbBnVL3n2wzmT3gP8LbzDwum3zNldZgsJp5TuC
 eeKuCOpX+MqM7kLxTELbndOaJTqrdFSrl/C9oAmPbkwO1TAsaUjRj7hsHRUAh+R4Q652
 sh74J0il5zxfgNvow+obIWIgBsdJzuf1qstbnGHzzcLCbv2Xard6ftoI4jiK4QWvpS7s
 401A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744666218; x=1745271018;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rSotBaFUmmKWr89h4uQGHoagPTJq+4FsRSbwdeSTqUo=;
 b=owh/6sc+s7fPbrghr5Kw054JfHIANhImmT+7WWwWs8vg1idVc80up495zzrlg/XiTa
 Z2Umu9099N7Zi2wcxi/0nx/5tbn5OC4Q32Au9tJdyYNNzu+Uyfx0Bh7iqyKY37LEmO6Z
 V4ETrBY8RiYwEmkLJI2Je5RlJW2NaXmCAB8sAFpiOsRL8tg6oNgvWoUhhdrBdcX7LxIS
 foeyXJkyT5IO0uTKqu+9k6Vbf0azjYkZl0NHjUe/XQODYKcnQjj/m1x+9VgWuAn+rOtd
 Dw9oTMpD3/b/gQj8KzzuN28fb+3ia+XUJ5W/OmeJ9SifxcoToS6JU6j7+23nLjQg8BDB
 MXag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrPbmXUqPNnN272AzVB8eSDxz6/ImpyfBu+e1UjCAqUq1lG/CeXaEWpxjcMVMfE5F3miAm2Qu9IhKP@nongnu.org
X-Gm-Message-State: AOJu0YwRCxOwtWOKT6hdnOWdLSi+ziTjH7zXLTwaOMSqKBh3QXfT56SA
 3J0SxUsa8ey4l6p0IYpQpS8yMNVJ6YPGQEqq4MoSxLT7C/3vFfOGD8z3TQcZjX0=
X-Gm-Gg: ASbGncs7boSn/5l4/l4zqXFUiWTXz+iukXwDY0vRemURAgL9O7yL9hChalFfGN7LdAz
 TF2kMygyH8t1ugnMQH3ZihTtQFh5HZV5BmSePwmSIqVAjAGoaKY4vUtxtD4ILCdEeql3EjA6zZJ
 W8NcRQbwK7ef1wdP+RknzBGn0csi5XoBE8V2qhlHgRX/glWmGvUNVNVQtboeDV26h5oS6WzlboV
 fhueqms7luBTCQ61oO6kkMei9wItLvExcv0tBdhh39fIsCGJPTzEaNtlK+n2z5dHZiQjYh9dKVj
 SOeKKqq3uVmJjELJA/ERl1qhHKREYaJmm2TFLD51yQfB01VKchfW7+eVtxeZOqlvrYAMf5XItms
 =
X-Google-Smtp-Source: AGHT+IEkVa2S+U01stfqgQn76gV6oe8pSub133NcxE+NMQ92oq8B9w+toXaXzmbKP5Xac8+7hE1RRw==
X-Received: by 2002:a05:6830:6812:b0:727:3e60:b44b with SMTP id
 46e09a7af769-72e86331a84mr7800038a34.14.1744666218315; 
 Mon, 14 Apr 2025 14:30:18 -0700 (PDT)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73e4d7e2sm2168999a34.45.2025.04.14.14.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 14:30:17 -0700 (PDT)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH] target/riscv: Fix vslidedown with rvv_ta_all_1s
Date: Mon, 14 Apr 2025 21:30:06 +0000
Message-Id: <20250414213006.3509058-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=antonb@tenstorrent.com; helo=mail-ot1-x329.google.com
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

vslidedown always zeroes elements past vl, where it should use the
tail policy.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/vector_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 67b3bafebb..1012d38c8a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5113,9 +5113,11 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     }                                                                     \
                                                                           \
     for (i = i_max; i < vl; ++i) {                                        \
-        if (vm || vext_elem_mask(v0, i)) {                                \
-            *((ETYPE *)vd + H(i)) = 0;                                    \
+        if (!vm && !vext_elem_mask(v0, i)) {                              \
+            vext_set_elems_1s(vd, vma, i * esz, (i + 1) * esz);           \
+            continue;                                                     \
         }                                                                 \
+        *((ETYPE *)vd + H(i)) = 0;                                        \
     }                                                                     \
                                                                           \
     env->vstart = 0;                                                      \
-- 
2.34.1


