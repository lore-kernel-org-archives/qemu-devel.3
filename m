Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF51606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JENCjrYC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO54V-0000sv-DZ; Mon, 02 Nov 2026 22:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO54M-0000q0-71; Mon, 02 Nov 2026 22:20:19 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO54I-0005Ig-Ui; Mon, 02 Nov 2026 22:20:16 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 59C4260008;
 Tue,  3 Nov 2026 03:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D305D1F0093A;
 Tue,  3 Nov 2026 03:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793676013;
 bh=TQZkPppbRXUvb4scDFQuMoWivNUA3qRX2ZcC4u13ylo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=JENCjrYCiaJxkS3OjY39boCs+mJXaVJhC9lqfzK0yFJHlVZB8QLQJ+JgIYg8fnGtu
 /c0MWoRIsM9/mu4XmyWXIPAVFaaIvsluikZdRo5dhUhsy5o9Or70eGdTus2RfbBhF8
 CE6Vdc3uY8xMeQpnIb9hPNrBhuUNveRm1Al1RdbtfB9Mwjullm7/ghoMHD+YnVdG5q
 QVHSWJ5MfV32yJWDfQBuQnZsZOQwQIvmjfAKsXIEaqZtEdPhcAmMq8enx7PVU2pnil
 ywamHHczJfv1iqehgHi+cmBW9ZVt7/UM0xA/a3OeO/h/Dd6HpQ39atJltL5yPNa9Yj
 H4/ScgBJtjICg==
Date: Tue, 3 Nov 2026 03:20:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 29/37] hw/arm/virt: Size the cache MSC occupancy model
 by level
Message-ID: <20261103032006.3666f780@jic23-hlaptop>
In-Reply-To: <tencent_5CA6D54DF02302DDEE4B59CD141E77AE000A@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_5CA6D54DF02302DDEE4B59CD141E77AE000A@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 18:10:49 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Give the cache MSCs their CSU model capacity: 512 KiB for L2 and
> 32 MiB for L3, matching the cache sizes guests infer from the
> topology, so the occupancy snapshot reads back realistic values.

Read them from the system registers like we do for PPTT.

Jonathan


> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  hw/arm/virt.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a57ba56..1bcdd20 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2192,6 +2192,10 @@ static void create_mpam_msc_cache(VirtMachineState *vms, int level,
>          object_property_set_uint(OBJECT(dev), "cache-type", UNIFIED_CACHE,
>                                   &error_fatal);
>          object_property_set_uint(OBJECT(dev), "cpu", i, &error_fatal);
> +        /* Occupancy model: usage = capacity scaled by the CPBM fraction */
> +        object_property_set_uint(OBJECT(dev), "csu-capacity-bytes",
> +                                 level == 2 ? 512 * KiB : 32 * MiB,
> +                                 &error_fatal);
>          sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>          sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, *base);
>          *base += MPAM_SIZE;


