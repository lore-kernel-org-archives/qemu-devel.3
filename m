Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF093C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdwR-0006Mh-6t; Thu, 30 May 2024 07:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sCdwO-0006Kt-9i
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sCdwJ-0003bo-SG
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717068442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BNjflOWVknfFtqGCiOUeELcymM0Al1PgCM0YXN3i43A=;
 b=NYyyD+46jpUgHk3jbcmAjh9ylF6Rr/CD0FMRUbm/xeZgaTWYrQ2GJ12ZNrnPqDn86VZAmi
 v1TYgGfgAr0VL4ZSn0aW888dn4YoYD/7BdrwCZwhcNjki0POYf3ycpY9HC+pmFopvrB2g+
 7JuZFItL7ai1EvF+fyN1x/jqJ5iMrMA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-wYtXrI6XP0CZUwMiCX9mRw-1; Thu, 30 May 2024 07:27:21 -0400
X-MC-Unique: wYtXrI6XP0CZUwMiCX9mRw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD57A800281;
 Thu, 30 May 2024 11:27:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D502C15BB1;
 Thu, 30 May 2024 11:27:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3A74118000A9; Thu, 30 May 2024 13:27:18 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/4] allow to deprecate objects and devices
Date: Thu, 30 May 2024 13:27:13 +0200
Message-ID: <20240530112718.1752905-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

Put some infrastructure in place to allow tagging objects (including
devices) as deprected.  Use it to mark the ohci pci host adapter and
the usb hub as deprecated.

v2:
 - pick up reviews.
 - drop ohci patch.
 - add cirrus vga patch.

Gerd Hoffmann (4):
  qom: allow to mark objects (including devices) as deprecated.
  usb: add config options for the hub and hid devices
  usb/hub: deprecate, don't build by default
  vga/cirrus: deprecate, don't build by default

 include/qom/object.h        | 1 +
 hw/display/cirrus_vga.c     | 1 +
 hw/display/cirrus_vga_isa.c | 1 +
 hw/usb/dev-hub.c            | 1 +
 qom/qom-qmp-cmds.c          | 4 ++++
 system/qdev-monitor.c       | 5 +++++
 hw/display/Kconfig          | 1 -
 hw/usb/Kconfig              | 9 +++++++++
 hw/usb/meson.build          | 4 ++--
 qapi/qom.json               | 4 +++-
 10 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.45.1


