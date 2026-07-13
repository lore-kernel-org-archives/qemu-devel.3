Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43E3C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 06:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjAXG-00065D-Oy; Mon, 13 Jul 2026 02:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wjAX2-00064k-Kz
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 02:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wjAX1-00048r-46
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 02:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783925565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0ZFEGQgLUrEEMAXipHw/EG2/+KkMcSNIs9r1La8aBo=;
 b=GevrpGCPmBmfgUWPsgMqF7g5PaBMxLk18xSecP/P9aUApO3UFU8I1GAB3OAynvqYzB+bN5
 CjFsa6/FPclf8ZAX3260sQ6MY8tbu/2ICved7i/mGXHvRInrEu0+kbAk2ppClmXGz8BR8b
 zpMKNIoVfVVkEu28TobYlNjuVAJzAIs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-XU9elJOPOPOAV9poiQ5Xew-1; Mon, 13 Jul 2026 02:52:43 -0400
X-MC-Unique: XU9elJOPOPOAV9poiQ5Xew-1
X-Mimecast-MFC-AGG-ID: XU9elJOPOPOAV9poiQ5Xew_1783925563
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493bc2b376fso21261765e9.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 23:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783925563; x=1784530363; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D0ZFEGQgLUrEEMAXipHw/EG2/+KkMcSNIs9r1La8aBo=;
 b=tGaFnnMT13PwP9OeLFmIhpneg/BHAT+aRAKJTq+6ya8iK12W+bwf4o4dPIRRl3/tGQ
 jzmUCHHfRN5zRgNahIA1MhFus/HmIQ/1GkUpwR0J17e70ARyQIlOHV1y1jU01Rq3aH4U
 KcSobM+Plzz6bIuhcuka87MFnKQa3TMc0ulF9YjcJnEwcMcOa78hWcdp5rdxJBx8UB0v
 jMDfQnh5FyF0+VB6CEzQtRE5SSA2l08yimlsfYqgdA7HzhBTrwF9DgI/gIy2kHEibCC7
 NVtRCcekAROt81E9+RFkfkJU41CYufVqoODTTSmS3S9yoMu1x/GqBdLqQ4sEktTvVb8y
 zqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783925563; x=1784530363;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=D0ZFEGQgLUrEEMAXipHw/EG2/+KkMcSNIs9r1La8aBo=;
 b=bnuehXNWqNO5mrQJR9RH6ioi4DYEYygqSoeKE7vPVcpthfXSFmnUGzQW7yIF1ASKhB
 e9Atc1zBjBZcbkXX5ZvOboQQjKMu656CSB/U8BwXokP8F6e9gr/NflcoJYbvbdkOx40D
 CJVI+2KBqIzAsmq0X6uRf0PsGwKulI47qO9/526rFBu1ofesjgO7b+LgJ81dtBwIhPCj
 Ve2zD5LFjGe7J4NsZocJ2cealC19I17VGvPZtErVF3qMyzoFqmcXAQ3UlmVmopw3Cvzd
 RuTmfYmtVybZRrdjEfIXOwCGPspuZVf8jm4oN/gPkXovLSEr2PwZ585rMzr0tSRO8Lzb
 fHxw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHIUW1iHDOi3gEQaVZydR0dMGEJJooo7IMKagBuSrSpqkRn4SUsXU2IeU/ZeH+6u1AJFRIdjWpyvIV@nongnu.org
X-Gm-Message-State: AOJu0Yx7brHLsFzMJDHuccr6j6pvrvXvOtffVrV7Roi9vT3hbDBs+foh
 i69pmk+ypQc9HJdoINX5hjaZ4/p0Z047rdOGlsqVZYX8VddTk5FRAuG8ZDTU078dXC1rsFuAOXT
 sCnr8XVENHNJ/4Vy7HuZjNM+bfuCSyw/ig/jwPX5df/me9e6E7SMnWGwp
