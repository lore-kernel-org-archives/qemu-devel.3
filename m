Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4152DC54736
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 19:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj1rH-00024N-5a; Tue, 27 Aug 2024 15:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sj1rF-0001xi-K4
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 15:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sj1rE-0003AR-9Q
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 15:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724786878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QuGEoePjdYmAvP51R2QVcMQr4oIRE7D6K0VSaRAMtIQ=;
 b=JGYk21DpHW4H6qWj2Xxw75Y+2zmip+NVI2zAjnxeR+QBRjI6YRbiaHOsKJTeRuGZbn8New
 P/Zf476HyWqz7NDZYL6Mms3tXCpVGoAf4V6KObnKipGEUAZ66nWa8h5t+LFg782WzglmnH
 qTG4z6bdvgiwPKv2WUKyho4hMA7A2y8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-WnycXezRMj65RqE6F1VO4Q-1; Tue,
 27 Aug 2024 15:27:54 -0400
X-MC-Unique: WnycXezRMj65RqE6F1VO4Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A8BA1955D55; Tue, 27 Aug 2024 19:27:53 +0000 (UTC)
Received: from localhost (unknown [10.2.16.119])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9B431955F40; Tue, 27 Aug 2024 19:27:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, pkrempa@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 0/2] qdev-monitor: avoid QemuOpts in QMP device_add()
Date: Tue, 27 Aug 2024 15:27:49 -0400
Message-ID: <20240827192751.948633-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

v3:
- Duplicate drain_call_rcu() into hmp_device_add() because moving it into
  qdev_device_add_from_qdict turned out to be unsafe.
v2:
- Rename Patch 1 to indicate that we're avoiding QemuOpts rather than doing a
  full conversion to QAPI. Also mention that 'gen': false is still being used.
  [Markus]
- Add Patch 2 to address a TODO comment suggesting that
  qemu_create_cli_devices() should call qmp_device_add(). [Markus]
- Move drain_call_rcu() into qdev_device_add_from_qdict() to avoid code
  duplication. [Markus]

This series enables non-scalar parameter parsing in device_add (e.g.
virtio-blk-pci,iothread-vq-mapping=). Stop converting from QDict to QemuOpts
and back again as this loses type information and cannot represent non-scalars.

Stefan Hajnoczi (2):
  qdev-monitor: avoid QemuOpts in QMP device_add
  vl: use qmp_device_add() in qemu_create_cli_devices()

 system/qdev-monitor.c | 44 ++++++++++++++++++++++++++++---------------
 system/vl.c           | 14 ++++----------
 2 files changed, 33 insertions(+), 25 deletions(-)

-- 
2.46.0


