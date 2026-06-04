Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6497CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 06:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV1GS-00041r-SN; Thu, 04 Jun 2026 02:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wV1GO-0003zu-FR
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 02:09:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wV1GK-0004Iu-Ns
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 02:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780553343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FrXJu03KKLiEAvbOex2Qm0+LorcLZBZ9kAhu7c7HBYo=;
 b=PvOkKeuJ1KMKios46rajbSGVfyiHvehwf9IL/0hoLs54PDcYmtLxHbMznABIyVsw7UtYSi
 +u9cw1fxb2MEM2HLVnZQj/JSukPUhpinlimgbvCIZO15DtQvhf1XXpp0S945mduN2hIfrf
 gEnP9SUsiQTIvwFbecmVjmF62++QWPw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-xo-V4uALPYui-yrd7VYqVg-1; Thu, 04 Jun 2026 02:09:01 -0400
X-MC-Unique: xo-V4uALPYui-yrd7VYqVg-1
X-Mimecast-MFC-AGG-ID: xo-V4uALPYui-yrd7VYqVg_1780553340
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490a763180bso3539555e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 23:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780553340; x=1781158140; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FrXJu03KKLiEAvbOex2Qm0+LorcLZBZ9kAhu7c7HBYo=;
 b=Cp9ljx12wZNwz1uKeBFAHkJ/qOz401Y29x2EiDN29vrFhRR+6C4WiiBcCQbqjBvqjR
 bcXFtBYkbNNl8Nv3A0vM6xXaHbqV8HLOaFxjtGYg2sZUKFB+j2sIy8i7Kb8BcxDl9U72
 MQQDxfRIMuYZl6i/x7FFdWBtsuxFWRKN4cpI/bsG9WvkFviozU7kuNWgdmy2kA2lXOSb
 HGqPLH4Bczm9wMm6o2J/lky3401yDj7HiTRRycqQVS0aesmja8am7kKVTRsSO9gzl0q4
 9jdA6TmsvN53ITmlq8YxAGlBneyJcQGS6ba/ISbGspzJSfA3fXLjPSSGj1O7oMKCgGKy
 +1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780553340; x=1781158140;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FrXJu03KKLiEAvbOex2Qm0+LorcLZBZ9kAhu7c7HBYo=;
 b=cbYdAq2OP5rWfe2fDmL00iQM0ALmeah+XfoN5M0PbA1VkP0pIiS5aDlrt6564po3wG
 7TKWDteebBBxCn0srwpJ1/fnRQCTsw/NapBWUyLRULuvzYD8hzrHtuKaGdKf9VOdblsG
 lVHRUGzKM3X9wrRUyL6JQkkqfXtd1NKc9W9YFtJscXW+NWqdefElczBzvKt1B/bz+NFn
 Ck6kVdMlelkagwmKVLTBCu1bYhHcIJaQNfOQE0aDBo2doCND/I4jjT9zcZvio6d98/Au
 DHQoRQsAlYjH0W29eBq39Iqh5uWjnSER8y4rWJdkwJiYP8d2mL0p4WcFr4jQT76boIuM
 /MMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jupZcaeh72RBg9RqGY+RqInJMYPM6V90QqM6CrFDasWS6Oee1KKC/SrcB+V8/5srRSEOgNzhUcEzU@nongnu.org
X-Gm-Message-State: AOJu0Yz3N2XXlZ1Sgad9e3Vypb1+uUw4v0yrKYMwXzx4DG2adyUoVsWR
 yNIeqfYb2dRHIKth0uJzNHjMsbdjvVQHriqAL+FZVgCJQGhn8nxmkG1KOqBWeNRt6Pk3Nvkok6m
 NWLcL+qUIQEiDWAfd47z8HagltSkqAgjQwyQamw6mpx9AHpOyOwGIPjpv
X-Gm-Gg: Acq92OH290RiXPKA6Evj4Hr820jm9GSIcsTpt/kW/KXqmF39GVQVvoeACku3aUNQdDg
 9xXwe31PMUuOpjz5KcqiyXoF5XzsRnEuiG0i84f3VCmoQMeuY8ge2z1Th+8i8BL2C40iQiwdqyx
 R14Jgn/BH6XuakfWLZ0KPOsaAlI5pGudPRbyQFq9Vy7YFvQj3J+k4xMDDGlNiw84GjRTtBsClMf
 A1G1mvCc6+BiT2jxSFhN5b5gk/dD2ACR9Z9KGm7QRBQa+9x1p0ZPJk18RSaZ8w7x76acgMCMWMc
 Ef8MzhSV+iEodgdS9Y+h54YSJEXCljpkveX9JQy6PxqSiyPHpHegy0MpGj/OTEYvZKn2tNRhuq6
 lhoTrnzJg+gj/nAxIDxu5P8amGT7AFj656XckRyhQdBrfLmgkTc2MDQ==
X-Received: by 2002:a05:600c:4510:b0:490:a298:3859 with SMTP id
 5b1f17b1804b1-490b60f001amr102093965e9.24.1780553340165; 
 Wed, 03 Jun 2026 23:09:00 -0700 (PDT)
X-Received: by 2002:a05:600c:4510:b0:490:a298:3859 with SMTP id
 5b1f17b1804b1-490b60f001amr102093195e9.24.1780553339530; 
 Wed, 03 Jun 2026 23:08:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3fcf5bsm47144275e9.9.2026.06.03.23.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 23:08:58 -0700 (PDT)
Date: Thu, 4 Jun 2026 02:08:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260604020826-mutt-send-email-mst@kernel.org>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <aiBBV48wyDF57vUi@redhat.com>
 <CABgObfZNX2rLnB=FosVopFmLB_S_5V48UPLjNTTtn543d9RfHg@mail.gmail.com>
 <8733z3trth.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8733z3trth.fsf@draig.linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 03, 2026 at 07:14:02PM +0100, Alex Bennée wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > Hi Daniel,
> >
> > Thanks for the review. It will take a while to incorporate everything
> > and I'll wait for more feedback, in the meantime just a couple things
> > I can confirm or add...
> 
> I mean you could just let the LLM handle it ;-)

One has to like that )


