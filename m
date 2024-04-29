Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED24C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 20:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1XhU-0004yt-4Q; Mon, 29 Apr 2024 16:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1XhS-0004yj-TC
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 16:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1XhQ-000277-Ra
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 16:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714422847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WC1xv2tIauHYwraZuqDKbfVb9r74zBOQVkX93kxGMC8=;
 b=ETZXO410Re+1hdxxVHrX/a6riRFN1dCXiBrc6CFsF8sSSoTCxKFGpd+ca9LI2xzCUjwA5x
 UQPplUVFIdQ4NkmajT93WfJBi/Z8yWY2rcv9vieFYY+1dW1ewf4f/FnlzB8gs0tXhI5mG4
 5Fuyj8o54UePwPWHclHVsgs2hfCa5Ho=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-FWYQfTziMPyx7YqW0wuFAA-1; Mon, 29 Apr 2024 16:34:06 -0400
X-MC-Unique: FWYQfTziMPyx7YqW0wuFAA-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1e4ce18cf97so2724475ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 13:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714422845; x=1715027645;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WC1xv2tIauHYwraZuqDKbfVb9r74zBOQVkX93kxGMC8=;
 b=w3WhUuYLuncCQQwwQv8J4okkTbfG31tfvuv4f5A8ooZ56XLirbioWDyiTvHUp3wIPv
 0m/DrydIl6IjcfQYS0i5F4j/hRplcHX7n9UfGsnnLKxES1TEMjgeIU7QYlPdIOoc9PfH
 +Z5VENZaRHbOGotenCZGbyICLBcoPWo4K4S2qWEQnoMswFEqoQ7DXJJdON6WlDhrhf+F
 G0lHibd/FkRAcLgCHc3koHrZdU04/LaRhrTba4O9t+AzX9zGe9b9KYbvHOK4AY5VBu/E
 KLQbknXgoBCXNul607y4SX3Jd+b2HKqCXLPNIYvm0JRNWCjUrdsDuvOF2xr9++JC9e3Y
 fjEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+6xYzuGyWlkTVs6RrK3Lr5WNTAo7EoOn11fgc/Ay5acoT4Io2YiaY9cTDhkTysJ7n/AUhtmXV2dqkrbo43N3Y/X1AGjs=
X-Gm-Message-State: AOJu0YzDcC8fs4YN9y0VGKYzS8p3sGT/AnBSXjDxPxl1dMX6VXQhNsWk
 PsAkc/QwX+pdnEFs7YzFtRviQdiq7KsxbOk8D9YB7zGvI4+F6IG4jCwEOSlgm5CiuFxFSZWjjui
 lrLg6hC/sejAuNvH20eBubJYNtoAUklyI0nus6IYRDWhbB//oa3q1
X-Received: by 2002:a17:902:eccd:b0:1e9:a06a:c3c3 with SMTP id
 a13-20020a170902eccd00b001e9a06ac3c3mr14269409plh.5.1714422844679; 
 Mon, 29 Apr 2024 13:34:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvGuTex0Xksv1Ebz6A7yUfKvsBtcbSbVyDQB0imZksv5fqc0mTDKaKJm188RbqgrxxAtj2Uw==
X-Received: by 2002:a17:902:eccd:b0:1e9:a06a:c3c3 with SMTP id
 a13-20020a170902eccd00b001e9a06ac3c3mr14269385plh.5.1714422844101; 
 Mon, 29 Apr 2024 13:34:04 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 im15-20020a170902bb0f00b001e3e081d07esm21235218plb.179.2024.04.29.13.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 13:34:03 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:34:00 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 00/26] =?utf-8?Q?Multifd_?= =?utf-8?B?8J+UgA==?=
 device state transfer support with VFIO consumer
Message-ID: <ZjAEOB9TbeK_7F9z@x1n>
References: <Zh-KF72Fe9oV6tfT@redhat.com>
 <c0b1dbb1-d353-4832-af90-96895b2129fc@maciej.szmigiero.name>
 <Zh_6W8u3H4FmGS49@redhat.com>
 <71ede5c8-857c-418b-9e37-b8d343ddfa06@maciej.szmigiero.name>
 <ZiD4aLSre6qubuHr@redhat.com>
 <aebcd78e-b8b6-44db-b2be-0bbd5acccf3f@maciej.szmigiero.name>
 <ZiF8aWVfW7kPuOtn@x1n>
 <9fa34f3e-2f65-442b-8872-513565bb335c@maciej.szmigiero.name>
 <Zig1vyC-D7j33yIn@x1n>
 <ad4c7663-6a12-48e5-b082-d919a535fcc2@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad4c7663-6a12-48e5-b082-d919a535fcc2@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Apr 26, 2024 at 07:35:36PM +0200, Maciej S. Szmigiero wrote:
> On 24.04.2024 00:27, Peter Xu wrote:
> > On Tue, Apr 23, 2024 at 06:14:18PM +0200, Maciej S. Szmigiero wrote:
> > > We don't lose any genericity since by default the transfer is done via
> > > mixed RAM / device state multifd channels from a shared pool.
> > > 
> > > It's only when x-multifd-channels-device-state is set to value > 0 then
> > > the requested multifd channel counts gets dedicated to device state.
> > > 
> > > It could be seen as a fine-tuning option for cases where tests show that
> > > it provides some benefits to the particular workload - just like many
> > > other existing migration options are.
> > > 
> > > 14% downtime improvement is too much to waste - I'm not sure that's only
> > > due to avoiding RAM syncs, it's possible that there are other subtle
> > > performance interactions too.
> > > 
> > > For even more genericity this option could be named like
> > > x-multifd-channels-map and contain an array of channel settings like
> > > "ram,ram,ram,device-state,device-state".
> > > Then a possible future other uses of multifd channels wouldn't even need
> > > a new dedicated option.
> > 
> > Yeah I understand such option would only provide more options.
> > 
> > However as long as such option got introduced, user will start to do their
> > own "optimizations" on how to provision the multifd channels, and IMHO
> > it'll be great if we as developer can be crystal clear on why it needs to
> > be introduced in the first place, rather than making all channels open to
> > all purposes.
> > 
> > So I don't think I'm strongly against such parameter, but I want to double
> > check we really understand what's behind this to justify such parameter.
> > Meanwhile I'd be always be pretty caucious on introducing any migration
> > parameters, due to the compatibility nightmares.  The less parameter the
> > better..
> 
> Ack, I am also curious why dedicated device state multifd channels bring
> such downtime improvement.
> 
> > > 
> > > > > 
> > > > > I think one of the reasons for these results is that mixed (RAM + device
> > > > > state) multifd channels participate in the RAM sync process
> > > > > (MULTIFD_FLAG_SYNC) whereas device state dedicated channels don't.
> > > > 
> > > > Firstly, I'm wondering whether we can have better names for these new
> > > > hooks.  Currently (only comment on the async* stuff):
> > > > 
> > > >     - complete_precopy_async
> > > >     - complete_precopy
> > > >     - complete_precopy_async_wait
> > > > 
> > > > But perhaps better:
> > > > 
> > > >     - complete_precopy_begin
> > > >     - complete_precopy
> > > >     - complete_precopy_end
> > > > 
> > > > ?
> > > > 
> > > > As I don't see why the device must do something with async in such hook.
> > > > To me it's more like you're splitting one process into multiple, then
> > > > begin/end sounds more generic.
> > > 
> > > Ack, I will rename these hooks to begin/end.
> > > 
> > > > Then, if with that in mind, IIUC we can already split ram_save_complete()
> > > > into >1 phases too. For example, I would be curious whether the performance
> > > > will go back to normal if we offloading multifd_send_sync_main() into the
> > > > complete_precopy_end(), because we really only need one shot of that, and I
> > > > am quite surprised it already greatly affects VFIO dumping its own things.
> > > 
> > > AFAIK there's already just one multifd_send_sync_main() during downtime -
> > > the one called from save_live_complete_precopy SaveVMHandler.
> > > 
> > > In order to truly never interfere with device state transfer the sync would
> > > need to be ordered after the device state transfer is complete - that is,
> > > after VFIO complete_precopy_end (complete_precopy_async_wait) handler
> > > returns.
> > 
> > Do you think it'll be worthwhile give it a shot, even if we can't decide
> > yet on the order of end()s to be called?
> 
> Upon a closer inspection it looks like that there are, in fact, *two*
> RAM syncs done during the downtime - besides the one at the end of
> ram_save_complete() there's another on in find_dirty_block(). This function
> is called earlier from ram_save_complete() -> ram_find_and_save_block().

Fabiano and I used to discuss this when he's working on the mapped-ram
feature, and afaiu the flush in complete() is not needed when the other one
existed.

I tried to remove it and at least the qtests run all well:

@@ -3415,10 +3415,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    if (migrate_multifd() && !migrate_multifd_flush_after_each_section() &&
-        !migrate_mapped_ram()) {
-        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
-    }
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     return qemu_fflush(f);
 }

> 
> Unfortunately, skipping that intermediate sync in find_dirty_block() and
> moving the one from the end of ram_save_complete() to another SaveVMHandler
> that's called only after VFIO device state transfer doesn't actually
> improve downtime (at least not on its own).
> 
> > It'll be great if we could look into these issues instead of workarounds,
> > and figure out what affected the performance behind, and also whether that
> > can be fixed without such parameter.
> 
> I've been looking at this and added some measurements around device state
> queuing for submission in multifd_queue_device_state().
> 
> To my surprise, the mixed RAM / device state config of 15/0 has *much*
> lower total queuing time of around 100 msec compared to the dedicated
> device state channels 15/4 config with total queuing time of around
> 300 msec.

Did it account device only, or device+RAM?

I'd expect RAM enqueue time grows in 15/0 due to the sharing with device
threads.

However even if so it may not be that fair a comparison, as the cpu
resources aren't equal.  It's fairer if we compare 15/0 (mixed) v.s. 10/5
(dedicated), for example.

> 
> Despite that, the 15/4 config still has significantly lower overall
> downtime.
> 
> This means that any reason for the downtime difference is probably on
> the receive / load side of the migration rather than on the save /
> send side.
> 
> I guess the reason for the lower device state queuing time in the 15/0
> case is that this data could be sent via any of the 15 multifd channels
> rather than just the 4 dedicated ones in the 15/4 case.

Agree.

> 
> Nevertheless, I will continue to look at this problem to at least find
> some explanation for the difference in downtime that dedicated device
> state multifd channels bring.

Thanks for looking at this.

-- 
Peter Xu


