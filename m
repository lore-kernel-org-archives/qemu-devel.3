Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254B4C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebnJ-0004JH-8m; Thu, 15 Aug 2024 10:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn7-0003kY-Q2
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:33 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn5-0000Ew-DS
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:29 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a80eab3945eso119424166b.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733366; x=1724338166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bup+6NeSiIzm/eSwtgbo7ETG7RN/Czsn26dY1f0S5U=;
 b=mQFjtTyTXpwEIgJ8dTOf3R/lStud44Mvi3WDOmHg53KXExWV5YBjEphIAJJT9THZcJ
 7ATbxy+huLTjcdW2aDHm1DKVG4GVBABXq5kYYVWQsVAmdY//0aHnBKXsiFMAUD88x4gT
 TDnYMcSijH8j2hmi926PyajsJ/sIqz+rj48AY1u8KCHb4ftOHWgckmWuYpu0JdGRztIR
 9SEpj0zVJ73pW1hDddOQtnN/YJv8DHfRtopyVr3ZmLzRdzotaQ9iZWQVfCP0/N5jONAj
 vpMQVyqitT147Dql/un2Y3kGm9smJ00bvqRSLaq2aPnPNqFUOXQm8jMiEglhSLgUKxT9
 OFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733366; x=1724338166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bup+6NeSiIzm/eSwtgbo7ETG7RN/Czsn26dY1f0S5U=;
 b=SiaMzVenUojrGb9SS4trKAdo1BkQ5cLV7hI1HXogFq7ekxtPuRQ313jak6h5clbz7d
 7UNrZUvqJFBNOHLc19HUfxBiU2QQazDeTuHN/EE5kZyYw6B5a3GarW6d3+uEjPE69ews
 WHinuh9y6ig9r0YVTO8FSWHJYzcClgi0HGgE+F9x9dfAL1+8+GUdZS+IIKVXJD5gmEuG
 FrlquhGlgHXluSeuj6YHbHRLBvU51wmc4VGmyPnz7YpTRNddKwMXoyOa74DBZnGqIK+8
 wEKt4qNR77gEAhs/tm08jMfupgIJQURgKDsT8t7V6oCAmcvlnLGEBiQubENGkCUiV4l2
 5LEg==
X-Gm-Message-State: AOJu0YxccC8vIimnzaAaONLDYcLti0Bi6iH1h6S7SIv0p3cTBwBDldmL
 SxEYfATQkhqE/END6EQdbgAH+l/QSQ51VxY2SA7X6LAI5Z3RmbnxjHmcfjqR7no=
X-Google-Smtp-Source: AGHT+IEyBl26rmnghuBi0BhVflap4nOkn8zahcMdxFCDTo+jriaMulDSDyxGns25+TJmYrgPkq402Q==
X-Received: by 2002:a17:907:e685:b0:a7a:b9dd:7762 with SMTP id
 a640c23a62f3a-a836701733amr453811966b.42.1723733365375; 
 Thu, 15 Aug 2024 07:49:25 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a838396bc50sm112218666b.198.2024.08.15.07.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:49:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 82668603CF;
 Thu, 15 Aug 2024 15:49:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org (open list:ARM SMMU)
Subject: [PULL 19/21] docs: Fix some typos (found by typos) and grammar issues
Date: Thu, 15 Aug 2024 15:49:09 +0100
Message-Id: <20240815144911.1931487-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Stefan Weil via <qemu-devel@nongnu.org>

Fix the misspellings of "overriden" also in code comments.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240813125638.395461-1-sw@weilnetz.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240813202329.1237572-20-alex.bennee@linaro.org>

diff --git a/docs/devel/migration/uadk-compression.rst b/docs/devel/migration/uadk-compression.rst
index 3f73345dd5..64cadebd21 100644
--- a/docs/devel/migration/uadk-compression.rst
+++ b/docs/devel/migration/uadk-compression.rst
@@ -114,7 +114,7 @@ Make sure all these above kernel configurations are selected.
 
 Accelerator dev node permissions
 --------------------------------
