Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3030CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 11:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8zbq-0008UC-PW; Wed, 15 Oct 2025 07:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8zbp-0008Tr-4r
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8zbk-0003DR-2j
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760527428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NiVRCKIxO5VKWO9NQuhBuAM1/B350tyct5VE8lKJ8oM=;
 b=cfN7xkKEOS2x08QyAPgGnAKpEYG9piqwuuPPrQBatgjC7O9JcVxPATrnLtPPCZglNWFOaR
 1IiMykwnlpTboJw+GTvtWwelgERiGH8pJvTQTGMNzuP8A3gM4Eep6DHQINLL3ZBrSiQ0zw
 wF63NE3mwU4F9rCCWdeAv99OfRdoRqI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-Bmfpg1p9PPG-iSpiSvN7Bg-1; Wed,
 15 Oct 2025 07:23:46 -0400
X-MC-Unique: Bmfpg1p9PPG-iSpiSvN7Bg-1
X-Mimecast-MFC-AGG-ID: Bmfpg1p9PPG-iSpiSvN7Bg_1760527425
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64D83195608D; Wed, 15 Oct 2025 11:23:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E28851800577; Wed, 15 Oct 2025 11:23:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A2ECA18000B2; Wed, 15 Oct 2025 13:23:42 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 0/5] igvm: add support for igvm memory map parameter in
 native mode
Date: Wed, 15 Oct 2025 13:23:37 +0200
Message-ID: <20251015112342.1672955-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

v3:
 - Oh crap, no MAINTAINERS entry, so v1 + v2 probably went
   largely unnoticed.  Added a patch adding an entry, comments
   welcome.  Also added some people to Cc.
 - code is mostly unchanged.
v2:
 - add support for loading the initial register state

Gerd Hoffmann (5):
  igvm: move igvm.h file to include/system
  igvm: add support for igvm memory map parameter in native mode
  igvm: add support for initial register state load in native mode
  igvm: track memory regions created
  igvm: add MAINTAINERS entry

 {backends => include/system}/igvm.h |   7 ++
 target/i386/cpu.h                   |   3 +
 backends/igvm-cfg.c                 |   2 +-
 backends/igvm.c                     |  70 +++++++----
 stubs/igvm.c                        |  26 ++++
 target/i386/cpu.c                   |   4 +
 target/i386/igvm.c                  | 179 ++++++++++++++++++++++++++++
 MAINTAINERS                         |   9 ++
 stubs/meson.build                   |   1 +
 target/i386/meson.build             |   3 +
 10 files changed, 277 insertions(+), 27 deletions(-)
 rename {backends => include/system}/igvm.h (64%)
 create mode 100644 stubs/igvm.c
 create mode 100644 target/i386/igvm.c

-- 
2.51.0


