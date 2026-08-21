Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E67C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 03:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGMu-0002xa-8M; Thu, 20 Aug 2026 23:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wxGMp-0002wm-4J
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 23:56:32 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wxGMm-0002H5-98
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 23:56:30 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66bd7857841so459632d50.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:56:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787284586; cv=none;
 d=google.com; s=arc-20260327;
 b=AJI5shIIShYD/oOmotI5Ve4yqZfahNVlKr+QSuyRrrEjLOBWKoDkCthpQIokPajvCe
 6xtiu8kVWMDJ0S1uvzWltIQEcU16+VreiLKvOrGIM0PQe6XqkWOb7WI+DFehzoiJfk2r
 18CIDnCIPO/Pak0A8Li8YLq4KQM0nc+xV9tOAkdDrMs7+9fFFS6CVYP8So4v68WdZD0W
 bd19Vb9iOzIPWbaKHnqsqFlQw90vI/DTMoOG86Rp+mtGlaDKXYt0CUXxIHgSs7zy0QeA
 t2qqe6WDdSsO1VbGuAVjghwxTY32MEj0MPXBU+ynm4pQu81GpxEJHzMoDFYITly3/Jdc
 OdYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e0/NANrCXjOobJNFshmIrntAvuqdQUXlvIojefKohd0=;
 fh=8+Qjz4/rUBl2LEXkmv8PyA+Zu1Dn2qSKIbGnL8oP4OI=;
 b=oUYJC3apFbPlujw7XII3mAzIkn/z18F6KYyIopLktjnnJGIKcrWEEAE3AatoV921Tb
 SsXprPzLE2v1JDKFUpau9WvDsZJShZvxX8U+efB/0FTq/Buy/6SUCBR20ffAEl/Lq6Y0
 8TrYKCXxPHRA1unZ3YqrXodNgLtMx6gFVMC5V2+C0f7zR3jl85fTIDP2QH0vkd4ZmUTq
 0RRim6ybKopWzSOwXaNxACL/9WjR/YfstrNnkau1zcbWSeX9JYHKQMah8OR4Xs9ErY4l
 FhTpY3akRKvwtX7qBjZ/CcEX1mZsdyE0uC5WnQhXJwubvy5YwuGI90w2Oh4kyT7Ty+xi
 1awg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787284586; x=1787889386; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e0/NANrCXjOobJNFshmIrntAvuqdQUXlvIojefKohd0=;
 b=WBFEalX/t6YVe/wyvwn+Y6D7LeSE1HVlKm4GOiZEterdgzYKmIWsB0Z1fHUrePBqos
 DbVXFRoVuZj2OWNXxQ5AX0xpkiHwjw3rBrSUZVd80FTGbsY8BROlzcREpxHN5PhAImNb
 zKWDJ+Eas9+lVhmMJm7stcADzHqaUq5zdhbNpYmWIOUkNHk3fsHGTdOGKtnAsbfBVz6v
 6CR7rjL+9+sCtTTslc/x3C+olFu++t4u70hl4Zfgdig3M7sjhX8UF3UQEC7O12gtDt1T
 ZR2uFORB+lMTF8k2gZ4p0xCQ82dTrFoxZp9I0p9qCAJQGOFkF/kVFndX28aq26x2d/gI
 NhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787284586; x=1787889386;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e0/NANrCXjOobJNFshmIrntAvuqdQUXlvIojefKohd0=;
 b=U80desYNh4FOLaeGnnwniund/Sgq2a279EZBDA8gSPSBxDp4/7Kmhmqut/vL440/wj
 YW5qcb0Gowexdvc+bLPZrod0+f9xFdLnuwvEKzFyjiILB0OVh2tl1e3SWL+cEQNaBWoQ
 UfW7SG6Wp2xXMDYkkCTNlF0mEq+Jv8aQU7THtPdmiSFxQrZ3FH9v+80L1JyK76w9r5Zw
 p+aQzASlDkEO5FFt3wP3K6H7mlOoW1ldBrZdDLyL8R/7hLR5vhAJx6crbbC/avJNw1LH
 8o13q8/en9Cd57HTHMf9kSLDD9Nr8qmw/VLXctA0IcxpuoXXvHHFJJ5tLHD8SZnhYJZH
 IiTg==
