Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE8FCAC58D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 16:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqadW-0005kB-7o; Tue, 17 Sep 2024 12:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1sqadS-0005gK-6c
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1sqadQ-0003bt-N2
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726588858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HIGI/sdvxIwyaDWGAZFZC7p06nC5601WYHUCYjSStNQ=;
 b=fLRh/CFBJGOYiqf+1az3vyl7AEbEJRB63QHotETaaLhaHaDcIVTNg5s4Ewl6bsMHNlVCHM
 LUfJSBDLTalq6XgTkjy22inYy132dzy8dL6YJaWezAvLIXPwPivfWumB4Ensb+zUfVbp2/
 UqIznl3/ktQv7K9G6vXxVmmhMQqtb9c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-628MTAWaPLmpcqJh0h8y7w-1; Tue,
 17 Sep 2024 12:00:54 -0400
X-MC-Unique: 628MTAWaPLmpcqJh0h8y7w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2ABA194511F
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 16:00:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.82])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 720AA3000238; Tue, 17 Sep 2024 16:00:52 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH RESEND v4 0/4] target/i386: Various Hyper-V related fixes
Date: Tue, 17 Sep 2024 18:00:47 +0200
Message-ID: <20240917160051.2637594-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Changes since '[PATCH RESEND v3 0/3] i386: Fix Hyper-V Gen1 guests stuck 
on boot with 'hv-passthrough':

- Added "target/i386: Make sure SynIC state is really updated before KVM_RUN" 
  to the set.
 
This is a long pending collection of fixes for various Hyper-V related 
issues, mostly detected by tests. On top of that, the patchset updates
Hyper-V related documentation adding recommendations.

Vitaly Kuznetsov (4):
  target/i386: Fix conditional CONFIG_SYNDBG enablement
  target/i386: Exclude 'hv-syndbg' from 'hv-passthrough'
  target/i386: Make sure SynIC state is really updated before KVM_RUN
  docs/system: Add recommendations to Hyper-V enlightenments doc

 docs/system/i386/hyperv.rst | 43 +++++++++++++++++++++++++++++++++----
 target/i386/cpu.c           |  2 ++
 target/i386/kvm/hyperv.c    |  1 +
 target/i386/kvm/kvm.c       | 18 ++++++++++------
 4 files changed, 54 insertions(+), 10 deletions(-)

-- 
2.46.0


