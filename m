Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38989CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 09:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utN0O-0005aP-CK; Tue, 02 Sep 2025 05:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utN0M-0005aC-ML
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utN0K-0004JH-Kf
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756804115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VDihUIvEMHU54Tuq8CooNZpuBMajgBmM/4WmqmpLugM=;
 b=aaxnhmth25ZjzsTpK+VOUTOsFuj5z8VCpwOdjIyewSNEz5zYGs9wPk/tqNmXQYDVpUwPC2
 GTOZiHo5P5SegmPXSyu5RGHpH1lJWTxCu0ar+yPJKIsGXqz2k5h4IhZ9805IJX44Ui+Lhd
 Pl5akSW8P01ldi0XznxqqRPmM+XiD+s=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-yHOEgvXKNWGo03GumaYqCg-1; Tue, 02 Sep 2025 05:08:33 -0400
X-MC-Unique: yHOEgvXKNWGo03GumaYqCg-1
X-Mimecast-MFC-AGG-ID: yHOEgvXKNWGo03GumaYqCg_1756804113
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-324e4c3af5fso5522407a91.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 02:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756804112; x=1757408912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VDihUIvEMHU54Tuq8CooNZpuBMajgBmM/4WmqmpLugM=;
 b=mv/54K3rKSdNV/hhwPTW/xkVLkRaMoa1Rkzg5zzLAuleIv6KnwMEAE45ho5hwKnNtx
 Zhz02CYv9e2+tc4FNRNbx/EYcb5FesXXy8GQ0rVprjmrCu26ZO+XFCbFUwIGb8jINuY3
 qUSAutY1wg0don4Eua30OfAFo7RGUOhAxPCFlvSTvaqpGtGsBO5PcJ7t16/qLdi71Xrh
 LMtq/aQPZ/obtZDd3PKcmpg+tG9CSUY83icM82np73Dr53+hgCT54RNKuDOcys+iqyiZ
 E+i+apfWboK0RiUaYUb19gW+e0IRgzSUOxKt2SXmlBx+EA27b3XzxXb+uM/oIsK90P5G
 7jhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW1WXZYERlSaiIWezauj4uZH7MQ/0A7WERWE1IFmop3yKrA3wDh6J7rYwr1r26rDB+OlobnnxgQdh6@nongnu.org
X-Gm-Message-State: AOJu0YxtveDmyC4O7f7IGy9Zad2mH6aBnoEETEFTHU2Z8VgL2pgSp24P
 WXckcIy+Sc1NP23F9K/topmuvsZp9W0BQT/lT9kp1cV0m5dn4pFbcMO0ccKvBIKWBIP96xbQpl1
 ZiQ8COwJhh0N5Dg/CYMNX41i0FmFHechrz/xpFAF73LF+uBbVqdwWeQ4GwkZY4qwNIRxg2GDjyQ
 WRCLXdKcoGcTlQTc0SyBS+58Lv/Hnc9Ec=
X-Gm-Gg: ASbGnctGUae3nB6AMLThW+RF0/CkNhmfXv1E628bxJelhPYy/GIoQVxxBnpyC6Rdkby
 vmjGMNH/GNwUTAAw4KPP7h1dbvKKqmKr4JWpPx3J/KZeosLmM6KTqXwG0IYP3lcRSFxICkae4br
 4X+FjAhTw0mxwE7+KMBxX5rA==
X-Received: by 2002:a17:90b:48c3:b0:327:f216:4360 with SMTP id
 98e67ed59e1d1-3281541434dmr14333016a91.8.1756804112483; 
 Tue, 02 Sep 2025 02:08:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbOW79SkSDzrkVbTMBwTNFFG1RIl/iY682+mBZSzR4SnENev8eBXvITnSML+tKAvBfKxkrJEnlNGNri0LTvnA=
