Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319D7ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 18:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snigI-0003rK-Iq; Mon, 09 Sep 2024 14:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snigG-0003jh-N4
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:00:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snigE-0000vw-J3
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725904800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YDdwWW6Jkk0Ed6C5UBpLGKTL2I5BSw0eBfiDuau65DU=;
 b=KHOph1YHa5A9QK54M0NeZky9XKz0jposwwYLRuYHzxt45nUvgzdD5DqDvEzciUvFa5CQ6D
 ysSJlZH3qxVSpZc/y/Lojpwo0IeqBp3LsPJPqkBQ11RXmhfQLh7Vt2Xob2tlrlA9Pl1Ycg
 eX/6WINcfHFeQSpsKfyMGhLqy3wNIFg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-7dTCrvfxMCGWM39-Xlsyog-1; Mon, 09 Sep 2024 13:59:56 -0400
X-MC-Unique: 7dTCrvfxMCGWM39-Xlsyog-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a99fdae7bbso468591685a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725904796; x=1726509596;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YDdwWW6Jkk0Ed6C5UBpLGKTL2I5BSw0eBfiDuau65DU=;
 b=rPM265G8hV3r3RvaWLhXs/FVu+7+5jXxnQ6yuf+uAt1z0L6+HhAb21sye/R5sKWiVA
 dSFsSwgaWeKmTjIZcL9mVBh9eZI+vJ5owazkXOJr5tzFCuHD7HM5zRZgqw/PPYaf7xm4
 YiTho6x7phym11maexU0/LPKYUGKYBA5ZKJp2EHino1ky6Ro0+/gQpMBUEHx3HYL8nuW
 t6NcmcTGkJ2JwWdm3AwpX2ceE3MSlBlqDsoDOMCd0KN9jvQaeP3/JdbqwSuxz3CcIOb0
 P391mD6wramHxJFGdadX2x+pwABBApRw8bGnxkOt0S7WXyliPL6tSmHDN9vphOGikkEx
 VBQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdcxo7EVxh8iJr6jNb3i+oM7NNjkrMp4orm9jex+KOq2ES+PoRdqBFX3z91eCJKkdZZ0W8eMHwMWiZ@nongnu.org
X-Gm-Message-State: AOJu0YwfTkvzLZ3syC+pPj+bjpmWeDZ6Jpny/1ZBelrc14r6rDEwnqDx
 yz2Su8jkKx5y9FPYwyp4BSXo2vKTMHHPL0a4k2p7zhNBCX4owwJhm6yMQRJpyxNZfgm4cH+7fX4
 iKQJ/mfZADuI/wI4yvLj6kA2BGipc+Iwmq+ycSCsaHgkUL54yelkI
X-Received: by 2002:a05:620a:3910:b0:7a5:27e:8814 with SMTP id
 af79cd13be357-7a99735e5afmr1444205685a.44.1725904796290; 
 Mon, 09 Sep 2024 10:59:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCmGOJRjHk1pXrskVbJFmyknudOXgHX6haiBC1zMDIHDsib7IGNUCOnpsH81v/8ARVw1BpcA==
X-Received: by 2002:a05:620a:3910:b0:7a5:27e:8814 with SMTP id
 af79cd13be357-7a99735e5afmr1444201885a.44.1725904795965; 
 Mon, 09 Sep 2024 10:59:55 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7969043sm237868685a.44.2024.09.09.10.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:59:55 -0700 (PDT)
Date: Mon, 9 Sep 2024 13:59:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 06/17] migration: Add
 save_live_complete_precopy_{begin,end} handlers
Message-ID: <Zt83mWWlMomX4mRD@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <afe0bc649007593edaa77f5f3923acb733a24c6a.1724701542.git.maciej.szmigiero@oracle.com>
 <9f9f0408-866d-4dc8-8c8e-80c3cfdd190a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f9f0408-866d-4dc8-8c8e-80c3cfdd190a@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 05, 2024 at 04:45:48PM +0300, Avihai Horon wrote:
> 
> On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > 
> > These SaveVMHandlers help device provide its own asynchronous
> > transmission of the remaining data at the end of a precopy phase.
> > 
> > In this use case the save_live_complete_precopy_begin handler might
> > be used to mark the stream boundary before proceeding with asynchronous
> > transmission of the remaining data while the
> > save_live_complete_precopy_end handler might be used to mark the
> > stream boundary after performing the asynchronous transmission.
> > 
> > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > ---
> >   include/migration/register.h | 36 ++++++++++++++++++++++++++++++++++++
> >   migration/savevm.c           | 35 +++++++++++++++++++++++++++++++++++
> >   2 files changed, 71 insertions(+)
> > 
> > diff --git a/include/migration/register.h b/include/migration/register.h
> > index f60e797894e5..9de123252edf 100644
> > --- a/include/migration/register.h
> > +++ b/include/migration/register.h
> > @@ -103,6 +103,42 @@ typedef struct SaveVMHandlers {
> >        */
> >       int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
> > 
> > +    /**
> > +     * @save_live_complete_precopy_begin
> > +     *
> > +     * Called at the end of a precopy phase, before all
> > +     * @save_live_complete_precopy handlers and before launching
> > +     * all @save_live_complete_precopy_thread threads.
> > +     * The handler might, for example, mark the stream boundary before
> > +     * proceeding with asynchronous transmission of the remaining data via
> > +     * @save_live_complete_precopy_thread.
> > +     * When postcopy is enabled, devices that support postcopy will skip this step.
> > +     *
> > +     * @f: QEMUFile where the handler can synchronously send data before returning
> > +     * @idstr: this device section idstr
> > +     * @instance_id: this device section instance_id
> > +     * @opaque: data pointer passed to register_savevm_live()
> > +     *
> > +     * Returns zero to indicate success and negative for error
> > +     */
> > +    int (*save_live_complete_precopy_begin)(QEMUFile *f,
> > +                                            char *idstr, uint32_t instance_id,
> > +                                            void *opaque);
> > +    /**
> > +     * @save_live_complete_precopy_end
> > +     *
> > +     * Called at the end of a precopy phase, after @save_live_complete_precopy
> > +     * handlers and after all @save_live_complete_precopy_thread threads have
> > +     * finished. When postcopy is enabled, devices that support postcopy will
> > +     * skip this step.
> > +     *
> > +     * @f: QEMUFile where the handler can synchronously send data before returning
> > +     * @opaque: data pointer passed to register_savevm_live()
> > +     *
> > +     * Returns zero to indicate success and negative for error
> > +     */
> > +    int (*save_live_complete_precopy_end)(QEMUFile *f, void *opaque);
> 
> Is this handler necessary now that migration core is responsible for the
> threads and joins them? I don't see VFIO implementing it later on.

Right, I spot the same thing.

This series added three hooks: begin, end, precopy_thread.

What I think is it only needs one, which is precopy_async.  My vague memory
was that was what we used to discuss too, so that when migration precopy
flushes the final round of iterable data, it does:

  (1) loop over all complete_precopy_async() and enqueue the tasks if
      existed into the migration worker pool.  Then,

  (2) loop over all complete_precopy() like before.

Optionally, we can enforce one vmstate handler only provides either
complete_precopy_async() or complete_precopy().  In this case VFIO can
update the two hooks during setup() by detecting multifd && !mapped_ram &&
nocomp.

-- 
Peter Xu


