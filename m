Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C37D116F5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 09:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOuk1-0006CW-Nd; Fri, 28 Nov 2025 04:26:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOuk0-00069e-Ik
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 04:26:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOujy-0006P5-L7
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 04:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764321968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=k3HegF1dvZskqDQjB6UZY2CsUlvTq/HyevidPGf1LmU=;
 b=dN8FgDt+U6eKJiSYdW9NBijUxklKkCeXdg3kx7HlwZTFznUrgbNYgepVlrLaOpGV+uO31X
 Ya55j1oyPJHG5+KfeOmnbX+ZJIarC1yuybTjqbeq6EfIDHAxtL+VkNSU0XOwWamQqnMGrJ
 PFIAhoYQCU6KeNJHqYVNypEzftTq6ZA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-TcibJeVwOsq6TwFOjmNUUw-1; Fri,
 28 Nov 2025 04:26:06 -0500
X-MC-Unique: TcibJeVwOsq6TwFOjmNUUw-1
X-Mimecast-MFC-AGG-ID: TcibJeVwOsq6TwFOjmNUUw_1764321965
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFC021800561; Fri, 28 Nov 2025 09:26:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.33.236])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CEDA19560B0; Fri, 28 Nov 2025 09:26:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A138A1800639; Fri, 28 Nov 2025 10:26:02 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 0/2] [RfC] edk2: add qemu variable store firmware builds
Date: Fri, 28 Nov 2025 10:25:59 +0100
Message-ID: <20251128092602.373747-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is somewhat related to the bigger question how we want move forward
with firmware builds in the qemu repo ...

qemu got uefi variable store support in version 10.0.  With the pending
edk2 firmware update (patches are on the list right now) edk2 is new
enough that support for the qemu variable store is present in the code
base.  This is a compile time option though, so it needs separate
firmware images.  This little patch series adds them.

The big question is if we want go down that route.  The images are not
essential for qemu itself.  The test cases for the acpi tables use the
firmware images for the traditional, pflash-based efi variable store
and can continue to do so.

So, do we want add them?  For qemu developer / user convenience?  Or
leave that to linux distributions?  Fedora already ships builds (see
/usr/share/edk2/*/*qemuvars*).

take care,
  Gerd

Gerd Hoffmann (2):
  edk2: add qemuvars builds to config
  edk2: add qemuvars build binaries

 pc-bios/edk2-aarch64-qemuvars.fd.bz2 | Bin 0 -> 1621714 bytes
 pc-bios/edk2-x86_64-qemuvars.fd.bz2  | Bin 0 -> 2095693 bytes
 roms/edk2-build.config               |  37 +++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)
 create mode 100644 pc-bios/edk2-aarch64-qemuvars.fd.bz2
 create mode 100644 pc-bios/edk2-x86_64-qemuvars.fd.bz2

-- 
2.52.0


