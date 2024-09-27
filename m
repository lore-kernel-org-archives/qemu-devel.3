Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61752CDD1BC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 15:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suD0p-0002x0-8Y; Fri, 27 Sep 2024 11:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1suD0k-0002rr-8e
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 11:36:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1suD0h-0006HU-NW
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 11:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727451355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JAC/ZOvZ9mXODADeZbct/nTe1AvgA+7yqoUqDwSaOlI=;
 b=YXD1CtbD5u959N7rwAk5hvcfy/OXUt5ZYufCMrhwsIDsCsLUNPaAPov36ZoqxPM2DfKnqO
 SFUYdh8jQjmUoEu2hr+aywOJBtUTl7xT9Swlt/LBG2Z6vMxd+QOjNAWV2nRpQwJfZW3nOf
 ayxUPHMpAkoxAX2cM3rh79SbyjZReCU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-MELuoqDdMYmDvfDZeZ2LhA-1; Fri, 27 Sep 2024 11:35:53 -0400
X-MC-Unique: MELuoqDdMYmDvfDZeZ2LhA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2e0c5819c57so960900a91.2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 08:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727451352; x=1728056152;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JAC/ZOvZ9mXODADeZbct/nTe1AvgA+7yqoUqDwSaOlI=;
 b=wJinidsZW4fRRZbWIW0eBWW96NeH9O47eygnw3Eo2bPC+P1bVCCQfq55cEtuNZEPTZ
 eaWze9EUAZoFm7zTA69MN4Dy2GFsA0S/ZB6KF7pi6NSlewBgOl3hgkEQ5pQ4x4CEYP0G
 4H24Z1zaAX+UdWb41T7Jbz3Jg2F0/jxHb5ANkKfYoxJSm3tW3x0JrIZe4w+s719Di5b2
 uPXqRefqJEL74EFF4eJ8+/rTiz8LZZJR9uBmsjuG/115TV1oYCpXBuJI9O+SKkpHFq85
 Z0pwePxE/G3n3tl2xGZ+Mtj94esxDAqokU9oJYfGM/4B9WYc5zuW4v2VZDvsVzn9zcge
 8ltw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5erKdZwH9jkKjdnEQaZFT8q6Jplb9RVzjXj5wgjSetFqcvyrIouwmelsJxM0S7ZAVUrHinMw/cKpw@nongnu.org
X-Gm-Message-State: AOJu0YxC7HaYLYfL18Fjg9p/uMpsI+wpladc4TJ7PV63DX7B58L1mXOc
 n8aE5IUfpHDwyAtJGumZnXxZklZK01DPojOBVgPgVzJelvbfJ9AtPitbhJP+ZV4VbjXIwnog1vq
 tqgLPTZGJHvlbbe15F2yF7u823wVIMmlUyc1Yn1g7KeUsjM4jZezn5+/fJwpP
X-Received: by 2002:a17:90a:68ca:b0:2c9:7616:dec7 with SMTP id
 98e67ed59e1d1-2e0b876f103mr3997599a91.6.1727451352064; 
 Fri, 27 Sep 2024 08:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4vbqDNmzylnZqyvSZBYffXwGV4w9C9H2mtl9kxAQRyG1Nyyi+eOqXMdDU2VHA5tkDGHj5zw==
X-Received: by 2002:a17:90a:68ca:b0:2c9:7616:dec7 with SMTP id
 98e67ed59e1d1-2e0b876f103mr3997577a91.6.1727451351642; 
 Fri, 27 Sep 2024 08:35:51 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e0777a696bsm2643547a91.0.2024.09.27.08.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2024 08:35:50 -0700 (PDT)
