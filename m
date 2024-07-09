Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C200C3271E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 02:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR0y5-0006AU-BA; Mon, 08 Jul 2024 22:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sR0y3-00063W-OR
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:52:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sR0y2-000533-5J
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720493553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mRR1yIn/2iJ+367kocaOV4X3Hk2LnjcfBrnuJxfoF8Q=;
 b=AwUQ9WAxVxTQGUE75ZhHbmNyREd29NdKhAFf5qgPUQryq5NwhuaD1ms0MmqY5nM3nSUeI7
 Yel2aE96GzEJOdT//Ad99aB2hRCE5Eo9mIJ5Xk4WuC6dTbybmMqCH2nAFf6hSuGQSJwbnC
 vmHvDRAGUNxlK5SSdiuvTx2JF+kBmxo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-0RkMaMs0ON-hOCQgO6-piA-1; Mon, 08 Jul 2024 22:52:32 -0400
X-MC-Unique: 0RkMaMs0ON-hOCQgO6-piA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-70af548db1eso3456893b3a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 19:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720493551; x=1721098351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mRR1yIn/2iJ+367kocaOV4X3Hk2LnjcfBrnuJxfoF8Q=;
 b=hJbq2fcRyBZe+RjCoJ/mGBHitkllKOn/tbNR31lbim6D+RP4cFTqgstF9fK7w2JFJ5
 WeNcXEBZeCFP9wD05Ta9o0ch1Bzkg3AnBXHaZZgiwRP2jTuq8syTnKmX+XV1k/bwwdV1
 60BgN4eaj661k/ZQt5i8K7PiuAU/aYx8RJa53CjDbdzLjQtHDrKhuAuMnC4kgFQBRuN7
 RFmUrVQ/jg/mW96X8SnnOc1PE9pPSmZ2xV5Fb/pdx98CbDRVzGvtV2yk4sJmXCVnYYkD
 g7Haps2ZH4i6wn1akeQRSrfN3ljOi1/WzlZ2Sbb/aUchAAdAyPKb+Ncbl8iLrQ2t1nkg
 ikTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtvooxOcUXXvznwSt/ExOYywEwVpgD8IbePA0N3fudk6agaOd5iPsZLBtUMxOh8mmYdgeMTN1OAP/P690DUjEghW+K978=
X-Gm-Message-State: AOJu0Yz8HbVCX87H+ilHkIlQw5rluNa8zLrW10XjNBcPE0GrZe75xkYi
 /R8cVpQ4DfNbKs6DEpj+3+ss3PPHFzegvZU3q3hRyUdKQ7NkH3865W2+zUe/O902HxVGTlt83lE
 jic3l4+wByZCw1jp0D9d1QrqPo6w0vlsBbEvjkM7nvTb6uzg0jDM36oNZInN7eLKeRZZybovrCT
 vVaq2FY/G70jOxNpydeMPzFlf30/k8A74BnWjRbA==
X-Received: by 2002:aa7:9ec4:0:b0:704:2516:8d17 with SMTP id
 d2e1a72fcca58-70b44d61fd3mr1148317b3a.8.1720493550668; 
 Mon, 08 Jul 2024 19:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSljQhcEXfZv/EUsH2oBgSCnnb7Vs5MItYOlVBQpGj4fjdMaWdOmoMexKrEt/WOvQMmYsB7OA6jQNffCQcqOg=
X-Received: by 2002:aa7:9ec4:0:b0:704:2516:8d17 with SMTP id
 d2e1a72fcca58-70b44d61fd3mr1148293b3a.8.1720493550258; Mon, 08 Jul 2024
 19:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240708-auto-v2-0-f4908b953f05@daynix.com>
In-Reply-To: <20240708-auto-v2-0-f4908b953f05@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Jul 2024 10:52:19 +0800
Message-ID: <CACGkMEsrY84aW9w1zef-6KaTYaKuJ_mBqVxJbLuettORmB7oBw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] virtio-net: Convert feature properties to OnOffAuto
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Mon, Jul 8, 2024 at 3:38=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> Based-on: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
> ("[PATCH v10 00/18] virtio-net RSS/hash report fixes and improvements")
>
> Some features are not always available, and virtio-net used to disable
> them when not available even if the corresponding properties were
> explicitly set to "on".
>
> Convert feature properties to OnOffAuto so that the user can explicitly
> tell QEMU to automatically select the value by setting them "auto".
> QEMU will give an error if they are set "on".

Would this be consumed by a management layer like libvirt?

Thanks

>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v2:
> - Added patch "virtio-net: Remove fallback from ebpf-rss-fds".
> - Added a compatibility property.
> - Corrected property type name.
> - Link to v1: https://lore.kernel.org/r/20240428-auto-v1-0-7b012216a120@d=
aynix.com
>
> ---
> Akihiko Odaki (4):
>       qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
>       virtio-net: Convert feature properties to OnOffAuto
>       virtio-net: Report RSS warning at device realization
>       virtio-net: Remove fallback from ebpf-rss-fds
>
>  include/hw/qdev-properties.h   |  18 +++
>  include/hw/virtio/virtio-net.h |   3 +-
>  hw/core/machine.c              |   1 +
>  hw/core/qdev-properties.c      |  65 +++++++++-
>  hw/net/virtio-net.c            | 278 ++++++++++++++++++++++++-----------=
------
>  5 files changed, 251 insertions(+), 114 deletions(-)
> ---
> base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
> change-id: 20240428-auto-be0dc010dda5
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>


