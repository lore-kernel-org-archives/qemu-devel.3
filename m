Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A0ACCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwI-0004Bz-5R; Fri, 31 Oct 2025 14:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwG-0004An-CT
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:28 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtw8-0006Ar-6n
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:28 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-429bcddad32so1072449f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935594; x=1762540394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wmyQkb2QsvUuGjFN9atNXZMMVdCdxzDZe72zwMmx34w=;
 b=BPbei9lJv3mcd/Bt99mM8VeSatPqle8lZcyARxQhVc72GYqynd2Pn2K7F6SVv+3B9K
 SkVFYnaFO7Qa7HIqoBo88GGtxurgwgwBkFosVCbqu0kfsCJBr4KFMxUAecCBbB/0ieB5
 F3/73700KGSi37zy0eE6fNlDWrXjc2q4IlPtNtNh5EJDzVQK/b4Bs7lxxJKOocaq7K9D
 ciYPa4AavEejKb8YMWSFnYObFqUpXXZiIj7N1O8WtpZMN+2lYgYQpXx6tWQwCi+UyPJ/
 DCpgUz3AHM/liLIxa/0YdxEhl5mrZhPSBgxajQlYLNpB1HbkSZmY6SbseZigjhL9I8iM
 ANHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935594; x=1762540394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmyQkb2QsvUuGjFN9atNXZMMVdCdxzDZe72zwMmx34w=;
 b=RKm163Vn61HmklgWZi9rLClSShb5rrsHq8qMf6L4218Jg3B75DUS7yRs4/AmJ4N1Oy
 a/4Gd7WEG8n3tn7KkjO/v2EMcUi1f9M1meyU48raqxj6Dv4mE1QJmGiGHcc+qckoDBvK
 OlwS9fYV/RfH7CykYCKU/NPs2geDYiSdV6SHaBNpYQNqe2q0LXxAwkjo+RHZXW2vFxa6
 JihQ47o6B7Plba2S075kTGKb97tedcK8ryu33dh6aIMAyHbcD1gLWfCVQ3cbG8IEV4yh
 vA8SvlmApeQ82xrICfIEuu7FzwyxqEbSwS6+OPlWONzS/rkpQIQ09H7XPEoSfTlQHIfW
 HqVQ==
X-Gm-Message-State: AOJu0YzgWsraTfDl89CSjikZfL+Fht7qrSXJGtC9D1JoPweGTo+TrjCe
 qhJRguFdKO5kP6UXb9BOfUpSbR8vZfsuol/O5r4tIem2GKVHUAEGNuOA+FIHYa6b7vP+dR3LZpR
 SK9r4
X-Gm-Gg: ASbGncuei+wK0UG4AyPpsDD9eiLzB5ZpbFH52OIapkqN2+hp+adW1upZYFAfmGaWaO0
 lWCN0o1u3bwyH7cIp8L99e7EAJ2qsqJ4QgC+N/GdAwXBy/rM/cWXgNS6zHtMarrFe/6A1OWimZO
 ziPK10uMpo82ZKGSzBhESIqmzKYCjSXj6mxoa79OfY7xEa7OxVIoG8Jj2Mb2Rgq8FMeuLhRPpSF
 ecUmZ7CYSZTuSBkCKeR70xAYscc1l2b6BaAx07SmGNeXp+9LIHq8ygE4aL+0+qY+/ZBnjGRZDQE
 isxi2uhpTMlc8Tnozkc9TtOLvF4YTbxv91+7THHf0TfKEL3rDj2Qmb+biDLhD7bkw7I/NTo6MmI
 wJRWFhf9/Luk1gdpiZvHtYby1ywC28RBLAi/RE7zsR3xLUsgrx0IZR8bQxU6DKQlaStGMqXYIdu
 +Q/9kf2Q==
X-Google-Smtp-Source: AGHT+IGg0a7p2mMgHx5XucSmnkWzlOmSEyoRvddkEfCDPJ8HEE/LizzR7Un3uour7bKZ9faXifDYnA==
X-Received: by 2002:a05:6000:2585:b0:428:3f7c:bcfe with SMTP id
 ffacd0b85a97d-429bd6c1ef3mr3599375f8f.57.1761935594114; 
 Fri, 31 Oct 2025 11:33:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/38] docs/system/arm/virt: Document user-creatable SMMUv3
Date: Fri, 31 Oct 2025 18:32:34 +0000
Message-ID: <20251031183310.3778349-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

The virt machine now supports creating multiple SMMUv3 instances, each
associated with a separate PCIe root complex.

Update the documentation with an example.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
[PMM: some minor wording tweaks]

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/virt.rst | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 10cbffc8a70..e5570773ba1 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -37,7 +37,8 @@ The virt board supports:
 - An RTC
 - The fw_cfg device that allows a guest to obtain data from QEMU
 - A PL061 GPIO controller
-- An optional SMMUv3 IOMMU
+- An optional machine-wide SMMUv3 IOMMU
+- User-creatable SMMUv3 devices (see below for example)
 - hotpluggable DIMMs
 - hotpluggable NVDIMMs
 - An MSI controller (GICv2M or ITS). GICv2M is selected by default along
@@ -176,7 +177,7 @@ iommu
   ``none``
     Don't create an IOMMU (the default)
   ``smmuv3``
-    Create an SMMUv3
+    Create a machine-wide SMMUv3.
 
 default-bus-bypass-iommu
   Set ``on``/``off`` to enable/disable `bypass_iommu
@@ -219,6 +220,36 @@ x-oem-table-id
   Set string (up to 8 bytes) to override the default value of field OEM Table ID
   in ACPI table header.
 
+SMMU configuration
+""""""""""""""""""
+
+Machine-wide SMMUv3 IOMMU
+  Setting the machine-specific option ``iommu=smmuv3`` causes QEMU to
+  create a single, machine-wide SMMUv3 instance that applies to all
+  devices in the PCIe topology.
+
+  For information about selectively bypassing devices, refer to
+  ``docs/bypass-iommu.txt``.
+
+User-creatable SMMUv3 devices
+  You can use the ``-device arm-smmuv3`` option to create multiple
+  user-defined SMMUv3 devices, each associated with a separate PCIe
+  root complex. This is only permitted if the machine-wide SMMUv3
+  (``iommu=smmuv3``) option is not used. Each ``arm-smmuv3`` device
+  uses the ``primary-bus`` sub-option to specify which PCIe root
+  complex it is associated with.
+
+  This model is useful when you want to mirror a host configuration where
+  each NUMA node typically has its own SMMU, allowing the VM topology to
+  align more closely with the host’s hardware layout.
+
+  Example::
+
+      -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0
+      ...
+      -device pxb-pcie,id=pcie.1,numa_node=1
+      -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1
+
 Linux guest kernel configuration
 """"""""""""""""""""""""""""""""
 
-- 
2.43.0


