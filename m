Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BC2CD6E55
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjNy-000224-1u; Sat, 06 Jun 2026 01:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjNr-00021t-KL
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjNp-0008Ac-Uc
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780722943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=321Sk4W0q2eBghQrYQieI1LQR7MJO5GdTpm52bl3Ibo=;
 b=Qb7vSLstGmJp/2b+BxHUGpTXEbnuLc55PINRwgxp3OjIBhfP9CzuPP/ZcnGyoUpsdwaL4l
 52ZQYXyxUNEUIMyYNEd4hmhzFHr5u3iOq5yQBmYauledsj8emsBl3mT5WhxJDJMalOuFhN
 Tb8RJDoXUblqXyjlt4uVSo0hMdRx9Ec=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-w2lhZ3lnP9yZrRMMtD9zLg-1; Sat,
 06 Jun 2026 01:15:41 -0400
X-MC-Unique: w2lhZ3lnP9yZrRMMtD9zLg-1
X-Mimecast-MFC-AGG-ID: w2lhZ3lnP9yZrRMMtD9zLg_1780722941
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DDC0195608E
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:15:41 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED47D1955BC0; Sat,  6 Jun 2026 05:15:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL v2 00/23] Fix various QOM object life-cycle issues
Message-Id: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
Date: Sat, 06 Jun 2026 09:15:32 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=3806;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ygHq6RKCcncIaJ3ibqV1KclPPvEx3yFMKLZQHcoGl7E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqI6z0tDpOBou7oPrQjS9bDSdBtD7bdQC1AT9/k
 EhdYU2pelqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiOs9AAKCRDa6OEJdZac
 5UPXD/9Y04zpjUpyrHcexZ5cGowJ/vlGNGPQ2NwnrbN+Uod/tttcUjFoxGydGL8KDYVydNC6Yje
 Tbx09O44t+lrofiKNelkqnpP3ehCsn5Dbav6ECZ8MLN8D/9h3Uy6GCYtkFF/MIAsLR2puyXneC4
 v/5DpWqIw7QgbOczdSeuMi6Ia22o/2EDurIGI6ClI/st1nXyK/hfCHK4/kKFQadfSrzqNgGf1/G
 HHwD4A3GVfLEv3Xue4MZM+JtDe8AXczQukWoKHl7SlWEzXfAUNvZ7K8igJyicq2SgFTwiG8Lf45
 7DVXJ8WIZXNleXnRBf0E3cWsDsouF14xUZcjx8gXT9mvh8JIO7gZlcPk85eSkKEh+yVGMAZnzpt
 +y5qO1/kYHMzC0WGg/utaknRbK+sF8oV59cpWdJNVPozQuy2+6av3ivaYWuPyxVH3NwXehWpR07
 XRFLAlj99vbgnB9xUeS2Y6mdlN9CYwyh9juJpBekXzG+iPnw4cm/xYXoIIyQ6afXS8Kng05zJjD
 9VEWW2ga8RzLMVW+z0mT8TFuLS6Urv/sWlEYe4FDwL0NoahZ5ZCDaJKQkZlCMpd+dwu0ftKQLg2
 W+lmQcLZo3o5ZRtEbxJXIFTtuiWcmXSmTYpT02MI9sazVydgBdjJLbGxluZIyObmgQvbSFrV6Fo
 VcY8OQRUDKzlPzA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 29c042c6e9d4a09d4a0ac3fa54aeb7ee08ce0bdc:

  lcitool: remove Cirrus CI support (2026-06-03 12:45:38 -0400)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/qom-tests-pr-v2

for you to fetch changes up to f74122507380ee53170c5b62e733bc247a76b4be:

  qtest: add "qom-tests" command (2026-06-06 09:15:23 +0400)

----------------------------------------------------------------
Fix various QOM object life-cycle issues

This series adds a new "qom-tests" qtest command that exercises basic QOM
object life-cycle: it instantiates all non-abstract object types, gets/sets
their properties, and unrefs them. This quickly surfaces leaks and crashes
that could otherwise be triggered at runtime via QMP qom commands.

----------------------------------------------------------------
Marc-André Lureau (23):
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
 hw/i2c/pmbus_device.c               |  6 +++--
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
 target/riscv/kvm/kvm-cpu.c          |  8 +++---
 tests/qtest/libqtest.c              |  6 +++++
 tests/qtest/qom-test.c              | 12 +++++++++
 28 files changed, 282 insertions(+), 54 deletions(-)


