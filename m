Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869B4EE01E9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 21:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so8Ms-0002GG-9k; Tue, 10 Sep 2024 17:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1so8Mr-0002B0-4h; Tue, 10 Sep 2024 17:25:45 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1so8Mo-0002Iz-U0; Tue, 10 Sep 2024 17:25:44 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6d3f4218081so59068327b3.1; 
 Tue, 10 Sep 2024 14:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726003541; x=1726608341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sul7/BXCsjPRlqt3G2+RLEijKUxX/bYzUBFroC3XHX8=;
 b=NNw/AwJWudejZh8znGmBJrK+PnlYsdROYO8YiMIOkwa9ILdkfeZHr9I+R7rWw661Aq
 zznGhVbvTnO/Q/0fUbIAMngKu6g8Q9tl+Vgd1zgHQRatchdy8JognfSYQa3YgihaEyNL
 jp4RttNWIcZHZdM/+meFaG+YCyqeW9XGzFCQ9o0Xk6tQfQ1a02wC1P28f4cMccTpbB9/
 y+MAusBtm5nlWc3m1PQmD6pPI4EwGIud8lmz3JbLDoGjY86jfhxZOJCcuSWinQTiFNxr
 67xbLuBfkZQvvKdiWRoBUzAI52/dpJ8rr5d7x9mk7ozzrIs49Unk83OQwVf/nuWKvCCS
 D6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726003541; x=1726608341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sul7/BXCsjPRlqt3G2+RLEijKUxX/bYzUBFroC3XHX8=;
 b=Ici0+Jq1O2UdHCYqayx8tu3n7/R8R0FX9KP9tjMmUrFKmQue0JPfj1PymRORz8d/5M
 2/Xu/4/5JNcjaN2VHpl02kDAYYiMZagk5vmFaNGvjBMaPEijLtH0rUGsrtRkYRCwvRSq
 nGIlZH/raS2mmSLJ3BWbWnflonWzUTIz7YOPVmLzHz9VDCeQSHICUmqO/S4VpDlilpus
 v3VG9ioEuacvX+XP0kud9Dou4NOZOwXMRhv9bBTS8oRyHY1xcUYvhZV6LP15SqL0t8ZG
 YwRw5Osowkd0k7N+NzvtzbdgLoNm4XkF+S5lBF4lzfd578uK9I/YJ4a+5EfHmc1+2N9j
 ux6g==
X-Gm-Message-State: AOJu0YyhKUdZHxxPM/Qa78hqRkYKQBkgq153rug0Y+BK+QzrpAZNYYxF
 sIVOaV06TZ3tMTzgYRpdm2HJT0fwwGRFgz0Yd9w2eOB4W2JVGV2CoQjavOew
X-Google-Smtp-Source: AGHT+IF9uGnRMRk4MebQSBNtEVoh/GtzWzYdf0FBa4If4bNikE0RBCGI9Do70Bi5nVkaqO8pB/iRuQ==
X-Received: by 2002:a05:690c:350e:b0:6af:b0cc:abda with SMTP id
 00721157ae682-6db45164af1mr168531427b3.40.1726003541368; 
 Tue, 10 Sep 2024 14:25:41 -0700 (PDT)
Received: from localhost ([2600:1700:830:3db0::14])
 by smtp.gmail.com with UTF8SMTPSA id
 00721157ae682-6db9650df6dsm4428357b3.103.2024.09.10.14.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 14:25:40 -0700 (PDT)
From: Gregor Haas <gregorhaas1997@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, dbarboza@ventanamicro.com,
 alistair.francis@wdc.com, Gregor Haas <gregorhaas1997@gmail.com>
Subject: [PATCH v5 2/2] docs/system/riscv: Add documentation for command-line
 OpenSBI domains
