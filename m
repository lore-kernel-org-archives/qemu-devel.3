Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F384CD343A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJraD-0007Ut-Dw; Mon, 04 May 2026 07:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJraA-0007UM-O3
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJra8-0000lt-0U
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S/z45fmEm0PjMVQmPl8UN4OhYtYkCO5fR7/JcJElm3U=;
 b=HOJdkem0B/JldvwrdxcyzRxHAbeg/sYo6JTR5oRehRS3MbUIiCQ8+dXo0pcgmWMfEWTxl5
 UehkhdHSDo+F+goyIMRXp1hAOPUdeIjCHM+Bw39KpIc8HFCVDLwPWtR2Kc8qvsg29ASSoH
 rKFTXbR91ubiIOBVcRa8JPAgOi5S2eI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-Bgi5IbSoPjCRQFhAhiWGmA-1; Mon,
 04 May 2026 07:35:18 -0400
X-MC-Unique: Bgi5IbSoPjCRQFhAhiWGmA-1
X-Mimecast-MFC-AGG-ID: Bgi5IbSoPjCRQFhAhiWGmA_1777894516
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FD5C195609E; Mon,  4 May 2026 11:35:16 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 385BE1800347; Mon,  4 May 2026 11:35:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 00/46] Fix various QOM object life-cycle issues
Date: Mon, 04 May 2026 15:34:48 +0400
Message-Id: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBAAv0L2bE23RQye/IfhAO0iNYFitxIN6
 d8tePU4yWRmBabgiOFSrBBocez8lEEdCjBDO91JOJsZlFSVLNVZPP0oInFkUVvT666u6hIRsj8
 H6t17b92aH/Ore5CJW2AzBsfRh88+W3Dz/nUXFFKYEnWvK3nSiNdAdmjj0fgRmpTSF6Hf0Fa1A
 AAA
X-Change-ID: 20260427-qom-tests-9dcf3b969411
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, peterx@redhat.com, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Pavel Pisa <pisa@fel.cvut.cz>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6846;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9xyeXP+FHzQsUEcHJT68T/vfgF/olbeEFtj1T6k2HCQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRrFj+CSRvGwCiJtSVJoP+RjbeTb0KmvioRn
 ZmPXg5ZS2uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEawAKCRDa6OEJdZac
 5fFzD/9fMIyr9EsP+J3MVz2Cgs8xfvUq089SUy8eMWKC1mGVdkl+m5ASTEJZsR2X4QDiWCZb+tt
 ZnfVRzAWVhLc/3svzRFHfZ0RYyhcW7Tj7a8MR3RmxGSZSbT8JTBTkTWUqsdxKgoXtoO0mBVqcYc
 tq188z4FdCxRmz4f54YMdwUB+N4IEq/sPxChrkSaznxuLspKlyV+mrAMEHRiG+bD4dRcXYCUNrE
 1k9O3L7VxcpO6Fp57jyH2g3BN+vvIY60CuTkEA41Vs3xKR1aEuVFxww0igIunx2Jx1DVF8Kmi3w
 JF3Kog9LjGSCzTLWVPlhXQ3V7TmjON5UaRICBntdZZ/IXdPC2e/5hdr7rSla4ZD5ArnJbVPC4Uq
 8OWH/ddyAlLOASpi+p/q61WxLEvNC3BAxVHZo7jlVGeomMQRNDLDm7nN65lNtZlziUpHLiGeGkO
 mGosQd+0a6dhH8RGFAYHt76xXdwBF6dxeGEkYO1Va7QCoPDXCw/wsJ1HQCV6Cfm4UsTkso74WZX
 RywF8W91PYlo7tOP1hxLu+nPUohDPg6uExjF+ZVQwhHDtsgYYa4rlpVMS8EsDZhEQSJlGsncQYL
 UUtldok75BGntxOiGGBWvEeVOv4dxYhan97m8UoCQ7m/95r5OKu3IN9hatrYKdpqhRMQtyuD0T+
 dPwELSYcdIQpLDA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Marc-André Lureau (45):
      hw/pci: handle missing bus in prop_pci_busnr_get
      chardev/char-socket: handle NULL addr in char_socket_get_addr
      hw/pci-bridge: handle missing parent in prop_pxb_uid_get
      hw/pci-host/i440fx: handle NULL bus in pci-hole64 getters
      hw/pci-host/q35: handle NULL bus in pci-hole64 getters
      hw/remote: check visit return in vfu_object_set_socket
      hw/ipmi: reject NULL 'bmc' property rather than crash
      hw/xlnx_dp: reject NULL 'dpdma' property rather than crash
      qom/object: update doc about NULL values in link properties
      hw/intc/apic: move checks to realize()
      hw/remote: guard listener unregister in finalize
      backends/cryptodev-lkcf: skip cleanup when not initialized
      io/net-listener: move mutex init to instance_init
      net/colo-compare: guard finalize against uninitialized state
      system/ioport: minor code simplification
      ui/console: remove console from global list on finalization
      hw/i386/x86: free oem_id and oem_table_id on finalization
      hw/core/machine: free shim_filename on finalization
      hw/core/resetcontainer: free children array on finalization
      net/filter: free old values in property setters
      ui/console-vc: destroy fifo on text console finalization
      target/i386/sev: add finalize functions and fix leaking setters
      target/i386/kvm/tdx: free strings in tdx_guest_finalize
      hw/i386/nitro_enclave: add instance finalize
      net/can: free ifname on socketcan finalization
      backends/igvm-cfg: free filename on finalization
      scsi/pr-manager-helper: free path on finalization
      accel/kvm: free device path on finalization
      system/qtest: add missing qtest_finalize()
      hw/i386/pc: free pcspk on finalization
      hw/tpm: free PPI buffer on finalization
      hw/fsi: move OPBus address space init to realize
      hw/fsi: move OPBus qbus_init() to instance_init
      hw/gpio/pca9552: fix state_str leak in pca955x_set_led
      hw/arm/aspeed: free fmc_model and spi_model on finalization
      hw/arm/sbsa-ref: free unrealized flash devices on finalization
      hw/arm/virt: free flash devices and OEM strings on finalization
      hw/loongarch/virt: free flash devices and OEM strings on finalization
      hw/ppc/spapr: free host_model and host_serial on finalization
      hw/ppc/pnv: drop extra ref on PHB after adding as child
      target/riscv: fix general_user_opts hash table leak
      target/riscv: use hash table as set for user_options
      hw/riscv/virt: free flash devices and OEM strings on finalization
      hw/i2c/pmbus: fix undefined behavior in pmbus_direct_mode2data
      qtest: add "qom-tests" command

