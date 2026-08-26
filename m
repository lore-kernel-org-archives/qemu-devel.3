Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29842C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBfV-0004xb-0c; Wed, 26 Aug 2026 07:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfR-0004kb-PF
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:41 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfP-0005nw-JB
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:41 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso1327422a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787743178; x=1788347978; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=npJXYp5DKT7QgT0yXi+L+fK29HlTjiLNKlL3gTl+WQs=;
 b=LsInc8tGkUL5gMXzlvwBU9r6IF7xMtu4UMakpICITig3sfOKXaf//5P5zMaM+NGyEm
 eGe2wVSv7FqlVncVUltKzuLmKLThTgKdAwxQR2hjsNL+DddklKq6IxFQR/Xbh9buXCA3
 yVJm6CEZFu/9FKZaa98XMo/blnGhTTJe7+GcQvzKkElQn2XkHR++eR9CaB3LLmrW+Ed4
 vUSXYjGHGFs3mJqPNw//U28+mJ7KXq4zvq27PZnDxP5+2yreY3UK7BUrAe4VJcGdDHow
 xna5PPQty3fZLHWFpEy7Z8Y0a18pWpYJWx+4qc8FTH6kWa9ykRaWB/T7XDfwuqpK489c
 A0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743178; x=1788347978;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=npJXYp5DKT7QgT0yXi+L+fK29HlTjiLNKlL3gTl+WQs=;
 b=tQbstIF8RHguv6C321xEzaMg/xh0dEeeftJult9wV5F7Gmzx/MxaFSCietenl3+Bd6
 divNQw4EN4iAoa5JW1meneqtRN8ICxnCKqubsADLiB7dPRBNiVHMPtLzXmUD7Bkp+4MK
 TXjcz7VaHZeWDjzxgGKAXuXLvxy/bNlOEL2ZoMSwmVz04LmwFqQhrlV5RStY8l6A/O8U
 KldaNUFzEucemoOlQJ5ub5ywhrCDPTjA3Hr0XTuiJeq4B56rCCtZKidT3SCn5D8o6swZ
 /D2HUuHq/uNYDysmbr3BO0LqTCFqBB+IZ70L2qPWu4EQqIddF2fZLltAjd79Omz9YYTe
 1gYA==
X-Gm-Message-State: AFuF++lB9r32AjQ7r3BDsYOYCgvdGYjdVgf5An1C/wwr+cp0rFExfUuJ
 u5TnSS20wtUu71tU8oEzCczJOObjI3aB8KobJ6UW575KkUdkYkyDnjZ9azaIfBb7iEs/3gAKgvM
 UDxhx
X-Gm-Gg: AR+sD12naeimut7vz0KHF3lJh237WoW9BeHGzq4/UzXcCyxwjlhSv0o3aSc4OPFkj3I
 zhueUA4F25YZBFFdtXeN/qPvIp1tWAFVjQ7fvVYnedvp8ZLsSvvtDLr7zDofuFqLKqxWcWH9H3w
 MAqwD4oxIjt5oysCfoaSU2NzufwUuil5KhO7GwGT/w1kyZDxritggh0kZgM248+CJ4ycx4HA+8r
 aR71bU9SpkNWv9CJBUiq1oGobap5CjTlZvMGKt8h29yEwD5o8dVQidp18N4rteAPpxgDE/9vPI5
 V7zs4QB57dyAhdzBv1ju6poI27QlPCjisOhUYkV6QmNsmr1GeM8ad7mfhoY1HAKhhyUnMDkSpAc
 LXo/SMlG8Qoqa2bBkCreEFZWecrWp1o2im/ioy7o8OvwjyNl7AtR67zZGAsBxrsXwR4bb0s5Ljv
 JM8ab8QZw3qPcTrpBfi+rI+m1GZzYSqEklnay8u7mCeCVWSil2
