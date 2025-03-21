Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C205C35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 10:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvZL1-00013F-SN; Fri, 21 Mar 2025 06:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tvZKx-00012K-9W
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 06:10:49 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tvZKs-0007EK-LL
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 06:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=GCQnHUt17ei7bgeH9ORmGrJGdpPpaSQM4ItLTdnQiEo=; b=T2LSLWDoOPXMOVIV0knNmiLEyI
 QM9ebYl8Z4nII/VwJBPi3iMuWMkb0IqH2tes/vawkAVdw09qxgSCYdb9vbBd37zahe9leH7ahzPbk
 tMMeByL4BDOXEZ8hEMpz7Hg98PCCOOLxB3Z0r9P5iHCxNjStk/vdG28gJMueXMploTwMUe/LPQM3i
 RDyfsWp4TuSCjHlj7c3CczOn0WuY0CGF5mSUm2WbVp9hFyfhxmqZcQjvNAcyw4WpbnCjcBiqoK20P
 LTyUsppjLAD7e53HQ59hdV4AJyipB5eLhEP+w13Ssw5ELeVu8ZsBEmbsFG/Y4mpqVAWnW8P4HH4Sa
 Qv3EZq10XmIbQ49tiUZnoY/R/5oI+yC2Yae4Nj5NGwZeuVeQTkZN1ML2fP4geAUnTyrcMGdjBQywp
 6rdQOxITupgsvRfaLAu+LApGH2n72aO4HbvptLWLLDJmyKuNyDnIgxXR4QmY+aWjO4pq4XqvJio88
 V/fizClHyOK8mpX05ziCULpLiLS/muFOZp6flaTkWcwkeMuNxc8zUYPTTSfZuM/jWUdx823j/tv4F
 gwz1ZjdMXYeFvFPY2nPg+EGNEuKJjMfUl1xiZMgW7safoeBzpp3VsUQtUmqwwgVYbRXx6hDKHAldc
 P+qRDKckAFJBk/yz9v1dVs+3c3NZ3fBK7098NPAiE=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2] 9pfs: fix 'total_open_fd' decrementation
Date: Fri, 21 Mar 2025 11:10:31 +0100
Message-ID: <10824792.3hV6cDByjg@silver>
In-Reply-To: <E1tvEyJ-004dMa-So@kylie.crudebyte.com>
References: <E1tvEyJ-004dMa-So@kylie.crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thursday, March 20, 2025 1:16:20 PM CET Christian Schoenebeck wrote:
> According to 'man 2 close' errors returned by close() should only be used
> for either diagnostic purposes or for catching data loss due to a previous
> write error, as an error result of close() usually indicates a deferred
> error of a previous write operation.
> 
> Therefore not decrementing 'total_open_fd' on a close() error is wrong
> and would yield in a higher open file descriptor count than actually the
> case, leading to 9p server reclaiming open file descriptors too soon.
> 
> Based-on: <20250312152933.383967-7-groug@kaod.org>
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  V2: log a warning message on unexpected close() -> EBADF case
> 
>  hw/9pfs/9p.c     | 10 +++++++++-
>  hw/9pfs/codir.c  |  7 ++++++-
>  hw/9pfs/cofile.c |  7 ++++++-
>  3 files changed, 21 insertions(+), 3 deletions(-)

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



