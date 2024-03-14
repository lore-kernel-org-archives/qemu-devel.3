Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007AEC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 11:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkjeH-00073P-NZ; Thu, 14 Mar 2024 07:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rkjeC-000711-7W
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rkje7-0002fl-Ko
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710417192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TDg3HC7qCArm0IqKc/Ziv5okpEu+5eWcbVfLhYGrB5Q=;
 b=DWgDj94gVG80EnH2SDadZaKPEsEJN6XfKF6q6fWhfNS0HAzFq3FVaRcyZGMlMGNT+Nr/jW
 fOA2Wxusy7z5Zc7V7RF7Z/VDDRYIsK52KuUOsfFa9W0p1aVBtcb8I7yKc3gB+3yGZFDN4n
 6ZRun2ONcXAKP4+7+AerfldT191OgiM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-ikXdl6eGMJmXLCjOlXtFUA-1; Thu,
 14 Mar 2024 07:53:11 -0400
X-MC-Unique: ikXdl6eGMJmXLCjOlXtFUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBE4E28B6AB6;
 Thu, 14 Mar 2024 11:53:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F53F111E5;
 Thu, 14 Mar 2024 11:53:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AE86A1800D6A; Thu, 14 Mar 2024 12:53:07 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 3/5] roms/efi: exclude efi shell from secure boot builds
Date: Thu, 14 Mar 2024 12:53:01 +0100
Message-ID: <20240314115307.628118-4-kraxel@redhat.com>
In-Reply-To: <20240314115307.628118-1-kraxel@redhat.com>
References: <20240314115307.628118-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Bugzilla: https://bugzilla.tianocore.org/show_bug.cgi?id=4641
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/edk2-build.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/roms/edk2-build.config b/roms/edk2-build.config
index 05cbafef70cb..ef3eb7beebe7 100644
--- a/roms/edk2-build.config
+++ b/roms/edk2-build.config
@@ -18,6 +18,7 @@ CAVIUM_ERRATUM_27456     = TRUE
 [opts.ovmf.sb.smm]
 SECURE_BOOT_ENABLE       = TRUE
 SMM_REQUIRE              = TRUE
+BUILD_SHELL              = FALSE
 
 [opts.armvirt.silent]
 DEBUG_PRINT_ERROR_LEVEL  = 0x80000000
-- 
2.44.0


