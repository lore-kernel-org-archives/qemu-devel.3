Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CA4CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 09:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSXJh-0003RB-Km; Thu, 28 May 2026 05:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wSXJc-0003Qr-Lz
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:46:13 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wSXJb-0000tX-4P
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=ZpBOh+ZIrGb7Ks7SDuX9K4UCnyIIDMqyloj6pMxhdDs=; b=aGbMPWCFKogUK/3t5jjSOJycHY
 YNQUG7yWsfQmpfaA/w8JyAr7GZwSw1YnOF0NeCfVLvkF8JpR3fskMsUlayXAfhE7E37U6iZ4nzFfj
 XWFvSuoPVGKXuadzbNxa9EOvBD3SeuCE74QOPeY0hoWr83Nz1H0fGDvAQ6nVtYffenQI67Qe3hB7K
 qTMt7/xyg0D3lXygwrEfUPx0eZRTZJymWJhQRQWC3i/j4/x8fGaPPLok9NipQgY8ZdLpYKYRTMPId
 PoCrSE3crnuDan1WH28abPlwsNY4MlzyCz7baEUcIaJDZoVsK7LUKYDyE5iV7JaY9haXtPXywMDwb
 X8Od8A971yB99Is8/CuSgnOTbd1QO62XPp+178b+XDgQOTGSFy261meosMrU+9DkVO5o/yNHgGLuz
 Knrz7LkRcZbjnqgtqWg2Xsgfq6FG7lTIVbuZNRRh8FbPnRf9p1V8CMVtkG0UfkzxAx1K5H8L8IKdP
 YPGldzzjVtMYt9ByQgfRKkd4ox/PV319oE5Z3xdLgeUrJuFbDcz1XS1HfkAKBe1fN+/PbH+3u0Mvk
 5JAFCpInvkQZR7RDoRsYN/6ZmEBJQv/pYRAn5etR28SCwJMSiIpRV4frsxUHO/B119GOtuWqnruE8
 3VdwX0N/5SgwJMjWVyvXyPDw/IT93tZugXvfx4P80=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, sin99xx <sin99xx@proton.me>
Cc: Greg Kurz <groug@kaod.org>, sin99xx <sinxx198@gmail.com>
Subject: Re: [PATCH] 9pfs: fix missing rename lock in v9fs_co_readdir_many
 (CVE-2026-48004)
Date: Thu, 28 May 2026 11:46:07 +0200
Message-ID: <12901414.O9o76ZdvQC@weasel>
In-Reply-To: <E1wPkYi-000adH-4E@kylie.crudebyte.com>
References: <E1wPkYi-000adH-4E@kylie.crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Wednesday, 20 May 2026 19:11:25 CEST Christian Schoenebeck wrote:
> From: sin99xx <sinxx198@gmail.com>
> 
> v9fs_co_readdir_many() dispatches do_readdir_many() to a worker thread
> that reads V9fsFidState's path.data without holding a rename lock.
> 
> A concurrent rename request, e.g. of its parent dir, causes the FID's
> absolute path to be altered by freeing the old path string and
> assigning a new one. This causes a heap-use-after-free race condition
> while do_readdir_many() is still accessing the old object.
> 
> This allows a DoS by an unprivileged guest user.
> 
> Fix this by wrapping the worker thread dispatch block within a pair of
> v9fs_path_read_lock() and v9fs_path_unlock() calls, like it's done at
> other places.
> 
> Fixes: 2149675b195f ("9pfs: add new function v9fs_co_readdir_many()")
> Fixes: CVE-2026-48004
> Reported-by: sin99xx <sinxx198@gmail.com>
> [Christian Schoenebeck: add commit log message]
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

With updated author's email address, queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



