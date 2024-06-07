Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88084C27C53
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 00:02:01 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFadO-0003k0-7g; Fri, 07 Jun 2024 10:32:02 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFadJ-0003jh-LA
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:31:57 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFadI-0002JR-6U
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:31:57 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57c614c57e1so421184a12.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717770714; x=1718375514; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e1Benc/rjH1FyVXTSwHETQFHSt8VqWqho7hgWCwYmcM=;
 b=zEiJZsk6mBdE7aA1YgOM4xgtoT9g/evRC/9amAD8RKxE6fuYTO1zcTtjIYOClxcN4A
 O2OynlHJjXA38Y0JqIPkUgL/t0hMW3efC3XDigIjNAgqhYlphXIeiEdks1a2m50wy102
 p09lvjAHS7655gz1IPWURLSiwoYlXqyMnU8SZGzmxMHDtJe6PoG7/wh0Wz6efslPhaGu
 dtiZYF15w0kozK7eDKv4Dk7gYhs0BCLdDWSxgscoq4DqU6SWZNpaWKKd4/IBTfBQT8gj
 Hbh+3pr3jmmCqm2N6GoZDZDsslYNnXD33QN0xp/xiwe4SN5oi7SqZVnPqdQFJPXZaj+x
 cHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717770714; x=1718375514;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e1Benc/rjH1FyVXTSwHETQFHSt8VqWqho7hgWCwYmcM=;
 b=PipKzTB+3slqh87bo6D8WuumtE1Hun5F0ygwzEmD7zjeBochvwdTWcPrZ0C7URJafU
 YY2Cz2s3fPkXP1EUcBeG5quHyzypGUExD04kGE2il2Y6so7tjuK5xnbd4Mt+ygXBK+1w
 RGG2E8k7xRHD5GRMs98CS9YEavywMf7SgS3okEanClc5q7wXUquyS/yaC1xAHXTMTaGn
 YiDitqep/3WPyTOC6XLpvbkbKzwk3dtIDVkuK8ZUmEfUsLtDfjWh1TT0ryOXSaWjioxp
 HqyTHtTbv4eXkv6sU292a8g3uZebMZEkobaXjNdHp79QwB/iF+b14pbleTUwC83a+NvC
 ubQg==
X-Gm-Message-State: AOJu0YxyiMoVte4vLnQHaNnaZiQOHFC8TZe9RON60v6I3TmCOvKkvxGo
 pa/INanIP1tP4B1299XGIwEhAScJ57ZkPxbe2GcZxU2EpvLLOjc3Tazq6pLa3Vt/P+Xooma7KeD
 6KhP4pCtdrsSLhUhA5raop3y5umL3p1phWJsbZX9L666iMro+
X-Google-Smtp-Source: AGHT+IFh1iEWb2np+Hy/sFR/lwMXi687UTmOV4uX/mv4noPUcU+YycFyZDZsSiu0GylYopW4mzcn4De2+8pU4dTqs2Y=
X-Received: by 2002:a50:d799:0:b0:57a:2fc1:e838 with SMTP id
 4fb4d7f45d1cf-57c50928dd9mr1697930a12.22.1717770714081; Fri, 07 Jun 2024
 07:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240523014637.614872-1-gaosong@loongson.cn>
 <20240523014637.614872-7-gaosong@loongson.cn>
In-Reply-To: <20240523014637.614872-7-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2024 15:31:43 +0100
Message-ID: <CAFEAcA8AONDHH=zMb6ODoE58=P4BN7+bBKJqzxQWU81STG8q4Q@mail.gmail.com>
Subject: Re: [PULL 06/10] hw/loongarch: Refine fwcfg memory map
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 Bibo Mao <maobibo@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Thu, 23 May 2024 at 02:48, Song Gao <gaosong@loongson.cn> wrote:
>
> From: Bibo Mao <maobibo@loongson.cn>
>
> Memory map table for fwcfg is used for UEFI BIOS, UEFI BIOS uses the first
> entry from fwcfg memory map as the first memory HOB, the second memory HOB
> will be used if the first memory HOB is used up.
>
> Memory map table for fwcfg does not care about numa node, however in
> generic the first memory HOB is part of numa node0, so that runtime
> memory of UEFI which is allocated from the first memory HOB is located
> at numa node0.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Reviewed-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20240515093927.3453674-4-maobibo@loongson.cn>
> Signed-off-by: Song Gao <gaosong@loongson.cn>

Hi; Coverity points out a possible issue with this code
(CID 1546441):

> +static void fw_cfg_add_memory(MachineState *ms)
> +{
> +    hwaddr base, size, ram_size, gap;
> +    int nb_numa_nodes, nodes;
> +    NodeInfo *numa_info;
> +
> +    ram_size = ms->ram_size;
> +    base = VIRT_LOWMEM_BASE;
> +    gap = VIRT_LOWMEM_SIZE;
> +    nodes = nb_numa_nodes = ms->numa_state->num_nodes;
> +    numa_info = ms->numa_state->nodes;
> +    if (!nodes) {
> +        nodes = 1;
> +    }
> +
> +    /* add fw_cfg memory map of node0 */
> +    if (nb_numa_nodes) {
> +        size = numa_info[0].node_mem;
> +    } else {
> +        size = ram_size;
> +    }
> +
> +    if (size >= gap) {
> +        memmap_add_entry(base, gap, 1);
> +        size -= gap;
> +        base = VIRT_HIGHMEM_BASE;
> +        gap = ram_size - VIRT_LOWMEM_SIZE;

In this if() statement we set 'gap'...

> +    }
> +
> +    if (size) {
> +        memmap_add_entry(base, size, 1);
> +        base += size;
> +    }
> +
> +    if (nodes < 2) {
> +        return;
> +    }
> +
> +    /* add fw_cfg memory map of other nodes */
> +    size = ram_size - numa_info[0].node_mem;
> +    gap  = VIRT_LOWMEM_BASE + VIRT_LOWMEM_SIZE;

...but then later here we unconditionally overwrite 'gap',
without ever using it in between, making the previous
assignment useless.

What was the intention here ?

thanks
-- PMM

