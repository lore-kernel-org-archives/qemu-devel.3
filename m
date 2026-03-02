Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280E7D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwytq-00033G-RY; Mon, 02 Mar 2026 03:45:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytl-0002YX-Nm
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytj-0001eW-F7
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l2dC2Q9dMZO9bqztuxoBOcOQF8vWCnFvS3RUEwDP/Tg=;
 b=L9GTC7Q8yJbkMCLOwBrXRSO5h6Qw/OX/e/DFZMvZhTUIzRo5kbsrq0kTg1c4U3c2K92RHb
 hzhoNuN/kPIlWI80g4GkqDKMpDpov5nl4HR08QOiTfTb3Y2HsGlJjWzVOLLM/xW0Ua9bfy
 htmamdVeAfE6PeqcZSj7m8IGaZZLX2Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-pAE28c6lMzWPYib927uyMg-1; Mon, 02 Mar 2026 03:45:01 -0500
X-MC-Unique: pAE28c6lMzWPYib927uyMg-1
X-Mimecast-MFC-AGG-ID: pAE28c6lMzWPYib927uyMg_1772441101
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837b6f6b93so29833065e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441099; x=1773045899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l2dC2Q9dMZO9bqztuxoBOcOQF8vWCnFvS3RUEwDP/Tg=;
 b=IhTcGJHfQQHx2PSV3diHrCadEEWNIDPLOEJb/dZOhth+0vqzqdc3wA1F58GH/NgcD0
 tRRKg1VugscYuJWtSRD8Gvxu/wPK1Yd/M34xlRG0Bd3pWsLG2aykL2ip3+NK2QWEF4tc
 U+zsjQbvkkGPMfwQEg942A5lnTjWL9gNr0N/+wZbXaX4YGFt7LwEol98oIDkq1s2TvZs
 qeYJbd9U5I9VDrAG1tm0JC0KHDpXbeyabH3X4btUChLW9waAHVF1sfp2sjoZ4XuUkGoZ
 nQvZFU2gl6gAJiaaEIrTDEcWRDuIGOXpvCSLNEtPUCnYBK6YojDfUujg1s8j0TOUDZcA
 lPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441099; x=1773045899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l2dC2Q9dMZO9bqztuxoBOcOQF8vWCnFvS3RUEwDP/Tg=;
 b=uuf/P/ZCVzFsFdhP+O1nlAojy3TFmv1V/S/DDMuGEOvwVGoCJteaJkUwqxtYA2VVr1
 /TfB4rK6SjWyxM69iFQ/XdTHrQZkATJJDM22uXcg28dA576SFaMBgdu05OUCICL6vQaL
 QbTcuaQxi9rPINrjfTx9sljJ6vapxfvuuCalBNmiHLIcC2AjhfZ3xtkUFLajP1TJaoiO
 nOFq1p4e9t2DXen6c3zi1tB88FiLEBVW3dwN8PXgVvJt6nz6wH37UmIELy0hhY326V5r
 exhTM5fifGhwJrr0GZUUAM+8yDUVdiTl4Tn3PQWSNOukSTPJ8c2LXSQcED2EV6VB8upb
 JfPQ==
X-Gm-Message-State: AOJu0YynZNZHZvGw4+JIl9kJNRZeWjnEaBvmXb4u5ntrCShaU9/ZAqDF
 +5WgfRW9mTc09m5aGCmY2/4v5eAS/XVrlAXLM61eL+njv4Qj1TfOh5ON6UrKf7QcDoOKJgjEDx7
 e4WLKP9K9unU9W1LC7YrPKw2Dqf87z/4wJ0dLTyHEuuiQJYLc03MvjCHoB23YIynFjBv5MpuK2p
 C6xH8vUzNp5IcH1P0+AMNf0ZXyI8Zta6nW9JM+WVeE
X-Gm-Gg: ATEYQzw8Ga5KVaIJw6eUewWffMjzIhwFPTOQojcHh1CNHkwbnMukygq0tpR7ZT8JyMm
 MLCsgZi727za/vtJmg9iEMsrqMgBdTXgnDqpeYVGOyNDSAaSY9IHfjuINK8qSLvPSk3iWYy54tN
 57/thufTQJlC4nmfjQz/M5sq3AG5gwC5DFxVHdta7gX7AAFnDf7qKIFezF0pn2BAAfijoBnJsTh
 Z3YhGHoVWAl/HmrGXjXn3ep+yIhMAg+bAZBZnx5/OKTBOtUjfzpQGWvikQuCiyc4dq8Jlh33ku/
 w3PwTT/0i3yMdGjq6Ika8UFeQN4z5PmkAISMu2hZPEWC/lggtYlW2eYA4Z48kgyAH0eNZC3LEbg
 HA3frp0XnCFpDitJ+QdE6ISt1lJICG4wTUsWSpktDu8od8nuGsiMycy7I+l4DpwqR52lXu78kzv
 4qh31hTCmbdBKFGzsdiMW6S1MgbO8=
X-Received: by 2002:a05:600c:6385:b0:477:54f9:6ac2 with SMTP id
 5b1f17b1804b1-483c9b53c9cmr217676825e9.0.1772441099500; 
 Mon, 02 Mar 2026 00:44:59 -0800 (PST)
X-Received: by 2002:a05:600c:6385:b0:477:54f9:6ac2 with SMTP id
 5b1f17b1804b1-483c9b53c9cmr217676245e9.0.1772441098875; 
 Mon, 02 Mar 2026 00:44:58 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f26d7sm409057105e9.3.2026.03.02.00.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PULL 030/102] accel/kvm: Don't clear pending #SMI in
 kvm_get_vcpu_events
Date: Mon,  2 Mar 2026 09:42:25 +0100
Message-ID: <20260302084338.473368-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Maxim Levitsky <mlevitsk@redhat.com>

The kvm_get_vcpu_events propogates the state of the pending smi
from the kernel to the cpu->interrupt_request, with the intention
of having un up to date migration state.

Later the opposite is done, the kvm_put_vcpu_events restores the state
of the pending #SMI from the 'cs->interrupt_request'

The only problem is that kvm_get_vcpu_events also resets the SMI
in cpu->interrupt_request when there is no pending #SMI indicated by the kernel,
and that is wrong as the SMI might be still raised by qemu.

While at it, also fix a similar but more theoretical bug with regard to a
latched #INIT while in SMM.

A simple reproducer for this bug is to read an EFI variable in a loop
from within a guest, while at the same time run 'info registers' on
the qemu HMP monitor.

The reads will, once in a while, fail with an 'Invalid argument' error.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Link: https://lore.kernel.org/r/20260223221908.361456-1-mlevitsk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 3b66ec8c42b..bb8303c39fe 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5501,8 +5501,6 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
         }
         if (events.smi.pending) {
             cpu_interrupt(CPU(cpu), CPU_INTERRUPT_SMI);
-        } else {
-            cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_SMI);
         }
         if (events.smi.smm_inside_nmi) {
             env->hflags2 |= HF2_SMM_INSIDE_NMI_MASK;
@@ -5511,8 +5509,6 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
         }
         if (events.smi.latched_init) {
             cpu_interrupt(CPU(cpu), CPU_INTERRUPT_INIT);
-        } else {
-            cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_INIT);
         }
     }
 
-- 
2.53.0


