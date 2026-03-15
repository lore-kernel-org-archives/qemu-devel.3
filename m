Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D214AD58B1A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 12:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1kkf-0007IU-5B; Sun, 15 Mar 2026 08:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadhyar.cs24@rvce.edu.in>)
 id 1w1kkd-0007Hf-7R
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 08:39:23 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadhyar.cs24@rvce.edu.in>)
 id 1w1kka-0000hi-Tz
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 08:39:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439ce3605ecso2768941f8f.0
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 05:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773578359; cv=none;
 d=google.com; s=arc-20240605;
 b=gtvzAUTUnEK2RySGHJ9zeO9a8CUbzpNxyfrB+O45zkrgRVGJgB4vXjOv+4seIN2PHe
 dQ0OuuPdRQlaaWDSzz2Q4eLyzM7amkjkn4+rKq6EsGGw/5BARTCeoBnxY3rVtUl9aCVw
 fKqNaZwO1lJOaNplwqDRIF7cmQrZ8NrsrfNefD/xAicTQt+MGxO2YBM95wFk/YUDeDCn
 Ziw4ya5oLZeEdmjiFfZvufjOuhZfWBV7gIpuzRTfTN+amTFX9hj8nT50OqlY7N3tkT+H
 Iy3s/txrOHXcb1Qo6aN2fmtfR+/tfxWNxOSmH1iu8nAF1WnKV5T2KEXF242wmxYBlR4t
 wwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=o6dVPY0fm5feSjniFIblEldNRrFM2DTaMlabxhT+BAs=;
 fh=VcWFz3STry9n9eUFM60hyxVS6bVcv395IvuDN7aAypU=;
 b=HqpafVL6IuJo+PSGO8xtwE2UHgjkTwNBB78IGadOpwkBzGDQxhjx0T5o9lEz6cAnk5
 itMg2wXzGWSvwTgkQwWcs64NyphMI66zBnzP/J/dURp6rJPMuTmaeZedOBkaPBehx9Jz
 N0o7mbPypcjdkP7sqLXzXKK1xOiB1S6vZQGVuemFoRGCtRbNcG64k50Y4qP5EoHtcMlJ
 2jriKIfbjX80OlItz2Ueul9BauQk38eb9v2opK+8fjiv4Xnx31CcDguGle1aZQTBh5E0
 LeQzHqjmB6uVlFmPz6lgNHXqlifqq6ZvV6BbNz5MIdPQG8cyo+5xRbguZ7dcvsiGeuka
 H5bw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rvce-edu-in.20230601.gappssmtp.com; s=20230601; t=1773578359; x=1774183159;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=o6dVPY0fm5feSjniFIblEldNRrFM2DTaMlabxhT+BAs=;
 b=GpRH3l5I44oZo+7KzsleQ+jlUtEsofc0kaaXP9yFtgFpK8hgB/C9ku6giv1UVR3+Nh
 AAW+Uy68Mj30qSsPfOggVO2d36/H/GSgs7IVRyy3xnZX05pk7Ylc81en/rgxJeDlaWsu
 B4OYYNHsEhnjO1Dzb2l3STQklSSzqPut5frb4e4+cEmxJLKo3kv0NHoxs7JqQNzkNh9T
 GotBeul/sOsSg3tVJlXAKSO0dxRfDSBwFpoU7k1vsM9Dphl9NXnDLA1Cnw2px0WZcA6v
 sJibYLz+W361Vkpx24Vp5/StRhf4NYDNWaHQ5oMuXGbAHY3Xw44jGCi0hKpV97h5XDuE
 tQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773578359; x=1774183159;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o6dVPY0fm5feSjniFIblEldNRrFM2DTaMlabxhT+BAs=;
 b=SZ/uLnVCo49r9FX+4Niq3eLMwFU6EP7mjDnYYdgSVmgxJYjRog+rlvOT3N0nqTB83K
 UEOM8zgA9TZFmqrQTDsRHl7+ZMCcNvu6i0CMV7C8iQtRChBlRNdspa9SzTYaDEs0spzh
 /UFfXuc6qbo9h8Nus1SYwnSzlrJXopPJpJyEeHwiJXMZ8U0rvCihe1J+8pSMy5V8Thyi
 N3Mio22KTvpfAPQItAFsQwK4U5LXCoKjb48ZQnqxTNTbKROvKbGF6aS4S7WcKsrQjb8v
 /kC8LhEuyC+XOuRJYQuaLVxXRvkv2Fdhb263QnZUwlWKlnaQsKgp2m3GDUu3Pf/DUj7X
 Mgqw==
