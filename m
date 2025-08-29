Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C024FCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNGg-0007KK-5f; Sat, 30 Aug 2025 11:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryi2-0000xI-0S
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryi0-000879-83
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j5STuZDfkLwvLA/o2L3RLPkW2V/mWa298khuXoe/7OQ=;
 b=cJqp6VuIsOw0JbLHMbtYgqxJ0+qYRgmyORnYDo8URNdtMS12+eJP6DeLrdikLYZor5yRcF
 udVg9zL5XDea96Ir6wacAhBCgoRJ8sdUMivUKHmPYhqgzMfSZboeYiSZXV8RClF9yQH6rT
 B27rYVRV4/YM0L/xayFa6qZSstcPer8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-L44POxkJNjWzMHsZiyAX9A-1; Fri, 29 Aug 2025 08:59:58 -0400
X-MC-Unique: L44POxkJNjWzMHsZiyAX9A-1
X-Mimecast-MFC-AGG-ID: L44POxkJNjWzMHsZiyAX9A_1756472397
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45a1b05b15eso15165195e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 05:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472396; x=1757077196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j5STuZDfkLwvLA/o2L3RLPkW2V/mWa298khuXoe/7OQ=;
 b=S8ISTjZTOypZnpGgkhQiPHPNaACv/gIFoUn+kikREeQHCUDndzk9UJ2rGH6lgUPuiW
 mNsn38XcPFdiMbrjuelVhqgNwG9AwCWY+fTUA+3YiFUEyMv0TjVmVHCDvSU3CAWIyZi8
 ilujRH/zRaP2AxgtYGhzJNyr4STA4qNPRFRtzPbNGxTifA8tzTDlE2mNK/Hi/YEWldg4
 +hbw/LWiYtQ1qFnEjePh/Uvqamqb5BYTHXedtZ0UPoJHMxigVBcsXWmXS9VXnZDkNoZI
 wxe8m5W33DVf9uVme9x9ZMFURsIRnbP8LF3H29hG4QFNsdKyrH3qEqRH5Ek5ZkBqrypo
 XUPg==
X-Gm-Message-State: AOJu0Yzf43/tZY7D+uRSv7L14CEEOyPyd2Snsy7IxibnrEU0A9uGHHSJ
 h0gcT7R4olNio0MA4MR9xLgt6HtrDrP9/fjadHU0H4rmfYNr/lo2uQdgBnJun76XwsgN+7J2TiS
 EHC5pQAYtaWmDIuDDTfHHeNuKYYU5qbBBNd/ky9EO2q/s1iF+xFiAEmogCKAvC6xsSF577qw1GO
 8oRTknVsD5TYnjljWyaGYxPl8p/YRbFc0AxKIoxMpR
X-Gm-Gg: ASbGncvu8Lm7xuVM98+R/7BN9PBCL1Tej7cfD1AqXy1XRYeqnrbUhz/YHYmvVbbSIBl
 ocR67eAN2GaEZ1qlquTku3NKam2wh1kPO4lKxPaev0moj9ZjsFde/TGWzmp+AVSUiuxOnXLdULO
 hLKBCh8+0VPTfGum3CxOA99eoqFCdHl9TNTrL5Z1nn2wPTYtDSH7rpn1ylEUTA6soMBtSh6OiqZ
 r4zwwiCsTqc/RvCJp/F0rmhNLjp/900BS12b0LhpsOdic+telD1E1Q+8AEqZZp3dU51KXJ7LyK2
 AutwCUUoWHPq15QibthLebEWxkJdcd80IitSg5zOrw/PGV7DKSixqfQnlXo+SN9iqEnNQsCE53A
 vT3FpNy1C+Hi8pFucWQD5BOPSDLpidr9hvs7nwJXmqrg=
X-Received: by 2002:a05:600c:4511:b0:456:1156:e5f5 with SMTP id
 5b1f17b1804b1-45b517d27f6mr276577945e9.31.1756472395769; 
 Fri, 29 Aug 2025 05:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+sj9MyI6AWkXcd0EExH+cpJtxqqUhsI0xFlPqbBpk6/FMZhIHMbtY4fdp7F+YMVpvzx5SkA==
X-Received: by 2002:a05:600c:4511:b0:456:1156:e5f5 with SMTP id
 5b1f17b1804b1-45b517d27f6mr276577775e9.31.1756472395345; 
 Fri, 29 Aug 2025 05:59:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7df3ff72sm24872465e9.1.2025.08.29.05.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 05:59:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PULL 07/28] hw/i386/pc_piix.c: remove igvm initialisation from
 pc_init_isa()
Date: Fri, 29 Aug 2025 14:59:14 +0200
Message-ID: <20250829125935.1526984-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

According to the QEMU documentation igvm is only supported for the pc and q35
machines so remove igvm support from the isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Link: https://lore.kernel.org/r/20250828111057.468712-8-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f1b4468d0a1..5ae265bd538 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -640,16 +640,6 @@ static void pc_init_isa(MachineState *machine)
                                x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
-
-#if defined(CONFIG_IGVM)
-    /* Apply guest state from IGVM if supplied */
-    if (x86ms->igvm) {
-        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
-                ->process(x86ms->igvm, machine->cgs, false, &error_fatal) < 0) {
-            g_assert_not_reached();
-        }
-    }
-#endif
 }
 #endif
 
-- 
2.51.0


