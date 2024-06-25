Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7F2C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 04:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLyF6-0006rm-Ge; Tue, 25 Jun 2024 00:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sLyF4-0006rK-8S; Tue, 25 Jun 2024 00:57:18 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sLyF0-0007X5-3f; Tue, 25 Jun 2024 00:57:18 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1c20:0:640:f632:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9143760031;
 Tue, 25 Jun 2024 07:57:08 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b5bf::1:d] (unknown
 [2a02:6b8:b081:b5bf::1:d])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7vGIsI0IbCg0-X0gerE5K; Tue, 25 Jun 2024 07:57:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719291427;
 bh=kSUB0o7/vUJovbVSzPolsZ3l/T+3tw5nuQ47hosarlI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=I6qWQH51dhjRKGknYE4nZYrdlJyjfym0xM6VRNZzpu8TPt4ofNIgJDN9Ggxc7LHI2
 8EyLQEju+kZrEbxRAIFs9dFxYIJrczYSpPNprwC2ygmHuAO5gSVPqjrkV+6opoGv2L
 KQfNd7PY4+xuokZHhG/28IO+UNEJWyK1K3u90CUo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <cab69e27-aacf-4371-88e4-9d8c76cb2a04@yandex-team.ru>
Date: Tue, 25 Jun 2024 07:57:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] blockdev: mirror: check for target's cluster size
 when using bitmap
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com
References: <20240521122014.333221-1-f.ebner@proxmox.com>
 <20240521122014.333221-6-f.ebner@proxmox.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240521122014.333221-6-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 21.05.24 15:20, Fiona Ebner wrote:
> When using mirror with a bitmap and the target does not do COW and is
> is a diff image, i.e. one that should only contain the delta and was
> not synced to previously, a too large cluster size for the target can
> be problematic. In particular, when the mirror sends data to the
> target aligned to the jobs granularity, but not aligned to the larger
> target image's cluster size, the target's cluster would be allocated
> but only be filled partially. When rebasing such a diff image later,
> the corresponding cluster of the base image would get "masked" and the
> part of the cluster not in the diff image is not accessible anymore.
> 
> Unfortunately, it is not always possible to check for the target
> image's cluster size, e.g. when it's NBD. Because the limitation is
> already documented in the QAPI description for the @bitmap parameter
> and it's only required for special diff image use-case, simply skip
> the check then.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   blockdev.c                                 | 57 ++++++++++++++++++++++
>   tests/qemu-iotests/tests/mirror-bitmap     |  6 +++
>   tests/qemu-iotests/tests/mirror-bitmap.out |  7 +++
>   3 files changed, 70 insertions(+)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 4f72a72dc7..468974108e 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2769,6 +2769,59 @@ void qmp_blockdev_backup(BlockdevBackup *backup, Error **errp)
>       blockdev_do_action(&action, errp);
>   }
>   
> +static int blockdev_mirror_check_bitmap_granularity(BlockDriverState *target,
> +                                                    BdrvDirtyBitmap *bitmap,
> +                                                    Error **errp)
> +{
> +    int ret;
> +    BlockDriverInfo bdi;
> +    uint32_t bitmap_granularity;
> +
> +    GLOBAL_STATE_CODE();
> +    GRAPH_RDLOCK_GUARD_MAINLOOP();
> +
> +    if (bdrv_backing_chain_next(target)) {
> +        /*
> +         * No need to worry about creating clusters with partial data when the
> +         * target does COW.
> +         */
> +        return 0;
> +    }
> +
> +    /*
> +     * If there is no backing file on the target, we cannot rely on COW if our
> +     * backup cluster size is smaller than the target cluster size. Even for
> +     * targets with a backing file, try to avoid COW if possible.

"Even for targes with" - I don't follow. We do "return 0" already above for such targets?

> +     */
> +    ret = bdrv_get_info(target, &bdi);
> +    if (ret == -ENOTSUP) {
> +        /*
> +         * Ignore if unable to get the info, e.g. when target is NBD. It's only
> +         * relevant for syncing to a diff image and the documentation already
> +         * states that the target's cluster size needs to small enough then.
> +         */
> +        return 0;
> +    } else if (ret < 0) {
> +        error_setg_errno(errp, -ret,
> +            "Couldn't determine the cluster size of the target image, "
> +            "which has no backing file");
> +        return ret;
> +    }
> +
> +    bitmap_granularity = bdrv_dirty_bitmap_granularity(bitmap);
> +    if (bitmap_granularity < bdi.cluster_size ||
> +        bitmap_granularity % bdi.cluster_size != 0) {
> +        error_setg(errp, "Bitmap granularity %u is not a multiple of the "
> +                   "target image's cluster size %u and the target image has "
> +                   "no backing file",
> +                   bitmap_granularity, bdi.cluster_size);
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +
>   /* Parameter check and block job starting for drive mirroring.
>    * Caller should hold @device and @target's aio context (must be the same).
>    **/
> @@ -2863,6 +2916,10 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
>               return;
>           }
>   
> +        if (blockdev_mirror_check_bitmap_granularity(target, bitmap, errp)) {
> +            return;
> +        }
> +
>           if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, errp)) {
>               return;
>           }
> diff --git a/tests/qemu-iotests/tests/mirror-bitmap b/tests/qemu-iotests/tests/mirror-bitmap
> index 37bbe0f241..e8cd482a19 100755
> --- a/tests/qemu-iotests/tests/mirror-bitmap
> +++ b/tests/qemu-iotests/tests/mirror-bitmap
> @@ -584,6 +584,12 @@ def test_mirror_api():
>                                   bitmap=bitmap)
>                   log('')
>   
> +        log("-- Test bitmap with too small granularity to non-COW target --\n")
> +        vm.qmp_log("block-dirty-bitmap-add", node=drive0.node,
> +                   name="bitmap-small", granularity=GRANULARITY)
> +        blockdev_mirror(drive0.vm, drive0.node, "mirror_target", "full",
> +                        job_id='api_job', bitmap="bitmap-small")
> +        log('')
>   
>   def main():
>       for bsync_mode in ("never", "on-success", "always"):
> diff --git a/tests/qemu-iotests/tests/mirror-bitmap.out b/tests/qemu-iotests/tests/mirror-bitmap.out
> index 5c8acc1d69..af605f3803 100644
> --- a/tests/qemu-iotests/tests/mirror-bitmap.out
> +++ b/tests/qemu-iotests/tests/mirror-bitmap.out
> @@ -3189,3 +3189,10 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
>   {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "sync": "none", "target": "mirror_target"}}
>   {"error": {"class": "GenericError", "desc": "Sync mode 'none' not supported with bitmap."}}
>   
> +-- Test bitmap with too small granularity to non-COW target --
> +
> +{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "bitmap-small", "node": "drive0"}}
> +{"return": {}}
> +{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap-small", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "sync": "full", "target": "mirror_target"}}
> +{"error": {"class": "GenericError", "desc": "Bitmap granularity 65536 is not a multiple of the target image's cluster size 131072 and the target image has no backing file"}}
> +

-- 
Best regards,
Vladimir


