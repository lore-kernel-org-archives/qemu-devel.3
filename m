Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B79BC531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 09:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnZ23-0004Uy-07; Sat, 25 Jul 2026 05:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnZ22-0004UN-4s
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnZ20-0004uB-KH
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784973055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k1wATOG6S5cTZcLT/f5BZ8q5BEH51s6vMy/SqDHqY0w=;
 b=OSNnM9wP76BzKjRTINRr0ppUl2xy8EMiBdtA2qv3KzDeHZq1bjL0JHZ2Hyy1lWM6p7Tk7v
 mdlr7FIwyZP2vsn7NZ6nWWirMYDsXCLLnEcwemzvXm+bYn2HMPjsdON7+6XQ9yHzyW720t
 tb6vJ/XK2nm/0Cvu64kFsI7phR8Eb7M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-1nq_VfKBMImPpYTq2_o9mw-1; Sat, 25 Jul 2026 05:50:54 -0400
X-MC-Unique: 1nq_VfKBMImPpYTq2_o9mw-1
X-Mimecast-MFC-AGG-ID: 1nq_VfKBMImPpYTq2_o9mw_1784973053
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f83450a8eso1049924f8f.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 02:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784973053; x=1785577853; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=k1wATOG6S5cTZcLT/f5BZ8q5BEH51s6vMy/SqDHqY0w=;
 b=MqSt8WKNXg7y+sempX0UBBaKmNL3S0nVWPp4RNIqqTNwx64Rrc0lvsGzRVL2QW954x
 a5Bs4B/zSExl7OjrHhsooM1lPmkBiFFSa4N+o8EF9GefFcsnfWiciPdsrfjXskELcVuz
 LPgIKPv6ZDCz65/1hZOj1aOjqo9GK9MaxX6hk+7JMiBRTQAC/g3iyVN+nrs6fMvHzn+K
 YM4MtfQyK8rDpkRb2qpfFPieBs7Q+EgDN6xGa1R5T4GkqAw1/f/i5Aze4s6YiLgA0/ve
 k51Z5B7siG7SooxU9xFTXFo2XSXt9SFfUMemdefLZc6niSR2lz1kKbOdfmW9KUyAZY4m
 M7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784973053; x=1785577853;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k1wATOG6S5cTZcLT/f5BZ8q5BEH51s6vMy/SqDHqY0w=;
 b=FdofEmDe8pytzPZHq8CjAnmIp8J6b/AMnGh1cvg5HW2PnOTvDfsbvBr4IJUsV//Oai
 ElgtubVJn9BT+lq4QLUCf3yKQ+td07YuUunsWuSuepZsfQrNE1GD4VPGJZtyFmBRXaBy
 qGc+BDmJpVE1R/bVIEoQZdU6faD2FaQiPUA7/aYEsbr7dGXimPhc/fiFA0BwPkU4AmIr
 5YWndNN8JQac9MvDeGwRXOsbt4YYg69PH6ibBIJRpv8D4rM2v0B9MyWdFhBpCO65KI2K
 hJKo7qoWIkfJvqup0IpKqa3ZJiUbYLFq25k1w1jT+Qpmw+PBomGqisd/KJ6ahvQXMgSD
 AuIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrUbrXWNXVNcAtvBlPhLwO0fsujAlcXFD4HnqVKEew9pRlPQ/cH4G59w7cEBAwcIqs3frHxyg+hY293@nongnu.org
X-Gm-Message-State: AOJu0YzCY+pUHp/fuiKbjbAJOkpDMZYmU30zeiAZCIQQPSrf4CC1trdh
 3rWkBPserWSZWWAwjIxB43d5Au37RAe+YNY6h8GYVMsU36p6Pz9OMOzjS6uD9ybUm1di6S9bBnv
 EeRMZOan/cvboaa8XaDMPTFzwaxPO1XCjzypXaZrbIaiXAKwkWNUtr0JZ
