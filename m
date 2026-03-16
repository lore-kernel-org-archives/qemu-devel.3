Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A324F53D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2C54-0001su-EO; Mon, 16 Mar 2026 13:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2C4u-0001sG-9i
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2C4q-0001iw-NT
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773683403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xdlz51YN6TNwHGw88PoC3oph3GvtnB30YwofysQALE0=;
 b=IiwgkhI4cBA9qvKRT3k0DTraMGWbLwhqRBaHhsqPXRygkXwvAVVkK+5jLtDvqXWSmaAvHf
 WjPjFnUhAk7XWNT0atNElsxldrZ127DXcDzgkhoyN87Ma9j8HSE68UB+V2slxcW3D1LGXl
 Ezy6jC+frFy2+WazuH/uddNLO2eoAY4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-i25B7uPxMXasPxpZ3l0edg-1; Mon, 16 Mar 2026 13:50:01 -0400
X-MC-Unique: i25B7uPxMXasPxpZ3l0edg-1
X-Mimecast-MFC-AGG-ID: i25B7uPxMXasPxpZ3l0edg_1773683401
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd80bea54dso3032963285a.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773683401; x=1774288201; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xdlz51YN6TNwHGw88PoC3oph3GvtnB30YwofysQALE0=;
 b=rpsSfO6TP12qw6uzAFcMm+rYcief8tVwkrKM864YDQ0cCsawcY7zIKFVACjw4sn0jO
 fpm0+ma9fWHiylRvartW4UPKuhP1cCff+tooJL1cxnygnxfme5X1eM56SbnE/GOPBw3n
 G5IefcPDWLF2Y+PIQw5WLhUWcH9BePYDEEIjhpG07MH1ffXoZiQfd8Qx9RATedQaetNZ
 MBbo+0IZHHAZKhtWjncDgNmVhmlF8HGnfBMWUcvN27VmsoNl8qwZJltvd9EMjsXt1ZkT
 UgMasFSYspemdurXbUg9pXiddBL1G4MJLOkix5iQwggsU4ubZ8k5niBVxnIvqLdkcjdh
 oRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773683401; x=1774288201;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xdlz51YN6TNwHGw88PoC3oph3GvtnB30YwofysQALE0=;
 b=p9uyqaY6xmp3L0SKuFJlW3QLieH2th3wtxRocu0kMnwovBdkQoUV7B3N0GiaLKkxqZ
 yVzEykhMRR1jhnWSbvmF1g1COjkjQpYlidyaKZT+awoOJ7ih4/7eC1WBpS7ijUnCs/Ke
 9BImgUYljNrwl166kynYtPV0Xf8LZZ8R8R3X5AP1eMK7JL2FvpeJkeNBs9Q912WUcHBu
 NWS5TWC0Fa/q1ytGjfbAdzqmgXaAmN7MP8Ski6xBxsw6FJmmY7WPw+nVZ0NyopjielO8
 GlmKuFok7Sq9PNFeNyR/LyxJ569U4VFPTsXjl+6BlrZ9gGtWTyvCqGE3Smsjk/QalgRN
 lA/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAMqufoUuiKvrFiv/CXI1HpzNFYNzvO8+AWvblyeXfbugWs/rTz905BJKIs0IszVFU+ppzDjMRkLRA@nongnu.org
X-Gm-Message-State: AOJu0Yzay65tPu7rDb3nfRX2RMcgrh2vf6oyKFtFCzdSOPndOo6m+KG5
 JtkVhyfrTduo6w/PffG/TUF56uSJbOX4zahPz5QXHFQ4l9QHf/AVBqjKTegwEkobvy1TF9ipnot
 +WDfmYkwH9M6qLwg2DitkghYrRswqsUmICCioF9OXMo7yAa68NFg5zqFr
