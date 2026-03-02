Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AF7D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvr-0001AR-PP; Mon, 02 Mar 2026 03:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuS-000534-8o
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuI-0001uw-Ky
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E1b0JYdWTmUMjfXhJgLYKJmJjYVhz92C9EWnenw/nwQ=;
 b=ZppBesEHRopsWkJofDjYjTIUGQZjvRx0TTePqEha1GSPL8KIZ8p6/yW4obbzrnN/q9Kvai
 ZGaHGt3iMZ6X8KSQdb+/4MgwFtDLJfICwRscDwUc25u8yasiK6TYxNd8RDG26sbcsW1LUA
 VoEIPTGf6A2w/0o7/bhY4J286KjuFN0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-ktoWASXnNZSn1GTtQvDPRQ-1; Mon, 02 Mar 2026 03:45:33 -0500
X-MC-Unique: ktoWASXnNZSn1GTtQvDPRQ-1
X-Mimecast-MFC-AGG-ID: ktoWASXnNZSn1GTtQvDPRQ_1772441132
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439b50dfca1so586231f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441130; x=1773045930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1b0JYdWTmUMjfXhJgLYKJmJjYVhz92C9EWnenw/nwQ=;
 b=EOxtsOx40ZPOLWpf60bP1AqYh5L9UXk2UJPrtw1EW4/nvCuGsER+ioJMGq8FxMTtsC
 LB26HJj40O0MrXSyASzSuC9Qq+oT8GEEUfMmrx1x1uDR4D0r3hYBhqVscTG/hSrqcMA+
 jRL8nui/eZDrG7Ubcm3aze7EmCITa0zHzCmqUJb6fPEQHc/AIjJUyOEb1ss4FNYenKcf
 pD+KpyZdWlhzfwt9lz0D/DsgsKMpUgMafsDV2GQ78jbgLEOhqiVR07u7puQxWBNO4WM7
 zc2RSzav6k0lE3geojLuj/ninDWarVZhdZrRFCcIs2VljXAsin+bHGV5M1Vau9DaARba
 I1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441130; x=1773045930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E1b0JYdWTmUMjfXhJgLYKJmJjYVhz92C9EWnenw/nwQ=;
 b=r+7ZqZZJTTHKlR71Tozu3a0et/evax60Dg43tCHhNl/2exFPOYPHYfGuYZzfA7W7HM
 uruew4XaxdO5EgZ3m9eXaaf0pZ2Rt2mhwfgFJduzHfsTANm+eGcBb2Ej7aaKsNKNbOgQ
 eAC3ooE0sCDk7S+Lob9qsL/qoEfPimbBtE0O0OjUC/l8SPO3JDgMusvfZ+pgbVMtYGGf
 26TfXt5LBeXAq/DUtOPijjwtcdYsI+ofU9KD2KLd64iBueiELmze0xGkY0vW1P847O6F
 5inUWyM+hj/O7ihTIQady7ZeqvoKu6DIUDUBmb1CJCYmSnQ4KsnQIbP14E+Lsene5rSC
 yCZw==
X-Gm-Message-State: AOJu0Yw4L5f3sIbkuy5Gz0uOC2vpQu7/lUnFjiP/6ru7/ti/KkshjeHI
 ekOGfLkDa1E9sqo1Q1D+4BqKSpQ+EmIBPFKiLXt6tkXJYQauTGo5JhsM8r1rGrnWF3UVQi1VOQx
 24zeatUeYJFriIkFql3CCq+PSGe+loT2fdbztMhmgWCBS3wFUFVs8n6DS5MijbNavH711amUkst
 kzRJsKTGfk/gtlvZPH5IWu2jVaIF975Cd4zPMKTb6a
X-Gm-Gg: ATEYQzwy1JMIfkhWoFxM9DQsGaA7Jyoungv0fKhpTmvVROW8N5HA0gL1i0p5t31A3T1
 lDpXoNEJr1/r9o4gz6W4RCkxvXu81j5nBCTVfFI1/UF91JFD0ms5+sL1TBez/j/ABawDyJwA4Ax
 GxPxRYMK0ZoZdI5keNjm4a3se3vsMSstXgeGIURccHmmFwPKusHldby8qME+BAlH1/ntXazQBHJ
 ZWebE19ENqNKUIAWCdNDBcUZ7M0gAlYDsEOR7UKBx8lPDT3UzdFBg+gycSGAKmBRZheRxIeNtH/
 07T9zYYlWVqVf54fGnFHR/aWSdupqhU2ZGK2u4jb2ACQvgKvoGxoawspAYOhm45dwO+Nw4YH4Bd
 fIGs9AbXHymD2dMLCp1J/YDMInT9pPrJgZHd26SDCMaad2aK+HadNe9gFaT5BtLC/pxTtLRIgi0
 A0egMye6Fif6rfwBBvqwRnL7aiCQM=
