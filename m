Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AEDCD4F48
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9vh-0004wX-Sa; Sat, 16 May 2026 03:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9vh-0004wN-1S
 for qemu-devel@nongnu.org; Sat, 16 May 2026 03:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9vd-0006xZ-Qa
 for qemu-devel@nongnu.org; Sat, 16 May 2026 03:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8qmHUPgOFlso4fL6/2vtJMa7EbPDXq3hjbaoj7N+YRY=;
 b=YSdj6o1JU/JAzX0TD/WEt5krfA/1QH6RPcaib6ANaNHr/g5fDkiVY1mL+MFHi/lh0fB6x1
 g0McQgvAqur5q9doYOfCPWWxVNPS3xxTIhzWBjE72VUBiszRcZ8tAIuYfmhOIgCOzW1C/9
 lsSpRNszCIzOe5FbXj2/Sg7Bw2bLxMs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-T2C8iOvONhm-jwLpvKUk1w-1; Sat,
 16 May 2026 03:59:18 -0400
X-MC-Unique: T2C8iOvONhm-jwLpvKUk1w-1
X-Mimecast-MFC-AGG-ID: T2C8iOvONhm-jwLpvKUk1w_1778918357
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C1DA19560B4
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 07:59:17 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3934B1800576; Sat, 16 May 2026 07:59:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 00/24] Fix various QOM object life-cycle issues
Date: Sat, 16 May 2026 11:58:59 +0400
Message-Id: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NTQ7CIBgFr9KwFsNf2+DKexgXLXxYTFoqINE0v
 btQF2ricpI38xYUwFsI6FAtyEOywbopA99VSA3ddAFsdWbECGuIYC2+uRFHCDFgqZXhvWykoBT
 l/ezB2MfWOp3fHO79FVQsgbIYbIjOP7ezRMvuXzdRTLASlBvekJpTevSghy7ulRtRCSf2UWsiv
 lWWVTAtcK2kMG33o67r+gLxhIV+8AAAAA==
X-Change-ID: 20260427-qom-tests-9dcf3b969411
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4835;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tU6cV9Iww+FN4JWdyyN17+DFSdlgCHw73ImgmZeGOOY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPOyvAzFJa2hcCT/9lQCIPpe/ZiynhdNw/ZQ
 ba073Ma3raJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzgAKCRDa6OEJdZac
 5TXYEACV1Jq4EInyEqRED5vP8VPPV3JJRfvpvFhu5DyZ4wAdr0Xo2MmwB7ZJIYCq5UOQnJKrmmY
 66QlJ8d1NCVdFhKJoSKUoGG8tLsK4KWK5GqVOhFdQqNEVFSHwpdMlHM72CbLYyNUg/xBipFCkIx
 qWRyiWZ3zFHanMJEnic6LorhWWjvdvuE6vqjJa+SFdMZSztjwrIgmJqV5+0GLZ6ghlzhM+bZmPT
 0aCrN3qdFoL9MxxPzpIRQG9rBH87G6JE5MBA/rpky0SVKa8xo2fG0Dh0lTh/3TESJtW47KrsPpd
 FIEgmEbmEy92tz4+eKOJfq1Sz1d2LTBaP7UskhAMXXs/I7A3jL1B9htuA+LBzqATRpAmhKhYr7T
 EYbfozgRcngBo4Lm6fQlXVccotU7URoAVkTMpB6wnob5jiSS+6qTulN6GmX0K982Qa9+v0APsFI
 sS6jQXbjgVeCrSG2oqIQVZm7DHQXZLgTN0XR8rpOoPcHgcZc3o7VkokjnVRDLVzFQIKLRB2+CcX
 l01I7IVeeNFdkXEM0TVnKGUj3BqD/HPtnoy1G6MYJORqG3/aWJuhB6IKC0OcLUZM+JMvnq7Qtv+
 C050ErcD9BzzVw3mLVjSopdldI3M4NqTirSSb++EnkaKzkTQFqWNfew2bOWvGQq2pqhR2JyXJb0
 ja5Ha7pA7N5uHew==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

After Markus's "Several QOM objects crash on introspection" report, I
started writing some unit test.

This series adds a new "qom-tests" qtest command that exercises basic QOM
object life-cycle: it instantiates all non-abstract object types, gets/sets
their properties, and unrefs them. This quickly surfaces leaks and crashes
that could otherwise be triggered at runtime via QMP qom commands.

