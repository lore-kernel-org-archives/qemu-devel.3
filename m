Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0553EFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV83-0001Ny-Ku; Thu, 30 Apr 2026 13:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV81-0001FU-Pm
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7z-0004wx-Sl
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYCduzC2cD73fw/BB3hnZuN/llJJ38dVAv+OuS7Ukjs=;
 b=KZWgiU71iYlDjypV3fXQWmkZirDNofdCzCEpUlLEWXzTAaR0bdZg9HCy8jt7Xv+8WqiHRS
 zCBqz3yKpnt9ogi/K8v8oUtymRgJzzIrGcaBiiZxaoNGhKerLJrMGf8gLysDiiW2DWBX4u
 5Fwql3LIl3eIvQSsMg/KIbjpiltu/54=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-Y2s0TYLsOjCyzB89wt4f0w-1; Thu, 30 Apr 2026 13:24:41 -0400
X-MC-Unique: Y2s0TYLsOjCyzB89wt4f0w-1
X-Mimecast-MFC-AGG-ID: Y2s0TYLsOjCyzB89wt4f0w_1777569881
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50fb6d713ddso19759481cf.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569880; x=1778174680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VYCduzC2cD73fw/BB3hnZuN/llJJ38dVAv+OuS7Ukjs=;
 b=rP/OnE1AsPOMOq5/R/z7Z29STgOv/4JkRz7Nqvv7731MD1GBe2YH5hGlnRUp08nRQ9
 XkaDGIbMakh2M/sZKud8g3CCRNvFUrHaE0QOvYn2/3iPKRe0/sLqf537+yYAk8j9KruH
 UBMUuEk04/6i1m9ioSI0J+3fVPrnOYDaXLaIhL5wYmCRHq4ZULFl97kQ8ZRD5MaW4J3T
 2l5dT9vrLju9MhmjrxiP1DtpEysLvB0PJe7V+5CttqMvQ3L5kKM2O0kox4Rc8sY90CyH
 fPjEifmiYr94+dv/JNfEP4F0I52+mRQ19iNZYFDJR60b5TyFxyzTXDHcu4/9khjhVhCw
 YN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569880; x=1778174680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VYCduzC2cD73fw/BB3hnZuN/llJJ38dVAv+OuS7Ukjs=;
 b=cgb9wUlBlEMt/wnQkyxoy2YCm8/OfgU9iFKdBzkTJBhz1YkOpg9pgZUaQld7TUgYUx
 hJIjZsIU20r0082vHzBgCFVAwf55uFkMCOd3EzqTrbEcazgFPXOOndZJHkE5mvgd3QCd
 9Sa7hn+KZrMhoF+qj85UByNBCOogOEf9BH7eB1qQAZJZI98pGXdQWzp66w2E1yeV2Rov
 B1l3h9u6lXaKob9HS8R4oW7gxmOFKcqQfQyYr0g0TgpaPMG4G/rmgulQTMbQ8Kp9ZbMv
 +7SAfZgy5T9lgYWKXjX9debDKrg3NvcIZ4X9C8f4plKj9v3AGdngLvijuvYBaUZ6EpMu
 EqlA==
X-Gm-Message-State: AOJu0YwQfaba0N1Kg+1/jdkTQPJYvwkzr6UGe4d6hIUNAKu/2KFI60lP
 vEbZvBlKKO6A6unkXcH/eMYUCargBkzzgFJ038KiwOSQSWxHKtgswB+S8QXmApIKgr4myZ1/2pT
 +tCaho0079mnLl+JvogXelXFX2ilknOTMH3HXBRIBYs2lLKD9+OVAI/q4d5sRDBG7sC7i3/s/7D
 YempT3HPBOUoc7Yjl2rKyzndySpd15d9naQwR2O0UR
X-Gm-Gg: AeBDieuSK8Dx/+5LrdUof4LEv3bj8gpGJXxaPVHAkjoonIgLboBt4QA6Y76UIbDYrih
 JoBVV6jrocvKbW485XT9cFDn/HN83XV2qdA9Bp+cimpJi94nU80WfqaFqp8OCrLg6CKeboQQec/
 +CLUcGXqThvHXrE+bZ3o5IKJ5qhjtdjkLHneucPGloJP4VX7JVSrKLqU2HAzCAY2V93UduHEUSw
 etlG7+Q4k8WkIDEdOrpTMget7Z6ITqGJDJYLjyuHGCx3oWWAjkspRqfleye+CYnVV8BwzEflGK2
 u4dhDvtLUDktJwMthgjmYH9Xc20d7W+a6O867FKR9oi2u1efOWCH8MaVByDrwfSaCuEoGUVya0X
 j4CvtJudciGk9rTSAnDuS8EktZoDNjHDMRKK5KFFvV8NcFYveDBCyl+Knm53175tG2UerwZ+6oN
 /7BnfXgEH17Smktk3zNzvogQagMHqx3Cb/TtY=
X-Received: by 2002:a05:622a:242:b0:510:138e:b83c with SMTP id
 d75a77b69052e-5102ae08789mr54450361cf.33.1777569880095; 
 Thu, 30 Apr 2026 10:24:40 -0700 (PDT)
X-Received: by 2002:a05:622a:242:b0:510:138e:b83c with SMTP id
 d75a77b69052e-5102ae08789mr54449691cf.33.1777569879429; 
 Thu, 30 Apr 2026 10:24:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff43b896sm23101066d6.25.2026.04.30.10.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 49/58] whpx: i386: Pause VM on fatal exception to be able to
 inspect state
Date: Thu, 30 Apr 2026 19:21:55 +0200
Message-ID: <20260430172204.1006673-50-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-26-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 077a491664d..25ace38ff60 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2387,7 +2387,7 @@ int whpx_vcpu_run(CPUState *cpu)
                          vcpu->exit_ctx.ExitReason);
             whpx_get_registers(cpu, WHPX_LEVEL_FULL_STATE);
             bql_lock();
-            qemu_system_guest_panicked(cpu_get_crash_info(cpu));
+            vm_stop(RUN_STATE_PAUSED);
             bql_unlock();
             break;
         }
-- 
2.54.0


