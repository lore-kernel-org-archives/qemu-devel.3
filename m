Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7656ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 19:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snjkr-0004b6-39; Mon, 09 Sep 2024 15:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snjkp-0004a1-34
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 15:08:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snjkn-0007e5-74
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 15:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725908928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uwFsKpWAXF9SQyV5m1QNA6mBeRMY3EYkreU6orWih2A=;
 b=GzoSnN+jJoM9pv0dPs34B5phTAdSTZO1bkXdmOTmeC+3LlOZi1zAkJ6njCh/cujRd9Bv4G
 16sR2H4Ng17XemjvKqKAtbTCct3USKohrQuLkh2+oL64sqLsZnqT45IsubWETwOABxPvDH
 yApMdeXSJQTyl1grw4F8+4+U0psLWTg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-hrBuAH5yOsqQL5hlmcgXDQ-1; Mon, 09 Sep 2024 15:08:44 -0400
X-MC-Unique: hrBuAH5yOsqQL5hlmcgXDQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7a9bffc241eso42608985a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 12:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725908924; x=1726513724;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwFsKpWAXF9SQyV5m1QNA6mBeRMY3EYkreU6orWih2A=;
 b=C5H0TInWHBXakIWRhtv2Y9I0cLA7P49gBfrEx7efwPaRP0lp3Zojkwch3qxZd775nE
 p4Yywxm/ecKFy7dtFFEJArg+xIjqZv+rRPvya3OAL1DbtUk0NtOp+RkoLdxaK3qXF+Js
 usWEJplLINhEODEGZ9AuUudlVOQn5QfMh+L46E8W/N1onrud2agnL0QslEYG8H6i/vRw
 Qcwx6y7pybYkHcL3RZWzzW4UhCq+ztsF8z9aNG4nHEuZg+emDv8ouOSnDqlrCq4qxl2M
 6ov3U+lWc0OkRlVY0Ug2BLUntpgkFo1HxkKDsnUj1LxBx9639emGS+qxuyJxUBDnctho
 gOJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOWXKqz75waVXKyzfBV9wutrQCtf4TxTjGMW4ABLkUwTX04KDlretcHKdF42Zbfc1dWdDfVlIelv0m@nongnu.org
X-Gm-Message-State: AOJu0Yxegl4I4ob06Qs4+iat0FvJi2KV1tRB7vdRk9DJK0N/z8xlcaPx
 QMJiu/o7MS1MIFcdjaV05Xg7eQbVF0YWQ1xTsyabvljpipdNwLz8GvEycjyFVXrItUx/L8qTA0W
 VrfCYMH6ow10HCmACC7vhRknMulb3WGnvm9iKYFmxb75gHwMUTBQF
X-Received: by 2002:a05:620a:1917:b0:7a9:be63:7b40 with SMTP id
 af79cd13be357-7a9be637d63mr244413985a.3.1725908924398; 
 Mon, 09 Sep 2024 12:08:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECgAS75KK8AB0ThrbcTh/nivqLT43kzNF3eyFoCAjLpooVwVlNYWqAw+VSeru+QCZPtjqB0w==
X-Received: by 2002:a05:620a:1917:b0:7a9:be63:7b40 with SMTP id
 af79cd13be357-7a9be637d63mr244409185a.3.1725908923965; 
 Mon, 09 Sep 2024 12:08:43 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c53433b426sm23362326d6.57.2024.09.09.12.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 12:08:43 -0700 (PDT)
Date: Mon, 9 Sep 2024 15:08:40 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 06/17] migration: Add
 save_live_complete_precopy_{begin,end} handlers
Message-ID: <Zt9HuA3QtP0E93X1@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <afe0bc649007593edaa77f5f3923acb733a24c6a.1724701542.git.maciej.szmigiero@oracle.com>
 <9f9f0408-866d-4dc8-8c8e-80c3cfdd190a@nvidia.com>
 <Zt83mWWlMomX4mRD@x1n>
 <fa64bf51-7fec-454b-b204-f92f5d06f731@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa64bf51-7fec-454b-b204-f92f5d06f731@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On Mon, Sep 09, 2024 at 08:32:45PM +0200, Maciej S. Szmigiero wrote:
