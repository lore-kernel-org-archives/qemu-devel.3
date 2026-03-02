Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56365D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyze-0007kj-Cx; Mon, 02 Mar 2026 03:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxr-0003hV-7a
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxp-0002J8-F9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FmDo2JQxyjuf0TSx31It8W03rDTxn7zYL46HcT7TvQI=;
 b=KcWZQeYVRjd1P52OTGECWUHiFhpKAGef8zRntFY59ibhwaIxZjBORI+UvisN5z/lQ85F7q
 SnC6dpeo/DzyRiHzkYA0xOGRghL2CsIZTX0iRB6lxTfgl8OLbzw3OE54mURldTrYh9JXmK
 xi5Hl7hZg+H86WKULPxaFKa1bOSS0T4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-p0jYy8fWPuOxn7r2KZuCHg-1; Mon, 02 Mar 2026 03:49:03 -0500
X-MC-Unique: p0jYy8fWPuOxn7r2KZuCHg-1
X-Mimecast-MFC-AGG-ID: p0jYy8fWPuOxn7r2KZuCHg_1772441343
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4832c4621c2so46309155e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441342; x=1773046142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FmDo2JQxyjuf0TSx31It8W03rDTxn7zYL46HcT7TvQI=;
 b=A0ME94SfKOq9o9XL3riIGeFcW54qkNrSxN7yz5dU8PSODJsvGKw0kGZAFfXZSioevH
 nspAhCQ85eEut7U8SzIbiBP2b6FzE/4Lr6Kdvqfg8ieBz+ah2U/DyhjSDnpsL/+RjFKo
 Xf1u0jf18ZKXGWqpSbfGxwC9HBcFMZF+fIun7/3bo3Gx+2+w/uRRsPN7giPVrT3xq2NE
 P3fIpLTrnUh7EFJtQwFwqWCee2ndXZH7O5ZGkRn3WG3zuTRF6ebPNBRFyqZNglbRXU2c
 8M7g6o5wBWWd042ndTWr49nrw4vhFlPGQUM+B5WS/jDL1P2NcSoqmOwTRp/UU6Nw3ZpZ
 /dsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441342; x=1773046142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FmDo2JQxyjuf0TSx31It8W03rDTxn7zYL46HcT7TvQI=;
 b=oSx/suewtKookynpnLnDKDigANUBheh8aYYhu3OSWiDm5g5itfHewOPsucWTmoMVtX
 KZDU5Y7QrTvbNTFBwX1g680cEXfWiGHv+OXOGp1bcrpACkNiiY6tSxX2RWLgOZvIK0ao
 Tc+7xde2SI0FypILaanASJo+Nti6H1d455mGiUHwlV9xQ8w+nQoBylQkFWkDgfmUZplc
 w8Ar//1hH7+UO52bLGsGz4PTFat6CwQAUeZ6LpafDkV9IkemyqHrGRXno4N0opJHvmHQ
 rqFt4B+JEQ7AW2TPloIr0nvMkTsQ5tqIoV510V2fQg/PQ1q5jduzDLGGbDEr8A49FTrd
 pIHw==
X-Gm-Message-State: AOJu0Yw4u4U6AyxLo+GnsZBQMQaLIiBHvy2YQDcXZDTstN8/PWpx/TL5
 rcTBcMrWIcGyeRY/2oYVKTaXJRMQvXnBewcLyx5VUOei76LQw+6aW+n3b1iNv7hXIXp0NflK7fT
 LjvgZWjI2MxlY/W/nUsgU0Bvy/Q8IT5deAtjHxw41X3l+86XOysC8lQJjG9kwYCkn25A1PFYjNO
 iZhin4B7UFYYrgiy3QTWtYqMUGMp02/AHL0LwShgY7
X-Gm-Gg: ATEYQzz6Kjbj4fNtMMFboPuNmbUngU8FZdro4bVK/QY1H83KUrlvmRdZ538wNIrnDhD
 HrniBESlikFKllOayv8gTfaRmvHyHw+84DB1fDWZeVirtDkEFFN4sh0A3pmeas1AcTbAw6Dq+uY
 G9QDe7ORjeotlb64tpeEveG/7r5/ywulMcOSf0S0LAoO6tJDAniZTnlLW0p60a3zxyFf+EfQzLH
 n2mxRwQ2AJ3ok2OV/m3zbw4DtI3M3blWw48Ci4/zLuyewabFCKslCDw3RrqWLhrRjsM8DD1IWLh
 FzK0ubKFhJX+IbmHvE98dC4Ua3TPfMd3m2LWT7ji65YOg46qfUyT8qalyf/SRobFtpiBgsriYw7
 SbWMpEOcfPCEuouXIXuPIJNBa/VljH/ZhGmQarEGf7sqsqbERax5QpJfX1OJjwtd591JTCRjw5Z
 YcIkFGfxZhurNDjBRUv2ubLwLaFQ4=
