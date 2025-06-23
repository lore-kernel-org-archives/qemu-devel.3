Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2009AC7EE30
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgA3-0002dq-Vk; Mon, 23 Jun 2025 08:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg9k-0001x9-KS
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:23 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg9g-0000qS-Mb
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:11 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so26777995e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681204; x=1751286004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/J3/dM6yL9EpwD8nNu/ZbysHMLeoDjMiAJQk/DeNw0=;
 b=KgaASy3nVLvcI2me5+vujIHmE7E2WozMXAiBpCEtezJAuVbbqIi2AOlqZ3V3Z/yzmF
 KDoGDwCcyNTrHycC64vykuezXGrthIKd/77oG0zb8YwgyOpBV6+JLKbFI42+BVXaPUaJ
 ySwsyHQWz0IsC/wW3APZQnBZKnfwPr5BENbZGQKzkT0XpMG9K2zKIjm5MB7dovfQ+xLI
 E6+QvskUS0I5bQKa0SyQ6Jqdb6w5qG6dmXN9NGtLFL2gZ4nsvsW3EY0VrYVx0OUmgloD
 jlQb6WGeq1BlWH42Sq8X4/vJw6wqrT5O+ImYT8ZII2NNXSvtmNOkEzsU5iZC7l3bws3U
 uV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681204; x=1751286004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y/J3/dM6yL9EpwD8nNu/ZbysHMLeoDjMiAJQk/DeNw0=;
 b=fQaOnnh/hq67aSkix1XQtakqO17mAIhu08uBSpZ0j3YQ90aYcy8NzbWpYMUyGNljxU
 O09jEYk7AX0evFjpZ1uWEH92i/BGNgtFUDWuhwjfFhPGuxNTgNeNtDQ2JoSRepsKVp2f
 UUQLRCHEU3+IFRalGPTUGjPo4KZMT4DZQZrIRM/tS3HC7lS9TcHJ/+KlBxaVPcWHa0FW
 MAWPXwpElYN1A6dGXwEjO5gAxTLweQ6CAax+B+JrRhEds3yz1bX9NJvbI99u29Zq3/6T
 F1OpuQLqtciWJt+aFwvSRqGCh+qyLzBAmzS0C9w7UmDSlOf2+YlicxGzZ6tHP67Teruz
 uaoQ==
X-Gm-Message-State: AOJu0Yx0K9WYw5UtJr4W45oExPXiA1BnIlsbGWFtkXPw/IJCHZ8MoL5l
 CVR0TNZ1wySH6EKBeKDnIFU2qEvL4Fy2pmtQul0Sogy50wcelOlGRP2Bo8a7OdjAhNx6q6lsO3S
 uCX19
X-Gm-Gg: ASbGncvX7Hmna5ng60RQcJF1kbjhTjvg6X02W4r/fs5jgaqxaObrCG9NZYdsnvu2tpI
 W0l9Oan/uY/d1dg8DlM1baqql+bI+UKJ2vwIj9qu/4pURxo2V63j4OjCUa0oWBSb9Akf8HL/EF0
 f8ZGmFP8HPBbfemRDZ80cWhG1kLB579nh2MSfGtxwF1LptTvurFmWBWASICyTqIUdlYAyD6o2gI
 vhGVfBjz0pJKvj2OIna2Kn7jhalTUtom0EP23EH0BYlhKoFfGiWB7b8bt1VBwOW+7ppmKK8atn0
 bRYo3tRchoNjIrXK0qk6uPdajJ5QVliDNOkLUtfuaZqG1+ig6im6plet+JOknl+rT0X5uqCERxy
 MpD4mpfKMqQZt/YAuogASG4qjsQ6hv/GE9qKo
X-Google-Smtp-Source: AGHT+IEDBLzyvotQDHdgeUadRfrLThtjSEX8cwJuz2mnLVjDK+hMLUAuzhTdSt0x3jQyPiQhQl7KNg==
X-Received: by 2002:a05:600c:1d27:b0:453:10c1:cb21 with SMTP id
 5b1f17b1804b1-45365e3dffamr107598715e9.8.1750681204506; 
 Mon, 23 Jun 2025 05:20:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646cb5a8sm111194065e9.7.2025.06.23.05.20.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:20:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 15/26] accel: Introduce AccelOpsClass::cpu_target_realize()
 hook
Date: Mon, 23 Jun 2025 14:18:34 +0200
Message-ID: <20250623121845.7214-16-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Allow accelerators to set vCPU properties before its realization.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/accel-ops.h | 1 +
 accel/accel-common.c       | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 44b37592d02..a863fe59388 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -35,6 +35,7 @@ struct AccelOpsClass {
     void (*ops_init)(AccelClass *ac);
 
     bool (*cpus_are_resettable)(void);
+    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
     void (*cpu_reset_hold)(CPUState *cpu);
 
     void (*create_vcpu_thread)(CPUState *cpu); /* MANDATORY NON-NULL */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 56d88940f92..55d21b63a48 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -105,6 +105,9 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
         return false;
     }
+    if (acc->ops->cpu_target_realize && !acc->ops->cpu_target_realize(cpu, errp)) {
+        return false;
+    }
 
     return true;
 }
-- 
2.49.0


