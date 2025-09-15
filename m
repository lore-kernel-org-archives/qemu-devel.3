Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEDACAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 16:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyCBr-0007q3-PP; Mon, 15 Sep 2025 12:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyCBl-0007iO-L9
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyCBV-0007wc-Is
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757954162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iohf8iTJbn33RjXzhmzZzE6csKhHQLJ/YlpJGiANklA=;
 b=YmhAMgM1yI+V6Izz1sAJbCk42Teyrxawx4VkgUZhyp4MO85kc3uvw5HJyOgLepuzXmH7gC
 gD2UdnmqSU2V9soSJk5dTFGyFrb84tReUg2QjogPmxi5s9rKbeoKU2NszAlvPMTargIJVa
 4kNy/BzgfeyA5RHs+5zTbEtVPEjgRjI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-w4BvggvlOfmBBdcl2V2wUA-1; Mon, 15 Sep 2025 12:36:00 -0400
X-MC-Unique: w4BvggvlOfmBBdcl2V2wUA-1
X-Mimecast-MFC-AGG-ID: w4BvggvlOfmBBdcl2V2wUA_1757954160
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b548745115so112208211cf.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 09:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757954160; x=1758558960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iohf8iTJbn33RjXzhmzZzE6csKhHQLJ/YlpJGiANklA=;
 b=gFDYCuPx5GTuTR/IIuP/iYAd9efSetjXIw/HCozAPkd5EfkZ2cCTwqzRrPxBEHr6/p
 d3m5EYyDBH4yQQ4/25HPZcft30Ot3oIpeEwLFkaHzV81IOSY4wmgVreepeVC9BZt+ORP
 q64uBtUkDqdSelG4lCi5puNmxoC6Tm7b6Su8YeY/irS2D6SBRt/iRyi/wYSNLfC52CRL
 giwaWwtNfAWpj3xODb0rDUz3tkbXbU+uIDGTFvCyOp67pEOHBc6a7Ha7My4y+USWdbds
 7hSj3EujNdtv9kN9hZBIU+BM3oh6O4/eoPIghFRmWXEaxsGcfHPOvZ9Et7z1DmvCTMwc
 u59Q==
X-Gm-Message-State: AOJu0YynUgR1mEjbvCMApFw4fCAzzECaBF+2I8Z7AKoPlnB+SrIDNI2U
 R0X/8un3V2PH54bJaO/uKZPPD94+2EUGps/nbsbpAIptFg5rSbfyQMA4NAnzLQ0eQWuZEvbX59A
 bbfZwbf+hirqI6ayk0NKMeSGPJvm9TrQg7vuYXSR5/hMRUX7ULwVndU2E
X-Gm-Gg: ASbGncuh+iLfHsNiQp0ynNxe1a7jEO/3sAvC/c0MVjd1o53qnFFAOTr7moran6UVP1g
 uRcWuqc2VGDtuxspy+K7t+rYRBJhE2zPWmtln3UflFF40W+oX+ItC95OLSNMjAFSyurIgwZVGls
 LGPhr3gZ3e5GDBEsaLyvwPyqbnA7i+WXtusds/F3NK5dasR3nVOuIR8g1nZlQvF5KM+f/YFLk1U
 Y1Ai2dXVImrtS8d6x5XZcyOy0qRMXDUqm0JtmLopGu9ogbNfh7qn/9MbXwQYeZX0ITZttA5IqOv
 QuCgwJ2dN5Vu/g8BQ4XchRaf/h6qAlRX
X-Received: by 2002:a05:622a:1347:b0:4b4:7b34:1dc4 with SMTP id
 d75a77b69052e-4b77cbbe4a1mr162873861cf.13.1757954159542; 
 Mon, 15 Sep 2025 09:35:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpnROrVIFBCKjJx5p3ucbdESi5suyNS88EJIAmJWWslilkAnI8VyMTix9MN+McuMqprx2tnQ==
X-Received: by 2002:a05:622a:1347:b0:4b4:7b34:1dc4 with SMTP id
 d75a77b69052e-4b77cbbe4a1mr162873161cf.13.1757954158851; 
 Mon, 15 Sep 2025 09:35:58 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b639dab102sm68845051cf.33.2025.09.15.09.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 09:35:58 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:35:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH V3 4/9] vl: helper to request exec
Message-ID: <aMhAYkVgf73gjxVZ@x1.local>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-5-git-send-email-steven.sistare@oracle.com>
 <aMBNCUXuMzxUToff@x1.local>
 <28bf9c97-1e69-4121-a4aa-2d2bf5ac50bb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28bf9c97-1e69-4121-a4aa-2d2bf5ac50bb@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Sep 12, 2025 at 10:49:23AM -0400, Steven Sistare wrote:
