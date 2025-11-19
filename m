Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308EDCF3186
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 10:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLf1i-00041S-Fn; Wed, 19 Nov 2025 05:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vLf1g-00040R-Bp
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 05:03:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vLf1e-0007Pj-Pv
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 05:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763546576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ueW6kc+kjK+7+P2KHDZOKQE0jGiK6isLPjvRHxGahek=;
 b=VIBikGT8rIWDd29Gwtrntqdj40xBL5xQ70k/8BiQyNYrXTFc9DAbuUnC4NV2zeYIzs9qqy
 IuzysG52GVETC/sbR0Lhp7AaK6pn2M8Pi5b0C01WUd2y/3N23ty6TtGq3YJ7FPR1xkekr6
 ADrdpK/sJjvVW/PQ2Logp1N5DEu9rnE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-QOgvUw_HMNCIzSNUYCBdOw-1; Wed, 19 Nov 2025 05:02:54 -0500
X-MC-Unique: QOgvUw_HMNCIzSNUYCBdOw-1
X-Mimecast-MFC-AGG-ID: QOgvUw_HMNCIzSNUYCBdOw_1763546574
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b56125e77so3310218f8f.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 02:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763546574; x=1764151374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ueW6kc+kjK+7+P2KHDZOKQE0jGiK6isLPjvRHxGahek=;
 b=VGwxlx56OsTVvg0P9ghbgrfCQE3eYUdsMkEHoahVlqHdWuVG0irZOsPGPVA/cHUxVg
 0OLeAa09PtE+mvdnrSkfXHpi+jT07RO6qP4HCqqtAymNv42PiKq891ZMnW57FQpmtWsB
 xtJt+ACCEF9NrIQ8bU3l/5jpup7xtDCvNFWBaxcSP20bR5pGMHQs+5rzvPnDwE20P7gO
 1mZQU/xN3VUGgq9VtNU5uxuCKx4K5YQ57dk9xvBoePQ64N7DhGEv4XGRfEbRhc0v19X9
 p6qER4OWEt1TK70SUAeHpPzXT7uTbMJLg70BemB2nWgzy6ZgN9z4dJSY+bAFCoSLe9wl
 cnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763546574; x=1764151374;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ueW6kc+kjK+7+P2KHDZOKQE0jGiK6isLPjvRHxGahek=;
 b=ALRS5jHz0VfSYwOKhX8fohJCkCEuvygy3+TOS4mOGE2ARSdvoODh4Gy0WxKRwVDVoj
 ICMKw3t+7HiaGFLfy1ahyzJU8L30J4nNtcH9JdJyB7STqCHhBdIRqyhtYddSc+KFW9jY
 orMmVVbyX32WQt5ZVF2iJa9i1PqNcWAMt2lfuFLHtvlKjjOaZsPtQsuSR5Ku9+FKL0zx
 zCYUE5q6LGC2GNBewOu7XNaHL++AfeFVRYm5oYSjBvSHU7EQ0V5W8Tg82JsyFBPpgqW1
 6rVmLKW+DH4rO4ycUW60q6snpB6eTgSggPnmirMH6fiFteHU/JOr32pXsvk+CTR5zRFv
 opWw==
X-Gm-Message-State: AOJu0YyP0A4Q5b4mrLcZhom9Xk16WUlSA5EINzTc0ooyvD1QMOp77i/G
 3Lg8nxdXQMXE8JjP9j13j8+n3RfHq1RpePpcvBgGSj1fVmfDTz9yGp7KYHK/nNMs9yZr0iY7NDb
 vSSh038iGmDWBMVOIf1b79jNDbV9Ab0Fb7C2KwNEul/oXbFpT9bou/L6Y
X-Gm-Gg: ASbGncs8uv0ui9S2EJCxOVT9EYzO0HbFquLX0VoQWmIf5vti6EUY+As4Su4TBXOv/Bs
 ATCOMqUfzkDS+FkI6f+q9IyT09bkA2WcJWsWtSQeVyh46+gRjeerFGN9Jf69GWY5ex5ycHJCz1o
 +2NdvFhSphyBMrTZ4PSK9sBucktgH7zGHQoKI+t4aBSTuJLN+E4hsk9Qp/3peyqZBvPiVWiESBj
 a03a2xYcCOOk6XTVIwpv4j4Iq81O7bTpnOtUXfjkhjr3kaTtJhrwO+2vx71xfxTWeWqqQA+LFCt
 8Z21v/9sErkXGSeAklXvS6+pMTob692IVyKxUAlMpDaRjXmVHONlE6L8lNiDo+zs2j9e1EkStdP
 1WqsU4CzD3o8gE/UCq7rYtAUd0ume4btNGAX6Vu0rwLm0kerS
