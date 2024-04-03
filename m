Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B006CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 16:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs3Yn-0005Ox-L4; Wed, 03 Apr 2024 12:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rs3Yj-0005Of-8j
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 12:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rs3Yd-0008DI-Gt
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 12:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712162029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hhxyxsE5RoO4bNflS5HaasvIZOLW1z4CSIEBcKBiegk=;
 b=fIzHR8EStDauWvFYW9y1m7WxbSx3+VOdqmkE02SDu299TCsfFSpvDCvSM1SwxbPEzwjWny
 LoKB/R/9proR4yb2wteYar/OsgIoF4FIFPDb7mjdiEEZabr/FL70D6EMmxmzn3BvWCv4Ql
 vJKCz8jffFah9R6JTc+k42Og41FqHwY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-PRWl29UqOq2SajSQ4T0PlQ-1; Wed, 03 Apr 2024 12:33:48 -0400
X-MC-Unique: PRWl29UqOq2SajSQ4T0PlQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-78d346eeb02so47266885a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 09:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712162027; x=1712766827;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hhxyxsE5RoO4bNflS5HaasvIZOLW1z4CSIEBcKBiegk=;
 b=ptoRjhldA9hp5TrAfgJ89eVOwn2cFwIViHaYaC0bA9+3jw5A364FWUbEU4EAAl25Dg
 +wUqgRF102NuwElCQkcreu7YnPk6h7YcfkoLEn+KzX9Zp7+NDwKN2e5IAXnGy2Ejb8t6
 sUGK8zUB9SVo4+xGMqHvvQSK5ZiUICgxgPK5tNTOQQtf8E3/8svOKEpcN7yARdoGVPgy
 KHGeB73XAOCSyFV7+9EsSSQashRkwidSISRGYxU/bpA7z5WP/A76/FjAtcHRvogaDM8v
 0z3JDwyeLs3jBucPXZKEfRIGnAueAYyb4/XID+sY9QiSHmkQzKx7NW2FkOvR9Z6hsbIY
 fsJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPbgmbY5W/iDcVQ1aNCPSIYIuSIzWp50yv4AkVLdfXCLJ+4DWfIuJ0x02LgJFrf4XA6CMfa1TK/RTF7WS2tKTJma6Nudc=
X-Gm-Message-State: AOJu0YwRUApNgy5lec1MgiWxpPfEivy7x9qTBKPkOApzA0G24wJJwyFu
 jMqZCyxIOvAflvsa2J8Gjkv7aRbO32DASPtTkrZklmUBakq7yFm3lFKGYcIa1O7UXKcjKLIxK2h
 QnY7tO0gLPmGJLIlGa3Ai/RQh1Ecd/NfQaWO8thrI1pYXPWacD5WM
X-Received: by 2002:a05:620a:5651:b0:78b:c3a2:26ce with SMTP id
 vw17-20020a05620a565100b0078bc3a226cemr16086056qkn.7.1712162027185; 
 Wed, 03 Apr 2024 09:33:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH//LpO1mJXqW4f7YvJEjhpX5yksfP2JGFVFCIVsGY16wiOuQTPKfL3szkC+dtaQQMiycTdEw==
X-Received: by 2002:a05:620a:5651:b0:78b:c3a2:26ce with SMTP id
 vw17-20020a05620a565100b0078bc3a226cemr16086022qkn.7.1712162026451; 
 Wed, 03 Apr 2024 09:33:46 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 k10-20020a05620a07ea00b0078a517d9fd2sm5223497qkk.29.2024.04.03.09.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 09:33:46 -0700 (PDT)
Date: Wed, 3 Apr 2024 12:33:44 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "Wang, Lei4" <lei4.wang@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "farosas@suse.de" <farosas@suse.de>
Subject: Re: [PATCH] migration: Yield coroutine when receiving
 MIG_CMD_POSTCOPY_LISTEN
