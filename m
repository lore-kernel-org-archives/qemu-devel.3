Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB99C55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqrfZ-0008UJ-0s; Mon, 03 Aug 2026 08:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqrfV-0008Tt-UY
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 08:21:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqrfU-0000og-GY
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 08:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785759678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ImKDnu/DXiRULUxoPjPgQ+NFqnyR9Oyx6v/LfSKDPJ4=;
 b=HDsDtzJvXyp3ZvFBz58MixTHXo4Qf98grBsLEsGt+nKUBofStMrJJEf9/7Hjs+1sh4jwSg
 nGv+pAq/k+7tt3SU3uqcqHAhNjXXGhEBLRCQaz6xWR5NC6JiMHmy4iZIWxq+Q9V3iqC5VZ
 ibVgPiXP0UuB5RlP36//aDA10S89iO0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-JR8CPQ5RNySVsT2gnTbsRQ-1; Mon, 03 Aug 2026 08:21:17 -0400
X-MC-Unique: JR8CPQ5RNySVsT2gnTbsRQ-1
X-Mimecast-MFC-AGG-ID: JR8CPQ5RNySVsT2gnTbsRQ_1785759676
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f8398ed9fso3170207f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 05:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785759676; x=1786364476; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ImKDnu/DXiRULUxoPjPgQ+NFqnyR9Oyx6v/LfSKDPJ4=;
 b=OOle2Jb9Ln40W0LlXXkfQocysFYdLUxgJpF/XLoq8XZmQpVIPmB7sP30nYBB9YgX49
 WXkXMcY2rDYOnwR0Y882jzTsG+qqv2XkNe9wSKQl2/oGEvvnfGIaX77NCcmTkTKq/9+W
 SJxCs/EKrhbXPvHFwwe/MvlDiPHH+y35joUpnGPJZlfp7e3qW1his98LuQzwEr597JzG
 44m/sSi4mGCUIisyfBeOuVCoFEl30vxdX3Puur3y9Tr2KPDh/sbbMwr2eadLJaXaqQAI
 zyd4x6HwoAHvPlt9uPIVqNvSNIhFFle27vL51S2IuwEQnV3dyg8zzJt1cCMhUdmO1+eU
 L1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785759676; x=1786364476;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ImKDnu/DXiRULUxoPjPgQ+NFqnyR9Oyx6v/LfSKDPJ4=;
 b=Prq+9IoEmaMXckYAAwb8hvwAVxk4VH9YF2W0U3E49l7aqHFR34OuF7/+c+kcOQO7kS
 amHWpXMciEz45O7iQT9XgXnkhqSQJFQXZUnOsi5o5iX6J+hOXFES49gXSVGB5lHQVDxs
 hjxYSPlWNt9d8B/psWFbo3EqWe3hjCUI2LfI9ONTLioUvFOjXaQaNKxvnTXHbEa3uAXq
 Uh9DYIrpfm39bMpxPmTvY7w3NiV843KAsWpD2KxumK464vLjBqzCHIQKy6S4RFpIg/18
 AiOELNG5rOn2WYhncwamcYPxB7m0TXJzFTTTSSJpt/jFkbkXbCyhomVKp3pVCT87MsVc
 t0/A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr4z/9+OLozY3iaciMs4Qk6q7rTk9zTI823k0khF9cGijFoTI3Fj6VoA1k/g0CmZ8IGf4bmFnaLtDDg@nongnu.org
X-Gm-Message-State: AOJu0YxghRbQ8z9Bq4/ntoQw01SS8zfJtcEa3wX8lrfXjjMtG6sbx080
 95kAH69YWKhLqJQO0nNT/lTlG39YcPzccp+z3WVvxN/iHB4D1PgLSQEummLfOAJM8Y0qG0B/7Vz
 odTKLjZtx+rh8Y3hIDIitUwtiNb6zhE7qep4Rrq33i8QWQ/TvpgcTuYa2
