Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11ECFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6AC-0003gE-S4; Wed, 29 Apr 2026 10:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wI6A8-0003fo-9Y
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wI6A6-0004EM-Bn
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777473913;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tFVSG23JHrIxmQus4bpKOn6Uiv6ar6GtHzR16cEj8M4=;
 b=LAUy9daWAMPhFwQTqpqDwvgTj36pS8NDH3oWiiX5jrCRgQi2t49VivxAV8ADCxLYtTNBOc
 GsDAzjpigyt56DI3M8vaujMJBoQG05UbNDt26rKnBwhO1NzjJKYLXSDedC2vxHZXoJJbCx
 AeJARmww3hCRIFJYOxW5226cENlcYHM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-2fzmA-XiMuW49rqa1YRbGg-1; Wed, 29 Apr 2026 10:44:55 -0400
X-MC-Unique: 2fzmA-XiMuW49rqa1YRbGg-1
X-Mimecast-MFC-AGG-ID: 2fzmA-XiMuW49rqa1YRbGg_1777473894
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48a55ecc32cso76367335e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777473894; x=1778078694; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tFVSG23JHrIxmQus4bpKOn6Uiv6ar6GtHzR16cEj8M4=;
 b=i+pSueP5vqiptcCTs0LwHode+VC76ofNYNtS8kf8X39ftDTHPFMqnQZc0ykQUFOsXW
 PJcnU6Sc7h0GKH3mKHTUMyi7iFK5QNtEnm7/px/YrmKDHZusuyMjxBRb4roJaiBoqxDX
 JEQg77QbPM/aFXeHbKVJdAssdhtrHpLCfNa4DCPW8kIm8NWHmDBRNjga72zFVBnFxFUy
 T/sgLVMR3BMBbPb0B+THFVPl9YRnhEyWQBosqf4h2x+emV+Lb1/xEpVnsYoZd+9lbd4t
 PyzdMbysSt641PE53DrDL75CQCUhC2HK5TYkr8a9puUu8hFtJ/Qh56wzM4XeS3jLXs4r
 RWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473894; x=1778078694;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tFVSG23JHrIxmQus4bpKOn6Uiv6ar6GtHzR16cEj8M4=;
 b=EIwo9J2HB88bFYAnFQUOy/IJbgBlpVgQi/DFpxiaBZ4xQyEguzCB+UM1+186EtPXIx
 Srq84yNWFu5NxGcE6v/Vt5RElTV9B+XaoeSf4B8ZEnBtw3c2zUjtJqv94HhRiJy4V0bn
 tsYXU9IFtwCVr9tQ/unflmdZcLU9W6IU7xQ3G2+7YyVVf7M6BvrWHYzt8bNJft4QhjYW
 mVKUR5qu8vJRikdQLWTiQN1AcZ9t6nmkovMeoBCAmDpYFj3Lu12FvaKBZ6isHxWXkorg
 /htbNEc0ir0W1Sf37Qj+d78HHkysjheUNB71OwlMS6jtFBGUu5+i87PVe/jGhHxWhO1N
 u5xw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/di98aPHLe2vIKrHWs1OUj3lWviVtPan4+jgDvpMYo8eVW0v4RTIDjLoT87UgdlskZqYikOzNuqt0v@nongnu.org
X-Gm-Message-State: AOJu0Yy5Ac0/p8lqwKWU3NKTBSZUBXC4WR025ZrZ6NyP0WLkF6puZRXx
 jF4ohbPjRHZMHIkCet5LJHcbKBWmmk3zxfClpRmj6UA7LeIOvKhUB8hw3v4OISnv38P6fFlmnyP
 owVF5RcDnB4nZzQSGI8N1NWKyao/Qtt78iT3u72lDHCXaW0tAmdA5uiZ3
