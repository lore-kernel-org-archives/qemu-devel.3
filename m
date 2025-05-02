Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17226C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 12:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uApEq-0000VN-FX; Fri, 02 May 2025 08:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1uApEp-0000V1-99
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1uApEn-0003Sk-83
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746187887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=c+knAeuiTD1Szt42KGehODz40fPYKzAhLUOaAeLhWzY=;
 b=G5gLmiEzCLMsZiXzq1njIn5XTwMrpNLQ5Re+VpSTQuM3+RA4V3Lv3CxKZlhIgG0rJtcGpi
 WqwcgQkfRpSnOQCO80MaodzRxHhpBXAawskOoI/gnrtuq0l59tJtC4oRnA3lqlDO6+DOWV
 enCco9v4xzsKlFdUdYcHDWUlOHGZHJA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-FY3KUtp4OWOlByPLwpQzfw-1; Fri,
 02 May 2025 08:11:24 -0400
X-MC-Unique: FY3KUtp4OWOlByPLwpQzfw-1
X-Mimecast-MFC-AGG-ID: FY3KUtp4OWOlByPLwpQzfw_1746187882
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1176F19560AA; Fri,  2 May 2025 12:11:22 +0000 (UTC)
Received: from desktop.redhat.com (unknown [10.45.224.121])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B3CC19560A3; Fri,  2 May 2025 12:11:16 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Alberto Faria <afaria@redhat.com>
Subject: [PATCH v3 0/2] scsi-disk: Add FUA write support
Date: Fri,  2 May 2025 13:11:13 +0100
Message-ID: <20250502121115.3613717-1-afaria@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=afaria@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add scsi-disk support for Force Unit Access (FUA) writes. The first patch lets
us avoid FUA emulation when the underlying driver supports it natively. The
second patch makes scsi-disk devices advertise FUA support by default.

v3:
- Restore flush on VERIFY.
- Modify hw_compat_10_0 instead of hw_compat_9_2.

v2:
- Drop FUA write emulation logic since the block layer already does that.
- Add machine type compat for "dpofua".

Alberto Faria (2):
  scsi-disk: Add native FUA write support
  scsi-disk: Advertise FUA support by default

 hw/core/machine.c   |  4 +++-
 hw/scsi/scsi-disk.c | 55 +++++++++++++--------------------------------
 2 files changed, 19 insertions(+), 40 deletions(-)

-- 
2.49.0


