Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCED606A32D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=x6z.top header.i=@x6z.top header.a=rsa-sha256 header.s=lark2301040359 header.b=eSSknXxI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnwc-0000cP-CI; Fri, 30 Oct 2026 10:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMnrx-0006j7-Mz
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:15 -0400
Received: from va-2-45.ptr.blmpb.com ([209.127.231.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMnrv-0005UW-LM
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=lark2301040359; d=x6z.top; t=1793371560; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=IZ8n9kQmZiR7eAzdtT+CnlHFnsWUM5kpiiXNJ9pJKCM=;
 b=eSSknXxIYjsTiPDrbYmFuKXO9VfapyliOVOL1SRxmsvM+nJ0FxHlCy12mOQKo2XWfkmi8H
 3NMgImai7tooI9vffsh8OUgojxNwo+1mUSZv447nVzyYe6pv7dutMju28IYKV3kUeeUNvr
 nOfh6VS0wnXyfeKMpxdMlthjBzEqzw8oiNlJtPY0i4csGzXN/dDRiAKJigDpjevbaiwLpE
 ndMkQzLDkzbnYNQF1XaTBmXK9nMPjNuAd9ZZg7P/+NgBDP4jHSDcWFSTmyK2088vK07hSx
 i14Ptj8Bmqo8BHnTLuMRXjtwr2sxm9auiJemwLWKMjDvMo/H/fe5qkxUtpdhvQ==
To: <qemu-devel@nongnu.org>
Cc: "lbyxiaolizi" <lbyxiaolizi@x6z.top>, "Peter Xu" <peterx@redhat.com>, 
 "Fabiano Rosas" <farosas@suse.de>, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 "Alberto Garcia" <berto@igalia.com>, 
 "Alistair Francis" <Alistair.Francis@wdc.com>, 
 "Gerd Hoffmann" <kraxel@redhat.com>, 
 "Palmer Dabbelt" <palmer@dabbelt.com>, 
 "Paolo Bonzini" <pbonzini@redhat.com>, 
 "Richard Henderson" <richard.henderson@linaro.org>, 
 <qemu-riscv@nongnu.org>
X-Mailer: git-send-email 2.56.0
X-Lms-Return-Path: <lba+26ae4ada7+1824f9+nongnu.org+lbyxiaolizi@x6z.top>
From: "lbyxiaolizi" <lbyxiaolizi@x6z.top>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-From: lbyxiaolizi <lbyxiaolizi@x6z.top>
Subject: [PATCH 0/9] migration: add missing post-load bounds checks across
 devices
Date: Fri, 30 Oct 2026 22:45:38 +0800
Message-Id: <cover.1793370600.git.lbyxiaolizi@x6z.top>
Received: from localhost.localdomain ([120.236.174.193]) by smtp.larksuite.com
 with ESMTPS; Fri, 30 Oct 2026 14:45:59 +0000
Received-SPF: pass client-ip=209.127.231.45; envelope-from=lbyxiaolizi@x6z.top;
 helo=va-2-45.ptr.blmpb.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 FROM_SUSPICIOUS_NTLD_FP=1.999, MSGID_FROM_MTA_HEADER=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Oct 2026 10:50:44 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_SUSPICIOUS_NTLD,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Several VMState descriptions restore array indices, ring heads or FIFO
lengths directly from the migration stream without re-checking the
bounds that runtime register writes enforce. If a migration stream or
snapshot carries an out-of-range value, subsequent device callbacks can
index past the corresponding array or buffer.

This series adds the missing post-load checks for Fifo8, fw_cfg,
hda-codec, Hyper-V VMBus (GPADL and rx_queue), pcie_sriov, sifive_uart,
ipoctal232, and vmmouse.

lbyxiaolizi (9):
  util/fifo8: check head and num bounds in post_load
  hw/nvram/fw_cfg: reset out-of-range cur_entry in post_load
  hw/audio/hda-codec: mask stream and channel IDs in post_load
  hw/hyperv/vmbus: check seen_gfns <= num_gfns in gpadl post_load
  hw/hyperv/vmbus: check rx_queue head and size in post_load
  hw/pci/pcie_sriov: clamp NumVFs to TotalVFs in register_vfs
  hw/char/sifive_uart: check rx_fifo_len in post_load
  hw/char/ipoctal232: check channel FIFO indices in post_load
  hw/i386/vmmouse: check nb_queue bound in post_load

 hw/audio/hda-codec.c  | 10 ++++++++++
 hw/char/ipoctal232.c  | 13 +++++++++++++
 hw/char/sifive_uart.c | 12 ++++++++++++
 hw/hyperv/vmbus.c     | 23 +++++++++++++++++++++++
 hw/i386/vmmouse.c     |  4 ++++
 hw/nvram/fw_cfg.c     | 18 ++++++++++++++++++
 hw/pci/pcie_sriov.c   |  7 +++++++
 util/fifo8.c          | 15 +++++++++++++++
 8 files changed, 102 insertions(+)


base-commit: 61436f5ff1c4e5ee8f60fa1a37962a60f73ea7a4

