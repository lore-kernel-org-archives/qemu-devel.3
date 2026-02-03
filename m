Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CECE87829
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 13:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnGT1-0002lX-6x; Tue, 03 Feb 2026 08:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1vnGSy-0002lO-IF
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:29:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1vnGSw-0005c3-H8
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770125352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uL1DcDJzKW+0omMq0fdb+hPs+ugQYt2S80AJ02U7OgM=;
 b=FANdpFtRU1Jbr6Wfk+xtaDENmawQhu+23faRU8P6CjoDbd97lmjZqoOSMs5fHLtMW/W8SW
 z1F5s08WVACdEGXhqcSqe7u+jO8b9wEAHgwLiFIS29RxSEqhp0SLRYHZtE77py76nuv4h1
 0VdV3Zm5Fjacn9IS3I+WFAiIWdRH/GI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-KJXQjtm3MHOY_wy3AWZVlw-1; Tue, 03 Feb 2026 08:29:08 -0500
X-MC-Unique: KJXQjtm3MHOY_wy3AWZVlw-1
X-Mimecast-MFC-AGG-ID: KJXQjtm3MHOY_wy3AWZVlw_1770125347
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4801e3aab32so30166335e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 05:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770125347; x=1770730147; darn=nongnu.org;
 h=date:content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uL1DcDJzKW+0omMq0fdb+hPs+ugQYt2S80AJ02U7OgM=;
 b=hiCroGZflm29c7vtAiOrvhAQUwQky/tcUnrA8DSrjcReYbHvKa1r63SntHxzHsgIud
 9SDl2lXdwMyzOuhwZ9+ZJO8tfaKE6OUa59VPY+HogEKQZMuIx4eezimgbQt0RVT03yNk
 uMpInbq00jyBKJRVFksTZEjz2M1njzND3BYqT6a0KcH6GxEhBnylYAPDN8rAkKWvDXuG
 699viS2Qnv1k01Qoy4BBSbuJkp1x1E648g9zLbGD8PLuki9aLzHwmQMvb9PwGtfaY++t
 Y5M1avmVKHCCElsE3FrBjMFVWRG/FovPn/UsEqR6B2qdb06QrC9qwTj8bV2WwlNQsopF
 DhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770125347; x=1770730147;
 h=date:content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uL1DcDJzKW+0omMq0fdb+hPs+ugQYt2S80AJ02U7OgM=;
 b=enXFfEfiqnoWax4Q/K52t2S/XkInF+1K9A5OUSdhSYbEPAcJAA2s1NF1F8D7MoKIJ+
 EEdcQ/NvDuTsxP0l0zRZt0o0bch2+m6EoH3jSPLkd7ugcA2vaI0FqBOodp9we83EuHiK
 Unpom2mcrTJa8769gkMOahW2QWPqrjpppQXwWYXsjfJHjxak46wsTdAorIZ/3h6WOuNG
 jNJ8n7cpt00NjX4K880OnWZAQt0mLAa9mykyHepp7nvpJWDWSHIsnZyXFUL4LzY8IiH/
 iwy8t0GIHfCGa+LzrPc7ZFmukZYt6GBeYUQ2YMR3II9R2HD1mxbqa0q54IfW/+g6EwD7
 xmdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDwagXS7WBhBFx+FdPYS4+ppaP2OHE11iUYNe2hlVckpesKTalPmZzQ/FDBKCcx+0DX83maL1kXUP8@nongnu.org
X-Gm-Message-State: AOJu0YxGjON2S0ZMpYyPe6xHJpvEZcR/y2Mmt0doYMcVNHsVyHyTMfil
 XZiDarXrQE2OogApVj7kVzexLR+ImrsaCRN8kQW98xivxfOj+WwmPPHgdGJd7Q4bNCc1nw+UCMU
 QlpL/qbdbHFnOanAtEHZ6dqoMoTahjaaTqQ7sOtBHMdur1upAluYdin/u
X-Gm-Gg: AZuq6aJD79/ej7U2lfwE00euItUde8HR+6Y0KVfdoFg01emZtU4ch0hdvZ2xeCnPRCi
 zYHzpC7q/vpOPiRfKA4zv8jm3apwsBWpnW7DS9/rwCFF0/c/kH3kyKiRa4AksT8IGtDcXRsTO39
 f8c+nGRAWd/70vwo+1U3XCwZdRYUtrhrOfOuygSK4DVPXMWkimSNfhMzUiLW1PYYqgByeXE21qb
 K4nsrwrllrfTK1utWRg6EmmTXabF1vZVOLXnsP0m0GZwLuYki2D51OnT+GdOMZqAr+rFIoudz9b
 l1IDA+hlkU8PqAPWgVzklwlsBYbKd+jNSWv80rPWRQdc3DPRlCI9MgbY80BuAIfxKnFAt94ELLz
 S4gj7OW/H8BcUiiMm0uhWEk1ycQAAMXq3I3uJyA==
