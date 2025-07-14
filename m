Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145EAC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 10:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubGUx-0000o6-72; Mon, 14 Jul 2025 06:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ubGUu-0000l9-TY
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:33:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ubGUn-0005GH-MV
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752489194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kFFc1PDICEOXI6I1qmM+LC4bafF9hi3ehm+wlWDYz0Y=;
 b=EGfIBus3UY8MSgpQ9zGFrpEAJzwydVxSBUI21rCl5hbSf2YydCSOzzkh1G54zKc2SOUJ8o
 JAZPW1zhQqbiqQoQnvJPtLHuFxeu1whDZ1hroSFsC1wur5iWfqCqcEhvkt5Rxo2N1R8J88
 mFOmN2WAnHEeUTtnjlTntZ6Q2MmBmf0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-weBxiB3UPnmzb3t9dfKOTw-1; Mon, 14 Jul 2025 06:33:13 -0400
X-MC-Unique: weBxiB3UPnmzb3t9dfKOTw-1
X-Mimecast-MFC-AGG-ID: weBxiB3UPnmzb3t9dfKOTw_1752489192
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-70f841fb19dso55265047b3.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 03:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752489192; x=1753093992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kFFc1PDICEOXI6I1qmM+LC4bafF9hi3ehm+wlWDYz0Y=;
 b=k55y5emPEwXQ5eKA8dBWH/AxuKHtfdvwDjpzSdwPFYZYDmiDwjRYEVsPYeSoho8DtB
 0G0b+zTMIISeb2sV5nPK4xaoXUyB5KnXjQ/SoXTHAk5GN8UABcOb3fD/0ud1FZ9J6u1C
 MzM860wMxN5OXeb5rJPrPZ1K7gaqyvEp1jtq5jBsEq5lc8hLI1rKVAkUuaez+WY7i4qU
 ofGrDEoBOv3k+w/0cH5aCbgFST1VOqxYbIJA7WpmqSVed9/KgyadWc4OWF/5DXiq7Xai
 EsgMWWtDORDeJ6XnLht7WV9HOln/KRlh7XLrWXBAeS/WDQNFFWs8BgtJxkJFfMrT2zGR
 XnOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR0f/K5amu2gne2g8Ogaqd/wtP/6AzqUOivdN2IIMYj5Pw8CsxvD9hYK3GLgSX6xWEqFRfs2u6eLVX@nongnu.org
X-Gm-Message-State: AOJu0YxserXGLrHGb9syDtjy+yRJUvT27dBxE06gBklVLtsZcTb7fofn
 4GdR080ZEPFgJ08VGHwOMsF0xb1+gSJfFqSRrujJIbLa7tV7Btv35NrPHEifDQUSaR7mEjAQ3k6
 9o5/yTpjXZnPZsDboC6UDp2YGtPrNnudaqg0rXVJgB4HrgSMwVdV+pa4DcGjcmucz6F0jbfwGGM
 eFgBmnf4wVclOdvj5hN3eoiBk+t7iNcMc=
X-Gm-Gg: ASbGncu1mCgcEkVSIC/ZcVK37iyMV0WfeLskqwtZqXXJmvH07T2XT0ddqPn2lNwViZW
 NUiwhdBKQOCoO82LhTqKMQL5hDM0unZwO0rEjI71SdBg090MQBpo2otp7lLfzndlpr6yiSboWeH
 hAVukgEl2f1onLjBxIlCFnJA==
X-Received: by 2002:a05:690c:d18:b0:710:e7ad:9d52 with SMTP id
 00721157ae682-717dad97268mr158916817b3.14.1752489192422; 
 Mon, 14 Jul 2025 03:33:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+JPIc1O1rjKemgdiRBfQ0/uZwEPmSbfY1zJMtRG1CwNr44liLO9V8tMilOkz62pFbjc3YW9JdynL+jvGMxXY=
X-Received: by 2002:a05:690c:d18:b0:710:e7ad:9d52 with SMTP id
 00721157ae682-717dad97268mr158916547b3.14.1752489192001; Mon, 14 Jul 2025
 03:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA816sEoqZOzSwX9q1zzJEQ_mMpenLW7fBu5MEbM=aFymQ@mail.gmail.com>
 <20250710123945-mutt-send-email-mst@kernel.org>
 <rwmbufb2zk6grtmrksfthav6ntm7ddsodqfrpjwjt6njbacx62@7hikurlwh3kl>
 <CAFEAcA-jqjuC+a7AH1wgde8=y_yTc_iE-MriwzT+RZMP7U070Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-jqjuC+a7AH1wgde8=y_yTc_iE-MriwzT+RZMP7U070Q@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 14 Jul 2025 12:33:00 +0200
X-Gm-Features: Ac12FXyXIPHYtsrcTBLirN5B55BvJfsdXRJp6HLqFcyaAr7gy7NLlWmSZHzuOBM
Message-ID: <CAGxU2F7ndXZN0Kzadk8doCV-9s_FyHhxkoH_rpyD7XQzLs=Cdw@mail.gmail.com>
Subject: Re: vhost-vdpa potential fd leak (coverity issue)
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 14 Jul 2025 at 11:51, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 14 Jul 2025 at 10:19, Stefano Garzarella <sgarzare@redhat.com> wrote:
> > On Thu, Jul 10, 2025 at 12:40:43PM -0400, Michael S. Tsirkin wrote:
> > >> Q: should this file be listed in the "vhost" subcategory of
> > >> MAINTAINERS?
> > >> At the moment it only gets caught by "Network device backends".
> >
> > Maybe yes, but it's really virtio-net specific.
> > @Michael WDYT?
>
> You could create a new virtio-net subsection if that works
> better (and we could move the two virtio-net* files
> currently listed under "Network devices" into it).
> The aim here should really be to ensure that the people
> interested in reviewing/queueing patches get cc'd.

Just added net/vhost* filese under vhost section:
https://lore.kernel.org/qemu-devel/20250714102626.34431-1-sgarzare@redhat.com/T/#u

Not sure about virtio-net subsection, I'm not really involved, so I'd
leave to someone else.

Thanks,
Stefano


