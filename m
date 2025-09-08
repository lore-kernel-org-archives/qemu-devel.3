Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB20CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYsH-0001ny-Ev; Mon, 08 Sep 2025 06:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsD-0001fC-JK
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYs8-0000vg-UQ
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQOby/BAJBGzsbQkEY5z4jLqdBepsOlgz7xz91bkfdo=;
 b=KYdeho8FpXcbvinctSzC61DoMX1vtzBhYMLqyp3BggyLETUxO5NeGsjEovARvMzTFUrNup
 2VoQW0ZdGf+m/FFHsyUPsHxt01pOwFbO/ANO346hd8Pk5GT37Uto1a5KmT/ylui/vBExj5
 B3QM83AXQEkh2Xu5QfrrAWpQXTan+Hg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-CxJRifP7OpyFDljCJMssrA-1; Mon, 08 Sep 2025 06:13:04 -0400
X-MC-Unique: CxJRifP7OpyFDljCJMssrA-1
X-Mimecast-MFC-AGG-ID: CxJRifP7OpyFDljCJMssrA_1757326383
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3df07c967e9so2698809f8f.2
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326383; x=1757931183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQOby/BAJBGzsbQkEY5z4jLqdBepsOlgz7xz91bkfdo=;
 b=fAU7FMmMbBb/9+7krBGJU5o3vHXs0DhojFffO8hthJb4R3AVhQk3N7ANphFU4PmOpR
 TDjFIi9Smd04I1PjVkOhFmcUPsEXaGbK94NCwotFrmCnkL7274ZlnQdsgunaUs08NIl5
 IRuLCZ5suaOGvglV6Ac9XjpdEvempkHZP3UHGnIznS0TeakgoU4XU2IbYX2cC+QseXDt
 cI4VBjJDirB9pK+RM9RZ5wqJAfr/uZm9XxMZ0HNOjvboUz5yVzdc8U+N8JnOFQjS9iGp
 VOlWiDjL8I9mB2ol3yRKc4nQiPEdFrMWEUdcyNBZKiCuQP+4xadrN1hmxMlcu0ZmOsF2
 tRPw==
X-Gm-Message-State: AOJu0YzIhP2igvcKtoeKFL6ho4S4CHXql6108eGWd3Wy/SJ5sq8SUl/h
 EMgyaxQxj4DdWSkleSrUo9JNj+4v42k0UjCnPNK4jmcJCDPdeRIvDAj1dShf+sRXJjYIJ3N8gpl
 J6w2Ls/ywcL/1qKRNnkfWM/1yaodvECb28RPzTBZ7pMMpLjxP8bQCirw5fXCk1vF+9CLiqX9hdR
 QJ6y0IFjJaM9kED1TVB4LTM564XZkOOlw70u6nMXN4
X-Gm-Gg: ASbGncv/E6Jc6hYz9rmGBYLnbWXZqGpd0Fcy9SHk60kmo+pGSvsD7IB90wsQJpp/9R2
 fTWPN+wVilBdpjgGVGNXvMGLAzaSOtCScbWqn8PCETCz19xcZIkXnjHMaH6XFyf7g40+6wcTbIm
 JKRW4syy53VehpOMmFU86C9nLhSraHOvMsLCna8wxRQoni6j1dcRxXAZD3rAl9k0eVCEaKXskLb
 Tk/p9mIEiojUCJVBHCl9y42b7rBIVbqvrPWYt6JXLT7V1KZHqbb72UQsc6a/kO1BZAZ8We80EJ9
 G9Nw/sBjpXkL6cds0luMOZvQzzFqg7VtPxW+u4EUqdWf6BLXZZgAWjHKhZFsTuu817FQXVD0dYb
 J7LaklTlwiSYrEdn37QZhEoWwaJfkePhmmEjkRh9hC9k=
X-Received: by 2002:a5d:5848:0:b0:3e0:152a:87b7 with SMTP id
 ffacd0b85a97d-3e643ff65a8mr4987719f8f.41.1757326382813; 
 Mon, 08 Sep 2025 03:13:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAA9NfZEganxwWt8Y+9YLqjd1kdhFvIouXrHLywH52Vt/8tKXZqML4MpviiyuehGFz8A1ikw==
X-Received: by 2002:a5d:5848:0:b0:3e0:152a:87b7 with SMTP id
 ffacd0b85a97d-3e643ff65a8mr4987688f8f.41.1757326382361; 
 Mon, 08 Sep 2025 03:13:02 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45de229238fsm69845945e9.16.2025.09.08.03.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:12:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 08/19] cpus: document that qemu_cpu_kick() can be used for
 BQL-less operation
Date: Mon,  8 Sep 2025 12:12:30 +0200
Message-ID: <20250908101241.2110068-9-pbonzini@redhat.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 23bd02277f4..8b57bcd92c9 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -829,7 +829,8 @@ bool qemu_cpu_is_self(CPUState *cpu);
  * qemu_cpu_kick:
  * @cpu: The vCPU to kick.
  *
- * Kicks @cpu's thread.
+ * Kicks @cpu's thread to exit the accelerator.  For accelerators that
+ * can do that, the target vCPU thread will try not to take the BQL.
  */
 void qemu_cpu_kick(CPUState *cpu);
 
-- 
2.51.0