X-Received: by 2002:a05:600d:12:b0:482:eec4:772 with SMTP id
 5b1f17b1804b1-482eec4092bmr113169995e9.32.1770125346819; 
 Tue, 03 Feb 2026 05:29:06 -0800 (PST)
X-Received: by 2002:a05:600d:12:b0:482:eec4:772 with SMTP id
 5b1f17b1804b1-482eec4092bmr113169625e9.32.1770125346312; 
 Tue, 03 Feb 2026 05:29:06 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830513730esm66577855e9.14.2026.02.03.05.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 05:29:05 -0800 (PST)
From: Stefano Brivio <sbrivio@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org, Fabiano Rosas
 <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu
 <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Laurent Vivier
 <laurent@vivier.eu>, David Gibson <david@gibson.dropbear.id.au>, Cindy Lu
 <lulu@redhat.com>
Subject: Re: [PATCH 0/4] migration: Pass network packets received during
 switchover to dest VM
Message-ID: <20260203142854.07640396@elisabeth>
In-Reply-To: <3806403b-a937-4b10-8bfb-bc4386b7fd82@redhat.com>
References: <20260127140316.4187221-1-jmarcin@redhat.com>
 <20260127192108.216495da@elisabeth>
 <3806403b-a937-4b10-8bfb-bc4386b7fd82@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Feb 2026 14:29:05 +0100 (CET)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sbrivio@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 3 Feb 2026 13:03:26 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> On 1/27/26 19:21, Stefano Brivio wrote:
> > [Cc'ing Laurent and David]
> > 
> > On Tue, 27 Jan 2026 15:03:06 +0100
> > Juraj Marcin <jmarcin@redhat.com> wrote:
> >   
> >> During switchover there is a period during which both source and
> >> destination side VMs are paused. During this period, all network packets
> >> are still routed to the source side, but it will never process them.
> >> Once the destination resumes, it is not aware of these packets and they
> >> are lost. This can cause packet loss in unreliable protocols and
> >> extended delays due to retransmission in reliable protocols.
> >>
> >> This series resolves this problem by caching packets received once the
> >> source VM pauses and then passing and injecting them on the destination
> >> side. This feature is implemented in the last patch. The caching and
> >> injecting is implemented using network filter interface and should work
> >> with any backend with vhost=off, but only TAP network backend was
> >> explicitly tested.  
> > 
> > I haven't had a chance to try this change with passt(1) yet (the
> > backend can be enabled using "-net passt" or by starting it
> > separately).
> > 
> > Given that passt implements migration on its own (in deeper detail in
> > some sense, as TCP connections are preserved if IP addresses match), I
> > wonder if it this might affect or break it somehow.
> 
> passt implements migration only with the vhost-user backend ("-netdev vhost-user") that is 
> not supported by netpass. All the vhost-* cannot be supported because netpass cannot catch 
> packets on the virtio queues.

Thanks for having a look! On this point... right, hence my question in:

  https://lore.kernel.org/qemu-devel/20260131032700.12f27487@elisabeth/

that is, is there a plan to add vhost support *for netpass*, eventually?
It looks like yes:

  https://lore.kernel.org/qemu-devel/CACLfguUZpT-3sj4C8G8e+LB5GHpBfE_HKLOhyZ9qYR8bgkTOCw@mail.gmail.com/

but I'm not sure I got it right (Cindy? Jason?).

> passt with "-netdev stream" doesn't implement migration, but QEMU can be migrated with it 
> and all the connections are lost. So netpass will forward packets for connections that 
> will be broken.

Realistically, I don't think anybody will ever try to migrate VMs using
-netdev stream with passt, so I guess we don't really have to care
about this (it might help with some protocols, probably make UDP usage
a bit worse, waste a bit of bandwidth with TCP... but that's it).

The only existing (known) user of passt's migration feature is
KubeVirt, which switched to passt's vhost-user interface entirely.

> "-netdev passt" is only some kind of wrapper on top of "-netdev stream" and "-netdev 
> vhost-user" that starts the passt backend by itself (rather than expecting it has been 
> started by the user).

-- 
Stefano


