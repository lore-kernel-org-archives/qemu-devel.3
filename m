Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A4AC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 15:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9nzq-0006c1-Sn; Wed, 22 May 2024 11:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1s9nzp-0006bg-10
 for qemu-devel@nongnu.org; Wed, 22 May 2024 11:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1s9nzn-0007Ci-54
 for qemu-devel@nongnu.org; Wed, 22 May 2024 11:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716392114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kpWkKYRZfkx08fdYPDExVbTdcACNotsFarIOvyHemfQ=;
 b=Ei4eHKoP/la2HQlZiI9uPKGka1fbZolPfYOBdckXeXgAb4qwKWyT9JSTrD4wXekpSff+Bi
 2zDNqtFeRuMcwsxxRts0IBLa/h7laDIG8Nr37D5aLuYd8u9QiIDbp21t0bmddOm0rBBmsp
 dGLsLi9lG7RfgVRRnObRkppG+MFqlJI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-veWn3IXUOS27j7EosKaNiQ-1; Wed, 22 May 2024 11:35:13 -0400
X-MC-Unique: veWn3IXUOS27j7EosKaNiQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF1688008A4
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 15:35:12 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.208.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4150D492BC6;
 Wed, 22 May 2024 15:35:11 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: pbonzini@redhat.com,
	mtosatti@redhat.com,
	berrange@redhat.com
Cc: qemu-devel@nongnu.org, vchundur@redhat.com, rjarry@redhat.com,
 Anthony Harivel <aharivel@redhat.com>
Subject: [PATCH v6 0/3] Add support for the RAPL MSRs series
Date: Wed, 22 May 2024 17:34:49 +0200
Message-ID: <20240522153453.1230389-1-aharivel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

In this version (v6), I have attempted to address all the problems 
addressed by Daniel and Paolo during the last review. 

However, two open questions remains unanswered that would require the 
attention of a x86 maintainers: 

1)Should I move from -kvm to -cpu the rapl feature ? [2]

2)Should I already rename to "rapl_vmsr_*" in order to anticipate the 
  futur TMPI architecture ? [end of 3] 

Thank you again for your continued guidance. 

v5 -> v6
--------
- Better error consistency in qio_channel_get_peerpid()
- Memory leak g_strdup_printf/g_build_filename corrected
- Renaming several struct with "vmsr_*" for better namespace
- Renamed several struct with "guest_*" for better comprehension
- Optimization suggerate from Daniel
- Crash problem solved [4]

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

[1]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg01570.html
[2]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg03947.html
[3]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg02350.html
[4]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg02481.html

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
 include/sysemu/kvm_int.h                 |  32 ++
 io/channel-socket.c                      |  28 ++
 io/channel.c                             |  13 +
 meson.build                              |   7 +
 target/i386/cpu.h                        |   8 +
 target/i386/kvm/kvm.c                    | 431 +++++++++++++++++-
 target/i386/kvm/meson.build              |   1 +
 target/i386/kvm/vmsr_energy.c            | 337 ++++++++++++++
 target/i386/kvm/vmsr_energy.h            |  99 +++++
 tools/i386/qemu-vmsr-helper.c            | 530 +++++++++++++++++++++++
 tools/i386/rapl-msr-index.h              |  28 ++
 19 files changed, 1831 insertions(+), 1 deletion(-)
 create mode 100644 contrib/systemd/qemu-vmsr-helper.service
 create mode 100644 contrib/systemd/qemu-vmsr-helper.socket
 create mode 100644 docs/specs/rapl-msr.rst
 create mode 100644 docs/tools/qemu-vmsr-helper.rst
 create mode 100644 target/i386/kvm/vmsr_energy.c
 create mode 100644 target/i386/kvm/vmsr_energy.h
 create mode 100644 tools/i386/qemu-vmsr-helper.c
 create mode 100644 tools/i386/rapl-msr-index.h

-- 
2.45.1


