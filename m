Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD3BC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 22:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf5PQ-00029w-A3; Mon, 03 Feb 2025 17:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf5PN-00029N-7U
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 17:59:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf5PL-0007d6-MO
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 17:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738623550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mQ5MTVs6G/7g/I9bchyl5ELXvZTt7UWlbPmJDoLCHtw=;
 b=U1pS+VkPdElqN15LDhavEoHgnz8VErygVZuHl6hWh1lAKI3CHc7PuJyTWmsLdCurYGEqtP
 T9izEk473gXw3McA8C03WSYWVx4YIWwa8dFdp3psP0lmdc41wcaLZnLCgeANyHEe70JoaQ
 xFQ2u9yuaH6qo+wxDrdUVMbySpT/hpQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-PjJF8rDUPCaPLWM9F-ABDg-1; Mon, 03 Feb 2025 17:59:08 -0500
X-MC-Unique: PjJF8rDUPCaPLWM9F-ABDg-1
X-Mimecast-MFC-AGG-ID: PjJF8rDUPCaPLWM9F-ABDg
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6f943f59dso805330285a.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 14:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738623548; x=1739228348;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQ5MTVs6G/7g/I9bchyl5ELXvZTt7UWlbPmJDoLCHtw=;
 b=m5wdW1G/c796KQspr/TG9176fxPzps1PctB/9zJ1iJY/ajF+UxH0ED8mWDTU2qrg4e
 ttgzxDC9I5OHLDIA0gWAAFlWC6MJ834Z5K+NsWc5L3G4wTrDMIHMVIuOGwORWvjAjeOI
 th3QM/IVjBRxvwmqTS5Mlb5BZVJYNocPwG3n0bzVFIwW+uJEbZlk7hiITSAEZwKhn3aC
 D1KeHtdHwM2HTtkRSgUg4PHqQ09+uIixC3Mgcf3jfyoxLuIA7j6/GJm1mMg66pfZ7g5N
 VNYv/m1CKaxLT8ikEhHfHz401LD4KXQfPzq2pOCnXP3M+l8/o8U2LpPp4u2XhV+BweT0
 UeVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyaX8n5Xo/f4qO8CVieO5a8fLc4y4Q4bHh0oftvu36U+IUCSV8pYoynLmwRYUwRv6wZOpPmkkUMlG1@nongnu.org
X-Gm-Message-State: AOJu0YwRmbMvdGoBWB2KaFPFrwXQPY3nmN/uzJIXvI3NKjaoLIFiNxao
 MXLT/vSi+KgvR/KvSDUrIZBnkn96Na9cwF7FeGMiW0O+Vjae4ovhD0Pmsi6DCSa4poFrUPpanTw
 /rI1M260nfPd6sl9Y79oQZOnBhh8blpgzcQGZbKL6qqTW7JsNarLq
X-Gm-Gg: ASbGnctjCD8LeqGPGUYYg/Rv4uQ8jE5foOAJN034wYVIByTaL0/VKicDag+HFtKeZve
 ySN3D0kPmq7XGj+xuZU+q1o823bFt9MEH6JE6GDWOZOsZQy1V2qOApAtNz2quauRTh5ZEmMEocu
 EXYPbtKoAfFbhMVuWLz/pYWThNKFJULJStRKYzJMFVpueAkfgsfczWhP1nAmiTivhtTAIytzktz
 Uu2LpElElOeXSRMMnCPGNOQl7FV9y/2075JCBKW+4ybN2Bzm2UPpE7wHMRYHXBDVoJ++9O6UcBI
 TH5txtTvW2aZNOuO2+hXL/6UC7dsYw4WDt5Z1Pcv/K2/K4Xj
X-Received: by 2002:a05:620a:471e:b0:7b6:d8aa:7ef8 with SMTP id
 af79cd13be357-7bffcd8cdd2mr3559397085a.37.1738623547810; 
 Mon, 03 Feb 2025 14:59:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF01sS/NgdySw1lijLKY8pGmfcdUAL4qRcdghI6HwMx/yvrLNI7WM7cgbm7jcbOHKvVrTku6Q==
X-Received: by 2002:a05:620a:471e:b0:7b6:d8aa:7ef8 with SMTP id
 af79cd13be357-7bffcd8cdd2mr3559394285a.37.1738623547505; 
 Mon, 03 Feb 2025 14:59:07 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a9058e4sm578779585a.82.2025.02.03.14.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 14:59:06 -0800 (PST)
Date: Mon, 3 Feb 2025 17:59:04 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 13/33] migration/multifd: Device state transfer
 support - receive side
Message-ID: <Z6FKOKrKZpSmzf68@x1.local>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <654768fd717b0def70906bf7adfd6739cfd2ecf3.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6E03MMQqTDNFsnX@x1.local>
 <c80c298c-b838-4ea3-8b72-48ca8bf6cb44@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c80c298c-b838-4ea3-8b72-48ca8bf6cb44@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Feb 03, 2025 at 11:18:11PM +0100, Maciej S. Szmigiero wrote:
> On 3.02.2025 22:27, Peter Xu wrote:
> > On Thu, Jan 30, 2025 at 11:08:34AM +0100, Maciej S. Szmigiero wrote:
> > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > 
> > > Add a basic support for receiving device state via multifd channels -
> > > channels that are shared with RAM transfers.
> > > 
> > > Depending whether MULTIFD_FLAG_DEVICE_STATE flag is present or not in the
> > > packet header either device state (MultiFDPacketDeviceState_t) or RAM
> > > data (existing MultiFDPacket_t) is read.
> > > 
> > > The received device state data is provided to
> > > qemu_loadvm_load_state_buffer() function for processing in the
> > > device's load_state_buffer handler.
> > > 
> > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > 
> > I think I acked this one.  You could keep my R-b if...
> > 
> > [...]
> > 
> > > diff --git a/migration/multifd.h b/migration/multifd.h
> > > index 9e4baa066312..abf3acdcee40 100644
> > > --- a/migration/multifd.h
> > > +++ b/migration/multifd.h
> > > @@ -62,6 +62,12 @@ MultiFDRecvData *multifd_get_recv_data(void);
> > >   #define MULTIFD_FLAG_UADK (8 << 1)
> > >   #define MULTIFD_FLAG_QATZIP (16 << 1)
> > > +/*
> > > + * If set it means that this packet contains device state
> > > + * (MultiFDPacketDeviceState_t), not RAM data (MultiFDPacket_t).
> > > + */
> > > +#define MULTIFD_FLAG_DEVICE_STATE (1 << 6)
> > 
> > ... if this won't conflict with MULTIFD_FLAG_QATZIP.
> 
> Hmm, isn't (16 << 1) = 32 while (1 << 6) = 64?

Oops. :)

> > I think we should stick with one way to write it, then when rebase you can
> > see such conflicts - either your patch uses 32 << 1, or perhaps we should
> > start to switch to BIT() for all above instead..

Still, do you mind switch to "32 << 1" (or use BIT())?

With either, feel free to take:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


