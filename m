Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C43C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 17:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9pLD-0000Mo-Gu; Wed, 22 May 2024 13:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9pL7-0000LV-AU
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:01:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9pL2-0006Fe-Ua
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716397275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=91VsFKMjs7kbThzPW6ISkk3AMayVD+ZM3jz2qHaTQnE=;
 b=irw9TneOFnkenJvo+PDtaRdHpcHW1DM1ck5hAP4AkNILYvLu26NYUJRL9BViN45WxbBRPC
 X/sRX/GEDfaz10+Gf52WLDlZDTTwJsdy+OJEqh0JUzJ1WUcJ93AjB/1jbmWoAjZ/Sdn+z9
 AZxjKfKB6CZ54Qi5oPbhYdeSH8Mdxgc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-lQ18FfgAM-SRNaS_zjjpvA-1; Wed,
 22 May 2024 13:01:11 -0400
X-MC-Unique: lQ18FfgAM-SRNaS_zjjpvA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B6C13800083;
 Wed, 22 May 2024 17:01:11 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B28143C27;
 Wed, 22 May 2024 17:01:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 0/7] s390x/ccw: Error reporting cleanups
Date: Wed, 22 May 2024 19:01:00 +0200
Message-ID: <20240522170107.289532-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello,

The first patches of this series simply apply the practices described
in the Rules section of the qapi/error.h file for routines taking an
'Error **' argument. The remaining patches are a fixup in the error
path of vfio_ccw_realize() and some error reporting adjustements.

Applies on top of this vfio PR :

  https://lore.kernel.org/qemu-devel/20240522095442.195243-1-clg@redhat.com

Thanks,

C.

Cédric Le Goater (6):
  hw/s390x/ccw: Make s390_ccw_get_dev_info() return a bool
  s390x/css: Make CCWDeviceClass::realize return bool
  hw/s390x/ccw: Remove local Error variable from s390_ccw_realize()
  s390x/css: Make S390CCWDeviceClass::realize return bool
  vfio/ccw: Use the 'Error **errp' argument of vfio_ccw_realize()
  vfio/{ap,ccw}: Use warn_report_err() for IRQ notifier registration
    errors

Zhenzhong Duan (1):
  vfio/ccw: Fix the missed unrealize() call in error path

 hw/s390x/ccw-device.h       |  2 +-
 include/hw/s390x/s390-ccw.h |  2 +-
 hw/s390x/ccw-device.c       |  3 ++-
 hw/s390x/s390-ccw.c         | 29 +++++++++++++----------------
 hw/vfio/ap.c                |  2 +-
 hw/vfio/ccw.c               | 18 ++++++++----------
 6 files changed, 26 insertions(+), 30 deletions(-)

-- 
2.45.1


