Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9C5C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 20:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlCic-0007fh-OY; Thu, 20 Feb 2025 15:00:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1tlCiY-0007fC-0p
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 15:00:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1tlCiV-0008Ot-Ud
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 15:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740081612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BmKzjaNSRadRsfGvVd28eze2sxG/mnoDMm0RrSy2xVI=;
 b=ZDpBez535IJnZZAE2nT8XHRhW9BjIG2Y5MxCNW1UrVLvE9G6er4sLg4Q2gHohlmCKG85M5
 W6K1IgxopHXG+SKN4vvOkLSQSnbFkatfk8GV5NzwCz2bS15KMQtnolS/EA3U77MjLxIPWZ
 f5BQ4a0ipJPhypZhhnYP6/XPR+Orld0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-3kyoHDVdPQ6Z7UwPE-y1yA-1; Thu, 20 Feb 2025 15:00:09 -0500
X-MC-Unique: 3kyoHDVdPQ6Z7UwPE-y1yA-1
X-Mimecast-MFC-AGG-ID: 3kyoHDVdPQ6Z7UwPE-y1yA_1740081608
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f2ef5f0dbso578153f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 12:00:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740081608; x=1740686408;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BmKzjaNSRadRsfGvVd28eze2sxG/mnoDMm0RrSy2xVI=;
 b=RQVj28qTfJEYa2n6Vm9uv70w0PxpxA3wnFCwScB8cciHqt4Ajd1R8gRwVsfjybOSgj
 rK+2LXbf4Sk6PhzFXXHtsORSxMnby+Et4tjK+Cdx8hKzALfS3RLqAtLSXqGVN7DRirr4
 q0dqrvzMSAkTwfiirjCJxCfXc2xy4EcXq5A97/lLgH4nl2kEDZhqB7Vni73e9dRS0iFv
 EE9jZvzVrJ4OKK55tv2ExQ8i7G3XT0/T3SrxZnuU5Xkp2c/jWWAgD0KKHgGIwJJTOi5F
 Ah4yDvA3fwM2Cby3EM6qteYaIQ4YL+My2Px2FImTQ8vg6IQ45nHjd8nXN6mc1pdHLhRO
 /8Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIaWIDQxaJSTOd/PvmHl4bgAQCQkRd+PM/5y9wLozw8Ub8kCHNk3s/JpvCLZXoPRoNwKlQk78EjpcX@nongnu.org
X-Gm-Message-State: AOJu0Yz0YCPOYyNgM3BrACAzhru8YfqDohmXSzNGY8Q/4fXyO2btiqmW
 xxNUkSclkdgEyG1VMGdbiT6V9oHVo8tBRcLNQ7fqFsYeONL5uoaMgjyybYBDMc6206cZl+QfdXF
 jA3egz1fYQDpQKVUwhnDdDgkc0xps+aLzwxWfUrMXXNMRyYP1utUJ
X-Gm-Gg: ASbGncujYVhjsh1pvvCd43Do8v7waf+aHT4TFlH3W4j0ulEQpshwPJLZ1+J5AheOsW2
 D/JX15ccohUMtfkw/6cXPbx5xhd9QeagCvHApy/bvy0BcHIa4cY+GEJOtj/N9JswnUtNw4qgdpo
 YErV/JOJsnSTlywfWDq5eqqR2UnBLAKdFausM9Vjmg65u1KWLX/KbNJcjYzfrhZp5Lyxx1uMwV/
 /d15rzKqLKog7dfV23oI8eDY3WyEjVJ0HTIRMndMmBjGnF0Bi/lsgFyg8u7hXHDAnEMNivJkzaQ
 R8ccMjdkgTQW6fuq
X-Received: by 2002:a5d:6e8a:0:b0:38d:e378:20f7 with SMTP id
 ffacd0b85a97d-38f6f09749emr383724f8f.41.1740081606926; 
 Thu, 20 Feb 2025 12:00:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN25ewCrDeKdO6CyYofac833fmpaFVzpZN+Dcbc8gkUPeJ5sMiH4fXMvaNJip1VHnYf4RyZw==