X-Gm-Gg: AfdE7cmDuUITDWZKE31DAsDG2zMSDG+ynkUlcIoe86uGmDmb92cRebGVCcIvK6u8mRS
 g3JhtDnEls9hRjJmlMtbn3jBDvrPukWcY5sQLU5Y9FGT1eEqdBud8p+ea8Gq84e101P1N1ERuMK
 v14pMgkbgfeKauGdxOkBAlFR9sAPdYR7rDDeXahCIMmpstAUimCeBq5pPdw0RJ/lMiTenRs8sC3
 34dAyVh+Z5g1ku8TkiHmlD/Zy96wLGDcrrOJuZqh1fiNGDH4L1cvDvGfleR095ccf2Xg2Wj9ZYf
 F6QFP5Ntp9K/pJi7DxDSkm6dzGaOQTqOoUrmjHFWXCATCZ4dQ59btnUDMsH42Rj+dNhSC84uSOF
 pU98=
X-Received: by 2002:a05:600c:c166:b0:493:cc25:85cb with SMTP id
 5b1f17b1804b1-493f87d620emr82164415e9.8.1783925562632; 
 Sun, 12 Jul 2026 23:52:42 -0700 (PDT)
X-Received: by 2002:a05:600c:c166:b0:493:cc25:85cb with SMTP id
 5b1f17b1804b1-493f87d620emr82164255e9.8.1783925562192; 
 Sun, 12 Jul 2026 23:52:42 -0700 (PDT)
Received: from redhat.com ([178.132.109.84]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb74835esm364623285e9.14.2026.07.12.23.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 23:52:41 -0700 (PDT)
Date: Mon, 13 Jul 2026 02:52:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 alistair23@gmail.com, qemu-riscv@nongnu.org,
 bin.meng@processmission.com, mzamazal@redhat.com, sgarzare@redhat.com
Subject: Re: [PATCH 2/2] MAINTAINERS: Mark "vhost-user-scmi" orphaned
Message-ID: <20260713025003-mutt-send-email-mst@kernel.org>
References: <20260710114305.2961898-1-armbru@redhat.com>
 <20260710114305.2961898-3-armbru@redhat.com>
 <20260711035848-mutt-send-email-mst@kernel.org>
 <65079ad4-3ab9-4ad6-b683-09d46c72b266@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65079ad4-3ab9-4ad6-b683-09d46c72b266@oss.qualcomm.com>
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 13, 2026 at 08:13:38AM +0200, Philippe Mathieu-Daudé wrote:
> On 11/7/26 10:00, Michael S. Tsirkin wrote:
> > On Fri, Jul 10, 2026 at 01:43:05PM +0200, Markus Armbruster wrote:
> > > Commit a5dab090e1 (hw/virtio: Add boilerplate for vhost-user-scmi
> > > device, 2023-06-28) added the section with S: Supported, but no M:.
> > > This makes no sense.  Downgrade to S: Orphan.
> > > 
> > > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > 
> > 
> > No, this makes sense. The reason this section was added is so that Milan can
> > get copied on vhost-user-scmi but not other virtio stuff:
> > 
> > ./scripts/get_maintainer.pl -f hw/virtio/vhost-user-scmi.c
> > Milan Zamazal <mzamazal@redhat.com> (reviewer:vhost-user-scmi)
> > "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> > Stefano Garzarella <sgarzare@redhat.com> (reviewer:vhost)
> > qemu-devel@nongnu.org (open list:All patches CC here)
> > 
> > Pls drop this patch.
> > 
> > > ---
> > >   MAINTAINERS | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index aa2df9cbe3..4d558ddee9 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -2622,7 +2622,7 @@ F: include/hw/virtio/vhost-user-snd.h
> > >   vhost-user-scmi
> 
> So what we want is to add here:
> 
>   M: Michael S. Tsirkin <mst@redhat.com>
>   R: Stefano Garzarella <sgarzare@redhat.com>

But these files already get M from the match against hw/virtio/ -
what am I missing?

> > >   R: Milan Zamazal <mzamazal@redhat.com>
> > > -S: Supported
> > > +S: Orphan
> > >   F: hw/virtio/vhost-user-scmi*
> > >   F: include/hw/virtio/vhost-user-scmi.h
> > >   F: tests/qtest/libqos/virtio-scmi.*
> > > -- 
> > > 2.54.0
> > 
> > 


