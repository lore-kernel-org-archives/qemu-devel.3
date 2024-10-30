Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F17CD7494F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 01:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5xGT-0001v9-A0; Tue, 29 Oct 2024 21:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1t5wnN-0006vq-W3
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 20:42:46 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1t5wnL-0004TL-7C
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 20:42:45 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d18cdab29dso23272636d6.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 17:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1730248961; x=1730853761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OGHSgD0bWZ2CwX6+wQIzrPZkFRl7arycJnyFtsH9h/U=;
 b=C+DY8X83DvG4PwL1lBDHFSf8DHGD0/shfbFG2gV3VJh+n0WiVxJJbmQZHDW0h4EL2o
 TqgqEDSkc1zxJ00HMp7kO3jFLrNaj2P0Yx34dtwVMdB8luZ7F+zexBzPTvSLs8uVDCSA
 2svA52IGrum4UlZVg3OrZWOjnqNW7RcyJdqX1+84k1g5wN6apLmcIJLBlD5hi7Pqg71x
 1vCI6uX+LvRGOTIfoSeyO5e0VSD4Voyi0hGXAluQGxhLmo1xxs+zWPgYgycU22Jwh3LK
 TbArsO0A/PkiVjdEV9/QF6ajU6XEsFznq7EnQfnfS1I239p9FcZjyPaie/CNCZbBqogf
 bsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730248961; x=1730853761;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OGHSgD0bWZ2CwX6+wQIzrPZkFRl7arycJnyFtsH9h/U=;
 b=n07x/hEbfmNuKBtln3/aFgkeH1ufhwXALHdNr51GqDOPBvMnp/ivOmwajWHDMYdUMN
 w1eX7ox3k8GJDCptlkuPp19f1ePvpHdU/yBkI164MqKIbkT9nXZK2Ke4aQn6aQUKGHgd
 1y3UAgNzSoWTkqqMxDpqLlbU4UcyX8A0vdCXHlk9OQ1Y5F6hf0hAPn3ggR7BcZKIflV0
 OB+rAssrr/RG2+qhxKeBy7lsYImhuUzQRvqCuqAuo5phy72dRuH5hT04MZVFgrRAwY9I
 f4Zf6x3xWZW6sZIRoxt9oORwvDfO0EpBq8fSOI68zx7hI4C7YdoI6MjXn6LGobBpSjaE
 RnBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDyjdlsBiCqKzXSqryidqluReK2uo2F/pLQ/XVYqag03MSCVX4M7lqOoYeEt77gtJcZ+SV2wpuvM7J@nongnu.org
X-Gm-Message-State: AOJu0YzVxB/lZdul4icD67gw0k4ZiAAAY+VQ4xPvZB+i9wN3XtiUw770
 6tCkQ4q5Qrm/+2PfV8VWQjtMYC0qdms7alC8kvQmBcDJEnttvAh8t6yOVtLanXs=
X-Google-Smtp-Source: AGHT+IGVt05PIvx4sETp0O1OCG59tllx8GNB+zEngcqAGZAtK6rH70c55EXE4Zm2Q5wrO1t84ZYw+Q==
X-Received: by 2002:a05:6214:3d0e:b0:6cb:eea5:69e0 with SMTP id
 6a1803df08f44-6d1856f3c9bmr274369066d6.27.1730248961060; 
 Tue, 29 Oct 2024 17:42:41 -0700 (PDT)
Received: from ausc-rvsw-c-01-anton.tail89d63.ts.net ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d179a0abf5sm46944986d6.98.2024.10.29.17.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 17:42:40 -0700 (PDT)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH] target/riscv: Fix vcompress with rvv_ta_all_1s
Date: Wed, 30 Oct 2024 11:41:46 +1100
Message-Id: <20241030004146.935656-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=antonb@tenstorrent.com; helo=mail-qv1-xf31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 29 Oct 2024 21:12:47 -0400
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

vcompress packs vl or less fields into vd, so the tail starts after the
last packed field.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/vector_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 072bd444b1..ccb32e6122 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5132,7 +5132,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
     }                                                                     \
     env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_elems_1s(vd, vta, num * esz, total_elems * esz);             \
 }
 
 /* Compress into vd elements of vs2 where vs1 is enabled */
-- 
2.34.1


