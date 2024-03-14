Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CA4C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 11:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkjeL-00075B-AG; Thu, 14 Mar 2024 07:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rkjeC-000710-4r
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:53:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rkje4-0002fZ-Rx
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710417191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1kax2+hBv4CGTGfJW70Zoqtpf0NUZAJVnUqsbAEMehI=;
 b=G5Pg/wmxhJ2fw+3c8bEZQ+kUgGEDS7Tnq9FBTJrZiy2nndjunVCXM1N+Mkcf5LCG+v2Gm9
 3g4ciS4mSjSMUsIFfxR4d2HFKhkCi/nqNqjPXy17G/7dihRuyZmTP1RmKfKoRS2FQM0QWA
 A1hQmNnGu6vEhHR2G8lB5lpKZKOdgOU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-jky7ULebMkeRLn3_HwmMrA-1; Thu,
 14 Mar 2024 07:53:09 -0400
X-MC-Unique: jky7ULebMkeRLn3_HwmMrA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B74428B6AC0;
 Thu, 14 Mar 2024 11:53:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85923111F3C6;
 Thu, 14 Mar 2024 11:53:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 88D151800629; Thu, 14 Mar 2024 12:53:07 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 0/5] roms/efi: cleanup fix, config update, ekd2 binary rebuild
Date: Thu, 14 Mar 2024 12:52:58 +0100
Message-ID: <20240314115307.628118-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



Gerd Hoffmann (5):
  roms/efi: clean up edk2 build config
  roms/efi: drop workaround for edk2-stable202308
  roms/efi: exclude efi shell from secure boot builds
  roms/efi: use pure 64-bit build for edk2-x86_64-secure-code.fd
  update edk2 binaries for arm, risc-v and x86 secure boot.

 pc-bios/edk2-aarch64-code.fd.bz2       | Bin 1589320 -> 1589310 bytes
 pc-bios/edk2-arm-code.fd.bz2           | Bin 1571418 -> 1571693 bytes
 pc-bios/edk2-i386-secure-code.fd.bz2   | Bin 2130741 -> 1876986 bytes
 pc-bios/edk2-riscv-code.fd.bz2         | Bin 1345420 -> 1289160 bytes
 pc-bios/edk2-x86_64-secure-code.fd.bz2 | Bin 2214892 -> 1967967 bytes
 roms/Makefile                          |   1 +
 roms/edk2-build.config                 |  13 ++++---------
 7 files changed, 5 insertions(+), 9 deletions(-)

-- 
2.44.0


