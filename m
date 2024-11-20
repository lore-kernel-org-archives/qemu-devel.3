Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C1ED6E2CE
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDf7k-0001yb-74; Wed, 20 Nov 2024 02:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDf7i-0001yQ-PH
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:27:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDf7h-00080d-44
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732087656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+dgNF2S08viF1uCuG5gYKqJhsXnzXUAgn0oEVa0luo=;
 b=MpsRCFqdzRjVMtV82Cj/yAO7ZtJEBX1CfuXI+X6MNxCbTpIx1fOlVndMqcusgGNFdVbczk
 D9xOxoqf55NggIKNUYIrem8XG4zxZj65fHjcm1D2M5CmLKeVwnbHSbfOBRT6KRqO5gj2L1
 dyezDjIfGYfh2jGN4j166znFbjk9jBQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-DWQrROmfNvK2MW4h1xbUHA-1; Wed, 20 Nov 2024 02:27:32 -0500
X-MC-Unique: DWQrROmfNvK2MW4h1xbUHA-1
X-Mimecast-MFC-AGG-ID: DWQrROmfNvK2MW4h1xbUHA
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-382341057e6so2088870f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 23:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732087650; x=1732692450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+dgNF2S08viF1uCuG5gYKqJhsXnzXUAgn0oEVa0luo=;
 b=cpR2ztegtz/sXlcQbMExAX+Ktp0H+tx9g0VuSfRKfm93TpsdKGuzkU7BdZ68nhX6VH
 mOYbcABGKmPnO1jIJl0nGye6OtaeCQtlLC+A2p61elOBVRo30lsy5cimSfaUUAhK0n42
 TT7a26C5Mbb6UaP3Yd28lz4dAriR4ivJmOwfOONMEkt5oxCPTDkE1ecMXNnrvFu+aWOZ
 jRPGNX7PMn56aO/Ob9KEKglYzIuda450GRYD5yepMAANToavqxmmSs5TL4G8H9friZ03
 ajrMchfJCpai0IbUXHnWTUMUvpNCjhn4XCS9gaEM3M2c+t5pvUZC/vZs4ZHt6i++lRwT
 R6Jw==
X-Gm-Message-State: AOJu0YzaDWHzDlHP/WPubTigj9L2hNjLtiSFpR5yoshiw9D3+VF6AZED
 hiBE+XXRGQFCum5gN35tNb7sagAXJQqcoNIAlOFQHNeL7m8x2gvKWl5z1/5/hrBSqadYB86Juul
 gh7POTdcFyjmk3GCOd0b5WxjeifoWnVnjHv4xowkTQ+XXuRO+SRI491cMKTv4JIJFwKBv0pagsH
 H/p0cIxhqlns7A+9/US4TDeAgXavt41emjS0fe
X-Received: by 2002:a5d:47a9:0:b0:382:372a:5719 with SMTP id
 ffacd0b85a97d-38254b2744emr994227f8f.59.1732087650051; 
 Tue, 19 Nov 2024 23:27:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/L57m8jyDZkOngQdFSRFHf7T+DLi1tQ3RnIXlVbcaIY6wdZenT6+uJESPo8RXVhW8aRtyIQ==
X-Received: by 2002:a5d:47a9:0:b0:382:372a:5719 with SMTP id
 ffacd0b85a97d-38254b2744emr994211f8f.59.1732087649641; 
 Tue, 19 Nov 2024 23:27:29 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825490ca19sm1253766f8f.39.2024.11.19.23.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 23:27:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 2/5] hvf: remove unused but set variable
Date: Wed, 20 Nov 2024 08:27:20 +0100
Message-ID: <20241120072723.103477-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120072723.103477-1-pbonzini@redhat.com>
References: <20241120072723.103477-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

fixes associated warning when building on MacOS.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/r/20241023182922.1040964-1-pierrick.bouvier@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_task.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index f09bfbdda5b..cdea2ea69d9 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -122,7 +122,6 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int rea
     load_regs(cpu);
 
     struct x86_segment_descriptor curr_tss_desc, next_tss_desc;
-    int ret;
     x68_segment_selector old_tss_sel = vmx_read_segment_selector(cpu, R_TR);
     uint64_t old_tss_base = vmx_read_segment_base(cpu, R_TR);
     uint32_t desc_limit;
@@ -138,7 +137,7 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int rea
     if (reason == TSR_IDT_GATE && gate_valid) {
         int dpl;
 
-        ret = x86_read_call_gate(cpu, &task_gate_desc, gate);
+        x86_read_call_gate(cpu, &task_gate_desc, gate);
 
         dpl = task_gate_desc.dpl;
         x68_segment_selector cs = vmx_read_segment_selector(cpu, R_CS);
@@ -167,11 +166,12 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int rea
         x86_write_segment_descriptor(cpu, &next_tss_desc, tss_sel);
     }
 
-    if (next_tss_desc.type & 8)
-        ret = task_switch_32(cpu, tss_sel, old_tss_sel, old_tss_base, &next_tss_desc);
-    else
+    if (next_tss_desc.type & 8) {
+        task_switch_32(cpu, tss_sel, old_tss_sel, old_tss_base, &next_tss_desc);
+    } else {
         //ret = task_switch_16(cpu, tss_sel, old_tss_sel, old_tss_base, &next_tss_desc);
         VM_PANIC("task_switch_16");
+    }
 
     macvm_set_cr0(cpu->accel->fd, rvmcs(cpu->accel->fd, VMCS_GUEST_CR0) |
                                 CR0_TS_MASK);
-- 
2.47.0


