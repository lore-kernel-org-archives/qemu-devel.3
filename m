Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0F3C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFEK-0002WX-7z; Mon, 18 Mar 2024 11:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFEH-0002G5-EH
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:50 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFEB-00083s-5B
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:49 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so2270407b3a.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776920; x=1711381720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZKKrRbt8NfIdpSLaUG4B3mAPFv2qCZwxs6w2FhzEZc=;
 b=FOBDrnzM6lkcnewnKz4jqJvkT589Jvv7Gqx0Noe+n5BpfhPIpMCr0z9thxdoo94J6n
 EcNvQm32L24Bp5ulKJKRLCA07XCgsBLflyEIjgu/nBmYILnBDvgpCQChvZoU3nlmDxrd
 TSzFbsbrr7wMoOZrEYIcWg5MqooHPBeKycH6LROibR8lKU2/lz8pXqAEBEFMHa+w5ZR+
 Tq6ISgHqvBRYPd8He0EiGVhbxHFI+O5SnxD+wN9fCFlc2Q5AnrhcDUKW/VsWO9U+CbCO
 zl3vlpC7T50qjSdZmDx4jIQSQvQ1FZ12ZBgqo7rHDhEIFzWI7A7br0AxTsz+UXnGFRvh
 DYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776920; x=1711381720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qZKKrRbt8NfIdpSLaUG4B3mAPFv2qCZwxs6w2FhzEZc=;
 b=RDNfZUgUohRSnozZb2eEWWOOp2+qh8KSXAZGnTMe1zzqUJud9/CYltzz5FlghNY+o5
 ohMRrcZVDWbmtMOxVqUYlQyL9Ciiockv+zQAZVFK3PmMRZ6co2R2iqZmoeYfDf9iJBqA
 UjEbZR6CZGhiGcTmPvhAJIoE/U4VGujYm6l7nGTFbT52USZx0AHr3OoN/ijg63QsTkxC
 DS7ILiR8fzJ3kzTnqDZHCW7nKqmZhXe/57s3zJ71MoJdkd/nPZIa9kKPghrO33J6C3rK
 GN+MRNu4Hj+QTxVz/vXhYxyfV5E4bsUcfMTJICRVO8OVqqKM/UtEdPFc7xV9gje79mmf
 TfVg==
X-Gm-Message-State: AOJu0Yy6UnCUnRdrL+5M+5WbxsILSo2/1BiYS06zTiea7AUwvzB87SmZ
 JVSfJeaZU5LqqdYewK0YdBgd6LDbFYhc18BYdUbC+wzrSz0foNyPBJdS3Iap+kE=
X-Google-Smtp-Source: AGHT+IHkAWlKjilg0CXooIlZffDQ1tO1mobBU6pAHFHYVoR2lAQjJVQlhq9Tjq6pPMJGGOvrseaqYQ==
X-Received: by 2002:a05:6a20:325a:b0:1a3:3d58:e508 with SMTP id
 hm26-20020a056a20325a00b001a33d58e508mr11927836pzc.53.1710776920421; 
 Mon, 18 Mar 2024 08:48:40 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:48:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v5 22/24] target/ppc: fix timebase register reset state
Date: Tue, 19 Mar 2024 01:46:19 +1000
Message-ID: <20240318154621.2361161-23-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

(H)DEC and PURR get reset before icount does, which causes them to be
skewed and not match the init state. This can cause replay to not
match the recorded trace exactly. For DEC and HDEC this is usually not
noticable since they tend to get programmed before affecting the
target machine. PURR has been observed to cause replay bugs when
running Linux.

Fix this by resetting using a time of 0.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index e6fa5580c0..ddcbf8972b 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1122,16 +1122,21 @@ void cpu_ppc_tb_reset(CPUPPCState *env)
         timer_del(tb_env->hdecr_timer);
         ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
         tb_env->hdecr_next = 0;
+        _cpu_ppc_store_hdecr(cpu, 0, 0, 0, 64);
     }
 
     /*
      * There is a bug in Linux 2.4 kernels:
      * if a decrementer exception is pending when it enables msr_ee at startup,
      * it's not ready to handle it...
+     *
+     * On machine reset, in this is called before icount is reset, so
+     * for icount-mode, setting TB registers using now=qemu_clock_get_ns
+     * results in them being skewed when icount does get reset. Use an
+     * explicit 0 to get a consistent reset state.
      */
-    cpu_ppc_store_decr(env, -1);
-    cpu_ppc_store_hdecr(env, -1);
-    cpu_ppc_store_purr(env, 0x0000000000000000ULL);
+    _cpu_ppc_store_decr(cpu, 0, 0, -1, 64);
+    _cpu_ppc_store_purr(env, 0, 0);
 }
 
 void cpu_ppc_tb_free(CPUPPCState *env)
-- 
2.42.0


