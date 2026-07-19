Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD9FC4450A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 15:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlTMc-0001kh-Vp; Sun, 19 Jul 2026 11:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlTMW-0001iV-Sh
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 11:23:30 -0400
Received: from mail-08.mail-europe.com ([57.129.93.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlTMT-0006hk-Ac
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 11:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pq.io;
 s=protonmail3; t=1784474600; x=1784733800;
 bh=8BU+EgkrPlDb3UN4VioQMzVj1gSd/x7YOWHQmu4oGVI=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=SvmG0q3WL9JWDbsaSst596dogVCkNDFcFCDLlaw2xyyrh4QfeTkYVgWS/F6p8G1JQ
 SCP82Yd1gt5hpbrZdhgB/YL6NIVs7/FBiHz9xlmp+5dLpYYDMV8o/kWDtwpuGvRtnz
 mA3V/SJ0hRxKuqWQV4WwG5fiy615DFnQ8xMDG6OeYBHtCeeULeSOVBGzHpL7ziTdGY
 /dJa0BXh4dsZB2QkSacEMi49MN1xgmqbK7zQ92GgQbq6OWBLFt4w1GDAMPc4JoxcWw
 wxE3RNes5UBYzqQRj7dN23diqOejK1OWCjzKoJcn23e5dYX9/NU2FtebtQDphp1RiY
 GXqTVTD593HZQ==
X-Pm-Submission-Id: 4h36qC6n3kz1DFF1
From: Matthew Jackson <matthew@pq.io>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: [PATCH 0/4] hw/display/vmware_vga: raise resolution ceiling,
 advertise modern capability bits
Date: Sun, 19 Jul 2026 08:23:14 -0700
Message-ID: <20260719152318.69481-1-matthew@pq.io>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=57.129.93.249; envelope-from=matthew@pq.io;
 helo=mail-08.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The QEMU `vmware_vga` device reports `SVGA_CAP_NONE` when the
guest reads `SVGA_REG_CAPABILITIES`, and caps mode validation
at 2368x1770. This was historically safe because the device
implements almost none of the modern VMware SVGA II feature
set, but the machinery for five capability bits is in fact
already present - the device just never told the guest about
them.

This four-patch series fixes that. Each patch touches a
single feature and is independently revertible.

| Patch | Subject |
|-------|---------|
| 1/4   | `hw/display/vmware_vga: raise resolution ceiling to 5K (5120x2880)` |
| 2/4   | `hw/display/vmware_vga: advertise PITCHLOCK capability` |
| 3/4   | `hw/display/vmware_vga: advertise EXTENDED_FIFO capability` |
| 4/4   | `hw/display/vmware_vga: advertise 8BIT_EMULATION, ALPHA_BLEND and ALPHA_CURSOR` |

## Motivation

Modern VMware SVGA II guest drivers (Linux vmwgfx, macOS
10.13+, Windows 10+) refuse to take optional fast paths when
the corresponding capability bits are not advertised. The
effect on macOS 15 guests in particular is:

  * Cursor is monochrome and flickers (ALPHA_CURSOR missing).
  * Scanout pitch does not align to guest framebuffer on
    non-power-of-two widths (PITCHLOCK missing).

Matthew Jackson (4):
  hw/display/vmware_vga: raise resolution ceiling to 5K
  hw/display/vmware_vga: add PITCHLOCK capability
  hw/display/vmware_vga: add EXTENDED_FIFO capability
  hw/display/vmware_vga: add alpha-blend + alpha-cursor capability bits

