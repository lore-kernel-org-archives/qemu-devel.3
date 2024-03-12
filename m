Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB239C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4io-00069o-Gy; Tue, 12 Mar 2024 12:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rk4iV-0005xY-Kp
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rk4iT-0007AU-UY
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710259859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q9hOSzAiStwBGz6weGgfzxM5rsglZsjdll5FGzQGjNI=;
 b=Zm5lcC3vIbvNYL3WEAwIVk6clkutIOs8Qt40TPPJ/InrDDC87FN3oScNXbuQwVSbrwYbUq
 bG2nDHZ11z01JRMwgqdJkT1G5Y9CRzYXM5OGWBMEGBuiHGdIrVfo83FUA92Dpu5sU0gZxI
 w3eaUT4cKW8RHE0MOnTPI9od70W5dLU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-5RSPBIALPfuhH7MHKP6a0A-1; Tue,
 12 Mar 2024 12:10:58 -0400
X-MC-Unique: 5RSPBIALPfuhH7MHKP6a0A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08D2D29AC017
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 16:10:53 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FE8A3C21;
 Tue, 12 Mar 2024 16:10:52 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com,
	mst@redhat.com
Subject: [PATCH v3 00/20] Workaround Windows failing to find 64bit SMBIOS
 entry point with SeaBIOS
Date: Tue, 12 Mar 2024 17:10:30 +0100
Message-Id: <20240312161050.2248814-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Changelog:
 v3:
   * whitespace missed by checkpatch
   * fix idndent in QAPI
   * reorder 17/20 before 1st 'auto' can be used
   * pick up acks
 v2:
   * QAPI style fixes (Markus Armbruster <armbru@redhat.com>)
   * squash 11/19 into 10/19 (Ani Sinha <anisinha@redhat.com>)
   * split '[PATCH 09/19] smbios: build legacy mode code only for 'pc' machine'
     in 3 smaller patches, to make it more readable
       smbios: add smbios_add_usr_blob_size() helper                                  
       smbios: rename/expose structures/bitmaps used by both legacy and modern code                                                                  
       smbios: build legacy mode code only for 'pc' machine
   * pick up acks

Windows (10) bootloader when running on top of SeaBIOS, fails to find            
SMBIOSv3 entry point. Tracing it shows that it looks for v2 anchor markers       
only and not v3. Tricking it into believing that entry point is found            
lets Windows successfully locate and parse SMBIOSv3 tables. Whether it           
will be fixed on Windows side is not clear so here goes a workaround.            
                                                                                 
Idea is to try build v2 tables if QEMU configuration permits,                    
and fallback to v3 tables otherwise. That will mask Windows issue                
form majority of users.                                                          
However if VM configuration can't be described (typically large VMs)             
by v2 tables, QEMU will use SMBIOSv3 and Windows will hit the issue              
again. In this case complain to Microsoft and/or use UEFI instead of             
SeaBIOS (requires reinstall).                                                    
                                                                                 
Default compat setting of smbios-entry-point-type after series                   
for pc/q35 machines:                                                             
  * 9.0-newer: 'auto'                                                            
  * 8.1-8.2: '64'                                                                
  * 8.0-older: '32'                                                              
                                                                                 
Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2008                        
CC: imammedo@redhat.com                                                          
CC: mst@redhat.com

Igor Mammedov (20):
  tests: smbios: make it possible to write SMBIOS only test
  tests: smbios: add test for -smbios type=11 option
  tests: smbios: add test for legacy mode CLI options
  smbios: cleanup smbios_get_tables() from legacy handling
  smbios: get rid of smbios_smp_sockets global
  smbios: get rid of smbios_legacy global
  smbios: avoid mangling user provided tables
  smbios: don't check type4 structures in legacy mode
  smbios: add smbios_add_usr_blob_size() helper
  smbios: rename/expose structures/bitmaps used by both legacy and
    modern code
  smbios: build legacy mode code only for 'pc' machine
  smbios: handle errors consistently
  smbios: get rid of global smbios_ep_type
  smbios: clear smbios_type4_count before building tables
  smbios: extend smbios-entry-point-type with 'auto' value
  smbios: in case of entry point is 'auto' try to build v2 tables 1st
  smbios: error out when building type 4 table is not possible
  tests: acpi/smbios: whitelist expected blobs
  pc/q35: set SMBIOS entry point type to 'auto' by default
  tests: acpi: update expected SSDT.dimmpxm blob

 hw/i386/fw_cfg.h                     |   3 +-
 include/hw/firmware/smbios.h         |  28 +-
 hw/arm/virt.c                        |   6 +-
 hw/i386/Kconfig                      |   1 +
 hw/i386/fw_cfg.c                     |  14 +-
 hw/i386/pc.c                         |   4 +-
 hw/i386/pc_piix.c                    |   4 +
 hw/i386/pc_q35.c                     |   3 +
 hw/loongarch/virt.c                  |   7 +-
 hw/riscv/virt.c                      |   6 +-
 hw/smbios/Kconfig                    |   2 +
 hw/smbios/meson.build                |   4 +
 hw/smbios/smbios.c                   | 481 +++++++++++----------------
 hw/smbios/smbios_legacy.c            | 185 +++++++++++
 hw/smbios/smbios_legacy_stub.c       |  15 +
 qapi/machine.json                    |   5 +-
 tests/data/acpi/q35/SSDT.dimmpxm     | Bin 1815 -> 1815 bytes
 tests/data/smbios/type11_blob        | Bin 0 -> 11 bytes
 tests/data/smbios/type11_blob.legacy | Bin 0 -> 10 bytes
 tests/qtest/bios-tables-test.c       |  81 ++++-
 20 files changed, 533 insertions(+), 316 deletions(-)
 create mode 100644 hw/smbios/smbios_legacy.c
 create mode 100644 hw/smbios/smbios_legacy_stub.c
 create mode 100644 tests/data/smbios/type11_blob
 create mode 100644 tests/data/smbios/type11_blob.legacy

-- 
2.39.3


