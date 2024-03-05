Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5D7C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 15:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhXAs-0005TF-6G; Tue, 05 Mar 2024 10:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rhXAl-0005Pf-1M
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:57:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rhXAi-0000Rz-VF
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709654259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HJF5Senj6Onn7fvPNEIxgiyack88To0MhvSnWL+GUxk=;
 b=NlSETNMS2JqTHot8BEI4KO5LsQht/dDuYzMSdY9rrMQmIKbfFIliPJk/1A7v1hhMITPLBl
 Q4L3IixCtHRT8ujdzexq+xMYSKi8la3kSQmCTODoVBG8hCouAL1L/oD5Qd5TgG3VbXQbO8
 wTrqTcFU/4yX38x1F6fOzjwbLr7aKPo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-eKlafKU9N268RW43G7SUEA-1; Tue,
 05 Mar 2024 10:57:33 -0500
X-MC-Unique: eKlafKU9N268RW43G7SUEA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D6C21C01E95;
 Tue,  5 Mar 2024 15:57:31 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 491D317A99;
 Tue,  5 Mar 2024 15:57:26 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com,
 gaosong@loongson.cn, alistair.francis@wdc.com, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, imammedo@redhat.com, anisinha@redhat.com,
 philmd@linaro.org, wangyanan55@huawei.com, eblake@redhat.com,
 armbru@redhat.com, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 f.ebner@proxmox.com
Subject: [PATCH v2 00/20] Workaround Windows failing to find 64bit SMBIOS
 entry point with SeaBIOS
Date: Tue,  5 Mar 2024 16:57:04 +0100
Message-Id: <20240305155724.2047069-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
CC: peter.maydell@linaro.org                                                     
CC: pbonzini@redhat.com                                                          
CC: mst@redhat.com                                                               
CC: gaosong@loongson.cn                                                          
CC: alistair.francis@wdc.com                                                     
CC: palmer@dabbelt.com                                                           
CC: bin.meng@windriver.com                                                       
CC: liwei1518@gmail.com                                                          
CC: dbarboza@ventanamicro.com                                                    
CC: zhiwei_liu@linux.alibaba.com                                                 
CC: imammedo@redhat.com                                                          
CC: anisinha@redhat.com                                                          
CC: philmd@linaro.org                                                            
CC: wangyanan55@huawei.com                                                       
CC: eblake@redhat.com                                                            
CC: armbru@redhat.com                                                            
CC: qemu-arm@nongnu.org                                                          
CC: qemu-riscv@nongnu.org                                                        
CC: f.ebner@proxmox.com                                                          

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
  smbios: extend smbios-entry-point-type with 'auto' value
  smbios: in case of entry point is 'auto' try to build v2 tables 1st
  smbios: error out when building type 4 table is not possible
  smbios: clear smbios_type4_count before building tables
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
 hw/smbios/smbios_legacy_stub.c       |  16 +
 qapi/machine.json                    |   5 +-
 tests/data/acpi/q35/SSDT.dimmpxm     | Bin 1815 -> 1815 bytes
 tests/data/smbios/type11_blob        | Bin 0 -> 11 bytes
 tests/data/smbios/type11_blob.legacy | Bin 0 -> 10 bytes
 tests/qtest/bios-tables-test.c       |  81 ++++-
 20 files changed, 534 insertions(+), 316 deletions(-)
 create mode 100644 hw/smbios/smbios_legacy.c
 create mode 100644 hw/smbios/smbios_legacy_stub.c
 create mode 100644 tests/data/smbios/type11_blob
 create mode 100644 tests/data/smbios/type11_blob.legacy

-- 
2.39.3