The bulk of the series fixes the issues found by this test and ASan
help. Some of the patches are redundant with patches sent earlier on the
ML and marked as RFC, they should naturally be dropped during rebases,
but are added for completeness and to make sure CI pass after this
series in the meantime.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Changes in v3:
- update "hw/ipmi: reject NULL 'bmc'" & "hw/xlnx_dp: reject NULL
  'dpdma'"
- fixed user-only build in target/riscv patch
- add "ui/vt100: add vt100_fini() check" patch
- rebased after PR with first half of series patches landed
- Link to v2: https://lore.kernel.org/qemu-devel/20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com

Changes in v2:
- tweak error messages
- drop "qom: skip link property check callback", instead
  added two patches to avoid crash on NULL link check, and doc update
- drop "RFC system/ioport" in favour of Peter Xu fix
- added "hw/fsi: move OPBus qbus_init() to instance_init" to address TODO comment
- added "target/riscv: use hash table as set for user_options"
- gather a-b/r-b trailers
- Link to v1: https://lore.kernel.org/qemu-devel/20260427-qom-tests-v1-0-c413f3605311@redhat.com

---
Marc-André Lureau (24):
      ui/vt100: add vt100_fini() check
      hw/pci: handle missing bus in prop_pci_busnr_get
      chardev/char-socket: handle NULL addr in char_socket_get_addr
      hw/pci-bridge: handle missing parent in prop_pxb_uid_get
      hw/pci-host/i440fx: handle NULL bus in pci-hole64 getters
      hw/pci-host/q35: handle NULL bus in pci-hole64 getters
      hw/ipmi: reject NULL 'bmc' property rather than crash
      hw/xlnx_dp: reject NULL 'dpdma' property rather than crash
      hw/intc/apic: move checks to realize()
      backends/cryptodev-lkcf: skip cleanup when not initialized
      system/ioport: minor code simplification
      hw/core/machine: free shim_filename on finalization
      net/filter: free old values in property setters
      target/i386/sev: add finalize functions and fix leaking setters
      target/i386/kvm/tdx: free strings in tdx_guest_finalize
      hw/i386/nitro_enclave: add instance finalize
      hw/i386/pc: free pcspk on finalization
      hw/tpm: free PPI buffer on finalization
      hw/loongarch/virt: free flash devices and OEM strings on finalization
      hw/ppc/spapr: free host_model and host_serial on finalization
      target/riscv: fix general_user_opts hash table leak
      target/riscv: use hash table as set for user_options
      hw/i2c/pmbus: fix undefined behavior in pmbus_direct_mode2data
      qtest: add "qom-tests" command

 target/riscv/cpu.h                  |  3 ++-
 tests/qtest/libqtest.h              |  8 ++++++
 backends/cryptodev-lkcf.c           |  4 +++
 chardev/char-socket.c               |  4 +++
 hw/core/machine.c                   |  1 +
 hw/display/xlnx_dp.c                |  6 +++++
 hw/i2c/pmbus_device.c               |  4 +--
 hw/i386/nitro_enclave.c             | 11 ++++++++
 hw/i386/pc.c                        | 10 +++++++
 hw/intc/apic_common.c               | 23 +++++++++-------
 hw/ipmi/ipmi.c                      |  8 +++++-
 hw/loongarch/virt.c                 | 14 ++++++++++
 hw/pci-bridge/pci_expander_bridge.c |  8 +++++-
 hw/pci-host/i440fx.c                | 15 +++++++++--
 hw/pci-host/q35.c                   | 15 +++++++++--
 hw/pci/pci.c                        | 11 ++++++--
 hw/ppc/spapr.c                      |  2 ++
 hw/tpm/tpm_tis_sysbus.c             |  9 +++++++
 net/filter.c                        |  2 ++
 system/ioport.c                     |  3 +--
 system/qtest.c                      | 46 ++++++++++++++++++++++++++++++++
 target/i386/cpu-apic.c              |  6 +----
 target/i386/kvm/tdx.c               |  5 ++++
 target/i386/sev.c                   | 37 ++++++++++++++++++++++++++
 target/riscv/cpu.c                  | 53 ++++++++++++++++++++++---------------
 target/riscv/kvm/kvm-cpu.c          |  6 ++---
 tests/qtest/libqtest.c              |  6 +++++
 tests/qtest/qom-test.c              | 12 +++++++++
 ui/vt100.c                          |  3 +++
 29 files changed, 282 insertions(+), 53 deletions(-)
---
base-commit: 0bbb0c2b65db64c161f91d10a89269e6d319d2a7
change-id: 20260427-qom-tests-9dcf3b969411

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


