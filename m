Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE48ECE588
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 19:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snkQw-0002Li-Qd; Mon, 09 Sep 2024 15:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkQv-0002L2-9R
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 15:52:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkQt-0003NV-JI
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 15:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725911537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5/3U3yDu8PUdzY29AlsktKBxoQ/xZmZZdqf5GHA6PLs=;
 b=g2Nx54fsLjkkfkhqCjaFnkbbQ4Tz+5s1XFaYYIybT3peWcy1jBW8c38kh1Y0FSHFuHJhYL
 0rBUAztSp8SrBv34ans9g7tn/EitiqnxU6gacm3bneje/NzPbCldd4nbDBZV+pLwjlZAg1
 6VbwJ0017gFgKsLvPXic7+/p3efXqPg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-l0CbS49oMNS1j0ciajjQWQ-1; Mon, 09 Sep 2024 15:52:16 -0400
X-MC-Unique: l0CbS49oMNS1j0ciajjQWQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a66b52c944so644719485a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 12:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725911536; x=1726516336;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5/3U3yDu8PUdzY29AlsktKBxoQ/xZmZZdqf5GHA6PLs=;
 b=PYRNSUYm+6ejGDi5H5rpvJ5lxR6WT2Ti14YHfpSg/GtAVMM9jfeFQzefINMyOG67m1
 14sGif7cQIoL9/NdjBDQnDH8vwj2s1xyIi/US2BvYEbXkiJCR7wsDifLDH8UGbe5KLEQ
 CnuTK2qYb/Wdaf5CIsH0OuOXM+zqgnasi+avIyXozyUUbhcioMQySUGv+fXGiV76yC1V
 jV1o9cmcjZQx8RVOlVvrZqwHDywdl5wiLVUqI9AqiIKOQFvMNmWwEBm1GdqlxGNa52dZ
 qlDbibMHkplIs8SCY6RlpmKCq32YQJ74R5Y5dCLvHLOxkHWTvi3GFyR/yFcPx1VLM5xc
 SrUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv52Z4D/OgLTu4VPbXlkTMcc/TfVxyKERxR5Ma2e9/dWeRjPkoogEQOeBOJ3/MCwI1No535XFl75+J@nongnu.org
X-Gm-Message-State: AOJu0Yw/ThFDTi97qf8uwq5vPv91I36Ual+Z8cIogWoPb/hYXDEociZj
 1MmXr8myV/+eaR7rtyI7MgK0/693wKxFKSxy6eBY2y4Wbk0YfB//fEs5H5S7FkfIbBHBXEnpFPm
 MvYPaxlWyQjQ6wO37HgXO3nWfdmJJAONz7gVOtYoLPxpAkA9T/Nb1
X-Received: by 2002:a05:620a:470b:b0:7a9:b8d1:a1d with SMTP id
 af79cd13be357-7a9b8d10be5mr514100385a.38.1725911534208; 
 Mon, 09 Sep 2024 12:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNP5q9TBNM/J6mkAq0msAt4gYMKDBX5U1sEdnvknvsWaLvHhENfzdI5AkTUvLyv33TbbrSjQ==
X-Received: by 2002:a05:620a:470b:b0:7a9:b8d1:a1d with SMTP id
 af79cd13be357-7a9b8d10be5mr514097185a.38.1725911533785; 
 Mon, 09 Sep 2024 12:52:13 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7a042c8sm245036985a.83.2024.09.09.12.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 12:52:13 -0700 (PDT)
Date: Mon, 9 Sep 2024 15:52:10 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 09/17] migration/multifd: Device state transfer
 support - receive side
Message-ID: <Zt9R6hJSTRtB7s9e@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <84141182083a8417c25b4d82a9c4b6228b22ac67.1724701542.git.maciej.szmigiero@oracle.com>
 <87ttf1n4lm.fsf@suse.de>
 <00eeacd5-ad27-4899-8526-0941b30e759d@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00eeacd5-ad27-4899-8526-0941b30e759d@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On Mon, Sep 02, 2024 at 10:12:01PM +0200, Maciej S. Szmigiero wrote:
> > > diff --git a/migration/multifd.h b/migration/multifd.h
> > > index a3e35196d179..a8f3e4838c01 100644
> > > --- a/migration/multifd.h
> > > +++ b/migration/multifd.h
> > > @@ -45,6 +45,12 @@ MultiFDRecvData *multifd_get_recv_data(void);
> > >   #define MULTIFD_FLAG_QPL (4 << 1)
> > >   #define MULTIFD_FLAG_UADK (8 << 1)
> > > +/*
> > > + * If set it means that this packet contains device state
> > > + * (MultiFDPacketDeviceState_t), not RAM data (MultiFDPacket_t).
> > > + */
> > > +#define MULTIFD_FLAG_DEVICE_STATE (1 << 4)
> > 
> > Overlaps with UADK. I assume on purpose because device_state doesn't
> > support compression? Might be worth a comment.
> > 
> 
> Yes, the device state transfer bit stream does not support compression
> so it is not a problem since these "compression type" flags will never
> be set in such bit stream anyway.
> 
> Will add a relevant comment here.

Why reuse?  Would using a new bit easier if we still have plenty of bits
(just to tell what is what directly from a stream dump)?

-- 
Peter Xu


