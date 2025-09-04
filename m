Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AD8CA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 16:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuCYf-0002b6-FB; Thu, 04 Sep 2025 12:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uuCYb-0002aN-BI
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 12:11:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uuCYR-0001SK-S9
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 12:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757002273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IXml/BHa8nzL9/Xc6RHrbKKaau1ijpMBY1LPUsLiCkg=;
 b=eOeMPGsSrCh3LdKPzkpzR65vbykOvyfCefu6w/Ck5ggLA7wJcu8rQWLpPAeVrunQWe7y3c
 hjxVOlI7uhACj9qcVjgM9GuEa5CJ7gBJ09UhU88pnHKP7bBE9cQSYLZhOyJEw/BxdOLL9j
 GRUtvYs9KnpFOIiFal0DvcGadzygRP8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-kVMQVIPyPPODS0GWlJ_UvA-1; Thu, 04 Sep 2025 12:11:11 -0400
X-MC-Unique: kVMQVIPyPPODS0GWlJ_UvA-1
X-Mimecast-MFC-AGG-ID: kVMQVIPyPPODS0GWlJ_UvA_1757002270
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b990eb77cso7801215e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 09:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757002270; x=1757607070;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXml/BHa8nzL9/Xc6RHrbKKaau1ijpMBY1LPUsLiCkg=;
 b=R682Q7o/901Q+hhMHYEERjvMLDSxZhzl/Jn0i6YxzoEgOFaE0gKgHKp5SyWmeuMv+M
 8pZqhLOk4ul0uMyqd7kqwCuHX7ztQXghM29JyXA/jhzFSZip8ZcIpkxPJ4D+9xhId/v6
 uxjzApxSPJt16hMVmkCvKaBTQHsQ2NQ35AR8qVZcbwVkWMZZAsWVzqKgvnn9w4KH1j4K
 gJlJNvK6D1hehHoqmtOyJHLsGXIYXKq5v9OPMXQx/37dTrcPKt3OKWsZdlnOEf6UkjfO
 wkBOLgb5CkN0z86iBO34L3KZUGrKxL62Z5wwUSqQTcrlqz3GkjXaWGxglqydSK63MbxG
 CuoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxpfeXZAV4zfTsiJnT1+Mwnxk90UJnluF1QqQ2HuM1mb5zhFXAExTJFsbZsl7M06uhyt8y4l4Q30Fw@nongnu.org
X-Gm-Message-State: AOJu0Yy99zTsN0yNIzsjYsEf4t0ikeXl3tGGPGfV7hvvsp2jvy53pSwH
 DnO8u7d2RIu8WsiRetXhYQ4AnUhpErP9ZWtFn7fiFD8OoUkDqkiAW7LzVZ2milw2NPt3l9jRkIw
 jkebch6Pf8orgNiaPCKrxGiaDM4BOpfqsS2JsvGnpJtYbfS/MBqvpJ245
X-Gm-Gg: ASbGncuXCMH3OSNV8DnHXpJpiZWkPkR8G8oPEOw6xw0QbCeJOd8lNG9aN0Ud4qTvA6C
 ZR2ECvFMWkoUcCW2y3J6CRQnRRxL/S8uAievcRij/YoJ8bwOmjObWhJ8ajTEYj55OqXfqPlE8XH
 awtylrs/9GYwdEuW0RRdMNoU4oOPMh9iG662C0oeZUju3B8TSKsw9cFYRUcm6OZdga5PqX2naZz
 b0vAs0ulhmVjn0oA7fG+FfFZkvw0ZiUmOxFZneViKGnLLNypg/kPvXABOlm4uIF8T72gw57oRVu
 jYRedIiKFPDAwGXaJiIgVm+/KGl/SUDCGN/orLEoYwH1hPYswgPrO4B51w==
X-Received: by 2002:a05:600c:35d4:b0:45d:d259:9a48 with SMTP id
 5b1f17b1804b1-45dd5b456c0mr2412305e9.9.1757002270193; 
 Thu, 04 Sep 2025 09:11:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZs+3ID5ufQFplleMPY7XnIiV0knFhSoS9oDbht8onOv7HZeZ69++0fT3PUcyzxeo5d5Mh6A==
X-Received: by 2002:a05:600c:35d4:b0:45d:d259:9a48 with SMTP id
 5b1f17b1804b1-45dd5b456c0mr2411535e9.9.1757002267600; 
 Thu, 04 Sep 2025 09:11:07 -0700 (PDT)
Received: from fedora (78-80-81-60.customers.tmcz.cz. [78.80.81.60])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306c93sm377086515e9.14.2025.09.04.09.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 09:11:07 -0700 (PDT)
Date: Thu, 4 Sep 2025 18:11:05 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Peter Xu <peterx@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, 
 qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH 0/4] migration: Introduce postcopy-setup capability
 and state
