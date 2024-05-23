Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A086C25B7A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 17:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sACZX-0006tS-0t; Thu, 23 May 2024 13:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sACYk-0005yT-Ki
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:49:03 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sACYT-0003du-NB
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:48:57 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ee954e0aa6so22520895ad.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 10:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716486518; x=1717091318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4r6TCjebwmoal19hsNaIlox9kjy5GL6IczrHH4aqNj4=;
 b=Kk5G+RLz5edwvv2gsaWDHCOz3OVPNhoRcTEKMW4pqAH8QDHSrP0jbNIiTrfaKpvest
 FGCQ1S/+7yLbxGle+uBfle2bJy+yLHJgiO1vnZeK40ssUe4z6iVo+aL47iFqIg1dSh2p
 JYCDw3JYVZ3Bw3snX2oM/rVqj/CeojVFZn4hA46TyFLDwgoOfU+0DqVeYoJbviLDNeuY
 LLPD/w8HK5tW9vHbNWOQ+3bg2LyvW3j6NBi7cQtan07gVXedEZ1+HV8c2NB8xvJkzzjO
 d6xaKz2unk/wBJv1ZxEBOjcvE6OSkYn0HLuF8CPzqOisqYWKal4UDY8wADUQjo6QKFMC
 cPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716486518; x=1717091318;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4r6TCjebwmoal19hsNaIlox9kjy5GL6IczrHH4aqNj4=;
 b=Xr8Zr4tCrlI53nI9YQSQ4bBN/Dlot9LsK+yvvC5wq7wRwCU2Bg+NIHvzIBsPVyS5gh
 U4+QTLalbb737O432xD7F8sa03OeZsoOzCO6K9TtcwtlUome9S8LlT8n1ppIulgKeubA
 aJP+0/jpn+mVa71GInXQZAbplsDSMimdbY3pXM33MUpTgfoBk/RIy2lBr90xBlTxwatQ
 ZuQlGtuaXi9ac/55lg7CHMJj43QzKmmLCQXWXuAAt2xhSQC1EH9KaInM3HiFfcq+r7Im
 UDg35+wDhlqzHEDm/xccOUun1RKCEv/M4rI6wMEnejeTEAwWJpGNNvS867q9VtxIBFd4
 h9+A==
X-Gm-Message-State: AOJu0YxUxAJNDb/vDJgmkBYSzb/+a0X9cuSM7KHOmqiNalpMjt6Vzfgy
 rDDZh7y1Y+cDPa0W3lM+Hno4aKHP7G5ufee/mpHbcYtVbi20YL1NXuyUtA==
X-Google-Smtp-Source: AGHT+IHWVrXQSnx82ntFoZX/SGrXTrSTjtR9HqgzEtaI+q3GNixRc445TQcUUiX1AHlXQqhKfb070g==
X-Received: by 2002:a17:903:244b:b0:1e4:436e:801b with SMTP id
 d9443c01a7336-1f4498f404bmr295475ad.67.1716486517545; 
 Thu, 23 May 2024 10:48:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 10:48:37 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, armbru@redhat.com, mst@redhat.com
Subject: [PATCH v8 00/14] Enabling DCD emulation support in Qemu
Date: Thu, 23 May 2024 10:44:40 -0700
Message-ID: <20240523174651.1089554-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Fan Ni <nifan.cxl@gmail.com>

A git tree of this series can be found here (with one extra commit on top
for printing out accepted/pending extent list for testing): 
https://github.com/moking/qemu/tree/dcd-v8-qapi

v7->v8:

This version carries over the following two patches from Gregory.
1. hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference
https://gitlab.com/jic23/qemu/-/commit/f44ebc5a455ccdd6535879b0c5824e0d76b04da5
2. hw/cxl/mailbox: interface to add CCI commands to an existing CCI
https://gitlab.com/jic23/qemu/-/commit/00a4dd8b388add03c588298f665ee918626296a5

Note, the above two patches are not directly related to DCD emulation.

All the following patches in this series are built on top of mainstream QEMU
and the above two patches.

The most significant changes of v8 is in Patch 11 (Patch 9 in v7). Based on
feedback from Markus and Jonathan, the QMP interfaces for adding and releasing
DC extents have been redesigned and now they look like below,

# add a 128MB extent at offset 0 to region 0
	{ "execute": "cxl-add-dynamic-capacity",
	  "arguments": {
		  "path": "/machine/peripheral/cxl-memdev0",
          "host-id":0,
          "selection-policy": 'prescriptive',
		  "region": 0,
          "tag": "",
		  "extents": [
		  {
			  "offset": 0,
			  "len": 134217728
		  }
		  ]
	  }
	}

Note: tag is optional.

# Release a 128MB extent at offset 0 from region 0
 { "execute": "cxl-release-dynamic-capacity",
	  "arguments": {
		  "path": "/machine/peripheral/cxl-memdev0",
          "host-id":0,
          "removal-policy":"prescriptive",
          "forced-removal": false,
          "sanitize-on-release": false,
          "region": 0,
          "tag": "",
		  "extents": [
		  {
			  "offset": 0,
			  "len": 134217728
		  }
		  ]
	  }
	}
    
Note: removal-policy, sanitize-on-release and tag are optional.
    
Other changes include,
1. Applied tags to patches. 
2. Replaced error_setq with error_append_hint for cxl_create_dc_region error
   case in Patch 6 (Patch 4 in v7); (Zhijian Li)
3. Updated the error message to include region size information in
    cxl_create_dc_region.
4. set range1_size_hi to 0 for DCD in build_dvsec. (Jonathan)
5. Several minor format fixes.

Thanks Markus, Jonathan, Gregory, and Zhijian for reviewing v7 and
svetly Todorov for testing v7.

This series pass the same tests as v7 check the cover letter of v7 for
more details. Additionally, we tested the QAPI interface for
adding/releasing DC extents with optional input parameters.
  

v7: https://lore.kernel.org/linux-cxl/5856b7a4-4082-465f-9f61-b1ec6c35ef0f@fujitsu.com/T/#mec4c85022ce28c80b241aaf2d5431cadaa45f097


Fan Ni (12):
  hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
    payload of identify memory device command
  hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
    and mailbox command support
  include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
    type3 memory devices
  hw/mem/cxl_type3: Add support to create DC regions to type3 memory
    devices
  hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
    size instead of mr as argument
  hw/mem/cxl_type3: Add host backend and address space handling for DC
    regions
  hw/mem/cxl_type3: Add DC extent list representative and get DC extent
    list mailbox support
  hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
    dynamic capacity response
  hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
    extents
  hw/mem/cxl_type3: Add DPA range validation for accesses to DC regions
  hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
  hw/mem/cxl_type3: Allow to release extent superset in QMP interface

Gregory Price (2):
  hw/cxl/mailbox: change CCI cmd set structure to be a member, not a
    reference
  hw/cxl/mailbox: interface to add CCI commands to an existing CCI

 hw/cxl/cxl-mailbox-utils.c  | 658 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 634 ++++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3_stubs.c    |  25 ++
 include/hw/cxl/cxl_device.h |  85 ++++-
 include/hw/cxl/cxl_events.h |  18 +
 qapi/cxl.json               | 143 ++++++++
 6 files changed, 1511 insertions(+), 52 deletions(-)

-- 
2.43.0


