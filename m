Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172C7C53200
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 13:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnyRf-0001Ah-2A; Sun, 26 Jul 2026 08:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1wnxql-0000en-RM
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:20:59 -0400
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1wnxqk-0001ZZ-6E
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:20:59 -0400
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-8ef1dc934d1so17668046d6.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 05:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785068457; cv=none;
 d=google.com; s=arc-20260327;
 b=XOyzpzULRsgjJ6eU7+D0gcESrR5PZvq9yZd0ueTxaZwRyuqPbwZw8TDT5vmpgPCjbP
 W5OyVvSy6CnCPRH7lCclXOW0zhqbS1D9bVmiSe9tiKRe6m97/MvkGiYvDIEWcS3c6XwD
 l0vPPI3dxYAaaTn8OW+jCLckazhWwHC+Yi3UzQ7HltsxsjZfmUE5GnzpZLtI6uGDkryD
 4M6YIosjXHIhkyf/rPyWogKnwfosR4Pc2xu44Z2lVBFNZ5LdVbk4/FcvMqywdGIFSpaE
 G+N1w+uXjL3u26tgc1SryXPhNpqQncPwxAm44XtcfjTct1KNCXi8b98FtY6fkOTwSq0e
 AkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=exXuXrHKCPYot3CP2bNujfaD85Un73hDflaTy5ScFeY=;
 fh=Q+VawTnyPpEwxPZMooSwK91l1mhoB7Mdd38ya8InFIo=;
 b=X/2hNPyzFy6sEkiEO1M2/QABOQ4dve7y3KtQolHyGRF7U+tDB3SrivC/hp5PlrkIJT
 4c7DMattgOMqq31kzCsKw6wWPIwu2jVQw9SwdRyZuoIx0yZQueu6dulC+8zJXaNp3rIZ
 q8a8BgGHijJGGrdvpYW4z+L16PMRcgQp6oGxTaFUU8MfvszB5l4vpMfMjOpPETnsHYXH
 ZpzHpFxUk41NDpIqqc8P9QZgSDyAJpAdmx/6k981syM7YcmvgF159egCmXxCrDlehIfd
 LsBg3DZ5C+3kBLeBcP878+yih8LcSsACZZL/vCYrC+vH20s22a7z/j+GRHoQFkQbaOgg
 t18Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785068457; x=1785673257; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=exXuXrHKCPYot3CP2bNujfaD85Un73hDflaTy5ScFeY=;
 b=bFvfIuK/USnR7+wrqUDoQLVnfpT2ack+391fANmnfGbln9UrrNvzFWyE8U8gNqqLdA
 +lL7/SoqO0p81Zzwjb36x0uO7oiJ0DmP8HSSdFoeh3QJnWnT5IeakWq0+KyXh6p90pTE
 htoRCzAVK+HNabZY1WGSRB0S1zCnoAG3sBLv+SQl4hjBPU3Bl/Bax0YHWGgXWjAl4xPG
 HL9nVkK7R4Q7KFjgLiQsODpgAXKZLyxh6En9fd+Za9wMAHXrN5Q+Tx37zlO8SqdhzBXh
 46Xne/3eQW9Hs9UBct4XCiE6wytWqA+j+jma6JU8yKsMXTZSLLwgaX7vfzHpdAVrf2Qp
 ykXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785068457; x=1785673257;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=exXuXrHKCPYot3CP2bNujfaD85Un73hDflaTy5ScFeY=;
 b=eFFfdeWs0ahp54Gz+2T4q4bEoK+LXfAadRI7isGIzm7KUciGRWvl/4Y4fUonp/vpZ0
 84+ErKo0yc1KkyEvWuuHuKJrUCdYKri2pDh9Sj0xGWcWqTrg40OL0+o23rqBUXoauMtx
 Lh+N+ixp7CJp8/hHDaou7rfPktG1DCl33hJOD0k4srgZ8e0Udgui2hAHRqHToUuPObdq
 oIreqgT09y+B5zYIY+UrJeQ42atwvF21q+dZYt6BT+UfYeuWX81aPlrUaUW8swK2KVbK
 /odrVXAO/TTN88TkzgcWDOQ4qX6OTXwgfAkRa3JDAXPsLGfynhFrpEkmjF4A2hKsCh5V
 HTIw==