> On 9.09.2024 19:59, Peter Xu wrote:
> > On Thu, Sep 05, 2024 at 04:45:48PM +0300, Avihai Horon wrote:
> > > 
> > > On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > 
> > > > These SaveVMHandlers help device provide its own asynchronous
> > > > transmission of the remaining data at the end of a precopy phase.
> > > > 
> > > > In this use case the save_live_complete_precopy_begin handler might
> > > > be used to mark the stream boundary before proceeding with asynchronous
> > > > transmission of the remaining data while the
> > > > save_live_complete_precopy_end handler might be used to mark the
> > > > stream boundary after performing the asynchronous transmission.
> > > > 
> > > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > > ---
> > > >    include/migration/register.h | 36 ++++++++++++++++++++++++++++++++++++
> > > >    migration/savevm.c           | 35 +++++++++++++++++++++++++++++++++++
> > > >    2 files changed, 71 insertions(+)
> > > > 
> > > > diff --git a/include/migration/register.h b/include/migration/register.h
> > > > index f60e797894e5..9de123252edf 100644
> > > > --- a/include/migration/register.h
> > > > +++ b/include/migration/register.h
> > > > @@ -103,6 +103,42 @@ typedef struct SaveVMHandlers {
> > > >         */
> > > >        int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
> > > > 
> > > > +    /**
> > > > +     * @save_live_complete_precopy_begin
> > > > +     *
> > > > +     * Called at the end of a precopy phase, before all
> > > > +     * @save_live_complete_precopy handlers and before launching
> > > > +     * all @save_live_complete_precopy_thread threads.
> > > > +     * The handler might, for example, mark the stream boundary before
> > > > +     * proceeding with asynchronous transmission of the remaining data via
> > > > +     * @save_live_complete_precopy_thread.
> > > > +     * When postcopy is enabled, devices that support postcopy will skip this step.
> > > > +     *
> > > > +     * @f: QEMUFile where the handler can synchronously send data before returning
> > > > +     * @idstr: this device section idstr
> > > > +     * @instance_id: this device section instance_id
> > > > +     * @opaque: data pointer passed to register_savevm_live()
> > > > +     *
> > > > +     * Returns zero to indicate success and negative for error
> > > > +     */
> > > > +    int (*save_live_complete_precopy_begin)(QEMUFile *f,
> > > > +                                            char *idstr, uint32_t instance_id,
> > > > +                                            void *opaque);
> > > > +    /**
> > > > +     * @save_live_complete_precopy_end
> > > > +     *
> > > > +     * Called at the end of a precopy phase, after @save_live_complete_precopy
> > > > +     * handlers and after all @save_live_complete_precopy_thread threads have
> > > > +     * finished. When postcopy is enabled, devices that support postcopy will
> > > > +     * skip this step.
> > > > +     *
> > > > +     * @f: QEMUFile where the handler can synchronously send data before returning
> > > > +     * @opaque: data pointer passed to register_savevm_live()
> > > > +     *
> > > > +     * Returns zero to indicate success and negative for error
> > > > +     */
> > > > +    int (*save_live_complete_precopy_end)(QEMUFile *f, void *opaque);
> > > 
> > > Is this handler necessary now that migration core is responsible for the
> > > threads and joins them? I don't see VFIO implementing it later on.
> > 
> > Right, I spot the same thing.
> > 
> > This series added three hooks: begin, end, precopy_thread.
> > 
> > What I think is it only needs one, which is precopy_async.  My vague memory
> > was that was what we used to discuss too, so that when migration precopy
> > flushes the final round of iterable data, it does:
> > 
> >    (1) loop over all complete_precopy_async() and enqueue the tasks if
> >        existed into the migration worker pool.  Then,
> > 
> >    (2) loop over all complete_precopy() like before.
> > 
> > Optionally, we can enforce one vmstate handler only provides either
> > complete_precopy_async() or complete_precopy().  In this case VFIO can
> > update the two hooks during setup() by detecting multifd && !mapped_ram &&
> > nocomp.
> > 
> 
> The "_begin" hook is still necessary to mark the end of the device state
> sent via the main migration stream (during the phase VM is still running)
> since we can't start loading the multifd sent device state until all of
> that earlier data finishes loading first.

Ah I remembered some more now, thanks.

If vfio can send data during iterations this new hook will also not be
needed, right?

I remember you mentioned you'd have a look and see the challenges there, is
there any conclusion yet on whether we can use multifd even during that?

It's also a pity that we introduce this hook only because we want a
boundary between "iterable stage" and "final stage".  IIUC if we have any
kind of message telling dest before hand that "we're going to the last
stage" then this hook can be avoided.  Now it's at least inefficient
because we need to trigger begin() per-device, even if I think it's more of
a global request saying that "we need to load all main stream data first
before moving on".

> 
> We shouldn't send that boundary marker in .save_live_complete_precopy
> either since it would meant unnecessary waiting for other devices
> (not necessary VFIO ones) .save_live_complete_precopy bulk data.
> 
> And VFIO SaveVMHandlers are shared for all VFIO devices (and const) so
> we can't really change them at runtime.

In all cases, please consider dropping end() if it's never used; IMO it's
fine if there is only begin(), and we shouldn't keep hooks that are never
used.

Thanks,

-- 
Peter Xu


