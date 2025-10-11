Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D723CCD183
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 04:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7ReD-0002QJ-BV; Sat, 11 Oct 2025 00:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1v7ReB-0002Q6-3E
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 00:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1v7Re7-0004HO-5l
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 00:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760158546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4jx3OxUyjDew2x/XMpV+iP7fDPC7DXJp4rK0S4uuvQ=;
 b=Ru3nwMF8xTYIfphUKMNOipE93t+zrOCP0u0GqXGpQWRpSHUjkY/5pwxuWNDDgTQRR/05LT
 BNJBxG4OmO1zHNwaZXm5/JAK10p1pfnEHnQNI6L98/M0GsvmK+GW1Gf5QFhnVatrFH0gDl
 iliOvyaWqC3D8U7tdsa41Mjr/4UZX+k=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-Y2SVggnfMjivWfsCMqHhkA-1; Sat, 11 Oct 2025 00:55:44 -0400
X-MC-Unique: Y2SVggnfMjivWfsCMqHhkA-1
X-Mimecast-MFC-AGG-ID: Y2SVggnfMjivWfsCMqHhkA_1760158543
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b55118e2d01so5607283a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 21:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760158543; x=1760763343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j4jx3OxUyjDew2x/XMpV+iP7fDPC7DXJp4rK0S4uuvQ=;
 b=HdrdmWG2Ns/mmmHMhHsq/ZpMFSohl3nev6d2nGEbR5ce8dfSLx2Tyw1zeuyPAHxLZ3
 Upx/UdhzxWbfgEfv6BapoRd5a+5A71rSeeg869j/4hDyXxo1D2MmN58zJdR6jLXJiZ8I
 Do6F5hCV/aiplRlUVQwPcEPDavoSci50qGVLql31iehuueAg0SnCCZQzTnZxtktP074n
 g00mQOxR8J6bDtn+KnH/Mwr5prFp8JxWJoIh6jClWsPqIMaySJbELqLvrlX3pC/ieqK6
 twmTkGDiiwEGBfGUk9SU5ju2tjk+0WQ2LY1uFKiepgErt4tDiwOwUYXGTUpzJHZum5U/
 fBlQ==
X-Gm-Message-State: AOJu0YzBJt4E4Dl7y6DS+rnhuQ/KTG40x6cUOgsd6O/W2VSeTWWkUnuX
 6Ldnk3DVXq/3A5YabLDGqpCkOW47MUohUkEnnij1FCAAWiz/WRlsJ/wlygSFnh7zfej9gqXh01/
 amDJ01q/cogUwBj1fTwjjKsHdj0T0YR94WyCvQP+c2i/8vuZ6zg+oANpl8T04K8ebZrvSbWCPh2
 AI9hLjd7470KykYBdimBH/39813DbWNKw=
X-Gm-Gg: ASbGncuhJQg5HZSaycB9/mksrTa+ltbPoHoqmT4l0xDIRFaZVNvkF+fqor9eGc5xksZ
 iXkDbUnsCNa5PgUzHEDjkeuLsaBzuzpyfNjLW9yC0G22HeVkkyYxZerzAaGnP1/qJJBZSEHlRN7
 wXL8eil9Bgq2WOrxcowA==
X-Received: by 2002:a17:90b:384c:b0:335:2823:3689 with SMTP id
 98e67ed59e1d1-33b5114b63dmr20448641a91.4.1760158543468; 
 Fri, 10 Oct 2025 21:55:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN+jjmyl76NVB5FdsgGSO44NpKqjInj/TYW756KunUleZgBT5DsZRh7i9JRmZt629d0RJi9dQB4MFpav7D9KM=
X-Received: by 2002:a17:90b:384c:b0:335:2823:3689 with SMTP id
 98e67ed59e1d1-33b5114b63dmr20448619a91.4.1760158543099; Fri, 10 Oct 2025
 21:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <9c500fbcd2cf29afd1826b1ac906f9d5beac3601.1760104079.git.pabeni@redhat.com>
In-Reply-To: <9c500fbcd2cf29afd1826b1ac906f9d5beac3601.1760104079.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 11 Oct 2025 12:55:29 +0800
X-Gm-Features: AS18NWDyoJccnhDsDSwtyUzqOk9Esp-6YLHiunw--OOs4Zi8I4xsOrNUOTlTheE
Message-ID: <CACGkMEt4YLAS7a-j-7t2ogoN=TWvsmBzDwJGVqvjbrt30orYTg@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Advertise UDP tunnel GSO support by default
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 10, 2025 at 10:13=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> Allow bidirection aggregated traffic for UDP encapsulated flows.

bidirectional ?

>
> Add the needed compatibility entries to avoid migration issues
> vs older QEMU instances.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---

Other than that.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


