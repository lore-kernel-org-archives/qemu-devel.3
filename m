Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA243C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 12:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4HFG-0008Cu-PA; Wed, 09 Sep 2026 08:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1x4HF2-0008By-8k; Wed, 09 Sep 2026 08:17:28 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1x4HF0-0008Nf-0b; Wed, 09 Sep 2026 08:17:27 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1413E60207;
 Wed,  9 Sep 2026 12:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957321F00A3A;
 Wed,  9 Sep 2026 12:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788956241;
 bh=XAsYGST3fK75sdqD5BtU1+vIYyrQfCFom8k9fVsh1PY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=IMrzoV4OhNq57UET6zC5VuIWCkk7UYhCWY9zAas2uwX4RO9gXOyYWGf2wQ8i8RIMo
 6FqJWObA6gNNOSSvdsgDdnHyfklE1+xa/Vq4m0pk6k6VwalKcTDaOtcbvXsFYOaNZ1
 LzXjJsItBPexiAQp486UnShhd6GXXm6hxy4WgOz5czHhAnkEyJOU4F955adQ9QJ3Ip
 awP4zTnItUnHY0eQJGzWapszKF10+1AN8ktTIx2Eu6fd73jdx5rEHZk1NAiKV5I0w9
 M+LOV+Lbbn4VRUay6NhrzZeUdLN9WVoI75d1ns5Yat7Sf7HhkZKTeKmceYTis3ta9i
 zLpQ9ydpdMYjw==
Date: Wed, 9 Sep 2026 14:17:07 +0200
From: Daniel Gomez <da.gomez@kernel.org>
To: Jesper Wendel Devantier <foss@defmacro.it>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe Mathieu-Daudé <philmd@mailo.com>, Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org, Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
Subject: Re: [PATCH v2 1/7] dma-helpers: fix unaligned discard_back
Message-ID: <20260907222356.1-da.gomez@kernel.org>
In-Reply-To: <20260904235516.2-foss@defmacro.it>
References: <20260819-align-nvme-mdts-with-linux-v2-0-351ac2dfed64@samsung.com>
 <20260819-align-nvme-mdts-with-linux-v2-1-351ac2dfed64@samsung.com>
 <20260904235516.2-foss@defmacro.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Mailer: lorebird
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026-09-04T23:57:16+02:00, Jesper Wendel Devantier <foss@defmacro.it> wrote:
>
>
> On 2026-08-19T17:24:03+02:00, Daniel Gomez <da.gomez@kernel.org> wrote:
> > From: Daniel Gomez <da.gomez@samsung.com>
> It is obviously locally correct.
>
> (I am more confused by the code, broadly. How come the IO isn't rejected
> if unaligned?).

IOs were never unaligned from nvme side. However, chunking introduces an
unalignment case that patch 2 fixes by ensuring that each IOV_MAX chunk
boundary is sector-aligned (not present in v1), which is what led me to
this fio test and unalignment check.

But your question made me look at the discard path more closely. And
looking at the commit introducing it, 58f423fbd5f7 "dma-helpers: Fix too
long qiov", it was meant to fix something unrelated: "This fixes the IDE
qtest case /x86_64/ide/bmdma/short_prdt." So, I guess it's fine for that
case.

I will drop the reproducer from the commit message as it belongs to
patch 2.



