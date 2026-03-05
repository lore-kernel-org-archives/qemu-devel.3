Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F26BF3D331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyByn-0004Br-Js; Thu, 05 Mar 2026 11:55:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyByl-0004BG-4J
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:55:15 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyByj-0003Ed-68
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:55:14 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64c9a398bc7so7790631d50.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:55:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772729711; cv=none;
 d=google.com; s=arc-20240605;
 b=Kvcyk7bZXMlwi0EO9K61fyrViAzwxW0g3M3t0yZf2iRrd5kRvm1qixGvjeIBvuQyDh
 EmFECSe5CU5xISlGEcYMwNPFSoP5ruvx2nO+qmRScrtuyHaQYkXW64BenI+rOWZPn1uX
 oGShLnSUaG2BIoWFhQ2Zl+Gb1a053vVbTyTdqjWmS5ugkuEia02PX+wc9bkDpd9CFMkh
 eC3HVADypdMj73BU7qEfGGA5iInhMKkCWmXvQFkj3IeE1yNsyRW7Nmesl/oUKlOO3xVu
 +01G/6CX8D3+St2zUfa5pZSnuGCrp956HK2sQc09OKtdKrXGEeuMzcbUjbFieZ0qxrNk
 T4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KG5tAxih9N2wv11pDQ6fn5KUPOK01pGHZ3Cg7drQanI=;
 fh=ARhkxHV/PQEXZBh9/HQAlQt8L6ixFOmgtnPvvMfpZUU=;
 b=KFYHcOKjbq7pWcv/xwuFsg0F3EbDMN93YGDySCuuLBbg68KBJhdqJqldQ+SU7ITtu2
 r3vEreUrbM3AJcyvyAYhBpNOQf9jxkR8ACn3P+CDoM5cnfTyHPZZUcG2EEarNlVSucny
 B1L4SPUQVpzsdKycf5QSI5fhXOm9CKybreLM9xhBh58xNwlf7AA9OwZOxKnMVrk3sPcH
 /h5HkDR3+hRVcjAkuZ9bX5ZEj4vemZxXEiTqBCwC12bXwgVQvEYsSfYLi85O5ZQSBOHh
 McJEqd1RKc4CZcnF+wVoWLDbOOMLyy7DZ9WBizyE5Tnlmq0E4JVuh9/+vOxJFUSHLPXy
 4Ihg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772729711; x=1773334511; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KG5tAxih9N2wv11pDQ6fn5KUPOK01pGHZ3Cg7drQanI=;
 b=ct85XuU4YUFJD8nfLLEUSmcRzC5R/umW4n6JfzOc8uZX2q75kZ+BMd/btaQSIuYmR2
 cGPJFy3CfZhbdFw9f/d881QSISZaxAwLApSzy/Wh+9Q+6j00zy/VoM9J81F1pf7UmOV8
 SmNHfGVthCgX+Dknswq74zitsjrkHRs++MRSgRc/ND/GpzT+OQM6raGn6NIK2K6D7II6
 FJ/68nXW+cLiRNTUYSIQQyw0naj2yseZSGlw926d91nXCtWcWuRftNdkue71s3OKtONB
 BrswNthA8+gqbfL0Mzp5QbduMNcZvEVMbyj/JkgK7tnbxewmGOzD60foPRQUG4pP8AcB
 eriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772729711; x=1773334511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KG5tAxih9N2wv11pDQ6fn5KUPOK01pGHZ3Cg7drQanI=;
 b=okDuWuF1gJR7zojGwZp5j19d5HTgKVmM+ksgrSlgzZgfBuvQAzjDfXw1pGGvhUmumw
 oQ8VmpEMTKDep8urdivOnUa87QmtRfuA//ifpwgssKU3xrqfgHvaN8DdS7rFEMMeYJvq
 SGVErKmxWc5EoHkzwSQ1fReiiOmXA+BiyM+v7ICbGHQ8CrIYYo2P4hMYrHttydMfWuxg
 5tPVmHaW+MtWiWCS/sNoX3dN3qE1Uqt5zruieJjCIzEhZ6lKaeDPgDzYBzOEK3byIFWT
 2vHy4DPq89CGd3pDKKByCnCIbzrfybhOnn0kVhQ6OqX10igHOEkCBjsfgqn2yG+3fcMj
 kNJw==
X-Gm-Message-State: AOJu0YxQZ91kVSn0Gry/cXIFeLAQTAJgGdCc99JZZ5I+EzXuhxcOGdhj
 Kz+I5b7by8KKzIPLFomOQT6Cs4e4jao87LwG4+mxAJBV/mFxtjWO7htbN81WhHZ5Bi5g7ibt57m
 ghzAn1YEJN5q0mupYkjWLawnEOz5+fXBZBwdoO/47hQ==
X-Gm-Gg: ATEYQzzLKKEtNWjF2ErOX5JaUOLyVwq8Yg6lJpQWZwsjQVRKbTRIvPS5lhvWW9bM8FU
 qgNlrlGSLKsrGPid5v9R62dSunIZ8Xpu2kmc46wp7muuwARZfFeT4YwhQpkqI8AkuUS6+71RCFM
 TO2X6sKdlo/44BJpYejip6Q6rv6YxGzkFdTDr5vHb0qyRjDueJ13XW23ywO1i6I18vMKRgQvOFG
 iQ9Ei39a7HF3/mFOTsFRmN1xYo1G9rl/AOGXzMdc9YIi7bmy0JP6JpGvTXNgeenjdsXw8TlupmN
 B8wddo5ZlDooA6aDLoH/PuXn3KAbCFYKMPHek2AqDq1dBRwO0v1wwxrSdThaTNqD2OCBCmurteX
 tGg==
