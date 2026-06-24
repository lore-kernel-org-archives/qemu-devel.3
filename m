Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4279ACDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHpG-0003Hf-RI; Wed, 24 Jun 2026 03:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wcHpF-0003H9-Fz; Wed, 24 Jun 2026 03:15:09 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wcHpD-0004U4-Pn; Wed, 24 Jun 2026 03:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=gAtt68WLOO/DZchlbTbR0A9VlwhIaNNy8uMnmyS5uHY=; b=Q33QedjmyuP3kcgCZaFj9nSNp0
 aR/T0ghoFFwQwe9krQ1EEKi4/cocppHkOZLJfehZBemwkbxO+oR77B2CLHs/59/Rivcb7J8xY2eCg
 Gpt3HnWAZgSMRyzOAs3FCFm5hy5o2F8vfEfMxAJ5ymPa0Vok9C+MnF8zkP3+K1u74Ndp6vuA6vreA
 sJoa6Jc2k+sVzAdn2Vl6njICxpniGPH32ejYL69FQprUUIwYVLgsPIBehw4BJ2rwulKZESaEpjh6G
 wvJTYw7lGrRYDmJ2oFQ/1JmqL/oWMiviJtzFUuCvOhgcYpUqEITYxnP3Bf0NdB0IHcgbTgwuNrBWP
 /00OlqI5LSJpP+BZQnlaJrFcqx26+sGpxMD0yLAl59o0/Iu/De9jc89/H5KvodoL5V67wIgCu9G84
 ddsTtzvofyJ3aby/AOEqAK+yJXVjpTN+jRw+9fh/8yu2ErzL2X8sInIK2no2HdFDC4v07QYPyYIbh
 z5yMBeX297T84tCFaMyPt/Omne3izpK33BU6wOA82jDwKHOnGj01iAg2s/YU9vuyUB115COb9Pq5N
 pGLM+1ZQ4jKpPuBahgFfOoBcgwo4AZ7KoHtLnurH4TxPQYDgQQ1ciY+GGiJlvQlLdERACfBTPgoPL
 k04kaQxqiGbaI2z0HoDUEH1jb3ZZj/YBVlaxCdrnA=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [Stable-10.0.11 79/86] hw/9pfs: consolidate name validation with
 check_name()
Date: Wed, 24 Jun 2026 09:15:02 +0200
Message-ID: <2414838.ElGaqSPkdT@weasel>
In-Reply-To: <20260624050404.394225-23-mjt@tls.msk.ru>
References: <qemu-stable-10.0.11-20260624080222@cover.tls.msk.ru>
 <20260624050404.394225-23-mjt@tls.msk.ru>
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

Hi Michael,

On Wednesday, 24 June 2026 07:02:50 CEST Michael Tokarev wrote:
> From: Christian Schoenebeck <qemu_oss@crudebyte.com>
> 
> Add a new, shared helper function check_name() that consolidates the name
> validation logic (illegal name check and "." / ".." rejection) currently
> spread over multiple 9p handlers, unnecessarily duplicating code.
> 
> This is pure refactoring with no behavior change. The existing error code
> semantics are preserved: rename operations return -EISDIR, create
> operations return -EEXIST.

Note that this particular patch is actually not a fix. It is just code 
deduplication. So my expecation was that this patch would not go to the stable 
branches, therefore I intentionally omitted to CC qemu-stable on this patch.

/Christian
 
> Note: These current error codes actually differ from native Linux system
> calls (e.g. rename() returns -EBUSY, open(O_CREAT) returns -EISDIR). The 9P
> protocol does not mandate specific error codes for these validation errors.
> Hence consolidating to a single error code (e.g., -EINVAL) for all cases
> could be considered in the future for simplicity reason.
> 
> This change reduces code duplication across 9 functions:
> 
> - v9fs_lcreate
> - v9fs_create
> - v9fs_symlink
> - v9fs_link
> - v9fs_rename
> - v9fs_renameat
> - v9fs_wstat
> - v9fs_mknod
> - v9fs_mkdir
> 
> Link:
> https://lore.kernel.org/qemu-devel/0573103880129eb543f07b68c77e86f2f572f6bf
> .1780072238.git.qemu_oss@crudebyte.com Signed-off-by: Christian Schoenebeck
> <qemu_oss@crudebyte.com>
> (cherry picked from commit 116db2986b11c914217bbd1547815b6c7efb944a)
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>




