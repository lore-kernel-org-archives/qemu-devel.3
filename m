Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE452CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v90Hp-0008S3-GR; Wed, 15 Oct 2025 08:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v90HY-0008PM-Ri
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 08:07:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v90HM-0000pp-Dc
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 08:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760530009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TmLE5qULar6pYnO/tyLlMzz75kXOfv4nRblR5cEExEY=;
 b=W+hIUmzCH4tGjiDyAfvrVmM1TiNHn4UpPftAtKsMbwovcOeiuFyahY+NVv1p1osgglfga2
 PbZ4nYmdF3ea3lORJ2VEuQcHpLBTVk9tDb7osYDsHzFqbwIZnDrMx79+crd3EXtVYwr8wN
 ofkwKY2sqSZTjNctsmLEnt/6IR3rqxc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-C8ZJxx9POWONvVMzaOiGLQ-1; Wed,
 15 Oct 2025 08:06:46 -0400
X-MC-Unique: C8ZJxx9POWONvVMzaOiGLQ-1
X-Mimecast-MFC-AGG-ID: C8ZJxx9POWONvVMzaOiGLQ_1760530005
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 699E6180840C; Wed, 15 Oct 2025 12:06:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E22661800592; Wed, 15 Oct 2025 12:06:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9F00C18000B2; Wed, 15 Oct 2025 14:06:37 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v5 0/3] hw/uefi: add support for receiving the firmware log
 via monitor.
Date: Wed, 15 Oct 2025 14:06:34 +0200
Message-ID: <20251015120637.1736402-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
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

v5:
 - address review comments.
 - split hmp command to separate patch.

Gerd Hoffmann (3):
  hw/uefi: add query-firmware-log monitor command
  hw/uefi: add 'info firmware-log' hmp monitor command.
  hw/uefi/ovmf-log: add maxsize parameter

 include/monitor/hmp.h      |   1 +
 hw/uefi/ovmf-log.c         | 286 +++++++++++++++++++++++++++++++++++++
 tests/qtest/qmp-cmd-test.c |   2 +
 hmp-commands-info.hx       |  13 ++
 hw/uefi/meson.build        |   2 +-
 qapi/machine.json          |  29 ++++
 6 files changed, 332 insertions(+), 1 deletion(-)
 create mode 100644 hw/uefi/ovmf-log.c

-- 
2.51.0


