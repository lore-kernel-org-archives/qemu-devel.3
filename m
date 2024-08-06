Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDBAC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 01:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb8il-0003uR-Nb; Mon, 05 Aug 2024 21:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sb8ik-0003tZ-Qy
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 21:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sb8ij-0005wb-CK
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 21:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722906636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y4VgS+tYUCMQo5MCIFEEe+Sulp5NR5eYoTwvQ2KaSrY=;
 b=GCH0t9XxNQZ0KVck4OZrQOAFQew8zREFQRWu6BlfzHCh/WsUUGTsqCvQqZ5KXQeb87QrH3
 WHLzNZSGWJkqPxOvlYr0YxBHuD4t/4dVPhLIvtCc/xk+RwjG/3hYUHs2zaZwmW2CRFxhvT
 4FwkaGTo856yuA/8J7r3gnLs1VVSnok=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-14WDFQh7OrCOsBmMOZrEQQ-1; Mon, 05 Aug 2024 21:10:31 -0400
X-MC-Unique: 14WDFQh7OrCOsBmMOZrEQQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c96e73c886so85935a91.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 18:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722906630; x=1723511430;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y4VgS+tYUCMQo5MCIFEEe+Sulp5NR5eYoTwvQ2KaSrY=;
 b=RUPlWPH096GwevzbeVbeJUb5a6GjcfVudyImeUvhTMmApMGVL4Gx3IYZbtY3BusFFj
 r3IAo89coW5k7vAh7E43PqheAPFFlq3Mc3hyrCKoKIHXOmZsW5Fh3UIMQ72d4edsiyw8
 hy+VkND4iMdO+C7N0U3gXod7j3HEIOFZWfh6L5eERgi+pmevMbNOO4C80yWleTZJjQNI
 ofP7xKQsV42V1jhAKPurQsjxQbTlPXBTn0j+o/tZw1O3hmLR1s2YKIO4ANC+NZhh5Zgy
 37Fg0XI4bCgKhLqRjmzcsCDH+apZdnK9h7SU4hXfxkYu9G9b6YROD732aoV1SoDMwfb3
 S7zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAtE5E8aJBUdQH1zOVtpOyBRtOcyMrWhnK2ZPDEhEkXmJGMynzW98SFv6Su5iQr++UsXHtVMs5HW2W6LQMW9Q4feUuS8k=
X-Gm-Message-State: AOJu0YxB66Klvrm6yF9x+Gf81EUgBElao6tJtzYzRbImL563BCRuZigg
 AIeNmHwP0pa+vJ6n6K5V32DbNQmzZIgMD0CPeTkuym5DjC+HK86nt2230gf4OEtMYz0r/lgu077
 laypmRZBcF2qFMZTIG3debMvQGaSVDwA0iVOHxpIDfJI98zCc+Ev5Oy5cxzu7tIfb1mVuYBLJKz
 hRuYCzIffDNfXi9HkJuuj69y2+uXU=
X-Received: by 2002:a17:90a:43a6:b0:2c9:69cc:3a6a with SMTP id
 98e67ed59e1d1-2cff93d5a2dmr12421991a91.3.1722906630148; 
 Mon, 05 Aug 2024 18:10:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYDccufDPXh0ekESz1nJ8SjYzAo1a2aUrMntb1TkzxwLOV7Z941eUcp13VoXEADwt9x7LvVIKOp1d+sIN1xV4=
X-Received: by 2002:a17:90a:43a6:b0:2c9:69cc:3a6a with SMTP id
 98e67ed59e1d1-2cff93d5a2dmr12421963a91.3.1722906629618; Mon, 05 Aug 2024
 18:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240802-rsc-v1-1-2b607bd2f555@daynix.com>
In-Reply-To: <20240802-rsc-v1-1-2b607bd2f555@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Aug 2024 09:10:18 +0800
Message-ID: <CACGkMEsYPb_2wMDXhpybATKaG=hgvOV7WryWzeXVRYj-5Jcewg@mail.gmail.com>
Subject: Re: [PATCH] vhost: Add VIRTIO_NET_F_RSC_EXT to vhost feature bits
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, dmitry.fleytman@gmail.com, 
 sriram.yagnaraman@ericsson.com, sw@weilnetz.de, yan@daynix.com, 
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 2, 2024 at 1:38=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> VIRTIO_NET_F_RSC_EXT is implemented in the rx data path, which vhost
> implements, so vhost needs to support the feature if it is ever to be
> enabled with vhost. The feature must be disabled otherwise.
>
> Fixes: 2974e916df87 ("virtio-net: support RSC v4/v6 tcp traffic for Windo=
ws HCK")
> Reported-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