Date: Tue, 10 Sep 2024 14:25:33 -0700
Message-ID: <20240910212533.986734-5-gregorhaas1997@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910212533.986734-1-gregorhaas1997@gmail.com>
References: <20240910212533.986734-1-gregorhaas1997@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=gregorhaas1997@gmail.com; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Signed-off-by: Gregor Haas <gregorhaas1997@gmail.com>
---
 MAINTAINERS                           |   1 +
 docs/system/riscv/opensbi_domains.rst | 156 ++++++++++++++++++++++++++
 docs/system/target-riscv.rst          |  10 ++
 3 files changed, 167 insertions(+)
 create mode 100644 docs/system/riscv/opensbi_domains.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b9f5b7432..5eb65cc499 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -361,6 +361,7 @@ RISC-V OpenSBI domain support
 M: Gregor Haas <gregorhaas1997@gmail.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
+F: docs/system/riscv/opensbi_domains.rst
 F: hw/riscv/opensbi_domain.c
 F: include/hw/riscv/opensbi_domain.h
 
diff --git a/docs/system/riscv/opensbi_domains.rst b/docs/system/riscv/opensbi_domains.rst
new file mode 100644
index 0000000000..b8bbf52738
--- /dev/null
+++ b/docs/system/riscv/opensbi_domains.rst
@@ -0,0 +1,156 @@
+OpenSBI Domains
+===============
+
+OpenSBI has support for domains, which are partitions of CPUs and memory into
+isolated compartments. Domains can be specified in the device tree according to
+a standardized format [1_], which OpenSBI parses at boot time to initialize all
+system domains. Depending on the specific QEMU machine being used, these domain
+configurations can be specified on the QEMU command line. Currently, this is
+only possible for the ``virt`` machine. To enable this functionality for a new
+machine, the initialization code must call ``create_fdt_opensbi_domains`` after
+all device tree nodes for peripherals have been initialized. This is to ensure
+that references to devices work for MMIO regions.
+
+There are two "devices" that are used to configure OpenSBI domains with this
+mechanism: ``opensbi-memregion`` and ``opensbi-domain``.
+
+Memregions
+----------
+
+OpenSBI memregions can be added to the machine's device tree with the following
+flag:
+
+.. code-block:: bash
+
+    -device opensbi-memregion
+
+For this device flag, the following options are implemented:
+
+- ``id``: The name of the memregion. This name is later used to link this
+  region to a domain if desired, in which case this argument is required.
+- ``base`` (required): The base address of this memregion. This address must
+  be aligned to ``2 ^ order``.
+- ``order`` (required): The ``log2`` of the memregion's size, which must be
+  between 3 and ``__riscv_xlen`` inclusive.
+- ``mmio`` (optional): A boolean indicating whether the specified physical
+  address range belongs to an MMIO-mapped peripheral device.
+- ``deviceX`` (optional): If ``mmio`` is indicated, this is the device tree
+  path to the ``X``-th device corresponding to this physical address range,
+  where ``0 <= X < OPENSBI_MEMREGION_DEVICES_MAX`` (default 16).
+
+Domains
+-------
+
+OpenSBI domains can be added to the machine's device tree with the following
+flag:
+
+.. code-block:: bash
+
+    - device opensbi-domain
+
+For this device flag, the following options are implemented:
+
+- ``id`` (required): The name of the domain, which becomes its identifier in
+  the device tree
+- ``boot-hart`` (optional): The HART booting the domain instance.
+- ``possible-harts`` (optional): The contiguous list of CPUs for the domain
+  instance, specified as ``firstcpu[-lastcpu]`` (e.g. ``0-3``).
+- ``next-arg1`` (optional): The 64 bit next booting stage arg1 for the domain
+  instance.
+- ``next-addr`` (optional): The 64 bit next booting stage address for the
+  domain instance.
+- ``next-mode`` (optional): The 32 bit next booting stage mode for the domain
+  instance.
+- ``system-reset-allowed`` (optional): Whether the domain instance is allowed
+  to do system reset.
+- ``system-suspend-allowed`` (optional): Whether the domain instance is allowed
+  to do system suspend.
+
+Furthermore, memregions can be linked to domains using the following options:
+
+- ``regionX`` (optional): The ``id`` of the ``X``-th region for this domain,
+  where ``0 <= X < OPENSBI_DOMAIN_MEMREGIONS_MAX`` (default 16).
+- ``permsX`` (optional): Access permissions for the ``X``-th region for this
+  domain, ``0 <= X < OPENSBI_DOMAIN_MEMREGIONS_MAX`` (default 16). This must be
+  encoded using OpenSBI's permission encoding scheme in ``sbi_domain.h``, and
+  copied below at the time of writing for convenience
+
+.. code-block:: c
+
+    /** Flags representing memory region attributes */
+    #define SBI_MEMREGION_M_READABLE	(1UL << 0)
+    #define SBI_MEMREGION_M_WRITABLE	(1UL << 1)
+    #define SBI_MEMREGION_M_EXECUTABLE	(1UL << 2)
+    #define SBI_MEMREGION_SU_READABLE	(1UL << 3)
+    #define SBI_MEMREGION_SU_WRITABLE	(1UL << 4)
+    #define SBI_MEMREGION_SU_EXECUTABLE	(1UL << 5)
+
+Example
+-------
+
+A complete example command line is shown below:
+
+.. code-block:: bash
+
+    $ qemu-system-riscv64 -machine virt -bios fw_jump.bin -cpu max -smp 2 -m 4G -nographic \
+            -device opensbi-memregion,id=mem,base=0xBC000000,order=26,mmio=false \
+            -device opensbi-memregion,id=uart,base=0x10000000,order=12,mmio=true,device0="/soc/serial@10000000" \
+            -device opensbi-domain,id=domain,possible-harts=0-1,boot-hart=0x0,next-addr=0xBC000000,next-mode=1,region0=mem,perms0=0x3f,region1=uart,perms1=0x3f
+
+As a result of the above configuration, QEMU will add the following subnodes to
+the device tree:
+
+.. code-block:: dts
+
+    chosen {
+            opensbi-domains {
+                    compatible = "opensbi,domain,config";
+
+                    domain {
+                            next-mode = <0x01>;
+                            next-addr = <0x00 0xbc000000>;
+                            boot-hart = <0x03>;
+                            regions = <0x8000 0x3f 0x8002 0x3f>;
+                            possible-harts = <0x03 0x01>;
+                            phandle = <0x8003>;
+                            compatible = "opensbi,domain,instance";
+                    };
+
+                    uart {
+                            phandle = <0x8002>;
+                            devices = <0x1800000>;
+                            mmio;
+                            order = <0x0c>;
+                            base = <0x00 0x10000000>;
+                            compatible = "opensbi,domain,memregion";
+                    };
+
+                    mem {
+                            phandle = <0x8000>;
+                            order = <0x1a>;
+                            base = <0x00 0xbc000000>;
+                            compatible = "opensbi,domain,memregion";
+                    };
+            };
+    };
+
+This results in OpenSBI output as below, where regions 01-03 are inherited from
+the root domain and regions 00 and 04 correspond to the user specified ones:
+
+.. code-block:: console
+
+    Domain1 Name              : domain
+    Domain1 Boot HART         : 0
+    Domain1 HARTs             : 0,1
+    Domain1 Region00          : 0x0000000010000000-0x0000000010000fff M: (I,R,W,X) S/U: (R,W,X)
+    Domain1 Region01          : 0x0000000002000000-0x000000000200ffff M: (I,R,W) S/U: ()
+    Domain1 Region02          : 0x0000000080080000-0x000000008009ffff M: (R,W) S/U: ()
+    Domain1 Region03          : 0x0000000080000000-0x000000008007ffff M: (R,X) S/U: ()
+    Domain1 Region04          : 0x00000000bc000000-0x00000000bfffffff M: (R,W,X) S/U: (R,W,X)
+    Domain1 Next Address      : 0x00000000bc000000
+    Domain1 Next Arg1         : 0x0000000000000000
+    Domain1 Next Mode         : S-mode
+    Domain1 SysReset          : no
+    Domain1 SysSuspend        : no
+
+.. _1: https://github.com/riscv-software-src/opensbi/blob/master/docs/domain_support.md
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index ba195f1518..bb776ea5f3 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -92,3 +92,13 @@ the images they need.
 * ``-bios <file>``
 
 Tells QEMU to load the specified file as the firmware.
+
+RISC-V Devices
+--------------
+
+There are some RISC-V specific devices that can be specified:
+
+.. toctree::
+    :maxdepth: 1
+
+    riscv/opensbi_domains
-- 
2.46.0


