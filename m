Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9F4C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 02:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYyf1-0006mM-PB; Tue, 30 Jul 2024 22:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYyez-0006lg-Js
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 22:01:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYyex-0003Bt-OG
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 22:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722391305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NrYHLyncqEWiEsMbqaF95fhxKn6SsZ9N1jTbmBC9NBE=;
 b=HSO1BKgGu4TBcrSI+1WBW8RLZL+4+5cWhV4eWCteXKOGitu2hakyfDHD+iAzkkoX1Ml759
 fj8F/52Rte6J1LUvdseT8uiQWyXKmhzmQamlWSokOeNiSfvGehfFD6nXmbKxCwPukyNXdQ
 WI6YvxJjCbQMaxmKIbbTJTRg/LzYndI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-Pm48lndUM3ywZWcKo-wfug-1; Tue, 30 Jul 2024 22:01:44 -0400
X-MC-Unique: Pm48lndUM3ywZWcKo-wfug-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-7a2787eb33dso5185811a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 19:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722391303; x=1722996103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NrYHLyncqEWiEsMbqaF95fhxKn6SsZ9N1jTbmBC9NBE=;
 b=Uru9yieCawp7cM7A853K+JvZyJoTSevQUiE5LKyqHaLJ6+a0rTXoTGY5NfvmOZwhcS
 WERMo9Smg5sw/mwIU3xjyMiZ2N9x1ISZ/zbaJSOYv71AuoXYmvfsgA5hrq0pgH/GZSQb
 9lKF5eVJWU2tI3USgEG5XsfXWTut5w682jaXe+Li+YBtkcNXYvjJTZ0VTH2truhZjUwE
 us2F178rOqTCSOfikY+kvuGSs9i55cpryar8zPlV8rIIZasS7KkFLfU+SGdZPuNSgdsT
 CVfA/m7LDsdER6vNT2SNOu92FEk+N6VCzbKixwJOfLPAE/6oNMoZgFZTdKtDD0x3T3Wz
 IfLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJoQMVUpjNnBit8MGm6d7sEWJzbzfSSrwmzvQQPCNcVfJ8EavluOVD2tYQZ1S8LzGfT18OKrZOqgu0FMDXu6FOu7F2WYY=
X-Gm-Message-State: AOJu0YwHpXWGzog8+htEIOIZy6HjnwxLewSWO+p24OeWXYCYw/aw+gLY
 ViOYaR1Dex//2ju8K+3JAu7zDQ5VAZdhVfHFTgv37pmZXYCJw7/3iMOsBI/6fnNECtbGy0w/5YM
 XIiOYggK/3LtzkEsGsLYnoEBeytt/7loN9OPzTs81ulNZAsi5LieCB6qUcwN2u8tGxgt/Kizowc
 ORydhZgsGLYELlJWlsTC3haZN2AYE=
X-Received: by 2002:a05:6a20:9155:b0:1c0:f1cb:c4b2 with SMTP id
 adf61e73a8af0-1c4a1178fdbmr18425803637.4.1722391303367; 
 Tue, 30 Jul 2024 19:01:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF63KXEk25TWkljvFScqtE/1oewyC9jXP4tpmg+HrZBNkKx5yFEM+541JCJyusQXJEq7zDqGHydEo34NE4F1EI=
X-Received: by 2002:a05:6a20:9155:b0:1c0:f1cb:c4b2 with SMTP id
 adf61e73a8af0-1c4a1178fdbmr18425762637.4.1722391302877; Tue, 30 Jul 2024
 19:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
 <Zqe8C9AfaojKHM8A@redhat.com> <ZqfKrtQSSRVnEOGt@x1n>
 <ZqfQ0cGf8t2trEdl@redhat.com>
 <ZqktXwxBWjuAgGxZ@x1n> <Zqk09BGxlpdxMBMx@redhat.com> <Zqk6x2nd3Twz--75@x1n>
 <20240730151746-mutt-send-email-mst@kernel.org> <ZqlHKaQXzKGcnoBM@x1n>
 <20240730172148-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240730172148-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jul 2024 10:01:31 +0800
Message-ID: <CACGkMEuU2--Adbyu6vQUnhP56D5WEKZjmJk9ACtQ1xO+4TMNuw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 dmitry.fleytman@gmail.com, akihiko.odaki@daynix.com, 
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org, 
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, Jul 31, 2024 at 5:33=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jul 30, 2024 at 04:03:53PM -0400, Peter Xu wrote:
> > On Tue, Jul 30, 2024 at 03:22:50PM -0400, Michael S. Tsirkin wrote:
> > > This is not what we did historically. Why should we start now?
> >
> > It's a matter of whether we still want migration to randomly fail, like
> > what this patch does.
> >
> > Or any better suggestions?  I'm definitely open to that.
> >
> > Thanks,
> >
> > --
> > Peter Xu
>
> Randomly is an overstatement. You need to switch between kernels
> where this feature differs. We did it with a ton of features
> in the past, donnu why we single out USO now.

I guess the reason is that for offload features other than USO they
are landed in early kernels so we don't have a chance to test/meet
this case. But this is not the case for USO.

Thanks

>
> Basically downstreams just don't separately add kernel features vs
> qemu features. There's little reason for them to do so.
>
>
>
> --
> MST
>


