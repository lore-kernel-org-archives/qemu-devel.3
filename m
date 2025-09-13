Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75216CAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLL1-0005ol-74; Sat, 13 Sep 2025 04:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLKz-0005o9-Uk
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLKx-0004tc-S4
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OhCG+WyJrPhBH4S92lRWZ920ib0X1m6ZPw+jICRCIIg=;
 b=CVBKb/ds38ETLMqAvz75rHe5AW75KT+s0lmB8aQnHCTXolb1gazN3bpWSyEdpOc/TGD3PQ
 lxqNlabDFhpL6Bu12VkYsJ4jYL9iX9nW1WVOS/ynZwPRq3TXeI1aELf6xhrVjoWlUqAla8
 A6JJsq3VznxjHrx7d8gXMgamYX5MT7Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-wRG_nrDzNY2vxp0jXm9pcA-1; Sat, 13 Sep 2025 04:10:21 -0400
X-MC-Unique: wRG_nrDzNY2vxp0jXm9pcA-1
X-Mimecast-MFC-AGG-ID: wRG_nrDzNY2vxp0jXm9pcA_1757751020
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b99c18484so9752045e9.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751019; x=1758355819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OhCG+WyJrPhBH4S92lRWZ920ib0X1m6ZPw+jICRCIIg=;
 b=xB+2l3V25ZQPgZfXkYW5fYejTMDctkts2EtauZwjtY6kGpgpKwyoveKH2ipSwzD1NP
 Zpaxpc6ZSpk8OuzH0Bf44Yqx1mI4NZmy7z8JRmBwnZ5sBi28lOavc2kDxRU0k5qBu7BA
 I5M4uVH++TvUzT6ANHIzfcPs2GzA5tAcAQp70cwnvLPPPga9f8AZxEYdWmnP4d/6m9BY
 Xm/N+YYFcs70KGnR+2fgoOYFAyI3DKDy6he+EW48WN4uiqOGr599n5E/OTB0PZR9OYAm
 eat1WrZltljdY1IDm+er/4cXY263fJ0oEUaZiJknk28C9fhmgxJrzdO+gTc+Cri5EGQI
 GY+Q==
X-Gm-Message-State: AOJu0Yx/VeVqLn127YZ6NKS2RNxS/LfyTMazSxH4YBSqTbCdeNNatgtZ
 xIvSU/i+pAyiT0kqA6215Ba3ALtk8FRqM5KBNsanDUDfryNlHLXG90bU0EjhOp3/9GjEEXzWYsA
 cJNWIMJNIABXBodD02ZznvMwe+vvqnS2e5wWIW7UbLYYT+xTaLjr420/raLrbKNbbVAkruABH9A
 tPJt2CTxm0WCx4s5WqDIhZuvLcDH98GEFsue1gxv2f
X-Gm-Gg: ASbGncuylxE2Doxh7elPcOaaIwFcHHU/1Tff0IBSbiQrurWTz8zG8KQ/zfwF9wC+bHx
 IfSEAn0W1UHCU1GcDEHTVd3xMKVZldy8ZU1zI0VIXNg/buPWwyShz5Tep5H9hfjlz0y6ETd+uEb
 wqWa5ik3ouXK2Vsj3z0qUtWq9sJkRwRp9z9LqVXkUi5VqrwaltRS0LRJ0uS+ORXo34JBWd8YSYy
 DdveWUU+uf5IfRzOlXXEUmGFNnX4uRh36PjwmQMIoTeeGq857BMkj+1oeH4rnpdc+Hdtqx2j/mu
 Tzhn07HVwEby1o7yFLYWNiq1xhKZ+vW3VMmJB0CEN6nJK0eX4F3KDhmZjGr4QXB4FMR89Yuw3Wm
 Gg5lFFcULp3h3lQ+rlvEKkFZN+IW5zmpYWEsWuKGJqgA=
X-Received: by 2002:a05:600c:6044:b0:456:29da:bb25 with SMTP id
 5b1f17b1804b1-45f211f8e90mr34817255e9.19.1757751018885; 
 Sat, 13 Sep 2025 01:10:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtiew4Zhoaexs0obWQaITl9KRQDaZU7Lc9HmMnazY0lKjJKaIM6LTlHs05J5ThyRhkjXtR0g==
X-Received: by 2002:a05:600c:6044:b0:456:29da:bb25 with SMTP id
 5b1f17b1804b1-45f211f8e90mr34817055e9.19.1757751018491; 
 Sat, 13 Sep 2025 01:10:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e016b5c5dsm93721635e9.14.2025.09.13.01.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:10:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/61] accel/tcg: inline cpu_exit()
Date: Sat, 13 Sep 2025 10:08:53 +0200
Message-ID: <20250913080943.11710-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Right now, cpu_exit() is not usable from all accelerators because it
includes a TCG-specific thread kick.  In fact, cpu_exit() doubles as
the TCG thread-kick via tcg_kick_vcpu_thread().

In preparation for changing that, inline cpu_exit() into
tcg_kick_vcpu_thread().  The direction of the calls can then be
reversed, with an accelerator-independent cpu_exit() calling into
qemu_vcpu_kick() rather than the opposite.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 9241bcadb5f..3ae545e888f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -751,7 +751,16 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 
 void tcg_kick_vcpu_thread(CPUState *cpu)
 {
-    cpu_exit(cpu);
+    /*
+     * Ensure cpu_exec will see the reason why the exit request was set.
+     * FIXME: this is not always needed.  Other accelerators instead
+     * read interrupt_request and set exit_request on demand from the
+     * CPU thread; see kvm_arch_pre_run() for example.
+     */
+    qatomic_store_release(&cpu->exit_request, true);
+
+    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
+    qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
 }
 
 static inline bool icount_exit_request(CPUState *cpu)
@@ -780,7 +789,8 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     /* Clear the interrupt flag now since we're processing
      * cpu->interrupt_request and cpu->exit_request.
      * Ensure zeroing happens before reading cpu->exit_request or
-     * cpu->interrupt_request (see also smp_wmb in cpu_exit())
+     * cpu->interrupt_request (see also store-release in
+     * tcg_kick_vcpu_thread())
      */
     qatomic_set_mb(&cpu->neg.icount_decr.u16.high, 0);
 
-- 
2.51.0