> On 9/9/2025 11:51 AM, Peter Xu wrote:
> > On Thu, Aug 14, 2025 at 10:17:18AM -0700, Steve Sistare wrote:
> > > Add a qemu_system_exec_request() hook that causes the main loop to exit and
> > > exec a command using the specified arguments.  This will be used during CPR
> > > to exec a new version of QEMU.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > ---
> > >   include/system/runstate.h |  3 +++
> > >   system/runstate.c         | 29 +++++++++++++++++++++++++++++
> > >   2 files changed, 32 insertions(+)
> > > 
> > > diff --git a/include/system/runstate.h b/include/system/runstate.h
> > > index 929379a..c005f49 100644
> > > --- a/include/system/runstate.h
> > > +++ b/include/system/runstate.h
> > > @@ -128,6 +128,8 @@ typedef enum WakeupReason {
> > >       QEMU_WAKEUP_REASON_OTHER,
> > >   } WakeupReason;
> > > +typedef void (*qemu_exec_func)(char **exec_argv);
> > > +
> > >   void qemu_system_reset_request(ShutdownCause reason);
> > >   void qemu_system_suspend_request(void);
> > >   void qemu_register_suspend_notifier(Notifier *notifier);
> > > @@ -139,6 +141,7 @@ void qemu_register_wakeup_support(void);
> > >   void qemu_system_shutdown_request_with_code(ShutdownCause reason,
> > >                                               int exit_code);
> > >   void qemu_system_shutdown_request(ShutdownCause reason);
> > > +void qemu_system_exec_request(qemu_exec_func func, const strList *args);
> > >   void qemu_system_powerdown_request(void);
> > >   void qemu_register_powerdown_notifier(Notifier *notifier);
> > >   void qemu_register_shutdown_notifier(Notifier *notifier);
> > > diff --git a/system/runstate.c b/system/runstate.c
> > > index 6178b00..b4980ff 100644
> > > --- a/system/runstate.c
> > > +++ b/system/runstate.c
> > > @@ -41,6 +41,7 @@
> > >   #include "qapi/error.h"
> > >   #include "qapi/qapi-commands-run-state.h"
> > >   #include "qapi/qapi-events-run-state.h"
> > > +#include "qapi/type-helpers.h"
> > >   #include "qemu/accel.h"
> > >   #include "qemu/error-report.h"
> > >   #include "qemu/job.h"
> > > @@ -422,6 +423,8 @@ static NotifierList wakeup_notifiers =
> > >   static NotifierList shutdown_notifiers =
> > >       NOTIFIER_LIST_INITIALIZER(shutdown_notifiers);
> > >   static uint32_t wakeup_reason_mask = ~(1 << QEMU_WAKEUP_REASON_NONE);
> > > +qemu_exec_func exec_func;
> > > +static char **exec_argv;
> > >   ShutdownCause qemu_shutdown_requested_get(void)
> > >   {
> > > @@ -443,6 +446,11 @@ static int qemu_shutdown_requested(void)
> > >       return qatomic_xchg(&shutdown_requested, SHUTDOWN_CAUSE_NONE);
> > >   }
> > > +static int qemu_exec_requested(void)
> > > +{
> > > +    return exec_argv != NULL;
> > > +}
> > > +
> > >   static void qemu_kill_report(void)
> > >   {
> > >       if (!qtest_driver() && shutdown_signal) {
> > > @@ -803,6 +811,23 @@ void qemu_system_shutdown_request(ShutdownCause reason)
> > >       qemu_notify_event();
> > >   }
> > > +static void qemu_system_exec(void)
> > > +{
> > > +    exec_func(exec_argv);
> > > +
> > > +    /* exec failed */
> > > +    g_strfreev(exec_argv);
> > > +    exec_argv = NULL;
> > > +    exec_func = NULL;
> > 
> > Would this really happen?
> > 
> > If so, do we at least want to dump something?
> > 
> > > +}
> > > +
> > > +void qemu_system_exec_request(qemu_exec_func func, const strList *args)
> > > +{
> > > +    exec_func = func;
> > > +    exec_argv = strv_from_str_list(args);
> > > +    qemu_notify_event();
> > > +}
> > > +
> > >   static void qemu_system_powerdown(void)
> > >   {
> > >       qapi_event_send_powerdown();
> > > @@ -849,6 +874,10 @@ static bool main_loop_should_exit(int *status)
> > >       if (qemu_suspend_requested()) {
> > >           qemu_system_suspend();
> > >       }
> > > +    if (qemu_exec_requested()) {
> > > +        qemu_system_exec();
> > > +        return false;
> > > +    }
> > 
> > Some explanation of why it needs to be done explicitly here would be
> > helpful.  E.g., can we do exec inside a BH scheduled for the main thread?
> > What if we exec() directly in another thread (rather than the main loop
> > thread)?
> 
> A BH is a good idea, thanks.
> It only requires a few lines of code, and no globals.
> I will drop this patch and add a BH to patch "migration: cpr-exec mode".

That would be better, thanks.

Then, what happens if we exec() in the migration thread directly?  IOW, is
BH required (to serialize with something happening in the main thread), or
just looks slightly more clean when exec happens in the main thread?

These info would be great to be put into commit message, but if there's no
obvious reason, IMHO we _could_ exec() directly in the migration thread, as
I don't see whatever to be synchronized in the main thread..  Anyway, if we
want to exec(), IMHO it would be best as straightforward as possible.

Thanks,

-- 
Peter Xu


