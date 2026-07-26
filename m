Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE7EC53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 13:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnyRj-0001Bm-Ga; Sun, 26 Jul 2026 08:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1wnxrj-0001fm-Df
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:22:00 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1wnxrg-0001fg-Jm
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:21:57 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-92e5c92c389so116455185a.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 05:21:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785068515; cv=none;
 d=google.com; s=arc-20260327;
 b=qaFpDKgaxfiE3oXzRQff7sETi+nNK+DB9nfuTZWyLbbtKXbASxVu7T9PUmAXjlYcqN
 6SLOdurwW/zyE6YPYC502h82CbyUOWcsjoMbdnzhQH6S31DIr7d9Tx89GmEY3ngO3Mge
 XeoE6zddwI/i873dqL0BCaW/a/pGrm3LVsy3c1VN1u220OtHSuVBfikilPiTtxOYtUC9
 qMdc7d5sU+na9anCAkWrnh1bWQ3er+rOFH82dZLKOpgRrg0vv51Wc1864WflSPFd1gvR
 Dwrs8WoEqyBkKBZOi6u9JsWqzZfxeBZGuMrKhAEC3ArlcjgpUqdr435aNwMtD0TY9dMG
 2mFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=rYHszDW0j9AqaazmGUXICI8AbZSM6RDOpOvAxriK8is=;
 fh=uyabCLEm0uqzMNAsIYkyVrHZAOjrXY7bH/yG4RoUZKQ=;
 b=i1Uod9ii91Gm51p3970JP632MpseQlHD3VHEGjbx5AXeIilm1RrLsL6Bjo4v5+Inmx
 ltUYzearPBvaoKqyj9SphNOHEnFAz6sGlm0EAWiDJ2RsnQEAdgqbE6Sf87TVp0h3Z/K/
 iUMKTegpJfWtkY9luCa1sgTWzlpEYcfkj6SXy5fJAJZ7WpHLovj0Mq5CUMBgdDEUpfVr
 NMKjXGMvfg3Eo6S+/yU0SoofnRLjv4EqYZ/7/cks3kKHNVrjIOKRc+xzwmZFkrLrad4e
 hX9rSHDm73TXS5xMS4ALug2nFXrxSF+ebiOY8azeBJD7IRx6YllwqoTbelDkEDC+QX/v
 nJYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785068515; x=1785673315; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rYHszDW0j9AqaazmGUXICI8AbZSM6RDOpOvAxriK8is=;
 b=PTF5Wqhe02D/cYXVxVPHWBjp6wda8/kMtwzSL7oX/C0UlGFrE4h+M2FmWhobMjh+Sc
 Gm99UesQOE5nkG/Zish9JoEBASJmmi5ZQOeiCJxlqtZ7QY76tj9FXN84EGmL2QBK3YiT
 ala8/2o+pCNTBDsZZb83NxHcC+LMjOd8TBuNX7OGtcGtXBS/bB7NPQ8MN50t0Hi9SOS4
 CY6jctqSLBGh82ZVvD5Sn0bg97lp4tr0FcHIlwNLnV4d5PvQVB6USLTWQA16hmlbemfe
 W7nZ6W0+gUfneVVoZU2nM4jVmC71+p1638VzjIJKRz3x9ampAsJ/gifCJdmfeXDpfxb8
 l+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785068515; x=1785673315;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rYHszDW0j9AqaazmGUXICI8AbZSM6RDOpOvAxriK8is=;
 b=ifCXhheLiAAKmVmVzAN+hITESp8O0lLRN4DWMe6b6b4rgjeZmkpLR95X9/dz6j6rMs
 Ksaom+fYMRDAUM1jz6HsLNrnd+BIu4Z5ZvG98JLOQoe4EVVYhgo0L8O/mrNvBcvUFiHL
 9UMRfKzA48aCwNrL5d18Ma9oiGghUsxRx5ME7fRfzFkL3A6gSPDIXoBDDcoXR01dXwzA
 dPTlPetntB1/pXOc02T/8Gd49zJGuALOcntMkMCGW6m/PlQeInna8bomrbC9NvTg8tHs
 OPpmlk2j4YwkUEsdPcApUe/56Y3XVy4mcGPccwfYChHIMSTRVGwRvsZXWzUsKUnsi96T
 Bc5w==
X-Gm-Message-State: AOJu0YwE/S2l3tqQUAvHqpTQw4lECNriXWEHG3yc5xWKTb6aUUy6F1cU
 KzEFE8ElBH6/sZbibmXx+mm3dfrDWEY2eG7whV1LcYK8ZhlvHDHIFQ0ypeZR8RuLKTunAWYHJ0U
 e4L2KXtoIF+vl3dr4M76Qsu5aJWILxRueCg==
X-Gm-Gg: AR+sD13/unHuYaBPfe8aj1D5gRWqji3xVGd9Rua6/2qeZ/Vyt0YaI4HUDgl4X431CJb
 9WK87dBYo06aPgnLeutnZgQEGCuqRnslIDw0vm8mEyj9nf4ushf6mNhJMwYkwvwE0LcjN1neM1e
 QEFASxOw/I3wzQzqOGh96h2hz2aINPHFGO8RhzR7LjvO3zhtFVpC8YYoGLCWin2PNqPuJEBixYa
 TJbxWV9m9CHLGdglVf8ateJhD9YjMufvGRt1QKBq69f59mdvVpyck/QowHO+Ax6G5VRYwjgccob
 fm/O7S6j5QGiqQE5bw==
X-Received: by 2002:a05:620a:2617:b0:92e:9cb3:3f71 with SMTP id
 af79cd13be357-932df5eeca8mr502396985a.36.1785068514780; Sun, 26 Jul 2026
 05:21:54 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 05:21:54 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 05:21:11 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 05:20:09 -0700
MIME-Version: 1.0
From: flavien.solt97@gmail.com
In-Reply-To: <CANVUYGtOgMnNRkfU=zs=jvtg7yKOHXZVb8k5oVnp+D2=U4xeWA@mail.gmail.com>
References: <CANVUYGtOgMnNRkfU=zs=jvtg7yKOHXZVb8k5oVnp+D2=U4xeWA@mail.gmail.com>
Date: Sun, 26 Jul 2026 05:21:54 -0700
X-Gm-Features: AUfX_myu_3RtLfEw5Ykzc3zSdO6Ztl0os6GynQKVkbpeXOAEb03rcyYkURJh4VE
Message-ID: <CANVUYGvfGv=C4qEcANeiLO6bFF1xChn49z9ONdcJfnuh0-Wc1A@mail.gmail.com>
Subject: [PATCH v2 2/3] hw/riscv/riscv-iommu.c: always send MRIF notice MSI
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-stable@nongnu.org, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=flavien.solt97@gmail.com; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 26 Jul 2026 08:59:02 -0400
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