X-Gm-Gg: AR+sD10s3ygD9AF5duVCAg3ux9tIvfAKChTqnxAR1gprujSO6rGDhpls32Nla+jGgBI
 KSkREI28R89IMCxDHnU0ZGIluGlk7Rhib3p7M+VEu/rXcUbDSdv+efJWwkUnGHhH/2SomM7Q4j2
 HQ3RTzpZQGF5abK0uK9TY1NYVLJFMcY1UidVNv39lLeZkP4R99igOTY3AYyiQskCckzaT7kbShV
 bPcil4uy6psFzeKRBea4YhP4DxYcJ68tzrhFW8gJeYbOshHQyXA2Uq8BhZXvGIwdgLOgbXakW2b
 SILIqWGo19lsUay4VqotHsVHprX1Pi6tUpBsWidjaLwbGQy+JN3QEKpOXyxw1gumcynrlUr2u0u
 BIN8JkXXbX48D+mNJZxSad1O/N5OMw5Fp27J+AwXAANIxj0rrto+yDl/ruEJkYqAHM4bOLeihW4
 yhmYZAWgtZtQTF0EtupoFLmnfTJ/HjdA==
X-Received: by 2002:a5d:588e:0:b0:47f:e721:1f77 with SMTP id
 ffacd0b85a97d-47fe7211fedmr2880290f8f.13.1785759675755; 
 Mon, 03 Aug 2026 05:21:15 -0700 (PDT)
X-Received: by 2002:a5d:588e:0:b0:47f:e721:1f77 with SMTP id
 ffacd0b85a97d-47fe7211fedmr2880140f8f.13.1785759675111; 
 Mon, 03 Aug 2026 05:21:15 -0700 (PDT)
Received: from ?IPV6:2003:cf:d73d:549a:e584:7c7b:2611:32a1?
 (p200300cfd73d549ae5847c7b261132a1.dip0.t-ipconnect.de.
 [2003:cf:d73d:549a:e584:7c7b:2611:32a1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0ae0sm33651014f8f.33.2026.08.03.05.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 05:21:14 -0700 (PDT)
Message-ID: <eb1d8424-206a-47f5-9ad5-a833a56bb3f3@redhat.com>
Date: Mon, 3 Aug 2026 14:21:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 02/15] vhost-user: Add memory-isolation qdev property
 to vhost-user devices
To: ConKite <connorkite@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 Demi Marie Obenour <demiobenour@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-2-6b97c439eb28@gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-2-6b97c439eb28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24.07.26 00:30, ConKite wrote:
> In support of future work to add a memory isolation mode to vhost-user devices, a
> qdev property, "memory-isolation", is added to all vhost-user devices. This is
> simply a bool representing whether the mode is active or not.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   hw/block/vhost-user-blk.c            | 1 +
>   hw/display/vhost-user-gpu.c          | 1 +
>   hw/scsi/vhost-user-scsi.c            | 1 +
>   hw/virtio/vhost-user-base.c          | 3 ++-
>   hw/virtio/vhost-user-fs.c            | 1 +
>   hw/virtio/vhost-user-scmi.c          | 1 +
>   hw/virtio/vhost-user-vsock.c         | 1 +
>   include/hw/virtio/vhost-user-base.h  | 1 +
>   include/hw/virtio/vhost-user-blk.h   | 1 +
>   include/hw/virtio/vhost-user-fs.h    | 1 +
>   include/hw/virtio/vhost-user-scmi.h  | 1 +
>   include/hw/virtio/vhost-user-vsock.h | 1 +
>   include/hw/virtio/virtio-gpu.h       | 1 +
>   include/hw/virtio/virtio-scsi.h      | 1 +
>   14 files changed, 15 insertions(+), 1 deletion(-)

Should `vhost_user_vga_inst_initfn()` set up an alias for 
"memory-isolation", like it does for "chardev" now?

There are four lines in here that the checkpatch script notes to be over 
80 characters in length, so they should be broken up.

[...]

> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index 90bd2903db..d2a74a2860 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -409,7 +409,8 @@ static void vub_device_unrealize(DeviceState *dev)
>   
>   /*Define common qdev properties.  Inherited by all children*/
>   static const Property vub_properties[] = {
> -    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev)
> +    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
> +    DEFINE_PROP_BOOL("memory-isolation", VHostUserBase, memory_isolation, false)

Nitpick: I would add a comma here. (This hunk shows specifically why 
it’s a good idea: So that future additions don’t have to change the line 
to add the comma.)

Hanna


