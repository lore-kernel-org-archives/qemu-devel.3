Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B353CCED25D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 09:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLIAy-0001BX-B8; Tue, 18 Nov 2025 04:39:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLIAw-0001BC-19
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 04:39:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLIAt-0001KH-So
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 04:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763458738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oCs5dYhKbzw0r5uwo8RePPLe35AG8E5p5mB64Z/4ZDc=;
 b=DDhlH01ptZX1qltXl1cmOyf3gzXfoocxqvVUmTBxcB6sOurNsxL2apmOSVfxLLvCpH9AE7
 ruXiNmCONBCVK7o6yfhltpr/byybt4r/M2nlhSt+aIGptU1B5ZA/VQIfCl2MlIN11K8Qvs
 L+QqmJKlVx2ZhUiUXdPRkbtBX7z0w5s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-YSdafbHuPISjf4EONhF0Mw-1; Tue, 18 Nov 2025 04:38:56 -0500
X-MC-Unique: YSdafbHuPISjf4EONhF0Mw-1
X-Mimecast-MFC-AGG-ID: YSdafbHuPISjf4EONhF0Mw_1763458735
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477a11d9f89so3540485e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 01:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763458735; x=1764063535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=oCs5dYhKbzw0r5uwo8RePPLe35AG8E5p5mB64Z/4ZDc=;
 b=WzndTHrXWELC0bwerFy7ou9GR2O5WV0zPfm+/aA61yJISLcUq69g9TqUEWc5cy0PJm
 lU9HM8ODAACCWEZ9fJ6OESn9bjWFcAy5hyAuosZppy4dCd8GZt/9xdOgZdZYbns0gX7o
 aGPRwVSg/uoin0IC0cV9B72GSMdrtbJI1dZxaP/vHfPU9ZVT63oOgWrpcb2xvvaoKVPm
 DWcyqQkDJFQzSrXOfurFCppB4SOdxo/l3NGEyssWwYgbjymzKgZbRO+497OpIXBRsWf2
 ESFZrdfOkNBM/5lyAr5yS8ewAE8UHLsBOKK6iI13ahkwPgqhohkJ7QscHyP9vqAa5Q0u
 qZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763458735; x=1764063535;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oCs5dYhKbzw0r5uwo8RePPLe35AG8E5p5mB64Z/4ZDc=;
 b=Lz1ShW2rP9j+wI9+1Xll3TG+JBbGoeJa3n05HhqYACMFPjwwC4ynk/MCDtGRWZJzl0
 fug3MxAHcMPETBh2GNNLZ/zXc24gyItRtywFuNyqtDvtYrR9XooJW4uDhefEkvDViTHg
 KDpzavmkNDZiLMaEXzOa7nHIp9aERo3xuPMUChuOwo+BkqheeeqGuT61AjDyQqs2oa2Q
 gXOQe/xu/hD5QSOp5123AyEtRKx6oNoH/S+GZVrBgYUR2p4h5PnybHrWcHBLCW0Cw7KD
 Oh+zFDOUEewBQY5FcC06oeTK+eVrvYusBDmG9opT1pEN1co3oPC2CKSH05zuHREQXH7l
 c8hA==
X-Gm-Message-State: AOJu0Yzf9pzgwAxQwRD+axHTtWk/Aa9k/Sl4KqkecX1FrPSkZAvTSiHr
 M+G10tER7Kr1lPELwt6utdEe5O3SS4GXgY9gFhCQYUyAQoKm2g36UFxEcrxJTB+z/0+U86gRg7Q
 1Y6szskCuloTx8qPNRDxSmgUVZdl1xxu80EF4gCuA+ef0BXzalvg/pdY8
X-Gm-Gg: ASbGncu3WKWTDYMQp0pak0bPhnRfx84N0maS+GQkwAC/lErsT10f2VCUEIJOKBaeoYo
 U8NQgV1Rf8gr4Bp8lLksRDKlrJP72vC7TOJtXUjH8D0jT5nZf+2sxH+oqQEqe9w6emvx19ZTxaf
 aNUQrpPHgCSfZbknXYTITHaHBtilzIjhe4/5xkXXkBytm1vb4kvXqVjdssrzg1Q9+cVcnHwsMY8
 sL27KRw+8hIaQLY6t9q2gp5ka/ZgNfnlkTY3QzvEFahdCRHIrWZFOfGryxZqzZMWo+vqvvI/FyP
 IU6KAMWTLMOI7c47dki8UqrtLVHo45fARyZ+/41rpby57OJ942G5Cab/cgJ6ukasis6Xe3aAe6x
 R+KeCHKw=
X-Received: by 2002:a05:600c:1f87:b0:471:9da:524c with SMTP id
 5b1f17b1804b1-4778fe69a76mr142336595e9.12.1763458735174; 
 Tue, 18 Nov 2025 01:38:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETQNhotT5F6bI1KrnfZFdDDxsxUaEtWXdDUVraPWIkPG3uZtZdm/dz66rYgVDRWiaX57Ypyg==
X-Received: by 2002:a05:600c:1f87:b0:471:9da:524c with SMTP id
 5b1f17b1804b1-4778fe69a76mr142336165e9.12.1763458734700; 
 Tue, 18 Nov 2025 01:38:54 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e36ca3sm380291665e9.5.2025.11.18.01.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 01:38:54 -0800 (PST)
Message-ID: <45808ab8-ea52-49ce-ac62-1609369276b6@redhat.com>
Date: Tue, 18 Nov 2025 10:38:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Fix a possible crash with passed-through virtio
 devices
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Cornelia Huck <cohuck@redhat.com>
References: <20251118093204.34324-1-thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251118093204.34324-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 18/11/2025 10.32, Thomas Huth wrote:
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
> refuse all devices that are not our own virtio devices.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/s390-hypercall.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
> index ac1b08b2cd5..7bee63aac67 100644
> --- a/hw/s390x/s390-hypercall.c
> +++ b/hw/s390x/s390-hypercall.c
> @@ -42,6 +42,18 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, uint64_t data)
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
> +        warn_report_once("Got virtio notification for unsupported device!");
> +        return -EINVAL;
> +    }
>   
>       vdev = virtio_ccw_get_vdev(sch);
>       if (vq_idx >= VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev, vq_idx)) {

Sorry, I sent out the wrong version of this patch ... please disregard, I'll 
send a v2 in a minute...

  Thomas


