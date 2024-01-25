Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889C3C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 07:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSu5p-0003Um-6c; Thu, 25 Jan 2024 02:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rSu5m-0003Tk-33
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 02:24:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rSu5h-0005cH-Ox
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 02:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706167441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HqK5Jg2AWC298Chjn6yXJQK8HIzW7u+LTdEhFHXTGT4=;
 b=UMVxyuMuijC+xxg+qACvAIfz9ZYS9DsUz9tf3LA1ECUqcFbeehnwamtlyVK9rsdjfHHySS
 7bO7JrmebkupD3iDSL+9kyx3vE875oFYs7bnNHoC3BqRvvF/UPC1O7OdDkmmT72etqMkV3
 uZQ5zTAVxEHi7eSm2ZoVJD3p7aJkMpQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-0X7hC3IgMP-6SGRxhl5dmA-1; Thu, 25 Jan 2024 02:22:23 -0500
X-MC-Unique: 0X7hC3IgMP-6SGRxhl5dmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C094484AE40
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 07:22:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.208.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71F231121306;
 Thu, 25 Jan 2024 07:22:21 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: pbonzini@redhat.com,
	mtosatti@redhat.com,
	berrange@redhat.com
Cc: qemu-devel@nongnu.org, vchundur@redhat.com,
 Anthony Harivel <aharivel@redhat.com>
Subject: [PATCH v3 0/3] Add support for the RAPL MSRs series
Date: Thu, 25 Jan 2024 08:22:11 +0100
Message-ID: <20240125072214.318382-1-aharivel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Dear maintainers,

First of all, thank you very much for your recent review of my patch 
[1].

In this version (v3), I have attempted to address the most crucial and 
challenging aspect highlighted in your last review.

I am hopeful that we can now engage in a discussion and address the 
remaining potential points that need attention.

Thank you for your continued guidance.

v2 -> v3
--------

- Move all memory allocations from Clib to Glib

- Compile on *BSD (working on Linux only)

- No more limitation on the virtual package: each vCPU that belongs to 
  the same virtual package is giving the same results like expected on 
  a real CPU.
  This has been tested topology like:
     -smp 4,sockets=2
     -smp 16,sockets=4,cores=2,threads=2

v1 -> v2
--------

- To overcome the CVE-2020-8694 a socket communication is created
  to a priviliged helper

- Add the priviliged helper (qemu-vmsr-helper)

- Add SO_PEERCRED in qio channel socket

RFC -> v1
---------

- Add vmsr_* in front of all vmsr specific function

- Change malloc()/calloc()... with all glib equivalent

- Pre-allocate all dynamic memories when possible

- Add a Documentation of implementation, limitation and usage

Best regards,
Anthony

[1]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg1003382.html

Anthony Harivel (3):
  qio: add support for SO_PEERCRED for socket channel
  tools: build qemu-vmsr-helper
  Add support for RAPL MSRs in KVM/Qemu

 accel/kvm/kvm-all.c                      |  27 ++
 contrib/systemd/qemu-vmsr-helper.service |  15 +
 contrib/systemd/qemu-vmsr-helper.socket  |   9 +
 docs/specs/index.rst                     |   1 +
 docs/specs/rapl-msr.rst                  | 133 ++++++
 docs/tools/index.rst                     |   1 +
 docs/tools/qemu-vmsr-helper.rst          |  89 ++++
 include/io/channel.h                     |  21 +
 include/sysemu/kvm_int.h                 |  17 +
 io/channel-socket.c                      |  23 +
 io/channel.c                             |  12 +
 meson.build                              |   5 +
 target/i386/cpu.h                        |   8 +
 target/i386/kvm/kvm.c                    | 348 ++++++++++++++++
 target/i386/kvm/meson.build              |   1 +
 target/i386/kvm/vmsr_energy.c            | 295 +++++++++++++
 target/i386/kvm/vmsr_energy.h            |  87 ++++
 tools/i386/qemu-vmsr-helper.c            | 507 +++++++++++++++++++++++
 tools/i386/rapl-msr-index.h              |  28 ++
 19 files changed, 1627 insertions(+)
 create mode 100644 contrib/systemd/qemu-vmsr-helper.service
 create mode 100644 contrib/systemd/qemu-vmsr-helper.socket
 create mode 100644 docs/specs/rapl-msr.rst
 create mode 100644 docs/tools/qemu-vmsr-helper.rst
 create mode 100644 target/i386/kvm/vmsr_energy.c
 create mode 100644 target/i386/kvm/vmsr_energy.h
 create mode 100644 tools/i386/qemu-vmsr-helper.c
 create mode 100644 tools/i386/rapl-msr-index.h

-- 
2.43.0


