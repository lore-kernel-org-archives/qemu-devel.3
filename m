Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92801C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 12:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4HWW-0003LK-Sg; Wed, 09 Sep 2026 08:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1x4HWV-0003L5-Pw; Wed, 09 Sep 2026 08:35:31 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1x4HWU-00048i-9K; Wed, 09 Sep 2026 08:35:31 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6EB04403D0;
 Wed,  9 Sep 2026 12:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EF31F00A3A;
 Wed,  9 Sep 2026 12:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788957327;
 bh=HZxkVoyxly/qPkvt288zeGzWXq0zrxvVa/7rKDHDKIs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=euyN3S6Jzj9i3/DdgGab4xxrNMoGqxP16XcLlY5Zja4ndTFLfDebapfHNgcVu1JDP
 W64BEy107uVhzdkC4sg/wKNF89y2cu4IL1NGPUWRkskJyf+4t+deI3DRWvGF+8zS9X
 mefJXalryoYgfb9KHLDCzziKarYnKOR+JmM9JPNUI/RsdPeW2ITZjHfVeTFCABWPeE
 dHmqpiM4wIU+kldBVXl5+YXmIxdKV9IV8XqiJO5/TLyrbH25picF6b6FgB1wjzrgwx
 YFR1CXh+m/HaWoO3y0yiRYTnI4G5gPx2fCQ7gpFNQTa/h5Eo8Ri1eyLPMv/BCepNDc
 3MjMT9MsY6SEw==
Date: Wed, 9 Sep 2026 14:35:21 +0200
From: Daniel Gomez <da.gomez@kernel.org>
To: Jesper Wendel Devantier <foss@defmacro.it>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe Mathieu-Daudé <philmd@mailo.com>, Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org, Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
Subject: Re: [PATCH v2 7/7] hw/nvme: cap mdts for CMB/PMR-only
Message-ID: <20260909143248.2-da.gomez@kernel.org>
In-Reply-To: <20260904235915.7-foss@defmacro.it>
References: <20260819-align-nvme-mdts-with-linux-v2-0-351ac2dfed64@samsung.com>
 <20260819-align-nvme-mdts-with-linux-v2-7-351ac2dfed64@samsung.com>
 <20260904235915.7-foss@defmacro.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Mailer: lorebird
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=sea.source.kernel.org
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

On 2026-09-05T00:02:22+02:00, Jesper Wendel Devantier <foss@defmacro.it> wrote:
> On 2026-08-19T17:24:09+02:00, Daniel Gomez <da.gomez@kernel.org> wrote:
>  ```c
>    static inline uint64_t nvme_mdts_max_iovs(uint8_t mdts)
>    {
>        return mdts >= 64 ? UINT64_MAX : (1ULL << mdts) + 1;
>    }
>  ```
>
>  Then the check becomes
>  ```c
>    if ((params->cmb_size_mb || n->pmr.dev) &&
>        (!params->mdts || nvme_mdts_max_iovs(params->mdts) > IOV_MAX)) {
>        error_setg(errp, "mdts=%u is incompatible with CMB/PMR", params->mdts);
>        return false;
>    }
>  ```
>
> ?

Looks good. I'll apply it together with the commit 1 message update and
send a new series.

Thanks!



