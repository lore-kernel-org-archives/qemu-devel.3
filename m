Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E479FC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 16:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhXvr-0004HE-Ki; Tue, 05 Mar 2024 11:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1rhXvS-0004Cd-DU
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 11:46:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1rhXvQ-0001X3-Ro
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 11:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709657155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZGyHl/ohgcv7TwxJhwCIe+U2WCSG9+lfm/nNZfJKEIY=;
 b=K6tjBsdJcc7v3vuRuS1nYvq03F0Bu91RBuyFzrq8O9V3sC/bYvwpVgsAsSLtPyFXTME+iR
 BK41aUVoVTT4O23oTovYDdfe2eWtomSRux07wmhyTx96ybMEWl86csWNQ5jY5YOZoelXrB
 J5iw9lZNqrHqMNrsDceBZINmS8eeR9U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-PPjGIh39P6e2J-ZiWxkCDA-1; Tue,
 05 Mar 2024 11:42:06 -0500
X-MC-Unique: PPjGIh39P6e2J-ZiWxkCDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A62D41C382A1
 for <qemu-devel@nongnu.org>; Tue,  5 Mar 2024 16:42:06 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 115D74073486;
 Tue,  5 Mar 2024 16:42:05 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH RESEND v3 0/3] i386: Fix Hyper-V Gen1 guests stuck on boot
 with 'hv-passthrough'
Date: Tue,  5 Mar 2024 17:42:01 +0100
Message-ID: <20240305164204.525575-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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

Changes since 'RESEND v2':
- Included 'docs/system: Add recommendations to Hyper-V enlightenments doc'
  in the set as it also requires a "RESEND")

Hyper-V Gen1 guests are getting stuck on boot when 'hv-passthrough' is
used. While 'hv-passthrough' is a debug only feature, this significantly
limit its usefullness. While debugging the problem, I found that there are
two loosely connected issues:
- 'hv-passthrough' enables 'hv-syndbg' and this is undesired.
- 'hv-syndbg's support by KVM is detected incorrectly when !CONFIG_SYNDBG.

Fix both issues; exclude 'hv-syndbg' from 'hv-passthrough' and don't allow
to turn on 'hv-syndbg' for !CONFIG_SYNDBG builds. 

Vitaly Kuznetsov (3):
  i386: Fix conditional CONFIG_SYNDBG enablement
  i386: Exclude 'hv-syndbg' from 'hv-passthrough'
  docs/system: Add recommendations to Hyper-V enlightenments doc

 docs/system/i386/hyperv.rst | 43 +++++++++++++++++++++++++++++++++----
 target/i386/cpu.c           |  2 ++
 target/i386/kvm/kvm.c       | 18 ++++++++++------
 3 files changed, 53 insertions(+), 10 deletions(-)

-- 
2.43.2


