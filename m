Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A78CCA470
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 07:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4aae-0000dJ-Ms; Fri, 03 Oct 2025 03:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v4aaY-0000bx-Da; Fri, 03 Oct 2025 03:52:27 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v4aaN-00027Y-ND; Fri, 03 Oct 2025 03:52:25 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 45E2D806F1;
 Fri, 03 Oct 2025 10:52:04 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:589::1:33] (unknown
 [2a02:6bf:8080:589::1:33])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 3qbxUv3FpCg0-NdmhXZ8w; Fri, 03 Oct 2025 10:52:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1759477923;
 bh=oquBhJqgGGDV5HXyoxmOJKvNoy+PDz7vc1XAVrLi7XI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=jfqhXiFbRyLbn0+kkyiYvKYQaBpujIpj7jKRePV5a+/hTXbsF7fgY4Sj7AEGoE4Bs
 OxQjFTy7pO2IHMdiDQ44o3JjreDh/nDurbOSW4iy0cRtdV0Hu09fLspsw1dYK7YlnY
 br7gxKQrzT0hGcTL7UnYNCx16wIAc5ga3ovzQqq0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6b99754a-c137-4fc6-b771-ac5188f26a4a@yandex-team.ru>
Date: Fri, 3 Oct 2025 10:52:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] block: use pwrite_zeroes_alignment when writing first
 sector
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Jean-Louis Dupond <jean-louis@dupond.be>, Hanna Reitz <hreitz@redhat.com>
References: <20251002184000.410486-1-stefanha@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251002184000.410486-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 02.10.25 21:39, Stefan Hajnoczi wrote:
> This series fixes a bug I introduced in commit 5634622bcb33 ("file-posix: allow
> BLKZEROOUT with -t writeback"). The Linux fallocate(2) and ioctl(BLKZEROOUT)
> syscalls require logical block size alignment of the offset and length, even
> when the file is opened in buffered I/O mode where read/write operations do not
> require alignment.
> 
> The fix is to populate the pwrite_zeroes_alignment block limits field and to
> use that limit in create_file_fallback_zero_first_sector().
> 
> One issue I want to raise is that pwrite_zeroes_alignment is an "optimal
> alignment" hint. Hence create_file_fallback_zero_first_sector() had to be
> modified to honor the limit explicitly. 

Probably, this place had to be modified anyway, even if we support "required
write zeroes alignment" generically, it seems better to do write-zeroes
on first smallest "write-zero-able" sector than fallback to normal write of zero
data (or even to read/modify/write).


> The block layer doesn't automatically
> apply padding in order to align requests. This is different from how QEMU's
> block layer pwrite/pread works, where it does automatically apply padding and
> read/modify/write as necessary. If you want consistency, please let me know.
> 
> Stefan Hajnoczi (3):
>    file-posix: populate pwrite_zeroes_alignment
>    block: use pwrite_zeroes_alignment when writing first sector
>    iotests: add Linux loop device image creation test
> 
>   include/system/block-backend-io.h             |  1 +
>   block.c                                       |  3 +-
>   block/block-backend.c                         | 11 ++++
>   block/file-posix.c                            | 17 ++++++
>   tests/qemu-iotests/tests/loop-create-file     | 59 +++++++++++++++++++
>   tests/qemu-iotests/tests/loop-create-file.out |  8 +++
>   6 files changed, 98 insertions(+), 1 deletion(-)
>   create mode 100755 tests/qemu-iotests/tests/loop-create-file
>   create mode 100644 tests/qemu-iotests/tests/loop-create-file.out
> 


-- 
Best regards,
Vladimir

