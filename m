Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A94FCD98CC
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 02:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXrkT-0007y1-Ee; Thu, 11 Jun 2026 22:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wXrkS-0007xl-Hz
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 22:35:56 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wXrkR-0000rB-6z
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 22:35:56 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68cc6c7df99so735574a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 19:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781231753; cv=none;
 d=google.com; s=arc-20240605;
 b=g/tC7iJKsBjUR9uC3BJc+QBkzBFqW2yYIMPqOSRz6UXKKdQwEPIvxgI78FSzS+ot8+
 +BPaadIn9zwuOcEaWPCTk/LTQTzwi7IY0yGS+YcU87HFj8JQCwTPIkZ1BLWI9598g39v
 6tYV8AML/P6tt26KeEUICYQLrGkiGeDEkhxjJxgZuG4pYU8BP70VIC+i6r8GklEYBfIJ
 AIsxJy3EC6pghe8lht1fWo7wl9Snj9fU5Yv7DqK5nrKLBNnr6MVJITr8fV9+V+EypC0A
 REWFXmz/IcPAlf2+PcADrRh/eOYbaOzv6KsNQRWHotrgOvqCeTCad2l2+Xrjg05Uiake
 jzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YLiT7oE05AMahAIojH+9OhT9gPhIkKYYd19DmN64vXw=;
 fh=c5t5J5DuZ07TpANKDNQXBQqHNrBr5lv/14VrOPTGi+M=;
 b=SJPbbD1Rt3nfkyJMiE+dZkZNwUP7XMZauW0VqAvxSxPLwUBPBYI3QRUvRT3JdX8D6w
 1A0Jd7x43CS2vlKKxsUrmliopDZH3pJ2x9GObM3VU405Dsjzz7L1exGmtTgftd/9cX6r
 X6divBU6gz1z5qlec0bVrATrv/DyFgBDgFKpy1VwoE45jOF5qDuQ6AGEJoZWMXJLLGtL
 mUrX83NJ/TmaQodTv47UOfGkqxPKZ++kB/N/MKqDOugP3ro7/V8bh3xFwH06oU6Jn8lY
 CH21deUY9ToZ81N54+lw/vgfBhCoNNrF9kbEvGMJynzUPXNOp7zPcWaXZ9AJBXsuI81y
 Ikmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781231753; x=1781836553; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLiT7oE05AMahAIojH+9OhT9gPhIkKYYd19DmN64vXw=;
 b=j/BmxjsqJ9fGZMVTe0L9Yk0L1nJSlB3EO5tZs5NpP3XOLk8ZqtjaBbm+LI0YG8+J7b
 VdEX3Yz2lJDpPVMi9krmqZIcW+qlGPm1c8I9KGpWu3zPp9wVk2AkunX22a3cokAHhjCm
 JGB+q5ZZlRvxxjmVfFi2Tf/cTrGM1ur41tDyjBDNMVERqU/RQ61ixpa+pAAlC9tUfbeJ
 ua/Y6VthRdJxJX+aogGj57GM0eYXs5fE8hKRbEV1ozI3mCWrZJ+eTeK0bG5HgtgX5fV4
 ZZJnMhf0EXnx5BYLnaecKVSFXjAOjkiOaOdqqeNi6zbzLEcHbLXBnnw89dOrhKhmHfZi
 /55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781231753; x=1781836553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YLiT7oE05AMahAIojH+9OhT9gPhIkKYYd19DmN64vXw=;
 b=PnonLkFOm1RT3YumNnWS77CLC6C1D6IOLzJlpw+/6ahsGt29yOYaua2lYT7uKYQh8X
 JH545LNElkUIH0ndzj5Gdy9EYVwxnXJkLxP3sdxXwNOKLtmbsprQC5j4cOV/nBvpjTUg
 hhtrqVNeGKHjWNh7b6yMKDFx84Q3ADUZBp/FsJl9EVJ5UqMP/HShdSssC5KzKkTJnyRR
 tyOwotJPFH1K/QnULWpU/GiPkxKcTwA29/kTfxwC536pg1u4qiRAHTmiDPFVFn22cZgl
 SjZGe6/w2yEON0aEXEpZmk9OsTRqOZILjJI8LG3YZ0fT7mw1I8j8/FdCypI4YUZXhNyU
 QPUg==
X-Gm-Message-State: AOJu0YxvMzcefbhOt5oCBP+Bxo7hLrUIjIMVcNWDevOUx7ROA/+Yr/nX
 qViVYDfUukee43JlsPkt+R34Ucu36lYjCuYQU4b4r/gEdeQgWVZxn4Dxj7A3zU30VKg5kepyBzF
 fGlIo5qf8cX/wlsHEeoE8RJjopB4FPHE=
X-Gm-Gg: Acq92OF8H1CHwL85PP3QMubF6+Ir3KfRqz4qLalbuVIZ+QwfnIPFSZS3ycTBxGXA6Pb
 elIbIo8NvRuYB2SLWqywCFTf598ahAUxwWdGQdAciOfrC6P+abAL9ILfc6SAc4dKIvER1gGlx/H
 hP7vgWlM30A6+U8jB+XN/gFyl1LvPf4t9AKiH8uZyMOyzP/xY+M+joPb5pEx2qRUERKOZWbzYAZ
 FcT2Zu1fcrOdt5Gf4BtC+HAPoer62PNme0LBN9ae35/x5S3vJtbwp+y1FmYpsGxCxZzbh2s28DA
 8gte4A5Xh9kEJKb+wNt+uQOB+L0XR66k4FLZjw==
X-Received: by 2002:a05:6402:434b:b0:68b:d10a:a490 with SMTP id
 4fb4d7f45d1cf-69378a103admr239871a12.13.1781231753184; Thu, 11 Jun 2026
 19:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260518072239.16293-1-jay.chang@sifive.com>
In-Reply-To: <20260518072239.16293-1-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 12 Jun 2026 12:35:26 +1000
X-Gm-Features: AVVi8CfPvakwsWlI8DzOvl1cdQV2f8pzb9oAEbs6bfRX-89rZxT7EqrMrKJXkII
Message-ID: <CAKmqyKPGywH7wB-KVHEOnFrM-74=6BpqA=c6V28nz+imER=3sQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Don't insert DDT cache in Bare mode
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
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

On Mon, May 18, 2026 at 5:24=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wr=
ote:
>
> When IOMMU is in Bare mode, DDT (Device Directory Table) lookup is not
> performed. This series fixes two issues:
>
> 1. Avoid inserting unnecessary DDT cache entries in Bare mode
> 2. Properly free Bare mode contexts to prevent memory leaks
>
> Change V2
>   Rebase riscv-to-apply.next
>
> Jay Chang (2):
>   hw/riscv: Don't insert DDT cache in Bare mode
>   hw/riscv: Refactor riscv_iommu_ctx_put() for Bare mode handling

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/riscv/riscv-iommu.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
>
> --
> 2.48.1
>
>

