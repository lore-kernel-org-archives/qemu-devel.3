Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AFACD98F0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 01:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbT93-0006vk-5c; Sun, 21 Jun 2026 21:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbT92-0006va-AD
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 21:08:12 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbT8z-00051m-GN
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 21:08:12 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-697764213d6so2905573a12.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 18:08:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782090487; cv=none;
 d=google.com; s=arc-20240605;
 b=RBPaTS43h2srDxvv34AMj8vdAnf2hdm0wcIHKAOZX6rsScPTLu/PxNvUTjFiLaEBxx
 O7YAnJmk4l/RrzDkYYFVj/3NMOT9ZBzhyhjJ8uQBiIydcjElSE1qNPahcB1LKqL3c+Mb
 /QWMCK8smt08WtyLTV8XHv18BsfCxO6foWWLi1jqCvlF+zs29Exbn6fbqmLdrCNEbqQh
 WTlqMM5kxw3w0dO0fAaDk9gSI+dPOOKEOCxeYald9Pite8Xj+1HfJX1Pfb7OLoNfecCq
 5hPX+DldQVlz3O97Dka7f/B8e3FCNiizwrjmgrNXkSa6ofK1hozBFgra0/MWcT071Pqr
 xYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sNodhsPSoYCVVYVH8wDldbY0IH1E8gorxJFk2aDbIRY=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=ZpevQETpp4X7/bg4luJB7b6l5I09SrCwAEIosjC+AnMACRrgAOGmEjBhKa3jh49ca+
 apOLns3CtFKTXxjErbtWVIpkT98xAobPlAolGXpu0JkypQdo4PeNGEorRO87xhkLh3d0
 k9aIIFqGHEIkWaXPuH7/ivn75/11lcui8YCJlO/jZxEy7da9KNEV7amd38WpHVJDvUhS
 KplOka5agrihD4unhddCpln6jwEB/I2VH6CcgRVmke3yjzOW9NDleTMtus42mDu27Xlw
 NDN/VP2U89x9uS6+DUq+OI567OkppOnBP1jHEXWuJlEmjY0k09m9Mnd/exxVEF1TXls4
 1NAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782090487; x=1782695287; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNodhsPSoYCVVYVH8wDldbY0IH1E8gorxJFk2aDbIRY=;
 b=VV73X4VLyErJ84JdSk7rSodvYMeH2qLCAxthiwiKu3Rcjdpjv/jwWa68pip4ULV+7o
 j6FlTcquhzQdu8XE5fBnO6Zd+al0T6/zXP9XUGkbvcd1nIDQ6D5eEe4DPPPg2Up0xppN
 T+S5bFuEVPL0M6Azcqs1rmd2kJlOoVQ5hoRfZOZ8GjUaRWvHi3Qt0lLDl1JEnBbLlEsT
 QTcqS8PQzvnReh03KFwBqWGfdo82QdnvjVx1IIkhY94STtSbDoy9AHLcMNEUJr14lMjJ
 5chSFKZUKysmTuJDMpL/8qS2DbD6hpyvzzNZaToOd51nvxn6CKZEzI6jHYuBMUj87H4c
 7snA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782090487; x=1782695287;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sNodhsPSoYCVVYVH8wDldbY0IH1E8gorxJFk2aDbIRY=;
 b=r780I1VgBfaff3iXyiB6v3a9q5uGRDi4MlgjuhxAVkVRYAFHplPPLYuXBfp6C56sYJ
 aDrJn/gxXK1jB854ovA9NxbKDXyWd05uPFa0KM7kVAZZoBAH89hoPQ+bRmumTNDTfVLL
 17a5G+6K+5MQnSJpxAyfr5Xj3d7tlpwk2yk+hfwBOPy2zXZD1FLGzZ+Z3XCQJ9WIOITh
 he0H/N8M9YztKTeC/LCvgcIP+HGiqR3+2FCXcv5LG3uIdK3xXnmlc7p99H4V+j3y5tLb
 bOdFcF+2q/RfpZvTUDflBxtXYRXhczEMwz/+WUglawrepj6LBQD0Z/kXDOgohNNDAnQI
 zCvg==
X-Gm-Message-State: AOJu0Yz8QOzq8whSCETAk9sxYZEXVgli9MbNr1IYcFn9erFtJa20TUwc
 pkz8MJD8mFVhwk8/qFfKigw+qP0qG6KJgIfdZeeZxHBsqGQL4YwmZi0YLthW0cDiWK5E2Xj4W30
 u9fJYrGAWlYxNpUpICMxDIwo+BI2BtVw=
X-Gm-Gg: AfdE7clvT6edzNLktV/Muz+LC0eJblgs0BLUu6ak3ZgQmJAXEH0s1GNL1sZLS1pUZ3h
 os7prn/kbpJbon4AtyLf/53f00zD+s1/oqzirYFbhcQYkHZ3/83pNVol5fgkjA+LuT6lswqEGuL
 xsYyeQk0KLw27TWuS+cktzkLfeiPQqtncEF7GrnB/g4wuNt4Oq24T8fja6+8DM+ozC2WVWyt+Jy
 W5Rn4hNetHeUFeRD0bdw9o5Jclt5q78TU3A9uwsEJi0zBK8kox6okIcFnsi/dLwWLCNOExl74Pc
 Qye22X07RdR8Cu/nJzKxu5H+usA=
X-Received: by 2002:a05:6402:358d:b0:697:7f6a:cf55 with SMTP id
 4fb4d7f45d1cf-6977f6ad063mr3646439a12.26.1782090487321; Sun, 21 Jun 2026
 18:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260617131710.1855353-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260617131710.1855353-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 11:07:40 +1000
X-Gm-Features: AVVi8CdLeqlr5yAhh3mHUqfjdXKHsdh-lA9c9YLubCBvngSrYDuayA6j5QfA8tI
Message-ID: <CAKmqyKPAuQhfZxjY_80AQyPMHjqrpS0soQ4cmxDaGvC5HU9YVQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] target/riscv: parametrize debug trigger number
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
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

On Wed, Jun 17, 2026 at 11:18=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Hi,
>
> This is a re-send after rebase with current master after the recent
> RISC-V PR got merged.  No other changes made.
>
> Changes from v4:
> - rebased to 'master'
> - v3 link: https://lore.kernel.org/qemu-devel/20260611123412.2135600-1-da=
niel.barboza@oss.qualcomm.com/
>
> Daniel Henrique Barboza (3):
>   target/riscv/cpu: add CPU unrealize callback
>   target/riscv: dynamic alloc of debug trigger arrays
>   target/riscv: add 'num-triggers' debug property

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c     | 26 ++++++++++++++++++++++++
>  target/riscv/cpu.h     | 39 ++++++++++++++++++++++++++++-------
>  target/riscv/csr.c     |  2 +-
>  target/riscv/debug.c   | 46 ++++++++++++++++++++++++++++++++++--------
>  target/riscv/debug.h   |  1 +
>  target/riscv/machine.c | 16 ++++++++++-----
>  6 files changed, 109 insertions(+), 21 deletions(-)
>
> --
> 2.43.0
>
>