X-Received: by 2002:a5d:5d06:0:b0:435:e3bd:5838 with SMTP id
 ffacd0b85a97d-4399de00428mr20275686f8f.25.1772441130419; 
 Mon, 02 Mar 2026 00:45:30 -0800 (PST)
X-Received: by 2002:a5d:5d06:0:b0:435:e3bd:5838 with SMTP id
 ffacd0b85a97d-4399de00428mr20275630f8f.25.1772441129829; 
 Mon, 02 Mar 2026 00:45:29 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b1116698sm11757410f8f.16.2026.03.02.00.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>
Subject: [PULL 041/102] docs: Add Nitro Enclaves documentation
Date: Mon,  2 Mar 2026 09:42:36 +0100
Message-ID: <20260302084338.473368-42-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

Now that all pieces are in place to spawn Nitro Enclaves using
a special purpose accelerator and machine model, document how
to use it.

Signed-off-by: Alexander Graf <graf@amazon.com>

Link: https://lore.kernel.org/r/20260225220807.33092-12-graf@amazon.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                                |   1 +
 docs/system/confidential-guest-support.rst |   1 +
 docs/system/index.rst                      |   1 +
 docs/system/nitro.rst                      | 133 +++++++++++++++++++++
 4 files changed, 136 insertions(+)
 create mode 100644 docs/system/nitro.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 0458980d434..72153288c53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3031,6 +3031,7 @@ M: Alexander Graf <graf@amazon.com>
 S: Maintained
 F: hw/nitro/
 F: include/hw/nitro/
+F: docs/system/nitro.rst
 
 Subsystems
 ----------
diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
index 66129fbab64..562a7c3c285 100644
--- a/docs/system/confidential-guest-support.rst
+++ b/docs/system/confidential-guest-support.rst
@@ -41,5 +41,6 @@ Currently supported confidential guest mechanisms are:
 * Intel Trust Domain Extension (TDX) (see :doc:`i386/tdx`)
 * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
 * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
+* AWS Nitro Enclaves (see :doc:`nitro`)
 
 Other mechanisms may be supported in future.
diff --git a/docs/system/index.rst b/docs/system/index.rst
index 427b0204831..d297a952823 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -39,5 +39,6 @@ or Hypervisor.Framework.
    multi-process
    confidential-guest-support
    igvm
+   nitro
    vm-templating
    sriov
