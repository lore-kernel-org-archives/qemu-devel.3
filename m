Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2634BC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 16:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Mgi-0000f0-3h; Mon, 14 Apr 2025 12:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u4MgQ-0000Zy-Va; Mon, 14 Apr 2025 12:29:24 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u4MgJ-000425-Tw; Mon, 14 Apr 2025 12:29:18 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:ca1:0:640:740c:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id CDE5360914;
 Mon, 14 Apr 2025 19:29:05 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b4ae::1:27] (unknown
 [2a02:6b8:b081:b4ae::1:27])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 3TJKrL0FbW20-ZacwFYnw; Mon, 14 Apr 2025 19:29:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744648144;
 bh=jotjLdI7Qcj9b3TH4f5TY0oj0FYYi4F5RXcQ/Thl0Uw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=TR5H4jOes2yymbOd7PHxJzWhAMIjq0K9HGX6kb/9vJvb5Kw0CdGlBQfnTuJSWnP3I
 nTIfdILUthxLd+uQ9FcM1xfKdEWAauBq1RL42OvPn1K3Y6NawjrcLip6kSYaFe2uHe
 VrkgjTkG9nRA4TuzHD2JkAgnhozv+LL6U7mfxqTw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <98cce41c-44a2-4dca-adeb-ef5ac05fd147@yandex-team.ru>
Date: Mon, 14 Apr 2025 19:29:03 +0300
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
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This make me doubt.

Actually, what is the different for the user between "fast zeroing empty qcow2 (actually no-op)" and "skip zeroing empty qcow2 (no-op)"? And why visible interface effect should change after some internal optimization?

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

So, without your patch we go into this "if" and set the whole dirty bitmap even with qcow2?

That looks like a preexisting bug to me. And this is because we don't have discard=unmap option on qcow2 node..

Probably, we'd better have something like bdrv_can_write_zeroes_fast(target_bs) here, which of course should be true for qcow2.

Probably in real world people always set discard=unmap for qcow2 nodes.

>               return 0;
> diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
> index c0ce82dd257..814c15dfe3b 100755
> --- a/tests/qemu-iotests/194
> +++ b/tests/qemu-iotests/194
> @@ -22,6 +22,14 @@
> 
>   import iotests
> 
> +def filter_job_event(event):
> +    '''Filter len and offset in a job event'''
> +    event = dict(event)
> +    if event['data'].get('len', 0) == event['data'].get('offset', 1):

I'd prefer explicit check that both fields exist instead of magic 0 and 1. But I don't care too much.

> +        event['data']['len'] = 'LEN'
> +        event['data']['offset'] = 'LEN'
> +    return event
> +
>   iotests.script_initialize(supported_fmts=['qcow2', 'qed', 'raw'],
>                             supported_platforms=['linux'])
> 
> @@ -34,6 +42,7 @@ with iotests.FilePath('source.img') as source_img_path, \
> 
>       img_size = '1G'
>       iotests.qemu_img_create('-f', iotests.imgfmt, source_img_path, img_size)
> +    iotests.qemu_io('-f', iotests.imgfmt, '-c', 'write 512M 1M', source_img_path)
>       iotests.qemu_img_create('-f', iotests.imgfmt, dest_img_path, img_size)
> 
>       iotests.log('Launching VMs...')
> @@ -61,7 +70,8 @@ with iotests.FilePath('source.img') as source_img_path, \
> 
>       iotests.log('Waiting for `drive-mirror` to complete...')
>       iotests.log(source_vm.event_wait('BLOCK_JOB_READY'),
> -                filters=[iotests.filter_qmp_event])
> +                filters=[iotests.filter_qmp_event,
> +                         filter_job_event])
> 
>       iotests.log('Starting migration...')
>       capabilities = [{'capability': 'events', 'state': True},
> @@ -87,7 +97,8 @@ with iotests.FilePath('source.img') as source_img_path, \
> 
>       while True:
>           event2 = source_vm.event_wait('BLOCK_JOB_COMPLETED')
> -        iotests.log(event2, filters=[iotests.filter_qmp_event])
> +        iotests.log(event2, filters=[iotests.filter_qmp_event,
> +                                     filter_job_event])
>           if event2['event'] == 'BLOCK_JOB_COMPLETED':
>               iotests.log('Stopping the NBD server on destination...')
>               iotests.log(dest_vm.qmp('nbd-server-stop'))
> diff --git a/tests/qemu-iotests/194.out b/tests/qemu-iotests/194.out
> index 6940e809cde..79b961723d8 100644
> --- a/tests/qemu-iotests/194.out
> +++ b/tests/qemu-iotests/194.out
> @@ -7,7 +7,7 @@ Launching NBD server on destination...
>   Starting `drive-mirror` on source...
>   {"return": {}}
>   Waiting for `drive-mirror` to complete...
> -{"data": {"device": "mirror-job0", "len": 1073741824, "offset": 1073741824, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> +{"data": {"device": "mirror-job0", "len": "LEN", "offset": "LEN", "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>   Starting migration...
>   {"return": {}}
>   {"execute": "migrate-start-postcopy", "arguments": {}}
> @@ -18,7 +18,7 @@ Starting migration...
>   {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>   Gracefully ending the `drive-mirror` job on source...
>   {"return": {}}
> -{"data": {"device": "mirror-job0", "len": 1073741824, "offset": 1073741824, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> +{"data": {"device": "mirror-job0", "len": "LEN", "offset": "LEN", "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>   Stopping the NBD server on destination...
>   {"return": {}}
>   Wait for migration completion on target...


With "int ret = -1;" kept as is:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


