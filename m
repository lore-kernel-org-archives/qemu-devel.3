Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B06C25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 09:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCbya-0006bv-Rw; Thu, 30 May 2024 05:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sCbyZ-0006bD-6q
 for qemu-devel@nongnu.org; Thu, 30 May 2024 05:21:35 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sCbyX-0004mp-1h
 for qemu-devel@nongnu.org; Thu, 30 May 2024 05:21:34 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f4a5344ec7so4945455ad.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 02:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1717060891; x=1717665691; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QIbHu3Kdqvk8YcJ4y5r4cxdsFNVnkXC+egIcYodGTY0=;
 b=WXfFla8wvvFh5lscj31h7VeicmKU+O8F+6qPfaEFvb2KwTEjaChvOtvjD6nsJQSr1H
 3y9WXumKo7EKpdMTHEigEH5KKowx51Xpha8r/O07L3WiGyhYCOiTLbNhanwWe4YhoXFb
 lkRSk9sachQ93jFot6kvLY3hC1Xx6b5wL9azHRlCMvWIsUvUBKFtcBBwA3/GTIvGO5MD
 N6g8gG7zE88IBnotumQ95YXfQjJM27i+N3bCC8xYVZEFVZMdw0VV5JxN/wJ7cR+Z77Hv
 zMufRcHP2+GHKxyPQSOaTs8gSwPjlE1Axj8wZUJH4b5zLqu7bR0PmSGHvST1CdrVEgN/
 KBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717060891; x=1717665691;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QIbHu3Kdqvk8YcJ4y5r4cxdsFNVnkXC+egIcYodGTY0=;
 b=cPjJAw8IDJrJysCGRYqIHHBoV+GdXH42dxGPphUhBcc13Nl74rqoIOPEENLs3wwCTp
 IyoEtK/XkczY5QrL6x9U757E9z2lSlq7l4u5gi9Ox15PO5EbIiDhM8S7AKdXvMsCGSX2
 XNj2bjS999Bo7Rk7bvURAI/4oOvK9AOCkM0jajurZRnrgNrK5BnqIrDTdZLE6CP2dvBh
 Ql857yjnKmgyXyA98AdZWLvQtpvZfUGeZA+72BhimEqaXkvcs3x753P82tAPIESW3mjt
 Fg/U+JXM6/PTF6GWlSjKjOESyAFmhJBUqY76PK4cfabgeIljpwawJ9Z8yAQYd6EQOpbe
 97tw==
X-Gm-Message-State: AOJu0YyjfIk+dHBN235p7a4BUw2GzO4a8NUuOnrxnXVH7829SQMzvOCn
 k1mFz6BTH/agG54TSVAONRcrrqy0LTVFNZYTzXS4moOCTWmDpLYoAI28fJ5oVcQ=
X-Google-Smtp-Source: AGHT+IH3i0I8/ut3w7JOQcz3tJuhZoXMc8sK1IEYXrmnOJ0mhsFR6T6k7ezqb/MGN1gIbFr8bAvHDQ==
X-Received: by 2002:a17:903:183:b0:1f4:9b48:7561 with SMTP id
 d9443c01a7336-1f61bddd04amr21028245ad.6.1717060891357; 
 Thu, 30 May 2024 02:21:31 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46dca2529sm94359215ad.247.2024.05.30.02.21.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 02:21:31 -0700 (PDT)
Message-ID: <712bb03a-688a-45d5-bb25-620f4af956e9@ventanamicro.com>
Date: Thu, 30 May 2024 06:21:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 0/5] target/riscv: Support RISC-V privilege 1.13
 spec
To: Fea Wang <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240515080605.2675399-1-fea.wang@sifive.com>
 <4d2d56aa-5758-4320-a5ef-53ebb87ab494@ventanamicro.com>
 <CAKhCfseJgRzyeg1seuZ15SR=f78E5rnbgfrzY_VeRDhPMOAhwA@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAKhCfseJgRzyeg1seuZ15SR=f78E5rnbgfrzY_VeRDhPMOAhwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Fea,

