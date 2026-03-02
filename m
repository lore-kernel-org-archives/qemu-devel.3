Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E8AD58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyzU-0006MS-HV; Mon, 02 Mar 2026 03:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxI-0003KP-9C
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxG-0002Fr-RO
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I6/bq4+YkLb97SUzRVOI1Wb1iLfHZWsSp+w0aut9ac4=;
 b=XpkKGm7JzQowz9ULK5aGh/XZO3tBINp2ApcQUKgQHUY6wQOFELTTH4hErF+tVOGsi8JAvy
 PH25StTDy1lMNrs8hmV1FReQUsmI4N1wsdbljlfUjVpCYRKA8GQPLJNh9bBgbuymxrtUqb
 naqcjYgwf/s+TlRW/uSS1FNFltbJHzw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-1HMvWPS4NJmghGrfhX81ng-1; Mon, 02 Mar 2026 03:48:40 -0500
X-MC-Unique: 1HMvWPS4NJmghGrfhX81ng-1
X-Mimecast-MFC-AGG-ID: 1HMvWPS4NJmghGrfhX81ng_1772441319
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439b484ee04so485044f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441318; x=1773046118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6/bq4+YkLb97SUzRVOI1Wb1iLfHZWsSp+w0aut9ac4=;
 b=sYQMwwpOA/IAJINouY1Jx20zYNLY2tahz8P2Wf5AlIg+Aox3zXx9ry+ZMWA6l+SObp
 vw2d+hxWHlNEPgECGNGEXfxeD7wwdGDItEosHdBeh4VRRvHM4+Qpq6IZYTAwL6RNDj8h
 Rkk22cJ+Oe2ivsRFEfH9TBE3MG5+8cM/n9/0nMNn7yN0WoWFLAo6e/Dn8lrtEnPkftCG
 8NnuVvy9jyvo3s49QGHUJJlZ+zZGSWwhOgIvb+gC8XDABZUm614nVxDHzeXc3pTrCsd1
 eVeXLc5IIB+KR3oYBJf88DyFR5WJiFRUiUZOZQSMyKqZDwri4csinF69dK7/W3KoXJVx
 Drpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441318; x=1773046118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I6/bq4+YkLb97SUzRVOI1Wb1iLfHZWsSp+w0aut9ac4=;
 b=SgsuyNmQhp2MUNARLTwhnYBowl/8BovEMPoCkYZyQ4k9hc4R8tbGyzspa9qadZ1U0p
 oFSGsyj8ZIcFe1s5NKLNmTSJR8A8hOmSDWIN2qxKQFz5zar+tB+7P0Fp/qDGgak+3DXe
 FV4BbmVtPTco6QLXHflse+kjzpEQ75ouMAyPZX5+dHu6IzWtK8aQ/O5NOhWRfYJbqqN6
 wh6FWEwp+q9ELh2SsmA/RxzwYcTZTWhQYTESJSpMs8Lnw24DgI9jRtl7cfnffkM5ZuKM
 Id6gno8R8sBEA5OXywaAOpTx7xFgExCPAgCBeHvRykgqIHwAgvjucQH9QT/n9+YccSaT
 vnXg==
X-Gm-Message-State: AOJu0Yw6XlHTBQ4qGURZ6HLhvzACBa4XAhxaGfGFJmS9ROHYdJRBUK6N
 DdevyFCPVY1c2f4HM/1nGgOgZNTypsCVNwvdnORh0cX8LBtsXxR4EMf3eCb6N5PFwRDbAwUXnPU
 CH4dhuSSmg3gIjaVW/fEjOToxuOrR2WZSA/btwbXdS8JkQV8Oj1gkeBk0wrpIG4ZM/zOLvLLo6G
 kbQ//fR6bNhD7KD1DpE/r1TN++jiK1Bck5GKSbwqGd
