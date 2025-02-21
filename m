Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8938CC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 11:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlRdJ-0005aD-1T; Fri, 21 Feb 2025 06:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlRdH-0005Zk-0g
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 06:55:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlRdE-0003V9-Ud
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 06:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740138947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gmGJE1/cFvgYU1zS1FLDyNwS2mddeuCQEoy4rbCwhDY=;
 b=fk5KhpzoDFfxHN9oj91zQ6DAebCVG62AFsMi+WbQHU5J6zbRtehwbup+LgGuRED+o7jVDw
 NKNUDqEENmEI09nNqaVpx9Pk8zQc+YJoZWmWU/fDI1ImPbLBKwBZoMXk6L80KCyswE4YX6
 +Gwe3oHjmjOfqlsXGPA7cQEwCe0aZMI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-rCW05ygTO8WSTNvx8YVYNg-1; Fri, 21 Feb 2025 06:55:45 -0500
X-MC-Unique: rCW05ygTO8WSTNvx8YVYNg-1
X-Mimecast-MFC-AGG-ID: rCW05ygTO8WSTNvx8YVYNg_1740138944
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f3eb82fceso969007f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 03:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740138944; x=1740743744;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmGJE1/cFvgYU1zS1FLDyNwS2mddeuCQEoy4rbCwhDY=;
 b=hUaXHQCNV4YaCNmJip3ltvq1YI43ICrXeC6L8VwTDh6XaBTvZsMvDrEZFrnhZIES1R
 DT+SLcsqC6QbqrsrwPjuh9CCaOxFQ+AIccL1CE4E+jY7313vnqJodvh8F+uTSwnbwPmh
 Ih3ixYYUbt+LnRj4YF6xYcTT00OmjcBZnL1Zi0IkqLn8Y64PnwBNS6F+VtlBJfVWYTQ6
 Y4l5MqRi38y+zPC2hQwFEYP4GQ3rU87qLyhAupsmJb3e8NDWJNxG/qwLnXprn0IRcw+i
 cQ22PJDReEOhlmEFKaZTfjigpfC/TZM2+PdMn3hK16sHb/NyZ0niIrpAmbTA8rMamKZW
 nVDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh2gWRc46WRACIob29mj5ZEAvhFrv5xALoll3CxDk1Mk+7Xk8YoY1IF0mSpoJxDbpb2TT+5D7J7amJ@nongnu.org
X-Gm-Message-State: AOJu0YwExoTqWGkxyyYfS0kBGF7/qPNNcqe7mC/YfnnInOXXIbQGl4V4
 mwMZzCnaaw0WzKsS8fnKrFtmjzHAvKaZ5HcNw6nwoPyIJLUjfGiSxXSQ6lV/H41+AIUmc4sdLiX
 rRczi61/YdwNpoN1QjqY7R4lWqj1KO+OC0unXYyBorN0av67F4vkN
X-Gm-Gg: ASbGncvuCXShOBhGoBZLEBsXV7ANm+shV7CuF2ywD9MlejLlo9Vq6hPJqk6+xpixrrT
 otuATZaHi0IVDLvlb9klvNYXzJH58CvMzMy1XV+mY/KqFxmefZWGUSheJbQ9PoDwJTxpVEvhjib
 jBKrRgb2An1tNlFgxsgXMHH/mwdwAR5IFkEutSjGx7ftptFq3i9DAQVcJWLcDFcoaUgRlldvdUp
 d8y8UfWkdzYVwxLGlakWG+Zp6pzziFjA3p3kebuihxSucljNQzZnJqm8Y6wOubLrc2VktkURZCy
 QjQ59w==
X-Received: by 2002:a5d:6d8c:0:b0:385:ee40:2d88 with SMTP id
 ffacd0b85a97d-38f6e7565e1mr2677226f8f.3.1740138944002; 
 Fri, 21 Feb 2025 03:55:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVBC0s2o/ixpiNEoF61i0JKsmM/WLcDy2I5sE1u7/5mHSEK1aRbJrGSadNmRpVXurxUdxLjw==
