Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59E0C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 20:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttBYI-0006NS-Ei; Fri, 14 Mar 2025 16:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1ttBYD-0006NA-JH
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 16:22:37 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1ttBY9-0003uD-MW
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 16:22:36 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B0D3DA488DF;
 Fri, 14 Mar 2025 20:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD04C4CEE3;
 Fri, 14 Mar 2025 20:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741983749;
 bh=YNCessG+uDSbwGXWuodhi+296lWS/qzWXOaYaGEjb6g=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=fOgA2GObvuTseKVq3XX6cFlneDHRB7EOGJJ3mIDm6Vuozd/wcnoNQGN5jkAHZXyyq
 MI4wOIDmXNlbi7bgAqRw+hCLv2xp0drmMUXNgrq0pifsu7w4X2/PHW3l2Ue8+A5Ne/
 /t77RtLskjMNp59IN2WhxdWNjraqaKHBt7cOFz/F0wHldlQ0OglCq54r0TSJMZBRSx
 HUqjPe6DOi9aaohl2KMcuCPpFjzulKhsfHircs346mrttPQzpqX775hq5GyOA1q3fH
 /NgteNGotyJfw64WZJS8K3QwBwUqmwHL6lc9Zam3ugRCLPvhANft1jFiuyWV62duPq
 SFH7HAOOdBZcQ==
Date: Fri, 14 Mar 2025 13:22:26 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Markus Armbruster <armbru@redhat.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, edgar.iglesias@gmail.com, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/2] hw/xen: Fix xen_bus_realize() error handling
In-Reply-To: <20250314143500.2449658-2-armbru@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2503141321390.3477110@ubuntu-linux-20-04-desktop>
References: <20250314143500.2449658-1-armbru@redhat.com>
 <20250314143500.2449658-2-armbru@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=sstabellini@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 14 Mar 2025, Markus Armbruster wrote:
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.
> 
> xen_bus_realize() is wrong that way: it passes &local_err to
> xs_node_watch() in a loop.  If this fails in more than one iteration,
> it can trip error_setv()'s assertion.
> 
> Fix by clearing @local_err.
> 
> Fixes: c4583c8c394e (xen-bus: reduce scope of backend watch)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xen/xen-bus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> index 8260f1e1bb..2aacc1436f 100644
> --- a/hw/xen/xen-bus.c
> +++ b/hw/xen/xen-bus.c
> @@ -357,6 +357,7 @@ static void xen_bus_realize(BusState *bus, Error **errp)
>              error_reportf_err(local_err,
>                                "failed to set up '%s' enumeration watch: ",
>                                type[i]);
> +            local_err = NULL;
>          }
>  
>          g_free(node);
> -- 
> 2.48.1
> 

