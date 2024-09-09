Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6A2ECE587
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 19:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snk7y-0002qV-5Y; Mon, 09 Sep 2024 15:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snk7x-0002nQ-7b
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 15:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snk7v-0001Vk-BB
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 15:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725910362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q8B886or0Pd0rGDg/WH2ReE8wV0SFAgueRfA3OnYLVw=;
 b=FO4K/wmpxmPrSdJYdCZ5XM69RhI3qs5fRJpgEfonyDfn3dxvY6qn3eqcjPC5+F1+xQF4xl
 yXDd7jwkcyifxwgejNXgPhS0FJsvJYeXAMtQpxb2YPLujVJP15fPZAY566J5/sn6mm0jen
 3ooNa3vb+JrTwdi0jJ/90lKu5irlENs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-yZHLEiLAPumcsK-SnUeeBw-1; Mon, 09 Sep 2024 15:32:41 -0400
X-MC-Unique: yZHLEiLAPumcsK-SnUeeBw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6c3649bca89so59125266d6.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 12:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725910360; x=1726515160;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q8B886or0Pd0rGDg/WH2ReE8wV0SFAgueRfA3OnYLVw=;
 b=vVkZL3qLu5+wt9PdFjpljEeOqBz7M1Rjn/Z8Jt1DJC5mV8Ke7DaF/fnOP9GsrJjiy/
 EPw8YHmLd67Iv1XUwYHhocqXIh/gQlEB0UW5uPJ+Xp7rpZRj3a8MWXB4EvFeBpAFRVI0
 VGXdGJLp24xc7wkwwKg8EcmB+Q01ep7TaI9onnPkHLDZdBBt3lEM3Ko2yUhzrHnNZpPw
 01l5UOM/axvbszfbPchmYibEjVQ4NH/1NYvCiw4xaMZXcoY4wJuU/SLoDXmRmlMy33Yd
 b/BTw2d3m+7PKTRLj3AydN+WVVIzEKF0hXYJcm/3TkoqOEF/msuKVF0MN0X0fQTBj7dz
 jOuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYJD+La/oy7gmF7K07lZnar3ZhBf+aOgBbCxFUG0mhaPL++bXBLKKYQgtZXJ319hjx1SDg7C0WRnzv@nongnu.org
X-Gm-Message-State: AOJu0YzTr4TnIJIymC10tEJvXlKg0ST9rbGW/8Aio0xylbYlmI9VyYmP
 XMLJKImhPuwRi11NuRvT3cGyremyNO1hh4a/ukkoxYDFTSS0guQ8ofT3QbSj0XuBeGIX+q8gVJv
 79scvQB2IOrZYQVlFsBnIxj68X9wwXQ8fjwerKXS1QXSqMn9DvybB
X-Received: by 2002:a05:6214:3f8c:b0:6c3:5597:406d with SMTP id
 6a1803df08f44-6c5281b766dmr183018286d6.0.1725910360337; 
 Mon, 09 Sep 2024 12:32:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIC+CGyffClrDzXBeeL/aRTvXa82ukBIi2W5JE8YtUtJkP3yxPcDR9RPrxCzjlpo0VRxbi+Q==
X-Received: by 2002:a05:6214:3f8c:b0:6c3:5597:406d with SMTP id
 6a1803df08f44-6c5281b766dmr183017986d6.0.1725910359900; 
 Mon, 09 Sep 2024 12:32:39 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534329544sm23357966d6.22.2024.09.09.12.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 12:32:39 -0700 (PDT)
Date: Mon, 9 Sep 2024 15:32:37 -0400
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
Message-ID: <Zt9NVdcpFTsJPkt4@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <afe0bc649007593edaa77f5f3923acb733a24c6a.1724701542.git.maciej.szmigiero@oracle.com>
 <9f9f0408-866d-4dc8-8c8e-80c3cfdd190a@nvidia.com>
 <Zt83mWWlMomX4mRD@x1n>
 <fa64bf51-7fec-454b-b204-f92f5d06f731@maciej.szmigiero.name>
 <Zt9HuA3QtP0E93X1@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zt9HuA3QtP0E93X1@x1n>
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