X-Received: by 2002:a05:6000:26cf:b0:3ec:ea73:a91e with SMTP id
 ffacd0b85a97d-42b593457f8mr19401971f8f.12.1763546573660; 
 Wed, 19 Nov 2025 02:02:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEN+GqXqzZCrTNvUgd/CkoCOJ47rqqF7uTuB4nPFCswHjciZomZbsxD3wt4czy4+Cmawz9aoQ==
X-Received: by 2002:a05:6000:26cf:b0:3ec:ea73:a91e with SMTP id
 ffacd0b85a97d-42b593457f8mr19401916f8f.12.1763546573144; 
 Wed, 19 Nov 2025 02:02:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae88sm36409120f8f.6.2025.11.19.02.02.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 02:02:52 -0800 (PST)
Message-ID: <521156ea-43f4-47cf-9e77-2310ff206ec1@redhat.com>
Date: Wed, 19 Nov 2025 11:02:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/s390x: Fix a possible crash with passed-through
 virtio devices
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20251118174047.73103-1-thuth@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251118174047.73103-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/18/25 18:40, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Consider the following nested setup: An L1 host uses some virtio device
> (e.g. virtio-keyboard) for the L2 guest, and this L2 guest passes this
> device through to the L3 guest. Since the L3 guest sees a virtio device,
> it might send virtio notifications to the QEMU in L2 for that device.
> But since the QEMU in L2 defined this device as vfio-ccw, the function
> handle_virtio_ccw_notify() cannot handle this and crashes: It calls
> virtio_ccw_get_vdev() that casts sch->driver_data into a VirtioCcwDevice,
> but since "sch" belongs to a vfio-ccw device, that driver_data rather
> points to a CcwDevice instead. So as soon as QEMU tries to use some
> VirtioCcwDevice specific data from that device, we've lost.
> 
> We must not take virtio notifications for such devices. Thus fix the
> issue by adding a check to the handle_virtio_ccw_notify() handler to
> refuse all devices that are not our own virtio devices. Like in the
> other branches that detect wrong settings, we return -EINVAL from the
> function, which will later be placed in GPR2 to inform the guest about
> the error.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v3: Print the subchannel number to ease debugging
> 
>   hw/s390x/s390-hypercall.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
> index ac1b08b2cd5..508dd97ca0d 100644
> --- a/hw/s390x/s390-hypercall.c
> +++ b/hw/s390x/s390-hypercall.c
> @@ -10,6 +10,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "cpu.h"
>   #include "hw/s390x/s390-virtio-ccw.h"
>   #include "hw/s390x/s390-hypercall.h"
> @@ -42,6 +43,19 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, uint64_t data)
>       if (!sch || !css_subch_visible(sch)) {
>           return -EINVAL;
>       }
> +    if (sch->id.cu_type != VIRTIO_CCW_CU_TYPE) {
> +        /*
> +         * This might happen in nested setups: If the L1 host defined the
> +         * L2 guest with a virtio device (e.g. virtio-keyboard), and the
> +         * L2 guest passes this device through to the L3 guest, the L3 guest
> +         * might send virtio notifications to the QEMU in L2 for that device.
> +         * But since the QEMU in L2 defined this device as vfio-ccw, it's not
> +         * a VirtIODevice that we can handle here!
> +         */
> +        warn_report_once("Got virtio notification for unsupported device "
> +                         "on subchannel %02x.%1x.%04x!", cssid, ssid, schid);
> +        return -EINVAL;
> +    }
>   
>       vdev = virtio_ccw_get_vdev(sch);

While at it, it would be good to test 'vdev' and return -EINVAL as in
virtio_ccw_set_vqs().

In virtio-ccw.c, this needs some care I think :

    static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
    {
        ...
        VirtioCcwDevice *dev = sch->driver_data;
        VirtIODevice *vdev = virtio_ccw_get_vdev(sch);
        ...
        if (!dev) {                <-- vdev ?
           return -EINVAL;
        }


Thanks,

C.

  

>       if (vq_idx >= VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev, vq_idx)) {


