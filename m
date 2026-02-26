Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECC1FD8FE8
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 17:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvfXn-0008UX-Ab; Thu, 26 Feb 2026 12:52:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvfXm-0008Tx-Cy
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:52:58 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvfXk-00006S-P6
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:52:58 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64ad79dfb6eso1385032d50.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 09:52:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772128375; cv=none;
 d=google.com; s=arc-20240605;
 b=RVX8O5fFC5CbWSjJW7QIB88q/rYzXMn9zdxJWUDnfNzpO0TlUZEw8Vr2jFJYq3U+st
 F8k5SN/O0JcJtvFawHQF20SFOd68krEZKH8OlUgPFi/1x0r4hOwxVhSFqPTooedaKxgc
 lVgewH+f6p7BlNaHiwoGTqddeaz/wfbuvo+B1hPFWIqqv8N5EdTyLVPm1iZWOJGnVUne
 zoLjNZSeLIgCgLHu+kQSWo0IkZr5uoJmv53+bAoyyxNl1TkUZhdF8p2naTYdiNlmjqAF
 ollDqNBR83zl0WwbLzoRYivp0mWcT+zO5XPqrLVQiO/x9MSxu2u4OpTPduEkRKThMm+A
 g+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=M/pwktj3KPpdz9iZXI87w+qmV43T3TeON1Um6f5U9dM=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=ZQ50kq5EX/hPvM81I3mi2NGABLbgxYw8kB/SI9S98jBa5uga+1hSoQxISMks2+DCv2
 zaCgljuan0gZPcm7Awqr/r64zavMAHVOw6SBdvaRrikuVzHEpo/sLVPqElQBp96HKVQL
 GTvtmk/Vw+rBnb7VmvEqpFD4e7Ik5nzUPkYD7BwdX8ixs3k37nC+c5UL4wRKGy7lEG7M
 as6gpF5xUd2AMQGt7zK+4HT23QUvSkotdQECNwsjm7xYyEGzMszF1UyCUT91SRJABIF1
 wH4fmZZpkrItiptG14AUesIpcDuC/Jdc2iN7z5zTxlh16KlQZFmYpwzJePbnoDRn3KZg
 mzLg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772128375; x=1772733175; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M/pwktj3KPpdz9iZXI87w+qmV43T3TeON1Um6f5U9dM=;
 b=G0h6pXKnF+BL/qe6mBEjc+vjWXgDfE6MYvHwef8bYpT83qVGjfGjE4stiGUBHDPJbn
 +uZ9jAHEyc2lmr3kUeAZ2dDiqTjjsaPooATt/0HWIhlffLfwVa0apzFTcfrfNAk1zyRh
 B0uFadObL/jvs870lJPv3H6yh2RVgkCd3jMs8YdKwPHlKQac/S5Gqmzuly2oWP4tnwd1
 gVzkLaAInPTpdg3wWhRxsEvmisCIseUGvpLhpj/D5+p2aa8PqOqbGIUfQh4DumQAIQso
 i+EfyijM6FlwGnm4ZhQDyfq6S0n5T9k3wde4c620I0jrb1LJhxv2+tn2GwU1cj8W5GUi
 fzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772128375; x=1772733175;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M/pwktj3KPpdz9iZXI87w+qmV43T3TeON1Um6f5U9dM=;
 b=ET1gdC6QP9MHm/HCS2cFqAzPpi13zKWNVb5IGpEd8VOlMlx0npwDnPIv71i8szytEM
 M6DJLtBUjgH8cURppn7h3dG7pujOVBeSNwziCN/hTmdmh488KTstdXnHZZliUCZlV6cg
 /xqUwzXxwoChimiGd6U55M6C2LQbUoWTrjOYB7kuUsLWxO5vViDBxL+YJHi++ytmhfgg
 cfqsywMG+sy9Z3m+XhoCIcmpb5aEWfxdlaktV4FKDtqjexoGcmJ3O6FlGQe/Ourb1ddN
 NgvypD1Uafz3i/4DksKJQHYNOhxP0MRP8T77OE+p3ZvfARYWhK9CpkTHXeeEbhAQI1Xl
 /FnA==
X-Gm-Message-State: AOJu0Yw92IWZLl/4M7F9gKqHHjNBpjcXmX4bnKRRrMIOSjzrYgUdfRPW
 3bQrdpIxVOvyHDlkDiKgT4FJWCyIPN8hxl0HKSMyHqZGUU7Ue+79Kd+FZXlkOp/7WUPuj2dJWtI
 z3cSDdw+sicGYvnRGxk+ORvKAYkbDv/JkZAJhe6uLBtmwLNnNMNap
X-Gm-Gg: ATEYQzybC1N2vDJ0I4ScARTVlFrj7VO9xqJVXLsNCiUPrbhlbkCdJVbZ4ZBHKVxK/X6
 zEx4iWIq0gXgFkgvlAseMblrztp8cIRsBdTKeAJnZnkuhYO8dKgmZSeam0RyAeYxc/tX91frtcw
 Jh7Wg0KW1pMc8Q6HJztozRUD0JIhXfJud5aHYCVi+i8HWsnNPTGdTHbPsiWNA8CgEC2ndGuo1bf
 3qXPir/6eyLBJ4/rwGCsW/im/4q5H7FH7uESTS5noNKAAdwwgU1+knuLcH9hqoRGP3DA6mPJa4j
 ynxwT2cBIrmWzk1wxuNiuFBfmUnvAjtjNspRerP3cXwnjimzdsfcwo6VjGGJfFSagtY=
X-Received: by 2002:a53:bbcc:0:b0:649:b6b1:84aa with SMTP id
 956f58d0204a3-64cc2302f0emr81646d50.78.1772128375188; Thu, 26 Feb 2026
 09:52:55 -0800 (PST)
MIME-Version: 1.0
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Feb 2026 17:52:44 +0000
X-Gm-Features: AaiRm53u5jCioqLS12ME25YxIQmkLtvHPML-zfbd_BysI9IKJksaq3ZZar_vwCE
Message-ID: <CAFEAcA8QcRkYM3dKHgB1dtvZxN69Tzx8J-4rM8Mg2GvUKqAizg@mail.gmail.com>
Subject: Re: [PULL 00/20] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 26 Feb 2026 at 15:55, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit 7390b0825b8e041a961f6215a18fa68213dc4779:
>
>   Merge tag 'single-binary-20260226' of https://github.com/philmd/qemu into staging (2026-02-26 09:33:12 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260226
>
> for you to fetch changes up to 907b8d56351b1ba6c97953edaca6a08f02fa2048:
>
>   hw/char/pl011: Only log "data written to disabled UART" once (2026-02-26 11:27:19 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * target/arm: set the correct TI bits for WFIT traps
>  * target/arm: Refactorings preparatory to KVM SME support
>  * target/arm/kvm: Don't free migration-blocker reason on failure
>  * target/arm/kvm: add kvm-psci-version vcpu property
>  * Revert "target/arm/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0"
>  * hw/arm/virt: Add virtio-mmio-transports property
>  * hw/arm/virt: Update error message for bad gic-version option
>  * hw/cpu: Build a15mpcore.c once as common object
>  * hw/misc/allwinner-cpucfg: Remove use of ARM_CPU() cast macro
>  * hw/ssi/xilinx_spips: Reset TX FIFO in reset
>  * hw/char/pl011: Only log "data written to disabled UART" once
>  * tests/functional: Make sure test case .py files are executable
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