X-Gm-Message-State: AFuF++mWB9OQwbHuRIgN53LMF7MUNaYnz2r6BUVsPpD9YhaWS4QqdtK6
 7dpRIgqMn1NHD+yTcxTU7q+RfqwVom5pJzWSQKnWgTtexXABr9+DfmFUA/1o/9LCu8eGh9RIayi
 0RRjnkxg3ScvdHiGXTEoTZluKm+WVjes=
X-Gm-Gg: AR+sD10Ba23NNkmKWRrk2/U5KoWUmUrsaabRaXz2AUZp39K6QrlEfXD8w4Q5EzCpSy9
 tSJJdkFuXgA7gfI2u/02xq3Wkp7O9tC/2L/qZKw1j2/ycekIbpogSWBkUknAFRnaItNKjLQC/zj
 Qm+LaxLUjMY/Ac5c68bxLgBYzx212PyBVXpUY0PYLMyrC5/K/17ao+M6RHVbjAlHGCOk31e82jY
 EFofVClfzxdSFCqJ9BjdIfoQL2hE5tiVGEmElUlS/QK31CxjedWP49Znq046qmE6GV7Rv+ficeX
 YtOr3dfnVTzsGRcgDDTik7o5x53lRJveXE7jD7D53AUA
X-Received: by 2002:a05:690e:bc1:b0:66c:c7e4:2ff1 with SMTP id
 956f58d0204a3-66ce4a1073bmr1416660d50.15.1787284586003; Thu, 20 Aug 2026
 20:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260808182956.290561-1-flamboyant.h.01@gmail.com>
 <20260808182956.290561-2-flamboyant.h.01@gmail.com>
 <3ed04624-9d4c-4c11-9d7b-4bb6568b2590@oss.tenstorrent.com>
In-Reply-To: <3ed04624-9d4c-4c11-9d7b-4bb6568b2590@oss.tenstorrent.com>
From: Kangjie Huang <flamboyant.h.01@gmail.com>
Date: Fri, 21 Aug 2026 11:56:16 +0800
X-Gm-Features: AcwNN1VE8RqSaOzsXzdPQvs6snSJSbnbVG7PiMoAjPTtDXkWyRjt2mRuWNbYDTI
Message-ID: <CAAW0U4Z4hSpbC62xE78PJjJPQKNh+7XxF3-Q14QzymELedxhSg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] hw/ssi: Add Synopsys DWC SSI standard PIO
 controller
To: Portia Stephens <portias@oss.tenstorrent.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Bin Meng <bmeng.cn@gmail.com>, Chao Liu <chao.liu@processmission.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Kangjie Huang <flamboyant.h.01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-yx1-xb133.google.com
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

Portia Stephens <portias@oss.tenstorrent.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=
=8821=E6=97=A5=E5=91=A8=E4=BA=94 09:11=E5=86=99=E9=81=93=EF=BC=9A
>
> I don't think this will work for frame !=3D  8-bit with the m25p80 flash
> model used by k230. ssi_transfer() takes a 32-bit value but it then
> calls m25p80_transfer8() which will just transfer the bottom 8-bits and
> drop the rest.
>
> I don't know if this is an issue with your code or with the ssi_transfer
> function though. It seems like ssi_transfer intends to accept 32-bit
> values.
>
Hi Portia,

Thanks for the review.

On SPI_FRF: you are right, the explicit clearing in dw_ssi_write() is
redundant because dw_ssi_write_masked() already drops the bits that are
not in the writable mask. I will remove it and add a LOG_UNIMP warning
when a non-zero SPI_FRF value is written.

On the frame width: ssi_transfer() takes a uint32_t word. The issue is
that the DWC model uses CTRLR0.DFS (4..32 bits) to define each
transmitted frame, while SPI NOR is an 8-bit consumer, so the two are
aligned only when DFS is 8. The K230 SDK SPI-NOR paths use 8-bit
frames, so this case is not exposed by the current K230 use case.
Maybe either add a DFS !=3D 8 restriction with a LOG_UNIMP warning, or
have the DWC model split byte-aligned 16/24/32-bit frames into
multiple 8-bit ssi_transfer() calls=EF=BC=9F

Thanks,
Kangjie