X-Received: by 2002:a5d:6d8c:0:b0:385:ee40:2d88 with SMTP id
 ffacd0b85a97d-38f6e7565e1mr2677211f8f.3.1740138943652; 
 Fri, 21 Feb 2025 03:55:43 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7998sm22867171f8f.82.2025.02.21.03.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 03:55:42 -0800 (PST)
Date: Fri, 21 Feb 2025 06:55:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Yuquan Wang <wangyuquan1236@phytium.com.cn>, fan.ni@samsung.com,
 qemu-devel@nongnu.org, chenbaozi@phytium.com.cn
Subject: Re: [PATCH] docs/cxl: Add serial number for persistent-memdev
Message-ID: <20250221065509-mutt-send-email-mst@kernel.org>
References: <20250217112039.138650-1-wangyuquan1236@phytium.com.cn>
 <20250220161213.000049a9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220161213.000049a9@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Feb 20, 2025 at 04:12:13PM +0000, Jonathan Cameron wrote:
> On Mon, 17 Feb 2025 19:20:39 +0800
> Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> 
> > Add serial number parameter in the cxl persistent examples.
> > 
> > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> Looks good.  I've queued it up on my gitlab staging tree, but
> Michael if you want to pick this one directly that's fine as well.

See no reason to, I was not even CC'd.

> I should be pushing out my gitlab tree shortly (bit of networking
> fun to deal with).
> 
> > ---
> >  docs/system/devices/cxl.rst | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> > index 882b036f5e..e307caf3f8 100644
> > --- a/docs/system/devices/cxl.rst
> > +++ b/docs/system/devices/cxl.rst
> > @@ -308,7 +308,7 @@ A very simple setup with just one directly attached CXL Type 3 Persistent Memory
> >    -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M \
> >    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> >    -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> > -  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> > +  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0,sn=0x1 \
> >    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
> >  
> >  A very simple setup with just one directly attached CXL Type 3 Volatile Memory device::
> > @@ -349,13 +349,13 @@ the CXL Type3 device directly attached (no switches).::
> >    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> >    -device pxb-cxl,bus_nr=222,bus=pcie.0,id=cxl.2 \
> >    -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> > -  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> > +  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0,sn=0x1 \
> >    -device cxl-rp,port=1,bus=cxl.1,id=root_port14,chassis=0,slot=3 \
> > -  -device cxl-type3,bus=root_port14,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1 \
> > +  -device cxl-type3,bus=root_port14,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1,sn=0x2 \
> >    -device cxl-rp,port=0,bus=cxl.2,id=root_port15,chassis=0,slot=5 \
> > -  -device cxl-type3,bus=root_port15,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2 \
> > +  -device cxl-type3,bus=root_port15,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2,sn=0x3 \
> >    -device cxl-rp,port=1,bus=cxl.2,id=root_port16,chassis=0,slot=6 \
> > -  -device cxl-type3,bus=root_port16,persistent-memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3 \
> > +  -device cxl-type3,bus=root_port16,persistent-memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3,sn=0x4 \
> >    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.targets.1=cxl.2,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k
> >  
> >  An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
> > @@ -375,13 +375,13 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
> >    -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
> >    -device cxl-upstream,bus=root_port0,id=us0 \
> >    -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
> > -  -device cxl-type3,bus=swport0,persistent-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0 \
> > +  -device cxl-type3,bus=swport0,persistent-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0,sn=0x1 \
> >    -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
> > -  -device cxl-type3,bus=swport1,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1 \
> > +  -device cxl-type3,bus=swport1,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1,sn=0x2 \
> >    -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
> > -  -device cxl-type3,bus=swport2,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2 \
> > +  -device cxl-type3,bus=swport2,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2,sn=0x3 \
> >    -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
> > -  -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3 \
> > +  -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,sn=0x4 \
> >    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
> >  
> >  Deprecations