Date: Fri, 27 Sep 2024 11:35:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 1/7] migration: Introduce structs for background sync
Message-ID: <ZvbQ0RQx-zxOeo4Y@x1n>
References: <cover.1726390098.git.yong.huang@smartx.com>
 <531750c8d7b6c09f877b5f335a60fab402c168be.1726390098.git.yong.huang@smartx.com>
 <87msk7z4l3.fsf@suse.de>
 <CAK9dgmb_rK5HJOGTG=KXKgH=e2e8JV8aqoOWUHBEyjnc-+kiqg@mail.gmail.com>
 <ZuxxOObKqS_G0Ela@x1n>
 <CAK9dgmYaE=poiwLQqD6qbjJQdgPLMn8cW8VO47xYFTBkNiUVLA@mail.gmail.com>
 <ZvRh0RhkUC-eLbjo@x1n>
 <CAK9dgmbi1VSXvxFjziH5PjaoiaQwBJ3z4ff1BAojtm26VTThUQ@mail.gmail.com>
 <ZvW8LxJsv3pRWom_@x1n>
 <CAK9dgma-RFQ3akWDFHW5VhMPOdbT4nizSrixQK9x4W7W249raQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9dgma-RFQ3akWDFHW5VhMPOdbT4nizSrixQK9x4W7W249raQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 27, 2024 at 10:50:01AM +0800, Yong Huang wrote:
> On Fri, Sep 27, 2024 at 3:55 AM Peter Xu <peterx@redhat.com> wrote:
> 
> > On Fri, Sep 27, 2024 at 02:13:47AM +0800, Yong Huang wrote:
> > > On Thu, Sep 26, 2024 at 3:17 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > > On Fri, Sep 20, 2024 at 10:43:31AM +0800, Yong Huang wrote:
> > > > > Yes, invoke migration_bitmap_sync_precopy more frequently is also my
> > > > > first idea but it involves bitmap updating and interfere with the
> > > > behavior
> > > > > of page sending, it also affects the migration information stats and
> > > > > interfere other migration logic such as migration_update_rates().
> > > >
> > > > Could you elaborate?
> > > >
> > > > For example, what happens if we start to sync in ram_save_iterate() for
> > > > some time intervals (e.g. 5 seconds)?
> > > >
> > >
> > > I didn't try to sync in ram_save_iterate but in the
> > > migration_bitmap_sync_precopy.
> > >
> > > If we use the migration_bitmap_sync_precopy in the ram_save_iterate
> > > function,
> > > This approach seems to be correct. However, the bitmap will be updated as
> > > the
> > > migration thread iterates through each dirty page in the RAMBlock list.
> > > Compared
> > > to the existing implementation, this is different but still
> > straightforward;
> > > I'll give it a shot soon to see if it works.
> >
> > It's still serialized in the migration thread, so I'd expect it is similar
> >
> 
> What does "serialized" mean?

I meant sync() never happens before concurrently with RAM pages being
iterated, simply because sync() previously only happens in the migration
thread, which is still the same thread that initiate the movement of pages.

> 
> How about we:
> 1. invoke the migration_bitmap_sync_precopy in a timer(bg_sync_timer) hook,
>    every 5 seconds.
> 2. register the bg_sync_timer in the main loop when the machine starts like
>     throttle_timer
> 3. activate the timer when ram_save_iterate gets called and deactivate it in
>     the ram_save_cleanup gracefully during migration.
> 
> I think it is simple enough and also isn't "serialized"?

If you want to do that with timer that's ok, but then IIUC it doesn't need
to involve ram.c code at all.

You can rely on cpu_throttle_get_percentage() too just like the throttle
timer, and it'll work naturally with migration because outside migration
the throttle will be cleared (cpu_throttle_stop() at finish/fail/cancel..).

Then it also gracefully align the async thread sync() that it only happens
with auto-converge is enabled.  Yeh that may look better.. and stick the
code together with cpu-throttle.c seems nice.

Side note: one thing regarind to sync() is ram_init_bitmaps() sync once,
while I don't see why it's necessary.  I remember I tried to remove it but
maybe I hit some issues and I didn't dig further.  If you're working on
sync() anyway not sure whether you'd like to have a look.

-- 
Peter Xu