On 5/30/24 00:30, Fea Wang wrote:
> Hi Daniel,
> thank you for your help.
> 
> I found that only the cover is without many maintainers. I used to send patches by git send-email --dry-run --to 'qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>,qemu-riscv@nongnu.org <mailto:qemu-riscv@nongnu.org>' --cc-cmd='scripts/get_maintainer.pl <http://get_maintainer.pl> -i' patches/*. Do you have a better script for me?

Hmmm no I don't actually :) my script is worse than yours. I just use a git
alias that hardcode everyone in the CC:

	askreview-riscv = send-email --suppress-cc=sob --to qemu-devel@nongnu.org \
		--cc qemu-riscv@nongnu.org \
		--cc (everyone from the output of get_maintainers.pl for RISC-V files)

And then "git askreview-riscv (patches)"

 From reading git docs it seems like one detail with your script is that the CC
is calculated patch by patch via the "--cc-cmd" output, but the cover letter is
considered an empty commit, so the script returns nothing. This is why every
other patch has a CC but the cover doesn't.

This is more a get_maintainer.pl detail than anything, so don't worry about it.
Having the patches properly CCed is enough. We'll go after the cover-letter
manually if needed.


Thanks,

Daniel


> Thank you.
> 
> Sincerely,
> Fea
> 
> On Mon, May 27, 2024 at 5:21 PM Daniel Henrique Barboza <dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com>> wrote:
> 
>     Fea,
> 
>     Please try to also add all RISC-V QEMU maintainers and reviewers when sending
>     patches. It will get your patches reviewed and queued faster. Otherwise the
>     maintainers can miss you your series due to high ML traffic.
> 
>     You can fetch who you want to CC using the get_maintainer.pl <http://get_maintainer.pl> script with the
>     patch files or any source file in particular, e.g.:
> 
>     $ ./scripts/get_maintainer.pl <http://get_maintainer.pl> -f target/riscv/cpu.c
>     Palmer Dabbelt <palmer@dabbelt.com <mailto:palmer@dabbelt.com>> (supporter:RISC-V TCG CPUs)
>     Alistair Francis <alistair.francis@wdc.com <mailto:alistair.francis@wdc.com>> (supporter:RISC-V TCG CPUs)
>     Bin Meng <bmeng.cn@gmail.com <mailto:bmeng.cn@gmail.com>> (supporter:RISC-V TCG CPUs)
>     Weiwei Li <liwei1518@gmail.com <mailto:liwei1518@gmail.com>> (reviewer:RISC-V TCG CPUs)
>     Daniel Henrique Barboza <dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com>> (reviewer:RISC-V TCG CPUs)
>     Liu Zhiwei <zhiwei_liu@linux.alibaba.com <mailto:zhiwei_liu@linux.alibaba.com>> (reviewer:RISC-V TCG CPUs)
>     qemu-riscv@nongnu.org <mailto:qemu-riscv@nongnu.org> (open list:RISC-V TCG CPUs)
>     qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org> (open list:All patches CC here)
> 
> 
>     I added the extra folk in the CC for this reply so don't worry about it.
> 
> 
>     Alistair, please queue this series. It's already fully acked and I would like to add
>     some bits on top of the priv_spec 1.13 support.
> 
> 
>     Thanks,
> 
> 
>     Daniel
> 
>     On 5/15/24 05:05, Fea.Wang wrote:
>      > Based on the change log for the RISC-V privilege 1.13 spec, add the
>      > support for ss1p13.
>      >
>      > Ref:https://github.com/riscv/riscv-isa-manual/blob/a7d93c9/src/priv-preface.adoc?plain=1#L40-L72 <https://github.com/riscv/riscv-isa-manual/blob/a7d93c9/src/priv-preface.adoc?plain=1#L40-L72>
>      >
>      > Lists what to do without clarification or document format.
>      > * Redefined misa.MXL to be read-only, making MXLEN a constant.(Skip, implementation ignored)
>      > * Added the constraint that SXLEN≥UXLEN.(Skip, implementation ignored)
>      > * Defined the misa.V field to reflect that the V extension has been implemented.(Skip, existed)
>      > * Defined the RV32-only medelegh and hedelegh CSRs.(Done in these patches)
>      > * Defined the misaligned atomicity granule PMA, superseding the proposed Zam extension..(Skip, implementation ignored)
>      > * Allocated interrupt 13 for Sscofpmf LCOFI interrupt.(Skip, existed)
>      > * Defined hardware error and software check exception codes.(Done in these patches)
>      > * Specified synchronization requirements when changing the PBMTE fields in menvcfg and henvcfg.(Skip, implementation ignored)
>      > * Incorporated Svade and Svadu extension specifications.(Skip, existed)
>      >
>      >
>      > Fea.Wang (4):
>      >    target/riscv: Support the version for ss1p13
>      >    target/riscv: Add 'P1P13' bit in SMSTATEEN0
>      >    target/riscv: Add MEDELEGH, HEDELEGH csrs for RV32
>      >    target/riscv: Reserve exception codes for sw-check and hw-err
>      >
>      > Jim Shu (1):
>      >    target/riscv: Reuse the conversion function of priv_spec
>      >
>      >   target/riscv/cpu.c         |  8 ++++++--
>      >   target/riscv/cpu.h         |  5 ++++-
>      >   target/riscv/cpu_bits.h    |  5 +++++
>      >   target/riscv/cpu_cfg.h     |  1 +
>      >   target/riscv/csr.c         | 39 ++++++++++++++++++++++++++++++++++++++
>      >   target/riscv/tcg/tcg-cpu.c | 17 ++++++++---------
>      >   6 files changed, 63 insertions(+), 12 deletions(-)
>      >
> 

