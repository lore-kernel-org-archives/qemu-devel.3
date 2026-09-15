Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C63C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WPr-0000mp-Pv; Tue, 15 Sep 2026 12:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6WPY-0000je-O3
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6WPV-0008TB-5p
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789491211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hpgnVYFDsXpmpk7AB0RjNyMZXCE9ynOIqhHDigjmYc=;
 b=bPxZMgV33N+7+Y8CjMeDs0m/U9bGunqy1waiyYftNSYxiZn8spOyc2911JiY35Ot8tTLAj
 Wxwe9kf1ITjSwj/MAXQLGBrfidIwcOYlH0KBvvFJfMn2Cn9kRGJNmwBCOKeWSRb3j95E6T
 1DQVnTj1HE2un8JNmQZafqnQ9RAq7kw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-m1nETSCLMDOvErDxt6QiGw-1; Tue, 15 Sep 2026 12:53:29 -0400
X-MC-Unique: m1nETSCLMDOvErDxt6QiGw-1
X-Mimecast-MFC-AGG-ID: m1nETSCLMDOvErDxt6QiGw_1789491208
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-486f77056cfso2780261f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789491208; x=1790096008; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1hpgnVYFDsXpmpk7AB0RjNyMZXCE9ynOIqhHDigjmYc=;
 b=CR4v4fLIu9Cd/lyKlch2LuTMwkfqWovrQEVa5uDMwWx7bqKBxsoogP4Qe9Oatm6s/I
 AKOESXmI41uxYffi9wtYKKUfwLqsbyAiBJA6MNBUDeX+R8/tOwUHiGVBY7MxrXTfamXz
 m6YkiF5g0S/YzS1k0I2QsNPsSZXBwTFMMiN8JbkLvu45ECoB4hHnjxGA69k7SViQpP2h
 ddniqAgk8acUCoMrzcEl1H7bOeW1aNcNe82G9wcyieeYt2QXT9Oj9/DwIEM85QPN5nHG
 POsGolRLdsXPQoh2Hvbm0X9KizKpSuzxYLIUqmiUjz0ZesoCzYjBQ7lfjjmvvcpB55Vb
 hKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789491208; x=1790096008;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1hpgnVYFDsXpmpk7AB0RjNyMZXCE9ynOIqhHDigjmYc=;
 b=CgjRhxcAEzyo44IWjqEABerDAPer5vGdnbXCRd8/zyYO/W4X03JuwlznFo7Co8ohuZ
 CL4lAr+P27I4pF2boFZ+7tgavs4fECNzPYPI6VsNwkSV/AXOgArueixRWIMlac3Th3Pz
 x7PLaWaBUpAZuyFo45ntg3bfYd/fhHH7H5sg+R2Xhx2kRKUn6n9ikvV3tPmmn0G/eavI
 Hakz0J5wHwa+wtVq4Aq/LoI+E0hMnc/jWJ01nuHebFQJ0eR1zlHHBDNA3bDhn0UQk9J1
 J3fnMpS7t++vn0mobDEL4toYkPE/++z8seDrLtlurhLyNlrJgSYB6nwG7c3q4jNnCxLM
 2+2Q==
X-Gm-Message-State: AFuF++k9JwVVyG0RU0srv8ijkW/g+X6FM1OHOWEI3YBcMlK0dR42PFQj
 rSFTRfbLcCpmd4iVBMW2M5E197cPpLndP3LLQfBh68vCEq/Jc4DXyKtGMstxL2v5FpB0sEs6XUp
 0m2YivHLU4K9WAkn9omnOXYT5V6v58J3+UHF58maDvcvpEnhDv4RCORGu
X-Gm-Gg: AYBFou0KfKEAf4y5IqwK9Kh14zw3ljhhUXMjqpANiSy5inFKMOQkYSZ/aoVUY2q1dhr
 l8kTErCOPCaLDIUd2vR1bSafLOTw6kU7UoxHBtGHnBcw3LzCDcP8ToJr8frfjcKmYUuSgJ0TcDM
 4mTzgUHHXHKhsBiCIuVXCccsrdIQ5I2/0NtoXJBxzgSLmSF1sJJS1YG8PJ3g1DWrDE03z4XqMc3
 pxyAPx0uWVeJhp8VpAf8aFhM8N4jJGxWCM2T8oj+rQa9H0YEuITI66kbyM1nA0pju+5eFMO4jW7
 ko2EJF+TEaPgDI2F/NeHPUVI3ho59hG32dAAOjIXg11vF+taM9QjO7IpeZRIgIBflr4uw+mk/9C
 CQUeiusAz/Ei6Z/7AhJhPtvw=
X-Received: by 2002:a05:6000:46d0:b0:485:8c16:5ef3 with SMTP id
 ffacd0b85a97d-4870a9fd073mr1330565f8f.45.1789491208090; 
 Tue, 15 Sep 2026 09:53:28 -0700 (PDT)
X-Received: by 2002:a05:6000:46d0:b0:485:8c16:5ef3 with SMTP id
 ffacd0b85a97d-4870a9fd073mr1330544f8f.45.1789491207573; 
 Tue, 15 Sep 2026 09:53:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1fa70sm357947f8f.9.2026.09.15.09.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:53:27 -0700 (PDT)
Date: Tue, 15 Sep 2026 12:53:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?0J3QuNC60L7Qu9Cw0Lkg0JfQvtGA0LjQvQ==?= <zorin@swemel.ru>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com
Subject: Re: PATCH] hw/s390x/s390-hypercall: fix potential NULL dereference
 in handle_virtio_ccw_notify
Message-ID: <20260915125119-mutt-send-email-mst@kernel.org>
References: <13ad0871-44dd-40eb-aad1-d08cc2d7dfe5@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13ad0871-44dd-40eb-aad1-d08cc2d7dfe5@swemel.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 15, 2026 at 07:17:28PM +0300, Николай Зорин wrote:
> SWSA#4992cdf0-415c-45c1-be1a-71213467347d
> 
> The `virtio_ccw_get_vdev()` function can return a `NULL` pointer if the
> corresponding subchannel driver data (`sch->driver_data`) is not initialized
> or has been cleared.

and when does this happen?

> If `vdev` is `NULL`, passing it directly into `virtio_queue_get_num(vdev,
> vq_idx)`
> results in a `NULL` pointer dereference, which can lead to a hypervisor
> crash or unexpected termination of the QEMU process.
> 
> Fix this by adding an explicit check for `!vdev` before verifying the
> queue index and its capacity, returning `-EINVAL` early if the device
> is missing or not bound to the subchannel.


Please do not use this style with `` - there's no reason to. Just
say NULL -EINVAL etc normally.

> 
> Signed-off-by: Nikolay N Zorin <zorin@swemel.ru>
> ---
>  hw/s390x/s390-hypercall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
> index ac1b08b2..fd2972c0 100644
> --- a/hw/s390x/s390-hypercall.c
> +++ b/hw/s390x/s390-hypercall.c
> @@ -44,7 +44,7 @@ static int handle_virtio_ccw_notify(uint64_t subch_id,
> uint64_t data)
>      }
> 
>      vdev = virtio_ccw_get_vdev(sch);
> -    if (vq_idx >= VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev, vq_idx))
> {
> +    if (!vdev || vq_idx >= VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev,
> vq_idx)) {
>          return -EINVAL;
>      }
> -- 
> 2.43.0


