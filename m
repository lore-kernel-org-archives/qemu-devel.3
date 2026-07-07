Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE31C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whEWE-0001aI-Pl; Tue, 07 Jul 2026 18:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEWD-0001Xf-D3
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:57 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEWB-0004Fi-T6
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:57 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cc80b585bfso775165ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783464234; x=1784069034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnMMO6XRJvcdXze8ZNpj726nr1qkqlMgc3hRmwu5zpY=;
 b=Go0yhxWBWqFiJe4snu8lkvfxWh8FkYjMJoCzgDHU3gkzHlp8A9Cr6OlctPc0OhITD6
 71jWGcW4coz5EZVzCg7mSKedOKamcQAPpGqimZ48qQdChHei1D7E4NoSEcl1LlxJedTG
 Vm+0wo+QWEcbu0zlnK0n4qBQjUQE0zsMjqQvzY2wIfTlvLItMMjzUUUMeHMhOt5uGoFx
 /LvaLpjhoNJr1JCXtC6YNCL4014i4REcHOrHrejiBJOAUYAgRTZRZHUiCmbrnh1gDAou
 IOTTkUUtDbSaAkUKXlADFTOQqSSDpRRg7sNoNQyu5Mw/v9kslyDCzkDsjKSOvnkeuMZN
 Tr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783464234; x=1784069034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EnMMO6XRJvcdXze8ZNpj726nr1qkqlMgc3hRmwu5zpY=;
 b=XvhoR6fuHRPW1q+e1v/7++lm9TWVs6znw+wpko1lkGRiQ51jXUa/mP/PmzQ1Fdcdld
 ++Jk5Tg0zPUQ2LkLIpZpSrhouahsfYU1v5LZCpvZQ569xoggcltDokNX+vHEqRbxOrWr
 MY49WebRbKMD2923NOl2cTIg27GXxXR1Yx5WNkBt95jxRHQ+368Do5YCDVMXqj34yOJM
 Yl5XOGohOSX2tFGvq2K5eKOvPJEyrjYnlRC+4MGJocwVUtjTftixr15PPFpq5wSdvhSS
 RVqKNmYgjODIrP1dRwKmGwKnSG7SPqmS1LZtDSvq7SK9sqRajsEUW3yUMrc4NSYwiZT2
 AvYA==
X-Gm-Message-State: AOJu0Yx+PKxDa3m0TyXTLcyb82+e1yxmTL1wNa27O+o5YSXc/FyI5s2W
 npWRETWurwILejjkCf4eLtgLfrcxO82KubjnNeC3DSWT1XorWR70hCAKHJg3thcpfA0=
X-Gm-Gg: AfdE7ck/SuZEuLiYbSKGQ7ZydJEsMkBz6riPE2a3nxsrDacF8vxM3kbVq5Cl9awwsvT
 8/vqhIIeXPl3S6yYk7uRQd/ras0oj7HTm1PRGDhV4LyKUrST1+33+FuPjBRAUa5HDSZlED+OdWz
 NxDjnkrrnlvmOZDKOv1cfg7JHC+/2XbN1/HG1ML5w/qlpcfYTaUWGUeYx+gEds03QNJysNenaOs
 4EAbZgEIlXoIO8vmndMs78vsyoYDk1aY6Cyd4cJy1LJrsg9p5rPRk0viiiwuX+uaysLjAcu2CVr
 ddEvJuNJNzDORgLDCmGQ9C+HrSXbQ6l3mlEfBjS4hlU2yLgnYzZ+PB2MBfVfTzkoC4KPkVBSduy
 3seXkEL9TKxyVZY5Ydq0yxk9jxipzxlNNUAALLcZLz499G0/dtou33RiDBgMox4u/ncrruiw4Oj
 05ACdJwtIxB7r0bqmwWxR3e5RNOC0k2rGYAVOGCE8=
X-Received: by 2002:a17:903:2344:b0:2c9:de53:f84f with SMTP id
 d9443c01a7336-2ccbe728bb0mr63110775ad.19.1783464234442; 
 Tue, 07 Jul 2026 15:43:54 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:43:53 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 23/25] docs/interop/firmware.json: Add arm-rme firmware
 feature
Date: Tue,  7 Jul 2026 16:43:04 -0600
Message-ID: <20260707224306.1202330-24-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x62a.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Some distributions provide packages continaing firmware to be run under
QEMU, such as "qemu-efi-aarch64" or "edk2-aarch64". Those packages also
contain descriptors in /usr/share/qemu/firmware/*.json listing the
firmware features, so that environments like libvirt can figure out
which firmware they can load.

Define an optional feature for arm64 firmware to indicate that a
firmware supports running in a Realm. Firmware implementations need
extra support for running in a Realm, in particular to distinguish
shared from private guest memory.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 docs/interop/firmware.json | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 421bee0e5ed4..c68d7f5013f8 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -161,6 +161,9 @@
 #     options related to this feature are documented in
 #     "docs/system/i386/amd-memory-encryption.rst".
 #
+# @arm-rme: The firmware supports running in a Realm, under the Arm Realm
+#           Management Extension (RME).
+#
 # @intel-tdx: The firmware supports running under Intel Trust Domain
 #     Extensions (TDX).
 #
@@ -229,7 +232,7 @@
 { 'enum' : 'FirmwareFeature',
   'data' : [ 'acpi-s3', 'acpi-s4',
              'amd-sev', 'amd-sev-es', 'amd-sev-snp',
-             'intel-tdx',
+             'arm-rme', 'intel-tdx',
              'enrolled-keys', 'requires-smm',
              'secure-boot', 'host-uefi-vars',
              'verbose-dynamic', 'verbose-static' ] }
-- 
2.43.0


