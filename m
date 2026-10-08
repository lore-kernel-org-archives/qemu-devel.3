Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82BECA600A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 08:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEjlf-0002bN-Ml; Thu, 08 Oct 2026 04:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xEjlX-0002b0-N7
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 04:46:16 -0400
Received: from mail-qk2-x03.google.com ([2607:f8b0:4864:34::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xEjlW-0007vU-8d
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 04:46:15 -0400
Received: by mail-qk2-x03.google.com with SMTP id
 af79cd13be357-93cc1b028bcso353953285a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 01:46:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791449172; cv=none;
 d=google.com; s=arc-20260327;
 b=P1+fFaZSi6y9ApHAMjBtD25cK84Mw8GazJ4OO2q8GV2I7hKRQGTBLXCEEVUFZ+IdWj
 fymmYjJDfgPnyL4K56USlgLUshYIxbROIrt3VA4GQYzfp5RymdRavgoQEWA1oD6gbHOp
 zvnRNda5/8ibALa4cpYTzZWvIPHUcvfYc3XR6JdLd09RlYPTV4+je5JQZMtAsPIMi6N0
 SdsNaHSjn57zFZfXy4ht7E3HerN4OSPFr/NIabHtIVfIRapKvF+04DAj4o19TdZI22AJ
 uC7cF8BdN85p7v7co2RWI604dNlh3NpocxAAS3XDDaZREshIRG8VnXDV72wwgDf5GQeR
 72rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=5+QRWLvTE4mvCUseC61Hy+m9MdEf+S+xLr9W7Ja3/W8=;
 fh=Y8kL6bSa/yQz5RitO0pLCewP1xvaxsKKeL2RQ3HSwAM=;
 b=AAn5PFH8YNFGgcZwePNDBamN803fDRk5Hm5xUQEgoLXjFKDSw5TPsl8RTEcgK25kkv
 dakPgoVydRdkUnLhQr2PUUJVskP5KGJMn1tBJQ+fzLtDxF95xtKFwkKl9hC9bccK/9Vk
 WOQnoRcNmyKBnuM5CkRxh25F9p2jaL69Gukchp/Ws7VSBwIykdi2qqU8OX11hxIAbXiQ
 aOgm0CtbNhV+CF5fE7TSZLKW9lR+yDlOqlgFsRWqh3uEtR3ilgia/zZkARy1fStZx1q2
 I2WSDvYuwtVzYAXOV+LCx6aflaaOt6xS+1ViE536OA+tnqG2PkoUxWZ+PCcODoXdiFdZ
 cUPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791449172; x=1792053972; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5+QRWLvTE4mvCUseC61Hy+m9MdEf+S+xLr9W7Ja3/W8=;
 b=FsmfYLMFGIowafoCxvZ08qbYVnJ34a6kmIxXxY53vxgjm1tqgaassuWMzE2+rUNAUk
 mAX3ABH14UzcTdtjRnQDL00d+9ra0sIu0aH426ARjOlwYABF/bABit0kWWKbQ2x6/GvW
 CMlSk9J4Yo5mXMNGPhaVXJzgdVbbY0UyB0GXL+m7KjWlS34PgptS1KZZVrZfRrueQwVJ
 RUGGE1ttFtWl2mPHbJ6F+AOELzW5mO1xiUOPuyds1r1tGJVKvK9C2U3iANQ3DsTJOYxl
 5zEn9u6jNEirDmQtETAec4Q2U4H7kCCIu3ZQoapwPM33d4JGXGAI2/5zvl4KbMcjDC2h
 Xt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791449172; x=1792053972;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5+QRWLvTE4mvCUseC61Hy+m9MdEf+S+xLr9W7Ja3/W8=;
 b=Kt8rqeu1n6Qq5Qhh9/HVPlAZltp+poFh5sLKefpd4s18e1CoXiRcpcEwrEqbOyw3kk
 jdS9cibPu/KT21AMma3RW6STQ4hkD6BDelCO1/Pa1M92aa9d3O2514Aq6CZjkcmsjACv
 Cg+waBBZBm8AcnsygTwm3qjwx8Gl6gMbq4Xpxgy402zYTnCmd9/suKZKP9tpmUfulbpI
 mrIzAoqzyBF6xRoaRV769hUlWiwoi2HWoZKKIwokbjV4qUESm8pK9uBC2oCiYa1/EHxj
 ONteVkkstcKUndYxXsA5xDygodYszpQWux6zlMmmcDq37EAgYjs58XTcROzVT6p7UhVs
 AotA==
X-Gm-Message-State: AFuF++nlmmkF8+NccwcgRggceSSlLKy0CemTtXKZk3xjaM3jIDqbz5gb
 LMmfVU5f0rBPjtSvfKuL4rH1oFZvramCzWyGJ6gJDLxDNkiMD3S073M6ipfGtofVx6JfeX5zKwX
 kRv1Ton/yPhoMkNJmaVUZOnDaAG4buQCDA0f2XomXZQ==
X-Gm-Gg: AYBFou31+UxN2nH3r4yIDEgsXKHmM6DloyNHIoxL0fHPMIt/svzKqmq3AfOE17qoLDi
 Y091qFiSgsTg55RT7j2e68ChHKsC6nTv/dWQ7tnIge06G889DoRpPqKBt4q3D5SQ3+7HFZ2Rg0/
 skGmd+fjRfrTIYy9ddPm6AKndr3QunqG92ntucKjlHsDZ/wEz+fG/it3+6wI/1rGB7ZWMJSbC08
 F1u83hOeqovUyXTH0zvBWHtzwszqxtdF1Obv/TzJ4SgVEKOoV9xjAbAr0r6Rep/PlFkuKhji6W9
 pwK9kMvQfQVRqa71p1TsnLnTjgm6ndDpcj3f0hs41N4X/rzvw4apUo+GIe+pu7XBBNG5yy6FUSR
 6SyFd7qKF/l8=
X-Received: by 2002:a05:620a:880e:b0:93c:8e3f:3036 with SMTP id
 af79cd13be357-93e9b0f24ffmr913727685a.4.1791449172270; Thu, 08 Oct 2026
 01:46:12 -0700 (PDT)
MIME-Version: 1.0
From: mdspan <mdspan.github@gmail.com>
Date: Thu, 8 Oct 2026 02:46:01 -0600
X-Gm-Features: AclHuK84Hze4swoYLFYykzI_AJ3x4oXKDoIbP3eLYdGmg-U6CwOGvvnHD2VxuGo
Message-ID: <CALU8FV-YWO-NEN1EMAa6NGZjxdHnFYESWAvRtWFgZtB8vLew+A@mail.gmail.com>
Subject: [RFC] target/i386: design for TCG emulation of LAM
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, zhao1.liu@intel.com, 
 laurent@vivier.eu, deller@gmx.de
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:34::3;
 envelope-from=mdspan.github@gmail.com; helo=mail-qk2-x03.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi,

I plan to add TCG emulation of Intel Linear Address Masking (LAM) to
target/i386. I would appreciate any comments on the design I've outlined
below.

In 2022, Kirill Shutemov [1] proposed masking tagged addresses before
the softmmu TLB lookup. Richard suggested doing the work in tlb_fill
instead. This is an outline of what I have in mind, based on Richard's idea
and the way TBI is currently handled on AArch64:

1. Masking in get_physical_address(). Run mmu_translate() on a masked
   copy of the address (bit 63 unchanged), and the entry is installed
   under the tagged page.

2. Entries are cached per tag, so INVLPG has to remove every alias of
   the page. INVLPG would pass tlb_flush_page_bits_by_mmuidx() 57 or 48
   bits when LAM is on for the operand's half, and 64 otherwise. Passing
   a tagged operand to INVLPG is a no-op, as the SDM requires.

3. linux-user. With no softmmu TLB, the address has to be masked at
   translation time under an hflags bit, plus ARCH_ENABLE_TAGGED_ADDR,
   ARCH_GET_UNTAG_MASK and ARCH_GET_MAX_TAG_BITS in do_arch_prctl(),
   and an x86 untagged_addr hook for syscalls.

[1] https://lore.kernel.org/qemu-devel/20220407010107.34734-1-kirill.shutemov@linux.intel.com/

Best,
Tim

