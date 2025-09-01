Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C47BCA0FE8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 02:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usuag-0005RS-6Y; Sun, 31 Aug 2025 22:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1usuae-0005Qs-F9
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 22:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1usuaW-00077u-Ch
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 22:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756694883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nj06+iFcrPeLwxfVwdGiXl7QDRk/nCocLjNRDMDqbdM=;
 b=JA1eKujR569rtHV2RV+/YITzaGBW+YT3u/PDC1mvAiYPElhewi9YulK0qc55hK4X2eNYtS
 /TsNWeTmlTsDNKL3W9+MQ+HumzLZCO0sPoAq1a7H0423oAK6Pswy8lu/eY8GLRrJc4gHyS
 fC04x74yCsp6R3v+iySq3uqxitfK9Xs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-64Fb0YqlNUavyCX2aLR6YQ-1; Sun, 31 Aug 2025 22:48:01 -0400
X-MC-Unique: 64Fb0YqlNUavyCX2aLR6YQ-1
X-Mimecast-MFC-AGG-ID: 64Fb0YqlNUavyCX2aLR6YQ_1756694881
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-324e4c3af5fso4110134a91.3
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 19:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756694881; x=1757299681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nj06+iFcrPeLwxfVwdGiXl7QDRk/nCocLjNRDMDqbdM=;
 b=lcPCONKaDlpQZ7HRfvefEI8vrLTBk6JgaoaDVImgWyr+Ocw6Ew4TSe9UPztvMB+s/p
 I+Tw1wkXSq4SLDQ408WoUHXyoB5JfN2D0i1to1yroaVc4Ym3JwZhICmrtlAKIu9Jtrw9
 cM4Pwsb+eA73px3OOJHiD9+PhFt/6UG5x1rtHkEV7iJj3A4e4xTS1qZmhxeRM6mfRRlU
 UlPi5h3Tm8cSVQo/6yJ7vQ0KJ+fqf2bar9ykUvorxtJn38GU7MLGOHpcb/dFskF8TDcp
 4pHRgjXmdMQUA4hiw17W9C0VQ3+DGNuOYceAQL0xknexNtfLEJEsuz42wLL1K0dmc73r
 cOXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnlR6sQzAfOrc5ZVSkxqSXJNJe31n9NUUGnT8iQ33cE1/MMFuhmlOkAVHGgz+/bCcaUpXIErgcFCN3@nongnu.org
X-Gm-Message-State: AOJu0Yxd5AEOjbzkToIum27ONZLqSMBTYpLJFt0PuZfxEwm0b81+pE2n
 yfQTMv7mxOFnfXF38nFtfCaJc7O/ECgJlwHFe6zLX526yod8QwlhOxRJcS+JOLnoWXxoMFwoOdo
 LQXSrU41ZzblW49eGGWBeCtpsNTyAYejey34wTWTFmMwWroQkFjuV7Hxl13U5Dp8RMgqB/Vl3aa
 sXHN64FfbOGBwzFMrdjuhj2fXb1ebQjnM=
X-Gm-Gg: ASbGncsWttXfUlNo6WD/0LeV1l98HFu3G3y6T2jC31VNqIh+CIGtcU9w3u67rRfMk01
 Jjlr6j460lB1oMTvPOFnr3Q6Rnvzx66f8rj2qyJfG+oni0lDKY5ir2uzK49OVrLqLu2bWXr8psQ
 6EAiJJvlu1OiJuh+rmq6tGWA==
X-Received: by 2002:a17:90b:1d92:b0:327:c9d5:2590 with SMTP id
 98e67ed59e1d1-32815437b1cmr10057993a91.12.1756694880574; 
 Sun, 31 Aug 2025 19:48:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd3ptV91fl4IIY9697nzWVTQVroqeJT1MDqLkg0Y7cn+y4tRIlYA8eKtjfuS2I0h8w7HXtiJV8e1tG+5lR19E=
X-Received: by 2002:a17:90b:1d92:b0:327:c9d5:2590 with SMTP id
 98e67ed59e1d1-32815437b1cmr10057957a91.12.1756694880052; Sun, 31 Aug 2025
 19:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1755080613.git.pabeni@redhat.com>
 <3590d748-752c-40f5-92c9-5c065dcc3c0b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <3590d748-752c-40f5-92c9-5c065dcc3c0b@rsg.ci.i.u-tokyo.ac.jp>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 1 Sep 2025 10:47:48 +0800
X-Gm-Features: Ac12FXwzK5asG2B7ynD5dg_9LP5MKvRTxLxfjXjc-p13vsoZyMYkXSOihNQwpYs
Message-ID: <CACGkMEvOmgGyqv5-FGDAgyDrY9TpssEDtpNp07ro2oamg_7r1w@mail.gmail.com>
Subject: Re: [PATCH v5 00/13] virtio: introduce support for GSO over UDP tunnel
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 28, 2025 at 9:47=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2025/08/13 19:28, Paolo Abeni wrote:
> > Some virtualized deployments use UDP tunnel pervasively and are impacte=
d
> > negatively by the lack of GSO support for such kind of traffic in the
> > virtual NIC driver.
> >
> > The virtio_net specification recently introduced support for GSO over
> > UDP tunnel, and the kernel side of the implementation has been merged
> > into the net-next tree; this series updates the virtio implementation t=
o
> > support such a feature.
> >
> > Currently the qemu virtio support limits the feature space to 64 bits,
> > while the virtio specification allows for a larger number of features.
> > Specifically the GSO-over-UDP-tunnel-related virtio features use bits
> > 65-69; the larger part of this series (patches 4-12) actually deals wit=
h
> > extending the features space.
> >
> > The extended features are carried by fixed size uint64_t arrays,
> > bringing the current maximum features number to 128.
> >
> > The patches use some syntactic sugar to try to minimize the otherwise
> > very large code churn. Specifically the extended features are boundled
> > in an union with 'legacy' features definition, allowing no changes in
> > the virtio devices not needing the extended features set.
> >
> > The actual offload implementation is in patches 13 and 14 and boils dow=
n
> > to propagating the new offload to the tun devices and the vhost backend=
.
> >
> > Patch 1 is a small pre-req refactor that ideally could enter the
> > tree separately; it's presented here in the same series to help
> > reviewers more easily getting the full picture, patch 2 updates to
> > linux headers update script to deal with annotations recently introduce
> > in the kernel and patch 3 is a needed linux headers update.
> >
> > Tested with basic stream transfer with all the possible permutations of
> > host kernel/qemu/guest kernel with/without GSO over UDP tunnel support,
> > vs snapshots creation and restore and vs migration.
> >
> > The new features are disabled by default to avoid compatibilty issues.
> > They could be enabled after that hw_compat_10_1 will be added, together
> > with the related compatiblity entries.
> >
> > Based-on: 9d71108d7de139dd4f4e6efe6837cabb32bf5616.1755078918.git.paben=
i@redhat.com
>
> Now everything looks good to me. For the whole series:
>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
> Regards,
> Akihiko Odaki
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


