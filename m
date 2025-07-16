Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E66C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 22:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucAW4-00087v-TO; Wed, 16 Jul 2025 18:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1ucA8O-00084v-ST; Wed, 16 Jul 2025 17:57:53 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1ucA8M-0002ET-5E; Wed, 16 Jul 2025 17:57:52 -0400
DKIM-Signature: a=rsa-sha256; bh=Zf4dPYfRzBQpH7+u8KHYEm6a6uMIHYYozbV511IKdSk=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1752703065; v=1;
 b=XhX36YzGbMRiwBEqNxcB3NFQYDRBv4nKoRoVQzdElzAE4Mc998shCmEoxiKNYTxmvHbdsAwv
 Zp5uSn62rM+Zf/M2Ajp1tcKVWrIMY9GfUGQrixcy57utFhuhe0yLgxIYo7mRJpS8nChS4xOlaG3
 WyPNVn7JBPNvq2+SClT80P1ugGZii6aqGe55C203GfRzU6U/rVbYobfy9fDBDFGjlNYKnReLCkC
 iZKzM1ReiuLgMYBRjHR4t6PiOUWTA02+ssdMBXHVvFNJr9AzapJgA9Ksv+2J0ZnUKHl/K0CpKbl
 mfFrMStNcTC0rpZmMqM4qSa6GQUt0HQI75ZwIPdZevLOA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 51CA822663;
 Wed, 16 Jul 2025 21:57:45 +0000 (UTC)
From: ~wojtekka <wojtekka@git.sr.ht>
Date: Wed, 16 Jul 2025 21:24:54 +0200
Subject: [PATCH qemu 1/2] Don't reverse bFLT endianess when not needed
Message-ID: <175270306503.19369.144677794735042916-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <175270306503.19369.144677794735042916-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 16 Jul 2025 18:20:18 -0400
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
Reply-To: ~wojtekka <wojtekka@toxygen.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Wojtek Kaniewski <wojtekka@toxygen.net>

bFLT format is big-endian. get_user_ual() returns host value so for
little-endian target and little-endian host it's necessary to reverse
words using ntohl(). For big-endian targets we end up with incorrect
endianess:

    $ qemu-m68k-static ./test
    BINFMT_FLAT: reloc outside program 0x801f0000 (0 - 0x41f0/0x1e40)
    Aborted (core dumped)

For comparison the output of `flthdr` follows:

    $ m68k-elf-flthdr -P ./test
    ./test
        Magic:        bFLT
        Rev:          4
        Build Date:   Tue Jul 15 23:02:00 2025
        Entry:        0x44
        Data Start:   0x1e80
        Data End:     0x205c
        BSS End:      0x40a0
        Stack Size:   0x1000
        Reloc Start:  0x205c
        Reloc Count:  0x17
        Flags:        0x2 ( Has-PIC-GOT )
        Relocs:
        #	reloc      (  address )	data
        0	0x00001f80 (0x00001f80)	3c200000
                  ^^^^^^^^
        1	0x00001f84 (0x00001f84)	3c300000
        2	0x00001f88 (0x00001f88)	3c200000
        ...

Signed-off-by: Wojtek Kaniewski <wojtekka@toxygen.net>
---
 linux-user/flatload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 4beb3ed1b9..afaff4ac44 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -413,7 +413,9 @@ static int load_flat_file(struct linux_binprm * bprm,
                relocated first).  */
             if (get_user_ual(relval, reloc + i * sizeof(abi_ulong)))
                 return -EFAULT;
+#if !TARGET_BIG_ENDIAN
             relval = ntohl(relval);
+#endif
             if (flat_set_persistent(relval, &persistent))
                 continue;
             addr = flat_get_relocate_addr(relval);
-- 
2.45.3


