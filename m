Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5839BD58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwytw-0003jl-SM; Mon, 02 Mar 2026 03:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytc-0002EK-Hq
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyta-0001cy-19
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2WdEDDjMaTqiYRF10E9g0Cwhkz1kZFv12Jw8FozsU1M=;
 b=Kor8a+XJq5aMe42ZfWwTQGnRLRpeeE08G70O4sTf+LqHp/3LrfqdnvaE6r6Yt/FG4GGeZD
 8M0L42Tx+lgNpnKuJtuvT9Iy11iROyY2o52eY+fCWQpQNWdPZu10uhLrSaf1W/px5aLg/u
 Dt3zFAvSl8SiU4jHMwXn8MaZZ36Tk+w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-eHDAzD1mM1W-psfUYjozug-1; Mon, 02 Mar 2026 03:44:51 -0500
X-MC-Unique: eHDAzD1mM1W-psfUYjozug-1
X-Mimecast-MFC-AGG-ID: eHDAzD1mM1W-psfUYjozug_1772441091
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439af95a718so1175203f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441090; x=1773045890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2WdEDDjMaTqiYRF10E9g0Cwhkz1kZFv12Jw8FozsU1M=;
 b=nE5wGhfqPzqa0qdL6mhcAyvH84z19uyhMvhxekrCzOZJnxTBpwwSjNz1kQrIZ5IaF0
 3LMhFqt/auaih6LbucXZlq8xtTnuzRR9ATR+YICUW5ApDWJQ6tSoAlulEbW/jJ7oDGWF
 GXva/0mFehTA1GlqPaABGDcrmE/poNvXdg/Wt8YdLapOwPBXmD/vQJzmw0d4lweLCm94
 EmqjoSDATAfCpZzKDhq80jE5LEbDgekebI5YpeEgCkD9OzntFugO0R0RnleImv/OxFYs
 IzmWyWs2PXakC0sVefJKfuacfDz1NE2GRtI+HL0NVV8xg6m77bB5cRyNTnoQau6R0UXK
 F9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441090; x=1773045890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2WdEDDjMaTqiYRF10E9g0Cwhkz1kZFv12Jw8FozsU1M=;
 b=Rl0JsL7V2Z/s/e097vWCeRSMihxUliaRbltPQe5LTKjMPDWBxHd3kFM36kiqHKzL69
 fHJB8DPrEPlPcX/YTRJUQdV+sDFTgP5Iw3YQy96M331lRbV5CPvJIgMNBjD/GifltNne
 gcQLE74QPOOjJk4/VrNDUfhsBOqxXMru06qOPVHZbvOzcWmSwi7Ua95+l7/H736lqSB9
 EzU/QhXDQ9gk/qwhD/8wRQODaunNFmMadYzVuZXLcTJwKHLEIGU+TZfyRqhDxxKFgEU0
 FvhLhK23otkrkACfx9FqQTTfXKEXvN95X/733TdBA3WscrZtozribGE0892mQhVc1OgG
 siYw==
X-Gm-Message-State: AOJu0YyAe7LqWNCuYTajvz/1mh7HaEccvIvKihoapvYMpTIEsiL1cHai
 Efk5hfWzeBTN/mKGO6ZK2igLzB7pJqeiSZdZsQjeJFJbfF0gBdYamj1uXaZQYHGSETdbHNRbeG7
 2E36H7qa/JdG/NxCo/asf7EpTfHD2UpnHO1jHZmwSo5gRnTXtlcnfHTDz4Fp81dwBztxVUanCsq
 ahUdVwK5VTZWn3TxJNAQrPFI3WtSgoY4HK/9lZrMY+
X-Gm-Gg: ATEYQzzavccJKtSamqViXYveQXSg2nW0RgS43Fl+3zhCspAAVPyE07dH5+HcWpC8A9n
 VwYchaatfKy/8JmHq8BztkcttAflG4QGh1AwBlRCp16+0sdoNBUn5VqS+0Vc5veivXdft0NKp5q
 cz1SXOOB/COwCJGJW1IebjKZqFU6az+YOWi5gZlNrXcRyEN1jr7ewcsrQqqWOpOL4pvD1yxKLrO
 7CewHvj8VhTdynhNVpJCjNrfqtV6BFydqu3H+BEEIFkmY5s0heplcVCj+3P1TD0Gx2i1nnZBGAy
 Jn1EYsW7wJzF83K5hTVqA7zJy2ENcv7WZS+rGprTtIA3DNg3tqnBEGNS/DWko/tIENeVeMJk49P
 8uv//cuggLHSr4EM6OBAhhJ0QwhpD1J8u5r/gS9ZUEPHOxbPtMI7urbyblL3tTYx1DUMhClpe0t
 hKh3RiZpSDbO6I5FuyXoEucpBmNDo=
X-Received: by 2002:a05:6000:2c04:b0:439:b486:ba5e with SMTP id
 ffacd0b85a97d-439b486c3c9mr6722781f8f.51.1772441089791; 
 Mon, 02 Mar 2026 00:44:49 -0800 (PST)
X-Received: by 2002:a05:6000:2c04:b0:439:b486:ba5e with SMTP id
 ffacd0b85a97d-439b486c3c9mr6722743f8f.51.1772441089284; 
 Mon, 02 Mar 2026 00:44:49 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b503424fsm9214101f8f.22.2026.03.02.00.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 026/102] whpx: i386: inject exceptions
Date: Mon,  2 Mar 2026 09:42:21 +0100
Message-ID: <20260302084338.473368-27-pbonzini@redhat.com>
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260223233950.96076-26-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 561a48206ca..0259782a822 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1506,6 +1506,26 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     }
 }
 
+static void whpx_inject_exceptions(CPUState* cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    if (env->exception_injected) {
+        env->exception_injected = 0;
+        WHV_REGISTER_VALUE reg = {};
+        reg.ExceptionEvent.EventPending = 1;
+        reg.ExceptionEvent.EventType = WHvX64PendingEventException;
+        reg.ExceptionEvent.DeliverErrorCode = 1;
+        reg.ExceptionEvent.Vector = env->exception_nr;
+        reg.ExceptionEvent.ErrorCode = env->error_code;
+        if (env->exception_nr == EXCP0E_PAGE) {
+            reg.ExceptionEvent.ExceptionParameter = env->cr[2];
+        }
+        whpx_set_reg(cpu, WHvRegisterPendingEvent, reg);
+    }
+}
+
 int whpx_vcpu_run(CPUState *cpu)
 {
     HRESULT hr;
@@ -1600,6 +1620,8 @@ int whpx_vcpu_run(CPUState *cpu)
             whpx_vcpu_configure_single_stepping(cpu, true, NULL);
         }
 
+        whpx_inject_exceptions(cpu);
+
         hr = whp_dispatch.WHvRunVirtualProcessor(
             whpx->partition, cpu->cpu_index,
             &vcpu->exit_ctx, sizeof(vcpu->exit_ctx));
-- 
2.53.0


