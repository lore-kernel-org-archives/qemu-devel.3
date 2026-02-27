Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7975FEFB6F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 23:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw7GO-0001hL-Qw; Fri, 27 Feb 2026 18:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw7GJ-0001gj-Ge
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 18:28:47 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw7GH-00026T-PB
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 18:28:47 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43770c94dfaso2384533f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 15:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772234922; x=1772839722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E1P2WA4S+R9FV+NsLzHuWrSFnCqT+fKA/hB8TermKBM=;
 b=eTvH19zdsat7Q9SflOXIbNwBNDFE1OP2hRdEgsLy7EBEM93wSj7TQoz+piBenvKbEd
 +GMHN6Ex99e/X6xXJVbQbjG5G9TspF3182oWKByGPib1q0Ygyc4+8gmv71NkYKNHEGdX
 35v6dYTl7wZQvV6sbIHEUhxH9Kj2L7qCSwbU4z+AuRQaaWFtzc+Z4q51Os+Ay/CJOD8/
 EgYtxnheZ1xG622somgpPg2HUBEtZ0vsFl9xemsCICoxvkgxauc5ESF42740saVe6FNz
 6GDPv84k5apocVbhJTU8LgwMBZ8KwQC4zvlZN3QY5Xvo/kSdW8/LgBSyNcsr4Z9GLUPO
 akIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772234922; x=1772839722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1P2WA4S+R9FV+NsLzHuWrSFnCqT+fKA/hB8TermKBM=;
 b=lLI7DUgfuxtdCQ2p0xw9VV1NhjQw4gMfBuormu0pDHXNYEFJF4qacrBVRjrJD/dxAn
 zMhcGDzrKS1UpVt7v54CmKv9PJQAivBuR4Sg7TpAbbpBK7e+qSyXYUbHyZSKCieVX6n3
 eVVJweYqNilWH9RIFQstkhAyil5WKo6GuqiY31749rSabgojtTUD6zzpYY7f10hmhU5r
 ++M0AF/Lp12S/eDNUKUnrmoBzf1pFJgd5YAiJlhgbxSS0EJ0xfI0K9PoRJ9aCOzgE5bB
 5KrDy35UXptwufLVsCwaLZywkfhlnT+Yuba/+jcLSMZ3XfJbmHBkj3/tHvE1IypxCLjO
 ZvLg==
X-Gm-Message-State: AOJu0YwH2Lc3+CeYucZuz3PNg+9+88pD4QSKjnPoPT8+G3aDogJAAdE8
 W1Wy2Wsy9bWedGg7OMR26RF3U5hsqbO4CX49qdCcQ68Jr4HFDlDtTOEqKduEs1F3+0mO02DbdMR
 vN/KeLOQ=
X-Gm-Gg: ATEYQzwnSK04x57gXaLbIBEO4ioaIKQyYzKcsb6oH3hrtbHwjC7udnfIhGIZ8uVVV8f
 71/GHBLkLLMyfRZ2DlRTiDj1i42eT/iEUKp3KcKnJMLTSnKQjWMv1Oojg8GU+18Y4EGuLZshobI
 LPuh5H0NHL8BF9caiqJSlUVtAs6xCN+aM60Td3NKjvCLg8KyjAKh6iPLt4Ie5HP8XjZV86pRqEO
 ahiYmu9vm6+mU1imfk+bZ2zaoQOm8a4KC3qaV/iw2pvnp+nYHt8dBiDLDTP1HRl+3X1hJJUqOsF
 ERYkCtT+EBZUpU8zY8vZhAVuwS2KP3W8yjDBm57XEZhGV6gq+AYq2/QViHQHmFV2HaMGkoIzPBy
 xTqSMAd2CaWhs7XBhnXCav9gZVnmqqg5jBHZW/1zCeTWFHA4/X5v4E8RpTNYzgyX8FnRq9Bh+tv
 QYu7PHEFS6xDsTw1xPFwTAEIyAi6kxhgwIq37izMm/m7o+poYll7coibIgwVDd1TMQK71SqNQP
X-Received: by 2002:a05:600c:8b12:b0:483:71f7:2794 with SMTP id
 5b1f17b1804b1-483c9bbbe39mr79735355e9.15.1772234921880; 
 Fri, 27 Feb 2026 15:28:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfbb465bsm167506335e9.3.2026.02.27.15.28.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Feb 2026 15:28:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Conor Dooley <conor@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>, devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] hw/riscv: Remove deprecated 'riscv,
 delegate' device-tree property
Date: Sat, 28 Feb 2026 00:28:37 +0100
Message-ID: <20260227232838.23392-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

The "riscv,delegate" DT property was added in QEMU 7.0 as part of
the AIA APLIC support.  The property changed name during the
review process in Linux and the correct name ended up being
"riscv,delegation". The incorrect name was added as alias, and
deprecated in v9.1 (commit 38facfa8432), so can be removed for
v11.0.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Binary file pc-bios/opensbi-riscv32-generic-fw_dynamic.bin matches
Binary file pc-bios/opensbi-riscv64-generic-fw_dynamic.bin matches
---
 docs/about/deprecated.rst       | 11 -----------
 docs/about/removed-features.rst | 11 +++++++++++
 hw/riscv/virt.c                 |  9 ---------
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 1d5c4f3707c..cc5502e5394 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -494,17 +494,6 @@ versions, aliases will point to newer CPU model versions
 depending on the machine type, so management software must
 resolve CPU model aliases before starting a virtual machine.
 
-RISC-V "virt" board "riscv,delegate" DT property (since 9.1)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-The "riscv,delegate" DT property was added in QEMU 7.0 as part of
-the AIA APLIC support.  The property changed name during the review
-process in Linux and the correct name ended up being
-"riscv,delegation".  Changing the DT property name will break all
-available firmwares that are using the current (wrong) name.  The
-property is kept as is in 9.1, together with "riscv,delegation", to
-give more time for firmware developers to change their code.
-
 x86 "isapc" board use of modern x86 CPUs (since 10.2)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 41bec8b8e38..0a62e87ee35 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1232,6 +1232,17 @@ converting to using TCG plugins they should contact the qemu-devel
 mailing list.
 
 
+Firmware, ACPI, Device Tree
+---------------------------
+
+RISC-V "virt" board "riscv,delegate" DT property (removed in 11.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The "riscv,delegate" DT property was added in QEMU 7.0 as part of
+the AIA APLIC support.  The property changed name during the review
+process in Linux and the correct name ended up being "riscv,delegation".
+
+
 System emulator devices
 -----------------------
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index bbce2fb6671..a1c323e66df 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -666,15 +666,6 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
         qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegation",
                                aplic_child_phandle, 0x1,
                                VIRT_IRQCHIP_NUM_SOURCES);
-        /*
-         * DEPRECATED_9.1: Compat property kept temporarily
-         * to allow old firmwares to work with AIA. Do *not*
-         * use 'riscv,delegate' in new code: use
-         * 'riscv,delegation' instead.
-         */
-        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
-                               aplic_child_phandle, 0x1,
-                               VIRT_IRQCHIP_NUM_SOURCES);
     }
 
     riscv_socket_fdt_write_id(ms, aplic_name, socket);
-- 
2.52.0


