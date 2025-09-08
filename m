Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F926CA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYsN-0001pW-SH; Mon, 08 Sep 2025 06:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsK-0001ow-Aq
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsC-0000xh-1L
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OhCG+WyJrPhBH4S92lRWZ920ib0X1m6ZPw+jICRCIIg=;
 b=jGNE7Sky13d10vHjeQWJcjH8GZOI/SukK2gvHDaxmc4ctX9J8UA5Lmctw5IAowEy3Jfkad
 fRphrGUCXB6Q2g4LfWrJpzpTMvSLAEAdzlYjwZlt2GRQO0eoYNBXEDldoehQ5S324DkCdo
 1bY+TpaZK6aepb+Phvd7dwWsRlTz9Ic=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-iw2DYDhJMumy2v0CQpXZgw-1; Mon, 08 Sep 2025 06:13:16 -0400
X-MC-Unique: iw2DYDhJMumy2v0CQpXZgw-1
X-Mimecast-MFC-AGG-ID: iw2DYDhJMumy2v0CQpXZgw_1757326395
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3e5190bcba1so2020220f8f.2
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326394; x=1757931194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OhCG+WyJrPhBH4S92lRWZ920ib0X1m6ZPw+jICRCIIg=;
 b=ZXNF8C2nw+FX8SQGqBSMq8MP1BKui03hVuzTbegwYem2vqkx0cJsNSf7whyo7A8nmm
 4dgWwAkEOb6a12MtooShMloCc2IdSXlmXv1rj5O4gyg79MXf5CPe6RRYgh+2lhNVV1ka
 EN2HUoxwvpT4yu1Njk8cqPLMepZuQ0MnPpjxO9sjKoTnJSBDN+F4R+u9S8EcUGO8rZ2i
 vGDarVKAFZwjBkcQRtAqJ07sdBSi37Bdvh0m1BTB0jjRmXOT4QJLHSGNyFh9Hmya3E5C
 oVqtPS4tGIjYWfye4Qf8QbHKYDtOBYdcuy1gmLKhbfHL/+qoDYMAuXWXVbhe46EEm+c4
 0jFw==
X-Gm-Message-State: AOJu0Yyrgu9nSkQDpSyVx3+tXgppsLmHMKVmV/r0ltTg6P6jQxjwD+CA
 U17+kiRhlLjQRahNc09qTR+5Hcwg0ofjBRILyO+h5Jimc6FvVq5H+UmD/t4l02vbqE/XiWCDm4q
 rnm+iCizk9Lb9saL0E635nKezDhOlzmrPHZELeMwopiU6QKiAWr5cYSPcHOewBq7R2W73JfKiuc
 r1gFE4sIWSryvKiPhYrihqs5TUBZffs2+ZoglklslU
X-Gm-Gg: ASbGncuU96B5H7MPN57rZ2G3NwSeZXfBUpW4vYq27WngkUe4OVVVnUCh25lh2b6/4WQ
 NeheUxvbSCN4n1OCP1ByDPwV5PsBj/l6OKzoqMRzPciTSPv668lp9pdI/f2igyFXvURCfEByB2+
 83tardLpC6Dn22Uhi8mbq56w7B699RImnZc+BD7j9I1jxkqEaW/NSAcEJDZPVfB7OkrQ73aAaGf
 Lf0MCavpxAtA06NIJu5Q5wMqLRyptBOx1pAq/AIKDjp2LtdHNi7sHsuj91rOKSvgpNUPVL5ByoA
 4WKZ5mD9Dnak6SmyC8u8cGTUX9I0U3rUJfnZDm2EVRZRimmI/rSFVwuX0x/NNM321V3OjdlT9Hp
 e/234l5DGd/z929OlGKvgQSpwBQTeAlz3OrKZJyU5jNs=
X-Received: by 2002:a05:6000:1862:b0:3e7:45c7:828e with SMTP id
 ffacd0b85a97d-3e745c78359mr3712388f8f.33.1757326394328; 
 Mon, 08 Sep 2025 03:13:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU5tpEV4AMFi4hXnBISZdBdcMWZfW9rWm4p7JGrFk5S1ueaHFU0CxKzZXpc8jVrrAZqDHijg==
X-Received: by 2002:a05:6000:1862:b0:3e7:45c7:828e with SMTP id
 ffacd0b85a97d-3e745c78359mr3712356f8f.33.1757326393866; 
 Mon, 08 Sep 2025 03:13:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e74b2e0511sm2001540f8f.62.2025.09.08.03.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:13:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 12/19] accel/tcg: inline cpu_exit()
Date: Mon,  8 Sep 2025 12:12:34 +0200
Message-ID: <20250908101241.2110068-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908101241.2110068-1-pbonzini@redhat.com>
References: <20250908101241.2110068-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


