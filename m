Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA09EE3686
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXEC-00070K-HZ; Thu, 12 Feb 2026 08:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vqXEB-0006zz-JQ; Thu, 12 Feb 2026 08:59:31 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vqXE9-0005CW-TM; Thu, 12 Feb 2026 08:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=LnSctD1UfWDid1zwDZsZS3LM6hfX/aK0k8Q5Y6WdZrg=; b=R6HwTGEoffx22ZzOa+ZPkwADGO
 NVvWbWuBff/zcs0kAiweBeloOHValhKFN8UxjlqK61GZMOiAMGDJFl5a1gqex+6KjMaf1L4wRWhhS
 dYlQtF7AgTa0HOgUwXgRuno8N046k/PQHMRPIARHaI8cClUsm06nDuab0BTl9KyzVKxl1IMkWzs+U
 2CjV0V8OCk2Om+N1gZbFlWOlPYRXaMRz4BwBVp339oBYJe/VKmdewb/YbH8M3Ctg4/ZmV1nc+q/zb
 KU71bGwtIqUU7vymx4BHj/dFrSnJoNtZN1fyBVB8ZzGz2P218P5T0NzkjI5VhY+tph37MxfxHzgCK
 xuebCZmouZu52cAuEY1VHgQh+GkPj8n6+Zp6EVsw/WpoYDvde0tN5fhUhbYh6zLGzpPWV3DvdnRqC
 AMqTB3d0VnrXaO0Ojx1YQdodlut4PjAI6g5JHv4Lf8GtCb0PLOiNQqigJuqBOaC/0lv1A9JTeQphD
 DPXZaGyBYptcyA4dylOWjjODW8SmBhDliRHKghI6pD2N3nULSF8qbOJul7/Miqae1avtrmUfVv+yQ
 PXdTuF67ATNiCdyojU51Uz5AnHZXgKXVo/o9n4X8/zYNUWSpqgoIz+ZjndTPv177fyYVi0r9W8hUZ
 tHQjnfbIrGsfAM9xevXUdQ4fwZ6rivrGZaYEFiJx4=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: groug@kaod.org, Richie Buturla <richie@linux.ibm.com>
Subject: Re: [PATCH] hw/9pfs: fix data race in v9fs_mark_fids_unreclaim()
Date: Thu, 12 Feb 2026 14:59:26 +0100
Message-ID: <13947461.uLZWGnKmhe@weasel>
In-Reply-To: <20260211154450.254338-1-richie@linux.ibm.com>
References: <20260211154450.254338-1-richie@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wednesday, 11 February 2026 16:44:50 CET Richie Buturla wrote:
> A data race between v9fs_mark_fids_unreclaim() and v9fs_path_copy()
> causes an inconsistent read of fidp->path. In v9fs_path_copy(), the
> path size is set before the data pointer is allocated, creating a
> window where size is non-zero but data is NULL.
> 
> v9fs_co_open2() holds a write lock during path modifications,
> but v9fs_mark_fids_unreclaim() was not acquiring a read
> lock, allowing it to race.
> 
> Fix by holding the path read lock during FID table iteration.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3300
> Signed-off-by: Richie Buturla <richie@linux.ibm.com>

Another true survivor:
Fixes: 7a46274529 ("hw/9pfs: Add file descriptor reclaim support")

> ---
>  hw/9pfs/9p.c | 2 ++
>  1 file changed, 2 insertions(+)

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



