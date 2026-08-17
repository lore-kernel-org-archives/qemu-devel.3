Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292BBC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvutV-0007WR-BN; Mon, 17 Aug 2026 06:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvutQ-0006jx-FE; Mon, 17 Aug 2026 06:48:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvutO-0004Qu-Ou; Mon, 17 Aug 2026 06:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786963487; bh=gw5UnqPna+YOEY0GgTk+3Fgv1fAWX7NyXwvM/Slqhlw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Z2FCDIFd688tB4L1Tcu5nUs0YlmURRwmPW50Jz4ETqEiQBDU3pxbx0QXeHuVIx/9Y
 V9vk+nWqAf4FYMqVriu6247cuWTxSSatO4NV3O53atHrOOJ95Zlz2cOM4MYJpua0Xr
 SneJA4ozSVeCGq4j4uEagRp/NxuvDBPt7VPwOT4kF55ru/BiL1qI3g5WKz0b/qHMqy
 YyteEUoXsteovD0NhHFEPAlBvmsZCgqwSJvCSiSQstXJWoq2YiCYBTra6mkz7nVx40
 DPTnwnCQwRv3n/v3VWGTrZtY69qIc1AXemTILI3wJZ8LpDeLoZNTbqbL1kTXwY4gWJ
 0tZRc2rx9gW0A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0EF2C1CBB8E;
 Mon, 17 Aug 2026 13:44:47 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0FA8040D222;
 Mon, 17 Aug 2026 13:45:08 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6AF7D30E94; Mon, 17 Aug 2026 13:44:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v2 161/161] hw/elf_ops: defend against weird elf
 headers
Date: Mon, 17 Aug 2026 13:43:15 +0300
Message-ID: <20260817104344.2047346-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Alex Bennée <alex.bennee@linaro.org>

According to the ELF spec:

  PT_LOAD

  The array element specifies a loadable segment, described by
  p_filesz and p_memsz. The bytes from the file are mapped to the
  beginning of the memory segment. If the segment's memory
  size (p_memsz) is larger than the file size (p_filesz), the
  ``extra'' bytes are defined to hold the value 0 and to follow the
  segment's initialized area. The file size may not be larger than the
  memory size. Loadable segment entries in the program header table
  appear in ascending order, sorted on the p_vaddr member.

which implies while both p_filesz and p_memsz can be zero we should
never see a case where p_filesz is greater than the in memory size.
Indeed it has been reported such a hand crafted ELF can blow up, for
example during rom_reset():

  address_space_set(rom->as, rom->addr + rom->datasize, 0,
                    rom->romsize - rom->datasize,
                    MEMTXATTRS_UNSPECIFIED);

which could trigger and underflow leaving QEMU slowly filling a very
large buffer.

Cc: qemu-stable@nongnu.org
Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4056
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260812081405.3811787-1-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 260d49d8e28378b1f4f6c255c15cc20617726920)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/hw/elf_ops.h.inc b/include/hw/elf_ops.h.inc
index 9c35d1b9da6..044e72de2a2 100644
--- a/include/hw/elf_ops.h.inc
+++ b/include/hw/elf_ops.h.inc
@@ -427,6 +427,11 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
             file_size = ph->p_filesz; /* Size of the allocated data */
             data_offset = ph->p_offset; /* Offset where the data is located */
 
+            if (file_size > mem_size) {
+                ret = ELF_LOAD_TOO_BIG;
+                goto fail;
+            }
+
             if (file_size > 0) {
                 if (g_mapped_file_get_length(mapped_file) <
                     file_size + data_offset) {
-- 
2.47.3


