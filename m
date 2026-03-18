Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157F4103E160
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oQp-0003bY-7C; Wed, 18 Mar 2026 06:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w2oQj-0003ZD-Tw
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:47:13 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w2oQi-0003NU-3V
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:47:13 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4852e9ca034so60586785e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773830830; x=1774435630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdLYTX5XCu0aJDUj9OehAyMtHZ53fPtprEnUaqi5uyI=;
 b=MmLlMUgr7h0HzJdiQc5LY0LyXhN7XSPEFk19SYVebhHZ3OGC8MZ36I1A3b85fmOCPZ
 /iK17AxS9n6/jV2f/Osun2/vBG9u/e3MNyi+1zk/IjghlXJl82P9DSRwETBfGEPz/Gen
 UwsxU/YSEX64mgdmadKMz1fPlKanJ/mV3OWjEMnZbkTQxLf9jZ5cyQNlU9mYhAbKypTW
 JAfRIfR396/4OsFlW1JvfNfnaXGiifXPwV1clAuiBZ2Ku2HeZroN8w+xjtmwjsxGRX+z
 cMUfZ7WnXgfQmXYrrnajwpdHKex8NZ/sasXAwnMgq7iW6iQTwm86OMgVKpBdR2jaZ0yd
 +rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773830830; x=1774435630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cdLYTX5XCu0aJDUj9OehAyMtHZ53fPtprEnUaqi5uyI=;
 b=h+OuMSllXzsK+5HdHSfgjiSK4/VWAiHYC6VylyyGuvuFqDYxM1AmvRAFu4VBqe++7/
 75LjMYxL6hdXYB08+RFus7QNjkDjiRJLMjTjOVjmFFmE1m/AlzyGTPrDaRbruL+XhZOU
 vdfbj2idXhyjH+6I9QTMCcrskupcRMlxXF5UJbVHOLYihAGUFXYLT4Nd8V4Z3w8aX0aW
 V43I9KMF9N4MJaPU2Jd7aD79gPMGCCgckO1FLD1kLLhSJZGKH6Xl1rRb55HiEn94Zw5X
 J3NKx7ag1HfzNYLky0hvKPjrS5asPeFVFbwnqnUF6WBO6PA19pTX+tmf6JzAHta4Q3Q8
 2yww==
X-Gm-Message-State: AOJu0YyGRY8MbmXXois1tU45W7ltnCz1YHNAmol1NaluZAhhUJmUVNrM
 u15+lzpj3nVtHxkV6w3AyjwxH618Edh9npI65zj0WsjlzwA5EhBDmx8nW0g7WaxT
X-Gm-Gg: ATEYQzzJUaObGcvEsp+VPIjDezpIMhfDe3ODNISWfexrj3bbNRtQyz2HA2tePQG15xn
 jNNt4bqXkmsDpU2mtmEmcqkVUjgZ11HK3iJkGF/OoLGTUmFA+cGqUnNWASK9ngYAmzgxI9K3x9x
 wnWQ+1kctL85Epunsw8CIgwU3MtHZpFqvAll6IQ1EIH1D7kTcSyAA1of+sSMIv8qq8ML5lSkd1y
 8XvHZ9dEPz50dhceTm+zIVqhXgA63E7LEMSI0wd+5EoqumUcxXKkF0UPEvq+4AJnOZRE9+TF8Hy
 L03DNYlO7YSjb4YghtFrJJjDhhW5jY24MDwCTZsDqcnANhg4a4VwyPD/Yvcb5yNjjkMCgf5xHs7
 Mrbjbt7jHgDSHrJE4mZNLRNy9dLalqTgFfuMw0OAB1I4oGNMKLJj2x+97CD+X+tg+uU+FGvWYob
 4FAKoud4QX1bx4uB9yQikbipmh9b6YfFD9Tu+Lgu7RAf48gbj3o0IwTjxByst/ZQ5QIA==
X-Received: by 2002:a05:600c:1d0b:b0:485:45fb:3472 with SMTP id
 5b1f17b1804b1-486f441bacdmr48347585e9.7.1773830830190; 
 Wed, 18 Mar 2026 03:47:10 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-80-194.adsl.net.t-com.hr.
 [93.143.80.194]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-486f420de8asm56471095e9.3.2026.03.18.03.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 03:47:09 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 alex.bennee@linaro.org, peter.maydell@linaro.org,
 pierrick.bouvier@linaro.org, philmd@linaro.org, Ruslan_Ruslichenko@epam.com
Subject: [RFC PATCH 9/9] docs: Add description of fault-injection plugin and
 subsystem
Date: Wed, 18 Mar 2026 11:46:40 +0100
Message-ID: <20260318104640.239752-10-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318104640.239752-1-ruslichenko.r@gmail.com>
References: <20260318104640.239752-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x336.google.com
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

The patch introduce documentation for newly added Fault Injection
plugin and subsystem.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 docs/fault-injection.txt | 111 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 docs/fault-injection.txt

