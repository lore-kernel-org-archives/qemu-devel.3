Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC38C83F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Jul 2025 10:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udRX1-00055W-Pb; Sun, 20 Jul 2025 06:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udRX0-00050E-7o
 for qemu-devel@nongnu.org; Sun, 20 Jul 2025 06:44:34 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udRWx-0001i5-V7
 for qemu-devel@nongnu.org; Sun, 20 Jul 2025 06:44:33 -0400
Received: from [157.82.206.39] ([157.82.206.39]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56KAiFRB082285
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 20 Jul 2025 19:44:15 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=VvozVuV3A7sE3leo2ZyKCEKayEpazTyAbW7tl9O7918=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1753008255; v=1;
 b=W37kaQjxHyqzcDjpEI2RbxZUfOQOIT8LkYdtQ3dOfa7Ee4z+IXHsU5iLtNT0xA8g
 bY07JRr6acpAFFbkCtmytWdR9zW/RnqzUeVi6m6+7Ok9bEd/G9LBoUrS1pYQJy71
 BKwkUjJ43AQe2k3h8tt9vLdZApU7FIe0Shk8gIapnjYEbrCBMt5IN6IhIQTGfs2U
 pAG+1hGjYumrQWRc7eJFYdZSAZu+DoqNsCyJsQxWcF9fYMlfSLfSbbh+ydza+FxD
 nNsTohtBkEuueo73epCloB8t0f4UShWwkOP5lerkMn1FDtAg62kNIqZHCuruYcB/
 m8mFyDIwnso09TLj28/nWA==
Message-ID: <2e3a7cbd-1055-4888-9577-3344d42ea050@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 20 Jul 2025 19:44:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 04/13] virtio: serialize extended features state
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
 <88978e62d3eb7a58d7d647c7ee29f074ccc99bc0.1752828082.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <88978e62d3eb7a58d7d647c7ee29f074ccc99bc0.1752828082.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/07/18 17:52, Paolo Abeni wrote:
> If the driver uses any of the extended features (i.e. 64 or above),
> store the extended features range (64-127 bits).
> 
> At load time, let legacy features initialize the full features range
> and pass it to the set helper; sub-states loading will have filled-up
> the extended part as needed.
> 
> This is one of the few spots that need explicitly to know and set
> in stone the extended features array size; add a build bug to prevent
> breaking the migration should such size change again in the future:
> more serialization plumbing will be needed.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
>   - 128bit_features state load/stores only the high bits
>   - consolidate the load implementation to use a single set
>     helper for 128/64/32 bits features
>   - _array -> _ex
> 
> v1 -> v2:
>   - uint128_t -> u64[2]
> ---
>   hw/virtio/virtio.c | 88 ++++++++++++++++++++++++++++++----------------
>   1 file changed, 57 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 2ab1d20769..2817d3a893 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2954,6 +2954,24 @@ static const VMStateDescription vmstate_virtio_disabled = {
>       }
>   };
>   
> +static bool virtio_128bit_features_needed(void *opaque)
> +{
> +    VirtIODevice *vdev = opaque;
> +
> +    return virtio_features_use_extended(vdev->host_features_ex);
> +}
> +
> +static const VMStateDescription vmstate_virtio_128bit_features = {
> +    .name = "virtio/128bit_features",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = &virtio_128bit_features_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64(guest_features_ex[1], VirtIODevice),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static const VMStateDescription vmstate_virtio = {
>       .name = "virtio",
>       .version_id = 1,
> @@ -2963,6 +2981,7 @@ static const VMStateDescription vmstate_virtio = {
>       },
>       .subsections = (const VMStateDescription * const []) {
>           &vmstate_virtio_device_endian,
> +        &vmstate_virtio_128bit_features,
>           &vmstate_virtio_64bit_features,
>           &vmstate_virtio_virtqueues,
>           &vmstate_virtio_ringsize,
> @@ -3059,23 +3078,28 @@ const VMStateInfo  virtio_vmstate_info = {
>       .put = virtio_device_put,
>   };
>   
> -static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val)
> +static int virtio_set_features_nocheck(VirtIODevice *vdev, const uint64_t *val)
>   {
>       VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
> -    bool bad = (val & ~(vdev->host_features)) != 0;
> +    uint64_t tmp[VIRTIO_FEATURES_DWORDS];
> +    bool bad;
> +
> +    bad = virtio_features_andnot(tmp, val, vdev->host_features_ex);
> +    virtio_features_and(tmp, val, vdev->host_features_ex);
>   
> -    val &= vdev->host_features;
>       if (k->set_features) {
> -        k->set_features(vdev, val);
> +        bad = bad || virtio_features_use_extended(tmp);
> +        k->set_features(vdev, tmp[0]);
>       }
> -    vdev->guest_features = val;
> +
> +    virtio_features_copy(vdev->guest_features_ex, tmp);
>       return bad ? -1 : 0;
>   }
>   
>   typedef struct VirtioSetFeaturesNocheckData {
>       Coroutine *co;
>       VirtIODevice *vdev;
> -    uint64_t val;
> +    uint64_t val[VIRTIO_FEATURES_DWORDS];
>       int ret;
>   } VirtioSetFeaturesNocheckData;
>   
> @@ -3088,14 +3112,15 @@ static void virtio_set_features_nocheck_bh(void *opaque)
>   }
>   
>   static int coroutine_mixed_fn
> -virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev, uint64_t val)
> +virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev,
> +                                     const uint64_t *val)
>   {
>       if (qemu_in_coroutine()) {
>           VirtioSetFeaturesNocheckData data = {
>               .co = qemu_coroutine_self(),
>               .vdev = vdev,
> -            .val = val,
>           };
> +        virtio_features_copy(data.val, val);
>           aio_bh_schedule_oneshot(qemu_get_current_aio_context(),
>                                   virtio_set_features_nocheck_bh, &data);
>           qemu_coroutine_yield();
> @@ -3107,6 +3132,7 @@ virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev, uint64_t val)
>   
>   int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>   {
> +    uint64_t features[VIRTIO_FEATURES_DWORDS];
>       int ret;
>       /*
>        * The driver must not attempt to set features after feature negotiation
> @@ -3122,7 +3148,8 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>                         __func__, vdev->name);
>       }
>   
> -    ret = virtio_set_features_nocheck(vdev, val);
> +    virtio_features_from_u64(features, val);
> +    ret = virtio_set_features_nocheck(vdev, features);
>       if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
>           /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
>           int i;
> @@ -3145,6 +3172,7 @@ void virtio_reset(void *opaque)
>   {
>       VirtIODevice *vdev = opaque;
>       VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
> +    uint64_t features[VIRTIO_FEATURES_DWORDS];
>       int i;
>   
>       virtio_set_status(vdev, 0);
> @@ -3171,7 +3199,8 @@ void virtio_reset(void *opaque)
>       vdev->start_on_kick = false;
>       vdev->started = false;
>       vdev->broken = false;
> -    virtio_set_features_nocheck(vdev, 0);
> +    virtio_features_clear(features);
> +    virtio_set_features_nocheck(vdev, features);
>       vdev->queue_sel = 0;
>       vdev->status = 0;
>       vdev->disabled = false;
> @@ -3254,7 +3283,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>        * Note: devices should always test host features in future - don't create
>        * new dependencies like this.
>        */
> -    vdev->guest_features = features;
> +    virtio_features_from_u64(vdev->guest_features_ex, features);
>   
>       config_len = qemu_get_be32(f);
>   
> @@ -3333,26 +3362,23 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>           vdev->device_endian = virtio_default_endian();
>       }
>   
> -    if (virtio_64bit_features_needed(vdev)) {
> -        /*
> -         * Subsection load filled vdev->guest_features.  Run them
> -         * through virtio_set_features to sanity-check them against
> -         * host_features.
> -         */
> -        uint64_t features64 = vdev->guest_features;
> -        if (virtio_set_features_nocheck_maybe_co(vdev, features64) < 0) {
> -            error_report("Features 0x%" PRIx64 " unsupported. "
> -                         "Allowed features: 0x%" PRIx64,
> -                         features64, vdev->host_features);
> -            return -1;
> -        }
> -    } else {
> -        if (virtio_set_features_nocheck_maybe_co(vdev, features) < 0) {
> -            error_report("Features 0x%x unsupported. "
> -                         "Allowed features: 0x%" PRIx64,
> -                         features, vdev->host_features);
> -            return -1;
> -        }
> +    /*
> +     * Avoid silently breaking migration should the feature space increase
> +     * even more in the (far away) future
> +     */
> +    QEMU_BUILD_BUG_ON(VIRTIO_FEATURES_DWORDS != 2);

This should be moved to around virtio_128bit_features_needed() and 
vmstate_virtio_128bit_features as they make assumptions on the feature 
space while virtio_load() doesn't.

> +
> +    /*
> +     * guest_features_ex is fully initialized with u32 features and upper
> +     * bits have been filled as needed by the later load.
> +     */
> +    if (virtio_set_features_nocheck_maybe_co(vdev,
> +                                             vdev->guest_features_ex) < 0) {
> +        error_report("Features 0x" VIRTIO_FEATURES_FMT " unsupported. "
> +                     "Allowed features: 0x" VIRTIO_FEATURES_FMT,
> +                     VIRTIO_FEATURES_PR(vdev->guest_features_ex),
> +                     VIRTIO_FEATURES_PR(vdev->host_features_ex));
> +        return -1;
>       }
>   
>       if (!virtio_device_started(vdev, vdev->status) &&


