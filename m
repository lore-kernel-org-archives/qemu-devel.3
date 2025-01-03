Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B75E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 23:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTqvZ-0007g6-IR; Fri, 03 Jan 2025 18:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTqvR-0007fI-Tr
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 18:17:54 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTqvQ-0004Il-9J
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 18:17:53 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso84180815e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 15:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735946269; x=1736551069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fd91irf1/HSw++4lXtUuV4IvFrA2wGjS8BYwmjz+8os=;
 b=w1Q5juwrkFU5OO5kFZeaDfapjX6xEks/bnvQYSfFABF2dm37ls/gjO59KR378hb+on
 QTxikA+ru8+dxdlWKL3A8qt5AQLbpr2iwzAyANSG69eSL/3PhczurnnpU1ju762124j7
 5bPQckD65HL4skk4jNqxiDlI6CsM66f7OWLXDhjE9dOiFFsZ+4xHlXzcxqURn1IwcikG
 VYAJVCSqkVg0LCWjuPsQVXtmhlbI1ORWFhRcMLM4OjcFGhWZhQrFl8Ipu7esG0uAzUg6
 Rs65zLAAItBukb8PX/u8bP0V00BN4ZmfAor7q4SAWd/aYmcayOR7nfJLZ3TRWi01X5R2
 3S6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735946269; x=1736551069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fd91irf1/HSw++4lXtUuV4IvFrA2wGjS8BYwmjz+8os=;
 b=Ihv/dihDBnh4Auy5rUwCcsG0kvotaM81EzLFqcoFyroSnvQf2qfdHJdUOK4BERwiqM
 xLL0LVKWnkH9HetWF/pZkBltaRAkc4S6xEwiuyc8iEA9NY9EgV+Ih+4zx+qm0wMDY4GB
 5xQ8TQ1qGuamCl44ncZ2vOUE3bVexvY0nS+kc2JUDymKXiMPDq9uIAJRK+zqBgkj7NbW
 J0coHHu6SeU44VxaTe8dWWGMTCZYUM6b/utodLsZ5nWvoPYU/2cbgp6O5bJClLozzGPr
 S9o/LjQPQXhOXlFvI3SRmEIhTAJupLb732ZN5FxbEhN9mbIvzrxevJANXhiejbtqKL/d
 Jitw==
X-Gm-Message-State: AOJu0Yxr/ZuhGSmk97GgMCLDfUAOI/TMFXxk6b9D7xLPLsmHlVsU+mha
 ReXd2ccInT88W3GsDRtC7Vyku4I0W1gz3syvI3W+6AriVJCLu8SfizVAJ7+jrSmZwv7FCECQ9Jk
 xeM4=
X-Gm-Gg: ASbGncuJAEsuJHs4SIvuU3lZD/AzRTCq7Yt91VgXbiha+J2Y0dSvwyHtgHD2RKLhztd
 eEw0xbXrLSED2XH2qKd5QLigbNv9sTBQwk6anMn8Fucn4WbjsrtwMY7Gek4wqk+MDpJDIAK/u0y
 NMVpnBOGywHDx4Hi9CaMG/8s+2qsfQJRAQleolFvi0BMXDeMwE2KP0z/fkPmsNSanob0CPTBuxR
 kGUz4ztVAcRRZg215sHb7PwKpXhpwxqDVPFviC2jY3R4616tdii/1HVJM+oI7AV4MrEoUKU+Dyb
 nPRNRLHXvZLUmbU/YpD3ZKk5RFyETjY=
X-Google-Smtp-Source: AGHT+IHdfjTPBusfrsOiih6/ZzrrEDIZwEfWmhibHzWr4VoyGvx6cSeRQvOWl5mWj93iXEHa1bm4mg==
X-Received: by 2002:a05:6000:2ae:b0:382:450c:2607 with SMTP id
 ffacd0b85a97d-38a221f3392mr37667024f8f.4.1735946269189; 
 Fri, 03 Jan 2025 15:17:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6c42sm530125255e9.9.2025.01.03.15.17.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 15:17:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 1/6] target: Only link capstone to targets requiring it
Date: Sat,  4 Jan 2025 00:17:33 +0100
Message-ID: <20250103231738.65413-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103231738.65413-1-philmd@linaro.org>
References: <20250103231738.65413-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

No need to link capstone to targets which don't use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 disas/meson.build        | 1 -
 target/arm/meson.build   | 1 +
 target/i386/meson.build  | 1 +
 target/ppc/meson.build   | 1 +
 target/s390x/meson.build | 1 +
 5 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/disas/meson.build b/disas/meson.build
index bbfa1197835..4e80adf36ae 100644
--- a/disas/meson.build
+++ b/disas/meson.build
@@ -20,4 +20,3 @@ common_ss.add(when: 'CONFIG_TCG', if_true: files(
 ))
 common_ss.add(files('disas-common.c'))
 system_ss.add(files('disas-mon.c'))
-specific_ss.add(capstone)
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 2e10464dbb6..3d64334657d 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,4 +1,5 @@
 arm_ss = ss.source_set()
+arm_ss.add(capstone)
 arm_ss.add(files(
   'cpu.c',
   'debug_helper.c',
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 2e9c472f49d..7d1363ec21f 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -1,4 +1,5 @@
 i386_ss = ss.source_set()
+i386_ss.add(capstone)
 i386_ss.add(files(
   'cpu.c',
   'gdbstub.c',
diff --git a/target/ppc/meson.build b/target/ppc/meson.build
index db3b7a0c33b..b5f509612ec 100644
--- a/target/ppc/meson.build
+++ b/target/ppc/meson.build
@@ -1,4 +1,5 @@
 ppc_ss = ss.source_set()
+ppc_ss.add(capstone)
 ppc_ss.add(files(
   'cpu-models.c',
   'cpu.c',
diff --git a/target/s390x/meson.build b/target/s390x/meson.build
index 3b34ae034cb..6e00793944e 100644
--- a/target/s390x/meson.build
+++ b/target/s390x/meson.build
@@ -1,4 +1,5 @@
 s390x_ss = ss.source_set()
+s390x_ss.add(capstone)
 s390x_ss.add(files(
   'cpu.c',
   'cpu_features.c',
-- 
2.47.1


