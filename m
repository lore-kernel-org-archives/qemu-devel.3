Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACF5C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4wGE-0002Ye-Oh; Fri, 11 Sep 2026 04:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4wGD-0002YF-2G
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4wGB-00059c-3y
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789113922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ybEL5MblcX58ZtLYI5Q01SdQ32Zn7mxiRXrW7QJUWBE=;
 b=IWhUjpEjd3Wn9QgQln2P9f6+geNzmCts4YrXpPJkV7lwxf+DCpCmgwepJd5H56aKOpaL4C
 peP2F2GIzMlWtR9XnkJ7j2cbzfEeQTQvhwn3zJ7ST5rvVA5hPrsLDeQpQb5YpiPqTMwzMa
 ggOYMazeUj7fcWeWLZFB9j2e3YUXbbg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-svE-DtxpOk-08ebOHZFcnQ-1; Fri, 11 Sep 2026 04:05:20 -0400
X-MC-Unique: svE-DtxpOk-08ebOHZFcnQ-1
X-Mimecast-MFC-AGG-ID: svE-DtxpOk-08ebOHZFcnQ_1789113919
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48436a5fb42so280907f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 01:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789113919; x=1789718719; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ybEL5MblcX58ZtLYI5Q01SdQ32Zn7mxiRXrW7QJUWBE=;
 b=l0BxcXnIQSjiltWexCyCGzU//jrx/nT8nxtbTbxocNCrfDNOMDZshEkUiwHoM8KPxu
 U32yXM5Q8UPF0/QntDkHgc6uboHPJXXRw+3r4vgSRzD1YbjzlPeab1DLqGPQKK0leSnO
 F2siMYZoE/BkGuVohKQwnWLEw6sWbghIiEGtPP+YFlAsQPrmZaNoZu+UWlULBU9ZIMse
 mR7Ee+ZabqdarXvxEyPSN5mWIRGY4nMRJtzMSDhFKkOBKkIgvap3PHEB3PScte3GWnwt
 ZPeJiUA307PDSr3f0RYRyoxWAEW2NzSDJfvEHBK3YodY/yBw/CxXVTFnhu6axSl4fsbE
 Lsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789113919; x=1789718719;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ybEL5MblcX58ZtLYI5Q01SdQ32Zn7mxiRXrW7QJUWBE=;
 b=ELguVpKIn4UJmpFAM7+AnR1gYK4TjiZ8/RiKagWms81RbqlDQhD82AF3ELqqSaPF5B
 X6BiwyA6JpvrmRSkoBSTzIezK+Xc6AzHtf2JdK1DhxQKlk7Yt3iR/fp6Y9sszVY/6T7p
 zILIN7WGPGGh8Wdp2u+W65iqA5pBfAVWunQ9lrEHskNamZ2qn8xSZMzVisMw2NPIN0BQ
 ZS0FyH/9s0G39KmNnqMR+y+aiKqEe23qUp+gTmesaipesmxTlhC3G1JzScVL3LWp5BIy
 5i7pfiYbImrPgA07eiFJR3w+wnVo+0RBj/dRk1iRex6li6cHnMqQnM9f03xsfi6BeqSk
 IpdA==
X-Gm-Message-State: AFuF++ld7IkmmVPNhxf9Mo5eH3S6u2lJjraaaAPtHRf4xev9BorX80mb
 NUOmsRj8VckUaT0l4whvgNKIyi3qixO21aqlCmKvrngu+isJ5IVcEq14ikCD3WBm6OdhW60X4/a
 K28Tai5yju57hFx9X5fxEFDtYHGicMAfk7kWAoELSvAnux8QKd8iJLImi
X-Gm-Gg: AYBFou1+535op9yo1KyyG08k/nE9cKmVtBtP3VzvDP2i9AUIdi6cl/iyYB6SWYYJ8Q4
 ZUyKVYive1hlkuBqK0joJxInP6Gsm2BD/lzHKOix1d3uSYrB0YcsK2ptmX8EU1ao/lFpFT9Q/Mf
 ZFz4rrdpoTw1xl2/e8rWscAfitKQoFjN2zSLru/wEYEoamJ0xj05pOLBIAEBUPfxxmC3Agj3eaq
 heCk1xj42ZfvD9M3pI3WMpApSvjHWf0NF4h2kcSKhNHOPff0L19hPv56pbkhfqeU/w9Riy+g7Ck
 17JFGBgtMCs2Iu7J3bj5YGPwk4hZzn2ClNQYsySzK86DA9olpalcGT0PeXRZ2IlnG1BOW1jOgAD
 W6GSjas9kPKCqSVLmvyLWclo=
X-Received: by 2002:a5d:5f4f:0:b0:484:4769:18a4 with SMTP id
 ffacd0b85a97d-486eb2fa4fcmr3095695f8f.14.1789113919140; 
 Fri, 11 Sep 2026 01:05:19 -0700 (PDT)
X-Received: by 2002:a5d:5f4f:0:b0:484:4769:18a4 with SMTP id
 ffacd0b85a97d-486eb2fa4fcmr3095637f8f.14.1789113918564; 
 Fri, 11 Sep 2026 01:05:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34f1f7sm4091517f8f.24.2026.09.11.01.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 01:05:18 -0700 (PDT)
Date: Fri, 11 Sep 2026 04:05:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PULL 00/90] pci, vhost, virtio, iommu, apci: features, fixes
Message-ID: <20260911040505-mutt-send-email-mst@kernel.org>
References: <cover.1789071042.git.mst@redhat.com>
 <CAGxU2F72403d-Dt2+_MuDhcdHrdbNNjkYK+KMJ3R1PUbY7xQEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F72403d-Dt2+_MuDhcdHrdbNNjkYK+KMJ3R1PUbY7xQEQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 11, 2026 at 09:30:24AM +0200, Stefano Garzarella wrote:
> Hi Michael,
> 
> CCing Andrey
> 
> On Thu, 10 Sept 2026 at 22:44, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit 1df256f5968e9f7c3c4533a1383b071c044a36d6:
> >
> >   Merge tag 'qom-qapi-pr-pr-v1' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-09-08 18:35:31 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 99c75c61d61251d98e0b93dd199edbb10a990205:
> >
> >   MAINTAINERS: add Junjie Cao as CXL reviewer (2026-09-10 10:55:03 -0400)
> >
> > ----------------------------------------------------------------
> > pci, vhost, virtio, iommu, apci: features, fixes
> >
> > migration/cpr now supports vhost-vsock devices
> 
> In the last review we found several issues and Andrey is going to fix 
> them in v5, so IMO is better to remove that series from the pull 
> request.

Thanks, will do now.

> See 
> https://lore.kernel.org/qemu-devel/20260820113955.509478-1-andrey.drobyshev@virtuozzo.com/ 
> mainly in patch 5 and 10 IIRC.
> 
> Thanks,
> Stefano