X-Received: by 2002:a5d:6e8a:0:b0:38d:e378:20f7 with SMTP id
 ffacd0b85a97d-38f6f09749emr383696f8f.41.1740081606453; 
 Thu, 20 Feb 2025 12:00:06 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud.
 [2a10:fc81:a806:d6a9::1]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399c5f901bsm29518775e9.3.2025.02.20.12.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 12:00:06 -0800 (PST)
Date: Thu, 20 Feb 2025 21:00:04 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, qemu-devel@nongnu.org, Jason Wang
 <jasowang@redhat.com>, Thibaut Collet <thibaut.collet@6wind.com>
Subject: Re: [PATCH] vhost-user: Silence unsupported
 VHOST_USER_PROTOCOL_F_RARP error
Message-ID: <20250220210004.1501dd86@elisabeth>
In-Reply-To: <20250220131932-mutt-send-email-mst@kernel.org>
References: <20250121100029.1106973-1-lvivier@redhat.com>
 <3mcx7u456pawkgz4dgf6tvk7izczuy55guipqacqkl66jhtltq@fofd5u3el4nj>
 <20250122085828-mutt-send-email-mst@kernel.org>
 <bfc3rstsxuapkjlea4lia3bn44rt7hhsf6kagtkltfssqynx6z@4dodvso73pel>
 <044af96f-791b-471f-ae90-c17597445fd3@redhat.com>
 <kt2sdfv3wg3raylqfmphrdbc2isex2q3jtmgw7oems5xysex4f@lnp3ulutpt6f>
 <20250124170327.448805ad@elisabeth>
 <20250220102724-mutt-send-email-mst@kernel.org>
 <20250220175910.25688823@elisabeth>
 <20250220131932-mutt-send-email-mst@kernel.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sbrivio@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 20 Feb 2025 13:21:33 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Feb 20, 2025 at 05:59:10PM +0100, Stefano Brivio wrote:
> > On Thu, 20 Feb 2025 10:28:20 -0500
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Fri, Jan 24, 2025 at 05:03:27PM +0100, Stefano Brivio wrote:  
> > > > But I don't understand why we're leaving this as it is.    
> > > 
> > > So that people notice if there's some backend problem and
> > > announcements are not going out. should help debug migration
> > > issues. which we had, so we added this :)  
> > 
> > The message mentions that the back-end fails to do something it didn't
> > and can't even do, that's (one reason) why it's wrong (and confusing)
> > and this patch is obviously correct.
> > 
> > Perhaps the commit title isn't entirely accurate (it should say "when
> > unsupported", I guess) but it's somewhat expected to sacrifice detail
> > in the name of brevity, there. A glimpse at the message is enough.
> > 
> > Laurent now added a workaround in passt to pretend that we support
> > VHOST_USER_PROTOCOL_F_RARP by doing nothing in the callback, report
> > success, and silence the warning:
> > 
> >   https://passt.top/passt/commit/?id=dd6a6854c73a09c4091c1776ee7f349d1e1f966c
> > 
> > but having to do this kind of stuff is a bit unexpected while
> > interacting with another opensource project.
> > 
> > -- 
> > Stefano  
> 
> 
> let me explain. historically backends did not support migration.
> then migration was added. as it was assumed RARP is required,
> we did not add a feature flag for "supports migration" and
> instead just assumed that VHOST_USER_PROTOCOL_F_RARP is that.
> 
> If you silence the warning you silence it for old backends
> with no migration support.

Thanks for the explanation. I'm struggling to grasp this. So if a
back-end doesn't support migration, because VHOST_USER_PROTOCOL_F_RARP
is not present in the features flag, migration is done anyway, but then
this is printed:

  Vhost user backend fails to broadcast fake RARP

with the meaning of:

  We did migration even if the back-end doesn't support it, whoops

?

Note that the message is printed *after* the migration and the flag is
*not* checked before.

> If you want a new flag "migration with no RARP", be my
> guest and add it.

That would actually make more sense than the existing situation I
think. VHOST_USER_PROTOCOL_F_NO_RARP?

I didn't understand, yet, what the exact meaning would be, though.

> Or if you want to add documentation explaining the meaning
> better and clarifying the message.

I'm still in the phase where I'm trying to understand the role of the
message :) ...I have to say this is fairly different now from what was
mentioned on the thread so far.

-- 
Stefano


