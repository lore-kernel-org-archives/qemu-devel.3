Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1E9C27C5E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 11:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEon4-0005Uo-4W; Wed, 05 Jun 2024 07:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sEon2-0005UQ-Iu
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:26:48 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sEon0-0003Lf-VU
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:26:48 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52b90038cf7so5694967e87.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 04:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1717586805; x=1718191605;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPxAwlCAi7W8nwaqze0FGdE6bUase8BbGObZQt+PM58=;
 b=N8oJNLLH90jDVduNxGNVKUZvS3ICbgHPhikzT0yjhdq/3U7z/jU9IhTaGNHXd8R1w9
 pMV8qQ9M+t7Kyd2XbZJCIBwOmYhwTqOHcLWP1HAPZIA2Sn7JSHz6jXSh+eH3R9IjfEQi
 DzqtagpZI5M2TIoKpyiSSeqGoIao6tut+Cxq3mABr3EeUg1Zvc8dlVqfqbwGJLHTMZi7
 etr+d5C3TSM0tgMQvMGK8Ejkx2QJkMJVcwhVYgPM8BXhi/YZf3siL7w+Ed8XU2EVdcMr
 dEjrDstt4/QfEd7bghzbq2gR60mz4XuLYTUArYngTfbrfal+Dtch13ftMQr/pci5/54B
 lMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717586805; x=1718191605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LPxAwlCAi7W8nwaqze0FGdE6bUase8BbGObZQt+PM58=;
 b=S/you4KeLLyPM89cCn4hhcy1GfPrnEUxwK2ijzNrVZ5Oa+EIkScbxMSHhc1+Xc+8Ou
 byCYR1PO2fPF3ZO6yRbM2tGG0730floVI776/UGih1V86yqlQuNQGbizUHvs0wnnyoOq
 g6bXNZik5L8fdb263PqGyZkCzVfb66SOtZIGqMxvzL6orJLs/D30VFveqPKrvmIkJZuk
 TE5IGQf+s0EoO8E7wpHjbNDnNtRDE+/IZwXlf8E5G3TY8CALBozDv7SsKTfY9V9PSNON
 QHOKy/hjEg1XFGS3jaXDvuXQb9pybMJkpfAHHohICFrSfCRVnTzVH016hCVgmvXzUSPR
 3ycg==
X-Gm-Message-State: AOJu0Ywwx1RR61zJa3IaeqXyX+cjh3T2i0RSgSY17Y/XXw6Kil4lkuO1
 uGazWIEkCc0nJ56Xv9JMb/ijuqi27RB+d5bqd+C/WKouDlvr6FM1t4PT3LFzQMUnyQT3laNQDPE
 =
X-Google-Smtp-Source: AGHT+IFSfd1xl8kHXS5PITZh/7fdw5fwkTyQdE8uskdjgYtv0bWi3lLkfFQJJjGlmPSSUuRldk+/yg==
X-Received: by 2002:a05:6512:3b23:b0:52b:8255:71ce with SMTP id
 2adb3069b0e04-52bab4f44a4mr1882841e87.43.1717586805158; 
 Wed, 05 Jun 2024 04:26:45 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-249.customer.bnet.at.
 [89.104.8.249]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a51023af4sm7111335a12.29.2024.06.05.04.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 04:26:44 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, lists@philjordan.eu,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <roman@roolebo.dev>
Subject: [PATCH v3 3/7] hvf: Consistent types for vCPU handles
Date: Wed,  5 Jun 2024 13:25:52 +0200
Message-Id: <20240605112556.43193-4-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20240605112556.43193-1-phil@philjordan.eu>
References: <20240605112556.43193-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::132;
 envelope-from=phil@philjordan.eu; helo=mail-lf1-x132.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

macOS Hypervisor.framework uses different types for identifying vCPUs, hv_vcpu_t or hv_vcpuid_t, depending on host architecture. They are not just differently named typedefs for the same primitive type, but reference different-width integers.

Instead of using an integer type and casting where necessary, this change introduces a typedef which resolves the active architecture’s hvf typedef. It also removes a now-unnecessary cast.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Roman Bolshakov <roman@roolebo.dev>
Tested-by: Roman Bolshakov <roman@roolebo.dev>
---
 accel/hvf/hvf-accel-ops.c | 2 +-
 include/sysemu/hvf_int.h  | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 6f1e27ef46..b2a37a2229 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -400,7 +400,7 @@ static int hvf_init_vcpu(CPUState *cpu)
     r = hv_vcpu_create(&cpu->accel->fd,
                        (hv_vcpu_exit_t **)&cpu->accel->exit, NULL);
 #else
-    r = hv_vcpu_create((hv_vcpuid_t *)&cpu->accel->fd, HV_VCPU_DEFAULT);
+    r = hv_vcpu_create(&cpu->accel->fd, HV_VCPU_DEFAULT);
 #endif
     cpu->accel->dirty = true;
     assert_hvf_ok(r);
diff --git a/include/sysemu/hvf_int.h b/include/sysemu/hvf_int.h
index 4a327fd526..30e739a2b5 100644
--- a/include/sysemu/hvf_int.h
+++ b/include/sysemu/hvf_int.h
@@ -13,8 +13,10 @@
 
 #ifdef __aarch64__
 #include <Hypervisor/Hypervisor.h>
+typedef hv_vcpu_t hvf_vcpuid;
 #else
 #include <Hypervisor/hv.h>
+typedef hv_vcpuid_t hvf_vcpuid;
 #endif
 
 /* hvf_slot flags */
@@ -50,7 +52,7 @@ struct HVFState {
 extern HVFState *hvf_state;
 
 struct AccelCPUState {
-    uint64_t fd;
+    hvf_vcpuid fd;
     void *exit;
     bool vtimer_masked;
     sigset_t unblock_ipi_mask;
-- 
2.36.1


