Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1A1CA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNOO-00034P-Kl; Sat, 30 Aug 2025 11:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us12i-00013K-UX
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us12g-0008Ru-FW
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756481368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNgAOjWCs/5x+du4tWhOWwrW1a6LaRDy8OpJh3GRStE=;
 b=Jn80kLwF5Zb7mocgauCAlqbG+J4zTR8ljujPbzR29Gv22zdSA7qq2DaVxoYh3wla3C0GXu
 LzuLXe/aF56PGL+QaAmlRptLp6m30qrTJ3sptZRSnxAvqS4tQEXs1s7lWM2CgBxCIQn52o
 hOh2XFL5xz2g1x0Z2SLNRbrqAozIY5k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-hN_7PpLwOaGt1mVKtQTrgw-1; Fri, 29 Aug 2025 11:29:26 -0400
X-MC-Unique: hN_7PpLwOaGt1mVKtQTrgw-1
X-Mimecast-MFC-AGG-ID: hN_7PpLwOaGt1mVKtQTrgw_1756481365
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3c85ac51732so917708f8f.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 08:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756481363; x=1757086163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NNgAOjWCs/5x+du4tWhOWwrW1a6LaRDy8OpJh3GRStE=;
 b=qmwLIfqkvsYXMjgDhW92xWee/bUhyNPte3ot9ZDUVwNtVGTkM3s9ER5w8xBvPlhSnw
 WOlWzTK6fPOUhoGM53di/Waj8RZfQdUT6E4XuEL2Dg18YPp6SsLAAyKEQf+BmAWJm0nA
 dQNFmoW4UbUHTQgEQvurmtnyxE5BoWn08hOL8pbNjU1T9OEEgvsls8L3R9jvu1Qo3FDO
 ZKjgyLmyeMuWYCsWoGLo71V6vVi3+ySKpP4t+GsbaWx+FS9xd4LZN8vDpj6zg0L56xip
 Oz6I618sWuUB8Rv+LlcQ2UdavesXZ963hf87nRd6gEBM/EUW9D0I2HvT08VbJoPjnr2Q
 2MdA==
X-Gm-Message-State: AOJu0YymyHMiJbvGC/g8uF1ZVmH8JggVYGvA0XQXU2/3wHdQ6/z+Z1Hi
 5ZsHGuVn0FAPgft+PzdPpNGglUPLecOu9ZtDJATILjvZQx1P1xybBqNbtI7nsXg7/tDfWW4etTo
 AUpyBVC7Q2Rax8cIIfJH9ffow57yS1Um7crA6BSRQAe2cQk4dftVtRHgWaCCr92Fgk8TgKVhycr
 ESdur27rt++maA4o7QMk/n8hGRj1PJwITuD2NDBAHp
X-Gm-Gg: ASbGnctw0ok64aIKV+lYdQ2TRIBLPRj46+8rhkJSPai7j1Di0oLNaOI9ebIw7FUXtP+
 PPzfaov46EB11GUfcYNmOmzZgZy4BSzT4xvB7Wscw5jxxPtbh7Y13h6MWg1Tb8p55M2qVHSyaP5
 T2r8lToiGXrCAKTIO/xFI9OdCpzIgjYl7DeFmTVUncZ20SJqn3Hs/Fx1XEkdSwGmdjOUQXt6CTp
 odC3qG3EKcl6Jh5fZ63rOAfNKywDFyxZTxuHmJo8tMPowOpDoLjLBOFYxAc9RzwWHOasuLmzCu8
 Zo9IxZruZuBuNg6xhHpNxGfS/kImj8HEXlLv9GSgu9KqdSsgULooUnBPykAlOo3vbhyhYCb+i9C
 TTtIaFkzd75S2ylvT6T9v2P7D3evbHQoApw5EupW4fD0=
X-Received: by 2002:a05:6000:4011:b0:3d0:bec0:6c35 with SMTP id
 ffacd0b85a97d-3d0bec06f52mr1855122f8f.34.1756481363410; 
 Fri, 29 Aug 2025 08:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsg7XggQRabDkBwXlftYGPaVsm/2wzNVNViFlNDAwMtSIvJZzTuK7JbJKqlaBcHW43n+jmJg==
X-Received: by 2002:a05:6000:4011:b0:3d0:bec0:6c35 with SMTP id
 ffacd0b85a97d-3d0bec06f52mr1855103f8f.34.1756481362963; 
 Fri, 29 Aug 2025 08:29:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f3098c7sm123637345e9.15.2025.08.29.08.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 08:29:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	richard.henderson@linaro.org,
	imammedo@redhat.com
Subject: [PATCH 02/18] target/sparc: limit cpu_check_irqs to system emulation
Date: Fri, 29 Aug 2025 17:28:53 +0200
Message-ID: <20250829152909.1589668-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829152909.1589668-1-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It is not used by user-mode emulation and is the only caller of
cpu_interrupt() in qemu-sparc* binaries.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/sparc/int32_helper.c | 2 ++
 target/sparc/int64_helper.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 39db4ffa70a..fdcaa0a578b 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -65,6 +65,7 @@ static const char *excp_name_str(int32_t exception_index)
     return excp_names[exception_index];
 }
 
+#if !defined(CONFIG_USER_ONLY)
 void cpu_check_irqs(CPUSPARCState *env)
 {
     CPUState *cs;
@@ -96,6 +97,7 @@ void cpu_check_irqs(CPUSPARCState *env)
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
     }
 }
+#endif
 
 void sparc_cpu_do_interrupt(CPUState *cs)
 {
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 49e4e51c6dc..23adda4cad7 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -62,6 +62,7 @@ static const char * const excp_names[0x80] = {
 };
 #endif
 
+#if !defined(CONFIG_USER_ONLY)
 void cpu_check_irqs(CPUSPARCState *env)
 {
     CPUState *cs;
@@ -127,6 +128,7 @@ void cpu_check_irqs(CPUSPARCState *env)
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
     }
 }
+#endif
 
 void sparc_cpu_do_interrupt(CPUState *cs)
 {
-- 
2.51.0