Message-ID: <iacvj4e7imqs7ra262gpmqbpxioadom26l34hhu5m5p22ykom4@mo4cljmx4ikk>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
 <aJoEJhJw-_rGVBbA@x1.local>
 <xfzgjwld4ba7mymu3xhkxdwpeie7bbjnbei2xchkqncamktk3g@rbafrorlpvcv>
 <aJzOo7P8aA64AfY_@x1.local>
 <xbqqss2yshtjkew5cirlp2bx3dkumxg3grwpduol5ucpx3leqq@irqeo2csi2vg>
 <aJ43_JQct45mnVgV@x1.local> <aLXehgy3S5G6A3ub@gallifrey>
 <w6qkokuof6ge2gwajhcwul5boaqf57w6m4yzsbyljpgpnigc64@pw2unqceumjn>
 <aLgtyy_UAfsmOLET@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLgtyy_UAfsmOLET@gallifrey>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Dave,

On 2025-09-03 12:00, Dr. David Alan Gilbert wrote:
> * Juraj Marcin (jmarcin@redhat.com) wrote:
> > Hi Dave,
> > 
> > On 2025-09-01 17:57, Dr. David Alan Gilbert wrote:
> > > * Peter Xu (peterx@redhat.com) wrote:
> > > > On Thu, Aug 14, 2025 at 05:42:23PM +0200, Juraj Marcin wrote:
> > > > > Fair point, I'll then continue with the PING/PONG solution, the first
> > > > > implementation I have seems to be working to resolve Issue 1.
> > > > > 
> > > > > For rarer split brain, we'll rely on block device locks/mgmt to resolve
> > > > > and change the failure handling, so it registers errors from disk
> > > > > activation.
> > > > > 
> > > > > As tested, there should be no problems with the destination
> > > > > transitioning to POSTCOPY_PAUSED, since the VM was not started yet.
> > > > > 
> > > > > However, to prevent the source side from transitioning to
> > > > > POSTCOPY_PAUSED, I think adding a new state is still the best option.
> > > > > 
> > > > > I tried keeping the migration states as they are now and just rely on an
> > > > > attribute of MigrationState if 3rd PONG was received, however, this
> > > > > collides with (at least) migrate_pause tests, that are waiting for
> > > > > POSTCOPY_ACTIVE, and then pause the migration triggering the source to
> > > > > resume. We could maybe work around it by waiting for the 3rd pong
> > > > > instead, but I am not sure if it is possible from tests, or by not
> > > > > resuming if migrate_pause command is executed?
> > > > > 
> > > > > I also tried extending the span of the DEVICE state, but some functions
> > > > > behave differently depending on if they are in postcopy or not, using
> > > > > the migration_in_postcopy() function, but adding the DEVICE there isn't
> > > > > working either. And treating the DEVICE state sometimes as postcopy and
> > > > > sometimes as not seems just too messy, if it would even be possible.
> > > > 
> > > > Yeah, it might indeed be a bit messy.
> > > > 
> > > > Is it possible to find a middle ground?  E.g. add postcopy-setup status,
> > > > but without any new knob to enable it?  Just to describe the period of time
> > > > where dest QEMU haven't started running but started loading device states.
> > > > 
> > > > The hope is libvirt (which, AFAIU, always enables the "events" capability)
> > > > can ignore the new postcopy-setup status transition, then maybe we can also
> > > > introduce the postcopy-setup and make it always appear.
> > > 
> > > When the destination is started with '-S' (autostart=false), which is what
> > > I think libvirt does, doesn't management only start the destination
> > > after a certain useful event?
> > > In other words, is there an event we already emit to say that the destination
> > > has finished loading the postcopy devices, or could we just add that
> > > event, so that management could just wait for that before issuing
> > > the continue?
> > 
> > I am not aware of any such event on the destination side. When postcopy
> > (and its switchower) starts, the destination transitions from ACTIVE
> > directly to POSTCOPY_ACTIVE in the listen thread while devices are
> > loaded concurrently by the main thread.
> > 
> > There is DEVICE state on the source side, but that is used only on the
> > source side when device state is being collected. When device state is
> > being loaded on the destination, the source side is also already in
> > POSTCOPY_ACTIVE state.
> 
> So I wonder what libvirt uses to trigger it starting the destination in
> the postcopy case?  It's got to be after the device state has loaded.

I checked the libvirt code and IIUC it waits for POSTCOPY_ACTIVE and
then it issues the 'cont' command, so it's concurrently with the device
state load. But as Peter mentioned, it doesn't actually start the VM if
the device load is not finished yet, it only sets the autostart variable
and the VM is started when the destination processes CMD_POSTCOPY_RUN
after the device state load.

Best regards,

Juraj Marcin

> 
> Dave
> 
> > Best regards,
> > 
> > Juraj Marcin
> > 
> > > 
> > > Dave
> > > 
> > > > Thanks,
> > > > 
> > > > -- 
> > > > Peter Xu
> > > > 
> > > > 
> > > -- 
> > >  -----Open up your eyes, open up your mind, open up your code -------   
> > > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> > > \        dave @ treblig.org |                               | In Hex /
> > >  \ _________________________|_____ http://www.treblig.org   |_______/
> > > 
> > 
> > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> 


