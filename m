Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D87AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 05:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZOiZ-0004Cr-94; Thu, 01 Aug 2024 01:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZOiX-0004CM-Cs
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:51:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZOiV-0006CE-Ua
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722491470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ea21U94GKphVCH40IrEwhhfhcDhhKR55/2PSjfUKmQs=;
 b=RvcERkWjxeuiYX7Xgq2L7QlhSfhcWISVJwQGMfo/GARljMGZdccGxBPEC1sj+xjFLr9kRg
 pV4djCjdezgsTH4iS33pWGlyCwIcEQy1/Mmc10TjCPYt92L/ShM3ZaZ7NpbMVcKFulT9/2
 gT68zv4WzWYk6cp2YF2Jwx2uohdYmdg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-G9vtJB2eMFGUCuI5QorwGg-1; Thu, 01 Aug 2024 01:51:09 -0400
X-MC-Unique: G9vtJB2eMFGUCuI5QorwGg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-530ad977cb6so2459036e87.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 22:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722491468; x=1723096268;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ea21U94GKphVCH40IrEwhhfhcDhhKR55/2PSjfUKmQs=;
 b=Ab0MQmnQs6K3697t2APLPy+EhpYCEFDhRTmyffZty4927Zk5ogtn5NsKmd8OQYopCl
 ooQjm0g+dJqLJww7lXjHfJbqgkq7ZeJYxleBFA57Hbbe7/Tq+S3UcrGGldeysib9jCjf
 u6/iwCVXXna6Ckx0xem8jGZNq+Oj7OYASAc4hBm2gnJvpAoYS9N7JYwR3Hvm/UMsZyrN
 0MIrt4qooxeJABRoRQmzKSgUpeZMBMLVbTqtNUsv94XqPH5VCZ05I9NMWPEIwGQluogu
 dPeUqiGn4/f1DgP3kHGmaN3Re+Pm2uXm+TZ1/rQeELAsqK2mMaXhqb/UlyrEFd/aQXfx
 TkAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2VIvMrfNIigDQI6T8+ZZ46GiOXk/0JUm7MUOS68luEKMh1WvTwv9L5ZTN+ICFDYymkk1ZXvzBE+yp+Nelv8ZhitzdByY=
X-Gm-Message-State: AOJu0YyiFEs5VWoZP4XYGhIklvsQdaoH9Py2a9rxBtOvmyTifdR9oD25
 mG01wNxJ2pXxivzmZcTwsichBh64tWyzOuYfmonQasBA/LDrltzr3RgvTJPd2K5UMZFG/gq2OJY
 UC1ojXhGImFChhhRFPxK9ELVw6aXoiqguj8OIc8tgjoPsk1GkjjUN
X-Received: by 2002:ac2:498d:0:b0:52e:f9cf:cc1d with SMTP id
 2adb3069b0e04-530b61b15f1mr533702e87.23.1722491467665; 
 Wed, 31 Jul 2024 22:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG4/xABh1zN7rS122zbBd92crH5qHFzp+Izn+mLyMiiOU6zbBmvFEI1/AaJXSS60QeaDdTEg==
X-Received: by 2002:ac2:498d:0:b0:52e:f9cf:cc1d with SMTP id
 2adb3069b0e04-530b61b15f1mr533680e87.23.1722491466716; 
 Wed, 31 Jul 2024 22:51:06 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac65783561sm9709820a12.92.2024.07.31.22.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 22:51:05 -0700 (PDT)
Date: Thu, 1 Aug 2024 01:51:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240801014222-mutt-send-email-mst@kernel.org>
References: <ZqfQ0cGf8t2trEdl@redhat.com> <ZqktXwxBWjuAgGxZ@x1n>
 <Zqk09BGxlpdxMBMx@redhat.com> <Zqk6x2nd3Twz--75@x1n>
 <20240730151746-mutt-send-email-mst@kernel.org>
 <ZqlHKaQXzKGcnoBM@x1n>
 <20240730172148-mutt-send-email-mst@kernel.org>
 <Zqnh-AJC4JPl5EkS@redhat.com>
 <20240731033803-mutt-send-email-mst@kernel.org>
 <Zqo00Na1MZpksY9A@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqo00Na1MZpksY9A@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

On Wed, Jul 31, 2024 at 08:57:52AM -0400, Peter Xu wrote:
> Could you elaborate why it would fail if with what I proposed?

First I think I was wrong I misunderstood what you said.
To summarise, you said:

- any new feature depending on another package is off by default
- starting qemu on destination with feature enabled will fail
  thus migration is not started


My comment is that this "started" is from qemu point of view,
from user's POV starting qemu on destination is just the 1st
step of migration.


However I agree, this is better since we do not waste bandwidth,
and I was wrong to say we do.

My other comment is that adding features becomes even more work
than it is now.

So I suggest a single command that dumps some description of host
features, to be passed to qemu on destination. qemu then fails to
start on destination if some of these do not work.
The advantage is that this also helps things like -cpu host,
and a bunch of other things like vdpa where we like to pass through
config from kernel.

The disadvantage is that it does not exactly *fix* migration,
it just does not let you start it.



-- 
MST


