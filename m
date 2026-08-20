Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42786C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3zW-0000ee-8U; Thu, 20 Aug 2026 10:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zK-0000ab-4R
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:26 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zI-0005Bd-0B
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:25 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so25976905e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787237002; x=1787841802; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=npJXYp5DKT7QgT0yXi+L+fK29HlTjiLNKlL3gTl+WQs=;
 b=HVqOlBFIUyUISioDA++qff4qQcNeQcjOW42SBxRjXrGEQc4UA0t+PwfTsY7m3TSJ1q
 Bn6bLl89jZIkCwb/J0tP/+z7+Tg+IBx4I1eIp97FLtpEXQRGzOWdsJ619e/qbknzx3k4
 X+nU/NCxBr4gxP0D48FZwOv0taPsk/aQ+md5kj47IduT07CtzS2K3jdyTkAhAfVQhOHu
 RiKj9iLsxyHgNyqOmKj8s2965/oWPCmyFQyZ3Jt4LucbsfNN+y9Fd4sxClGsZLGopEMi
 K2Axfu8OKTKxsSal9UbN6JqaAYVTy4SwKKLVNSVg3eIqBO/M7VoZne7QixXRDNJth43A
 M0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787237002; x=1787841802;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=npJXYp5DKT7QgT0yXi+L+fK29HlTjiLNKlL3gTl+WQs=;
 b=sqDU457sKuYfphbvDddo4LusyoUmf4tNKOkBPI//TeIkioBM3OCWiVhFF2YgRsSKtx
 R85G/SZlq3IByZ1NLMp7XEnUJB6m8w6rP4bGaxKT7n80TgrcT4Fa5MEiJvuXWhkkpQEi
 3mFtaOxAsLDIdX7CrwaMgSnPiItEkIgbqYKeEfMGXS2LMu7CKyFMNNnfMEURerAmFAOz
 tigtfxlLURtvsLNPxxVoN/H/sySfulyRPdfNMDnuefZVqNwOZO4rEJcHPOqoCFso9/YH
 5l5W64KMOtpOVfo4X5QD/Kbn9JeCYjCgKKACCXkJ2jLZYvzDBaAJhxTr0Sr36qttlf2D
 ku+w==
X-Gm-Message-State: AOJu0Yy7haWRL/In+peBUjHNNRKne8iSoDyfpdG0MhS92QcK/kyLJ9Ae
 peKlMaoJHylQB/7EdRCFMUiRg4SRxnXKFfliA8G7asBiz1vGbiOKOHlmQEEeKqXJEJKIelO1EQD
 2xPdo
X-Gm-Gg: AR+sD11Fpa00PEXWdg7A2WRGsaRbs6D7K7MMNqZ2lhhJ3pd8safCpCRIWL3eSUM5UuW
 u7VN8mvUqZ682gy9pXC5vb0Rpqq+etqo5XQ1IX8tE8xoSkA/e037dt2Xew5g60h0Ocaxn7XpCo4
 z9EZPRd/EPZJzdmM/1quXY8HUUBq3GLrdWPOJcY0fPrhO52rISfnL9W3Qs7zymiRAJG31LJlExm
 W/SZL6zzq4NFqDUqdIRwDN/zbeJZ1udBuuGNUvRXHWd4L1iysildCzsNH463qM33zaBuKqT0h5T
 2kAtQiLzgCha+a1VF/Ta1jR6Lpd0SnssWbhegK2E8s+x2yufqzTYdZCLi0UHhsLkTJ9H79bkqC9
 7z809w1jPgGWZNhglyCN+NBZ+Kn+kBZlJxXbM7IwLvVOq2Bh7z1dtPKSkHwGehGjyKh9zqYDGtW
 wA71EURRHAEtZ0qJQZus4dLOEDfkFKmvuG1hwoFg6W01fhglIWKwzjiOYPvFcsdv9W614B
X-Received: by 2002:a05:600c:468c:b0:499:48bb:417e with SMTP id
 5b1f17b1804b1-499aa14a72dmr194391465e9.2.1787237001601; 
 Thu, 20 Aug 2026 07:43:21 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd620sm136791565e9.13.2026.08.20.07.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 07:43:21 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 07/11] hw/ide/ahci: reject a command header with an invalid
 FIS length
Date: Thu, 20 Aug 2026 16:43:05 +0200
Message-ID: <20260820144309.835173-8-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820144309.835173-1-den@openvz.org>
References: <20260820144309.835173-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=den@openvz.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


