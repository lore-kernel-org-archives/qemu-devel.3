Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CCECD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqBC-0002tQ-47; Mon, 18 May 2026 01:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOqAn-0002sY-JB
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:05:51 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOqAl-0004ky-8q
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:05:48 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-67f7caa33easo3923843a12.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:05:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779080745; cv=none;
 d=google.com; s=arc-20240605;
 b=APsdLetBw5Mek55pc0zKEo8beYYb+Qo8k5NZLyyKcnEKCpvR9NDJlwwyCjHk+L1Oi+
 wuJKtcIcF966Gb1nKEI39Hlt4ZfGgU77+xAvZHEm22MEhIp2Xba5dX/b0tKwfAPBhLRF
 9zBz+GP0juywURWVWUVkSPNiLzskABqnlVdsGgrTR6BLuDmfEQBhGMLrkhapVLrcxYeb
 CSFn8H3SNUzGIQE2Qd5HSGpK1rNkaGX16l7Kaq6oCOrV677XS8raFg1/ZKnwDSbf9XlV
 4YtKE+FDtjgovqjLcwqm9dCKs2WWA/T9WR2ix+U+bazgMp/80/LZWuTpOIYx459mUZWa
 YSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T6YtyFlKjaCEj+GtDXCk5hFK8cgIsyn2oi5Ayb2Wpvo=;
 fh=KxFgLvB8QpbaNzAHYkYnodH8BxFTJmWAX/wpmrbktoY=;
 b=jhUWT1Zr4VOx05gWdvuqyuzngWh2jQRbxS6/yLarrXVYMfrNvqvSqXgd2B7ZlRug/j
 45bnesUhbcFzYrDxM4oUzt7DpeytUiYRJ2DrHNMxj5yi//NAwq1AnoDBRPMlSEhl4PX6
 krtj06fk/J4GW58YRFEKrPmPlFV83i8BUrclhgF4lh6W8bg3VD4N405vffLN/9u/aGpr
 uVueIsIjFpBwiNEJAZyn1kqbYwtiv08sgLf1qzLfvcATAT3jhOJHJIUg4MJp08uU00UV
 uHsPvu/N0XrxacCz+5L3XBtKA5qU6MB2HK1kSezxMl5qg+lhJpNYlzh0NkDgQnQVvqTd
 +KKg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779080745; x=1779685545; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T6YtyFlKjaCEj+GtDXCk5hFK8cgIsyn2oi5Ayb2Wpvo=;
 b=bIKxnYgEOept5NWKkqGPCthmnj7CBn9HBYPcpfHDtZk8gP0VfNBkAel3NPfz9g89yf
 Oh59rg73nAD+0fgKrSbLiJMH5W2Zc2WHSnGKVfkfGpx8IrrNhVDvBi2pZqGD0O/rJXec
 3KjQeR/6BTOgOHKtI+vObOotSUxYtRqbsYL43i+aEQM/Wrqy/z/RVtyH+zIdXFeFHaUH
 mPmBm3SyrvICxTc/ZxIPKe26JrYf6zYBFyPdQl4sj7Np4ImmGIPC4ppa2hKVfHegtsln
 ecvLy9/6ls6ZL2ddPozGzbzsrEGCsvUnKqasedi3FQNFtbV4n6hgyX8aSwPMlZgz+tAX
 b44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779080745; x=1779685545;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T6YtyFlKjaCEj+GtDXCk5hFK8cgIsyn2oi5Ayb2Wpvo=;
 b=tT4ebADJVsnIr0hjXIqcMnSoOf/VuBEfPNQGA3vz9ABU1jFvl9xt7gbLrB2uz5rMPk
 ygEdC9g8I5sBADpEcEwd7lpCVXnsHEjJptcs70yYHm5/JxqqQzYIskdkawzUBMxR2waW
 dZDprv8qERy+URdQBhGW/VJgzdj/H64bLZygQliDBXVeyZFa30PZ9Dcu00g/hac8SgLH
 D9PzE8RLbYCVQ7uMBb5MBxqKvaftmOD9EZTQgCzXWB8xaaHNmE6fgbcqAlySE2wlkg3i
 CusX8P+CE3qZdtYImsJHUScCGJLbRgVA1R4CBV46Z/v/NYO41b6+hE8rE37lsmsfWyHV
 4nzw==
