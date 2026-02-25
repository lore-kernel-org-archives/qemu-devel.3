Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC65FD45F8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 22:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvN4y-0001N5-Ri; Wed, 25 Feb 2026 17:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=509822c20=graf@amazon.de>)
 id 1vvN4t-00018q-I1; Wed, 25 Feb 2026 17:09:56 -0500
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.83.148.184])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=509822c20=graf@amazon.de>)
 id 1vvN4q-00014c-Tk; Wed, 25 Feb 2026 17:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1772057392; x=1803593392;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+aizdLXyc6doicL/j8QKWc/fhiSn6T+aU4ZL0eEP5CQ=;
 b=Sk3mzyPBemxUcGRhVM7cmrSzDOLbATKLLgLkZClQkgKxSf9eE5hdYBqC
 /vwbwssUhnWPqMhJvv2DrCg5nIFtvu8gCYNe+T7VVUiUvs8efD4VeXWqP
 kn+5iJVlo18mVhJvDL/RU7lSA/I2lyCRCGqLJchvBPlT1tlOpP9D1GoCJ
 BqIKa3NJgdpZ/IfHeTgBwE2/UgD1HuKNaXF5no7hN/0uZncKIFV3+QkUx
 a/BePXJtJrsN2GK+KILUIhWG5zu+ge5+HdcntzyShtO5e80I89HAmbTWW
 DlDvtQYILBU8s4Uf3YesWcODyIqbl+BsdkzvLBrbDEkXANSYC8VJkx7J8 g==;
X-CSE-ConnectionGUID: tLqGqKfoQey116EMykT4vQ==
X-CSE-MsgGUID: aaJscaJQRm+2mkBrFd5ZkQ==
X-IronPort-AV: E=Sophos;i="6.21,311,1763424000"; d="scan'208";a="13581656"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 22:09:47 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:21158]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.105:2525]
 with esmtp (Farcaster)
 id c68b9de9-809b-4cbe-b307-21b7fd766657; Wed, 25 Feb 2026 22:09:47 +0000 (UTC)
X-Farcaster-Flow-ID: c68b9de9-809b-4cbe-b307-21b7fd766657
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 25 Feb 2026 22:09:45 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 25 Feb 2026 22:09:42 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Thomas
 Huth" <thuth@redhat.com>, <alex.bennee@linaro.org>, <philmd@linaro.org>,
 <berrange@redhat.com>, <marcandre.lureau@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, <mst@redhat.com>, Dorjoy Chowdhury
 <dorjoychy111@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyler Fanelli <tfanelli@redhat.com>,
 <mknaust@amazon.com>, <nh-open-source@amazon.com>
Subject: [PATCH v3 11/11] docs: Add Nitro Enclaves documentation
Date: Wed, 25 Feb 2026 22:08:05 +0000
Message-ID: <20260225220807.33092-12-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260225220807.33092-1-graf@amazon.com>
References: <20260225220807.33092-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=35.83.148.184;
 envelope-from=prvs=509822c20=graf@amazon.de;
 helo=pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Now that all pieces are in place to spawn Nitro Enclaves using
a special purpose accelerator and machine model, document how
to use it.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - explain the nitro bus, its notification flow and topology
  - give example for qom-get of the enclave cid
  - document the accel enclave-cid property
---
 MAINTAINERS                                |   1 +
 docs/system/confidential-guest-support.rst |   1 +
 docs/system/index.rst                      |   1 +
 docs/system/nitro.rst                      | 133 +++++++++++++++++++++
 4 files changed, 136 insertions(+)
 create mode 100644 docs/system/nitro.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 53ce075e9a..5e9e429530 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3027,6 +3027,7 @@ M: Alexander Graf <graf@amazon.com>
 S: Maintained
 F: hw/nitro/
 F: include/hw/nitro/
+F: docs/system/nitro.rst
 
 Subsystems
 ----------
diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
index 66129fbab6..562a7c3c28 100644
--- a/docs/system/confidential-guest-support.rst
+++ b/docs/system/confidential-guest-support.rst
@@ -41,5 +41,6 @@ Currently supported confidential guest mechanisms are:
 * Intel Trust Domain Extension (TDX) (see :doc:`i386/tdx`)
 * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
 * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
+* AWS Nitro Enclaves (see :doc:`nitro`)
 
 Other mechanisms may be supported in future.
diff --git a/docs/system/index.rst b/docs/system/index.rst
index 427b020483..d297a95282 100644
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
index 0000000000..5907d6153e
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
2.47.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


