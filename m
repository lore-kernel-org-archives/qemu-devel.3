Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490CFCD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRX2p-000636-MH; Mon, 25 May 2026 11:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRX2k-0005yd-DR
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRX2h-0007Ti-DO
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779722194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OKOkFCCWCPnSIN8b+3A7vXAmBTMZOV+rT3knUHlWwdQ=;
 b=Lh07mLtnqYhDg+iaKwnQJEMP9OL4YFBQnEpRPXn1P493yyswaxjCNkl7PEnjqsep+u7KLh
 CV9lKhk1iy8/duFGXHtyc+TVnc37cWWRPkO587JCKpXPQnctJ/U1EJ3FkUNKH0kolt/sfO
 qUmfBRBK07wKXZVXCgwo6DPC3sxwU+M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-hQvyRzXTN6WNYKH2QDwswQ-1; Mon, 25 May 2026 11:16:33 -0400
X-MC-Unique: hQvyRzXTN6WNYKH2QDwswQ-1
X-Mimecast-MFC-AGG-ID: hQvyRzXTN6WNYKH2QDwswQ_1779722192
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44ffa15dc8cso6002393f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779722192; x=1780326992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKOkFCCWCPnSIN8b+3A7vXAmBTMZOV+rT3knUHlWwdQ=;
 b=bdZCZPIQtbJaowNFO7SXFkpAr0eOIlI/Y53vHKRfzATjgkOUxRGVAyzTrbpfGYcazk
 FlrrFXHg67rVYj94bKYvyIeVTP19Tg32jVfvz3EGfTQ3h9SdaYucSS8m2ufqWn9dG+qF
 sEqouVWJtOITXHHVnXTodrF/ISQ8OjPOl7n+CLD2QUg8rScCVn0t2vkJK0NtJ1PKCEcT
 yDGeWIqL6uTyq3I2qmCWCGeXN0XINFP2ROU+eW4wlfxniIXTRrbPJQWvfQNt9nkEl4uB
 E6PSvLNh2sqXjr66nNacM+6Iuf7RvIbowDU+3J1ZuKxWK5y78FcNxQ7888R6G+ex5TFH
 7WBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722192; x=1780326992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OKOkFCCWCPnSIN8b+3A7vXAmBTMZOV+rT3knUHlWwdQ=;
 b=L5S3BB8s5+3C6b5oxQIwUTGGyXi2fbjGER50PS6Gl41paHjtoGTRx4oqhpkAkb3CQw
 3KCPS2lmwsso8HZTGqvb4RBP73KTJlO+QshIXaF1kbUiAx5P1EMNT3I9SvN2g1oJxt6R
 ZPaAdx3pWC9QqeZ9sIjF8AHB1EbjQ3xOCawRo5YISs8U2mEDx+5rub6oyr58OFPoNp6a
 0VdwWOebb+DUlZ+IRGowznBQk0uWlatUJeSm+xKp3azOb42fwa2cPUk6Ex30oM7qK+Zv
 Qd40NLVMJVqnhGv8uV5+mAkvfnm3OA2TklH3dogJ5OiUDUOYtEzRZfhJN0aQ98BTComi
 Xvlw==
X-Gm-Message-State: AOJu0YwAdYoOH9i80JtO3t4jo+j4PDe/1UBAsjwrU+ZQoGpmnbYtlMZq
 SCWKGWZW+S/mQI2p4K/yAiR1ydIpilDKyZq5HUySnZkaBsAPl7OWlce5P46DbkUEdOaSc2yd0kf
 kwOq63jb14H73D5cm+cBHw6fsGDwKIBnzcNoCIN7acXI8+mVw3mjUCTEdln0CZWTEryq6IubQnF
 zrhuM+tfxzjViLmrWZsPUqq/7bCcfUTgbBU+wSSOAa
X-Gm-Gg: Acq92OEMqIX5jBdXP0beKPrXpDJg5jFetRPwlONof4UhDY/eQPojma51d8NV9BaRxDA
 q9EFTZHAfFGM8O8v+8aNR7ncVd9gae+q0+G9fsjkBl8CoNOq2OyVvusuSC1BsM0gA2bpkrqbMua
 2TjjE/MOw0YUWDro+TmrWQk2JhpTjiL0mg6viJXH4oqHc7r8ZaW2l5DIvj3+pW7Qw0mRJ1AmO5j
 Kr5mkfmed24tmiI3597VjvvyJiut6kbcuaZ/Sw2l6FIU/zzf7KoKgm29zmO7NDGa+sruoAi17t/
 8FN7jDXucXAuVkF5knJBe2EyvZ9U2Dd/rmlhMi1kMA/nnNOCxZPnU8ZDTIqCIDf3efcMTfTYGaV
 F2kzww//Ea1TNoq2NoofMp5lMgtSdRQgX8+APFLutN9pbsUhY9OCTtS8qyR/82p2nOMqzgJJN4l
 QD1Vf+xx+icQhynCXJX7KkjNrbHeka
X-Received: by 2002:a05:6000:4310:b0:45e:73b9:fdeb with SMTP id
 ffacd0b85a97d-45eb367fa36mr25503544f8f.8.1779722191942; 
 Mon, 25 May 2026 08:16:31 -0700 (PDT)
X-Received: by 2002:a05:6000:4310:b0:45e:73b9:fdeb with SMTP id
 ffacd0b85a97d-45eb367fa36mr25503480f8f.8.1779722191454; 
 Mon, 25 May 2026 08:16:31 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d5e363sm28709822f8f.28.2026.05.25.08.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:16:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 4/6] accel/mshv: implement cpu_thread_is_idle() hook
Date: Mon, 25 May 2026 17:16:19 +0200
Message-ID: <20260525151621.395954-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525151621.395954-1-pbonzini@redhat.com>
References: <20260525151621.395954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

In MSHV the hypervisor APIC is always used, so we to implement this hook
to make sure the AP's vcpu thread is not blocked waiting for an INIT SIPI
by the BSP. Without this change soft reboots with -smp cpus>=2 will
hang.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260421-mshv_accel_arm64_supp-v3-9-469f544778ba@linux.microsoft.com
[Make comment not x86 specific. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/mshv/mshv-all.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 58af674bd99..58d8638c0c1 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -714,11 +714,23 @@ static const TypeInfo mshv_accel_type = {
     .instance_size = sizeof(MshvState),
 };
 
+/*
+ * MSHV manages secondary processors in the hypervisor. SIPI for x86 and
+ * PSCI for Arm are handled internally. Halted vCPUs must still enter
+ * mshv_cpu_exec() so that MSHV_RUN_VP is called and the hypervisor will
+ * wake APs.
+ */
+static bool mshv_vcpu_thread_is_idle(CPUState *cpu)
+{
+    return false;
+}
+
 static void mshv_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
     ops->create_vcpu_thread = mshv_start_vcpu_thread;
+    ops->cpu_thread_is_idle = mshv_vcpu_thread_is_idle;
     ops->synchronize_post_init = mshv_cpu_synchronize_post_init;
     ops->synchronize_post_reset = mshv_cpu_synchronize_post_reset;
     ops->synchronize_state = mshv_cpu_synchronize;
-- 
2.54.0