X-Gm-Gg: ATEYQzxPmAzJbsrXO6ejUwMmy6wGtIE3GHqtfkjTaaMAbKYbdqxFQRUHK7PqQVqHIJZ
 wSQn+6jZ+nUu8X3DGjZBB5HbjeTy2Xq93OPw9mq++jV3E1vQ6+/MdBk2ePoemWI3uVtJ1wT7Fls
 dsJ1LjS95dcYpcSQMTyCiJQktB+NC/orsexBKR+19RPJIfODme2DVE7ajVai7wpkCDXTAhvivQo
 +PO/SMWZ7zNeKC6U2bzyhQ0tFkyi4U3oYD76lw0H6Jk7aMQ2wm4m5FycglfuYYmlMHTOlNpPgx5
 eOSXVqjuB5McMSqKayuKso2Vw/z+GCYR2diTHgjq+wUsLELVPa6nNEggfzCA0R4Q3dKFoq+yVKj
 zfP+J8Ui8tElat3zwXIcEw8Cnb7A813lUAgHqaJlKkRUpidqC0UDxpRLy+xOqy6t5c9xZKDuKLj
 eaYiw8pBjM7bBLphb3REEDFBFDSe8=
X-Received: by 2002:a05:6000:2689:b0:439:b69b:3c8d with SMTP id
 ffacd0b85a97d-439b69b4206mr5308545f8f.13.1772441318197; 
 Mon, 02 Mar 2026 00:48:38 -0800 (PST)
X-Received: by 2002:a05:6000:2689:b0:439:b69b:3c8d with SMTP id
 ffacd0b85a97d-439b69b4206mr5308489f8f.13.1772441317625; 
 Mon, 02 Mar 2026 00:48:37 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439af926c53sm14131735f8f.8.2026.03.02.00.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 085/102] whpx: x86: kick out of HLT manually when using the
 kernel-irqchip
Date: Mon,  2 Mar 2026 09:47:31 +0100
Message-ID: <20260302084749.474955-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Otherwise, interrupts processed through the cancel vCPU and inject path will not cause the vCPU to go out of its halt state.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260226181930.53170-3-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index cfc63065807..51ecc9531fe 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1468,6 +1468,16 @@ static void whpx_vcpu_post_run(CPUState *cpu)
         !vcpu->exit_ctx.VpContext.ExecutionState.InterruptShadow;
 }
 
+static void whpx_vcpu_kick_out_of_hlt(CPUState *cpu) 
+{
+    WHV_REGISTER_VALUE reg;
+    whpx_get_reg(cpu, WHvRegisterInternalActivityState, &reg);
+    if (reg.InternalActivity.HaltSuspend) {
+        reg.InternalActivity.HaltSuspend = 0;
+        whpx_set_reg(cpu, WHvRegisterInternalActivityState, reg);
+    }
+}
+
 static void whpx_vcpu_process_async_events(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -1775,6 +1785,25 @@ int whpx_vcpu_run(CPUState *cpu)
                 cpu->exception_index = EXCP_INTERRUPT;
                 ret = 1;
             }
+            /* 
+             * When the Hyper-V APIC is enabled, to get out of HLT we
+             * either have to request an interrupt or manually get it away
+             * from HLT.
+             *
+             * We also manually do inject some interrupts via WHvRegisterPendingEvent
+             * instead of WHVRequestInterrupt, which does not reset the HLT state.
+             *
+             * However, even with this done, if the guest does an HLT without
+             * interrupts enabled (which the test_sti_inhibit KVM unit test does)
+             * then the guest will stay in HLT forever.
+             *
+             * Keep it this way for now, with perhaps adding a heartbeat later
+             * so that we get the CPU time savings from having Hyper-V handle HLT
+             * instead of going away from it as soon as possible.
+             */
+            if (whpx_irqchip_in_kernel()) {
+                whpx_vcpu_kick_out_of_hlt(cpu);
+            }
             break;
         case WHvRunVpExitReasonX64MsrAccess: {
             WHV_REGISTER_VALUE reg_values[3] = {0};
-- 
2.53.0


