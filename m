Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6D1CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 02:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRhU0-0006nX-SE; Mon, 25 May 2026 22:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRhTu-0006hi-DA
 for qemu-devel@nongnu.org; Mon, 25 May 2026 22:25:22 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRhTq-0007kp-AH
 for qemu-devel@nongnu.org; Mon, 25 May 2026 22:25:21 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6763cc8775cso18891098a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 19:25:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779762305; cv=none;
 d=google.com; s=arc-20240605;
 b=E8uOK8eJN1aP4pyz3TRvcuOOQPUBhMwnYodExmKOEdXNSqORw8sOOs7dGNayV8JvDv
 4bzFwhtqwxNXO6J/2GQpGRH/iVunhEx4O83M183b0xWnR15c0KhRI5h8bosfyFsOi231
 ZCN+CDyT1dEdLU7S2hKG2eAFKnoSDwDtQZNF7f7z4ePpcooto3vQYnMlh6JFJbK0LXiG
 5/0gVGpEsUwUc2LlJvDtZhuWnX/8VLVJIrs7XeIu4ZEDRAEDwr8TlKYw7NLMMyXtDVBJ
 IcnvBzwzZylkioIbppB3tlLFKOfwh+CypOfmwR3HqvEf7pw2+buOwa265hW3145BvNhH
 0D7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VDMyuOqoWvSn3OAa1z+NT+qoNd6lqnmQ9x716Wtip9E=;
 fh=c5t5J5DuZ07TpANKDNQXBQqHNrBr5lv/14VrOPTGi+M=;
 b=XXy/4LL32NDR75mw105FRyIGlkJV0F9qev9BpH7ypdjokGIK8AhxAF+YlcHZEfEU8H
 5aw0n8asuY6SAoA+7ZGkxSvtsad+4zhqbtYlUVUtH1hkZot9KMRZe6QfvjW+3n06SWAW
 FBBHEakiwUVeit0KZLdzi1yySkyWZCQHR6/Ok10Tt3f7QWzcwKqPBs526/M91FJhFJIH
 n8A35pTKeAG6BuGujJK/MkTnZxI6QJAmdzh5VbTwvAP/dBjGAPAZ9B5faOmy6qOCxJ3J
 PEv8c1/f27X54oK5ZomEGXHWNHzSV1HjDGJcDSfkyuYiB9inD2bgKoAeDOLqFUBMWjPB
 lXfg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779762305; x=1780367105; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VDMyuOqoWvSn3OAa1z+NT+qoNd6lqnmQ9x716Wtip9E=;
 b=fr3GCJvrodogByZwarBPFgJF+0WngfCIoFgMKebEPmgC+muHxYoLqvqfeGHqQPzOQ+
 sH8Yz03HX2Z2T+38/nFvkpfv/CBYPyZO47aQinArxSwqYzUua120mU16GqoTOfJIPd5i
 ncfC204GsktIswrwbxJr11sY70vIonCfsl7Wq2OqWX54C3PFjFWmgPdpaJo7UMGPrrJa
 RJLnAKXKWiY3VbzqzClF9dNE8sEjLyY1hhpdmQH/B97waWj+C8SBdEJJn5jh5uIo2bDD
 nw9gp9Hr54G7pCarzqHjqTYg6Gmeje7JR6axm2eQnvFTzVj5PUwEJORqe0xHLy/GqBAt
 R1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779762305; x=1780367105;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VDMyuOqoWvSn3OAa1z+NT+qoNd6lqnmQ9x716Wtip9E=;
 b=Dw1TDaLmpwka2bLprGtn/DtSr9XJBlP7Nesa0p7Kn1Ae66STOzeRw7vTidx9BDR1dn
 5kKCvEx4F+9q4AaopyzYyVHE3adAVhmxkTweTOiU41U3aEwrYELROi6nRfks14FL9TDS
 /ZWJKz9cg85tx4/iAo2EqvliTebT9GXDFnat3tZuzSVNeeF4jpgdDkoADxgrcQ3xgyQJ
 CQGwK7peYGXTs3yvMrqG548fzLlrLAI6UIrl7zEYKrPj/QY2PMLVowPOA55I+Xif3lMF
 HV3+XcIxf8fwWyo3BMOhAvd9tk2J0zuRufbCt8vT50bI1K3hyUURKxgOmVk+CPWWuVb5
 MjBQ==
X-Gm-Message-State: AOJu0YyDRIL/f4X/iO7LYNYg4QPC89fSyiEZfXpI3blz3CFfdyyFL20x
 T8oTMVmE/xYlP7bcWlP+MjiK4uSmBN2+rhQsvmNFB0JBgliP/o5x3TzgFIOw1P5dn9IMdv6JSZo
 jYOPleR5Z8vOjJbgnvQ10jr6un2y4W+U=
X-Gm-Gg: Acq92OHsds9vPSO9V+eEAukPUk4uTdI3uj8MSkFM2V3lGDqOqcesJ2XKU4sr3Qpx1Y7
 OHR+H1trQ6GewFtlQY7rBodaXG4WGbsCMcDs7WiLZDCVDccNJjpeJBDs6u6PHTfBgaG5FU4qUdL
 XfEz4qCwvQ1uyak5Cvwa+wjbOP2G4Lr2nVpYOB+kuJdFHR/iIiMuYA2Np9uvqaxs+9bk+XmBgok
 jqpX8Hta8Y/ylD7xxMyDvIw7KVcgC2lzkKiZT3jv2meIR3q/R+n1zaTwCQyifcRnRlIy4qnOyaG
 3mmKrS4AgzZ3hrK6RJr0cKSq4PNhTbyeBHB0Fw==
X-Received: by 2002:a17:907:7245:b0:ba7:41d0:5efd with SMTP id
 a640c23a62f3a-bdc0181d98amr994941866b.28.1779762305084; Mon, 25 May 2026
 19:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260520063606.36600-1-jay.chang@sifive.com>
In-Reply-To: <20260520063606.36600-1-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2026 12:24:38 +1000
X-Gm-Features: AVHnY4K_Y3KQQP1p2bVIoeMIkNzyNuoiQ8zbWM_O4ESZiHozQbPbJxi9feMPUjo
Message-ID: <CAKmqyKMEL-szou+SFghaFBwCnUVjdbtOFcwX28zDq9zo_KJK_A@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] target/riscv: Fix PMP address alignment
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, May 20, 2026 at 4:36=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wr=
ote:
>
> This series fixes PMP address alignment to comply with the RISC-V
> specification WARL (Write-Any, Read-Legal) semantics.
>
> When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
> value is smaller than the PMP granularity, it needs to be aligned
> to the PMP granularity.
>
> Chagnes in v5:
> - Use uint64_t for granule, in preparation for upcoming single-binary wor=
k:
>   https://lore.kernel.org/qemu-devel/20260515180437.23620-1-anjo@rev.ng/
>
> Changes in v4:
> - Rebase riscv-to-apply.next
>
> Changes in v3:
> - Use ROUND_UP() macro for NAPOT address alignment
>
> Changes in v2:
> - Fixed commit message grammar ("it needs to be aligned")
> - Use ROUND_DOWN() macro for TOR address alignment to improve
>   code readability
>
> Jay Chang (2):
>   target/riscv: Align pmp size to pmp-granularity
>   target/riscv: Improve PMP address alignment readability

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/pmp.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> --
> 2.48.1
>
>

