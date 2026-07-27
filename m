Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3167FC531C9
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 02:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woB4w-0006i5-NR; Sun, 26 Jul 2026 22:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1woB4r-0006eL-12
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 22:28:25 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1woB4p-0001EJ-Hh
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 22:28:24 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-92e50979c71so227720885a.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 19:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785119302; cv=none;
 d=google.com; s=arc-20260327;
 b=Yd07+We7cugIQVaqlyBBjAhijUGf4V5OtjlC7xiv8NGk48R988gQVbb3sKeqjFTVZ/
 +fJrVQ9yc8Ba/bEOYHpmPBJLuZKUv+vzGzLJ0s0+EcFwwE+VL9755agIZ/V2g8l0Dqf0
 f/q5/1oxoRP1Ix0mUvCdikmlAdGA2tKnKzoPy/pEIiNj7KiuzPiEqM3Z294w7rcJychq
 UneAuR4WVP3WzNIZA2HY79zWUsp3bNzfInIy4wR90TI+KNyge3Ds1TkiZ27BBR50z5Yh
 y2KUkrqisc7uJ7+OssKquKa7w+HlN59pdyTb3e/EtStfIqbZaVNyv/OM5OuWsJc/KUYT
 aO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=YdjUz8yik0MeA92jNBhv3Nw6JCVgFI8IwVl9CAMpWCw=;
 fh=uyabCLEm0uqzMNAsIYkyVrHZAOjrXY7bH/yG4RoUZKQ=;
 b=XdhmhlftzVKlAwBBNlcG4X9LPTESrRdZAnl2ufNqxUVxOKLRQWzoTZNPtiQvkJRrd4
 BgwF7wHRcsaqH65UEobNBPfFrNOba99MVy2i9gAHWJb5RbxBHsjTjfP6VHl4z4RdBAX7
 Qb08AfrCcP/zyd5UhodgERJzqulcRoiRnZhps0Kn9dj3BAT7KUO1HYH02nSIL52iTrXB
 h5eHvSCOejOdqb+5pd29hNhHpPCUkxLKbjAJaarwtvQP9QFf0wYs3QyaPZDPpKHk/tjt
 CISM9hZb4fpm+qbOnJ6/GPw5C6XLspD9/MUE6qbF1V/8puxXtlp2pmuWisGDBdu21aRG
 7WUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785119302; x=1785724102; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YdjUz8yik0MeA92jNBhv3Nw6JCVgFI8IwVl9CAMpWCw=;
 b=kR9dXconlDklXhfPRn99VrHn+37eZef/x80EeSIKFBiaxV9Rvb5EWC3vknUKIxoeot
 Xx3KiKm+TwufsfAtKR72MYJvM7rgENuA+JvSFl405auxY1zoSjSUZ4MNXhc/xrIVL5Zy
 UzR7h7aTDfe0GF6CEyYi+jJ3foXmtF/OUeVxfMF4y8VR50ZQQ15VqdTeVQqy/iGfjYSq
 G4PCCzWCmHHDitTklc7iW7Jrs0vf6e91eGJulXfKTP2eYhocC8y3orSpTSriNNimFXgz
 6513aFvx1DkllU+MZVACg/xET5zfPLAMYty+6HAlIH6cEZ6OVXJhzRYgNaqbRRDsDOzQ
 oYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785119302; x=1785724102;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YdjUz8yik0MeA92jNBhv3Nw6JCVgFI8IwVl9CAMpWCw=;
 b=bMlLFxKwymlh8zXWroa62t8z/CoIFokNVDgUD+oPfkG3a1Z7GByLMPwHeHBZa57IEQ
 /R1FoV6CtxHg26yMh4M0+r34ZdJAeca/R1MLD/eCtFu3YYxfndbsIgXXaiBYri40Ebg1
 R1nCh34h/Rawv8b7+lxL60yqJJYxoohhBkH+kZaJJsoqDUElOXt19lxQL59WvCHp/ito
 gJyHplGf788bZW/9oN/fBqfkJ82fBn4ch1E+NWS8NNLFj//0zY//P0NJLsnDUGDvh5JQ
 mEq8sCKt+JdtSQHY9YkUbrvydmkFASa7538oywNqC4stCcMggbj1zEihmDTq0j9oCNOC
 b/gg==
