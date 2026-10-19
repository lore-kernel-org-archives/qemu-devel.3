Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23ECCCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIkJW-0003Bz-IG; Mon, 19 Oct 2026 06:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xIkJT-00038h-8E
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 06:09:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xIkJR-0007OT-J1
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 06:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792404587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CGDGqktqGv6ml/mmaO2sFVwU9Y5TonKf9Pwrkzzbg6Q=;
 b=RGPm5cJf3lXJzkX3yPxjMe8IArD+oiJx/vzhdyzNkvg3VWy+L1M8WgDO2VzSDXpHhlRrFG
 Obj155SNKwgoCbgsSXYZXItRy+5JNKFYS620wEGjD1hBuGXvu+vyGBaWHuQwd5C93jRj4q
 7MRvxm/gQKY3FoBQMWQwFzFj4QWVORo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-GQ6hZY0-NiSPmMXRMs0PRg-1; Mon, 19 Oct 2026 10:09:46 +0000
X-MC-Unique: GQ6hZY0-NiSPmMXRMs0PRg-1
X-Mimecast-MFC-AGG-ID: GQ6hZY0-NiSPmMXRMs0PRg_1792404585
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48c6a1d4034so1752510f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792404585; x=1793009385; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CGDGqktqGv6ml/mmaO2sFVwU9Y5TonKf9Pwrkzzbg6Q=;
 b=g0cAxYW5Om6Kue05vhAUv3foUls5lYDM686R25yPi1l7Onad4mBAgnRzBKqbISUz7v
 S3xaxk4yM8KWDsbl5LatFe5saSzvoQyKDdO2l0bfhJue0TBH9IfwxUMMoCDzJ7AED5Fl
 26153UItfnDJP00XhJB1hdCJMSgcdyVGEXDctKHldt1vjxe0c0CDxF38B8uxUbxrQcpx
 y28z6aI8e8Gv7uFgFnuneKU1806ALFmh6qoaTbJu3uKK7jfEoFyWVI+P5kZKuKjxY16z
 BDQnATG8gUY6WxAqYn3FpkThyF+uzWJsAylmc8VsA++mAxpyijnrMDYDM5uM5PXCvZ+n
 Xb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792404585; x=1793009385;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CGDGqktqGv6ml/mmaO2sFVwU9Y5TonKf9Pwrkzzbg6Q=;
 b=1mFxz6CadyCo4q0DV6ZhL6xKyoY4SVYoKhb20r3MXi6wD4pqoktOkrbvFJG7FgqAvj
 5XkmGiou3sGNOeJ7M6r5dhW3So2W9k9TV6fD5dHUoQb+KSmhxLirnwwNB9/y3C3E6aHG
 4j+HmuTpwu0EsQG47O3mllZdCp7xZ4F6/i7pyGexj2eAsL2v+FpVzhrpHTSiAXLsPjbc
 WURtFh+dn324f4mCtGvUJC4WLlp3HcmpmC6nivRl0jc2c0DEHD7Znt2T19pdWg20YZmY
 og38RT9lnrwxLQNtP3fXXS3/H6UvrZi3nOZD3tWB8ew0yAh7thgeoKfZQngIvCsDPPwW
 NKEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBztN64dC0HQGJHqvVDv3OXHFhn/a2j+Ctk51DbuQybjz0NhoOuXpAEemsMdTeaU0f5mOHfa9gTyOZAc@nongnu.org
X-Gm-Message-State: AFq9FYLte9mCIRKBir2f1iSjqMfTiFzOoZjXmx5pQAjoY9SxMZ/uiEeg
 U581/i9IoNXfIOl/ts0BSp3T4dU6FiTDdkxmr7V714AmiT78itTxGQowt3P79UYuOR8pcRzcvrA
 bdDHDtSI8hocjMOdAHJAM7YuJv3prlLt0fks86hHV0BLuzo0vmL05c4k4
X-Gm-Gg: AYBFou2FU3M/e8S206B7bkyHRneS9H8dG3+Plpn7QbB7IbMIp/ZKvPor1CVV79PaEyI
 JUUuZbzeLRKqDmV8AUShOvPozLTbVMuAooUPeaWfzBZDdwuZXYE2sDYcmn7r4lVTpHBpLQ6bRVz
 1HvK+Muy1P/k58tItVETpOZrjSc64PznsF5LtCbBwESKDEQR6wM+E1ne2k6mj7ucNm5qgy72PJI
 EsVaeQp2zzDJ0pIyMbhN3ittsNnU8SHJrY3pbn4Iemuj0r9hOGM+1U5CyRA01H5oGVCuoa/U43a
 Yv6zIfe1QOf9+r+j0fthUXteRIBsDkXPIPqGwjx6HPVMMc+0R8DCjLXmq4ixk0O5GOoyjA==
X-Received: by 2002:a05:6000:46dc:b0:48e:75f:477d with SMTP id
 ffacd0b85a97d-48e07988b2amr10256188f8f.7.1792404584657; 
 Mon, 19 Oct 2026 03:09:44 -0700 (PDT)
X-Received: by 2002:a05:6000:46dc:b0:48e:75f:477d with SMTP id
 ffacd0b85a97d-48e07988b2amr10256140f8f.7.1792404583922; 
 Mon, 19 Oct 2026 03:09:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd471877sm18689616f8f.1.2026.10.19.03.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:09:43 -0700 (PDT)
Date: Mon, 19 Oct 2026 06:09:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH] virtio-snd: don't use virtio_snd_pcm_get_stream() in
 virtio_snd_post_load()
Message-ID: <20261019060923-mutt-send-email-mst@kernel.org>
References: <20261002165039.212819-1-alexander@mihalicyn.com>
 <CAFEAcA-JWf-KxgdTj5wuT7140ZY2=RXcnkCeAZkFx=t3OEoyWw@mail.gmail.com>
 <CAFEAcA-dni9eUQs-Mxhuf7Z72BNrEcFwzS4ywXDZFe1VA6V3Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-dni9eUQs-Mxhuf7Z72BNrEcFwzS4ywXDZFe1VA6V3Tg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Oct 19, 2026 at 11:05:32AM +0100, Peter Maydell wrote:
> This patch doesn't seem to be upstream yet -- which maintainer takes
> virtio-snd patches?
> 
> thanks
> -- PMM

I can take it since no one else did.

> On Mon, 5 Oct 2026 at 10:13, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Fri, 2 Oct 2026 at 17:50, Alexander Mikhalitsyn
> > <alexander@mihalicyn.com> wrote:
> > >
> > > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > >
> > > Coverity suspects nullptr-deref, because we don't check a return value
> > > of virtio_snd_pcm_get_stream() call in virtio_snd_post_load().
> > >
> > > While, techically this code has no issue it's better to change it and
> > > as Peter has pointed out [1] just follow the same pattern as in other places
> > > of virtio-snd code:
> > >     for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
> > >         VirtIOSoundPCMStream *stream = &vsnd->streams[i];
> > >         ...
> > >     }
> > >
> > > this way it's perfectly clear that an index is always within the bounds.
> > >
> > > Link: https://lore.kernel.org/qemu-devel/CAFEAcA-K7L5NWk0cC9R8yVvojSS6O6Eh+i9KXP8Lijo4Tjnd-Q@mail.gmail.com [1]
> > > Resolves: Coverity CID 1687010
> > > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>


