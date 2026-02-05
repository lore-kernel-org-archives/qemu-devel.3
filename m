Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDB3ECD999
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5Vi-00071R-RI; Thu, 05 Feb 2026 14:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5Vc-0006ud-9n
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:25 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VY-0003AR-GA
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:24 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so915198f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321559; x=1770926359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4qhxa62Apjpg7nJHeZcMHBxhSVe14XdkTu3eXuhEWd0=;
 b=TaDkkcI2WCJC2FWtP87tphDk7qSXuMFxFQAKHQS6V8gPpkjFcFNhQ1veWrRh0EaAdL
 VnrSZsvBqgNO/gXiwJzRqnTZpgUFqzr+gMyPlNu0iKyElyrfrpv27VVnEYfUSnmPTi/J
 vSlW7Y04MqR5udsbHeDI33qKTnISMYYnddVXH4heq/RyuesPiKT3Z7y74GfgqcE1uupl
 sMUeUZHYvk7ezVq8ZSFz9lRYMY9EtMwKcvXIhB3zksFc+7VFRvf942zcN8/JKyAQnc3G
 AtBygJRW+R8vH4RaAd1MMexWeylH5xLcs8h7cqwXK1+civh9j8IijEtIksMFvujVowfo
 Niyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321559; x=1770926359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4qhxa62Apjpg7nJHeZcMHBxhSVe14XdkTu3eXuhEWd0=;
 b=tA15CuGkc3PG8q4eeY50dp+m/Lae4cVNtz/I6HTelAzBL0YaHdusaYmxr7AJB+jM5B
 FOSM0bK69tM69vtXfv1BRXwpERQriqb4y2jgSzCjGlGXDRDDIJGKURULEfNj4i3Abav2
 Mn52NUFDS068qo2A2se4gRxc9AxZPP67tAACvkdn5OnklH7kkdxzPX4BD5AjtRtb6LOA
 q8n6YboCiOVYws7ZuWezqlKT7V8K3jU09jlnrFNeiMEXFlROkAeCFs+kAhUTeG86EAQ1
 m61zM7ZupXk8ZsjtGbjCsiD++zLNgecRUlfIWl7D7V5FhvtaZg7Gx/idOjoxdSwHwAzZ
 9m+g==
X-Gm-Message-State: AOJu0Yw5JXMXnhAjreZ/B+ebkqx/BoyO+bVmFHUTDa7XAfKS3wKwGbmY
 k2viStnEW5ffEValeMcFxEt4JXwJajM5sGjvNwvt70IrOpNNZnhomqlPvxg3XsSpbw8=
X-Gm-Gg: AZuq6aKY1LBClZ3kPWoEWWUKc0x3pkENy935uQ3yyMiAcQJ9oiKIthk2WhfiY3rHOtT
 EwcAVCHKEIWayDzRCa1/wZ0d1gL50Eu/cr3L78HakZ/AiBbALko2yFif7hwbielhdHxgObAoSkx
 9OKbnnfOo8qb+LvyTzu3T7qTzfkFFg0X/YtKQdRX4h4J0BPfET5VQx+ileJGe7Zm/NPyJ1MyPOR
 /s5I4qMKwt+PChPE9blbS80jhMTCU5lk+eauWPRyv1CU9b07h1MGOYM8NiyG0nzACub2sUsXVnL
 r2prBhaoFzUNLkPMOc4i6fl8E9fU/Yzl5dOHL/3zwoE9KYch24j8xG1gNCLwLcqlV6fo6M76Z7p
 IznIDI2A53fEeBMfz/y4XkBwobDV54WpkCiX2EMz/5hJZ05rUnh+7CtD+pd3UcuHAeowGmCsXyA
 G9hoXNVaWC/DbySV4iZjc=
X-Received: by 2002:a05:6000:24ca:b0:430:f97a:6f42 with SMTP id
 ffacd0b85a97d-4362968d49cmr546325f8f.54.1770321558502; 
 Thu, 05 Feb 2026 11:59:18 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:59:17 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 23/29] system: Introduce -sync-quantum command line option
Date: Thu,  5 Feb 2026 20:58:18 +0100
Message-ID: <20260205195824.2610192-24-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Add a new global option '-sync-quantum' to specify the maximum time
interval, in nanoseconds, between synchronizations with remote peers.

In co-simulation environments (such as QEMU coupled with a SystemC
simulator), time must be synchronized periodically to ensure functional
accuracy. The 'sync-quantum' defines the maximum amount of time QEMU
can simulate ahead of its remote peers before a mandatory synchronization
event (sync packet) occurs.

This value is stored in the global 'global_sync_quantum' variable and
serves as a default hint for device models and Remote Port instances
to manage their simulation time.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 include/system/system.h |  2 ++
 qemu-options.hx         | 11 +++++++++++
 system/vl.c             |  8 ++++++++
 3 files changed, 21 insertions(+)

diff --git a/include/system/system.h b/include/system/system.h
index 0cd012004d..f187544147 100644
--- a/include/system/system.h
+++ b/include/system/system.h
@@ -59,6 +59,8 @@ extern MlockState mlock_state;
 
 extern const char *machine_path;
 
+extern uint64_t global_sync_quantum;
+
 #define MAX_OPTION_ROMS 16
 typedef struct QEMUOptionRom {
     const char *name;
diff --git a/qemu-options.hx b/qemu-options.hx
index b7dd2a64f0..8ef0c57507 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -765,6 +765,17 @@ SRST
     Preallocate memory when using -mem-path.
 ERST
 
+DEF("sync-quantum", HAS_ARG, QEMU_OPTION_sync_quantum,
+    "-sync-quantum Max time between synchroniation, nanoseconds.\n",
+    QEMU_ARCH_ALL)
+SRST
+``-sync-quantum val``
+    Maximum time between synchronization <val>.
+    This value is used to drive periodic synchronization with remote port peers.
+    It is also used to set device models sync-quantum properties controlling
+    the maximum amount of ahead of time simulation that is prefered (only a hint).
+ERST
+
 DEF("machine-path", HAS_ARG, QEMU_OPTION_machine_path,
     "-machine-path DIR A directory in which to create machine nodes\n",
     QEMU_ARCH_ALL)
diff --git a/system/vl.c b/system/vl.c
index 4750b1cf69..467646c3ff 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -182,6 +182,7 @@ static QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
 static BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
 static bool nographic = false;
 static int mem_prealloc; /* force preallocation of physical target memory */
+uint64_t global_sync_quantum;
 const char *machine_path;
 static const char *vga_model = NULL;
 static DisplayOptions dpy;
@@ -3129,6 +3130,13 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_mem_prealloc:
                 mem_prealloc = 1;
                 break;
+            case QEMU_OPTION_sync_quantum:
+                if (qemu_strtou64(optarg, &optarg, 10,
+                                  &global_sync_quantum)) {
+                    error_report("failed to parse sync_quantum");
+                    exit(1);
+                }
+                break;
             case QEMU_OPTION_machine_path:
                 machine_path = optarg;
                 break;
-- 
2.43.0


