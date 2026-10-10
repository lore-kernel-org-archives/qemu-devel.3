Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DED9CA9EBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 13:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFXIq-0004xw-Nd; Sat, 10 Oct 2026 09:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXIp-0004sM-0a
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:39:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXIn-0004nk-5B
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791639592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eHlmM2OW8vBgTNNqS2W/Lyj0mc71XENMhVWORgeokPc=;
 b=TJNCv51OcOWG1GIKavST7VE0K4kPYGUV4CzVbgzY7jl+QlzttjhXYugqT9tjeb1GZblnEv
 N2aczaFTGKGhcjfxhIaamY6cUkIKowMka+bR1XPl8k/Jzd5SQHgrC+Upko5xaJwQ+M2O3W
 ugh1orby/DbuGtM972w8XRlye5vinZU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-eklHFRvkPgWBpJ2ToJv5QA-1; Sat,
 10 Oct 2026 13:39:51 +0000
X-MC-Unique: eklHFRvkPgWBpJ2ToJv5QA-1
X-Mimecast-MFC-AGG-ID: eklHFRvkPgWBpJ2ToJv5QA_1791639589
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00B931944B22; Sat, 10 Oct 2026 13:39:49 +0000 (UTC)
Received: from laptop.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7850630000E5; Sat, 10 Oct 2026 13:39:44 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v10 26/26] arm/cpu-features: Document ID reg properties
Date: Sat, 10 Oct 2026 15:36:30 +0200
Message-ID: <20261010133725.642498-27-eric.auger@redhat.com>
In-Reply-To: <20261010133725.642498-1-eric.auger@redhat.com>
References: <20261010133725.642498-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Cornelia Huck <cohuck@redhat.com>

Add some documentation for how individual ID registers can be
configured with the host cpu model.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>

---

9 -> 10:
- document the fact some props may be willingly hidden because they
  conflict with legacy composite options
- mention max model too
---
 docs/system/arm/cpu-features.rst | 111 ++++++++++++++++++++++++++++---
 1 file changed, 102 insertions(+), 9 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 10b0eff27e..13454783cf 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -2,8 +2,11 @@ Arm CPU Features
 ================
 
 CPU features are optional features that a CPU of supporting type may
-choose to implement or not.  In QEMU, optional CPU features have
-corresponding boolean CPU proprieties that, when enabled, indicate
+choose to implement or not.  QEMU provides two different mechanisms
+to configure those features:
+
+1. For most CPU models, optional CPU features may have
+corresponding boolean CPU properties that, when enabled, indicate
 that the feature is implemented, and, conversely, when disabled,
 indicate that it is not implemented. An example of an Arm CPU feature
 is the Performance Monitoring Unit (PMU).  CPU types such as the
@@ -31,6 +34,34 @@ running guests in AArch32.
 CPU features that are inherently specific to KVM are
 prefixed with "kvm-" and are described in "KVM VCPU Features".
 
+2. Additionally, the ``host`` and ``max`` CPU models on KVM allow
+overwriting a subset of the ID register fields. Not all ID register
+fields are writable: this depends on the host. For those which are
+writable, and for those only, these models expose
+``SYSREG_<IDREG>_<FIELD>`` properties. IDREG and FIELD names are those
+used in the ARM Architecture Reference Manual. QEMU may still omit some
+writable fields that conflict with legacy composite options (for example
+EL3/secure, MTE, SVE, or pauth).
+
+Values set with those properties override the initial values retrieved
+from the vCPU after legacy composite property settings (``sve``,
+``pauth``, ...) have been applied, whether at machine level or at vCPU
+level.
+
+``SYSREG_<IDREG>_<FIELD>`` properties are applied at the end of the chain
+and do not substitute for legacy composite options. In other words, if
+you want to use pauth, you still need to set ``pauth=on``. Indeed legacy
+options do more than exposing a different value for ID registers. They
+may also interact with KVM to prepare the vCPU for this feature (for
+instance at vCPU init time). Whereas ``SYSREG_<IDREG>_<FIELD>`` properties
+only change the final value of the ID register. Inconsistent settings
+between legacy composite options (at machine level or CPU level) which
+impact the vCPU and low-level ``SYSREG_<IDREG>_<FIELD>`` properties are
+rejected. ``SYSREG_<IDREG>_<FIELD>`` properties are essentially used to
+tune the ``host``/``max`` vCPU model so that it allows migration between
+different hardware.
+
+
 CPU Feature Probing
 ===================
 
@@ -126,13 +157,21 @@ A note about CPU models and KVM
 
 Named CPU models generally do not work with KVM.  There are a few cases
 that do work, e.g. using the named CPU model ``cortex-a57`` with KVM on a
