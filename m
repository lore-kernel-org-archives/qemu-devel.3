Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9243DC531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 20:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnjNR-000114-C1; Sat, 25 Jul 2026 16:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wnjNP-00010F-QD
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 16:53:43 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wnjNO-0007y5-38
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 16:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=dVGuFx9Bjc02SoFq7SUdMAn8d9kxRJ0sXg9Xlst9b5A=; b=gyD5U4e/U1WLaq7y
 kFBI8TEVTyMTGT2IPtiV3Ik7akkoZG4vHqhxvCakKUoG1qy8MPGck7uyA3Cm9GS0Fx9FNQOBx/FF5
 wWEz0L+DFg2BpEDJ5mBwlS1ktnvWPGfd+M6m3L6TWkT8f5VobjD4OfJSrdNby6yKTW33+txfVVICL
 KwyKH7krTuWp65X2fwIQMNwXcb509l3GoxV3mCKzA9HIhz9tYrthSX71jUN/Qf+ZTQk26xpAt9ETx
 0Mxg0iXfompjvsV0TBwV8f2QFkiQTWeUL7y2BL2w5ULB7K8MXndE2FpzgvsFHXX6lRLMqynzi/6g6
 wVaUPMCMvU1V1SEXIg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wnjNJ-00000005Upo-36wS;
 Sat, 25 Jul 2026 20:53:37 +0000
Date: Sat, 25 Jul 2026 20:53:37 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio: fail early on bad config_len in migration
Message-ID: <amUiUdfC2kpx1qLq@gallifrey>
References: <cfbefa358af5885eb386637216552bfeba5e7bbc.1784898922.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <cfbefa358af5885eb386637216552bfeba5e7bbc.1784898922.git.mst@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.95+deb13-amd64 (x86_64)
X-Uptime: 20:49:41 up 19 days, 20:30,  2 users,  load average: 0.01, 0.01, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
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

* Michael S. Tsirkin (mst@redhat.com) wrote:
> virtio_load() attempts to load config_len bytes from the migration
> stream. If that's huge (e.g. 4g) this will uselessly spin
> beyond the end of the stream for seconds. Not nice.
> Check qemu_file_get_error() and bail out early, instead.
> 
> Also note that config_len is int32_t but is coerced to unsigned when
> used. Switch it to uint32_t to make this clearer.

That in a way feels like the more important fix (I hate to
think what that MIN(int32_t, size_t) does.

> Fixes: 2f5732e964 ("Allow mismatched virtio config-len")
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3891
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  hw/virtio/virtio.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 8add4d5d99..72d828d33f 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3516,7 +3516,7 @@ int coroutine_mixed_fn
>  virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>  {
>      int i, ret;
> -    int32_t config_len;
> +    uint32_t config_len;
>      uint32_t num;
>      uint32_t features;
>      BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
> @@ -3564,6 +3564,9 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>      qemu_get_buffer(f, vdev->config, MIN(config_len, vdev->config_len));
>  
>      while (config_len > vdev->config_len) {
> +        if (qemu_file_get_error(f)) {
> +            return -1;
> +        }
>          qemu_get_byte(f);
>          config_len--;
>      }
> -- 
> MST
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

