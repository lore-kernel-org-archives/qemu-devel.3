Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A57FCA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 14:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux5EX-0005iA-OC; Fri, 12 Sep 2025 10:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux5ER-0005gU-NE
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux5EH-0000n9-GW
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757689103;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxnHq32iTWiKyW/p0FMFzJESuFiCrIMha0E7oRayqC4=;
 b=JdNAS7MTeuMYHwTpWa4izrz5EgdTrVKKjWQoj5dEKgN1dWE3H7NX/o/RyayQ74QqW97Bfi
 osEzCdkFXlGaQ/F3dSDd/SHdHDj3tHMt+mM4jMPiuuJMgNcD05B/Hp3Z5j4z+aaBlwneUk
 to0JTq4V4yzUJLnUMNpTi1FDwcMIqk8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-Rm9TEjhjOX2uSjOT9LXnHw-1; Fri,
 12 Sep 2025 10:58:20 -0400
X-MC-Unique: Rm9TEjhjOX2uSjOT9LXnHw-1
X-Mimecast-MFC-AGG-ID: Rm9TEjhjOX2uSjOT9LXnHw_1757689098
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 902FA1955DB6; Fri, 12 Sep 2025 14:58:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B60D318004D8; Fri, 12 Sep 2025 14:58:13 +0000 (UTC)
Date: Fri, 12 Sep 2025 15:58:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 05/20] audio: make jackaudio use qemu_thread_set_name
Message-ID: <aMQ1AYfJhxD26GPb@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-6-berrange@redhat.com>
 <10718921.crInZIivIp@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10718921.crInZIivIp@silver>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 11, 2025 at 03:21:04PM +0200, Christian Schoenebeck wrote:
> On Wednesday, September 10, 2025 8:03:42 PM CEST Daniel P. Berrangé wrote:
> > This has greater portability than directly call pthread_setname_np,
> > which is only 1 out of 3 possible functions for pthreads that can
> > set the name.
> > 
> > The new API requires a trampoline function, since it can only set
> > the name of the current thread.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  audio/jackaudio.c | 30 ++++++++++++++++++++++++------
> >  1 file changed, 24 insertions(+), 6 deletions(-)
> > 
> > diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> > index 974a3caad3..69dce3f302 100644
> > --- a/audio/jackaudio.c
> > +++ b/audio/jackaudio.c
> > @@ -629,18 +629,36 @@ static void qjack_enable_in(HWVoiceIn *hw, bool
> > enable) ji->c.enabled = enable;
> >  }
> > 
> > -#if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
> > +#if !defined(WIN32)
> > +struct QJackThreadData {
> > +    void *(*function)(void *);
> > +    void *arg;
> > +};
> > +
> > +static void *qjack_thread_trampoline(void *targ)
> > +{
> > +    struct QJackThreadData *data = targ;
> > +    void *(*function)(void *) = data->function;
> > +    void *arg = data->arg;
> > +
> > +    g_free(data);
> > +    qemu_thread_set_name("jack-client");
> > +
> > +    return function(arg);
> > +}
> > +
> >  static int qjack_thread_creator(jack_native_thread_t *thread,
> >      const pthread_attr_t *attr, void *(*function)(void *), void *arg)
> >  {
> > -    int ret = pthread_create(thread, attr, function, arg);
> > +    struct QJackThreadData *data = g_new0(struct QJackThreadData, 1);
> > +    data->function = function;
> > +    data->arg = arg;
> > +    int ret = pthread_create(thread, attr, qjack_thread_trampoline, data);
> >      if (ret != 0) {
> > +        g_free(data);
> >          return ret;
> >      }
> > 
> > -    /* set the name of the thread */
> > -    pthread_setname_np(*thread, "jack-client");
> > -
> >      return ret;
> >  }
> >  #endif
> > @@ -696,7 +714,7 @@ static void register_audio_jack(void)
> >  {
> >      qemu_mutex_init(&qjack_shutdown_lock);
> >      audio_driver_register(&jack_driver);
> > -#if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
> > +#if !defined(WIN32)
> >      jack_set_thread_creator(qjack_thread_creator);
> >  #endif
> >      jack_set_error_function(qjack_error);
> 
> Well, it does what you said, so:
> 
> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> 
> I just wonder whether this thread naming code couldn't be much more simplified
> now by dropping jack_set_thread_creator() entirely, which is very seldomly
> used at all and had another user case [1]:
> 
> "This function can be used in very very specialized cases where it is
> necessary that client threads created by JACK are created by something other
> than pthread_create(). After it is used, any threads that JACK needs for the
> client will will be created by calling the function passed to this function.
> 
> No normal application/client should consider calling this. The specific case
> for which it was created involves running win32/x86 plugins under Wine on
> Linux, where it is necessary that all threads that might call win32 functions
> are known to Wine."
> 
> [1] https://jackaudio.org/api/group__ClientThreads.html#ga157ab0ade60e266ffd26ddffdb5545af
> 
> However there doesn't seem to be a thread creation callback in the JACK API,
> so the jack_set_thread_creator() bypass is still the best we can get, right?

From QEMU's POV the only value we get from using the thread callback
is that we can set the thread name so the jack thrread can be easily
identified when debugging.  I don't think there's another easy way
to get that set, as we can't portability set thread names from outside
the thread.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