On Mon, Sep 09, 2024 at 03:08:40PM -0400, Peter Xu wrote:
> On Mon, Sep 09, 2024 at 08:32:45PM +0200, Maciej S. Szmigiero wrote:
> > On 9.09.2024 19:59, Peter Xu wrote:
> > > On Thu, Sep 05, 2024 at 04:45:48PM +0300, Avihai Horon wrote:
> > > > 
> > > > On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
> > > > > External email: Use caution opening links or attachments
> > > > > 
> > > > > 
> > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > > 
> > > > > These SaveVMHandlers help device provide its own asynchronous
> > > > > transmission of the remaining data at the end of a precopy phase.
> > > > > 
> > > > > In this use case the save_live_complete_precopy_begin handler might
> > > > > be used to mark the stream boundary before proceeding with asynchronous
> > > > > transmission of the remaining data while the
> > > > > save_live_complete_precopy_end handler might be used to mark the
> > > > > stream boundary after performing the asynchronous transmission.
> > > > > 
> > > > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > > > ---
> > > > >    include/migration/register.h | 36 ++++++++++++++++++++++++++++++++++++
> > > > >    migration/savevm.c           | 35 +++++++++++++++++++++++++++++++++++
> > > > >    2 files changed, 71 insertions(+)
> > > > > 
> > > > > diff --git a/include/migration/register.h b/include/migration/register.h
> > > > > index f60e797894e5..9de123252edf 100644
> > > > > --- a/include/migration/register.h
> > > > > +++ b/include/migration/register.h
> > > > > @@ -103,6 +103,42 @@ typedef struct SaveVMHandlers {
> > > > >         */
> > > > >        int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
> > > > > 
> > > > > +    /**
> > > > > +     * @save_live_complete_precopy_begin
> > > > > +     *
> > > > > +     * Called at the end of a precopy phase, before all
> > > > > +     * @save_live_complete_precopy handlers and before launching
> > > > > +     * all @save_live_complete_precopy_thread threads.
> > > > > +     * The handler might, for example, mark the stream boundary before
> > > > > +     * proceeding with asynchronous transmission of the remaining data via
> > > > > +     * @save_live_complete_precopy_thread.
> > > > > +     * When postcopy is enabled, devices that support postcopy will skip this step.
> > > > > +     *
> > > > > +     * @f: QEMUFile where the handler can synchronously send data before returning
> > > > > +     * @idstr: this device section idstr
> > > > > +     * @instance_id: this device section instance_id
> > > > > +     * @opaque: data pointer passed to register_savevm_live()
> > > > > +     *
> > > > > +     * Returns zero to indicate success and negative for error
> > > > > +     */
> > > > > +    int (*save_live_complete_precopy_begin)(QEMUFile *f,
> > > > > +                                            char *idstr, uint32_t instance_id,
> > > > > +                                            void *opaque);
> > > > > +    /**
> > > > > +     * @save_live_complete_precopy_end
> > > > > +     *
> > > > > +     * Called at the end of a precopy phase, after @save_live_complete_precopy
> > > > > +     * handlers and after all @save_live_complete_precopy_thread threads have
> > > > > +     * finished. When postcopy is enabled, devices that support postcopy will
> > > > > +     * skip this step.
> > > > > +     *
> > > > > +     * @f: QEMUFile where the handler can synchronously send data before returning
> > > > > +     * @opaque: data pointer passed to register_savevm_live()
> > > > > +     *
> > > > > +     * Returns zero to indicate success and negative for error
> > > > > +     */
> > > > > +    int (*save_live_complete_precopy_end)(QEMUFile *f, void *opaque);
> > > > 
> > > > Is this handler necessary now that migration core is responsible for the
> > > > threads and joins them? I don't see VFIO implementing it later on.
> > > 
> > > Right, I spot the same thing.
> > > 
> > > This series added three hooks: begin, end, precopy_thread.
> > > 
> > > What I think is it only needs one, which is precopy_async.  My vague memory
> > > was that was what we used to discuss too, so that when migration precopy
> > > flushes the final round of iterable data, it does:
> > > 
> > >    (1) loop over all complete_precopy_async() and enqueue the tasks if
> > >        existed into the migration worker pool.  Then,
> > > 
> > >    (2) loop over all complete_precopy() like before.
> > > 
> > > Optionally, we can enforce one vmstate handler only provides either
> > > complete_precopy_async() or complete_precopy().  In this case VFIO can
> > > update the two hooks during setup() by detecting multifd && !mapped_ram &&
> > > nocomp.
> > > 
> > 
> > The "_begin" hook is still necessary to mark the end of the device state
> > sent via the main migration stream (during the phase VM is still running)
> > since we can't start loading the multifd sent device state until all of
> > that earlier data finishes loading first.
> 
> Ah I remembered some more now, thanks.
> 
> If vfio can send data during iterations this new hook will also not be
> needed, right?
> 
> I remember you mentioned you'd have a look and see the challenges there, is
> there any conclusion yet on whether we can use multifd even during that?
> 
> It's also a pity that we introduce this hook only because we want a
> boundary between "iterable stage" and "final stage".  IIUC if we have any
> kind of message telling dest before hand that "we're going to the last
> stage" then this hook can be avoided.  Now it's at least inefficient
> because we need to trigger begin() per-device, even if I think it's more of
> a global request saying that "we need to load all main stream data first
> before moving on".

Or, we could add one MIG_CMD_SWITCHOVER under QEMU_VM_COMMAND, then send it
at the beginning of the switchover phase.  Then we can have a generic
marker on destination to be the boundary of "iterations" v.s. "switchover".
Then I think we can also drop the begin() here, just to avoid one such sync
per-device (also in case if others may have such need, like vdpa, then vdpa
doesn't need that flag too).

Fundamentally, that makes the VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE to be a
migration flag..

But for sure the best is still if VFIO can enable multifd even during
iterations.  Then the boundary guard may not be needed.

> 
> > 
> > We shouldn't send that boundary marker in .save_live_complete_precopy
> > either since it would meant unnecessary waiting for other devices
> > (not necessary VFIO ones) .save_live_complete_precopy bulk data.
> > 
> > And VFIO SaveVMHandlers are shared for all VFIO devices (and const) so
> > we can't really change them at runtime.
> 
> In all cases, please consider dropping end() if it's never used; IMO it's
> fine if there is only begin(), and we shouldn't keep hooks that are never
> used.
> 
> Thanks,
> 
> -- 
> Peter Xu

-- 
Peter Xu