Message-ID: <Zg2E6MKQPaG3gA1k@x1n>
References: <20240329033205.26087-1-lei4.wang@intel.com>
 <DS0PR11MB6373254218DDBF279B13FD79DC3A2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZgrdIDGe3aNcRu7o@x1n>
 <ce89cb04-65d0-4f43-ad87-ead6e69c1e09@intel.com>
 <DS0PR11MB6373AE29375A2910057CC313DC3E2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <9aa5d1be-7801-40dd-83fd-f7e041ced249@intel.com>
 <Zgx7DI4LXYrR_dk-@x1n>
 <c0607330-60af-4e0f-819e-4a22a38edd6d@intel.com>
 <Zg1qyEJZH8kScSng@x1n>
 <DS0PR11MB637346AE0C9777A6C25746CFDC3D2@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DS0PR11MB637346AE0C9777A6C25746CFDC3D2@DS0PR11MB6373.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Apr 03, 2024 at 04:04:21PM +0000, Wang, Wei W wrote:
> On Wednesday, April 3, 2024 10:42 PM, Peter Xu wrote:
> > On Wed, Apr 03, 2024 at 04:35:35PM +0800, Wang, Lei wrote:
> > > We should change the following line from
> > >
> > > 	while (!qemu_sem_timedwait(&mis->postcopy_qemufile_dst_done,
> > 100)) {
> > >
> > > to
> > >
> > > 	while (qemu_sem_timedwait(&mis->postcopy_qemufile_dst_done,
> > 100)) {
> > 
> > Stupid me.. :(  Thanks for figuring this out.
> > 
> > >
> > > After that fix, test passed and no segfault.
> > >
> > > Given that the test shows a yield to the main loop won't introduce
> > > much overhead (<1ms), how about first yield unconditionally, then we
> > > enter the while loop to wait for several ms and yield periodically?
> > 
> > Shouldn't the expectation be that this should return immediately without a
> > wait?  We're already processing LISTEN command, and on the source as you
> > said it was much after the connect().  It won't guarantee the ordering but IIUC
> > the majority should still have a direct hit?
> > 
> > What we can do though is reducing the 100ms timeout if you see that's
> > perhaps a risk of having too large a downtime when by accident.  We can even
> > do it in a tight loop here considering downtime is important, but to provide an
> > intermediate ground: how about 100ms -> 1ms poll?
> 
> Would it be better to use busy wait here, instead of blocking for even 1ms here?
> It's likely that the preempt channel is waiting for the main thread to dispatch for accept(),
> but we are calling qemu_sem_timedwait here to block the main thread for 1 more ms.

I think it's about the expectation of whether we should already received
that sem post.  My understanding is in most cases we should directly return
and avoid such wait.

Per my previous experience, 1ms is not a major issue to be added on top of
downtime in corner cases like this.

We do have a lot of othre potential optimizations to reduce downtime, or I
should say in the other way, that..  there can be a lot of cases where we
can hit much larger downtime than expected. Consider when we don't even
account downtime for device states for now, either load_state or
save_state, we only count RAM but that's far from accurate.. and we do have
more chances to optimize.  Some are listed here, but some may not:

https://wiki.qemu.org/ToDo/LiveMigration#Optimizations

If you agree with my above "expectation" statement, I'd say we should avoid
using a busy loop whenever possible in QEMU unless extremely necessary.

> 
> 
> > 
> > If you agree (and also to Wei; please review this and comment if there's any!),
> > would you write up the commit log, fully test it in whatever way you could,
> > and resend as a formal patch (please do this before Friday if possible)?  You
> > can keep a "Suggested-by:" for me.  I want to queue it for
> > rc3 if it can catch it. It seems important if Wei can always reproduce it.
> 
> Not sure if Lei would be able to online as the following two days are Chinese holiday.
> If not, I could help take over to send late tomorrow. Let's see.

Oops, I forgot that even if I was aware..

Please do so if you can do this.  Thank you, Wei!  (I hope you can switch
some working hours later on!)

Let me know if that doesn't work; it'll be all fine.

Thanks,

-- 
Peter Xu


