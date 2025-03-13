Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC80C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsffv-0005GX-FE; Thu, 13 Mar 2025 06:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1tsfft-0005En-SY
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:20:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1tsffs-0002LL-6P
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741861222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1W9/gFe9cgcZGf1VJFPGmXZLJP85WQkRKI1Whq9qWK8=;
 b=RyA/rIerYW9oeY3/KFMKjW/0h3OE8PJ0frNek/2YUsy2vETsnfRz2C4HYuKj0sF8BdF5TT
 y2Vf8Jqf/oxpcYlwcPiSqK+Z7pCBM9imzRJMP576ZP5K0pZ+q08AEdxX1SDOHPRHDLpF0Z
 hsHkRsTSjftwPa3fWXkBMmKAdQEAZCE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-klrqri5xMsexkq9WK4pmTA-1; Thu,
 13 Mar 2025 06:19:14 -0400
X-MC-Unique: klrqri5xMsexkq9WK4pmTA-1
X-Mimecast-MFC-AGG-ID: klrqri5xMsexkq9WK4pmTA_1741861153
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3202818004A9
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 10:19:13 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.22.17])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E17D3003770; Thu, 13 Mar 2025 10:19:10 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: pbonzini@redhat.com,
	berrange@redhat.com
Cc: qemu-devel@nongnu.org,
	Anthony Harivel <aharivel@redhat.com>
Subject: [PATCH 0/2] Add AMD CPU for RAPL MSR support
Date: Thu, 13 Mar 2025 11:19:00 +0100
Message-ID: <20250313101902.835556-1-aharivel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,

The following patch add the support for AMD CPU for RAPL MSR. This was 
one of the two current limitation of the introduction patch.

This has been tested on AMD Ryzen 5850U. I was able to mount the RAPL 
driver in a VM with '-cpu host'. The counter value are increasing 
properly.

I added a second patch to silence an error that is not really an error. 
I change it to a tracepoint following Daniel advice. Thanks Daniel !

Thanks
Anthony

Anthony Harivel (2):
  target/i386/kvm: add AMD support for RAPL MSR
  target/i386/kvm: Change error_report() to tracepoint in
    vmsr_read_thread_stat()

 docs/specs/rapl-msr.rst       |  21 ++++---
 include/system/kvm_int.h      |   4 ++
 target/i386/cpu.h             |   2 +
 target/i386/kvm/kvm.c         | 111 ++++++++++++++++++++++------------
 target/i386/kvm/trace-events  |   3 +
 target/i386/kvm/vmsr_energy.c |  13 +++-
 target/i386/kvm/vmsr_energy.h |   1 +
 tools/i386/qemu-vmsr-helper.c |  47 ++++++++------
 tools/i386/rapl-msr-index.h   |   4 ++
 9 files changed, 139 insertions(+), 67 deletions(-)

-- 
2.48.1


