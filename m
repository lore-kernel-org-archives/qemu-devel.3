Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F245C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 06:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2l6K-0004Kq-FM; Thu, 10 Apr 2025 02:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u2l6C-0004KR-A7
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 02:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u2l6A-0001zk-35
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 02:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744265353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LChmln5pvmQkmrWi+XQ9ty6Td0rfwWtUpmoji5Y/RXE=;
 b=eJ5fr1torJ+h3Elb80JHxoZqrEmXuVYfV9VBfy/+YJTxQ7NxkemjFibR2mNKX9OEIzeF8I
 D0xJB3AIjfjSWVVoAkRfUy1to87jyZTFU9tkLHEEvbAsAiEiYtjHx3IIz6O4AuIXOlKM9C
 IORNEmj1PR0BzZJAF8h4hXjLY4eAmr8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-HX7_s-6aOfmN04MePozfmQ-1; Thu, 10 Apr 2025 02:09:10 -0400
X-MC-Unique: HX7_s-6aOfmN04MePozfmQ-1
X-Mimecast-MFC-AGG-ID: HX7_s-6aOfmN04MePozfmQ_1744265350
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39d8e5ca9c2so219698f8f.0
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 23:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744265349; x=1744870149;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LChmln5pvmQkmrWi+XQ9ty6Td0rfwWtUpmoji5Y/RXE=;
 b=pQCGiXy14XYtCNu32DHVCl098m+2gsxztB2P0pZ4h5XohVR4UkEmxx0Aw0gvM78CRP
 db3ApdpT0EK5ae4lG2ZsNyLL6YDL/r/nV/eOpeWMIXyK1hrJfQe37LdVc8etsXeGSJG8
 sYcc9HPxucxdLgOoZUcY+6TIk3tVjPRS3bv9yQUgkRYwPAh2DQCy/Tj8/VuBFLztqYNA
 yYnDuP4Z2uWh/du3Ia1Une90UQ6hkvZyMDX0ktE3VTLIUytzRcnt0T8OlN3YuT9VNOTK
 wA97Jpslc96WaTpP7IRTf71G+qpYHQ+3iyIKGw9KXo2M/KzzA/GxwxmOx6uAt+YiXv0T
 q8UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDnhpl8eTch57XpCC0nqGXkIfTPRsSy7IR0oRWZp9oQ+7qvAmEPk45F7LAXkW5GZ31C4lCh4FgAZTs@nongnu.org
X-Gm-Message-State: AOJu0Yzi2cm4f4rOL8Cx0TR5sx/MdHOrOaRnKsJkGIgPWIgpOHmlBWrE
 QY2+pl8e0Ie+w/SqY1CVvaq2hm6Hlv/lglZ6BaW10yRuk8+CPsbexcRTkW+fuXZiUyu1sdyuUIM
 +68udDPn3nCLmuN/ZZhcxDbQR8Ag0ORGrYxfH0rfEhY7hVY8fFgQR
X-Gm-Gg: ASbGncvRsxKG4kFL7NPoEogA/yxwjAu/hEK/sqPEF0UIpoI4BQxK9ea+/u2CCDBfSFv
 VRFG9BT7tsZQ9MIjf8P3MJsWsvCb735jBeFHVTLmzunJVbJIuGjl1iz6WLqVeVFxn+9VQWiv1/D
 PrFv39gw9zGuDuL8Y+i6JmbCYHODt/L/J0aFlpnX+piyaYyIgzOgQkXBnpCNc8dQ1FGUJ+XLlBn
 55S0tQFfBZ5pdPqG2sWm4zVUQGOqFQnX7cSuTe4/Lk59uWfITXcIsbTvqMY9CF1hXvb2v5h9IPF
 3xLBIw==
X-Received: by 2002:a05:6000:2507:b0:39c:12ce:6a0 with SMTP id
 ffacd0b85a97d-39d8fd470a3mr799344f8f.21.1744265349579; 
 Wed, 09 Apr 2025 23:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ1GhjxMlzN223tKM8OxhXX0NhC+rdIbtadE8NXnK9XgBLPT+4L8ZsuONorXcjHMj7cgFoAw==
X-Received: by 2002:a05:6000:2507:b0:39c:12ce:6a0 with SMTP id
 ffacd0b85a97d-39d8fd470a3mr799308f8f.21.1744265349218; 
 Wed, 09 Apr 2025 23:09:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f207c914csm42473655e9.39.2025.04.09.23.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 23:09:07 -0700 (PDT)
Date: Thu, 10 Apr 2025 02:09:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuanchu Xie <yuanchu@google.com>
Cc: "T.J. Alumbaugh" <talumbau@google.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>, Yu Zhao <yuzhao@google.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [RFC PATCH v2 0/5] virtio-balloon: Working Set Reporting
Message-ID: <20250410020704-mutt-send-email-mst@kernel.org>
References: <20230525222016.35333-1-talumbau@google.com>
 <20250407053811-mutt-send-email-mst@kernel.org>
 <CAJj2-QE1fO5GhYL_N2=w+xqd+yspkqjrn4HGeTrPUWZYbTp+Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJj2-QE1fO5GhYL_N2=w+xqd+yspkqjrn4HGeTrPUWZYbTp+Sg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Apr 09, 2025 at 09:52:12AM -0700, Yuanchu Xie wrote:
> On Mon, Apr 7, 2025 at 2:39 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, May 25, 2023 at 10:20:11PM +0000, T.J. Alumbaugh wrote:
> > > This is the device implementation for the proposed expanded balloon feature
> > > described here:
> > >
> > > https://lore.kernel.org/linux-mm/20230509185419.1088297-1-yuanchu@google.com/
> > >
> > > This series has a fixed number of "bins" for the working set report, but this is
> > > not a constraint of the system. The bin number is fixed at device realization
> > > time (in other implementations it is specified as a command line argument). Once
> > > that number is fixed, this determines the correct number of bin intervals to
> > > pass to the QMP/HMP function 'working_set_config'. Any feedback on how to
> > > properly construct that function for this use case (passing a variable length
> > > list?) would be appreciated.
> >
> > It's been a while. Is there interest is reviving this? I also note that
> > reserving a feature bit is very much recommended to avoid a complete
> > mess.
> Thanks for the reminder Michael! I've been informed [1] that this
> should be brought up in VIRTIO TC, but I haven't gotten around to this
> yet. Should I send a patch to this mailing list or a proposal to
> virtio-comment@lists.oasis-open.org to reserve a feature bit?
> 
> [1] https://lore.kernel.org/linux-mm/20241127025728.3689245-10-yuanchu@google.com/


You can do this in any order.

-- 
MST


