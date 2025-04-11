Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DA0C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 19:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3KT2-00077S-8a; Fri, 11 Apr 2025 15:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u3KT0-00076j-Ob; Fri, 11 Apr 2025 15:55:11 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u3KSx-0003Ld-RU; Fri, 11 Apr 2025 15:55:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:ee89:0:640:1681:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id AA47160D44;
 Fri, 11 Apr 2025 22:54:58 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7310::1:a] (unknown
 [2a02:6b8:b081:7310::1:a])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vsmBgU1FduQ0-zE1RH6UO; Fri, 11 Apr 2025 22:54:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744401298;
 bh=X68VQGG+NiL8sITpL3/5Siga6JdhiASKYp6NQDQvmEM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=sm/NVysZoP3bAAn8kfZ94p/uQ8Yb5tLbxIfucKNBrVTtFbM6hrTpRP/DTl1LaKOap
 7m1wIOmqiCsHqqOtGY19umt8ccTFXsFkXiwfgq4DVVwSDjBYhYh8siyT25COZzEMF3
 VdZYl/uDnTFnpyY3d+5XA7zq6PJSdvuLo8L2TuBE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c72f0d7e-1408-49c7-b068-6a475ce336f1@yandex-team.ru>
Date: Fri, 11 Apr 2025 22:54:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mirror: Skip pre-zeroing destination if it is already
 zero
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:Block Jobs"
 <qemu-block@nongnu.org>
References: <20250411010732.358817-8-eblake@redhat.com>
 <20250411010732.358817-9-eblake@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250411010732.358817-9-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 11.04.25 04:04, Eric Blake wrote:
> When doing a sync=full mirroring, QMP drive-mirror requests full
> zeroing if it did not just create the destination, and blockdev-mirror
> requests full zeroing unconditionally.  This is because during a full
> sync, we must ensure that the portions of the disk that are not
> otherwise touched by the source still read as zero upon completion.
> 
> However, in mirror_dirty_init(), we were blindly assuming that if the
> destination allows punching holes, we should pre-zero the entire
> image; and if it does not allow punching holes, then treat the entire
> source as dirty rather than mirroring just the allocated portions of
> the source.  Without the ability to punch holes, this results in the
> destination file being fully allocated; and even when punching holes
> is supported, it causes duplicate I/O to the portions of the
> destination corresponding to chunks of the source that are allocated
> but read as zero.
> 
> Smarter is to avoid the pre-zeroing pass over the destination if it
> can be proved the destination already reads as zero.  Note that a
> later patch will then further improve things to skip writing to the
> destination for parts of the image where the source is zero; but even
> with just this patch, it is possible to see a difference for any BDS
> that can quickly report that it already reads as zero.  Iotest 194 is
> proof of this: instead of mirroring a completely sparse file, change
> it to pre-populate some data.  When run with './check -file 194', the
> full 1G is still allocated, but with './check -qcow2 194', only the 1M
> of pre-populated data is now mirrored; this in turn requires an
> additional log filter.
> 
> Note that there are still BDS layers that do not quickly report
> reading as all zero; for example, the file-posix code implementation
> for fast block status currently blindly reports the entire image as
> allocated and non-zero without even consulting lseek(SEEK_DATA)); that
> will be addressed in later patches.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   block/mirror.c             | 10 ++++++++--
>   tests/qemu-iotests/194     | 15 +++++++++++++--
>   tests/qemu-iotests/194.out |  4 ++--
>   3 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index a53582f17bb..2e1e14c8e7e 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -841,14 +841,20 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
>       int64_t offset;
>       BlockDriverState *bs;
>       BlockDriverState *target_bs = blk_bs(s->target);
> -    int ret = -1;
> +    int ret;

I think, it was to avoid Coverity false-positive around further code

         WITH_GRAPH_RDLOCK_GUARD() {
             ret = bdrv_co_is_allocated_above(bs, s->base_overlay, true, offset,
                                              bytes, &count);
         }
         if (ret < 0) {
             return ret;
         }

which you don't touch here. I think "= -1;" should be kept. Or I missed static analyzes revolution (if so, it should be mentioned in commit message).

>       int64_t count;
> 
>       bdrv_graph_co_rdlock();
>       bs = s->mirror_top_bs->backing->bs;
> +    if (s->zero_target) {
> +        ret = bdrv_co_is_zero_fast(target_bs, 0, s->bdev_length);
> +    }
>       bdrv_graph_co_rdunlock();
> 
> -    if (s->zero_target) {
> +    if (s->zero_target && ret <= 0) {
> +        if (ret < 0) {
> +            return ret;
> +        }
>           if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
>               bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
>               return 0;
> diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
> index c0ce82dd257..814c15dfe3b 100755



-- 
Best regards,
Vladimir


