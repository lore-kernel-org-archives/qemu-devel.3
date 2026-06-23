Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF52DCDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbxFG-0005Ec-Oj; Tue, 23 Jun 2026 05:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wbxFF-0005EN-0M; Tue, 23 Jun 2026 05:16:37 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wbxFD-000491-D1; Tue, 23 Jun 2026 05:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=6P2cA8wxhGbTxqiqXldIWqnxzb3Z+kPd731bhghbMBg=; b=turqzexMYnh80cgeYs8wlaXoyD
 updWOaZTwoJfN4yGaECps61L8umXvLEFoKWzC0n5ByGc8YXIKW5XSLDwjRZqaMK/UVtzihwOqUsy1
 EPs+3oNvZNFYS5dWnSZSxq59UjJcvZJqNtHaLybymJ4wspexrWnZcZNQQWrZ2sv26NXVw5YeLo4vT
 uqZuVeTjNNt1R9Adz6XEgGvccCo8MuNU/E6fbAaJRGwXAukA4kMm3jopQ4qP0ofvU1Jfs5Blkfiws
 prpmSUgNTN/UazshOfPulZ+zk/0Gvqbly4Al9YZYDyqT99r1kAck7X1Xy/FYL6hxtWZFMRDOhx+lX
 kd7KTKRUFmq+UEDTmMjXwgaEbbr8+yJePHDzw/akFEcmqd+opNZt3kKF2piG5b3X47BHEVYVv/b/O
 HpAwo6cJPlJtcuCZuGrwbBO5IqJz1/rpAmnHZF4/8R0j3RV6JcMpbYZSrqmriWNrJvulCNA17vfkT
 QXSnn9PKoS4lgdaNc/WOApri8HaNj5rQBlKoCU0mRdKk3g9NXOAIDCaRlPtcega23b6kPjEfFAyEp
 kVqKWLWqwkHRCCymHIpxbLcwfpgLUK9IxujEagjiyTd2wKkgfMknKnqBUXsv1hZcrzeHnNCk3EZHC
 KR0Od2qik6sC4kLJC1wau4qBHRALoJ1SI5ln9E/dM=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2 0/8] 9pfs: fix DoS via Treaddir (CVE-2026-9238)
Date: Tue, 23 Jun 2026 11:16:29 +0200
Message-ID: <12917790.O9o76ZdvQC@weasel>
In-Reply-To: <cover.1781287774.git.qemu_oss@crudebyte.com>
References: <cover.1781287774.git.qemu_oss@crudebyte.com>
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

On Friday, 12 June 2026 20:22:52 CEST Christian Schoenebeck wrote:
> Feifan Qian reported a potential DoS and unbound host allocation via
> Treaddir request due to msize not being capped on Tversion handshake, and
> allocation size in Treaddir being capped too late.
> 
> Attack Vector of Vulnerability:
> 
> A malicious guest can negotiate a large 9P msize during Tversion handshake
> and then send Treaddir request with a large 'count' parameter. The 9p
> server would allocate host memory proportional to the negotiated 'msize'
> for collecting directory entries, before validating that the actual reply
> buffer can hold the response. If the reply buffer is smaller than what was
> allocated, the response marshalling fails, but the memory has already been
> consumed.
> 
> This can lead to:
> 
>  - Unbound host memory allocation proportional to the negotiated msize.
>  - Denial of service against the QEMU process.
>  - Potential OOM conditions affecting entire host system.
> 
> This series fixes this vulnerability on two layers.

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian
 
> Summary of patches fixing this vulnerability:
> 
>  - Layer 1: Patches 1..4 cap msize during Tversion handshake to reasonable
>    maximum value. It does so by limiting msize to the theoretical maximum
>    msize value supported by transport implementation.
> 
>  - Layer 2: Patches 5..8 cap the allocated host memory in the Treaddir
> handler specifically to the current, real response buffer size of transport
> implementation.
> 
> v2:
>   - Patch 3:
>     - Pick the smallest limit from all Xen rings.
>     - Return zero if Xen's ring count is zero.
>   - Patch 7:
>     - Use a local iovec in_sg[2] array variable to avoid potential NULL
>       pointer dereference.
>   - Patch 8:
>     - Fix potential underflow if response_buffer_size() returned a value
>       smaller than 11.
> 
> Christian Schoenebeck (8):
>   hw/9pfs: add msize_limit transport callback
>   9pfs/virtio: implement msize_limit callback
>   9pfs/xen: implement msize_limit callback
>   hw/9pfs: cap negotiated msize to transport limit
>   hw/9pfs: add response_buffer_size transport callback
>   9pfs/virtio: implement response_buffer_size callback
>   9pfs/xen: implement response_buffer_size callback
>   hw/9pfs: cap Treaddir allocation (CVE-2026-9238)
> 
>  hw/9pfs/9p.c               | 34 ++++++++++++++++++++++++++++++++--
>  hw/9pfs/9p.h               |  2 ++
>  hw/9pfs/virtio-9p-device.c | 17 +++++++++++++++++
>  hw/9pfs/xen-9p-backend.c   | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 82 insertions(+), 2 deletions(-)