X-Gm-Gg: AeBDieuBGheIcN6BG2gQgpicbaVdHfOh51juogiRUv5f1+cVBBFxLQMTAl5HAOWYOe8
 7HawPXe+acYraS+hj8Kkw0O7auUhyL0l3r6vreHzYgHUwV4cElnFEaIuxDxMXvdMKQzI2rjQdDi
 ukux5z23WXxbuesKdW0ng/vF9Sa04vLsYDkuNOiZYM2hpt77lwmQY7Pc2T4Z1gs76T/MU8Zi5bB
 gDMVscojSiX/iGny1yXyrZfxhg41D++wMYMj/m6x1MH7N/UKmMbwswkbffdg74LOJBEHiHVKXqX
 7Qhi4yJXtzJJ1I9nmDGs4+0wuxZ2cyUEs0AtluGMxNqkGT+hEBbJn/sgzNgKstyikbS4UYBETYt
 C55o8PDbH+fl4rwrNFNGKZJXFgg5Q5DM=
X-Received: by 2002:a05:600c:5247:b0:489:e696:836f with SMTP id
 5b1f17b1804b1-48a7b519485mr71487215e9.10.1777473893667; 
 Wed, 29 Apr 2026 07:44:53 -0700 (PDT)
X-Received: by 2002:a05:600c:5247:b0:489:e696:836f with SMTP id
 5b1f17b1804b1-48a7b519485mr71486155e9.10.1777473892892; 
 Wed, 29 Apr 2026 07:44:52 -0700 (PDT)
Received: from redhat.com ([2a02:8012:f011:0:f1ce:ac56:d2cd:7c2e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7bc23ffesm61112385e9.8.2026.04.29.07.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:44:52 -0700 (PDT)
Date: Wed, 29 Apr 2026 15:44:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Markus Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, cw@f00f.org,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Demi Marie Obenour <demiobenour@gmail.com>, dhedde@kalrayinc.com,
 Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 Alyssa Ross <hi@alyssa.is>, iggy@theiggy.com,
 Warner Losh <imp@bsdimp.com>, jacob.oursland@gmail.com,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 matthieu@minio.io, Max Chou <max.chou@sifive.com>,
 Mark Burton <mburton@qti.qualcomm.com>, mdean@redhat.com,
 "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>,
 z.huo@139.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 zwu.kernel@gmail.com
Subject: Re: KVM/QEMU community call 28/4/2026 agenda items?
Message-ID: <afIZYIgaAZiQ6xQu@redhat.com>
References: <874il05rwo.fsf@draig.linaro.org>
 <ce906d97-7022-4671-8590-2f8f58b098bf@linaro.org>
 <e341ea82-5389-4e13-9fb5-a00c3383da85@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e341ea82-5389-4e13-9fb5-a00c3383da85@oss.qualcomm.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 24, 2026 at 12:31:06PM -0700, Pierrick Bouvier wrote:
> On 4/24/2026 8:40 AM, Philippe Mathieu-Daudé wrote:
> > Hi,
> > 
> > On 24/4/26 16:55, Alex Bennée wrote:
> > 
> > > The KVM/QEMU community call is at:
> > > 
> > > https://meet.jit.si/kvmcallmeeting
> > > @
> > > 28/04/2026 14:00 UTC
> > > 
> > > Are there any agenda items for the sync-up?
> > 
> > I'd like to have a discussion with Stefan and Pierrick about the
> > possible improvements that can be done on our CI system, and
> > review our git-forge use in general.
> > 
> 
> That's a nice topic I would be happy to talk about with all of you.
> 
> > Pierrick: Stefan is available this Tuesday, are you?
> > 
> 
> It would be 6am on my side, which is too early sorry.
> 
> However, I would be very happy to talk about it in private with Stefan and
> you, and other people interested in this specific topic.
> 
> I just feel it will be a conversation that may derail very easily with many
> people participating, and it would be better to restrict it to people very
> enthusiastic about it first.
> 
> Once we have a concrete plan, we can share it more widely and deal with
> critics and see what can really be done.

Can we please keep the discussions in public. Yes, sometimes the threads
can derail, but that's just a characteristic of our open collaboration
process. Switching to private design and then presenting a solution is
not the way to work in the community.

With regards,
Daniel


