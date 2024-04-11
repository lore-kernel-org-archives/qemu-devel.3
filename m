Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028B6CD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 12:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rutKQ-0005pJ-TR; Thu, 11 Apr 2024 08:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rutKO-0005oR-T9
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 08:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rutKM-00079s-Q9
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 08:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712837689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sYvABxZQvcHAG7u7fJTunygMU1bKkd61+AECVXLwbLc=;
 b=ReJfUh7OVrZxbVptiU+yu6umkwbYfAq441ZsWYJuAbfK56S8i6cRJxy9Wc02JE5UJBAwK/
 Ol+uIqLqGQumAHDn9Ve/9dHHJowP3OtVKR+lr352WKeXgFbc81dwYQoQC3r/yJjI6wtVA8
 zsK1W62ty4aL2Iam+jGoZeEUDWC8mwo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-xYXVmnAFPlu8ZaCko2Iz8Q-1; Thu, 11 Apr 2024 08:14:46 -0400
X-MC-Unique: xYXVmnAFPlu8ZaCko2Iz8Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B968E80171B
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 12:14:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3501C444425;
 Thu, 11 Apr 2024 12:14:44 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: pbonzini@redhat.com,
	mtosatti@redhat.com,
	berrange@redhat.com
Cc: qemu-devel@nongnu.org, vchundur@redhat.com, rjarry@redhat.com,
 Anthony Harivel <aharivel@redhat.com>
Subject: [PATCH v5 0/3] Add support for the RAPL MSRs series
Date: Thu, 11 Apr 2024 14:14:31 +0200
Message-ID: <20240411121434.253353-1-aharivel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Dear maintainers, 

First of all, thank you very much for your review of my patch 
[1].

In this version (v5), I have attempted to address all the problems 
addressed by Daniel during the last review. I've been more careful with 
all the remarks made. 

However, one question remains unanswered pointing the issue with the 
location of "/var/local/run/qemu-vmsr-helper.sock", created by 
compute_default_paths(). QEMU is not allowed to reach the socket here.

Thank you again for your continued guidance. 

v4 -> v5
--------

- correct qio_channel_get_peerpid: return pid = -1 in case of error
- Vmsr_helper: compile only for x86
- Vmsr_helper: use qio_channel_read/write_all
- Vmsr_helper: abandon user/group
- Vmsr_energy.c: correct all error_report
- Vmsr thread: compute default socket path only once
- Vmsr thread: open socket only once
- Pass relevant QEMU CI

v3 -> v4
--------

- Correct memory leaks with AddressSanitizer  
- Add sanity check for QEMU and qemu-vmsr-helper for checking if host is 
  INTEL and if RAPL is activated.
- Rename poor variables naming for easier comprehension
- Move code that checks Host before creating the VMSR thread
- Get rid of libnuma: create function that read sysfs for reading the 
  Host topology instead

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

[1]: https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04417.html

Anthony Harivel (3):
  qio: add support for SO_PEERCRED for socket channel
  tools: build qemu-vmsr-helper
  Add support for RAPL MSRs in KVM/Qemu

 accel/kvm/kvm-all.c                      |  27 ++
 contrib/systemd/qemu-vmsr-helper.service |  15 +
 contrib/systemd/qemu-vmsr-helper.socket  |   9 +
 docs/specs/index.rst                     |   1 +
 docs/specs/rapl-msr.rst                  | 155 +++++++
 docs/tools/index.rst                     |   1 +
 docs/tools/qemu-vmsr-helper.rst          |  89 ++++
 include/io/channel.h                     |  21 +
 include/sysemu/kvm.h                     |   2 +
 include/sysemu/kvm_int.h                 |  32 ++
 io/channel-socket.c                      |  28 ++
 io/channel.c                             |  13 +
 meson.build                              |   7 +
 target/i386/cpu.h                        |   8 +
 target/i386/kvm/kvm-cpu.c                |   9 +
 target/i386/kvm/kvm.c                    | 428 ++++++++++++++++++
 target/i386/kvm/meson.build              |   1 +
 target/i386/kvm/vmsr_energy.c            | 335 ++++++++++++++
 target/i386/kvm/vmsr_energy.h            |  99 +++++
 tools/i386/qemu-vmsr-helper.c            | 529 +++++++++++++++++++++++
 tools/i386/rapl-msr-index.h              |  28 ++
 21 files changed, 1837 insertions(+)
 create mode 100644 contrib/systemd/qemu-vmsr-helper.service
 create mode 100644 contrib/systemd/qemu-vmsr-helper.socket
 create mode 100644 docs/specs/rapl-msr.rst
 create mode 100644 docs/tools/qemu-vmsr-helper.rst
 create mode 100644 target/i386/kvm/vmsr_energy.c
 create mode 100644 target/i386/kvm/vmsr_energy.h
 create mode 100644 tools/i386/qemu-vmsr-helper.c
 create mode 100644 tools/i386/rapl-msr-index.h

-- 
2.44.0