X-Gm-Gg: ATEYQzz6he2GeX6QwCkJZTrKS2le9/HT7ANqEpC6LzcrIqQDv6HIE4deOc4q0Hli7pL
 RDZdvk4/dPltDNA+moysnxbJfqaSRtGub8IzdHAFpP0I0ND7i35nG/VND83KzIisKZyZK+taG4i
 3DYKul9Bn8I6lMJRfZ3OSYYPkGcZ3xivvGi8l0XLspK8LxgDn9j9JB71kyNArOrxBa+OmBEQ4kJ
 Jc4VrzvTfGZh2jmchW/PGawuoPmgVFFXNN3JzxqSDfZbKxK4ABhydoQPPGJDZ/Cx1Gblrw7D9rB
 OOLdvhnwBR34yXoFFgiUP6TyEoJ/FtP+wt3uJbiuPmQXRhpYFEfCbfjex9g18sWd7fvh5JGKM/W
 /BFmgcd5KAZP3vg==
X-Received: by 2002:a05:620a:414a:b0:8cd:9baa:fad7 with SMTP id
 af79cd13be357-8cdb5a6da5dmr1740119585a.26.1773683400924; 
 Mon, 16 Mar 2026 10:50:00 -0700 (PDT)
X-Received: by 2002:a05:620a:414a:b0:8cd:9baa:fad7 with SMTP id
 af79cd13be357-8cdb5a6da5dmr1740112585a.26.1773683400224; 
 Mon, 16 Mar 2026 10:50:00 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda719a513sm1244109385a.15.2026.03.16.10.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 10:49:59 -0700 (PDT)
Date: Mon, 16 Mar 2026 13:49:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] hw/display/tcx: Init memory regions in realize
Message-ID: <abhCxgOL0Rdra8hI@x1.local>
References: <20260316130651.5C8735968DE@zero.eik.bme.hu>
 <abgqjKVFHKxuKupP@x1.local>
 <e596bcf2-962b-4857-addc-1200702fe455@redhat.com>
 <CAFEAcA-n2EW=deU=jVcLd=6PysNZd5m7WTYrHLtQkxMo=KWBPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-n2EW=deU=jVcLd=6PysNZd5m7WTYrHLtQkxMo=KWBPw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 16, 2026 at 04:36:23PM +0000, Peter Maydell wrote:
> On Mon, 16 Mar 2026 at 16:23, Thomas Huth <thuth@redhat.com> wrote:
> >
> > On 16/03/2026 17.06, Peter Xu wrote:
> > > On Mon, Mar 16, 2026 at 02:06:51PM +0100, BALATON Zoltan wrote:
> > >> Due to aux-ram-share property qemu_ram_alloc_internal dereferences
> > >> current_machine which is not set during init when inspecting the
> > >> device. This causes the qtest/device-introspect-test to fail since a
> > >
> > > Does it has anything to do with aux-ram-share?  I thought it's because the
> > > qom introspect test will create yet another sun-tcx device, causing double
> > > registration?
> >
> > I think it happens because the test starts QEMU with the sun4m machine (or
> > whichever machine uses this device by default), and then creates another
> > instance of the device for introspection (without realizing it). You can
> > easily recreate the bug manually like this:
> >
> >   $ ./qemu-system-sparc -M SS-20 -display none -monitor stdio
> >   QEMU 10.2.50 monitor - type 'help' for more information
> >   (qemu) device_add sun-tcx,help
> >   RAMBlock "tcx.prom" already registered, abort!
> >   Aborted (core dumped)
> >
> > An instance_init() function should not change the global state of QEMU, so
> > registering memory regions this way is a no-go. This has to be done in
> > realize() instead.
> 
> Ah, and previously we created the MR in instance_init but did
> the vmstate_register_ram_global() in realize, so we didn't see this.
> 
> I'm a little surprised that this causes a problem, though -- I
> thought that we constructed the RAM idstr not just from the
> provided string but also including the qdev path, so that
> you could have multiple devices of the same type. I guess that
> we don't get that happening correctly because the device isn't
> sufficiently created to have a qdev path yet when we haven't
> even finished instance_init ?

Device sun-tcx's parent bus is TYPE_SYSTEM_BUS, which doesn't provide
->get_dev_path().. so IIUC it'll generate the same name.

Thanks,

-- 
Peter Xu