-Harware accelerators(eg: HiSilicon Kunpeng Zip accelerator) gets registered to
+Hardware accelerators (eg: HiSilicon Kunpeng Zip accelerator) gets registered to
 UADK and char devices are created in dev directory. In order to access resources
 on hardware accelerator devices, write permission should be provided to user.
 
@@ -134,7 +134,7 @@ How To Use UADK Compression In QEMU Migration
   Set ``migrate_set_parameter multifd-compression uadk``
 
 Since UADK uses Shared Virtual Addressing(SVA) and device access virtual memory
-directly it is possible that SMMUv3 may enounter page faults while walking the
+directly it is possible that SMMUv3 may encounter page faults while walking the
 IO page tables. This may impact the performance. In order to mitigate this,
 please make sure to specify ``-mem-prealloc`` parameter to the destination VM
 boot parameters.
diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
index 9c7380896a..11f7bae460 100644
--- a/docs/interop/qemu-ga.rst
+++ b/docs/interop/qemu-ga.rst
@@ -50,7 +50,7 @@ Options
 .. option:: -c, --config=PATH
 
   Configuration file path (the default is |CONFDIR|\ ``/qemu-ga.conf``,
-  unless overriden by the QGA_CONF environment variable)
+  unless overridden by the QGA_CONF environment variable)
 
 .. option:: -m, --method=METHOD
 
diff --git a/docs/tools/qemu-vmsr-helper.rst b/docs/tools/qemu-vmsr-helper.rst
index 6ec87b49d9..9ce10b9af9 100644
--- a/docs/tools/qemu-vmsr-helper.rst
+++ b/docs/tools/qemu-vmsr-helper.rst
@@ -17,8 +17,8 @@ driver to advertise and monitor the power consumption or accumulated energy
 consumption of different power domains, such as CPU packages, DRAM, and other
 components when available.
 
-However those register are accesible under priviliged access (CAP_SYS_RAWIO).
-QEMU can use an external helper to access those priviliged register.
+However those registers are accessible under privileged access (CAP_SYS_RAWIO).
+QEMU can use an external helper to access those privileged registers.
 
 :program:`qemu-vmsr-helper` is that external helper; it creates a listener
 socket which will accept incoming connections for communication with QEMU.
diff --git a/qapi/rocker.json b/qapi/rocker.json
index 6950ca9602..73c7363b16 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -42,7 +42,7 @@
 ##
 # @RockerPortDuplex:
 #
-# An eumeration of port duplex states.
+# An enumeration of port duplex states.
 #
 # @half: half duplex
 #
@@ -55,7 +55,7 @@
 ##
 # @RockerPortAutoneg:
 #
-# An eumeration of port autoneg states.
+# An enumeration of port autoneg states.
 #
 # @off: autoneg is off
 #
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 02f7528ec0..296fd068c0 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1852,7 +1852,7 @@ void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n);
  * memory_region_unregister_iommu_notifier: unregister a notifier for
  * changes to IOMMU translation entries.
  *
- * @mr: the memory region which was observed and for which notity_stopped()
+ * @mr: the memory region which was observed and for which notify_stopped()
  *      needs to be called
  * @n: the notifier to be removed.
  */
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index d73ad62211..3f82728758 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -674,7 +674,7 @@ error:
 
 /*
  * combine S1 and S2 TLB entries into a single entry.
- * As a result the S1 entry is overriden with combined data.
+ * As a result the S1 entry is overridden with combined data.
  */
 static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
                         dma_addr_t iova, SMMUTransCfg *cfg)
diff --git a/qga/main.c b/qga/main.c
index b8f7b1e4a3..50186760bf 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -257,7 +257,7 @@ QEMU_COPYRIGHT "\n"
 "\n"
 "  -c, --config=PATH configuration file path (default is\n"
 "                    %s/qemu-ga.conf\n"
-"                    unless overriden by the QGA_CONF environment variable)\n"
+"                    unless overridden by the QGA_CONF environment variable)\n"
 "  -m, --method      transport method: one of unix-listen, virtio-serial,\n"
 "                    isa-serial, or vsock-listen (virtio-serial is the default)\n"
 "  -p, --path        device/socket path (the default for virtio-serial is:\n"
-- 
2.39.2


