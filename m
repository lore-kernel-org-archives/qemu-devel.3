Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CFCCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 08:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBUSq-00017o-4s; Wed, 22 Oct 2025 04:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vBUSj-00016k-MD
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:44:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vBUSi-0006jf-3b
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761122691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9IR/WIC+yPIAGAWLQTKorG1MMjN8+aLVT1Tu1pFvSf4=;
 b=BHo0KjldIoVnbxRQy/d9B0XRHlcHF7RzBDEJrvnZKutR3U44oq5wjyK9JvuQRCCUhNTZqb
 ucyHrRsFZ7y1kqEu9i7yAX1Vxoe53LCyjSB/v+Cho3DbRRz4w39Trfld+dtmMY3Gemnl0D
 4tZUTpUWCscO2u/fJAnDgIW3+Q+Td3Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-TnkZ_94uPae6xc4HzVT_5Q-1; Wed,
 22 Oct 2025 04:44:48 -0400
X-MC-Unique: TnkZ_94uPae6xc4HzVT_5Q-1
X-Mimecast-MFC-AGG-ID: TnkZ_94uPae6xc4HzVT_5Q_1761122687
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B81EA180B5E7; Wed, 22 Oct 2025 08:44:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AF4D1800584; Wed, 22 Oct 2025 08:44:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B166218000B5; Wed, 22 Oct 2025 10:44:39 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: [PATCH v4 0/5] igvm: add support for igvm memory map parameter in
 native mode
Date: Wed, 22 Oct 2025 10:44:34 +0200
Message-ID: <20251022084439.242476-1-kraxel@redhat.com>
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

v4:
 - misc minor fixes as suggested by Stefano
 - pick up review tags
 - add Ani as reviewer

v3:
 - Oh crap, no MAINTAINERS entry, so v1 + v2 probably went
   largely unnoticed.  Added a patch adding an entry, comments
   welcome.  Also added some people to Cc.
 - code is mostly unchanged.
v2:
 - add support for loading the initial register state

Gerd Hoffmann (5):
  igvm: move igvm.h file to include/system
  igvm: fix off by one bug in memmap entry count checking
  igvm: add support for igvm memory map parameter in native mode
  igvm: add support for initial register state load in native mode
  igvm: add MAINTAINERS entry

 {backends => include/system}/igvm.h |   7 ++
 target/i386/cpu.h                   |   3 +
 backends/igvm-cfg.c                 |   2 +-
 backends/igvm.c                     |  50 ++++----
 stubs/igvm.c                        |  26 ++++
 target/i386/cpu.c                   |   6 +
 target/i386/igvm.c                  | 180 ++++++++++++++++++++++++++++
 MAINTAINERS                         |  10 ++
 stubs/meson.build                   |   1 +
 target/i386/meson.build             |   3 +
 10 files changed, 266 insertions(+), 22 deletions(-)
 rename {backends => include/system}/igvm.h (64%)
 create mode 100644 stubs/igvm.c
 create mode 100644 target/i386/igvm.c

-- 
2.51.0