diff --git a/docs/fault-injection.txt b/docs/fault-injection.txt
new file mode 100644
index 0000000000..05cbd48136
--- /dev/null
+++ b/docs/fault-injection.txt
@@ -0,0 +1,111 @@
+QEMU FAULT INJECTION PLUGIN DOCUMENTATION
+=========================================
+
+OVERVIEW
+--------
+The Fault Injection (FI) plugin is a testing tool for guest operating systems running in QEMU. It allows you to test how a guest OS or driver handles hardware-level errors. Currently, only AArch64 (ARM64) guest systems are supported.
+
+Errors (faults) can be injected in two ways:
+1. Statically using a configuration file when QEMU starts.
+2. Dynamically using a UNIX socket while the system is running.
+
+
+USAGE
+-----
+To use the plugin, add the "-plugin" option to the QEMU command.
+
+Command Line Examples:
+
+1. Using a static XML config file:
+qemu-system-aarch64 -machine virt -cpu cortex-a57 -plugin ./contrib/plugins/libfault_injection.so,config=faults.xml
+
+2. Using a dynamic UNIX socket:
+qemu-system-aarch64 -machine virt -cpu cortex-a57 -plugin ./contrib/plugins/libfault_injection.so,socket=/tmp/fi_socket.sock
+
+3. Using both at the same time:
+qemu-system-aarch64 -machine virt -cpu cortex-a57 -plugin ./contrib/plugins/libfault_injection.so,config=faults.xml,socket=/tmp/fi_socket.sock
+
+To send a dynamic fault over the socket while QEMU is running, an XML string can be sent directly to the socket file.
+
+
+CORE CONCEPTS
+-------------
+A fault configuration has two main parts:
+- Trigger: When should the fault happen? (Example: when the CPU reaches a specific address).
+- Target: What should be corrupted or injected? (Example: change a CPU register).
+
+SUPPORTED TRIGGERS:
+- PC      : Triggers when the CPU executes an instruction at a specific Virtual Address.
+- SYS_REG : Triggers when the guest reads a specific System Register (like cntvct_el0).
+- RAM     : Triggers when the guest accesses a specific Virtual Address in memory.
+- MMIO    : Triggers when the guest reads from a hardware device at a Physical Address.
+- TIMER   : Triggers at a specific guest virtual time (in nanoseconds).
+
+SUPPORTED TARGETS:
+- CPU_REG : Changes a CPU register (x0 to x30).
+- RAM     : Overwrites physical memory with a fake value.
+- MMIO    : Modifies a hardware device read with a fake value.
+- IRQ     : Injects a hardware interrupt into the primary INTC.
+- EXCP    : Injects a CPU exception (like an SError).
+- CUSTOM  : Triggers a custom device error (custom handler registered by device model).
+
+
+XML CONFIGURATION FORMAT
+------------------------
+The plugin uses a simple XML format. Each fault is defined by a <Fault /> tag. Multiple fault tags can be added inside one file by wrapping them in a <Faults> block.
+
+The following attributes can be used in the tag:
+- trigger           : The event that starts the fault (PC, TIMER, etc.).
+- trigger_condition : The value needed to activate the trigger (Address, Time, or System Register Name).
+- target            : The system part to corrupt (CPU_REG, IRQ, etc.). This is optional for RAM and MMIO triggers.
+- target_data       : The specific ID or address of the target.
+- fault_data        : The corrupted value to inject.
+- size              : (Optional) Size in bytes for memory operations. Default is 8.
+- cpu               : (Optional) CPU index for IRQs. Default is 0.
+- irq_type          : (Optional) For IRQs. Can be SPI, PPI, or SGI. Default is SPI.
+- fault_name        : (Optional) Required only for CUSTOM targets (string with the name of the custom fault).
+
+
+EXAMPLES
+--------
+
+Example 1: Corrupt a CPU Register on a Specific Instruction
+This changes register x1 to 0 when the CPU executes the instruction at virtual address 0xa00002e7714.
+
+<Faults>
+    <Fault trigger="PC" trigger_condition="0xa00002e7714" target="CPU_REG" target_data="1" fault_data="0" />
+</Faults>
+
+
+Example 2: Modify an MMIO Read
+When the guest OS tries to read a hardware device at physical address 0x0800FFE8, the plugin ignores the real hardware and returns the fake value 0x0.
+
+<Faults>
+    <Fault trigger="MMIO" trigger_condition="0x0800FFE8" fault_data="0" />
+</Faults>
+
+
+Example 3: Inject a Hardware Interrupt using a Timer
+This injects SPI interrupt number 77 into CPU 0 after 10s of virtual guest time and modifies the results of MMIO reads starting at this time.
+
+<Faults>
+    <Fault trigger="TIMER" trigger_condition="10000000000" target="IRQ" target_data="77" fault_data="0" />
+    <Fault trigger="TIMER" trigger_condition="10000000000" target="MMIO" target_data="0x09050060" fault_data="0x180" />
+    <Fault trigger="TIMER" trigger_condition="10000000000" target="MMIO" target_data="0x09050064" fault_data="0x0" />
+</Faults>
+
+
+Example 4: Trigger a Custom SMMUv3 Command Queue Error
+After 10s of guest virtual time, this injects a custom SMMUv3 Command Queue error into the SMMU device located at 0x09050000.
+
+<Faults>
+    <Fault trigger="TIMER" trigger_condition="10000000000" target="CUSTOM" fault_name="smmu_gerror_cmdq" target_data="0x09050000" fault_data="1" />
+</Faults>
+
+
+Example 5: Inject a CPU Exception (SError)
+This injects a Virtual SError (Exception Index 24) when the CPU executes the instruction at 0xffff8000802dfed0. The syndrome register is set to the value 0xbf000002.
+
+<Faults>
+    <Fault trigger="PC" trigger_condition="0xffff8000802dfed0" target="EXCP" target_data="24" fault_data="0xbf000002" />
+</Faults>
-- 
2.43.0


