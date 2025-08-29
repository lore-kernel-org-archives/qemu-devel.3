Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AE2CA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNGk-0007SV-6g; Sat, 30 Aug 2025 11:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryiU-0001C6-0A
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryiK-0008OI-Dr
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k8kp0Cbu16sKsjDAB7J2N+24+1kUucDBRmU0sLqwMZQ=;
 b=d6Pak6MfMWnSR9EgkODJB0Y2U7UJGCI8DYo2zzoCIvdJd9+OMD9CPoW3S67+uLmWMLZKlJ
 0MYtf3Z5b7MX+CihQ6zOBIDpx0D3kL6KGocR17zW3ivfYTq89iWuR3L3i+lrID4xClmi3H
 gSavnX8X9SEHBMIkXhYhSJEwy9JW+mw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-VG07g-4GOa283MIVQcaGsQ-1; Fri, 29 Aug 2025 09:00:15 -0400
X-MC-Unique: VG07g-4GOa283MIVQcaGsQ-1
X-Mimecast-MFC-AGG-ID: VG07g-4GOa283MIVQcaGsQ_1756472414
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3cdd69ee330so731582f8f.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472413; x=1757077213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k8kp0Cbu16sKsjDAB7J2N+24+1kUucDBRmU0sLqwMZQ=;
 b=rTKkgGBnU/OyAwhSeC4rUgrr2bBJO+J43cd7w40ekChtyiFl1rRc05UcLrUY+9KPX0
 wScXXv14rqMWi4XNVKGH7BBfaYuVVcY4AeMb2znRHEmLTfBjLe00wUsrzCp1YDUnok5H
 k8nW39pESeQIpiKwIzvGlin57ErQUXbQb6K3wkKe99JVMfy1jbfZe9VpGdpBgy/WYs2v
 sSfmFeoP+3/lGTyO5HKAkIXg+IbkQT3e5C0cR0yE8+y5IE8TNFhPpHuAUn7gkBqbu+vW
 pTDOBj63+S6nplw27ijDxpjhspY8T+Anz6UWPhff+d7xl59PayIfbE61XtlOlHnDqjF3
 Iobw==
X-Gm-Message-State: AOJu0YxCsAksplcLDmf4nfOhHift1RHlFhLhGXESbO1ULByv3qZcvmEq
 2O3ZP61+hdKI+gqKxmku++3I3+pORqizqOIDaVrJ+pEWVP8pgLtEItX5YPLJMa6wP8EMVbFQRzd
 QqUjtqWRPnpeC7zaMy9VgbYocAtv+9wc/4xvbBjWmaIqe+0aNpcSMUSJcQ+YzCrhFU6K7bIE2HG
 FN10snY0caVVE9Vw9s19IYOQ6psByiISXKbjNnz0pv
X-Gm-Gg: ASbGncsGnWSnwOwZCC1GV2Hz2z5ZubuRAjtFEDlfUCjxgsz7JSYpLYKqkeKLBZ2zSAF
 eKSFyzM4yQxkHW9gpMkKTccN8t+zhlCZu3laM4v0EBAB9LhnOQKfmLL0S/TFTSxzrZDXHA3UA8p
 AJnfJZOeaWO9BaBRWvLvT+bpyNmGj8XAm6ZrCHG4edPZA8shzEBU+ZEoLsNtmJq8XiL9yIpNEU/
 PRSIg18/8kkcd54AsCDk4FKXRDRLEwTWxHmqPiMxZL8ZMCWbm/Ghie1kE/BIq0/349H8GDsh92Y
 fH82iIeLFJJoLOQDHWvomDp75i7KgS22W7CT8EHAa+5a6FIauu2RhZ0iiIyA9saQH2dzkqo2Q/W
 7RCT9uI1XyT2AzcI+tXQt2vwiVx9E1a2rYfLUrRGzpRE=
X-Received: by 2002:a05:6000:40dd:b0:3a4:d6ed:8df8 with SMTP id
 ffacd0b85a97d-3c5dc734927mr21516467f8f.39.1756472412942; 
 Fri, 29 Aug 2025 06:00:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY6a5M++V57bS+wpK+MuOfDStkPzeN9MtAnX3m6Z8KIV5YtsAP4l11iMRj4BKW0y6o5wcGeQ==
X-Received: by 2002:a05:6000:40dd:b0:3a4:d6ed:8df8 with SMTP id
 ffacd0b85a97d-3c5dc734927mr21516430f8f.39.1756472412419; 
 Fri, 29 Aug 2025 06:00:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fb9d37sm3350068f8f.49.2025.08.29.06.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:00:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/28] hw/i386/pc_piix.c: remove
 pc_system_flash_cleanup_unused() from pc_init_isa()
Date: Fri, 29 Aug 2025 14:59:20 +0200
Message-ID: <20250829125935.1526984-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

This function contains 'assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled)' and so we can
safely assume that it should never be used for the isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250828111057.468712-14-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 66dc4a5186e..fb936748bd1 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -503,7 +503,6 @@ static void pc_init_isa(MachineState *machine)
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
 
-        pc_system_flash_cleanup_unused(pcms);
         if (machine->kernel_filename != NULL) {
             /* For xen HVM direct kernel boot, load linux here */
             xen_load_linux(pcms);
-- 
2.51.0


