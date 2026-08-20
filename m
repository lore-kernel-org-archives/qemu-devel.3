Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096D0C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yh-0004GF-SM; Thu, 20 Aug 2026 12:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yb-00043R-A0
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yX-0005TG-Td
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f8clCq896sp1k7uHvjIuVM+wQUp6bOAXBESRx0osuPc=;
 b=Hu16agZtq7TyB6JGN5b+4DsH3x+H3vK5nyrxIF7JKDvshRqNBVmi00qdx+ct0xPJzUelSN
 KMmkZSstsTxGBaQ595Viz8E4teJaE0W05vJhcJgQG0rp3cEFY7+m/iajG6NJdhT9ANV4tJ
 Q0RRX3rhWMqXpp4bsersc03VvXWr0Ko=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-jTSP7zuDNg-XsuvJv2982w-1; Thu, 20 Aug 2026 12:50:37 -0400
X-MC-Unique: jTSP7zuDNg-XsuvJv2982w-1
X-Mimecast-MFC-AGG-ID: jTSP7zuDNg-XsuvJv2982w_1787244637
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-496b61bd846so170715e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244636; x=1787849436; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f8clCq896sp1k7uHvjIuVM+wQUp6bOAXBESRx0osuPc=;
 b=bUCK9hqg+KwqvlrJu2RaUmSLx1lqojIMWOF3uyOgYzZYZ2w9IiAW7gZRqerlN4kq0/
 YYZ1n+RRmrY0rpqzrvk89C5dMRVhl2b7S4u3k7FaYBs/vCh+ZGHHm2wdHUi1QowRA+6C
 QbR3iyEGYgdk3rQY2PAg+CZNB70sl7ElulNl/w1dlTmwM9xGp4fKYiuJrVQzFGRcMJRI
 A72eVp0sor+QqeKtCi3hRcWjzKzlWngDIaY8NqmGT/XygHqjY3mUk7L4Xo7pvE0wo/tc
 QuF/VcBKn9uG2CdM6PvY6WfgaefMyx965c135OjRdW2m9Pg8RaMu4YBNpbLYFYaidXbe
 Xurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244636; x=1787849436;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f8clCq896sp1k7uHvjIuVM+wQUp6bOAXBESRx0osuPc=;
 b=Mm9ciiRJY5O24gW25noGnnaYLmtxJg0gACab0MmtAcVxISlz1eQMeRCLEE3DJ437kD
 xgl4qi8l2Dm4gQVE67Xc/5huv/vB4JqSFcEazmH38i0s4fW9D4+Xl+5siqUE0vr8b/WM
 22IEUz9JPHU8Xie+cLjJDiowD7MttQHZWq71bIPhpxan2yllhG+PVTbokpZnrUPlIe1i
 2EPXN5as+dEbBdG2FooutTvwx4TfgQiDJEeykGwEdL5p7XBfCnsO05znzwDHEFusTvAi
 0BxKBhiJaxfWmXvzSpmQ1TvgLG4oH6LDdrTuenlJjfEX4E1Dnw3CWFmun8V7WcHvt7F2
 b8hg==
X-Gm-Message-State: AOJu0YxccFKgwBm0JcLXgsOg2eSYy5SCEODI00TtP/10AVFlHcStyMA4
 Ps5mRrGeWXABDioA0GKO2dzifdAj7GPVXV4fapTcgtaCBta9SNdB+a92sVRyHZgxRmGkA0JQLgn
 qrt20wENlKP/MJQUzsAwRnsiDWx+37ZQz2tYiNbuGeKtVP3pgmMCqgCmoolF+Ckqecw4kC7u6Xp
 S4+ai8s/yN/RTHAvRjGHhHsQR66p1pKW97OwL04wLS
X-Gm-Gg: AR+sD11c6TObZzXQQ4jP3Ujio/5q6yEl8GY+A0qTjybYkgMjR7XlC1Vro0xGijK9o0t
 LDWeV5voPKVPoKQZ3epj298+xq661zL0mQ7kN4hCtgfj0ihEdzBUoFiwbniDtPsKsd41+wvz+hQ
 vyJp6cHE9/8aob5QuCU7+9zh4OlpewRpR2bDYHkILEBXn45VVPOqCtqymaPVdJZdxPvXcUmu94e
 YSQgJCoPpZdBn+GvbRaKPoDaXYimsE/d5QK36z7Em4s+gzGEQiQ1fDQ4jJhXGn0Jji3bio3h4BK
 5TrNFPyQHHjju29eTsGcvAZQgr7xw/J1HOQ7tPRbgGVQcOD3cLE817+OZA+RfKa/MP8CEZLbT5i
 Df0tBmlXsG5Ij0DK9MiVyzwI53toKzdSyoHM0LQv2EPYWPUWYpJEdLZtV55GkXyG7jDcgv+wb+c
 kFnz8=
X-Received: by 2002:a05:600c:4f09:b0:496:bffb:fb7b with SMTP id
 5b1f17b1804b1-499b8457b10mr3307035e9.10.1787244636535; 
 Thu, 20 Aug 2026 09:50:36 -0700 (PDT)
X-Received: by 2002:a05:600c:4f09:b0:496:bffb:fb7b with SMTP id
 5b1f17b1804b1-499b8457b10mr3305965e9.10.1787244636053; 
 Thu, 20 Aug 2026 09:50:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e78496sm167648475e9.2.2026.08.20.09.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PULL 12/53] accel/mshv: install dummy handler for SIG_IPI
Date: Thu, 20 Aug 2026 18:49:15 +0200
Message-ID: <20260820164957.1895963-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

This is similar to HVF's implementation. We want to interrupt the blocking
vcpu run. The self-kick was effectively a no-op for mshv.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260710101534.664604-5-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/mshv/mshv-all.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 7b3c13cf1ed..f9511ca050a 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -621,17 +621,13 @@ static int mshv_cpu_exec(CPUState *cpu)
 }
 
 /*
- * The signal handler is triggered when QEMU's main thread receives a SIG_IPI
- * (SIGUSR1). This signal causes the current CPU thread to be kicked, forcing a
- * VM exit on the CPU. The VM exit generates an exit reason that breaks the loop
- * (see mshv_cpu_exec). If the exit is due to a Ctrl+A+x command, the system
- * will shut down. For other cases, the system will continue running.
+ * We need a dummy handler to make SIG_IPI a deliverable signal. The kernel
+ * handler will be woken up by the caught signal and instruct the hypervisor
+ * to suspend execution (the concrete mechanism differs between schedulers)
+ * and return to userspace.
  */
-static void sa_ipi_handler(int sig)
+static void dummy_handler(int sig)
 {
-    /* TODO: call IOCTL to set_immediate_exit, once implemented. */
-
-    qemu_cpu_kick_self();
 }
 
 static void init_signal(CPUState *cpu)
@@ -641,7 +637,7 @@ static void init_signal(CPUState *cpu)
     sigset_t set;
 
     memset(&sigact, 0, sizeof(sigact));
-    sigact.sa_handler = sa_ipi_handler;
+    sigact.sa_handler = dummy_handler;
     sigaction(SIG_IPI, &sigact, NULL);
 
     pthread_sigmask(SIG_BLOCK, NULL, &set);
-- 
2.55.0


