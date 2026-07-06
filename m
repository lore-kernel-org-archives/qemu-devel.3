Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F26C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 02:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgYgT-0005JS-Qo; Sun, 05 Jul 2026 22:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgYgM-0005J3-0A
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 22:03:38 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgYgK-0001T2-FQ
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 22:03:37 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-698b899b4c8so2178775a12.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 19:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783303414; cv=none;
 d=google.com; s=arc-20260327;
 b=eyNxeplGc5XQR37kxzgqPaG2NuCjXqcX5ge2AdizDylpE00nIUMnjFhKTjHWrzZR2d
 O6MmFio5kcVJjW5JcSBrR+1WV+y3j335USyqZGQ3Mc9GpvCrm4aKak7g9dcqBI/rdBK7
 3lIvkxbA7TZHm5OlRhO14okTHVl6KvMc8eGDJ1LeCIZA8CgRupa5O7GYiWDLfYMclcoX
 CKRtiPOmJl1T75Djxl4sfQGApkupioGjRKwIF+anCUegjBhLp2cmYF+vk/hGXNun3lbf
 KnI8dczOPk4w40wtT2DFxGJtcMIc5HD7M6Q9zUjcnhNm2lUZSCyCHMu2qHSmXV3JjUbb
 DaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cox4sR+7xsstieoFliuFvYqO+sAAaOQnZ9XxVg9v7Ds=;
 fh=MnNJvVdo/5nyIBFwY9JvsPpUstdtIQAX4imftEC7M30=;
 b=Q9XgLgReIDt9/nKaRand7v2vlLrvBajOK8+oCEERP50gIrBvHWPEwaBvwik8OalgIQ
 FVvgeZvY+gqNtVKtLytIMyq+imM0B0ngFxA9IxTkmou4MHwBVtJYGLmRp2mtXZQSZYtu
 CKZu/p8Ido6YNnGFdS1xPgb26jtH9sTMxYpcwb1IGK6LO72sWAeRWrxH6FxomrKajMlh
 7SMBb4y8+sXvs/Fsgvqm1wESgZ3s2eaTOCHF6S7un7+mdBRodSGv7IOZ8r3/f309YrE0
 W0VYM8OhL3HNsrhODK59okczDJCMkpabueVoPWV4riHDhxSg+AZDmGW/dD7vZZ+Fkw9t
 nWnw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783303414; x=1783908214; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cox4sR+7xsstieoFliuFvYqO+sAAaOQnZ9XxVg9v7Ds=;
 b=LRIo9zKMD8mkItjaFP2TH3rO5mNBDaBnyCgz+k5MXvJ2Y/qwhLSwIfI5dw7btE64nu
 3CqvrAADt0nkPguW/yhJdAIJmq0BZJMaxjAqoE62LQ2Axt9NeHzQKGwfAKDX0W/bli+G
 +L4oSJw6VBK6yLRYrYa1D68Y5EuYr7pGEaK0mrGbbqknpt+x123qQ4/YpipDgC1uzgh9
 TA5dX5VR/0eJ4BIC6fU32kflmSbx75XnSN7UI7KibFGJ3IEkrm9LZvbjAUlNOpAq7+xv
 Q6+9+4d4EBR9oQLKILSiIH+/0xD4Bi61CLmuqyz/bw0TLLm2ae8xCpqeHDlFZ18NtyWL
 wX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783303414; x=1783908214;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cox4sR+7xsstieoFliuFvYqO+sAAaOQnZ9XxVg9v7Ds=;
 b=ZBDfcLTrANpN7GiC/4QL6uj5zG7F9qU7jX9Eo1wOCg+AZcdhjNBIemEaRp0FkNsIuc
 UMWAGzlxgU9HLDXOHMkPABQYrjokj1OLIxfoFNAbJ+YxmSVLHi1HACGHZvqZsHGaSS2E
 8tBR9lf6qNN8uc1/FzOOE75SzX6zMNedT0GGOAwjYOH84+my4RDvzmO0VrfTLLc71e3l
 SE/3GPllO6ZQB/3cCceJsAcqk2O23VvBBNRra/K4u7YfjcNk26WMkg3UMqFohhmt0Clq
 5V0NajGKmh7tKFzpyquFnKEEt/fAYrNaagYJqQTE5LET2lXZg5jKZvrz+7yRzMC+7Tns
 eIOQ==
X-Gm-Message-State: AOJu0YwHEipWOzVkE9M/HvRaZvN8QTo7EcxQkCj8Kz4a1zLS4YKKiVpg
 PFagFPg60fHu/iPiuKVe2XcPtfZUBnlTyJWEusMptOt1SkxsFeFJgPkmUCeVazm+wJW0sJFXo7s
 clUAcYg7smnaAj6k50ynhWMbDZDPVn+A=
X-Gm-Gg: AfdE7clnmZaS26To4YZXXET6orPDKvLjRM+/TEJBesxNVZWq6T/rxDe57Mso6l7mf/p
 nzF3FH4eQCyDnON7iMe0Va1CFL73vHCR2GQJpG5zNumTI7X0HS3OM4AeEaN4CJLOzwIjh0aadeO
 /QU7oVtQ8CuJC8meBi7IH7LFRitrnNpDf1hBW/Z4U8YtIncR6DzjGWoQOVAIK4zZgolBXSWdVAh
 luMkZjWwgfXE0oIKzdtyT/nrIII9RCW7jJheR0ewdjUvlSqnK0K0Kk9kn9x/50Uu3mcS/NGLu9c
 RdNZ7qcLz6CkAMc4ePmqJAgJ7kM=
X-Received: by 2002:a05:6402:3227:b0:698:5f89:9a51 with SMTP id
 4fb4d7f45d1cf-69a1a24beacmr3037151a12.5.1783303414439; Sun, 05 Jul 2026
 19:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260702203616.1795588-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260702203616.1795588-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 12:03:07 +1000
X-Gm-Features: AVVi8CciTkPVGCrm1jYsQaLhcKQijELG9s_cJCEcUyhl0S4DWLNf_nswaJonQho
Message-ID: <CAKmqyKMVqG7=bcUKZDuJFWxjwFvFVr6_=iGx1Apm_9c9zwu5-Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] hw/riscv/riscv-iommu.c: check for misaligned
 IOHGATP_PPN
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 nutty.liu@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
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

On Fri, Jul 3, 2026 at 6:37=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Hi,
>
> This new version fixes a blunder I made in v1 pointed by Chao and
> Nutty - I was using the PPN value, instead of the page table base
> address, to check for the 16kb alignment.
>
> We no longer need to change qos-riscv-iommu.h because now we're doing
> the right thing.
>
> Changes from v1:
> - use PPN_PHYS(iohgatp_ppn), i.e. the page table base address, to
>   check for the 16kb alignment
> - v1 link: https://lore.kernel.org/qemu-devel/20260630203155.2103084-1-da=
niel.barboza@oss.qualcomm.com/

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>
> Daniel Henrique Barboza (1):
>   hw/riscv/riscv-iommu.c: check for misaligned IOHGATP_PPN
>
>  hw/riscv/riscv-iommu.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> --
> 2.43.0
>
>