X-Gm-Message-State: AOJu0Yzg/Cr70N6UM5FHGo1bELCnlNPuWbg4nt0dH8Zxqd+oKGULnkFd
 rojWx4aIFXUpYThOB6Ph7fwl0BfzBjRitvosh3fjZOk8VkJk/tJTm9l53SyL80IP0hcLr6OnOdI
 A6ur7yg/3wnHMOnPnCfal/pzgoBKdBokwqA==
X-Gm-Gg: AR+sD12qTCdVPpv/Nfp279lA4fVuywFe0PheF11iisy5dZ+ZaQXnpGJARYAgaMEEVQ+
 xblaBqHfraN50ATQh+rcjPyWNvgI0jFQZHSQ+YByic2YfvEdp+KW5vnHPsJmpIbhuKKy7r8mEQ8
 pOwfbCe1ojMBWM7twDf8TOwmlXM1+sQWoYO5iCqozLmz6vf5b/KeQ/K5etRoXlRTPGqIFJRDZyE
 RhlrseC39I+dZGbLc4QHP74s+rvi4iHX0eGA2JgAbHSF+9vqDpQcXrpNsWaHN1TPs8QX3oYyDhf
 cA6jlEuExC2Z7bYHkw==
X-Received: by 2002:a05:6214:e8f:b0:8ef:dde7:bd69 with SMTP id
 6a1803df08f44-907e6699060mr85711996d6.29.1785068456628; Sun, 26 Jul 2026
 05:20:56 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 05:20:55 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 05:18:22 -0700
MIME-Version: 1.0
From: flavien.solt97@gmail.com
Date: Sun, 26 Jul 2026 05:20:55 -0700
X-Gm-Features: AUfX_myUnOnMme4waSUfKlpLju28So0YNd5ljjPIJNnVUu_wEUiZSyjZo_y1iXg
Message-ID: <CANVUYGtOgMnNRkfU=zs=jvtg7yKOHXZVb8k5oVnp+D2=U4xeWA@mail.gmail.com>
Subject: [PATCH v2 0/3] riscv-iommu: always send MRIF notice MSI
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Andrew Jones <andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=flavien.solt97@gmail.com; helo=mail-qv1-xf33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 26 Jul 2026 08:59:01 -0400
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
MSI after storing an MSI to an MRIF even when the destination interrupt
is disabled. QEMU currently reads the MRIF interrupt-enable word and
returns without sending the notice when the matching bit is clear.

This revision includes a qtest. Patch 1 lets iommu-testdev select an
MSI payload and supplies its PCI requester ID. Patch 2 removes the
invalid enable-bit gate. Patch 3 checks both enable states through
qemu-system-riscv64.

The complete RISC-V IOMMU qtest suite passes:

  MRIF notice: enable=0 pending=0x20 notice=0x12d
  MRIF notice: enable=1 pending=0x20 notice=0x12d
  6/6 tests passed

Changes in v2:
  - Wrap the fix commit message.
  - Keep the existing notification comment.
  - Add deterministic IE-clear and IE-set qtests.

Flavien Solt (3):
  hw/misc/iommu-testdev: support PCI MSI test writes
  hw/riscv/riscv-iommu.c: always send MRIF notice MSI
  tests/qtest: add RISC-V IOMMU MRIF notice tests

 hw/misc/iommu-testdev.c         |  14 ++++-
 hw/riscv/riscv-iommu.c          |  13 ----
 include/hw/misc/iommu-testdev.h |   1 +
 tests/qtest/iommu-riscv-test.c  | 102 ++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 15 deletions(-)


base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
-- 
2.54.0

