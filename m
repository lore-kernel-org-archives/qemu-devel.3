Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB71CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3dV-0006hM-Ep; Fri, 26 Jun 2026 06:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dP-0006fT-PU
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dL-00057u-Nv
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEwm3fgpo3qUaz+yBGQLuR4QP9rx2aWp+MStI39TbBA=;
 b=S+XiqHhuPHp43ewldYaYOhsPAeqiQfD2bH6M0yqj7Y+efaifXIYh44dM0zxotVEokJH1ck
 +o08UjAj+cT7c9GvZUFhOaNNn0gR47UCuxeztrapxlB94ZT7XC2xUJG/F7D4k/lCi6/wZY
 cXsoFt7LX12GA0jjVSyHYZEJloFfKSY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-_iE0Ade_Oiio7PGtYhV26Q-1; Fri, 26 Jun 2026 06:18:01 -0400
X-MC-Unique: _iE0Ade_Oiio7PGtYhV26Q-1
X-Mimecast-MFC-AGG-ID: _iE0Ade_Oiio7PGtYhV26Q_1782469080
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b2f22ea2so6705585e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469080; x=1783073880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nEwm3fgpo3qUaz+yBGQLuR4QP9rx2aWp+MStI39TbBA=;
 b=JyG1/wYPlLCPG98YfDf+/qgNX0XIxUsfl+diohFKtRbyKEEIxt4rl7wL51fuPH41K9
 Ef+X198u/Hc3A/JcO5S16o6VYAdFsfyc3l1NHmSKusso+AAQwjntzAfZjo13GYtl48Mq
 ZCgeD0LL6lOzpsckf5M95tf/BeeoWfPUEt5bEVPcUdrAN1d90JmENX9dQr8uCZgmyzei
 FGzE8W8tV6ymz5OW3IgNeZXLG3iWrv0i1Ou+77KwZKqjCPBk8bCLheDVwLbjKuRCrqf2
 59nrnjFKSkG2uMr+kp8Ff/++atMvMgWHxtNkaWCuQU/ccQZx+ZQCigUedrSNhrfH2uOw
 KJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469080; x=1783073880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nEwm3fgpo3qUaz+yBGQLuR4QP9rx2aWp+MStI39TbBA=;
 b=pfJ3OCyv7YvRayFNvaOtohX87i/8r5BWS2UD69eYRefPaB8ZtEyoYFpqwNpvDXTASk
 BdhNchcw8MHnXie/HoU0TUINVpa6pFCCArI+c4DYVZUv645uPndjqEPa1XwQJXO5Tokv
 rqHB1n0yar1CQ9IaZ8zjzvlQ6Q2gHiMSpnZzrxGaC9n+E3ctNYCTC06OHmbadAjT4jXC
 4LMWcjrHJuVpjC93PXJBMGjoE3hGhaMwmna3QOL6MECfPZqKHsb9HhGI1YeYgxm7G/4u
 1BMkUwUk3UL/WWJRQ0qvzpdGnVVESvaWOJFEtq+cfbNXJJpeJKZwVVE+9MVbg03TTOGh
 T9Fg==
X-Gm-Message-State: AOJu0YxMsAROpih61WjWyxCrOtooed3LjGawjEAZkSvXhPRfds5ktfCW
 3MXbu81YuUwllruh0plvsy4F5QtSyh+4fmrYNy7AorgUM60MRGaYEvTYg2zyH3HkEsmfpjDfUUc
 wIsVybrfSiesSrJtWvE4m4zGyMFkkm2bm3l6AnNxDpKesbazXfuPDluyUd7H1Jtt25Y/mBQcmIX
 nZ2nUqrNuZkeUtgGa3Z6Bf1vBx1MNCuWJjTT43dQS0
X-Gm-Gg: AfdE7cmmDHPE+9caUf9kmVeYtGI5eMD5OltxCgwb3FTw759lRBfreL5JUHkX/N1EgDL
 ak+zBO7hHqmIPvTAzPRFiah04jpixEY/2ZrUQJSSQuTM9NxmhCQ5fLYqiBG9MV7id96Mnxx+CJe
 h9UFb2eDNRIwM97e8eF6/3muMW7zHR+c1pAXl9P7s+1WxZkTPBIU37Tts9qc/XzOCmbfRoGuMgk
 Z/jNa9qZtjH9duoxpClgOJfUFQa/kcqF2keJWvNBIK2ITD+GXqLTx98JGI0H/hPxrDOjh3JAK/N
 XXRH9tBgt1eEa0UCRnKlZLADrcSvlaBAsfYzFttY2XQB6in+4/BDMhFF9ne4sGL/aUc2FkGNMCb
 zSN8jfxMGbgUWfazNqXKztIHBbjbJTAgXbYcjKHRvSLaTejPgdL+QzwwcsWlT0xprxUFKJHmtAi
 4JM9WzE0xaFCzqH55V
X-Received: by 2002:a05:600c:3b28:b0:48a:906b:14ca with SMTP id
 5b1f17b1804b1-4926687e77emr84931805e9.20.1782469080261; 
 Fri, 26 Jun 2026 03:18:00 -0700 (PDT)
X-Received: by 2002:a05:600c:3b28:b0:48a:906b:14ca with SMTP id
 5b1f17b1804b1-4926687e77emr84931195e9.20.1782469079749; 
 Fri, 26 Jun 2026 03:17:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c221d93eesm22896620f8f.20.2026.06.26.03.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:17:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PULL 04/45] target/i386/mshv: change cpuid mask to UINT32_MAX
Date: Fri, 26 Jun 2026 12:17:07 +0200
Message-ID: <20260626101748.1728079-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

The current implementation would only override the feature bits that are
enabled, however we also want to consider disabled features, hence all
bits are set on the masks in the hypercall argument.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260416121116.527927-5-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index bfcccd19916..2ee46bd7025 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -538,22 +538,17 @@ static int register_intercept_result_cpuid_entry(const CPUState *cpu,
         .input.always_override = always_override,
         .input.padding = 0,
         /*
-         * With regard to masks - these are to specify bits to be overwritten
-         * The current CpuidEntry structure wouldn't allow to carry the masks
-         * in addition to the actual register values. For this reason, the
-         * masks are set to the exact values of the corresponding register bits
-         * to be registered for an overwrite. To view resulting values the
-         * hypervisor would return, HvCallGetVpCpuidValues hypercall can be
-         * used.
+         * Masks specify which bits to override. Set to 0xFFFFFFFF to
+         * override all bits with the values from the QEMU CPU model.
          */
         .result.eax = entry->eax,
-        .result.eax_mask = entry->eax,
+        .result.eax_mask = 0xFFFFFFFF,
         .result.ebx = entry->ebx,
-        .result.ebx_mask = entry->ebx,
+        .result.ebx_mask = 0xFFFFFFFF,
         .result.ecx = entry->ecx,
-        .result.ecx_mask = entry->ecx,
+        .result.ecx_mask = 0xFFFFFFFF,
         .result.edx = entry->edx,
-        .result.edx_mask = entry->edx,
+        .result.edx_mask = 0xFFFFFFFF,
     };
     union hv_register_intercept_result_parameters parameters = {
         .cpuid = cpuid_params,
-- 
2.54.0


