Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DBBFD8FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdke-0001t1-S9; Thu, 26 Feb 2026 10:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vvdkc-0001UJ-Gp
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:58:06 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vvdka-00041C-PQ
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:58:06 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 05B8C43BF1;
 Thu, 26 Feb 2026 15:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6071EC19424;
 Thu, 26 Feb 2026 15:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772121480;
 bh=pFENtf1PLuTlptv7aTYc9wD6eepcLaVhZA0dSQ3FgDg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=busjz29t3dJvMFnpJC8bSIEDhV6k6BlSzlQe6gdQgjYd3dIi48A+K+CpJcPN+Ezl8
 TDdMYAnQosH7H5UB/EAN0uKVAlMZQS+4U/N634zloMARaSrn57SWWvGWBoMFrMPYKg
 6XncwfRf2K8lIi5Im+NJoCejKReEHTKI1RTJIk7sA6NcipRx0LMg5oyhG8PwfGXJ9e
 FtZfd+BUZrZ7mrXd87GS1mRvfxP5ONQ3tF50wDePdgtYufYngdWbvBBknw5NArAjnD
 Ia9l6lOjQwrtwhe8pa7IFpCJhrs1JCgp8R5qoWazPhG5U4B04nWksW5nV/vOFEgqc6
 5BQi09VEO2I+A==
Message-ID: <a00dfa12-e10d-45c6-956a-fd0acc8f82b9@kernel.org>
Date: Thu, 26 Feb 2026 16:57:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/15] virtio-mem: use warn_report_err_once()
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Ben Chaney <bchaney@akamai.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Mark Kanda <mark.kanda@oracle.com>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-4-marcandre.lureau@redhat.com>
From: David Hildenbrand <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20260226140001.3622334-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=david@kernel.org; helo=sea.source.kernel.org
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

On 2/26/26 14:59, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> ---
>  hw/virtio/virtio-mem.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 251d1d50aaa..a4b71974a1c 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -594,18 +594,7 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
>          Error *local_err = NULL;
>  
>          if (!qemu_prealloc_mem(fd, area, size, 1, NULL, false, &local_err)) {
> -            static bool warned;
> -
> -            /*
> -             * Warn only once, we don't want to fill the log with these
> -             * warnings.
> -             */
> -            if (!warned) {
> -                warn_report_err(local_err);
> -                warned = true;
> -            } else {
> -                error_free(local_err);
> -            }
> +            warn_report_err_once(local_err);
>              ret = -EBUSY;
>          }
>      }

Thanks!

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David


