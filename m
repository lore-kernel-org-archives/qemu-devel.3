Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04142C021B6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 10:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmsZM-0005C7-UL; Tue, 25 Feb 2025 05:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tmsZL-0005BR-Eo
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 05:53:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tmsZJ-0005bw-TI
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 05:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740480820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WJvns7vtcDzwh3QaUgwTl9cp0IBPeJbK+qQt61TfqAQ=;
 b=SXgpDuLp2LZIo6cYCyZhHc3L7c4rluZNpgddfETsR8qSiMX4/mYnYOQeSnWq1XgLyxEEVj
 ueJxhSukDkgXQckLVj6ylvvvb1PW8jjCCcBjtlnFJ81/XApPq9N5HFYSvZ/zbfxlRrbdGs
 MfNx8DRD9viqG4dkGcOqezoyOrLiCH4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-6PrvvyYHM4yYq9hHPlwXkw-1; Tue, 25 Feb 2025 05:53:39 -0500
X-MC-Unique: 6PrvvyYHM4yYq9hHPlwXkw-1
X-Mimecast-MFC-AGG-ID: 6PrvvyYHM4yYq9hHPlwXkw_1740480819
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e5742f52896so7239246276.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 02:53:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740480818; x=1741085618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WJvns7vtcDzwh3QaUgwTl9cp0IBPeJbK+qQt61TfqAQ=;
 b=KT7Zztily7dzi6IiV9z2DeJa1sAK+zjhLfmE3S2lOsHik2r8THftxvH9nuMWwcDCwo
 M1YUIwOOxt1zXYHrPXGz7LSd6Z4WSjC0sClCaVdIoVJT7ZgEA6ZdGLmJ+IOFTvfNvUsk
 E7PJ9q4t8g5r9+jPDvRoaPSjHDhi/kqWejpxgtz0NIlKJFb1/trxPPI0KLHkz/LS2nKb
 XayQO2FUbKO7ewBpAbXTTLKG0Ia/mCX9YNz54XO6W+k65ut+RcY88st7QrVKQchq/XL0
 RtJXw0MhataydPKx0n0HPgUoWQGlGUTootIHQcCuY4h3iinO5kQbsMdlNfQAysXJvXmL
 GvRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS+ieP7/V1SRndEAS6XWjqcxMuWnRLZLIqvcCX//0eeAIj5kYOvMRtJQ8ftEg4sknSbuMBjx4r88TH@nongnu.org
X-Gm-Message-State: AOJu0Yyv5jUns41S8j/qMYNw5cXnMBZKTx2xgpS2u1FlJH9rnJhRygG5
 Law9oirU4FpsVgCOCt86ms3i8s87UMAmzyoyjq1RejDldL+eAzMD/NprAfiiI4IoPNBO+wSq3bg
 Mnu13TDbnN5Q2+YdTW4LldErz6dinpGMKGkI6gQPUZfJdtC0/fRjUORSbNoAgnKmiszovdw7BrU
 ggIP1Q2nWroU8BEuPbmp+DXX/+YS1b7Gu5aidGpQ==
X-Gm-Gg: ASbGncsWD7/aL2BFgRs7m6tRwEoULhmhvX8jiKG9/O/eKFgvEvnB0fYVq+oOdjNEIvV
 fy3qGiptzpEd9PpOMZhusNMmzJoA8sHIj+Sd/q17pwb1xW9TiSMz47scPvfP+XkyvH/yh
X-Received: by 2002:a05:6902:1086:b0:e5d:c0db:b3de with SMTP id
 3f1490d57ef6-e5e2467a803mr12802002276.34.1740480818200; 
 Tue, 25 Feb 2025 02:53:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsC5AttzVoNZqEF1hto5oW4YN9hr/CADPnUvZ824A6wUfmzar+0lVuy4fbclg+orlgDyruoB2AIn89XlQtyhI=
X-Received: by 2002:a05:6902:1086:b0:e5d:c0db:b3de with SMTP id
 3f1490d57ef6-e5e2467a803mr12801989276.34.1740480817829; Tue, 25 Feb 2025
 02:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20250217131255.829892-1-mvaralar@redhat.com>
 <rmroel5kfax2inqmwtbu2bdabzppz46agjh2epjx7enup5kpsi@bqjc6oxnaagj>
 <4e00ff05-8a7c-488c-a3c5-3df48ce74e79@tls.msk.ru>
In-Reply-To: <4e00ff05-8a7c-488c-a3c5-3df48ce74e79@tls.msk.ru>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 25 Feb 2025 11:53:26 +0100
X-Gm-Features: AWEUYZlC1nm5kzLuo13wUtdy2DGF8n3ouZApaBpFuJkttUHMtxOUQE4rAlmtHKw
Message-ID: <CAGxU2F5nOsT2wY89+OTy+Nnr-HPmRXU2CZ=Vq3Vr5ZuKuPWEVg@mail.gmail.com>
Subject: Re: [PATCH v2] vhost-user-snd: correct the calculation of config_size
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 25 Feb 2025 at 10:40, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 17.02.2025 17:07, Stefano Garzarella wrote:
> > On Mon, Feb 17, 2025 at 02:12:55PM +0100, Matias Ezequiel Vara Larsen wrote:
> >> Use virtio_get_config_size() rather than sizeof(struct
> >> virtio_snd_config) for the config_size in the vhost-user-snd frontend.
> >> The frontend shall rely on device features for the size of the device
> >> configuration space. The presence of `controls` in the config space
> >> depends on VIRTIO_SND_F_CTLS according to the specification (v1.3):
> >> `
> >> 5.14.4 Device Configuration Layout
> >> ...
> >>
> >> controls
> >> (driver-read-only) indicates a total number of all available control
> >> elements if VIRTIO_SND_F_CTLS has been negotiated.
> >> `
> >> This fixes an issue introduced by commit ab0c7fb2 ("linux-headers:
> >> update to current kvm/next") in which the optional field `controls` is
> >> added to the virtio_snd_config structure. This breaks vhost-user-device
> >> backends that do not implement the `controls` field.
> >>
> >> Fixes: ab0c7fb22b ("linux-headers: update to current kvm/next")
> >
> > If we want to backport this on stable branches, better to add:
> >
> > Cc: qemu-stable@nongnu.org
>
> There's a problem with stable branches though:
>
> >> static const Property vsnd_properties[] = {
> >>     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
> >> +    DEFINE_PROP_BIT64("controls", VHostUserBase,
> >> +                      parent_obj.host_features, VIRTIO_SND_F_CTLS, false),
> >> };
>
> This change introduces an incompatible change in migration stream,
> it looks like.  I'm not sure how to handle this for stable branches,
> is there a way?

Good point, but in hw/virtio/vhost-user-snd.c IIUC the device is
marked unmigratable:

static const VMStateDescription vu_snd_vmstate = {
    .name = "vhost-user-snd",
    .unmigratable = 1,
};

So should we care about migration stream for this change?

Thanks,
Stefano


