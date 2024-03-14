Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EB1C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 11:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkjeL-00075S-Iz; Thu, 14 Mar 2024 07:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rkjeF-00073O-Tj
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:53:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rkjeB-0002g6-TA
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710417194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i2v1prcqiXz0jaZL0bJvXmInR+VF4vkGAJkMq66df0s=;
 b=bfzDXUg18zjXc5HyeKwOxUrSneRwwApkRDwPSImuqdaDspxrciJq/KbATft2MGGOjRoemH
 koZLxnE8xaZdNy1zpJuoV+6ZhSjddj9LzOyYfOQPDKmQdQ+RnkSszl156kP2XLpzLyqjS1
 6vNy06s6hWoK2GXMA+Tyj0D1onwz1jk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-7pB6jD72P4KeuGYwAIdyEQ-1; Thu, 14 Mar 2024 07:53:12 -0400
X-MC-Unique: 7pB6jD72P4KeuGYwAIdyEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D3E51869C61;
 Thu, 14 Mar 2024 11:53:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3CC13C21;
 Thu, 14 Mar 2024 11:53:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BB1F51800D6F; Thu, 14 Mar 2024 12:53:07 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 4/5] roms/efi: use pure 64-bit build for
 edk2-x86_64-secure-code.fd
Date: Thu, 14 Mar 2024 12:53:02 +0100
Message-ID: <20240314115307.628118-5-kraxel@redhat.com>
In-Reply-To: <20240314115307.628118-1-kraxel@redhat.com>
References: <20240314115307.628118-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/edk2-build.config | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/roms/edk2-build.config b/roms/edk2-build.config
index ef3eb7beebe7..cc9b21154205 100644
--- a/roms/edk2-build.config
+++ b/roms/edk2-build.config
@@ -70,11 +70,11 @@ cpy1 = FV/OVMF_CODE.fd edk2-x86_64-code.fd
 
 [build.ovmf.x86_64.secure]
 desc = ovmf build (64-bit, secure boot)
-conf = OvmfPkg/OvmfPkgIa32X64.dsc
-arch = IA32 X64
+conf = OvmfPkg/OvmfPkgX64.dsc
+arch = X64
 opts = common
        ovmf.sb.smm
-plat = Ovmf3264
+plat = OvmfX64
 dest = ../pc-bios
 cpy1 = FV/OVMF_CODE.fd edk2-x86_64-secure-code.fd
 
-- 
2.44.0