diff --git a/docs/system/nitro.rst b/docs/system/nitro.rst
new file mode 100644
index 00000000000..5907d6153eb
--- /dev/null
+++ b/docs/system/nitro.rst
@@ -0,0 +1,133 @@
+AWS Nitro Enclaves
+==================
+
+`AWS Nitro Enclaves <https://aws.amazon.com/ec2/nitro/nitro-enclaves/>`_
+are isolated compute environments that run alongside EC2 instances.
+They are created by partitioning CPU and memory resources from a parent
+instance and launching a signed Enclave Image Format (EIF) file inside
+a confidential VM managed by the Nitro Hypervisor.
+
+QEMU supports launching Nitro Enclaves on EC2 instances that have
+enclave support enabled, using the ``nitro`` accelerator and the
+``nitro`` machine type.
+
+Prerequisites
+-------------
+
+* An EC2 instance with Nitro Enclaves enabled
+* The ``nitro_enclaves`` kernel module loaded (provides ``/dev/nitro_enclaves``)
+* CPU cores allocated to the Nitro Enclaves pool via ``nitro-enclaves-allocator``
+* Huge pages allocated for Nitro Enclaves via ``nitro-enclaves-allocator``
+
+Quick Start
+-----------
+
+Launch a Nitro Enclave from a pre-built EIF file::
+
+    $ qemu-system-x86_64 -accel nitro,debug-mode=on -M nitro -nographic \
+        -smp 2 -m 512M -kernel enclave.eif
+
+Launch an enclave from individual kernel and initrd files::
+
+    $ qemu-system-x86_64 -accel nitro,debug-mode=on -M nitro -nographic \
+        -smp 2 -m 512M -kernel vmlinuz -initrd initrd.cpio \
+        -append "console=ttyS0"
+
+The same commands work with ``qemu-system-aarch64`` on Graviton based EC2
+instances.
+
+Accelerator
+-----------
+
+The ``nitro`` accelerator (``-accel nitro``) drives the
+``/dev/nitro_enclaves`` device to create and manage a Nitro Enclave.
+It handles:
+
+* Creating the enclave VM slot
+* Donating memory regions (must be huge page backed)
+* Adding vCPUs (must be full physical cores)
+* Starting the enclave
+* Notifying vsock bus devices of the enclave CID
+
+Accelerator options:
+
+``debug-mode=on|off``
+    Enable debug mode. When enabled, the Nitro Hypervisor exposes the
+    enclave's serial console output via a vsock port that the machine
+    model automatically connects to. In debug mode, PCR values are zero.
+    Default is ``off``.
+
+Machine
+-------
+
+The ``nitro`` machine (``-M nitro``) is a minimal, architecture-independent
+machine that provides only what a Nitro Enclave needs:
+
+* RAM (huge page backed via memfd)
+* vCPUs (defaults to ``host`` CPU type)
+* A Nitro vsock bus with:
+
+  - A heartbeat device (vsock server on port 9000)
+  - A serial console bridge (vsock client, debug mode only)
+
+Communication to the Nitro Enclave is limited to virtio-vsock. The Enclave
+is allocated a CID at launch at which it is reachable. A specific CID can
+be requested with ``-accel nitro,enclave-cid=<N>`` (0 lets the hypervisor
+choose). The assigned CID is readable from the vsock bridge device::
+
+    (qemu) qom-get /machine/peripheral/nitro-vsock enclave-cid
+
+EIF Image Format
+^^^^^^^^^^^^^^^^
+
+Nitro Enclaves boot from EIF (Enclave Image Format) files. When
+``-kernel`` points to an EIF file (detected by the ``.eif`` magic
+bytes), it is loaded directly into guest memory.
+
+When ``-kernel`` points to a regular kernel image (e.g. a bzImage or
+Image), the machine automatically assembles a minimal EIF on the fly
+from ``-kernel``, ``-initrd``, and ``-append``. This allows standard
+direct kernel boot without external EIF tooling.
+
+CPU Requirements
+^^^^^^^^^^^^^^^^
+
+Nitro Enclaves require full physical CPU cores. On hyperthreaded
+systems, this means ``-smp`` must be a multiple of the threads per
+core (typically 2).
+
+Nitro Enclaves can only consume cores that are donated to the Nitro Enclave
+CPU pool. You can configure the CPU pool using the ``nitro-enclaves-allocator``
+tool or manually by writing to the nitro_enclaves cpu pool parameter. To
+allocate vCPUs 1, 2 and 3, you can call::
+
+  $ echo 1,2,3 | sudo tee /sys/module/nitro_enclaves/parameters/ne_cpus
+
+Beware that on x86-64 systems, hyperthread siblings are not consecutive
+and must be added in pairs to the pool. Consult tools like ``lstopo``
+or ``lscpu`` for details about your instance's CPU topology.
+
+Memory Requirements
+^^^^^^^^^^^^^^^^^^^
+
+Enclave memory must be huge page backed. The machine automatically
+creates a memfd memory backend with huge pages enabled. To make the
+huge page allocation work, ensure that huge pages are reserved in
+the system. To reserve 1 GiB of memory on a 4 KiB PAGE_SIZE system,
+you can call::
+
+    $ echo 512 | sudo tee /proc/sys/vm/nr_hugepages
+
+Emulated Nitro Enclaves
+-----------------------
+
+In addition to the native Nitro Enclaves invocation, you can also use
+the emulated nitro-enclave machine target (see :doc:`i386/nitro-enclave`)
+which implements the x86 Nitro Enclave device model. While -M nitro
+delegates virtual machine device emulation to the Nitro Hypervisor, -M
+nitro-enclave implements all devices itself, which means it also works
+on non-EC2 instances.
+
+If you require NSM based attestation backed by valid AWS certificates,
+you must use -M nitro. The -M nitro-enclave model does not provide
+you with an AWS signed attestation document.
-- 
2.53.0


