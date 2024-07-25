Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB14C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 12:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWxbR-0003u7-Hr; Thu, 25 Jul 2024 08:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWxbP-0003o2-Rh
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 08:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWxbN-0008I4-KT
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 08:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721910582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GmqP7A+JPqJziazr6AG6F2fPGPMKo7eb6D/y7TyUksU=;
 b=X47AB8ogGixI1GGgfnH6lWu+OtZWneNBYDJz2hh146sgEqgJrH78kjVfQq9mvaLniGJ0Yy
 V2HznDmjH7K94Ud3K6gA+8Z2M4IZVGVNm0s/WEKLq6pZtO4yvn33TWFfsSgWEDSqeubLh+
 dQhDPlorBmrps4d8WDpaTlPd+/o8lXk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-RJrE3RDfMyuxaI7aVU8x3Q-1; Thu, 25 Jul 2024 08:29:38 -0400
X-MC-Unique: RJrE3RDfMyuxaI7aVU8x3Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5a69c1f5691so2913873a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 05:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721910577; x=1722515377;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmqP7A+JPqJziazr6AG6F2fPGPMKo7eb6D/y7TyUksU=;
 b=ZMPOcKJquro5pFTnKMAkp2YR+lA2JlsXbaIkYJwCQ4oqVnbqwewZBj8F9eksS5Ml/2
 OVVsfaD6EDNgfeCrHtxXTmZdS98qKQ+O1/3Gfa2MS6oK8mKJg710zdDXbyAt184dZUsN
 +9KJwqUrhJlcbAg/pMCRK/3zcwzjkpMgOT1xvmBKsvevBoAHIPGiifUkaaCdKPaR1GMe
 omdAv//ikcFCiH2qnO5Kd17hlIcw5nPIMydSmJJ2ZlnSPQk3E2KpBjILLkrv5mYwrCAq
 z14Et4OYSIssd36ECWhdMSS9Dd0TrFyRvB2mSgnEr8YvihGJumhi+ZpZyBaweS+i7i1L
 gnDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcsn3lvR8MoSCfy6EDy0YlqXXYknsJnybi/3uGY78W6OFgsajW2F8/6UZGGrLK565MrSBh40eCaEsrfDu+xrlYlgzAjGM=
X-Gm-Message-State: AOJu0YwLFnbcpxr7Q8Yyenos+3B2TYHwBceJ1Dg/F20kBGW2D0kG5dyC
 Nv+Fb3aXQSJYde1zK58nRF9ookXS2M0/+G4j85b+fOh0091RM6xBnngT4XfHCZfXII2KJKMU2pW
 t0/5qpVwDlrDVc0GFjoyf/legj3iL5JxVl9IeCweI6Xy22CdjxThS
X-Received: by 2002:a50:baa3:0:b0:58c:10fd:5082 with SMTP id
 4fb4d7f45d1cf-5ab1a7af0f3mr5616864a12.10.1721910577480; 
 Thu, 25 Jul 2024 05:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESzTf1Dq4jXq+lb4GZ/ln7u62lD42/qJf2maAOGtbm2TYn0twTp0kEGmFg6gBHrHiC+FsesQ==
X-Received: by 2002:a50:baa3:0:b0:58c:10fd:5082 with SMTP id
 4fb4d7f45d1cf-5ab1a7af0f3mr5616818a12.10.1721910576749; 
 Thu, 25 Jul 2024 05:29:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:81aa:776c:8849:e578:516a])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac64eb3becsm768874a12.74.2024.07.25.05.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 05:29:36 -0700 (PDT)
Date: Thu, 25 Jul 2024 08:29:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 "Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
 "Luu, Ryan" <rluu@amazon.com>, "Chashper, David" <chashper@amazon.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 "Christopher S . Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] ptp: Add vDSO-style vmclock support
Message-ID: <20240725082828-mutt-send-email-mst@kernel.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
 <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
 <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Thu, Jul 25, 2024 at 01:27:49PM +0100, David Woodhouse wrote:
> On Thu, 2024-07-25 at 08:17 -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 25, 2024 at 10:56:05AM +0100, David Woodhouse wrote:
> > > > Do you want to just help complete virtio-rtc then? Would be easier than
> > > > trying to keep two specs in sync.
> > > 
> > > The ACPI version is much more lightweight and doesn't take up a
> > > valuable PCI slot#. (I know, you can do virtio without PCI but that's
> > > complex in other ways).
> > > 
> > 
> > Hmm, should we support virtio over ACPI? Just asking.
> 
> Given that we support virtio DT bindings, and the ACPI "PRP0001" device
> exists with a DSM method which literally returns DT properties,
> including such properties as "compatible=virtio,mmio" ... do we
> already?
> 
> 

In a sense, but you are saying that is too complex?
Can you elaborate?

-- 
MST


