Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B781AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 16:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZv6u-0002SY-Dd; Fri, 02 Aug 2024 12:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sZv6t-0002Rt-2H
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:26:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sZv6r-0006fJ-5S
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722615987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WYJP2WPweH6IxZbIiJtkBYnDl1I6THBDCKGTlL4gQIg=;
 b=IzTD0c4cJ5IKut5xgyMlg8SwXLI8dELlmXLmmZw9ogzPxtwR6mqpX0VGM1S06ZAYzyYkwL
 y5PJ4I4ROVVeSj3A5WwcZU8IOC+AWZKrA53RXh0hi9gutXPsP/TmR1lZOFJpAYidWcyQxU
 v0bqEFJHDEAfK6e66Tbm+vU9x0sZYPs=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-Nm6xgg9POf-os-QuD7M5bQ-1; Fri, 02 Aug 2024 12:26:26 -0400
X-MC-Unique: Nm6xgg9POf-os-QuD7M5bQ-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7093890e502so1676843a34.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 09:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722615985; x=1723220785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WYJP2WPweH6IxZbIiJtkBYnDl1I6THBDCKGTlL4gQIg=;
 b=Yx3wuBl8Dj/zBfmuPVqUgfLYGNrXt83BcQfgRL3pmReCVWMwu1s6y8e4tZjnyJrFDo
 gQswJmTYMIX9gUxfGu+9gBkxNBCYUj65wbTP+B7kBa2tQB2kkR9/10t28zQdB3JrZSYh
 VDfisO2UA2G68etDzqxGAUlG2JkNxxpfAUz5KDKXn4ab1SEX0SX1J3EJtQOnzOQK5MtB
 6uHxIPGcJFrtzHbdAiQu9LmsESgY1OfFy2iqp6APbay0edyeehZphK6NmqHLNzR/6fEu
 mXGNPCQV5oGw6dPjUS1J6iBbm6ZfHSc08BQqcGp+r/dMaADSIU7RK/YZrW1IqZXd1JFl
 s9sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq3uPK3Zz0wT5/Pe+mL+dT6WqEhmq0kwjk7DL49QsuWB0tcnSAe9tYWhiGHrWeeSUb300vCZnUtc6x@nongnu.org
X-Gm-Message-State: AOJu0YxL211ztUOR/42NyEo2cF2sYwq9CkkBLTZpK6GPMvLTWYyFuS+N
 ibEziXSiWO6MgIYXauCaJ3bW/Rc/8DNXhac/Hv1sL1+fxclz8r9v6sEwnm3UnFFblvaoD6/Ix2k
 FgOzKZhGabk0reGDWnj5g+YlNb6E8QAZRye8iLvsLDJPTbTcT7L5U
X-Received: by 2002:a05:6830:f81:b0:704:4987:2342 with SMTP id
 46e09a7af769-709b995bb2cmr2833611a34.3.1722615985614; 
 Fri, 02 Aug 2024 09:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1LnH/41L+D8cOHKMlQonebCkfoWyKDvfc4BrAcVmfOvTEb6TDuTUllCcs5ZapQnCasoj/Rw==
X-Received: by 2002:a05:6830:f81:b0:704:4987:2342 with SMTP id
 46e09a7af769-709b995bb2cmr2833576a34.3.1722615985204; 
 Fri, 02 Aug 2024 09:26:25 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb9c78b17fsm8438446d6.34.2024.08.02.09.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 09:26:24 -0700 (PDT)
Date: Fri, 2 Aug 2024 12:26:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <Zq0IrhV-DgStpJtk@x1n>
References: <ZqfKrtQSSRVnEOGt@x1n> <ZqfQ0cGf8t2trEdl@redhat.com>
 <ZqktXwxBWjuAgGxZ@x1n> <Zqk09BGxlpdxMBMx@redhat.com>
 <Zqk6x2nd3Twz--75@x1n>
 <39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com>
 <ZqumIZcs1tCNTpRE@x1n>
 <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com>
 <Zqz1vvYqRuIAPnod@x1n>
 <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
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

On Sat, Aug 03, 2024 at 12:54:51AM +0900, Akihiko Odaki wrote:
> > > > I'm not sure if I read it right.  Perhaps you meant something more generic
> > > > than -platform but similar?
> > > > 
> > > > For example, "-profile [PROFILE]" qemu cmdline, where PROFILE can be either
> > > > "perf" or "compat", while by default to "compat"?
> > > 
> > > "perf" would cover 4) and "compat" will cover 1). However neither of them
> > > will cover 2) because an enum is not enough to know about all hosts. I
> > > presented a design that will cover 2) in:
> > > https://lore.kernel.org/r/2da4ebcd-2058-49c3-a4ec-8e60536e5cbb@daynix.com
> > 
> > "-merge-platform" shouldn't be a QEMU parameter, but should be something
> > separate.
> 
> Do you mean merging platform dumps should be done with another command? I
> think we will want to know the QOM tree is in use when implementing
> -merge-platform. For example, you cannot define a "platform" when e.g., you
> don't know what netdev backend (e.g., user, vhost-net, vhost-vdpa) is
> connected to virtio-net devices. Of course we can include those information
> in dumps, but we don't do so for VMState.

What I was thinking is the generated platform dump shouldn't care about
what is used as backend: it should try to probe whatever is specified in
the qemu cmdline, and it's the user's job to make sure the exact same qemu
cmdline is used in other hosts to dump this information.

IOW, the dump will only contain the information that was based on the qemu
cmdline.  E.g., if it doesn't include virtio device at all, and if we only
support such dump for virtio, it should dump nothing.

Then the -merge-platform will expect all dumps to look the same too,
merging them with AND on each field.

Said that, I actually am still not clear on how / whether it should work at
last.  At least my previous concern (1) didn't has a good answer yet, on
what we do when profile collisions with qemu cmdlines.  So far I actually
still think it more straightforward that in migration we handshake on these
capabilities if possible.

And that's why I was thinking (where I totally agree with you on this) that
whether we should settle a short term plan first to be on the safe side
that we start with migration always being compatible, then we figure the
other approach.  That seems easier to me, and it's also a matter of whether
we want to do something for 9.1, or leaving that for 9.2 for USO*.

Thanks,

-- 
Peter Xu