X-Received: by 2002:a05:600c:3509:b0:483:c3f3:1dad with SMTP id
 5b1f17b1804b1-483c9c20d75mr174319175e9.34.1772441342141; 
 Mon, 02 Mar 2026 00:49:02 -0800 (PST)
X-Received: by 2002:a05:600c:3509:b0:483:c3f3:1dad with SMTP id
 5b1f17b1804b1-483c9c20d75mr174318845e9.34.1772441341642; 
 Mon, 02 Mar 2026 00:49:01 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcbd781sm233715205e9.8.2026.03.02.00.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:49:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 095/102] whpx: i386: move whpx_vcpu_kick_out_of_hlt()
 invocation to interrupt raise time
Date: Mon,  2 Mar 2026 09:47:41 +0100
Message-ID: <20260302084749.474955-29-pbonzini@redhat.com>
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

This fixes the sti followed by hlt kvm_unit_tests.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260228214704.19048-2-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 49 ++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 51ecc9531fe..f12e621a412 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1323,6 +1323,16 @@ static int whpx_handle_halt(CPUState *cpu)
     return ret;
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
 static void whpx_vcpu_pre_run(CPUState *cpu)
 {
     HRESULT hr;
@@ -1406,6 +1416,17 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
                 .Vector = irq,
             };
             reg_count += 1;
+            /* 
+             * When the Hyper-V APIC is enabled, to get out of HLT we
+             * either have to request an interrupt or manually get it away
+             * from HLT.
+             *
+             * We also manually do inject some interrupts via WHvRegisterPendingEvent
+             * instead of WHVRequestInterrupt, which does not reset the HLT state.
+             */
+            if (whpx_irqchip_in_kernel()) {
+                whpx_vcpu_kick_out_of_hlt(cpu);
+            }
         }
      }
 
@@ -1468,15 +1489,6 @@ static void whpx_vcpu_post_run(CPUState *cpu)
         !vcpu->exit_ctx.VpContext.ExecutionState.InterruptShadow;
 }
 
-static void whpx_vcpu_kick_out_of_hlt(CPUState *cpu) 
-{
-    WHV_REGISTER_VALUE reg;
-    whpx_get_reg(cpu, WHvRegisterInternalActivityState, &reg);
-    if (reg.InternalActivity.HaltSuspend) {
-        reg.InternalActivity.HaltSuspend = 0;
-        whpx_set_reg(cpu, WHvRegisterInternalActivityState, reg);
-    }
-}
 
 static void whpx_vcpu_process_async_events(CPUState *cpu)
 {
@@ -1785,25 +1797,6 @@ int whpx_vcpu_run(CPUState *cpu)
                 cpu->exception_index = EXCP_INTERRUPT;
                 ret = 1;
             }
-            /* 
-             * When the Hyper-V APIC is enabled, to get out of HLT we
-             * either have to request an interrupt or manually get it away
-             * from HLT.
-             *
-             * We also manually do inject some interrupts via WHvRegisterPendingEvent
-             * instead of WHVRequestInterrupt, which does not reset the HLT state.
-             *
-             * However, even with this done, if the guest does an HLT without
-             * interrupts enabled (which the test_sti_inhibit KVM unit test does)
-             * then the guest will stay in HLT forever.
-             *
-             * Keep it this way for now, with perhaps adding a heartbeat later
-             * so that we get the CPU time savings from having Hyper-V handle HLT
-             * instead of going away from it as soon as possible.
-             */
-            if (whpx_irqchip_in_kernel()) {
-                whpx_vcpu_kick_out_of_hlt(cpu);
-            }
             break;
         case WHvRunVpExitReasonX64MsrAccess: {
             WHV_REGISTER_VALUE reg_values[3] = {0};
-- 
2.53.0