Peter Xu (1):
      system/ioport: Fix qom-list-properties crash on portio list obj

 include/qom/object.h                |  8 +++---
 target/riscv/cpu.h                  |  3 +-
 tests/qtest/libqtest.h              |  8 ++++++
 accel/kvm/kvm-all.c                 |  8 ++++++
 backends/cryptodev-lkcf.c           |  4 +++
 backends/igvm-cfg.c                 |  1 +
 chardev/char-socket.c               |  4 +++
 hw/arm/aspeed.c                     |  9 ++++++
 hw/arm/sbsa-ref.c                   | 12 ++++++++
 hw/arm/virt.c                       | 14 ++++++++++
 hw/core/machine.c                   |  1 +
 hw/core/resetcontainer.c            |  3 ++
 hw/display/xlnx_dp.c                |  6 ++++
 hw/fsi/aspeed_apb2opb.c             | 37 +++++++++++++++---------
 hw/gpio/pca9552.c                   |  2 +-
 hw/i2c/pmbus_device.c               |  4 +--
 hw/i386/nitro_enclave.c             | 11 ++++++++
 hw/i386/pc.c                        | 10 +++++++
 hw/i386/x86.c                       |  9 ++++++
 hw/intc/apic_common.c               | 23 ++++++++-------
 hw/ipmi/ipmi.c                      |  9 +++++-
 hw/loongarch/virt.c                 | 14 ++++++++++
 hw/pci-bridge/pci_expander_bridge.c |  8 +++++-
 hw/pci-host/i440fx.c                | 15 ++++++++--
 hw/pci-host/q35.c                   | 15 ++++++++--
 hw/pci/pci.c                        | 11 ++++++--
 hw/ppc/pnv.c                        |  1 +
 hw/ppc/spapr.c                      |  2 ++
 hw/remote/remote-obj.c              |  4 ++-
 hw/remote/vfio-user-obj.c           |  4 ++-
 hw/riscv/virt.c                     | 14 ++++++++++
 hw/tpm/tpm_tis_sysbus.c             |  9 ++++++
 io/net-listener.c                   |  9 +++++-
 net/can/can_socketcan.c             |  8 ++++++
 net/colo-compare.c                  | 31 ++++++++++----------
 net/filter.c                        |  2 ++
 scsi/pr-manager-helper.c            |  1 +
 system/ioport.c                     | 14 +++++++---
 system/qtest.c                      | 56 +++++++++++++++++++++++++++++++++++++
 target/i386/cpu-apic.c              |  6 +---
 target/i386/kvm/tdx.c               |  5 ++++
 target/i386/sev.c                   | 37 ++++++++++++++++++++++++
 target/riscv/cpu.c                  | 51 ++++++++++++++++++---------------
 target/riscv/kvm/kvm-cpu.c          |  6 ++--
 tests/qtest/libqtest.c              |  6 ++++
 tests/qtest/qom-test.c              | 12 ++++++++
 ui/console-vc.c                     |  1 +
 ui/console.c                        |  5 +++-
 48 files changed, 440 insertions(+), 93 deletions(-)
---
base-commit: ac0cc20ad2fe0b8df2e5d9458e90a095ac711ab1
change-id: 20260427-qom-tests-9dcf3b969411

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


