Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDB2CF34AD
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 21:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swTCL-0002fQ-8W; Thu, 03 Oct 2024 17:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1swTCI-0002ez-Uj
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1swTCH-0002sb-4Z
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727990235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FRY0HXW88OAPptnLwUXzDa+b3pggdISm9Y7+XatJStE=;
 b=E+VYNp78ItKY3XDiBTEfH3IEsQV43Kd4sHLLOt2gkZ/3WT2khcsy0CZfCoLZarUYYt7HCf
 wc5rcuDo6x2dSqG2U5Kb7wBZErTTzeFQV4/nB0HnNoqvHf5g77NSsHGbz9aLVi+keg9Njl
 4c9rjeKGBNkbZvZwUapWxysEguOgHis=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-zxvWaVuqM6y4pfUD7Rhp2g-1; Thu, 03 Oct 2024 17:17:13 -0400
X-MC-Unique: zxvWaVuqM6y4pfUD7Rhp2g-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cb2455ea43so19935386d6.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 14:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727990233; x=1728595033;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRY0HXW88OAPptnLwUXzDa+b3pggdISm9Y7+XatJStE=;
 b=D3oO28FrydCm7kBmCpTAhttHb8Scs4oopWbthYTG63jQ8AKJ4z+FNFB5FbEGncPoXd
 TRAkJU0hhWz8Tz6l/1Yq9gr2/ZXdGHxA6Da/dKdoxUi5FABXUG9qTjRxQwtB0xHMB+ov
 zbZvgJWxPGPf1VMwytTnwMZQ24DxzU25blwBdNfctFMIJghHSPMN4uRUPoqjXnJQ5iYE
 pQTztnjv9+PlmvxpikllXQ6fSJaNmXJXjZJB3tVexp2rIgYVGG5hty+S8jN1v6I7UoyL
 /N9xJP93rKOKwsubN4SZdDeReFOITTWpaihBHqL2+KFnxyTkdUVZlpF8RmcxfBL/noHP
 +3lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvNo6KaqqNNqPd+e5FqW4y4nTOaIWxHRqQkQPSbwYjEzgWhHEY4SoqDed6qJ0H5v+2d7vGlqQeDn00@nongnu.org
X-Gm-Message-State: AOJu0Yyg1mEKTjz7Ff6dwOeqBuzGR0UVyIUmy4JnfwVR3b2oIZXJAg5s
 CuoITNAAeai4ZcQHUg7Ovn06c9j/EB6r8dzmuyb0R4ZBhyH8iM3Y+aIiP8vLW2KgwFc/kotbBPA
 9vRERBVCizO0KZ6A5vS5TYhtz1zEEj71KduZ+Wznb99wnq3pSU8ja
X-Received: by 2002:a05:6214:5a01:b0:6cb:3644:6572 with SMTP id
 6a1803df08f44-6cb9a308c3fmr9320366d6.29.1727990233228; 
 Thu, 03 Oct 2024 14:17:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOi13yzVZK8l40J8EJJcWMeSWiAuc7XpcZvnQC/AdZ0BRGgMiE6CE2mfgPMAlMZ/OCGlc6Eg==
X-Received: by 2002:a05:6214:5a01:b0:6cb:3644:6572 with SMTP id
 6a1803df08f44-6cb9a308c3fmr9320136d6.29.1727990232871; 
 Thu, 03 Oct 2024 14:17:12 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb935cd68bsm9832606d6.44.2024.10.03.14.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 14:17:12 -0700 (PDT)
Date: Thu, 3 Oct 2024 17:17:10 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 08/17] migration: Add load_finish handler and
 associated functions
Message-ID: <Zv8J1uAWIxzCgErh@x1n>
References: <Zu2mvrKOvmD1WtvD@x1n>
 <848ba96d-c3ca-4fbb-9ec4-92023230c026@maciej.szmigiero.name>
 <ZvYCGFnI_68B_w3h@x1n>
 <c013f26f-6e55-4426-9ec9-e160e8179a7a@maciej.szmigiero.name>
 <ZvsesAPD6G4Ef9m0@x1n>
 <927023c9-c8ba-4cdf-9d42-bf1109a139af@maciej.szmigiero.name>
 <ZvxqE0i5qGGiSFk0@x1n>
 <cba181bd-0961-4ea8-962b-2f6bbf09d94a@maciej.szmigiero.name>
 <Zv26LE_2YIjKk4FL@x1n>
 <6240036b-f8b8-4592-8f80-21ee6d3eaa1e@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6240036b-f8b8-4592-8f80-21ee6d3eaa1e@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Thu, Oct 03, 2024 at 10:34:28PM +0200, Maciej S. Szmigiero wrote:
