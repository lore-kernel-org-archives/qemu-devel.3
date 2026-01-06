Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAFCCD0437
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 05:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd04T-0003l0-Sr; Tue, 06 Jan 2026 00:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd04S-0003jQ-3v
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:57:32 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd04Q-0001m5-NF
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:57:31 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7baf61be569so724704b3a.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 21:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767679049; x=1768283849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=etIVLC6L7mo/66z2SyCuVLxVt9Sh/37Vs1ku8vb9LDk=;
 b=BFon2xvV1/uqj7P34WYUqwoGu1PcQIPScpXSZO0CHicjE/fzRtz8RBuSXIbfyBj5Vl
 4Rar4spuin5+ndtMZl49SQpFIh03uzXcQ1RcDjKsm+zIoh/Fs098fWsFp3H8nry6sNiv
 N90ba/wM6BYL+VmTSALoK5TMHv5H1BRAbSEYIwwkEWL/m0g3/Wb4gBqaInsEc7Nwuyza
 3HWqCLbfpC35oB7PQZYmjHEJ1504lDMcCIJ0ddE3DtLMXoxA6Zz9UG0/j93/wHSVtjqQ
 YGyDFTMiURSahlIUgHC1tXyljnITxpyhpU+64HOxWIRiHkfib2q6EKL4JXP5km+YMea3
 Fjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767679049; x=1768283849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=etIVLC6L7mo/66z2SyCuVLxVt9Sh/37Vs1ku8vb9LDk=;
 b=Qx9PXAzdIUmTVs9PzRjZ478/FMkpm6QHlWysatPa3PZwYoR6mfw5dXEP0ZCcXQUbAO
 jKCNBINOktzpeoQ/gW747S5jTNOOH+F3/cxk3NNU1F+oY/B14nTaWU+vSUeWatfufyU6
 zL7QIdqPy/Pf8KE7Sa/QBKTChskXDuknWtrRk+E535J3V4defWdQ2H6Yq8SdAkX5FbA/
 vcFJ7AHqAbvH9PWfwAoF6wuVVK++Ylfy6roNt1X7U6UFcGLG++jmzTWFJzdCEKG5gdGc
 Xv7tBdowtL9uICA3YbISR5cCCpvhAcSCxvJeM5zOIelGUhDkvXuvLZ04QI+OIZPv52yZ
 ulrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzyPEgtoGWOrPRCkXb9WTT08ZPMa6jT6gmJRaDv8Ag/h5rpsmuDVoK7I/3/2U870OV6y7XofXNjDc1@nongnu.org
X-Gm-Message-State: AOJu0Yy2RKv8Vd1Mvf9r9AUtmR8fFHdxqpI5mPCcyNp9Gv/yQ1NpJdyy
 KZQRBE6Ig65+9PmA43nrGOTh8MUJj8oHBjPdpiz2JVMDK5fP7AggPWty
X-Gm-Gg: AY/fxX5v/YUrIm2+T59t8LQ4AO6qc9oF5/QB1scuxwQqMzx8eFJ/SbF3/JHIPLoaWD/
 6QErMXSTqI2QkwsaEevdrADSuYjt0uZIDpC9CGOmqyJbbP9k/Ch0P0n3QGIJldiCkwHFDFy+2rN
 eIcphLUUALTkhsGDgrNAViCYGAoK5t/KieSxRsd7lnZmhhn/UjntGA4qKO4RBOMMwQZoyxBIofS
 cJucFcqEII9v94OSrbd8kTZvUSJEjWgXMZzcBQeE4ETO68xXtzFaciAaVZJfHGHHOjjoXhBZvPv
 alDvYvaeIqJ6akoG4IWfQK7tEzL9fhIljWkztK7JPQnRy5aBre/zNOo1kTTEyYpO3YYAVGi6aJ5
 KE9L/w3EwzNLnM+y0M9wfKDYqTKVTiOoaug8L4uXNesx3a1o4z90oIxA8b1umnO/XvjVYuzUIMA
 OjeAmLtbYOV3Xa8DltPl/3
X-Google-Smtp-Source: AGHT+IGrB+kiK1RF72xLNXdHZRVfFJCUN6f0JdD3GUo5K5pWCW54GrV1ymfNOVgL0jNsQMtaXjLuEw==
X-Received: by 2002:a05:6a21:9989:b0:352:eede:89cd with SMTP id
 adf61e73a8af0-38982277ec2mr1642800637.17.1767679049353; 
 Mon, 05 Jan 2026 21:57:29 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f60178af5sm460222a91.3.2026.01.05.21.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 21:57:28 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Chris Rauer <crauer@google.com>,
 Vijai Kumar K <vijai@behindbytes.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 03/16] target/riscv: tt-ascalon: Add Tenstorrent mvendorid
Date: Tue,  6 Jan 2026 16:26:43 +1030
Message-ID: <20260106055658.209029-4-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106055658.209029-1-joel@jms.id.au>
References: <20260106055658.209029-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

JEP106 has two vendor IDs for Tenstorrent. We will use Bank 16, hex 0xa1:

 ((16 - 1) << 7) | (0xa1 & ~0x80) = 0x7a1

Add it to the Ascalon CPU definition as the mvendorid CSR.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 target/riscv/cpu_vendorid.h | 2 ++
 target/riscv/cpu.c          | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 96b6b9c2cb58..6a5c2491b923 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -7,4 +7,6 @@
 #define VEYRON_V1_MIMPID        0x111
 #define VEYRON_V1_MVENDORID     0x61f
 
+#define TENSTORRENT_VENDOR_ID   0x7a1
+
 #endif /*  TARGET_RISCV_CPU_VENDORID_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 01bd522f9189..b8b64284a281 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3187,6 +3187,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_svnapot = true,
         .cfg.ext_svpbmt = true,
 
+        .cfg.mvendorid = TENSTORRENT_VENDOR_ID,
+
         .cfg.max_satp_mode = VM_1_10_SV57,
     ),
 
-- 
2.47.3


