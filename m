Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9279C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 12:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWxPZ-0007mj-PP; Thu, 25 Jul 2024 08:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWxPW-0007lu-3A
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 08:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWxPS-0003hT-9P
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 08:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721909844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S3UGu/KRztNRY0Bp3FrBUk5j7TGUvdGU0FLKSCgJsvw=;
 b=WjEZWketa0yiquvy94lDLg026dn26dZaGXbJFOBtXYzJQiVIx9Wgmvgq2DFHs+trJRPPCh
 b70sWYVIFo98Y07furRnuFanzQiRpyKOdst3T+LHpXYTNrSlEEt062/HWxJWpADjYEyTOq
 bMtYM0pxBNAU4+uktjbtd8mlEf5UmuY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-GSJxa0IxO1GFUoLflovuUg-1; Thu, 25 Jul 2024 08:17:22 -0400
X-MC-Unique: GSJxa0IxO1GFUoLflovuUg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36871eb0a8eso500568f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 05:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721909841; x=1722514641;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S3UGu/KRztNRY0Bp3FrBUk5j7TGUvdGU0FLKSCgJsvw=;
 b=ix+06ol52uNjU3ps4l55twPkxwdkYc0vPYJgYBPhDpzTx9tIrmhTwy09WApfiSwKcx
 FeIv5CSxDzMNalXW7XRDwWfm0UZcBBhnqrC13iKUXJsokq9xg+gbkMZdXQU0fdQR6tEb
 lr1x0oIsZMnl/90KCjtzp3+wklAmcekKqLgI4tw289EUxvSU3Pg494+KZAdwlv+YbSpn
 TOJtNdeqTrbLbAijCBpW1OsJYGHx/ta9DsliPMDstXjS3nKPA4wnOKPtL+Sbu3C8anum
 gwMdLHhfW/TuMyl0F/8jvY3kGrP7q2S83SEa3xAFDn03U28TeLB8I/pF0/bST29QFVta
 yRwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVquyP4wBlN1/8sM6Z+chLx2e7IPDhfYKMwntKwmidqsLcqDHR+3/NOfjfY3oy+y7NKh1xvoSonvU1I4vgXuJaaehLz/iY=
X-Gm-Message-State: AOJu0Yz5Rz/eb7KTO/HqfuQxvPaG7n5jqrghFkbU17e5kJKiiP1jV/Y1
 72WnBWe/Um0eGo3pFDAyaRNafyf/FMfMm4mum79LgDY70CLrOorlw10dQYtW1W/5Hw3Ns4qPOcr
 S1l/TSjLkQqKM0nVPZWqPfIs/ldk6y9tOB+Pug84via/yh2FuKynw
X-Received: by 2002:a05:6000:10c4:b0:367:f281:260e with SMTP id
 ffacd0b85a97d-36b31ac7126mr1799095f8f.3.1721909841500; 
 Thu, 25 Jul 2024 05:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEKfa12+yv+9oCURpazLfKX3NylqFM0NYsmdlmyULxdYJys5id/PrGbgGHwZdmlDCg2IQWng==
X-Received: by 2002:a05:6000:10c4:b0:367:f281:260e with SMTP id
 ffacd0b85a97d-36b31ac7126mr1799053f8f.3.1721909840718; 
 Thu, 25 Jul 2024 05:17:20 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f8:1b05:4ed8:7577:e2b:7ae3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36863aa7sm1983920f8f.109.2024.07.25.05.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 05:17:20 -0700 (PDT)
Date: Thu, 25 Jul 2024 08:17:14 -0400
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
Message-ID: <20240725081502-mutt-send-email-mst@kernel.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
 <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
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

On Thu, Jul 25, 2024 at 10:56:05AM +0100, David Woodhouse wrote:
> > Do you want to just help complete virtio-rtc then? Would be easier than
> > trying to keep two specs in sync.
> 
> The ACPI version is much more lightweight and doesn't take up a
> valuable PCI slot#. (I know, you can do virtio without PCI but that's
> complex in other ways).
> 

Hmm, should we support virtio over ACPI? Just asking.

-- 
MST


