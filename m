Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D381C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 07:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkeJb-0003by-5A; Wed, 19 Feb 2025 02:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tkeIr-0002c8-IR
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 02:15:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tkeIo-0005Nc-IJ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 02:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739949323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=erzI/Ncs6Hnb/gTlWEX/91dVhKQq6/Z2g6NMnZjQjkY=;
 b=Vu/zKjIbcyhFxz+026Ai6+1dUtw4cPevvD24TU+w/qe7heaatREkjY73LQ9Uxy/s/Y+zIA
 63fQSB1ezYYrDFtkiY3tx9FN3o7UvZoY5l7yp9CH97kPa1pnfyr/HplOLmVokrCxK+qART
 CyhuSYZXUI6JM1gaU2MXVJoIvQlxWUM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-4w4Dkaf9MIWrXhTPG0cc_g-1; Wed,
 19 Feb 2025 02:15:18 -0500
X-MC-Unique: 4w4Dkaf9MIWrXhTPG0cc_g-1
X-Mimecast-MFC-AGG-ID: 4w4Dkaf9MIWrXhTPG0cc_g_1739949317
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2314B1800985; Wed, 19 Feb 2025 07:15:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.78])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8356C1800944; Wed, 19 Feb 2025 07:15:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A1E371801B34; Wed, 19 Feb 2025 08:14:33 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Ard Biesheuvel <ardb@kernel.org>,
 Michael Roth <michael.roth@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 graf@amazon.com, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v4 24/24] docs: add uefi variable service documentation
Date: Wed, 19 Feb 2025 08:14:26 +0100
Message-ID: <20250219071431.50626-25-kraxel@redhat.com>
In-Reply-To: <20250219071431.50626-1-kraxel@redhat.com>
References: <20250219071431.50626-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/devel/index-internals.rst |  1 +
 docs/devel/uefi-vars.rst       | 68 ++++++++++++++++++++++++++++++++++
 hw/uefi/LIMITATIONS.md         |  7 ++++
 3 files changed, 76 insertions(+)
 create mode 100644 docs/devel/uefi-vars.rst
 create mode 100644 hw/uefi/LIMITATIONS.md

diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index bca597c65895..7a0678cbdd3a 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -20,6 +20,7 @@ Details about QEMU's various subsystems including how to add features to them.
    s390-cpu-topology
    s390-dasd-ipl
    tracing
+   uefi-vars
    vfio-iommufd
    writing-monitor-commands
    virtio-backends
diff --git a/docs/devel/uefi-vars.rst b/docs/devel/uefi-vars.rst
new file mode 100644
index 000000000000..0151a26a0a6f
--- /dev/null
+++ b/docs/devel/uefi-vars.rst
@@ -0,0 +1,68 @@
+==============
+UEFI variables
+==============
+
+Guest UEFI variable management
+==============================
+
+The traditional approach for UEFI Variable storage in qemu guests is
+to work as close as possible to physical hardware.  That means
+providing pflash as storage and leaving the management of variables
+and flash to the guest.
+
+Secure boot support comes with the requirement that the UEFI variable
+storage must be protected against direct access by the OS.  All update
+requests must pass the sanity checks.  (Parts of) the firmware must
+run with a higher privilege level than the OS so this can be enforced
+by the firmware.  On x86 this has been implemented using System
+Management Mode (SMM) in qemu and kvm, which again is the same
+approach taken by physical hardware.  Only privileged code running in
+SMM mode is allowed to access flash storage.
+
+Communication with the firmware code running in SMM mode works by
+serializing the requests to a shared buffer, then trapping into SMM
+mode via SMI.  The SMM code processes the request, stores the reply in
+the same buffer and returns.
+
+Host UEFI variable service
+==========================
+
+Instead of running the privileged code inside the guest we can run it
+on the host.  The serialization protocol can be reused.  The
+communication with the host uses a virtual device, which essentially
+configures the shared buffer location and size, and traps to the host
+to process the requests.
+
+The ``uefi-vars`` device implements the UEFI virtual device.  It comes
+in ``uefi-vars-x86`` and ``uefi-vars-sysbus`` flavours.  The device
+reimplements the handlers needed, specifically
+``EfiSmmVariableProtocol`` and ``VarCheckPolicyLibMmiHandler``.  It
+also consumes events (``EfiEndOfDxeEventGroup``,
+``EfiEventReadyToBoot`` and ``EfiEventExitBootServices``).
+
+The advantage of the approach is that we do not need a special
+privilege level for the firmware to protect itself, i.e. it does not
+depend on SMM emulation on x64, which allows the removal of a bunch of
+complex code for SMM emulation from the linux kernel
+(CONFIG_KVM_SMM=n).  It also allows support for secure boot on arm
+without implementing secure world (el3) emulation in kvm.
+
+Of course there are also downsides.  The added device increases the
+attack surface of the host, and we are adding some code duplication
+because we have to reimplement some edk2 functionality in qemu.
+
+usage on x86_64
+---------------
+
+.. code::
+
+   qemu-system-x86_64 \
+      -device uefi-vars-x86,jsonfile=/path/to/vars.json
+
+usage on aarch64
+----------------
+
+.. code::
+
+   qemu-system-aarch64 -M virt \
+      -device uefi-vars-sysbus,jsonfile=/path/to/vars.json
diff --git a/hw/uefi/LIMITATIONS.md b/hw/uefi/LIMITATIONS.md
new file mode 100644
index 000000000000..29308bd587aa
--- /dev/null
+++ b/hw/uefi/LIMITATIONS.md
@@ -0,0 +1,7 @@
+known issues and limitations
+----------------------------
+
+* works only on little endian hosts
+  - accessing structs in guest ram is done without endian conversion.
+* works only for 64-bit guests
+  - UINTN is mapped to uint64_t, for 32-bit guests that would be uint32_t
-- 
2.48.1


