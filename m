Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21518C27C77
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6XZ-0005ke-Qa; Mon, 17 Jun 2024 03:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6XY-0005U9-GP
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:12:32 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6XW-0002IS-Kn
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:12:32 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a6f7720e6e8so105252866b.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608348; x=1719213148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FtFU7s0OE9g+HVGgtXqebVqKRLtvfz7dny9VpSwM+gI=;
 b=Z+8SL2uyAsnQXzhc4fvB8KC84Fg83RTEVzqAwNo10dmDt/Nvc/SHDDeFlHPbpqZZ+F
 LuCzaYrnqHVMDTqSWjnpyUPPqRIDIqWDZvXLEaMjic8ypAl/axT0wvKjSnjYfgBT8uTJ
 sjx4SUFfD4+/CyvLXYE/Lv5UBOGqxj3F+nQ2rxBoh+O0yQis+qTGHhdTqA66leh79f9D
 3KamfgdBjXSXeQByDk2eT5TrLvWlF+5+4+JQ9obmqG8tllMPMK6MjT7rh5vTcFwOWr42
 B0fsR85GvMdFbZVp/G1hno8R0BZ5WKdJX6cvkRqN0GeSErznbBXXbIEyZJBgCv5S9vy/
 LlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608348; x=1719213148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FtFU7s0OE9g+HVGgtXqebVqKRLtvfz7dny9VpSwM+gI=;
 b=Nltmn0cnxC6NjIB08p9mhnmwab4tF5SzyUGd6r+Vfsjqsnql3RDhrzB8o2qRUnXnNf
 GDBMVsLzV8fT4oS4RJDvx+EgGhjKIJw2tOVOJL4EF6nwYdKrY9CG/5sAV7ndjoNNylfU
 kCmQ820wYN9+g9bCC2A87dMoQAJuvrs+j+D6YHe+VH9/TpAL0qtFktMpxiMpsmATacB1
 JxThXM+StdhA7MVuJa757f6uvLWXA1S/2ci2QaU5oM3fkbPVW+gKH3RbWesZw+HW0DOX
 I2AIsv74O/DTkd93JdEiDK/m77QMWtjFvsxZUOP9HvAI8ASBLxGu5KLqKJdSdv6HFQ/e
 cEMg==
X-Gm-Message-State: AOJu0YywdTdITGjRhT2WoR0n3I857ZPq20KV0Dn7sXXXGznjqrj/I1lE
 O4YukWZlcn/vXDQtrA6Ed2VClh0e2n5Enw5WGHLpC4XDWAvc9jWmYuJfBKvStYRuhFgSVP87Mc0
 nXQI=
X-Google-Smtp-Source: AGHT+IFrY+HYWd0dtm47EYlprOKdaBcmwiP/hHo45VQlTbTCbIUsZZVQ97KkWLS15Fh89T56sLvKxA==
X-Received: by 2002:a17:906:710f:b0:a6f:5120:3a30 with SMTP id
 a640c23a62f3a-a6f60dc4ffamr707532566b.60.1718608348266; 
 Mon, 17 Jun 2024 00:12:28 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ed379esm491850466b.139.2024.06.17.00.12.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 00:12:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 12/23] hw/smbios: Remove 'smbios_uuid_encoded',
 simplify smbios_encode_uuid()
Date: Mon, 17 Jun 2024 09:11:07 +0200
Message-ID: <20240617071118.60464-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240617071118.60464-1-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

'smbios_encode_uuid' is always true, remove it,
simplifying smbios_encode_uuid().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/smbios/smbios.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 8261eb716f..3b7703489d 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -30,7 +30,6 @@
 #include "hw/pci/pci_device.h"
 #include "smbios_build.h"
 
-static const bool smbios_uuid_encoded = true;
 /*
  * SMBIOS tables provided by user with '-smbios file=<foo>' option
  */
@@ -600,11 +599,9 @@ static void smbios_build_type_0_table(void)
 static void smbios_encode_uuid(struct smbios_uuid *uuid, QemuUUID *in)
 {
     memcpy(uuid, in, 16);
-    if (smbios_uuid_encoded) {
-        uuid->time_low = bswap32(uuid->time_low);
-        uuid->time_mid = bswap16(uuid->time_mid);
-        uuid->time_hi_and_version = bswap16(uuid->time_hi_and_version);
-    }
+    uuid->time_low = bswap32(uuid->time_low);
+    uuid->time_mid = bswap16(uuid->time_mid);
+    uuid->time_hi_and_version = bswap16(uuid->time_hi_and_version);
 }
 
 static void smbios_build_type_1_table(void)
-- 
2.41.0