X-Gm-Message-State: AOJu0YwRW7jAnAUuBoCI8OsPkaA1rCFsDmbBVng5dIY0/sifI0wG6QD1
 Mh1il4zaU2JnmooXkhmfTMtiym20TB2r6GnBE8qJ//2+zICOEj1D6vacE0L1zCXsesSE8bIV60D
 mdp11FSwzNh1DzkfXUBPyi9zhGt5KbAo=
X-Gm-Gg: Acq92OH190IRkN17fr05dIKWcM/x5HWjQ2HVXZWMv2NvCAb3/yjyY/3nRnoX9aDmxPk
 dTaIozrfDHUkeWcbHF1hryl6e/RI5hUuINhL4Bd2ad9fwJYv65ZQmGjvCD0l3CfIO4ulHNwrceT
 MDHeKA4Uqe3S14oretZ2T1QggN9SJ3s+hyIBHo1bUgVWEQszIrJm9y2E9jIPTC1ZRdA9trRexZ7
 F6W2EXni07cxzH1fjKQ6k39pX2rnKsX/AzYGV/VTZ0PVyDuKgtm8kWVem4s0BUFFWQkOWNnhp14
 nQ3oog2lSpVV4KfET/ETn9vH1XisyJP6bbcL/A==
X-Received: by 2002:a17:907:6d04:b0:b97:1d24:c004 with SMTP id
 a640c23a62f3a-bd517860e1dmr668866466b.21.1779080744784; Sun, 17 May 2026
 22:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20251211025611.99038-1-jay.chang@sifive.com>
 <CACNNAjNV-ffHE_Vs7BOkgC-ff+j4+uz8tX9Zi2xGfPuLfbKdpQ@mail.gmail.com>
In-Reply-To: <CACNNAjNV-ffHE_Vs7BOkgC-ff+j4+uz8tX9Zi2xGfPuLfbKdpQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 15:05:18 +1000
X-Gm-Features: AVHnY4LxV4wFrwG5t0UfEA8Crt2GSTQTRHWRFtA8Pg5EIbVqz7bD2Hh6_EdoM5g
Message-ID: <CAKmqyKOW71u1pB+13m5FZ10FFrtW2nbdAiOe8SkQH6XUv8BW+Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Don't insert DDT cache in Bare mode
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Mon, May 18, 2026 at 12:38=E2=80=AFPM Jay Chang <jay.chang@sifive.com> w=
rote:
>
> Hi,
>
> Gentle ping on this patch.

Can you please resend the series, I lost this the first time around

Alistair

>
> Thanks,
> Jay Chang
>
> On Thu, Dec 11, 2025 at 10:56=E2=80=AFAM Jay Chang <jay.chang@sifive.com>=
 wrote:
>>
>> When IOMMU is in Bare mode, DDT (Device Directory Table) lookup is not
>> performed. This series fixes two issues:
>>
>> 1. Avoid inserting unnecessary DDT cache entries in Bare mode
>> 2. Properly free Bare mode contexts to prevent memory leaks
>>
>> Jay Chang (2):
>>   hw/riscv: Don't insert DDT cache in Bare mode
>>   hw/riscv: Refactor riscv_iommu_ctx_put() for Bare mode handling
>>
>>  hw/riscv/riscv-iommu.c | 34 +++++++++++++++++++++++++---------
>>  1 file changed, 25 insertions(+), 9 deletions(-)
>>
>> --
>> 2.48.1
>>