-seattle host, but mostly if KVM is enabled the ``host`` CPU type must be
-used.  This means the guest is provided all the same CPU features as the
-host CPU type has.  And, for this reason, the ``host`` CPU type should
-enable all CPU features that the host has by default.  Indeed it's even
-a bit strange to allow disabling CPU features that the host has when using
-the ``host`` CPU type, but in the absence of CPU models it's the best we can
-do if we want to launch guests without all the host's CPU features enabled.
+seattle host, but mostly if KVM is enabled, the ``host`` CPU model must be
+used.
+
+Using the ``host`` type means the guest is provided all the same CPU
+features as the host CPU type has.  And, for this reason, the ``host``
+CPU type should enable all CPU features that the host has by default.
+
+In case some features need to be tuned for the guest, and the host kernel
+supports it, the ``host`` and ``max`` models can be instructed to change
+individual ID register field values. This is especially useful for
+migration purposes.
+However, this interface will not allow configuring an arbitrary set of
+features; the ID registers must describe a subset of the host's features,
+and all differences to the host's configuration must actually be supported
+by the kernel to be deconfigured.
 
 Enabling KVM also affects the ``query-cpu-model-expansion`` QMP command.  The
 affect is not only limited to specific features, as pointed out in example
@@ -169,6 +208,15 @@ disabling many SVE vector lengths would be quite verbose, the ``sve<N>`` CPU
 properties have special semantics (see "SVE CPU Property Parsing
 Semantics").
 
+Additionally, if supported by KVM on the host kernel, the ``host`` and
+``max`` CPU models may be configured via individual ID register field
+properties, for example::
+
+  $ qemu-system-aarch64 -M virt -cpu host,SYSREG_ID_AA64ISAR0_EL1_DP=0x0
+
+This forces ID_AA64ISAR0_EL1 DP field to 0. The same property syntax works
+with ``-cpu max``.
+
 KVM VCPU Features
 =================
 
@@ -495,3 +543,48 @@ Legal values for ``S`` are 30, 34, 36, and 39; the default is 30.
 
 As with ``x-rme``, the ``x-l0gptsz`` property may be renamed or
 removed in some future QEMU release.
+
+Configuring CPU features via ID register fields
+===============================================
+
+Note that this is currently only supported under KVM, and with the
+``host`` or ``max`` CPU models.
+
+Querying available ID register fields
+-------------------------------------
+
+QEMU will create properties for ID register fields that are reported as
+being writable by the kernel, known to the QEMU instance, and not omitted
+because they conflict with legacy composite options. Therefore, the same
+QEMU binary may expose different properties when run under a different
+kernel.
+
+To find out the available ID register field properties, use the
+``query-cpu-model-expansion`` QMP command::
+
+  (QEMU) query-cpu-model-expansion type=full model={"name":"host"}
+  {"return": {
+   "model": {"name": "host", "props": {
+   "SYSREG_ID_AA64PFR0_EL1_EL2": 1, "SYSREG_ID_AA64ISAR2_EL1_CLRBHB": 0,
+   "SYSREG_CTR_EL0_L1Ip": 3, "SYSREG_CTR_EL0_DminLine": 4,
+   "SYSREG_ID_AA64MMFR0_EL1_BIGEND": 1, "SYSREG_ID_AA64MMFR1_EL1_ECBHB": 0,
+   "SYSREG_ID_AA64MMFR2_EL1_CnP": 1, "SYSREG_ID_DFR0_EL1_PerfMon": 4,
+   "SYSREG_ID_AA64PFR0_EL1_DIT": 0, "SYSREG_ID_AA64MMFR1_EL1_HAFDBS": 2,
+   "SYSREG_ID_AA64ISAR0_EL1_FHM": 0, "SYSREG_ID_AA64ISAR2_EL1_CSSC": 0,
+   "SYSREG_ID_AA64ISAR0_EL1_DP": 1, (...)
+   }}}}
+
+If a certain field in an ID register does not show up in this list, it is
+either not writable with the specific host kernel, unknown to this QEMU
+build, or intentionally not exposed because it overlaps a legacy composite
+option.
+
+A note on compatibility
+-----------------------
+
+A common use case for providing a defined set of ID register values is
+to be able to present a fixed set of features to a guest, often referred
+to as "stable guest ABI". This may take the form of ironing out differences
+between two similar CPUs with the intention of being able to migrate
+between machines with those CPUs, or providing the same CPU across Linux
+kernel updates on the host.
-- 
2.53.0


