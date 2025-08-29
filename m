Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CB4CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNNz-0002iW-32; Sat, 30 Aug 2025 11:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us12b-00010U-Hj
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us12Z-0008Qy-Cn
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756481362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WL2tlaGqHqkD6S6Lrl1Huap2Hah7Qy/PDV3OtD7Ozd0=;
 b=WsrOd7bercMFepr4VkZOvxbBv9MqPSyMIJBi8yRtb3QLKEeA0ysaWRB03Vrjp4l+2PeGkg
 Bx3gZFxvwGjL8siRcv/bO3JcM0B0mDBT8jyzL6L+kuTV86PJSHwqxjRAnOEMDi6NUIjjvl
 u222EhUmhHwn57aJ9LKPVU44MD7rb88=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-FIbNW-z3PHi8XV3uqgFd5w-1; Fri, 29 Aug 2025 11:29:20 -0400
X-MC-Unique: FIbNW-z3PHi8XV3uqgFd5w-1
X-Mimecast-MFC-AGG-ID: FIbNW-z3PHi8XV3uqgFd5w_1756481359
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3d1114879a4so332846f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 08:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756481358; x=1757086158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WL2tlaGqHqkD6S6Lrl1Huap2Hah7Qy/PDV3OtD7Ozd0=;
 b=nNO2jWl196g8tnpVUMgFC/X+5nCXQJSDNVovhd0QdNJwgD5HJsfxuaXerJ9yw8zJHV
 YjshfNtd/5FC9S24rOOEgdo3WQGzmcwsXL1jSrfnxLmCww9FmdC2czOTQMW2mDuTdLAv
 mY39JnBbngA7ReDX+j+j/kM5ALdmYCHTEbENV/QVpt3BSbNjOd7OskkhuklYdS+oCID5
 u59DeJNfwROym/LHUJ/72OrYjgVX/PsGnkmLbv9BpQOtYeYR032e92cJVbCAQy8Bf4YB
 i+inzgVuhc+f/KST6yzC2L6c4pCUAm21sFJE6N6o+YtcKEH4MPzFe4DCyNxY8Qh16sgC
 ZovA==
X-Gm-Message-State: AOJu0YycUGMrINYpXy1Th7mE3k89AinRoA+KbDvpUltUBgNAk00yVOQc
 CP07NDzEbov5bwbPWOf2pq54g+k76ROSvKZ0NzL+iuqgF3mi2efBZRqoscn+8KskDiKbwt/HjGF
 3CByZbvpj80AkhlmV3T8VuNgGZpYsQTs3aaFX7+69hbmZtYYWc8bwkOaIFV7/QPAmMFrfVtBdYs
 pSh0Gkk/SRce3rPjKaMmTvfYMJVLTRVYKi8OPcZVpG
X-Gm-Gg: ASbGncsebunatwK2Zj+MwRjO93OEZHiMdsqZoVjQX+5ICwowTSv3888s5Q2skm7RLxP
 jwjz2U/y7WVqLMGAkDKGRv0ikYP5cZRF8AI0uqOajCQzXcoXBdaSq/LFEeGFlkCBl/om1iVXhPv
 3V14jBMv77SIkC2ZnPlsP0+fQaEgrQ4Q+vkagd3JmdGlN6S4uiX6qup9YlgnDkPaBrp+qgQILkD
 eITjWOftcyh+nCIQ3HkYCRyxuA4sbHFZuZNixdBuSkxGM2JLcV16SZgSF2oB2PVGrNdIzHjp+jC
 EV2dH8ZqGkuQepXPuPkU32IKdMPozm3/ud6V/sQAcKYBi5KYj597SDP0lJBx5vrtPSLDXqCaNfM
 tZuQbkQuKOCceQybdv6kv28VhOaQZ69tPX3H0yRDkJq0=
X-Received: by 2002:a05:6000:1250:b0:3d0:bec0:6c38 with SMTP id
 ffacd0b85a97d-3d0bec06f6emr1724579f8f.46.1756481358038; 
 Fri, 29 Aug 2025 08:29:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfR9ms83Q1p2WDefcpnExj5uUYceOM+YZGUoQOIO+f9yXDH8ZhdO2n0HppNIvPMJM5Avpkmg==
X-Received: by 2002:a05:6000:1250:b0:3d0:bec0:6c38 with SMTP id
 ffacd0b85a97d-3d0bec06f6emr1724560f8f.46.1756481357617; 
 Fri, 29 Aug 2025 08:29:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34493bbbsm3759778f8f.60.2025.08.29.08.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 08:29:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	richard.henderson@linaro.org,
	imammedo@redhat.com
Subject: [PATCH 01/18] target/ppc: limit cpu_interrupt_exittb to system
 emulation
Date: Fri, 29 Aug 2025 17:28:52 +0200
Message-ID: <20250829152909.1589668-2-pbonzini@redhat.com>
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
cpu_interrupt() in qemu-ppc* binaries.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/ppc/helper_regs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 7e5726871e5..5f217397490 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -274,6 +274,7 @@ TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs)
     return (TCGTBCPUState){ .pc = env->nip, .flags = hflags_current };
 }
 
+#ifndef CONFIG_USER_ONLY
 void cpu_interrupt_exittb(CPUState *cs)
 {
     /*
@@ -285,6 +286,7 @@ void cpu_interrupt_exittb(CPUState *cs)
         cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
     }
 }
+#endif
 
 int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
 {
-- 
2.51.0


