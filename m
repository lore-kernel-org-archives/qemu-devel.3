Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BF2CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 10:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8G85-0003pB-HR; Mon, 13 Oct 2025 06:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8G82-0003on-UJ
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 06:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8G7y-00088K-Mf
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 06:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760352603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6eYJnCNkS5h75wgx+BgwuWwMf/k6NoD+Y97fPNtg1vQ=;
 b=U/m/mo9t2OgkhMaKr0fkKFJkCzWt+PDS4syDCvE9fWEyEhsAvj3nWlHQHVs/HF7cklZggL
 YVNMrMLH0iROpiaK+SPlRMAgsIIDLQQih/0JAV0gYOkJc/uDgKs5ekrCT9wM9y8l2X5Pm3
 tApuELHh5aRreOpy96dn31ChpUXZZus=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-sT5Yp2PbN0yRkIWqir45yg-1; Mon,
 13 Oct 2025 06:49:59 -0400
X-MC-Unique: sT5Yp2PbN0yRkIWqir45yg-1
X-Mimecast-MFC-AGG-ID: sT5Yp2PbN0yRkIWqir45yg_1760352598
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A53AC1956087; Mon, 13 Oct 2025 10:49:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98BB71954102; Mon, 13 Oct 2025 10:49:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5A90B18000B2; Mon, 13 Oct 2025 12:49:54 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 0/2] hw/uefi: add support for receiving the firmware log
 via monitor.
Date: Mon, 13 Oct 2025 12:49:52 +0200
Message-ID: <20251013104954.250166-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



Gerd Hoffmann (2):
  hw/uefi: add "info firmware-log" + "query-firmware-log" monitor
    commands
  hw/uefi/ovmf-log: add maxsize parameter

 include/monitor/hmp.h      |   1 +
 hw/uefi/ovmf-log.c         | 291 +++++++++++++++++++++++++++++++++++++
 tests/qtest/qmp-cmd-test.c |   2 +
 hmp-commands-info.hx       |  13 ++
 hw/uefi/meson.build        |   2 +-
 qapi/machine.json          |  26 ++++
 6 files changed, 334 insertions(+), 1 deletion(-)
 create mode 100644 hw/uefi/ovmf-log.c

-- 
2.51.0


