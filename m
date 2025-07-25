Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65318C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 07:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufCSU-0008ST-BR; Fri, 25 Jul 2025 03:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ufCHK-0003aD-T6
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 02:51:38 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ufCHH-0007Qx-WD
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 02:51:38 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56P6pGVb000912
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 25 Jul 2025 15:51:16 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=urVX6VNtr/giG2JufrS3v1GX5MVTsNTLsBLIPmNQ+CE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1753426276; v=1;
 b=ZsvXKu6syqIfWMYrUbakjBPz6mRzuQGUzKthMHv1AQuDwC+CLSP9tCEVfAgdeuUI
 tey+bFc0DrOa7id7fl6yIGvDyxvE2WtVvtYhKkVeg1hU3smVQK1AJ03jF77CVpGG
 R0YCa5UtsW0xuYASZ/mqnF4vJch4yiETLlJvw7dMk0AEbKSB/RjK90UqS/8GG+q8
 NMnyhyi3v15ca5xL2pnJbDEOANsfToiBfoYE291WDDeZtmO3LysXoqefwsIZ+3ai
 zNA1gZ4fNii9aL83nTT2WwWkT2Jzg1fdTOnpJhn8m6fAk1Oq4PpZkfI7glwsYBBv
 XJ5k9Mnw65DGOjobmKVuVA==
Message-ID: <85865cbf-cd91-4d43-aab2-0d32188ab96a@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 25 Jul 2025 15:51:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 06/14] virtio: add support for negotiating extended
 features
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
References: <cover.1753297661.git.pabeni@redhat.com>
 <9c09cad354aaeda4a4925650c782ff7642da593e.1753297661.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <9c09cad354aaeda4a4925650c782ff7642da593e.1753297661.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/07/24 4:31, Paolo Abeni wrote:
> The virtio specifications allows for up to 128 bits for the
> device features. Soon we are going to use some of the 'extended'
> bits features for the virtio net driver.
> 
> Add support to allow extended features negotiation on a per
> devices basis. Devices willing to negotiated extended features
> need to implemented a new pair of features getter/setter, the
> core will conditionally use them instead of the basic one.
> 
> Note that 'bad_features' don't need to be extended, as they are
> bound to the 64 bits limit.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v3 -> v4:
>    - use new virtio_features macro names
> 
> v2 -> v3:
>    - _array -> _ex
> 
> v1 -> v2:
>    - uint128_t -> uint64_t[]
> ---
>   hw/virtio/virtio-bus.c     | 11 ++++++++---
>   hw/virtio/virtio.c         | 18 +++++++++++++-----
>   include/hw/virtio/virtio.h |  4 ++++
>   3 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index 11adfbf3ab..cef944e015 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -62,9 +62,14 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
>       }
>   
>       /* Get the features of the plugged device. */
> -    assert(vdc->get_features != NULL);
> -    vdev->host_features = vdc->get_features(vdev, vdev->host_features,
> -                                            &local_err);
> +    if (vdc->get_features_ex) {
> +        vdc->get_features_ex(vdev, vdev->host_features_ex, &local_err);
> +    } else {
> +        assert(vdc->get_features != NULL);
> +        virtio_features_from_u64(vdev->host_features_ex,
> +                                 vdc->get_features(vdev, vdev->host_features,
> +                                                   &local_err));
> +    }
>       if (local_err) {
>           error_propagate(errp, local_err);
>           return;
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index c6896e000c..a7c695f633 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3093,7 +3093,9 @@ static int virtio_set_features_nocheck(VirtIODevice *vdev, const uint64_t *val)
>       bad = virtio_features_andnot(tmp, val, vdev->host_features_ex);
>       virtio_features_and(tmp, val, vdev->host_features_ex);
>   
> -    if (k->set_features) {
> +    if (k->set_features_ex) {
> +        k->set_features_ex(vdev, val);
> +    } else if (k->set_features) {
>           bad = bad || virtio_features_use_ex(tmp);
>           k->set_features(vdev, tmp[0]);
>       }
> @@ -3136,9 +3138,8 @@ virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev,
>       }
>   }
>   
> -int virtio_set_features(VirtIODevice *vdev, uint64_t val)
> +int virtio_set_features_ex(VirtIODevice *vdev, const uint64_t *features)
>   {
> -    uint64_t features[VIRTIO_FEATURES_NU64S];
>       int ret;
>       /*
>        * The driver must not attempt to set features after feature negotiation
> @@ -3148,13 +3149,12 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>           return -EINVAL;
>       }
>   
> -    if (val & (1ull << VIRTIO_F_BAD_FEATURE)) {
> +    if (features[0] & (1ull << VIRTIO_F_BAD_FEATURE)) {
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "%s: guest driver for %s has enabled UNUSED(30) feature bit!\n",
>                         __func__, vdev->name);
>       }
>   
> -    virtio_features_from_u64(features, val);
>       ret = virtio_set_features_nocheck(vdev, features);
>       if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
>           /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
> @@ -3174,6 +3174,14 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>       return ret;
>   }
>   
> +int virtio_set_features(VirtIODevice *vdev, uint64_t val)
> +{
> +    uint64_t features[VIRTIO_FEATURES_NU64S];
> +
> +    virtio_features_from_u64(features, val);
> +    return virtio_set_features_ex(vdev, features);
> +}
> +

Nitpick: this patch will be smaller by a few lines if you move 
virtio_set_features() before virtio_set_features_ex(). It will also 
align the order of these functions with the header file.

>   void virtio_reset(void *opaque)
>   {
>       VirtIODevice *vdev = opaque;
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 39e4059a66..2aeb021fb3 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -178,6 +178,9 @@ struct VirtioDeviceClass {
>       /* This is what a VirtioDevice must implement */
>       DeviceRealize realize;
>       DeviceUnrealize unrealize;
> +    void (*get_features_ex)(VirtIODevice *vdev, uint64_t *requested_features,
> +                            Error **errp);
> +    void (*set_features_ex)(VirtIODevice *vdev, const uint64_t *val);
>       uint64_t (*get_features)(VirtIODevice *vdev,
>                                uint64_t requested_features,
>                                Error **errp);
> @@ -373,6 +376,7 @@ void virtio_queue_reset(VirtIODevice *vdev, uint32_t queue_index);
>   void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index);
>   void virtio_update_irq(VirtIODevice *vdev);
>   int virtio_set_features(VirtIODevice *vdev, uint64_t val);
> +int virtio_set_features_ex(VirtIODevice *vdev, const uint64_t *val);
>   
>   /* Base devices.  */
>   typedef struct VirtIOBlkConf VirtIOBlkConf;