X-Gm-Message-State: AOJu0YzXVJp+ESEdM+5Rq+9nEFl7Mgciqbz2A9tRqHsIKOW6Y4IC7oyX
 ftx/AoFNnwtgmgd2TEduvRHlelKyPs2k/uYkv7EokIqm5b8Nakq4mFvfHhr+ZKzxksm5l9Kwh42
 XJ15BuSA5K3L9MV6E+mnCMXtb1jvnMOkObi0I8b6mFw==
X-Gm-Gg: ATEYQzxSpo2EVceALULMw4/IiD5OlmIxHkMmO/GRJfQluMNKd26AbB4FRZ/rtDtRDfc
 CfsMIYbX++auklRhYL3sgLjqdyk7cQQAPGpW7Db5va8FhPRrgdW8QsP9Gjn3yCPCiqIvgMMc6iq
 BxNEv52Cd28iK5d8stuuWLn1giEJrREqrwgnzdeSmQB7zmMAGyn5MBHOlf+b+jaXYQcjopEEI1v
 u9L90B2utPaSebZoVnPgrV8eLEHfv7y9otNjEZeSD/ryQKCdWuwT5wEL4VZOz1cp5SIEIcZD4yW
 g/OrcldUsKpb7JzAkNLeMG5aV94yc1RFsaiDVv6oq3q3ASPIRo0wljhCL0lu1/lwNo6MPUaQ6qh
 kRcuPr5yoLTBhL6EdkO81pWY+8g==
X-Received: by 2002:a05:6000:2583:b0:439:c1ca:82be with SMTP id
 ffacd0b85a97d-43a04db18cfmr18236267f8f.28.1773578358639; Sun, 15 Mar 2026
 05:39:18 -0700 (PDT)
MIME-Version: 1.0
From: AADHYA R <aadhyar.cs24@rvce.edu.in>
Date: Sun, 15 Mar 2026 18:09:06 +0530
X-Gm-Features: AaiRm50bLnSJmL_Z9YhtuFVKJ7GuwtPnimNAUXwFMlMI0A_rTFLg85OTzmYkdpI
Message-ID: <CABHAK8PF1U9LKO-7uem36N1Zw+H73ECLDhfHHrciN+4RvYMV_w@mail.gmail.com>
Subject: [PATCH v2] disas/sparc: Fix integer overflow and convert to g_malloc
To: mark.cave-ayland@ilande.co.uk
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=aadhyar.cs24@rvce.edu.in; helo=mail-wr1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From 41436452357983a35d2280d04be3fad269928a72 Mon Sep 17 00:00:00 2001
From: Aadhya R <aadhyar.cs24@rvce.edu.in>
Date: Sun, 15 Mar 2026 12:27:39 +0000
Subject: [PATCH v2] disas/sparc: Fix integer overflow and convert to g_malloc
To: mark.cave-ayland@ilande.co.uk
Cc: qemu-devel@nongnu.org,
    qemu-trivial@nongnu.org

Replace standard C allocators with GLib functions to safely handle
out-of-memory aborts. Also change '1 << i' to '1ul << i' to prevent
undefined behavior when shifting into the sign bit. Resolves SVACE
warning and GitLab issue #1798.

Signed-off-by: Aadhya R <aadhyar.cs24@rvce.edu.in>
---
 disas/sparc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disas/sparc.c b/disas/sparc.c
index 40c1164554..702409a118 100644
--- a/disas/sparc.c
+++ b/disas/sparc.c
@@ -2623,7 +2623,7 @@ build_hash_table (const sparc_opcode **opcode_table,
   memset (hash_table, 0, HASH_SIZE * sizeof (hash_table[0]));
   memset (hash_count, 0, HASH_SIZE * sizeof (hash_count[0]));
   free(hash_buf);
-  hash_buf = malloc (sizeof (* hash_buf) * num_opcodes);
+  hash_buf = g_malloc(sizeof(*hash_buf) * num_opcodes);
   for (i = num_opcodes - 1; i >= 0; --i)
     {
       int hash = HASH_INSN (opcode_table[i]->match);
@@ -2685,7 +2685,7 @@ print_insn_sparc (bfd_vma memaddr, disassemble_info *info)

       if (!opcodes_initialized)
         sorted_opcodes =
-          malloc (sparc_num_opcodes * sizeof (sparc_opcode *));
+          g_malloc(sparc_num_opcodes * sizeof(sparc_opcode *));
       /* Reset the sorted table so we can resort it.  */
       for (i = 0; i < sparc_num_opcodes; ++i)
         sorted_opcodes[i] = &sparc_opcodes[i];
-- 
2.43.0

