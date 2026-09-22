Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6A7C982FE
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x927a-0000Ub-9h; Tue, 22 Sep 2026 11:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1x927Y-0000UP-F4; Tue, 22 Sep 2026 11:09:24 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1x927W-0000g8-NT; Tue, 22 Sep 2026 11:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=0YtdWL9J+xjWyDVE/NuRPEaKi5bEiy+dvaaxhX50l4c=; b=r96t8gaMT1as4FApb5rPkutT0L
 VDOtfP6Xm/4xYeAmJpkVfZpgtQKMoQblezHZUrwKENsUkBbJ5gVny9oIKLUPipFQEEK6SahPS2YjB
 eaX7w6vme46QoevoJrNme74358yW3YwTaTU9zoFVJeTlsvnd9XARFPuJFR4AP/MeXPgLtQUVTHaKA
 hJKK012ZXYMPLQ2XAwu/yndR/ZoYGIY4dco11d8d0tmvW+POOVwfb7f4+qK1sPXrwLBDocYeRzFpu
 18cUj9pEijU5ZBux8cH6nkzo8v+98PM5QnXVOml+NLo75o3oj/1TUBRYLKfnHmoHB45sdwrRpG59k
 2p/0nor3PNwu2UwndsvZ72WW3AfGAvLmhRlBy36+qU89pTpa8kymFCHfz3S6nYObECfmk7Za7/FIC
 pbykREjn7Yq/oWuySHOHmLLAgpkt/P93ExmZZGa9UElO7UKzS194+2TTbWXfN0NUnKyJYvbJz7Kf7
 ge2LK95XKtGloIsWmCNHaax4vDHpD2+E5e5hcxPzwcd8OjX+jvi4tLae17Idpf/LQaKV6/8QcxgXQ
 f4R/xjFg7IyfA7fFBnwVL75RYOd07dXM42MFyhzu6pYSL8nD79Hhb3XOcvX5mG6F3uOBnQB+XFP+6
 k+dvmDQYy1GB1KJ7xgaaSkyiOgdkfM7ZGXLGo5njk=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] hw/9pfs: mutate FID path from main thread only
 (CVE-2026-93834)
Date: Tue, 22 Sep 2026 17:09:17 +0200
Message-ID: <3972315.kQq0lBPeGt@weasel>
In-Reply-To: <E1x8d3N-003M3F-Pz@kylie.crudebyte.com>
References: <E1x8d3N-003M3F-Pz@kylie.crudebyte.com>
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

On Monday, 21 September 2026 14:18:58 CEST Christian Schoenebeck wrote:
> v9fs_co_open2() is the only code that mutates a FID path from a worker
> thread: inside its v9fs_co_run_in_worker() block it frees fidp->path
> and copies in the new path under the held FID path write lock.
> 
> Every other FID path mutation in the 9p codebase happens on the main
> thread, so main thread readers (v9fs_walk(), v9fs_xattrwalk(),
> v9fs_stat(), v9fs_co_name_to_path()) rely on the same (main) thread
> atomicity and don't take the path read lock themselves on main thread.
> 
> Fix this by making the worker thread block in v9fs_co_open2() read-only
> with respect to the FID: render the new path into the local 'path'
> variable only and copy it to fidp->path after the worker block returned
> back to the main thread and still under the held write lock of the FID,
> like every other FID path mutation does.
> 
> Fixes: 02cb7f3a25 ("hw/9pfs: Use read-write lock for protecting fid path.")
> Fixes: CVE-2026-93834
> Reported-by: Milad Nasr <https://gitlab.com/sirkhezr>
> Suggested-by: Milad Nasr <https://gitlab.com/sirkhezr>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4491
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/cofile.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



