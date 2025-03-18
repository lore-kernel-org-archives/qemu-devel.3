Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7096C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 19:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tucBu-000875-DX; Tue, 18 Mar 2025 15:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tucBi-00082Q-Fq
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 15:01:27 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tucBf-0005up-G2
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 15:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=hI6YO/QoDBondvf/5cf4WdMvoDCXAXTq4pyytZYO550=; b=csZIvor3RMYzTqo3hfYD2FpSvz
 Lfoj153NewxxYqJc+FyOpc51bxe1InEczIa+lC4aJP10LbB5ty+HItlfiR+xtnctTfVZYJfl9kTpE
 Z3g5CEHKTjlYo0BILbd3g17XbClaw72g7L5s+yY/EKPA/P3F+IpI44f05J3SPtkxFoQKkc0uiI0G6
 YnjZ4UybK4jCwbjRLGS0sb4dpy+4IwUnsbqywKbzHvnPGe4vDMEvVgxPTtkvkaIKRiXJnRCC2SQ5U
 ig6kr9+GYdt6wnQhhnyzDmXvN9uq57Zv0n8Ta/gki3pZFSr8RdMxsVC61PwQ28AqjuVWE/jL87yOm
 zUTtqdafo/matHl+PQDE/QFyIgRrGW8jTW1F/WDcSnxFKXl/TSyS6Urz2S8AOwALZNaxUqT2nvn6X
 UJ7chyateSL49SvuuQKZgYhDnRwLvj8pkYd3QAyCXbC+sXdXuqFnzgui3Wj1Ev75H4R6L4BbC2x+S
 z1geqCqX/ZjGcV/kKYuWlOF3tvnGc5vrVwKLoSKvexlu7/U1x+rYtZN9YGQEoOAJubmGgDYYMt8xm
 bqHn2HbKTm+39p0PBVlBjRNziBNFoviJUs+T9nPZ5ydqm5c5nwsz/3W+Ymrrx5qfGJstlCtFdyf2a
 OUfpUdd+d6+TdNKAEiCezKSDX4SdQGADDxveY9Wfc=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v3 0/6] 9pfs: Fix ftruncate-after-unlink
Date: Tue, 18 Mar 2025 20:01:12 +0100
Message-ID: <2022729.raZeVgqq3s@silver>
In-Reply-To: <20250312152933.383967-1-groug@kaod.org>
References: <20250312152933.383967-1-groug@kaod.org>
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

On Wednesday, March 12, 2025 4:29:26 PM CET Greg Kurz wrote:
> QEMU 9.2 already fixed the long standing limitation of failing fstat() on
> unlinked files. This series does something similar for ftruncate().
> 
> The following program can be straced inside the guest with a shared fs in
> passthrough mode over 9p2000.L.
> 
> int main(void)
> {
> 	struct stat st;
> 	int fd = creat("./foo", 0000);
> 
> 	ftruncate(fd, 100);
> 	unlink("./foo");
> 	ftruncate(fd, 1000);
> }
> 
> Before :
> 
> creat("./foo", 000)                     = 3
> ftruncate(3, 100)                       = -1 EACCES (Permission denied)
> unlink("./foo")                         = 0
> ftruncate(3, 1000)                      = -1 ENOENT (No such file or directory)
> 
> After :
> 
> creat("./foo", 000)                     = 3
> ftruncate(3, 100)                       = 0
> unlink("./foo")                         = 0
> ftruncate(3, 1000)                      = 0
> 
> Cheers,
> 
> --
> Greg
> 
> Christian Schoenebeck (1):
>   tests/9p: add 'Tsetattr' request to test client
> 
> Greg Kurz (5):
>   9pfs: local : Introduce local_fid_fd() helper
>   9pfs: Don't use file descriptors in core code
>   9pfs: Introduce ftruncate file op
>   9pfs: Introduce futimens file op
>   tests/9p: Test `Tsetattr` can truncate unlinked file
> 
>  fsdev/file-op-9p.h                    |  5 +++
>  hw/9pfs/9p-local.c                    | 49 ++++++++++++++++++++-------
>  hw/9pfs/9p-synth.c                    | 22 ++++++++++++
>  hw/9pfs/9p-util.h                     |  1 +
>  hw/9pfs/9p.c                          | 21 +++++++++---
>  hw/9pfs/cofs.c                        | 37 ++++++++++++++++++++
>  hw/9pfs/coth.h                        |  4 +++
>  tests/qtest/libqos/virtio-9p-client.c | 49 +++++++++++++++++++++++++++
>  tests/qtest/libqos/virtio-9p-client.h | 34 +++++++++++++++++++
>  tests/qtest/virtio-9p-test.c          | 15 ++++++++
>  10 files changed, 219 insertions(+), 18 deletions(-)
> 
>

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