X-Gm-Message-State: AOJu0Yzwoy84tGh989Fi/s1HpJTIAV7tDvoze6woB4DC161oQmxZIg0r
 S6aKwCDX2zST5OcWAbAFk/dihj21tEqEvZgSJCMhE0sKew+rWavIq3I2sbxY7y5zxbWtHSlvEnK
 I+HxnR+cZamR0QLafmLu2dI8g6Ur3R7rjPR7W
X-Gm-Gg: AR+sD13KAsFeOcBT8L8TRhuNhWLXv1NqLBcXbOkj/PI0BlODscnO/EmJmYjemV/pGAO
 ko/C0JAuo4DJgTkwU/F90EGUVghgrDYFlVrjouNXMbZQ7N53h11XAMeyPw0Sg2WrrBwjmBn1C8/
 qvV8GaISLSynek98o6KmisZc/cHKFn0fUVJmS3QM56orWQpJT2uLNrw8M/guI01O3sp5j1XvVsl
 gsAP7QG7v4YzsfEn2mzjR4Dtzj4T4cwTi2vXSzHjlEHusGLs8u2rM+z8z9PkW4cKeVvy7KuZzi4
 ZuR36RahjvMWiL1L
X-Received: by 2002:a05:620a:608e:b0:92e:675e:8eef with SMTP id
 af79cd13be357-932df5c4974mr702949685a.15.1785119302517; Sun, 26 Jul 2026
 19:28:22 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 19:28:21 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 19:27:48 -0700
MIME-Version: 1.0
From: flavien.solt97@gmail.com
In-Reply-To: <CANVUYGvOyZdCwXOtDkS7bXY3Z2HGK1b6QWKttCVUjhnpH65g5A@mail.gmail.com>
References: <CANVUYGvOyZdCwXOtDkS7bXY3Z2HGK1b6QWKttCVUjhnpH65g5A@mail.gmail.com>
Date: Sun, 26 Jul 2026 19:28:21 -0700
X-Gm-Features: AUfX_mza1SR7s82RBsNpv5HCAVKryuqxdGxcsv0bkATEczjuOFrF6lJgDbUbVIM
Message-ID: <CANVUYGvtuMbxE6TCkO98G1rCadb0psdn8HQM+6T8v0KE+QVr5g@mail.gmail.com>
Subject: [PATCH v3 2/3] hw/riscv/riscv-iommu.c: always send MRIF notice MSI
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-stable@nongnu.org, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=flavien.solt97@gmail.com; helo=mail-qk1-x735.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From 42f759d7e7f4eca064638622d52aa38be11b956b Mon Sep 17 00:00:00 2001
From: Flavien Solt <flavien.solt97@gmail.com>
Date: Sun, 26 Jul 2026 17:52:03 +0800
Subject: [PATCH v3 2/3] hw/riscv/riscv-iommu.c: always send MRIF notice MSI

The AIA specification requires an IOMMU to send the configured notice
MSI after storing an MSI to an MRIF, even when the corresponding
interrupt-enable bit is clear.

riscv_iommu_msi_write() currently reads the MRIF interrupt-enable
doubleword and suppresses the notice MSI when the matching bit is zero.
This makes notice delivery depend on a bit that AIA requires the IOMMU
to ignore.

Remove the enable-word read and send the notice MSI unconditionally
after updating the MRIF pending bit.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Cc: qemu-stable@nongnu.org
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Signed-off-by: Flavien Solt <flavien.solt97@gmail.com>
---
 hw/riscv/riscv-iommu.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index f6865d1..2bbac30 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -788,19 +788,6 @@ static MemTxResult
riscv_iommu_msi_write(RISCVIOMMUState *s,
         goto err;
     }

-    /* Get MRIF enable bits */
-    addr = addr + sizeof(intn);
-    res = dma_memory_read(s->target_as, addr, &intn, sizeof(intn), attrs);
-    if (res != MEMTX_OK) {
-        cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
-        goto err;
-    }
-
-    if (!(intn & data)) {
-        /* notification disabled, MRIF update completed. */
-        return MEMTX_OK;
-    }
-
     /* Send notification message */
     addr = PPN_PHYS(get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NPPN));
     n190 = get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NID) |
-- 
2.54.0

