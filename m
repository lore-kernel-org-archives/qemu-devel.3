Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21642CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 14:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSFLz-0003f3-Ri; Wed, 27 May 2026 10:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wSFLy-0003ef-S1; Wed, 27 May 2026 10:35:26 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wSFLp-0008GZ-UM; Wed, 27 May 2026 10:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=PGHnCJRL8HOLoNRN5DCteN44su3Wc1EgoxfR1cAdwf0=; b=h1lF8vVYLHrCOAPoflPLFNmL4r
 uwvZqwy9TZYjgmApKfjA3xtCwmjG5H5ipm2P3Cfv27yFuz0XdlZ12/cs8B/6D4+skEFmeJWOfSIrL
 V4rjc+VzyArjQdgWNzMLph6oi7a/gYlHwRcglHrZLVyV2A51kf/UsXwY4WlUVQ1hYiciAlWhUWpCC
 p0fq2f07+B3Lfyoh51hNqAYYN74RzXNmClBzCa5bB+Oc04njgwZRopYnKGwehqMkiuvMNM8InHh8j
 AhjV3QGaprbn4MapXZwj/hsF+g3K/+JLo98CbisMHgfR63Wtm9rr0vmaLfEmmHHCQQD02TCYDjCtr
 B74MftXQBs2+vCefLam9JIlPd1r6puylR+WSW1a2JOa0iMDmFOmjBQmvC5UToYnGK0tgewl7Iyizl
 vbxpZpi8hSV9Gh28i55kwIK4p2oHy4cLaKZnLiomjaigIMMhfbg6JXkE40vf6vIcambm28wI8GFgt
 JqWuTD1/dxpjFniBFLN5ZYnnoGHVziemiRs56RsEzWEHaWt8Vzz3YsQYmFzst+0E1zpRtCGo+xL3L
 +UFZLPHTIOWHio3mTm4LAIVMHZu77w/6O3CHlMC7cuJggmnkLd89tMTst4qh/Alk8y4PjFVTINMoL
 KqUQrY4DHwgf9F/qMokumF+l82SQwyJy4zI7hATPo=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Wang Jihe <wangjihe.mail@gmail.com>
Cc: Greg Kurz <groug@kaod.org>, Jia Jia <physicalmtea@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/6] 9pfs: fix V9fsPath heap buffer overflow
Date: Wed, 27 May 2026 16:35:13 +0200
Message-ID: <12901044.O9o76ZdvQC@weasel>
In-Reply-To: <cover.1779126034.git.qemu_oss@crudebyte.com>
References: <cover.1779126034.git.qemu_oss@crudebyte.com>
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

On Monday, 18 May 2026 19:40:34 CEST Christian Schoenebeck wrote:
> This series fixes a heap buffer overflow vulnerability in the 9pfs local
> backend. The vulnerability occurs when handling paths exceeding 65536 bytes,
> due to the V9fsPath.size field being limited to 16 bits.
> 
> The fix consists of:
> 
> - Changing V9fsPath.size from uint16_t to size_t.
> - Converting v9fs_path_sprintf() to return int for error handling.
> - Adding error propagation through all path manipulation functions.
> 
> Invididual Patches:
> 
> - Patch 1 is just an additional defensive patch.
> 
> - Actual fixes are patches 2..4, where patch 2..3 are prepatory, and
>   patch 4 is the actual behaviour fix.
> 
> - Patch 5 adds a reset function to the virtio test client for the new
>   test to work.
> 
> - Patch 6 adds a new test to guard this buffer overflow issue.
>   It must be enabled explicitly by -m slow for it to run.
> 
> More details about this issue:
> https://gitlab.com/qemu-project/qemu/-/issues/3358

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian
 
> Christian Schoenebeck (6):
>   hw/9pfs: add NULL check in v9fs_path_is_ancestor()
>   hw/9pfs: change V9fsPath.size to size_t and v9fs_path_sprintf() return
>     type
>   hw/9pfs: add error handling to v9fs_fix_path()
>   hw/9pfs: let callers of v9fs_path_sprintf() and v9fs_fix_path() handle
>     errors
>   tests/qtest/libqos: add qvirtqueue_reset_pool() for descriptor pool
>     reset
>   tests/9pfs: add deep absolute path test
> 
>  fsdev/file-op-9p.h           |  2 +-
>  hw/9pfs/9p-local.c           | 23 ++++++++----
>  hw/9pfs/9p.c                 | 41 +++++++++++++++------
>  hw/9pfs/9p.h                 |  4 +--
>  tests/qtest/libqos/virtio.c  | 23 ++++++++++++
>  tests/qtest/libqos/virtio.h  |  2 ++
>  tests/qtest/virtio-9p-test.c | 69 ++++++++++++++++++++++++++++++++++++
>  7 files changed, 144 insertions(+), 20 deletions(-)



