Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDCAC88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6XNa-0006ws-3Z; Tue, 15 Sep 2026 13:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6XN8-0006pH-2g
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:55:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6XN4-0003qU-4P
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789494903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=isG/UafLGI1WqGN/jYrgbdMUzSDVyDgdbVXFdCNZheI=;
 b=OdR41IGEmzp3GdJgBYziacZitNgmahbDmQbsxiEhq7FM00A2fPoSovWrB9rKngrDqWqpzg
 Al3QtoBEV836L5nVKsTYxFyIqHnTI0Rw/AvjsnxsZXx4wbNZw8u38iGPpa6MoG3aEocEdZ
 b5CrZZ9dOHoxhyAuYCxk8OgUpgN8nzI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-l6_wLJTXMzuf9olAlL-5eA-1; Tue, 15 Sep 2026 13:55:02 -0400
X-MC-Unique: l6_wLJTXMzuf9olAlL-5eA-1
X-Mimecast-MFC-AGG-ID: l6_wLJTXMzuf9olAlL-5eA_1789494901
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e6b5c5f44so28206925e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789494901; x=1790099701; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=isG/UafLGI1WqGN/jYrgbdMUzSDVyDgdbVXFdCNZheI=;
 b=c9VvC/UwbyuUqOcdAbd9+NNxkYhd8LUXhyngPATYEez90UkyO1Ja4Q1UGFN9ju/HUV
 j6djgO+sVN+gWlioJAXYh720lwdbG6y6E8aRqKbLXZqNcpuH2jjG91s3zWZB0JdlGXSP
 vHah5DIFKQmfeVg3Yp5kZN3elm3Rue++NrztsYNFFtKdaqk24S4R9kTk4ZUQqhNbJ5cU
 6fjlNEb8M5VSMWS7WqE5BtIqnhdZ4GEfH2xWJ2x9uQrGzVt4Ha2K141j4JsRlzyrmEjf
 l4bI0ACKwHG1RHi4Wt0dgeGFuKvK1sMD4QIfRCowRwoGvBYJlCm4qys950uowZ82faYZ
 Sfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789494901; x=1790099701;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=isG/UafLGI1WqGN/jYrgbdMUzSDVyDgdbVXFdCNZheI=;
 b=t58K9/5inU2u451fdy403EgLLRNSyMD4A4Hr2UEdHwBDRb3xpHck4QtuRp8Bs4RfH8
 AAl5kzEgk7pSg21kiKui4vweroRcsV2sGqCG1ho6gw7MQ0jaq77/5sDH9BwbbcsK3Mvu
 B9eGasfOFSMDaWsknCJLf7eECKZSwb3G5F+POUV7G31ouwNFwdesWB0f/OyEGcLsH60s
 VpCjJIo0uAMkIaB1/VYekACbI1gJTfGX6+zvtlnPXRPaNndK5265nwfLM+/kZBHROodw
 WHKoKzhmiyXoFKSas2PO4Nrox96deytDtksrO6QUzT5UJJnd8+mT4SchdVkKzK0r1+pv
 HBPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJGoJZH5lRfsT6LO6/Q9ZK+5rBEniGAMvRthkzq0kxANIVtRGCZR8NQko2H3Ks5hlfM7LI01lbRM09@nongnu.org
X-Gm-Message-State: AFuF++lBC7XNQ58eBz/Yx/RyOz0+9YL8YIFbr2midgsBD+pPsQ7ieVeP
 jPMZgc1hC6MpmSZZk3fBQpi3Lz/gBeO+E8LoAY31u151synTRapBFeGP3rXwfri3RaKe6uTp2C6
 bRgswn1p1t7ktRyWZd5MN4exmIBOsicSED79VkjGyxFR4mbD2q4kUs7Yk
X-Gm-Gg: AYBFou1mZS9GbOb1zGY6bPO5ahVTcFx1rHc+c2y5Q5oww+RHjNVib91Ukr1S0KhM6qD
 j4IXsHWQQHxBhoY/nQtfz2rlZLhc5vimZmW+1zAUVW+UAUOXvsT161Ah7R4Ay83Wy68xtEwymWY
 cTGS5EHu7NL3/BaNaEzdIU5eMyiWMYNYqr0Qp08JJgRczUe+Bj/TCc2FapSDm97itYMdZSmsOHI
 xk4ww0rUSU2i9ORXmJO6cEfUdOFTruf0KUFYaTaDNHFeyBGEIIpPAN0eZWPIaSP0jXxnDStOSDd
 1HweDPodLrUvbnUwpjBPtKsfPwEkUYiM7bAYYB7zzVC8ntIw9YfMdLDwrnUvNnNYiQgilC1ux9h
 U8vAgSa/nMwkp+1YovthEqoY=
X-Received: by 2002:a05:600c:c168:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-49e7a662e89mr100913855e9.7.1789494900967; 
 Tue, 15 Sep 2026 10:55:00 -0700 (PDT)
X-Received: by 2002:a05:600c:c168:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-49e7a662e89mr100913515e9.7.1789494900520; 
 Tue, 15 Sep 2026 10:55:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83d903f6sm6702965e9.4.2026.09.15.10.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:55:00 -0700 (PDT)
Date: Tue, 15 Sep 2026 13:54:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org,
 jonathan.cameron@oss.qualcomm.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Junjie Cao as CXL reviewer
Message-ID: <20260915135403-mutt-send-email-mst@kernel.org>
References: <20260908042310.493882-1-junjie.cao@intel.com>
 <20260915184056.44f30b8e@jic23-hlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915184056.44f30b8e@jic23-hlaptop>
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

On Tue, Sep 15, 2026 at 06:40:56PM +0100, Jonathan Cameron wrote:
> On Tue,  8 Sep 2026 12:23:10 +0800
> Junjie Cao <junjie.cao@intel.com> wrote:
> 
> > I have been reviewing, testing and contributing to hw/cxl for the past
> > few months, and would like to be Cc'd on incoming CXL changes to help
> > with review.
> > 
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> 
> Apologies for slow reply but for the record.
> Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> Thanks for helping out!
> 
> I'm jumping through hoops to get a CXL staging tree up under new employer's
> github.
> 
> Just waiting on what I think is final step so maybe have that done today.
> 
> Jonathan

great! just to confirm the things you acked so far you will repost
as you did previously? if u want me to pick something up out of band,
pls let me know.

> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7183babd6a..bbabcf8cca 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3328,6 +3328,7 @@ F: docs/devel/migration/CPR.rst
> >  
> >  Compute Express Link
> >  M: Jonathan Cameron <jic23@kernel.org>
> > +R: Junjie Cao <junjie.cao@intel.com>
> >  L: linux-cxl@vger.kernel.org
> >  S: Supported
> >  F: hw/cxl/