> To be clear, these loading threads are mostly blocking I/O threads, NOT
> compute threads.
> This means that the usual "rule of thumb" that the count of threads should
> not exceed the total number of logical CPUs does NOT apply to them.
> 
> They are similar to what glibc uses under the hood to simulate POSIX AIO
> (aio_read(), aio_write()), to implement an async DNS resolver (getaddrinfo_a())
> and what Glib's GIO uses to simulate its own async file operations.
> Using helper threads for turning blocking I/O into "AIO" is a pretty common
> thing.

Fair enough.  Yes I could be over-cautious due to the previous experience
on managing all kinds of migration threads.

> 
> To show that these loading threads mostly spend their time sleeping (waiting
> for I/O) I made a quick patch at [1] tracing how much time they spend waiting
> for incoming buffers and how much time they spend waiting for these buffers
> to be loaded into the device.
> 
> The results (without patch [2] described later) are like this:
> > 5919@1727974993.403280:vfio_load_state_device_buffer_start  (0000:af:00.2)
> > 5921@1727974993.407932:vfio_load_state_device_buffer_start  (0000:af:00.4)
> > 5922@1727974993.407964:vfio_load_state_device_buffer_start  (0000:af:00.5)
> > 5920@1727974993.408480:vfio_load_state_device_buffer_start  (0000:af:00.3)
> > 5920@1727974993.666843:vfio_load_state_device_buffer_end  (0000:af:00.3) wait 43 ms load 217 ms
> > 5921@1727974993.686005:vfio_load_state_device_buffer_end  (0000:af:00.4) wait 75 ms load 206 ms
> > 5919@1727974993.686054:vfio_load_state_device_buffer_end  (0000:af:00.2) wait 69 ms load 210 ms
> > 5922@1727974993.689919:vfio_load_state_device_buffer_end  (0000:af:00.5) wait 79 ms load 204 ms
> 
> Summing up:
> 0000:af:00.2 total loading time 283 ms, wait 69 ms load 210 ms
> 0000:af:00.3 total loading time 258 ms, wait 43 ms load 217 ms
> 0000:af:00.4 total loading time 278 ms, wait 75 ms load 206 ms
> 0000:af:00.5 total loading time 282 ms, wait 79 ms load 204 ms
> 
> In other words, these threads spend ~100% of their total runtime waiting
> for I/O, 70%-75% of that time waiting for buffers to get loaded into their
> target device.
> 
> So having more threads here won't negatively affect the host CPU
> consumption since these threads barely use the host CPU at all.
> Also, their count is capped at the number of VFIO devices in the VM.
> 
> I also did a quick test with the same config as usual: 4 VFs, 6 multifd
> channels, but with patch at [2] simulating forced coupling of loading
> threads to multifd receive channel threads.
> 
> With this patch load_state_buffer() handler will return to the multifd
> channel thread only when the loading thread finishes loading available
> buffers and is about to wait for the next buffers to arrive - just as
> loading buffers directly from these channel threads would do.
> 
> The resulting lowest downtime from 115 live migration runs was 1295ms -
> that's 21% worse than 1068ms of downtime with these loading threads running
> on their own.
> 
> I expect that this performance penalty to get even worse with more VFs
> than 4.
> 
> So no, we can't load buffers directly from multifd channel receive threads.

6 channels can be a bit less in this test case with 4 VFs, but indeed
adding such dependency on number of multifd threads isn't as good either, I
agree.  I'm ok as long as VFIO reviewers are fine.

> 
> > PS: I'd suggest if you really need those threads it should still be managed
> > by migration framework like the src thread pool.  Sorry I'm pretty stubborn
> > on this, especially after I notice we have query-migrationthreads API just
> > recently.. even if now I'm not sure whether we should remove that API.  I
> > assume that shouldn't need much change, even if necessary.
> 
> I can certainly make these loading threads managed in a thread pool if that's
> easier for you.

Yes, if you want to use separate thread it'll be great to match on the src
thread model with similar pool.  I hope the pool interface you have is
easily applicable on both sides.

Thanks,

-- 
Peter Xu