X-Received: by 2002:a53:ee5e:0:b0:64c:a63f:87a with SMTP id
 956f58d0204a3-64cfa053badmr4749271d50.79.1772729711376; Thu, 05 Mar 2026
 08:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
 <20240209105813.3590056-7-alistair.francis@wdc.com>
In-Reply-To: <20240209105813.3590056-7-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 16:54:59 +0000
X-Gm-Features: AaiRm502-daN9rJAWngCXeCq40olEypoeORD7PENFwI0gg73oyRWfgrjXKmheTM
Message-ID: <CAFEAcA8NpikLhbooY=So0m5RauAD_tJCxXCbTv4wsa1jiAyf+w@mail.gmail.com>
Subject: Re: [PULL 06/61] target/riscv: move 'pmu-mask' and 'pmu-num' to
 riscv_cpu_properties[]
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Vladimir Isaev <vladimir.isaev@syntacore.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Fri, 9 Feb 2024 at 10:59, Alistair Francis <alistair23@gmail.com> wrote:
>
> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>
> Every property in riscv_cpu_options[] will be migrated to
> riscv_cpu_properties[]. This will make their default values init
> earlier, allowing cpu_init() functions to overwrite them. We'll also
> implement common getters and setters that both accelerators will use,
> allowing them to share validations that TCG is doing.
>
> At the same time, some options (namely 'vlen', 'elen' and the cache
> blocksizes) need a way of tracking if the user set a value for them.
> This is benign for TCG since the cost of always validating these values
> are small, but for KVM we need syscalls to read the host values to make
> the validations, thus knowing whether the user didn't touch the values
> makes a difference.
>
> We'll track user setting for these properties using a hash, like we do
> in the TCG driver. All riscv cpu options will update this hash in case
> the user sets it. The KVM driver will use this hash to minimize the
> amount of syscalls done.
>
> For now, both 'pmu-mask' and 'pmu-num' shouldn't be changed for vendor
> CPUs. The existing setter for 'pmu-num' is changed to add this
> restriction. New getters and setters are required for 'pmu-mask'
>
> While we're at it, add a 'static' modifier to 'prop_pmu_num' since we're
> not exporting it.

I've been looking at a memory leak reported by the leak sanitizers
that seems to be introduced in this commit:

Direct leak of 192 byte(s) in 2 object(s) allocated from:
    #0 0x625956ece9d3 in malloc
(/home/pm215/qemu/build/san/qemu-riscv64+0x4b89d3) (BuildId:
f84fd5abb768fcdc651f49f456c8f3cad629a4bf)
    #1 0x72cd2c919ac9 in g_malloc
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x72cd2c8fb45a in g_hash_table_new_full
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4445a) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #3 0x6259570d17e8 in riscv_cpu_init
/home/pm215/qemu/build/san/../../target/riscv/cpu.c:1102:25

> +/* Hash that stores general user set numeric options */
> +static GHashTable *general_user_opts;

This is a global; it's shared between all CPUs in the process.

>  static void riscv_cpu_init(Object *obj)
>  {

This is the CPU init function; it's called once for each CPU.

> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +
>  #ifndef CONFIG_USER_ONLY
>      qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
>                        IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
>  #endif /* CONFIG_USER_ONLY */
>
> +    general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);

Here we unconditionally create a new hash table and store it in
the global. So if there is more than one guest CPU in the system,
or if we're in linux-user and have more than one thread, each
new CPU that is created will create a new hash table and overwrite
global, leaking the old hash table.

How is this intended to work? Is the hashtable global, or per-CPU ?
Since you are setting hashtable entries based on CPU properties,
which are per-CPU-object and can be different for different CPU
objects, my guess is this hashtable should be stored in the
CPU, not a global.

Similar globals in target/riscv/tcg/tcg-cpu.c have similar leaks:

Direct leak of 192 byte(s) in 2 object(s) allocated from:
    #0 0x625956ece9d3 in malloc
(/home/pm215/qemu/build/san/qemu-riscv64+0x4b89d3) (BuildId:
f84fd5abb768fcdc651f49f456c8f3cad629a4bf)
    #1 0x72cd2c919ac9 in g_malloc
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x72cd2c8fb45a in g_hash_table_new_full
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4445a) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #3 0x6259573bcd30 in riscv_tcg_cpu_instance_init
/home/pm215/qemu/build/san/../../target/riscv/tcg/tcg-cpu.c:1678:26

Direct leak of 192 byte(s) in 2 object(s) allocated from:
    #0 0x625956ece9d3 in malloc
(/home/pm215/qemu/build/san/qemu-riscv64+0x4b89d3) (BuildId:
f84fd5abb768fcdc651f49f456c8f3cad629a4bf)
    #1 0x72cd2c919ac9 in g_malloc
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x72cd2c8fb45a in g_hash_table_new_full
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4445a) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #3 0x6259573bcd41 in riscv_tcg_cpu_instance_init
/home/pm215/qemu/build/san/../../target/riscv/tcg/tcg-cpu.c:1679:27

thanks
-- PMM

