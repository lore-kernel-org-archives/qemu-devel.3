Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBB5C25B79
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAQ0b-000546-0w; Fri, 24 May 2024 04:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0X-00050z-Fg
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0V-0000Ma-VS
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716538231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbTLiCeUvWkQ0K+ApblZWP5HmsgfyWXFWN9Nk07xfSw=;
 b=basF5e5V8UWOheFy5oMI3uy5hyr5EnkA4biGDi6D3+OySYq93zyaBg6IQweYz/XUhhjeKL
 k1+0On+AX2T1A0sHPxSxJD0R/nibzkL2ZreyVg2JR/k4sEAZK/96koLfdASwf6cyxxT6VU
 fOqlLxMLf3uqC5bvdY84cfVttQPW8Do=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-2SVnUSDuMEaYdcbK-RlgCQ-1; Fri, 24 May 2024 04:10:28 -0400
X-MC-Unique: 2SVnUSDuMEaYdcbK-RlgCQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2e95a1f049aso5523911fa.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716538227; x=1717143027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wbTLiCeUvWkQ0K+ApblZWP5HmsgfyWXFWN9Nk07xfSw=;
 b=pMbzYGV/3xK1OPdnr82o5aB7N3vvJ5qibCg1+8FkRkF00f18T9+NIQOVlenmbDUH/j
 jHdSVvAUsVpb587IOFkMoIJAALDBTo6cN05bhjYrxvVZ8M3S6F7orKegsYeg+7ge9bYT
 pVM1QeF6WU8ngFejPpvrKbAmc1sU5fhkv8E2AvsDK87NHKRH8xmkqo2ClLJazaLXGSvd
 j7+yaBh2MGogM8Chxn6PYsW+lyZvbxSTZ0V8zBIvdOjrxzf9iknbjoiingiWtfvnQXoE
 hF/Huu2Muixbd2w36cVAJoyU0DxYtx6YEm7XYW8Kn57DRS71OY/x9eQL9BWa1oSpp16r
 R48Q==
X-Gm-Message-State: AOJu0YzwelvuNAi6sIUZDOLXXcpC8wgbTSTiF0Jjl875R0NJDoR802xn
 YXLHXVHNmsTi5dOTyv+xWve/5Ey7NQSQ+vcC4hvnwzStSJ5t3xxSWY72ByaIOChArZmRHnzM1uN
 b7WQo76DJwj9vrsACRAkROibhMhVKU02P0iRGZlxNFIjrRTy714aBsDm5SKQlMIPFzhOoERYW1I
 vZnZ36bsVEKyxJM3mQnMzHSmdzyIglcf94zmDG
X-Received: by 2002:a2e:9f4a:0:b0:2e7:1e4a:31e0 with SMTP id
 38308e7fff4ca-2e95b096f07mr13619991fa.18.1716538226973; 
 Fri, 24 May 2024 01:10:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhOFQEAsml9prPJCio1TD8WXvfG6LQdmw1+r3T3yGeaVrojs7m52NNJD1Ii/nJcT2DOVm63g==
X-Received: by 2002:a2e:9f4a:0:b0:2e7:1e4a:31e0 with SMTP id
 38308e7fff4ca-2e95b096f07mr13619741fa.18.1716538226456; 
 Fri, 24 May 2024 01:10:26 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c97a1fbsm90994066b.92.2024.05.24.01.10.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 01:10:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/16] target/i386: document and group DISAS_* constants
Date: Fri, 24 May 2024 10:10:06 +0200
Message-ID: <20240524081019.1141359-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524081019.1141359-1-pbonzini@redhat.com>
References: <20240524081019.1141359-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Place DISAS_* constants that update cpu_eip first, and
the "jump" ones last.  Add comments explaining the differences
and usage.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 3c7d8d72144..52d758a224b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -144,9 +144,28 @@ typedef struct DisasContext {
     TCGOp *prev_insn_end;
 } DisasContext;
 
-#define DISAS_EOB_ONLY         DISAS_TARGET_0
-#define DISAS_EOB_NEXT         DISAS_TARGET_1
-#define DISAS_EOB_INHIBIT_IRQ  DISAS_TARGET_2
+/*
+ * Point EIP to next instruction before ending translation.
+ * For instructions that can change hflags.
+ */
+#define DISAS_EOB_NEXT         DISAS_TARGET_0
+
+/*
+ * Point EIP to next instruction and set HF_INHIBIT_IRQ if not
+ * already set.  For instructions that activate interrupt shadow.
+ */
+#define DISAS_EOB_INHIBIT_IRQ  DISAS_TARGET_1
+
+/*
+ * EIP has already been updated.  For jumps that do not use
+ * lookup_and_goto_ptr()
+ */
+#define DISAS_EOB_ONLY         DISAS_TARGET_2
+
+/*
+ * EIP has already been updated.  For jumps that wish to use
+ * lookup_and_goto_ptr()
+ */
 #define DISAS_JUMP             DISAS_TARGET_3
 
 /* The environment in which user-only runs is constrained. */
-- 
2.45.1


