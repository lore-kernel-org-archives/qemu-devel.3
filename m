Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C30C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 21:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX6JR-0007Cg-4N; Thu, 25 Jul 2024 17:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sX6JQ-0007C1-3z
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 17:47:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sX6JO-0003xs-1T
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 17:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721944064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6tmy95W8d8fcZK8M4WYbtDZ6SLsWVsRb69dG5sobEig=;
 b=hzwAkpyMKXaw5sYZdLaG7t37Zlru2lyyV47Eecaj8/x2VnvqqgZVMHDDwunRq5OXoIKvWc
 Cl3g7OMAg8pc76nf+zTaVKcamoWrV/oFiOebZS4ZrtTQS8jtOZ1z7ldnQeOS1ox68vLrJZ
 AkllCYEdGcrPgKuDD4+mLdoGEpA4eME=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-3iny0fyhOS6qKG_5ycS-kA-1; Thu, 25 Jul 2024 17:47:43 -0400
X-MC-Unique: 3iny0fyhOS6qKG_5ycS-kA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-367990b4beeso777948f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 14:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721944061; x=1722548861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6tmy95W8d8fcZK8M4WYbtDZ6SLsWVsRb69dG5sobEig=;
 b=nqb8tWtXjDux3WY3gRVVZDCqi4uPpKdr//0bWZiPINLg3qeCpjAvvrKUEnD2Tcoe7B
 krGKubhQqdPLL1hPxzVSgpevtYY814iZh02wWKA9AgyIYciJiPJyEGkHiOciIWjJAwnp
 /Sw/Ny2KujfqcYBHo5ZZ9fc6uQSf3I4ysTmuF3/JpTNZ9t9phBe3TLpm9N/aObFGArLK
 8DJaL0alnsPghgUl3j4KaNNiQ7miVYm65NXzG7RHac9Fg6xbChew6KGzMUF3pvdkDD3f
 4udBtTosNLYLFLA1u+kvfySZ8iV4+K3PI8/M0OQLc+3rcx0b8gY39Dd/sFb4YvyyJNiV
 7IQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp/FurctnMNtp3+sEtODE9Cna9X6WKSJK/8J8M4KcUmHfNeWjNS9gh4D8a2eX1UG7pQDRFOKRcOz5GSblQWc/F18nSG08=
X-Gm-Message-State: AOJu0Yyulxwygr+Jz48+OwnpU/3jf6WUhZqGWfDt1Ukv2EGJFfVq1G0m
 EAjZ8LEFDMoOE0eoJN9Vmsotd1pgoChnPtgiOwO5nn9OZr3wn2bu8P/PgGg35P8w8HjuwU4mi/N
 +pe78i+eVxWvh1DWhC9/jF1eMcMOQucSTxoDOvVkf86Er0Q9gUnKG
X-Received: by 2002:a5d:5752:0:b0:368:57dd:3822 with SMTP id
 ffacd0b85a97d-36b319f3063mr2690260f8f.37.1721944061111; 
 Thu, 25 Jul 2024 14:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnrcTMj8bw6kTD3LLlnmlsS7YJ0E+S2t+2JYqQjwaCK2jQqu4/mn7Hg10XxeeRSeBb6Kchew==
X-Received: by 2002:a5d:5752:0:b0:368:57dd:3822 with SMTP id
 ffacd0b85a97d-36b319f3063mr2690247f8f.37.1721944060425; 
 Thu, 25 Jul 2024 14:47:40 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573eb03sm52686875e9.12.2024.07.25.14.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 14:47:39 -0700 (PDT)
Date: Thu, 25 Jul 2024 17:47:35 -0400
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
Message-ID: <20240725174327-mutt-send-email-mst@kernel.org>
References: <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240725100351-mutt-send-email-mst@kernel.org>
 <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
 <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
 <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
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

On Thu, Jul 25, 2024 at 10:29:18PM +0100, David Woodhouse wrote:
> > > > Then can't we fix it by interrupting all CPUs right after LM?
> > > > 
> > > > To me that seems like a cleaner approach - we then compartmentalize
> > > > the ABI issue - kernel has its own ABI against userspace,
> > > > devices have their own ABI against kernel.
> > > > It'd mean we need a way to detect that interrupt was sent,
> > > > maybe yet another counter inside that structure.
> > > > 
> > > > WDYT?
> > > > 
> > > > By the way the same idea would work for snapshots -
> > > > some people wanted to expose that info to userspace, too.
> 
> Those people included me. I wanted to interrupt all the vCPUs, even the
> ones which were in userspace at the moment of migration, and have the
> kernel deal with passing it on to userspace via a different ABI.
> 
> It ends up being complex and intricate, and requiring a lot of new
> kernel and userspace support. I gave up on it in the end for snapshots,
> and didn't go there again for this.

ok I believe you, I am just curious how come you need userspace
support - what I imagine would live completely in kernel ...


> By contrast, a driver which merely exposes a page of MMIO space
> identified by an ACPI device (without even the in-kernel PTP support)
> could probably be fewer than a hundred lines of code. In an externally-
> buildable module that goes back as far as RHEL8 or even further,
> allowing users to just build and use it from their application.
> 
> > was there supposed to be text here, or did you just like this
> > so much you decided to repost my mail ;) 
> 
> Hm, weirdness. I've known Evolution get into a state where it sends
> completely *empty* messages, but I've never seen it eat only my own
> part before. I had definitely typed responses (along the lines of the
> above) last time.

mutt sucks less ;)


