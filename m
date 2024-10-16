Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA02DD2A555
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 19:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t19xC-00075r-L8; Wed, 16 Oct 2024 15:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t19x8-00073e-BY
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:45:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t19x6-0005Zk-Fw
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729107898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mW0oxvId7kG+w7/tmBDcqIAmjLANa5yzQGAw7SvqZtw=;
 b=S7PtOehkcRbszqCAuxQdgEXhDILqW3e2UAAJBVbWSlVry/nIKLtBCUeYgNq8qWyDPbmT13
 QfYFDadbafwnwc4J46CqeX18yTYUMtS5ihPbLcaEnzy5DIUVOrApv7GXAW1uo8x0Gys702
 uzCRMBHGL2x53iCfCOvGS7dJ3v0enXg=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-HjycEQaXMpWK7UpwopSJkQ-1; Wed, 16 Oct 2024 15:44:57 -0400
X-MC-Unique: HjycEQaXMpWK7UpwopSJkQ-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5eb61b55b47so246705eaf.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 12:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729107897; x=1729712697;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mW0oxvId7kG+w7/tmBDcqIAmjLANa5yzQGAw7SvqZtw=;
 b=JpV2m0Nhd4VQM4z0QkYL3iBjBQMfvfss8MNLrLW6aKVFBLXigmPIQPhRJuSTMUDn2+
 G4eELra0afOj8oPbJwb+kbA96/NTLIS32eSKXKpE9SYsRFHXNglatxVf8sXdvqViIMmd
 z8R7ispUw1DKap1Q2d8AQZVSP0lOQjV18sW8v3C4W1zELnNAgCOjkeGQ6EO1pBzlJ19Q
 tQS3P/jC5C/mK1SSoRuiKWB4TnxW1sVEiAWyyFL3Xlwc9Grj54t1etYmitXpMHhjHS1X
 SjHoz0+emNZI/f48MuaZ0ls/ts2EkypLvoxkBbavh3AHxX0WYXuh3JFnXMIuw3kRYPCV
 4jnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuUzxqXOwKejTq+UGuQJX74nm97Y5hzffabRYVPjut8YOcEl/yFxeQoHwrCbk2YsoQrUOwuAP/SS7B@nongnu.org
X-Gm-Message-State: AOJu0YwQpSY8KbwcvUHX8Iby1VvE9a2GxhvRJqj8L5j/LVm26RnzsXms
 iXpVLvlQLgBTKTnU5R9RD0ORc1UrKC+aaMvz7XimrPB5X/x7fRs1utGRdAn+SLF487yn2PHG8JA
 yoAWxfSFs3M19C0jo8U/6vK87uY/SJyxPnEc5cj1+zxR3UHm8jeBG
X-Received: by 2002:a05:6358:7e0b:b0:1aa:d5c8:ec94 with SMTP id
 e5c5f4694b2df-1c3784fae72mr424748555d.26.1729107896750; 
 Wed, 16 Oct 2024 12:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPWGrku4CYKN0L8EqSbhEqjPzuU6f33XUmxvTVMZZhUJq0IY4AqI0iCfARJSDOctmrY8YfOg==
X-Received: by 2002:a05:6358:7e0b:b0:1aa:d5c8:ec94 with SMTP id
 e5c5f4694b2df-1c3784fae72mr424746755d.26.1729107896432; 
 Wed, 16 Oct 2024 12:44:56 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4607b0a28d3sm20808521cf.18.2024.10.16.12.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 12:44:55 -0700 (PDT)
Date: Wed, 16 Oct 2024 15:44:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [External] Re: [PATCH v6 00/12] Use Intel DSA accelerator to
 offload zero page checking in multifd live migration.
Message-ID: <ZxAXterqtYw2j5eV@x1n>
References: <20241009234610.27039-1-yichen.wang@bytedance.com>
 <ZwlTCgqjbFbJduyI@x1n>
 <CAHObMVbmQt6U_16dYG4y_9kt76fk_W+OSSe34SRmFrC0bGNOVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHObMVbmQt6U_16dYG4y_9kt76fk_W+OSSe34SRmFrC0bGNOVw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Oct 15, 2024 at 03:02:37PM -0700, Yichen Wang wrote:
> On Fri, Oct 11, 2024 at 9:32 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Oct 09, 2024 at 04:45:58PM -0700, Yichen Wang wrote:
> >
> > The doc update is still missing under docs/, we may need that for a final
> > merge.
> >
> 
> I will work with Intel to prepare a doc in my next patch.
> 
> > Are you using this in production?  How it performs in real life?  What is
> > the major issue to solve for you?  Is it "zero detect eats cpu too much",
> > or "migration too slow", or "we're doing experiment with the new hardwares,
> > and see how it goes if we apply it on top of migrations"?
> >
> 
> Yes, we do use it in production. Our codebase is based on an old QEMU
> release (5.X), so we backported the series there. The major use case
> is just to accelerate the live migration, and it is currently under QA
> scale testing. The main motivation is, we reserve 4 cores for all
> control plane services including QEMU. While doing 2nd-scheduling
> (i.e. live migration to reduce the fragmentations, and very commonly
> seen on cloud providers), we realize QEMU will eat a lot of CPUs which
> causes jitter and slowness on the control planes. Even though this is
> not happening too frequently, we still want it to be stable. With the
> help of DSA, it saves CPU while accelerates the process, so we want to
> use it in production.

Thanks. Please consider adding something like this (issues, why DSA help
and how, etc.) into the doc file.

> 
> > There're a lot of new code added for dsa just for this optimization on zero
> > page detection.  We'd better understand the major benefits, and also
> > whether that's applicable to other part of qemu or migration-only.  I
> > actually wonder if we're going to support enqcmd whether migration is the
> > best starting point (rather than other places where we emulate tons of
> > devices, and maybe some backends can speedup IOs with enqcmd in some
> > form?).. but it's more of a pure question.
> >
> 
> I tried to put most of the code in dsa.c and do minimum changes on all
> other files. Even in dsa.c, it has the abstraction for "submit task",
> and the implementation of "submit a buffer_zero task". I think this is
> the best I can think of. I am open to suggestions of how we can help
> to move this forward. :)

That's ok.

Though I think you ignored some of my question in the email on some
parameter I never found myself in this series but got mentioned.  If you
plan to repost soon, please help make sure the patchset is properly tested
(including builds), and the results are reflecting what was posted.

Thanks,

-- 
Peter Xu