X-Received: by 2002:a17:90b:48c3:b0:327:f216:4360 with SMTP id
 98e67ed59e1d1-3281541434dmr14332980a91.8.1756804112045; Tue, 02 Sep 2025
 02:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1755080613.git.pabeni@redhat.com>
 <3590d748-752c-40f5-92c9-5c065dcc3c0b@rsg.ci.i.u-tokyo.ac.jp>
 <CACGkMEvOmgGyqv5-FGDAgyDrY9TpssEDtpNp07ro2oamg_7r1w@mail.gmail.com>
 <8c41ea67-c5a3-4f16-85a2-cc4876f09995@redhat.com>
In-Reply-To: <8c41ea67-c5a3-4f16-85a2-cc4876f09995@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 2 Sep 2025 17:08:20 +0800
X-Gm-Features: Ac12FXxqgyWOjLyF2XsDhNnKvrEE86yLh3igdtk39PdVUSouqVG49yr76zdLES0
Message-ID: <CACGkMEuyhCFCdQ5owUZqWC490doqgDUVq3osFGPo7QnnZ7_Pqg@mail.gmail.com>
Subject: Re: [PATCH v5 00/13] virtio: introduce support for GSO over UDP tunnel
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Sep 1, 2025 at 2:44=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 9/1/25 4:47 AM, Jason Wang wrote:
> > On Thu, Aug 28, 2025 at 9:47=E2=80=AFAM Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>
> >> On 2025/08/13 19:28, Paolo Abeni wrote:
> >>> Some virtualized deployments use UDP tunnel pervasively and are impac=
ted
> >>> negatively by the lack of GSO support for such kind of traffic in the
> >>> virtual NIC driver.
> >>>
> >>> The virtio_net specification recently introduced support for GSO over
> >>> UDP tunnel, and the kernel side of the implementation has been merged
> >>> into the net-next tree; this series updates the virtio implementation=
 to
> >>> support such a feature.
> >>>
> >>> Currently the qemu virtio support limits the feature space to 64 bits=
,
> >>> while the virtio specification allows for a larger number of features=
.
> >>> Specifically the GSO-over-UDP-tunnel-related virtio features use bits
> >>> 65-69; the larger part of this series (patches 4-12) actually deals w=
ith
> >>> extending the features space.
> >>>
> >>> The extended features are carried by fixed size uint64_t arrays,
> >>> bringing the current maximum features number to 128.
> >>>
> >>> The patches use some syntactic sugar to try to minimize the otherwise
> >>> very large code churn. Specifically the extended features are boundle=
d
> >>> in an union with 'legacy' features definition, allowing no changes in
> >>> the virtio devices not needing the extended features set.
> >>>
> >>> The actual offload implementation is in patches 13 and 14 and boils d=
own
> >>> to propagating the new offload to the tun devices and the vhost backe=
nd.
> >>>
> >>> Patch 1 is a small pre-req refactor that ideally could enter the
> >>> tree separately; it's presented here in the same series to help
> >>> reviewers more easily getting the full picture, patch 2 updates to
> >>> linux headers update script to deal with annotations recently introdu=
ce
> >>> in the kernel and patch 3 is a needed linux headers update.
> >>>
> >>> Tested with basic stream transfer with all the possible permutations =
of
> >>> host kernel/qemu/guest kernel with/without GSO over UDP tunnel suppor=
t,
> >>> vs snapshots creation and restore and vs migration.
> >>>
> >>> The new features are disabled by default to avoid compatibilty issues=
.
> >>> They could be enabled after that hw_compat_10_1 will be added, togeth=
er
> >>> with the related compatiblity entries.
> >>>
> >>> Based-on: 9d71108d7de139dd4f4e6efe6837cabb32bf5616.1755078918.git.pab=
eni@redhat.com
> >>
> >> Now everything looks good to me. For the whole series:
> >>
> >> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thank you for the feedback. I guess this series will go through
> Micheal's tree, am I correct?

Yes. I think so.

>
> Also I suspect/fear it could need rebasing due to some other patches
> being applied meanwhile, please LMK if a repost is needed, thanks!
>
> Paolo
>

Thanks


