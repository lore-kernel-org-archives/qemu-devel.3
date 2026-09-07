Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A66C79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 19:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3f52-0005Xr-EL; Mon, 07 Sep 2026 15:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x3f4y-0005XI-Pg
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 15:32:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x3f4v-0007WU-KY
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 15:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788809542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qjho0rRY/k67yl+VptRb3Shy5rRI4XWmPaVmtyHqyr0=;
 b=YsBAK1HotQBtOUHA6wdg3cm981zNa1lOCuUu8ao0meo1yKnd/w2X2z7o8DALyVWPV51d3R
 FQ85Rxgxz1A0J/y7DJD0bFRdJDZIL0yOqaVaUw+z2OytjhqccqLrw2LLvo/eek/kkrGzEy
 PqqEvxhh+hJRld9qPRd1s1QRmZmmirY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-7Jeaw5o1N9y9avYsMcTrqQ-1; Mon, 07 Sep 2026 15:32:21 -0400
X-MC-Unique: 7Jeaw5o1N9y9avYsMcTrqQ-1
X-Mimecast-MFC-AGG-ID: 7Jeaw5o1N9y9avYsMcTrqQ_1788809540
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49b8c651ac0so55960625e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788809540; x=1789414340; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qjho0rRY/k67yl+VptRb3Shy5rRI4XWmPaVmtyHqyr0=;
 b=qW5kfsY28a/ufX66QqOkNsobejmizJOZ4ywkbSbGyCIJSjvDiniBFYmEcq87qgoxJs
 ZA3YmA5+dJqrj4VBZECL1vpAqpGbAtdExY1d03LMjB1cBiHM/2c9DdaiKs2bp7Wm4qC4
 bnmteR8to5sfSkSiYW8+fraTGFP5T/U+DH2Y69XAERP8V9HW2U4iaKDMDIy76NAzofGU
 k1i6w6/frqH9IDaaAe3ocDXhhVXMGOo6QzRTYzkUc44wmnUyHOoRTiu5j3Dv+srqk8Nd
 MQSsTeWWlnv0DXXYFzNKD+53W5T+PF/mU8aLcVhbKW4tXy+CR2quZtkeedVTXDjEBkQH
 jrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788809540; x=1789414340;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Qjho0rRY/k67yl+VptRb3Shy5rRI4XWmPaVmtyHqyr0=;
 b=IoLLbkPIMz6ANOowxvGb7m/SiYZzwa24LCHp77GZPtiy0hnDhW3z+pa7FNY84kUV5m
 zQitJAFr1NDHH32R3HOQZu7xDMPLLoaR4vtTp6Qyi4grOf059inmQh9AcSkHpvXxtd6S
 L1Ho3HJxvd+UvIFgFP2dPRlOAJ4tbomU9UqJo5n3HFVqTf2N2O5olg0IqbEnVB+SCwSS
 eqzY01l22CpqV1t8pOrSQJROi4qJ0R5XBC4rbbWjEUTnjlK2+1HqPEiwF+mKs11xVHJ5
 vJoB9ke5iPrGdbJa5myeNbrvP7LWpV0Xnp8chFRXzcej2vYqd3aoJ1+oDDIdzSEIzZ2v
 yZCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzg3vIfJFmZhGtbCqYLainxOuOEOrXOuy7stdx0U+F4nx3RSV09l6iKOOzVnvFNQ91DsKCTfFtiQGuK@nongnu.org
X-Gm-Message-State: AFuF++lC2sDK5wtIj47bt6o3OG65Ru/hY2yVYBRd4WOR3154XUmJjVJs
 qumQZJBc1iVwC4N/OpBh+BwDBRigfe8Fac0jS2D/SjzJKPldGAGR/HXzntYWcLBvsUEf85LPyAe
 3Hm81Pn//Zq2OzD5cyx1UzTuR6IqnfFYNBwGKbY6nelohDlVCgd9hXZkg
X-Gm-Gg: AYBFou03T01LtszY9mL14sPMGf8Mbh45i3p3GDmms8D7tE1LtKCNvewQU5VtGIX8GqT
 8B3bccZ3U0Ykz9/ObpFa/bzU8I1JqDYAo9cok+5+Zlbt9zhjwMq055TmHkjpC+QSvAETp4asneI
 jJnBN1LRFu1yPIIwoqmCczR6tEQGRQYSayOWpcEXAyXMSzTjVevc119PSHJmiYDprdamaQP7pK/
 3GMmjcSMRNu6OJ1JLV266qD+iK9IysubV5ltbhXbT47e5GO5KybJhsKbSvlGb8ebVwQHXdRJFFV
 VaciajYXgQqfCgTt5l45Em7OCUNl6Y+CN9j4kR4e/+LG51InVdXKIlgyw1gyMeNTWDDl9tk6V9q
 ++RN1Q6AbaD3YnMUD1zDao3k=
X-Received: by 2002:a05:600c:8707:b0:49c:fc6e:8caf with SMTP id
 5b1f17b1804b1-49cfc6e8efdmr218191865e9.19.1788809539920; 
 Mon, 07 Sep 2026 12:32:19 -0700 (PDT)
X-Received: by 2002:a05:600c:8707:b0:49c:fc6e:8caf with SMTP id
 5b1f17b1804b1-49cfc6e8efdmr218191585e9.19.1788809539456; 
 Mon, 07 Sep 2026 12:32:19 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf75ce49esm576175705e9.1.2026.09.07.12.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 12:32:18 -0700 (PDT)
Date: Mon, 7 Sep 2026 15:32:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/9] tests/test_vhost_user_bridge: skip when running ASAN
Message-ID: <20260907152927-mutt-send-email-mst@kernel.org>
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
 <20260906-nohmp-next-v1-2-2b21e63974f3@redhat.com>
 <20260907075640-mutt-send-email-mst@kernel.org>
 <CAJ+F1CJfjvYWRW1Az=1Q2vUMM+RS56-_a5ugLbepeznHm8pvxw@mail.gmail.com>
 <20260907093319-mutt-send-email-mst@kernel.org>
 <CAJ+F1CKiUFGqJbWuxNM54bPJg1AicBKK_i+AuXttSCy-JRr8xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKiUFGqJbWuxNM54bPJg1AicBKK_i+AuXttSCy-JRr8xg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 07, 2026 at 06:18:39PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Sep 7, 2026 at 5:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 07, 2026 at 05:22:43PM +0400, Marc-André Lureau wrote:
> > > > maybe just avoid stdbuf completely.
> > > > i don't remember why we use it, but it looks like merely to
> > > > disable buffering for stdout?
> > > >
> > > > If so:
> > > >
> > > > setvbuf(stdout, NULL, _IONBF, 0);
> > > >
> > > > will do just that with no asan issues.
> > > >
> > >
> > > That requires modifying vhost-user-bridge, not sure that's what we want.
> > >
> > > thanks
> >
> > why not? it's not like it's a facility useful outside of testing qemu.
> > If we were we'd probably disable stdout printout completely.
> 
> Since the test redirects stderr to stdout, I guess the log is
> fully-buffered for stdout and unbuffered for stderr, and we see stderr
> log lines in the file log before the others. If we call
> setvbuf(stdout, NULL, _IONBF, 0) early, we probably will get
> interleaved stream output, but probably broken lines...

We can also just change that macro to write to stderr.

> Tbh, I don't
> have much motivation to check or fix this, I would just like the test
> to be green or skipped when built with ASAN. The current workaround is
> quite ok. If you prefer setvbuf() in vhost-user-bridge.c, I am okay
> too.
> 
> Yodel, wdyt?