X-Received: by 2002:a05:6402:1cc4:b0:6a1:8d1a:816b with SMTP id
 4fb4d7f45d1cf-6a5df62b841mr8357723a12.11.1787743178035; 
 Wed, 26 Aug 2026 04:19:38 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm4838366a12.21.2026.08.26.04.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:19:37 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 24/28] hw/ide/ahci: reject a command header with an invalid FIS
 length
Date: Wed, 26 Aug 2026 13:19:11 +0200
Message-ID: <20260826111915.3387926-15-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111915.3387926-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
 <20260826111915.3387926-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=den@openvz.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Denis V. Lunev <den@openvz.org>

AHCI 1.3.1 defines CFL in the command header as the "Length of the
Command FIS", where "A length of '0' or '1' is illegal" and "The
maximum value allowed is 10h, or 16 DW". handle_cmd() never looks at
it, so an all-zero command header is executable: its zero tbl_addr maps
a command table at guest physical address 0, and a guest that has put a
valid Register H2D FIS there gets it run.

That is the reachability a guest gains by pointing PxCLB at an MMIO
region, where the CLB is a zero-filled bounce buffer rather than
anything the guest wrote.

Reject a header whose CFL falls outside the legal range. Nothing else
consults it; the command FIS is always mapped at its full 128 bytes.

The slot is dropped without reporting anything, as the unmappable
command table beside it already is. No PxIS bit describes a malformed
command header: HBFS is for a host bus error, "such as a bad software
pointer", which is why the short mapping below raises it and this does
not.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4043
Cc: John Snow <jsnow@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/ahci.c       | 9 +++++++++
 hw/ide/trace-events | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 436a0eaab6..2b2ef873e0 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1334,6 +1334,7 @@ static void handle_cmd(AHCIState *s, int port, uint8_t slot)
     AHCICmdHdr *cmd;
     uint8_t *cmd_fis;
     dma_addr_t cmd_len;
+    uint8_t cfl;
 
     if (s->dev[port].port.ifs[0].status & (BUSY_STAT|DRQ_STAT)) {
         /* Engine currently busy, try again later */
@@ -1346,6 +1347,14 @@ static void handle_cmd(AHCIState *s, int port, uint8_t slot)
         return;
     }
     cmd = get_cmd_header(s, port, slot);
+
+    /* AHCI 1.3.1: a CFL below 2 dwords or above 16 is illegal */
+    cfl = le16_to_cpu(cmd->opts) & AHCI_CMD_HDR_CMD_FIS_LEN;
+    if (cfl < 2 || cfl > 16) {
+        trace_handle_cmd_badcfl(s, port, le16_to_cpu(cmd->opts));
+        return;
+    }
+
     /* remember current slot handle for later */
     s->dev[port].cur_cmd = cmd;
 
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index f1472f5852..3ab5e7bd1d 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -106,6 +106,7 @@ handle_reg_h2d_fis_res(void *s, int port, char b0, char b1, char b2) "ahci(%p)[%
 handle_cmd_busy(void *s, int port) "ahci(%p)[%d]: engine busy"
 handle_cmd_nolist(void *s, int port) "ahci(%p)[%d]: handle_cmd called without s->dev[port].lst"
 handle_cmd_badport(void *s, int port) "ahci(%p)[%d]: guest accessed unused port"
+handle_cmd_badcfl(void *s, int port, uint16_t opts) "ahci(%p)[%d]: guest provided an invalid cmd FIS length: 0x%04x"
 handle_cmd_badfis(void *s, int port) "ahci(%p)[%d]: guest provided an invalid cmd FIS"
 handle_cmd_badmap(void *s, int port, uint64_t len) "ahci(%p)[%d]: dma_memory_map failed, 0x%02"PRIx64" != 0x80"
 handle_cmd_unhandled_fis(void *s, int port, uint8_t b0, uint8_t b1, uint8_t b2) "ahci(%p)[%d]: unhandled FIS type. cmd_fis: 0x%02x-%02x-%02x"
-- 
2.53.0


