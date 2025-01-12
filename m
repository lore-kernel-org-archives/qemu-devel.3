Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715FAC02183
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6KH-0004Ro-Ho; Sun, 12 Jan 2025 17:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6K8-0004IH-IH
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:48 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6K6-0006sA-QP
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:48 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso2682609f8f.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720445; x=1737325245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qItHc7tFgKciRuiRbnX0eajyd0aKzZOQ+m27ZqV/yQc=;
 b=uhY22ixQhLPrq1Z2GZcMkF9mHn3x+w7LOCMgSwoAGNAUs7+6ZpqStcD1O00ogPJnax
 SDV+qTB2mPNZdE6yHI9xNq0KH92EUrJMg96nYZtBZReglikEkOB/RMtI6gkQH0uTZRjK
 1BFWpja3dX8FJ+SrI7gnc8mRRH8yzMKDxnhxozrAdKgtqYzO8xTB3Feg9DlSvQqiaaZy
 mm4fX+72bu9gAP8pARW0NMH6FwwgMVCNi1lGDNbkpIldPQCzC2vVsPR+3fFtpT18Nwgr
 3eMtsCJmDlk2Pd1i3D6DNg4pFV01zVQqCiQUAg4cdJWgOpzSnvwzl6zf3VeVheW1mDB1
 URsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720445; x=1737325245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qItHc7tFgKciRuiRbnX0eajyd0aKzZOQ+m27ZqV/yQc=;
 b=sSFNzVC9wKz17DLo2oc7IxIolSC5ZqiDWxmt63xE/i5UjJVCigKHGaWXCVsWmXJ2bi
 4uNXVDTL/AJeXN0cgSY929hVzyY/2RiVRTsi+hVIiSUiB5KWe6LNUda6lur7lOhiYHXm
 aHNDJAfHY1d7MktnW6rRfqc59/Df180AGW6uDBkEwnby17EJAjOVfgQQqGDl0eoj5yF3
 kgtK49vRLeY8ZDazjEHBUfeQpq/GI/zpQiYu5eULNOXOqvRzaZBrNZeJtr2HhYeovX3X
 AZw+n4u1upTikqiqYqdbc+WK3hln9e1mjKaf6yoQ8ywqlmkUwu9sx68/QgAIdKPqfaem
 5msA==
X-Gm-Message-State: AOJu0Yy/SMZLUkw+JOJ8BH6gkZzU3REzUsuG6HSDpAc//pFbsE0iE3U0
 i5N53Dzuh52Eat9bu9Y/G4YcqmZtyMiiQEAvJ1M36AZjKBXOBYfl3peUE4zwQ/XIInmAEoDxdOV
 3lj4=
X-Gm-Gg: ASbGncviN/cmOrUVxIuOf1sWTA4ERBgNSVJxvs5Ss7AgEVquvNCktUC8fRPFeLiXKNF
 o4NIQDye1X/hhFQB3XyIh5q/jQM3UBLLhrba7IayBr+Ny5itNbvdUOFKYjqWPtLa+NPC3D7GheS
 L68XTyF8kjQBA6RxWGyB+QdUlSpr9IgvEJ1EpTnwIVpKU4+kxnPjNwUVFrH0Aoxk2o+8F2uUBPJ
 SFr8vgkyUgC7GbfZGIi3FexXHlR0v1sYU+23RJoLOZ9mZfCjucVVajgC/Esl5l5Y2ac8lqh98u/
 kpO8Brjtj++6NIjird89lyu/s9UxnfM=
X-Google-Smtp-Source: AGHT+IG6m5Epu5flO0AWzADRdJwiIb/odYP9nTHLtVMe47+DaekmuGSyid0QnkIenJnqvRqSGbj5gw==
X-Received: by 2002:a05:6000:186b:b0:386:1cd3:8a08 with SMTP id
 ffacd0b85a97d-38a872d0006mr15505335f8f.5.1736720445127; 
 Sun, 12 Jan 2025 14:20:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e37d3bsm122515855e9.31.2025.01.12.14.20.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:20:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 40/49] target/hppa: Set PC on vCPU reset
Date: Sun, 12 Jan 2025 23:17:16 +0100
Message-ID: <20250112221726.30206-41-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

On reset:

  "The CPU begins fetching instructions from address 0xf0000004.
   This address is in PDC space."

Switch vCPUs to 32-bit mode (PSW_W bit is not set) and start
execution at address 0xf0000004.

Signed-off-by: Helge Deller <deller@gmx.de>
Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20241231190620.24442-6-philmd@linaro.org>
---
 target/hppa/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index dbd46842841..7278b7ca6b5 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -205,6 +205,7 @@ static void hppa_cpu_reset_hold(Object *obj, ResetType type)
     }
     cs->exception_index = -1;
     cs->halted = 0;
+    cpu_set_pc(cs, 0xf0000004);
 
     memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
 
-- 
2.47.1