X-Gm-Gg: AR+sD13PKaVJ/p57qQCuFgun/VXHaZenQ1qrFiRzhlLaL5Me/qGfOBcPXQG/fGv20Ke
 IH9ktWvBAUPGUX0y/zITQL7gDoGUb6lvBkzq0w99F8reYydouARXvn/oIw8QMGW0IYdvLEjSKzj
 xnXJiHobVhQMkzNLLjtQM3nUr42CNqeVGxxIIZOcIGYlcP04Z957g4iLVJJkuCcD7W5pd9CYa5j
 nfizdeq+nLny7hcPSKjBIZmmquhZRB0bDOdnxfO3/Je9e0NYyIuEBr7Q70rcm/efNoyxxCTMyFx
 EgjcygcRl7+SsEb/1oL2U2WumGEcIXglzW1L2JtP1FYDQmeFEz3HojL6Z4Uw6lOkhm+T75uxitE
 kxhA0eoYuiposNh59lDOklJVlHWWy1Uw=
X-Received: by 2002:a05:600c:19c9:b0:492:4a50:41fe with SMTP id
 5b1f17b1804b1-496b56ff171mr21900155e9.22.1784973052609; 
 Sat, 25 Jul 2026 02:50:52 -0700 (PDT)
X-Received: by 2002:a05:600c:19c9:b0:492:4a50:41fe with SMTP id
 5b1f17b1804b1-496b56ff171mr21899885e9.22.1784973052125; 
 Sat, 25 Jul 2026 02:50:52 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net.
 [79.177.145.168]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4858e86sm32991795e9.1.2026.07.25.02.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 02:50:50 -0700 (PDT)
Date: Sat, 25 Jul 2026 05:50:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Subject: Re: [PATCH v3 0/2] More virtio-snd fortifications/coverity fixes
Message-ID: <20260725055035-mutt-send-email-mst@kernel.org>
References: <20260420-virtio-fixups-v3-0-07aef1eff9d2@linaro.org>
 <99126226-5f73-4853-869f-0fcdc30c13a4@tls.msk.ru>
 <CAAjaMXagdexkBXM8acCq7d+N51BG1qLGs-J7Ctz+ZFe2zzSOFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXagdexkBXM8acCq7d+N51BG1qLGs-J7Ctz+ZFe2zzSOFg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 08, 2026 at 03:01:19PM +0300, Manos Pitsidianakis wrote:
> On Wed, Jul 8, 2026 at 12:09 PM Michael Tokarev <mjt@tls.msk.ru> wrote:
> >
> > On 20.04.2026 08:07, Manos Pitsidianakis wrote:
> > > Added checks for stuff coverity pointed out (CID 1547527).
> > >
> > > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > > ---
> > > Changes in v3:
> > > - Added Coverity CID in patch message (thanks Alex)
> > > - Link to v2: https://lore.kernel.org/qemu-devel/20260417-virtio-fixups-v2-0-4a0d8636a628@linaro.org
> > >
> > > Changes in v2:
> > > - Use g_size_checked_add (thanks rth)
> > > - Link to v1: https://lore.kernel.org/qemu-devel/20260416-virtio-fixups-v1-0-ec14e2de0852@linaro.org
> >
> > Hi!
> >
> > It looks like this patchset has been lost somehow.  Is it still needed?
> >
> > /mjt
> 
> Patch 2 is still unreviewed it seems. I might send a new series with
> more patches soon. Thanks for the reminder!

so you will repost all this?

> >
> > > ---
> > > Manos Pitsidianakis (2):
> > >        virtio-snd: check rx buffer descriptor size
> > >        virtio-snd: check for overflow before g_malloc0
> > >
> > >   hw/audio/virtio-snd.c | 24 +++++++++++++++++-------
> > >   1 file changed, 17 insertions(+), 7 deletions(-)
> > > ---
> > > base-commit: da6c4fe60fee30dd77267764d55b38af9cb89d4b
> > > change-id: 20260415-virtio-fixups-3bc3a1a1cd27
> > >
> > > --
> > > γαῖα πυρί μιχθήτω
> > >
> > >
> >
> 
> -- 
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd


