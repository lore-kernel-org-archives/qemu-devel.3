Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4736C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 23:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQxZ5-00057e-UU; Mon, 08 Jul 2024 19:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sQxZ4-00056M-47
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 19:14:34 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sQxZ2-0001y5-Fl
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 19:14:33 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C3660611EB;
 Mon,  8 Jul 2024 23:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1558CC116B1;
 Mon,  8 Jul 2024 23:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720480470;
 bh=0QHGRQ292hmDIAtRoV8vjuJiWMGOE6ygT3BwAK0/NNw=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=X2rzQeP5qrwQXsPvKE631Ejpm08ZcSe11JzFqc0OAIyn5BpFRhVA19w8f6OlLXMTd
 OT5JC8klstKIAc0ifkygPVwC1L9CZtKEi1W5hgDLs5OD5HB3voA9rImTkiOYHqb/tS
 j1YkQQkkJGx+QFIGxSZmB2Ll9EW9LyzDknqHnXVuK4d8dVMfK/TyIuG2p2FPA7ql9n
 e7rou1/9GJjbMoXUVOfxlQmVoUKXlo+UMG3FILlZEpqSgP8Vmm2bZJvub+wKQW8UQ1
 clNPDEz2sc15R5u5vPVpiTL/xZTz9Q//njRXXrcnEfC130QylZVIG/ggDBfIkmx5XD
 KgZHpTI0anrFQ==
Date: Mon, 8 Jul 2024 16:14:27 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, edgar.iglesias@amd.com, xen-devel@lists.xenproject.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 1/2] physmem: Bail out qemu_ram_block_from_host() for
 invalid ram addrs
In-Reply-To: <20240701224421.1432654-2-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2407081614210.3635@ubuntu-linux-20-04-desktop>
References: <20240701224421.1432654-1-edgar.iglesias@gmail.com>
 <20240701224421.1432654-2-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2 Jul 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Bail out in qemu_ram_block_from_host() when
> xen_ram_addr_from_mapcache() does not find an existing
> mapping.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  system/physmem.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 33d09f7571..59d1576c2b 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2277,6 +2277,10 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
>          ram_addr_t ram_addr;
>          RCU_READ_LOCK_GUARD();
>          ram_addr = xen_ram_addr_from_mapcache(ptr);
> +        if (ram_addr == RAM_ADDR_INVALID) {
> +            return NULL;
> +        }
> +
>          block = qemu_get_ram_block(ram_addr);
>          if (block) {
>              *offset = ram_addr - block->offset;
> -- 
> 2.43.0
> 

