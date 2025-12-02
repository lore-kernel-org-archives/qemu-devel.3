Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D399CFD376
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 08:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQLo3-0000rF-En; Tue, 02 Dec 2025 03:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQLo0-0000qO-Ky
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 03:32:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQLny-0007J5-LA
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 03:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764664333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AtDYJG1hvguILOap/gXoCHdV+D1IAb0ELiv0e7xXTEA=;
 b=X/BxRhDAMGe/z5E/29qA7UJMN7zy1Y0He0HrgS2zXz9LDoTVnXIwaufFmw/6+WBecFhYJH
 hAR/JJPdEwdPgaSSobM15VOhQhFoGIqHV+tPeiIn6hIIPT+PioCdvOXkzwgf1cAcU4qqsm
 5iHVVkooSJkNh5AVGhTiw5nQd1UX/Cw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-dw9Sv8dIN2CyYfJKetvKOQ-1; Tue,
 02 Dec 2025 03:32:11 -0500
X-MC-Unique: dw9Sv8dIN2CyYfJKetvKOQ-1
X-Mimecast-MFC-AGG-ID: dw9Sv8dIN2CyYfJKetvKOQ_1764664330
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2A2C1956095; Tue,  2 Dec 2025 08:32:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 608F2195608E; Tue,  2 Dec 2025 08:32:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BC84621E6A27; Tue, 02 Dec 2025 09:32:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/2] Error reporting patches for 2025-12-02
Date: Tue,  2 Dec 2025 09:32:04 +0100
Message-ID: <20251202083206.4180561-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit 9ef49528b5286f078061b52ac41e0ca19fa10e36:

  Merge tag 'hw-misc-20251125' of https://github.com/philmd/qemu into staging (2025-11-25 14:22:39 -0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-error-2025-12-02

for you to fetch changes up to 88be119fb19b8ee04d681ad9048cde9f6a37c631:

  kvm: Fix kvm_vm_ioctl() and kvm_device_ioctl() return value (2025-12-02 07:46:21 +0100)

----------------------------------------------------------------
Error reporting patches for 2025-12-02

----------------------------------------------------------------
Markus Armbruster (2):
      migration: Fix double-free on error path
      kvm: Fix kvm_vm_ioctl() and kvm_device_ioctl() return value

 accel/kvm/kvm-all.c | 4 ++--
 migration/multifd.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.49.0


