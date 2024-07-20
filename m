Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECD6C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 18:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVEzY-0006Fo-5c; Sat, 20 Jul 2024 14:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVEzX-0006FK-Ga
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 14:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVEzV-0003fn-Q8
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 14:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721500773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e3PnQMFRwJJUSvCrjmKDzfL37bGzpARrjE3In7K798A=;
 b=ZXKXnorAy2kUo88v0pvCodn/ERLcHBdl+K5G6MKYbEbu6uA1fexI2dbpKBzteUAIMTFSAX
 1cs09a8++LellCNBHgSX5eCbKd1V/JMFIfl/GD1FVChsBn6hab58W+oJtPyCSjV7UVd6Kp
 qCL3+q547URlwdpJ2GF6Mf/GBoHHSlE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-wWig3BOIMbuZTZ938jYl6w-1; Sat, 20 Jul 2024 14:38:48 -0400
X-MC-Unique: wWig3BOIMbuZTZ938jYl6w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4266945770eso19596075e9.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 11:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721500727; x=1722105527;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3PnQMFRwJJUSvCrjmKDzfL37bGzpARrjE3In7K798A=;
 b=RjWPbWC8CobbBNFqP/72eVKQQ7/NKE39w5zXjETSyzDpnu6/oXuVVC/ntl5o8Vyt/x
 VjQTdd5J+t71I5B3igI2sYMAcxWDnaV0nlrYD6N+LjBW4VX/uv08m3qYS0GIFyI/7qAk
 Qbll0uVfDGntpMSrgebqBgO0+FdUMlfw96eJmc3/ka81PqW8njRDzDstUQN3zBdD0tF4
 ddhYnW9Bm5ajdSUFhPRXyrWLhgsuM7bxir6vZOTwTHQLas8lM1c9jtyR1u5P1g1P3wU4
 afdIHOawaxye8HpEGDk+8jKVfg3HgEkE5oIHDppzu/2hmIxybqoZ46pEjV9nfDrW+1eI
 3wYg==
X-Gm-Message-State: AOJu0YyPQenGE7wcy/ajdMBbE4Oo95xm9mU7IjjENtUaSSXEeDwiTq/E
 qHfQP3kzj7qdduruyd89MJdkhbNmZVUiyz5Zuqyvn2FM8uZ2/mpJl7KJC5UTce31yZo/6+lKvpH
 ZMvFYJwXDNufBwy81juhu4sLsej5EKuDLCiFSl3X/koptasgja1Pi
X-Received: by 2002:a05:600c:4e8b:b0:427:9db3:46ad with SMTP id
 5b1f17b1804b1-427dc532266mr13918865e9.23.1721500726892; 
 Sat, 20 Jul 2024 11:38:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC/RMdNZnXwMGTV1q2NDsQ5rAuXLjj/bmYvwZhCT9bEr70yzN6WFNvEMZVam/e1L+hIVD1IQ==
X-Received: by 2002:a05:600c:4e8b:b0:427:9db3:46ad with SMTP id
 5b1f17b1804b1-427dc532266mr13918625e9.23.1721500726264; 
 Sat, 20 Jul 2024 11:38:46 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a721b7sm89920945e9.27.2024.07.20.11.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 11:38:45 -0700 (PDT)
Date: Sat, 20 Jul 2024 14:38:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH 0/3] Resolve vt82c686 and piix4 qemu_irq memory leaks
Message-ID: <20240720143745-mutt-send-email-mst@kernel.org>
References: <20240704205854.18537-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704205854.18537-1-shentey@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 04, 2024 at 10:58:51PM +0200, Bernhard Beschow wrote:
> This series first turns vt82c686's "INTR" pin into a named GPIO for better
> comprehensibility. It then continues fixing qemu_irq memory leaks in vt82c686
> and piix4 by connecting out IRQs of the south bridges before they get realized.
> This approach is already used in the pc machines after it had been discussed at
> KVM forum `23.
> 
> Observe that out IRQs are callbacks such as an INTR IRQ handler in a CPU which a
> south bridge wants to trigger. If, as an implementation detail, the south bridge
> wants to pass this callback to a child device, such as the PIC, then this
> callback must be known to the south bridge before it gets realized. Otherwise
> board code had to wire the PIC device itself, breaking encapsulation. This means
> that qdev_connect_gpio_out*() has to be called before realize() which this
> series implements. Another way to look at it is that callbacks apparently are
> resouces such as memory regions which are also populated before realize().
> 
> Please check if above paragraph makes sense.
> 
> Best regards,
> Bernhard


Bernhard, do you intend to resolve Zoltan's comments on this
patchset?

Thanks!


> See also:
> * https://lore.kernel.org/qemu-devel/0FFB5FD2-08CE-4CEC-9001-E7AC24407A44@gmail.
> com/
> * "Remove intermediate IRQ forwarder" patches in
> https://lore.kernel.org/qemu-devel/20230210163744.32182-1-philmd@linaro.org/
> 
> Testing done:
> * Boot amigaone machine into Linux
> * Boot pegasos2 machine into MorphOS
> * Start fuloong2e machine and check that it doesn't abort
> * Boot malta machine with https://people.debian.org/~gio/dqib/
> 
> Bernhard Beschow (3):
>   hw/isa/vt82c686: Turn "intr" irq into a named gpio
>   hw/isa/vt82c686: Resolve intermediate IRQ forwarder
>   hw/isa/piix: Resolve intermediate IRQ forwarder
> 
>  hw/isa/piix.c       | 13 ++-----------
>  hw/isa/vt82c686.c   | 12 ++----------
>  hw/mips/fuloong2e.c |  2 +-
>  hw/mips/malta.c     |  4 +---
>  hw/ppc/amigaone.c   |  8 ++++----
>  hw/ppc/pegasos2.c   |  4 ++--
>  6 files changed, 12 insertions(+), 31 deletions(-)
> 
> -- 
> 2.45.2
> 


